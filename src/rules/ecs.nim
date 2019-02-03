import options

import ../util

import combat_states
import ecs_base
import ecs_actor
import ecs_item
import ecs_spatial
import ecs_tile
import tilemap

type
  VigECS* = ref object of RootObj
    actorSystem*: ActorSystem
    itemSystem*: ItemSystem
    spatialSystem*: SpatialSystem
    tileSystem*: TileSystem

proc addHenchman(ecs: VigECS, point: IntPoint): Entity =
  let charE = newEntity()
  ecs.actorSystem[charE] = newActorComponent(henchman, standPassive)
  assert(ecs.actorSystem[charE].get().entity == charE)

  ecs.itemSystem[charE] = newItemComponent()

  ecs.spatialSystem.add(charE, 2, point)

proc setTile*(ecs: VigECS, point: IntPoint, tile: EnvironmentTile): Entity =
  if ecs.spatialSystem.tilemap.entities(0, point).len == 0:
    result = newEntity()
    ecs.tileSystem[result] = newTileComponent(tile)
  else:
    result = ecs.spatialSystem.tilemap.entities(0, point)[0]
    ecs.tileSystem[result].get().tile = tile

proc populateTilemap(ecs: VigECS) =
  for y in 0..<ecs.spatialSystem.tilemap.height:
    for x in 0..<ecs.spatialSystem.tilemap.width:
      let isXWall = x == 0 or x == ecs.spatialSystem.tilemap.width - 1
      let isYWall = y == 0 or y == ecs.spatialSystem.tilemap.height - 1
      if isXWall or isYWall:
        discard ecs.setTile((x, y), wall)
      else:
        discard ecs.setTile((x, y), floor)

proc newVigECSForStateDebugScene*(): VigECS =
  result = VigECS(
    actorSystem: newActorSystem(),
    itemSystem: newItemSystem(),
    spatialSystem: newSpatialSystem((5, 5)),
    tileSystem: newTileSystem())
  result.populateTilemap()
  discard result.addHenchman((1, 1))

export ecs_base
export ecs_actor
export ecs_item
export ecs_spatial
export ecs_tile
export combat_states