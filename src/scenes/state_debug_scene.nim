import critbits
import options
import sequtils

import raynim

import ../assets/asset_store
import ../rules/ecs
import ../rules/tilemap
import ../util

import base_scene
import world_rendering

type
  StateDebugScene* = ref object of Scene
    assetStore*: AssetStore
    ecs*: VigECS
    entity*: Entity
    camera*: Camera2D

proc newStateDebugScene*(assetStore: AssetStore): StateDebugScene =
  var camera: Camera2D
  camera.zoom = 1
  camera.rotation = 0
  camera.offset = newVector2(0, 0)
  camera.target = newVector2(0, 0)

  let ecs = newVigECSForStateDebugScene()
  StateDebugScene(
    assetStore: assetStore,
    ecs: ecs,
    entity: toSeq(ecs.actorSystem.keys)[0],
    camera: camera)

method name*(s: StateDebugScene): string = "StateDebugScene"

method update*(s: StateDebugScene) =
  let actorC = s.ecs.actorSystem[s.entity].get()
  
  if IsKeyPressed(KEY_RIGHT):
    actorC.state = actorC.state.next
  elif IsKeyPressed(KEY_LEFT):
    actorC.state = actorC.state.previous

  if IsKeyPressed(KEY_TAB):
    actorC.actorKind = actorC.actorKind.next

method draw*(s: StateDebugScene) =
  s.camera.target = s.ecs.getPosition(s.assetStore, s.entity)
  s.camera.target.x += s.assetStore.tileSizeZoomed / 2
  s.camera.target.y += s.assetStore.tileSizeZoomed / 2
  s.camera.offset.x = -s.camera.target.x + cfloat(GetScreenWidth() / 2)
  s.camera.offset.y = -s.camera.target.y + cfloat(GetScreenHeight() / 2)
  s.ecs.drawWorld(s.assetStore, s.camera)

  let actorC = s.ecs.actorSystem[s.entity].get()

  DrawText("State debugger", 4, 4, 20, RAYWHITE)
  DrawText($actorC.actorKind & "-" & $actorC.state, 4, 24, 20, RAYWHITE)