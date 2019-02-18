import options

import ../util

import actor_states
import ecs_base
import ecs_actor
import ecs_item
import ecs_spatial
import ecs_tile
import actor_state_transitions
import tilemap

type
  VigECS* = ref object of RootObj
    actorSystem*: ActorSystem
    itemSystem*: ItemSystem
    spatialSystem*: SpatialSystem
    tileSystem*: TileSystem

### API ###

proc setTile*(ecs: VigECS, point: IntPoint, tile: EnvironmentTile): Entity =
  if ecs.spatialSystem.tilemap.entities(0, point).len == 0:
    result = newEntity()
    ecs.spatialSystem.add(result, 0, point)
    ecs.tileSystem[result] = newTileComponent(tile)
  else:
    result = ecs.spatialSystem.tilemap.entities(0, point)[0]
    ecs.tileSystem[result].get().tile = tile
    ecs.spatialSystem.move(result, 0, point)

proc isPossible*(
    ecs: VigECS,
    ast: ActorStateTransition,
    point: IntPoint,
    entity: Entity,
    positionDelta: IntPoint): bool =
  let actorC = ecs.actorSystem[entity].get()
  ast.isPossible(
    ecs.actorSystem,
    ecs.itemSystem,
    ecs.spatialSystem,
    ecs.tileSystem,
    point,
    entity,
    actorC,
    positionDelta)

proc apply*(
    ecs: VigECS,
    ast: ActorStateTransition,
    point: IntPoint,
    entity: Entity,
    positionDelta: IntPoint) =
  let actorC = ecs.actorSystem[entity].get()
  ast.apply(
    ecs.actorSystem,
    ecs.itemSystem,
    ecs.spatialSystem,
    ecs.tileSystem,
    point,
    entity,
    actorC,
    positionDelta)

### CREATE THINGS ###

proc addHenchman*(ecs: VigECS, point: IntPoint): Entity =
  let charE = newEntity()
  ecs.actorSystem[charE] = newActorComponent(henchman, standPassive, up)
  assert(ecs.actorSystem[charE].get().entity == charE)

  ecs.spatialSystem.add(charE, 2, point)

proc addVigilante*(ecs: VigECS, point: IntPoint): Entity =
  let charE = newEntity()
  ecs.actorSystem[charE] = newActorComponent(vigilante, standPassive, up)
  assert(ecs.actorSystem[charE].get().entity == charE)

  ecs.spatialSystem.add(charE, 2, point)

proc populateTilemap(ecs: VigECS) =
  for y in 0..<ecs.spatialSystem.tilemap.height:
    for x in 0..<ecs.spatialSystem.tilemap.width:
      let isXWall = x == 0 or x == ecs.spatialSystem.tilemap.width - 1
      let isYWall = y == 0 or y == ecs.spatialSystem.tilemap.height - 1
      if isXWall or isYWall:
        discard ecs.setTile((x, y), wall)
      else:
        discard ecs.setTile((x, y), floor)
  # echo(ecs.spatialSystem.tilemap.cells[0])

### INITS ###

proc newVigECSForStateDebugScene*(): VigECS =
  result = VigECS(
    actorSystem: newActorSystem(),
    itemSystem: newItemSystem(),
    spatialSystem: newSpatialSystem((5, 5)),
    tileSystem: newTileSystem())
  result.populateTilemap()
  # discard result.addHenchman((2, 2))
  discard result.addVigilante((2, 2))

export ecs_base
export ecs_actor
export ecs_item
export ecs_spatial
export ecs_tile
export actor_states