import os

import raynim

import ../rules/actor_states
import ../util

import spritemaps

type
  ImageAsset* = tuple[texture: Texture2D, location: IntPoint]
  AssetStore* = ref object of RootObj
    actorsTexture*: Texture2D
    tilesTexture*: Texture2D
    zoom*: cint
    musicTrack1*: Music
    musicTrack2*: Music

### HELPERS ###

proc loadTexture(assetStore: AssetStore, name: string): Texture2D =
  let image = LoadImage("art" & DirSep & name & ".png")
  let imageSizeSource: cint = image.width
  ImageResizeNN(
    unsafeAddr image,
    imageSizeSource * cint(assetStore.zoom),
    imageSizeSource * cint(assetStore.zoom))
  result = LoadTextureFromImage(image)
  UnloadImage(image)

### PUBLIC ###

proc tileSizeSource*(assetStore: AssetStore): cint = 16

proc tileSizeZoomed*(assetStore: AssetStore): cint =
  assetStore.tileSizeSource * assetStore.zoom

proc getRect*(assetStore: AssetStore, point: IntPoint): Rectangle =
  newRectangle(
    cfloat(point.x * assetStore.tileSizeZoomed),
    cfloat(point.y * assetStore.tileSizeZoomed),
    cfloat(assetStore.tileSizeZoomed), cfloat(assetStore.tileSizeZoomed))

proc getActorImageAsset*(assetStore: AssetStore, kind: ActorKind, state: ActorState): ImageAsset =
  result = (assetStore.actorsTexture, actorSpritemapPoint(kind, state))

proc getTileImageAsset*(assetStore: AssetStore, tile: EnvironmentTile): ImageAsset =
  result = (assetStore.tilesTexture, tileSpritemapPoint(tile))

proc drawAsset*(assetStore: AssetStore, asset: ImageAsset, point: Vector2, orientation: cfloat) =
  let w = cfloat(assetStore.tileSizeZoomed)
  DrawTexturePro(
    asset.texture,
    assetStore.getRect(asset.location),
    newRectangle(cfloat(point.x) + w / 2, cfloat(point.y) + w / 2, w, w),
    newVector2(w / 2, w / 2),
    orientation * 90,
    WHITE)

### INIT ###

proc newAssetStore*(zoom: cint): AssetStore =
  result = AssetStore()
  result.zoom = zoom
  result.actorsTexture = result.loadTexture("henchman")
  result.tilesTexture = result.loadTexture("tiles")
  result.musicTrack1 = LoadMusicStream("art" & DirSep & "track1.mp3")
  result.musicTrack1.SetMusicLoopCount(cint.high)
  result.musicTrack2 = LoadMusicStream("art" & DirSep & "track2.mp3")
  result.musicTrack2.SetMusicLoopCount(cint.high)

proc unload*(assetStore: AssetStore) =
  UnloadTexture(assetStore.actorsTexture)
  UnloadTexture(assetStore.tilesTexture)
  UnloadMusicStream(assetStore.musicTrack1)
  UnloadMusicStream(assetStore.musicTrack2)