type
  ActorState* = enum
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

proc next*(state: ActorState): ActorState =
  var isNext = false
  for s2 in ActorState.low..ActorState.high:
    if isNext:
      return s2
    elif state == s2:
      isNext = true
  if isNext:
    return ActorState.low

proc previous*(state: ActorState): ActorState =
  var prev = ActorState.high
  for s2 in ActorState.low..ActorState.high:
    if state == s2:
      return prev
    prev = s2
  return ActorState.low

proc next*(actorKind: ActorKind): ActorKind =
  var isNext = false
  for s2 in ActorKind.low..ActorKind.high:
    if isNext:
      return s2
    elif actorKind == s2:
      isNext = true
  if isNext:
    return ActorKind.low

### ENV ###

proc isPassable*(tile: EnvironmentTile): bool =
  case tile:
    of floor: true
    of wall: false
    of doorOpen: true
    of doorClosed: false