import ecs_base
import ../util

type
  SpatialComponent* = ref object of Component
    point*: IntPoint
  SpatialSystem* = ref object of System[SpatialComponent]

proc newSpatialSystem*(): SpatialSystem = SpatialSystem()
proc newSpatialComponent*(point: IntPoint): SpatialComponent =
  result = SpatialComponent(point: point)