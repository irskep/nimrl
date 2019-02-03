import options
import raynim

import rules/combat_states
import assets/asset_store
import scenes/base_scene
import scenes/state_debug_scene

proc run*() =
  let screenWidth: cint = 800
  let screenHeight: cint = 450

  InitWindow(screenWidth, screenHeight, "vigil@nte")
  SetWindowPosition(0, 20)
  SetTargetFPS(60)

  var s: Scene = newStateDebugScene(newAssetStore(4))

  while not WindowShouldClose() and not IsWindowHidden():
    s.update()

    BeginDrawing()
    ClearBackground(newColor(uint8(24), uint8(24), uint8(24), uint8(255)))
    s.draw()
    EndDrawing()

    if s.nextScene.isSome:
      s = s.nextScene.get()