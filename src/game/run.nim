import raynim
import "../rules/combat_states"
import "../assets/asset_store"
import "../util"

type
  Scene = ref object of RootObj

method name*(s: Scene): string {. base .} = "UNNAMED"
method update*(s: Scene) {. base .} = discard
method draw*(s: Scene) {. base .} = discard

type
  StateDebugScene = ref object of Scene
    assetStore*: AssetStore
    state*: CombatState
    actorKind*: ActorKind
proc newStateDebugScene*(assetStore: AssetStore, state: CombatState): StateDebugScene =
  StateDebugScene(assetStore: assetStore, state: state, actorKind: henchman)

method name*(s: StateDebugScene): string = "StateDebugScene"

method update*(s: StateDebugScene) =
  if IsKeyPressed((cint)KEY_RIGHT):
    s.state = s.state.next
  elif IsKeyPressed((cint)KEY_LEFT):
    s.state = s.state.previous

  if IsKeyPressed((cint)KEY_TAB):
    s.actorKind = s.actorKind.next

method draw*(s: StateDebugScene) =
  DrawText("State debugger", 4, 4, 20, RAYWHITE)
  DrawText($s.actorKind & "-" & $s.state, 4, 24, 20, RAYWHITE)

  let x = GetScreenWidth() / 2 - s.assetStore.tileSizeZoomed / 2
  let y = GetScreenHeight() / 2 - s.assetStore.tileSizeZoomed / 2

  s.assetStore.drawAsset(s.assetStore.getImageAsset(s.actorKind, s.state), newVector2(x, y))

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