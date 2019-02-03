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

proc drawWorld*(ecs: VigECS, assetStore: AssetStore, camera: Camera2D) =
  camera.draw proc(): void =
    for layer, grid in ecs.spatialSystem.tilemap.cells:
      for y, row in grid:
        for x, entities in row:
          for entity in entities:
            let maybeActorC = ecs.actorSystem[entity]

            if maybeActorC.isSome:
              let actorC = maybeActorC.get()
              assetStore.drawAsset(
                assetStore.getImageAsset(actorC.actorKind, actorC.state),
                ecs.getPosition(assetStore, (x, y)))