import os

import raynim

import ../rules/combat_states
import ../util

import spritemaps

type
  ImageAsset* = tuple[texture: Texture2D, location: IntPoint]
  AssetStore* = ref object of RootObj
    actorsTexture*: Texture2D
    tilesTexture*: Texture2D
    zoom*: cfloat

### HELPERS ###

proc loadTexture(assetStore: AssetStore, name: string): Texture2D =
  let image = LoadImage("art" & DirSep & name & ".png")
  let imageSizeSource: cfloat = 128
  ImageResizeNN(
    unsafeAddr image,
    cint(imageSizeSource * assetStore.zoom),
    cint(imageSizeSource * assetStore.zoom))
  result = LoadTextureFromImage(image)
  UnloadImage(image)

### PUBLIC ###

proc tileSizeSource*(assetStore: AssetStore): cfloat = 16

proc tileSizeZoomed*(assetStore: AssetStore): cfloat =
  assetStore.tileSizeSource * assetStore.zoom

proc getRect*(assetStore: AssetStore, point: IntPoint): Rectangle =
  newRectangle(
    cfloat(point.x) * assetStore.tileSizeZoomed,
    cfloat(point.y) * assetStore.tileSizeZoomed,
    assetStore.tileSizeZoomed, assetStore.tileSizeZoomed)

proc getActorImageAsset*(assetStore: AssetStore, kind: ActorKind, state: CombatState): ImageAsset =
  result = (assetStore.actorsTexture, actorSpritemapPoint(kind, state))

proc getTileImageAsset*(assetStore: AssetStore, tile: EnvironmentTile): ImageAsset =
  result = (assetStore.tilesTexture, tileSpritemapPoint(tile))

proc drawAsset*(assetStore: AssetStore, asset: ImageAsset, point: Vector2, orientation: int) =
  let w = assetStore.tileSizeZoomed
  DrawTexturePro(
    asset.texture,
    assetStore.getRect(asset.location),
    newRectangle(point.x + w / 2, point.y + w / 2, w, w),
    newVector2(w / 2, w / 2),
    cfloat(orientation) * 90,
    WHITE)

proc newAssetStore*(zoom: cfloat): AssetStore =
  result = AssetStore()
  result.zoom = zoom
  result.actorsTexture = result.loadTexture("henchman")
  result.tilesTexture = result.loadTexture("tiles")