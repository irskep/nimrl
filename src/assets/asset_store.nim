import raynim
import spritemap_locations
import ../util
import ../rules/combat_states

type
  ImageAsset* = tuple[texture: Texture2D, location: IntPoint]

type
  AssetStore* = ref object of RootObj
    henchmanTexture*: Texture2D

proc tileSizeSource*(assetStore: AssetStore): cfloat = 16

proc zoom*(assetStore: AssetStore): cfloat = 4

proc tileSizeZoomed*(assetStore: AssetStore): cfloat =
  assetStore.tileSizeSource * assetStore.zoom

proc getRect*(assetStore: AssetStore, point: IntPoint): Rectangle =
  newRectangle(
    cfloat(point.x) * assetStore.tileSizeZoomed,
    cfloat(point.y) * assetStore.tileSizeZoomed,
    assetStore.tileSizeZoomed, assetStore.tileSizeZoomed)

proc getImageAsset*(assetStore: AssetStore, kind: ActorKind, state: CombatState): ImageAsset =
  return (assetStore.henchmanTexture, spritemapPoint(kind, state))

proc drawAsset*(assetStore: AssetStore, asset: ImageAsset, point: Vector2) =
  DrawTextureRec(asset.texture, assetStore.getRect(asset.location), point, WHITE)

proc newAssetStore*(): AssetStore =
  result = AssetStore()
  let imageSizeSource: cfloat = 128
  let henchmanImage = LoadImage("art/henchman.png")
  ImageResizeNN(
    unsafeAddr henchmanImage,
    cint(imageSizeSource * result.zoom),
    cint(imageSizeSource * result.zoom))
  result.henchmanTexture = LoadTextureFromImage(henchmanImage)
  UnloadImage(henchmanImage)