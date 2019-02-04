import ecs_base
import combat_states

type
  ActorComponent* = ref object of Component
    actorKind*: ActorKind
    state*: CombatState
    orientation*: int  # 0,1,2,3
  ActorSystem* = ref object of System[ActorComponent]

proc newActorSystem*(): ActorSystem = ActorSystem()

proc newActorComponent*(actorKind: ActorKind, state: CombatState, orientation: int): ActorComponent =
  return ActorComponent(actorKind: actorKind, state: state, orientation: orientation)