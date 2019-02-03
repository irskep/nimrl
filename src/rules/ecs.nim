import options

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
  result = VigECS(
    actorSystem: newActorSystem(),
    itemSystem: newItemSystem(),
    spatialSystem: newSpatialSystem())

  let charE = newEntity()
  result.actorSystem[charE] = newActorComponent(henchman, standPassive)
  echo(result.actorSystem[charE].get().actorKind)