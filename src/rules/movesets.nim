import options
import combat_states

proc getWeaponChecksForState(state: CombatState): Option[WeaponClass] =
  case state:
    of
      superpunchingBefore,
      punchingBefore:
        return some(fists)
    of throwingBefore:
      return some(throwable)
    of knifingBefore:
      return some(knife)
    of shootingBefore:
      return some(gun)
    else:
      return none(WeaponClass)

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
      breakingWeapon,
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
      breakingWeapon,
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

proc getIsLegalMove*(kind: MoveSet,
                     state: CombatState,
                     weaponClass: WeaponClass,
                     weaponClassOnFloor: Option[WeaponClass]): bool =

  case kind:
    of henchman:
      if not getIsLegalBaseMoveForHenchman(state):
        return false
    of vigilante:
      if not getIsLegalBaseMoveForVigilante(state):
        return false

  let weaponToCheck = getWeaponChecksForState(state)
  if not weaponToCheck.isNone and weaponToCheck.get() != weaponClass:
    return false

  # can't pick up if nothing is on the floor
  if state == pickingUp and weaponClassOnFloor.isNone:
    return false
  
  return true