import critbits
import options

type
  Entity* = int
  Component* = ref object of RootObj
    entity*: Entity

var nextEntity = 0
proc newEntity*(): Entity =
  nextEntity += 1
  return nextEntity

type
  System*[T] = ref object of RootObj
    values*: CritBitTree[T]

proc newSystem*[T](): System[T] =
  return System[T]()

proc set*[T](system: System[T], entity: Entity, component: T) =

  system.values[$entity] = component

proc get*[T](system: System[T], entity: Entity): Option[T] =
  if system.values.contains($entity):
    return some(system.values[$entity])
  else:
    return none(T)

iterator all*[T](system: System[T]): T =
  for val in system.values:
    yield val
