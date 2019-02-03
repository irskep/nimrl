import ecs_base
import combat_states

type
  ActorComponent* = ref object of Component
    actorKind*: ActorKind
    state*: CombatState
  ActorSystem* = ref object of System[ActorComponent]

proc newActorSystem*(): ActorSystem = ActorSystem()

proc newActorComponent*(actorKind: ActorKind, state: CombatState): ActorComponent =
  return ActorComponent(actorKind: actorKind, state: state)