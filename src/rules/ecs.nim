import options

import ecs_base
import ecs_actor
import ecs_item
import ecs_spatial
import combat_states

type
  VigECS* = ref object of RootObj
    actorSystem*: ActorSystem
    itemSystem*: ItemSystem
    spatialSystem*: SpatialSystem

proc addHenchman(ecs: VigECS): Entity =
  let charE = newEntity()
  ecs.actorSystem[charE] = newActorComponent(henchman, standPassive)
  assert(ecs.actorSystem[charE].get().entity == charE)

  ecs.itemSystem[charE] = newItemComponent()

  ecs.spatialSystem[charE] = newSpatialComponent((0, 0))

proc newVigECSForStateDebugScene*(): VigECS =
  result = VigECS(
    actorSystem: newActorSystem(),
    itemSystem: newItemSystem(),
    spatialSystem: newSpatialSystem())
  discard result.addHenchman()

export ecs_base
export ecs_actor
export ecs_item
export ecs_spatial
export combat_states