import ecs_base
import actor_states

type
  TileComponent* = ref object of Component
    tile*: EnvironmentTile
  TileSystem* = ref object of System[TileComponent]

proc newTileSystem*(): TileSystem = TileSystem()

proc newTileComponent*(tile: EnvironmentTile): TileComponent =
  return TileComponent(tile: tile)