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

  MoveSet* = enum
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