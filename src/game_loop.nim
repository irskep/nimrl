import options
import raynim

import rules/actor_states
import assets/asset_store
import scenes/base_scene
import scenes/state_debug_scene

proc run*() =
  let screenWidth: cint = 800
  let screenHeight: cint = 450

  InitWindow(screenWidth, screenHeight, "vigil@nte")
  SetWindowPosition(0, 20)
  SetTargetFPS(60)

  InitAudioDevice()

  let assetStore = newAssetStore(4)
  var s: Scene = newStateDebugScene(assetStore)

  # PlayMusicStream(assetStore.musicTrack1)
  # PlayMusicStream(assetStore.musicTrack2)

  while not WindowShouldClose() and not IsWindowHidden():
    s.update()

    # UpdateMusicStream(assetStore.musicTrack1)
    # UpdateMusicStream(assetStore.musicTrack2)

    BeginDrawing()
    ClearBackground(newColor(uint8(24), uint8(24), uint8(24), uint8(255)))
    s.draw()
    EndDrawing()

    if s.nextScene.isSome:
      s = s.nextScene.get()

  assetStore.unload()
  CloseAudioDevice()