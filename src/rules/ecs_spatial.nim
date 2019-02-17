import options

import ../util

import ecs_base
import tilemap

type
  SpatialComponent* = ref object of Component
    layer: int
    point*: IntPoint

  SpatialSystem* = ref object of System[SpatialComponent]
    tilemap*: Tilemap

### COMPONENT ###

proc newSpatialComponent*(point: IntPoint): SpatialComponent =
  result = SpatialComponent(point: point)

### SYSTEM ###
  
proc newSpatialSystem*(size: IntPoint): SpatialSystem =
  result = SpatialSystem(tilemap: newTilemap(3, size.x, size.y))

proc add*(spatialSystem: SpatialSystem, entity: Entity, layer: int, point: IntPoint) =
  spatialSystem[entity] = newSpatialComponent(point) 
  spatialSystem.tilemap.add(entity, layer, point)

proc move*(spatialSystem: SpatialSystem, entity: Entity, layer: int, point: IntPoint) =
  let c = spatialSystem[entity].get()
  spatialSystem.tilemap.remove(entity, c.layer, c.point)
  c.layer = layer
  c.point = point
  spatialSystem.tilemap.add(entity, layer, point)

proc move*(spatialSystem: SpatialSystem, entity: Entity, point: IntPoint) =
  let c = spatialSystem[entity].get()
  let layer = spatialSystem.tilemap.findLayer(entity, c.point)
  spatialSystem.tilemap.remove(entity, c.layer, c.point)
  c.layer = layer
  c.point = point
  spatialSystem.tilemap.add(entity, layer, point)

proc isInBounds*(spatialSystem: SpatialSystem, point: IntPoint): bool =
  result = spatialSystem.tilemap.isInBounds(point)

proc find*(spatialSystem: SpatialSystem, layer: int, point: IntPoint): Option[Entity] =
  let tilemap = spatialSystem.tilemap

  if point.x < 0 or point.y < 0 or point.x >= tilemap.width or point.y >= tilemap.height:
    result = none(Entity)

  let entities = tilemap.entities(layer, point)

  if entities.len == 0:
    result = none(Entity)
  elif entities.len == 1:
    result = some(entities[0])
  else:
    assert(false, "Too many entities at " & $point)
    result = some(entities[0])