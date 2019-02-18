import options
import tables

import ../util
import ecs_base
import ecs_actor
import ecs_item
import ecs_spatial
import ecs_tile
import actor_states

let ENV_LAYER: int = 0
let ITEM_LAYER: int = 1
let ACTOR_LAYER: int = 2

type
  ActorStateTransition* = ref object of RootObj
    endState*: ActorState

method name*(ast: ActorStateTransition): string {. base .} = "UNNAMED"
method inputID*(ast: ActorStateTransition): string {. base .} = "NO INPUT"

func positionDeltas*(ast: ActorStateTransition): seq[IntPoint] =
  @[(-1, 0), (0, -1), (1, 0), (0, -1)]

method isPossible*(
  ast: ActorStateTransition,
  actorS: ActorSystem,
  itemS: ItemSystem,
  spatialS: SpatialSystem,
  tileS: TileSystem,
  point: IntPoint,
  entity: Entity,
  actor: ActorComponent,
  positionDelta: IntPoint): bool {. base .} = false

method apply*(
  ast: ActorStateTransition,
  actorS: ActorSystem,
  itemS: ItemSystem,
  spatialS: SpatialSystem,
  tileS: TileSystem,
  point: IntPoint,
  entity: Entity,
  actor: ActorComponent,
  positionDelta: IntPoint) {. base .} = discard

### PLACEHOLDER ###

type
  ASTNop* = ref object of ActorStateTransition

method name*(ast: ASTNop): string = "nop"
method inputID*(ast: ASTNop): string = "nop"

method isPossible*(
    ast: ASTNop,
    actorS: ActorSystem,
    itemS: ItemSystem,
    spatialS: SpatialSystem,
    tileS: TileSystem,
    point: IntPoint,
    entity: Entity,
    actor: ActorComponent,
    positionDelta: IntPoint): bool =
  false

method apply*(
    ast: ASTNop,
    actorS: ActorSystem,
    itemS: ItemSystem,
    spatialS: SpatialSystem,
    tileS: TileSystem,
    point: IntPoint,
    entity: Entity,
    actor: ActorComponent,
    positionDelta: IntPoint) =
  discard

### DODGE ###

type
  ASTDodge* = ref object of ActorStateTransition

method name*(ast: ASTDodge): string = "dodge"
method inputID*(ast: ASTDodge): string = "dodge"

method isPossible*(
    ast: ASTDodge,
    actorS: ActorSystem,
    itemS: ItemSystem,
    spatialS: SpatialSystem,
    tileS: TileSystem,
    point: IntPoint,
    entity: Entity,
    actor: ActorComponent,
    positionDelta: IntPoint): bool =
  
  let targetPoint = point + positionDelta
  let envEntity = spatialS.getOne(ENV_LAYER, targetPoint)

  if not spatialS.isInBounds(targetPoint):
    false
  elif envEntity.isSome and not tileS[envEntity.get()].get().tile.isPassable:
    false
  elif not spatialS.getOne(ACTOR_LAYER, targetPoint).isNone:
    false
  else:
    true

method apply*(
    ast: ASTDodge,
    actorS: ActorSystem,
    itemS: ItemSystem,
    spatialS: SpatialSystem,
    tileS: TileSystem,
    point: IntPoint,
    entity: Entity,
    actor: ActorComponent,
    positionDelta: IntPoint) =
  spatialS.move(entity, ACTOR_LAYER, point + positionDelta)  

### AGGREGATES ###

let ACTOR_STATE_TRANSITIONS_BY_KIND*: Table[ActorKind, seq[ActorStateTransition]] = {
  ActorKind.henchman: @[ASTDodge(), ASTNop()],
  ActorKind.vigilante: @[ASTDodge(), ASTNop()],
}.toTable