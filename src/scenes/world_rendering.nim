import options

import raynim

import ../assets/asset_store
import ../rules/combat_states
import ../rules/ecs
import ../util

proc getPosition*(ecs: VigECS, assetStore: AssetStore, point: IntPoint): Vector2 =
  result.x = cfloat(point.x) * assetStore.tileSizeZoomed
  result.y = cfloat(point.y) * assetStore.tileSizeZoomed

proc getPosition*(ecs: VigECS, assetStore: AssetStore, entity: Entity): Vector2 =
  let c = ecs.spatialSystem[entity].get()
  return ecs.getPosition(assetStore, c.point)

proc maybeDrawTile(ecs: VigECS, assetStore: AssetStore, entity: Entity, point: IntPoint) =
  let maybeTileC = ecs.tileSystem[entity]
  if maybeTileC.isNone: return
  let tileC = maybeTileC.get()
  assetStore.drawAsset(
    assetStore.getTileImageAsset(tileC.tile),
    ecs.getPosition(assetStore, point))

proc maybeDrawActor(ecs: VigECS, assetStore: AssetStore, entity: Entity, point: IntPoint) =
  let maybeActorC = ecs.actorSystem[entity]
  if maybeActorC.isNone: return
  let actorC = maybeActorC.get()
  assetStore.drawAsset(
    assetStore.getActorImageAsset(actorC.actorKind, actorC.state),
    ecs.getPosition(assetStore, point))

proc drawWorld*(ecs: VigECS, assetStore: AssetStore, camera: Camera2D) =
  camera.draw proc(): void =
    # layer 0: environment
    for y, row in ecs.spatialSystem.tilemap.cells[0]:
      for x, entities in row:
        for entity in entities:
          maybeDrawTile(ecs, assetStore, entity, (x, y))

    # layer 1: items

    # layer 2: actors
    for y, row in ecs.spatialSystem.tilemap.cells[2]:
      for x, entities in row:
        for entity in entities:
          maybeDrawActor(ecs, assetStore, entity, (x, y))