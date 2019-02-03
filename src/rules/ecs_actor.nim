import ecs_base
import combat_states

type
  ActorComponent* = ref object of Component
    actorKind*: ActorKind
    state*: CombatState
  ActorSystem*[T: ActorComponent] = ref object of System[T]

proc newActorSystem*(): ActorSystem[ActorComponent] = ActorSystem[ActorComponent]()

proc newActorComponent*(actorKind: ActorKind, state: CombatState): ActorComponent =
  return ActorComponent(actorKind: actorKind, state: state)