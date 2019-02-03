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