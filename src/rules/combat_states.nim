type
  CombatState* = enum
    standPassive,
    standActive,
    stumbling,
    stunned,
    charging,
    prone,
    dead,
    dodging,
    blocking,
    punchingBefore,
    punchingAfter,
    knifingBefore,
    knifingAfter,
    shootingBefore,
    shootingAfter,
    superpunchingBefore,
    superpunchingAfter,
    pickingUp,
    throwingBefore,
    throwingAfter,
    parryingBefore,
    parryingAfter,
    catching,
    takingWeapon,
    losingWeapon,
    breakingWeapon

  ActorKind* = enum
    henchman,
    vigilante
  
  WeaponClass* = enum
    fists,
    knife,
    gun,
    throwable

  ThrowableState* = enum
    notNearObject,
    nearObject

  EnvironmentTile* = enum
    floor,
    wall,
    doorClosed,
    doorOpen

proc next*(state: CombatState): CombatState =
  var isNext = false
  for s2 in CombatState.low..CombatState.high:
    if isNext:
      return s2
    elif state == s2:
      isNext = true
  if isNext:
    return CombatState.low

proc previous*(state: CombatState): CombatState =
  var prev = CombatState.high
  for s2 in CombatState.low..CombatState.high:
    if state == s2:
      return prev
    prev = s2
  return CombatState.low

proc next*(actorKind: ActorKind): ActorKind =
  var isNext = false
  for s2 in ActorKind.low..ActorKind.high:
    if isNext:
      return s2
    elif actorKind == s2:
      isNext = true
  if isNext:
    return ActorKind.low