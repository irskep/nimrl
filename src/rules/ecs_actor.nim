import ../util
import ecs_base
import actor_states

type
  Orientation* = enum
    up, right, down, left
  ActorComponent* = ref object of Component
    actorKind*: ActorKind
    state*: ActorState
    orientation*: Orientation  # 0,1,2,3
  ActorSystem* = ref object of System[ActorComponent]

proc delta*(orientation: Orientation): IntPoint =
  case orientation:
    of up: (0, -1)
    of left: (-1, 0)
    of down: (0, 1)
    of right: (1, 0)

proc cwFromTop*(orientation: Orientation): cfloat =
  case orientation:
    of up: 0
    of right: 1
    of down: 2
    of left: 3

proc newActorSystem*(): ActorSystem = ActorSystem()

proc newActorComponent*(actorKind: ActorKind, state: ActorState, orientation: int): ActorComponent =
  return ActorComponent(actorKind: actorKind, state: state, orientation: up)