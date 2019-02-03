import raynim
import "../rules/combat_states"
import "../assets/spritemap_locations"
import "../util"

type
  AssetStore = ref object of RootObj
    henchmanTexture*: Texture2D

proc tileSizeSource*(assetStore: AssetStore): cfloat = 16
proc zoom*(assetStore: AssetStore): cfloat = 4
proc tileSizeZoomed*(assetStore: AssetStore): cfloat =
  assetStore.tileSizeSource * assetStore.zoom
proc getRect(assetStore: AssetStore, point: IntPoint): Rectangle =
  newRectangle(
    cfloat(point.x) * assetStore.tileSizeZoomed,
    cfloat(point.y) * assetStore.tileSizeZoomed,
    assetStore.tileSizeZoomed, assetStore.tileSizeZoomed)

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

type
  Scene = ref object of RootObj

method name*(s: Scene): string {. base .} = "UNNAMED"
method update*(s: Scene) {. base .} = discard
method draw*(s: Scene) {. base .} = discard

type
  StateDebugScene = ref object of Scene
    assetStore*: AssetStore
    state*: CombatState
proc newStateDebugScene*(assetStore: AssetStore, state: CombatState): StateDebugScene =
  StateDebugScene(assetStore: assetStore, state: state)

method name*(s: StateDebugScene): string = "StateDebugScene"

method nextState(s: StateDebugScene) =
  var isNext = false
  for state in CombatState.low..CombatState.high:
    if isNext:
      s.state = state
      return
    elif state == s.state:
      isNext = true
  if isNext:
    s.state = CombatState.low
    return

method previousState(s: StateDebugScene) =
  var prev = CombatState.high
  for state in CombatState.low..CombatState.high:
    if state == s.state:
      s.state = prev
      return
    prev = state

method update*(s: StateDebugScene) =
  if IsKeyPressed((cint)KEY_RIGHT):
    s.nextState()
  elif IsKeyPressed((cint)KEY_LEFT):
    s.previousState()

method draw*(s: StateDebugScene) =
  DrawText("State debugger", 4, 4, 20, RAYWHITE)
  DrawText($s.state, 4, 24, 20, RAYWHITE)

  let x = GetScreenWidth() / 2 - s.assetStore.tileSizeZoomed / 2
  let y = GetScreenHeight() / 2 - s.assetStore.tileSizeZoomed / 2
  let texRect = s.assetStore.getRect(spritemapPointHenchman(s.state))
  DrawText($texRect, 4, 44, 20, RAYWHITE)

  DrawTextureRec(s.assetStore.henchmanTexture, texRect, newVector2(x, y), WHITE)
  # DrawTexture(s.assetStore.henchmanTexture, cint(x), cint(y), WHITE)

proc run*() =
  let screenWidth: cint = 800
  let screenHeight: cint = 450

  InitWindow(screenWidth, screenHeight, "vigil@nte")
  SetWindowPosition(0, 20)
  SetTargetFPS(60)

  var s = newStateDebugScene(newAssetStore(), standPassive)

  while not WindowShouldClose() and not IsWindowHidden():
    s.update()

    BeginDrawing()
    ClearBackground(newColor(uint8(24), uint8(24), uint8(24), uint8(255)))
    s.draw()
    EndDrawing()