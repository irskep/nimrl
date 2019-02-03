import options

import raynim

import base_scene
import ../assets/asset_store
import ../rules/ecs
import ../util

type
  StateDebugScene* = ref object of Scene
    assetStore*: AssetStore
    ecs*: VigECS
    entity*: Entity

proc newStateDebugScene*(assetStore: AssetStore): StateDebugScene =
  StateDebugScene(assetStore: assetStore, ecs: newVigECSForStateDebugScene(), entity: 1)

method name*(s: StateDebugScene): string = "StateDebugScene"

method update*(s: StateDebugScene) =
  let actorC = s.ecs.actorSystem[s.entity].get()
  
  if IsKeyPressed((cint)KEY_RIGHT):
    actorC.state = actorC.state.next
  elif IsKeyPressed((cint)KEY_LEFT):
    actorC.state = actorC.state.previous

  if IsKeyPressed((cint)KEY_TAB):
    actorC.actorKind = actorC.actorKind.next

method draw*(s: StateDebugScene) =
  let actorC = s.ecs.actorSystem[s.entity].get()

  DrawText("State debugger", 4, 4, 20, RAYWHITE)
  DrawText($actorC.actorKind & "-" & $actorC.state, 4, 24, 20, RAYWHITE)

  let x = GetScreenWidth() / 2 - s.assetStore.tileSizeZoomed / 2
  let y = GetScreenHeight() / 2 - s.assetStore.tileSizeZoomed / 2

  s.assetStore.drawAsset(s.assetStore.getImageAsset(actorC.actorKind, actorC.state), newVector2(x, y))