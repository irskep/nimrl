when isMainModule:
  import unittest
  import ../src/rules/movesets
  import ../src/rules/combat_states

  suite "Legal moves":
    test "Henchman can stand":
      check:
        # henchmen can hang out
        getIsLegalMove(MoveSet.henchman, CombatState.standPassive, WeaponClass.fists)
        getIsLegalMove(MoveSet.henchman, CombatState.standActive, WeaponClass.fists)

    test "Vigilante can also stand":
      check:
        # but the vigilante never sleeps
        not getIsLegalMove(MoveSet.vigilante, CombatState.standPassive, WeaponClass.fists)
        getIsLegalMove(MoveSet.vigilante, CombatState.standActive, WeaponClass.fists)

    test "Henchman can use weapons if held":
      check:
        getIsLegalMove(MoveSet.henchman, CombatState.punchingBefore, WeaponClass.fists)
        not getIsLegalMove(MoveSet.henchman, CombatState.punchingBefore, WeaponClass.knife)
        not getIsLegalMove(MoveSet.henchman, CombatState.punchingBefore, WeaponClass.gun)

        not getIsLegalMove(MoveSet.henchman, CombatState.knifingBefore, WeaponClass.fists)
        getIsLegalMove(MoveSet.henchman, CombatState.knifingBefore, WeaponClass.knife)
        not getIsLegalMove(MoveSet.henchman, CombatState.knifingBefore, WeaponClass.gun)

        not getIsLegalMove(MoveSet.henchman, CombatState.shootingBefore, WeaponClass.fists)
        not getIsLegalMove(MoveSet.henchman, CombatState.shootingBefore, WeaponClass.knife)
        getIsLegalMove(MoveSet.henchman, CombatState.shootingBefore, WeaponClass.gun)

    test "Vigilante cannot use weapons":
      check:
        getIsLegalMove(MoveSet.vigilante, CombatState.punchingBefore, WeaponClass.fists)
        not getIsLegalMove(MoveSet.vigilante, CombatState.punchingBefore, WeaponClass.knife)
        not getIsLegalMove(MoveSet.vigilante, CombatState.punchingBefore, WeaponClass.gun)

        not getIsLegalMove(MoveSet.vigilante, CombatState.knifingBefore, WeaponClass.fists)
        not getIsLegalMove(MoveSet.vigilante, CombatState.knifingBefore, WeaponClass.knife)
        not getIsLegalMove(MoveSet.vigilante, CombatState.knifingBefore, WeaponClass.gun)

        not getIsLegalMove(MoveSet.vigilante, CombatState.shootingBefore, WeaponClass.fists)
        not getIsLegalMove(MoveSet.vigilante, CombatState.shootingBefore, WeaponClass.knife)
        not getIsLegalMove(MoveSet.vigilante, CombatState.shootingBefore, WeaponClass.gun)