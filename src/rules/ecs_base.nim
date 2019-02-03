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

proc `[]=`*[T: Component](system: System[T], entity: Entity, component: T) =
  component.entity = entity
  system.values[$entity] = component

proc `[]`*[T](system: System[T], entity: Entity): Option[T] =
  if system.values.contains($entity):
    return some(system.values[$entity])
  else:
    return none(T)

proc unset*[T: Component](system: System[T], entity: Entity) =
  system.values[$entity] = nil

iterator items*[T](system: System[T]): T =
  for val in system.values:
    yield val
