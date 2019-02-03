import ecs_base
import ecs_actor
import ecs_item
import ecs_spatial
import combat_states

type
  VigECS = ref object of RootObj
    actorSystem: ActorSystem
    itemSystem: ItemSystem
    spatialSystem: SpatialSystem

proc newVigECSForStateDebugScene*(): VigECS =
  let ecs = VigECS(
    actorSystem: newActorSystem(),
    itemSystem: newItemSystem(),
    spatialSystem: newSpatialSystem())

  let charE = newEntity()
  ecs.actorSystem.set(charE, newActorComponent(henchman, standPassive))
  # This is what I want to get working. ActorSystem.get should return an
  # ActorComponent without additional casting, so I can just pull properties
  # off it directly.
  echo(ecs.actorSystem.get(charE).actorKind)

  return ecs