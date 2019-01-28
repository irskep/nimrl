import options
import combat_states

type
  MoveSet* = enum
    henchman,
    vigilante
  
  WeaponClass* = enum
    fists,
    knife,
    gun

  ThrowableState* = enum
    emptyHanded,
    nearObject,
    holdingObject

proc getWeaponChecksForState(state: CombatState): Option[WeaponClass] =
  case state:
    of
      standPassive,
      standActive,
      stumbling,
      stunned,
      charging,
      prone,
      dead,
      dodging,
      pickingUp,
      throwingBefore,
      throwingAfter,
      parryingBefore,
      parryingAfter,
      catching,
      takingWeapon,
      losingWeapon,
      blocking:
        return none(WeaponClass)
    of
      superpunchingBefore,
      superpunchingAfter,
      punchingBefore,
      punchingAfter:
        return some(fists)
    of
      knifingBefore,
      knifingAfter:
        return some(knife)
    of
      shootingBefore,
      shootingAfter:
        return some(gun)

proc getIsLegalBaseMoveForHenchman(state: CombatState): bool =
  case state:
    of
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
      pickingUp,
      throwingBefore,
      throwingAfter,
      losingWeapon:
        return true
    of
      parryingBefore,
      parryingAfter,
      catching,
      takingWeapon,
      superpunchingBefore,
      superpunchingAfter:
        return false

proc getIsLegalBaseMoveForVigilante(state: CombatState): bool =
  case state:
    of
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
      pickingUp,
      throwingBefore,
      throwingAfter,
      parryingBefore,
      parryingAfter,
      catching,
      takingWeapon:
        return true
    of
      standPassive,
      knifingBefore,
      knifingAfter,
      shootingBefore,
      shootingAfter,
      superpunchingBefore,
      superpunchingAfter,
      losingWeapon:
        return false

proc getIsLegalMove*(kind: MoveSet, state: CombatState, weaponClass: WeaponClass): bool =
  case kind:
    of henchman:
      if not getIsLegalBaseMoveForHenchman(state):
        return false
    of vigilante:
      if not getIsLegalBaseMoveForVigilante(state):
        return false

  let weaponToCheck = getWeaponChecksForState(state)
  if not weaponToCheck.isNone:
    if weaponToCheck.get() != weaponClass:
      return false
  
  return true