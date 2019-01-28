when isMainModule:
  import options
  import tables
  import unittest

  import ../src/assets/spritemap_henchman
  import ../src/rules/movesets
  import ../src/rules/combat_states

  suite "Legal moves":
    test "Henchman can stand":
      check:
        # henchmen can hang out
        getIsLegalMove(henchman, standPassive, fists, none(WeaponClass))
        getIsLegalMove(henchman, standActive, fists, none(WeaponClass))

    test "Vigilante can also stand":
      check:
        # but the vigilante never sleeps
        not getIsLegalMove(vigilante, standPassive, fists, none(WeaponClass))
        getIsLegalMove(vigilante, standActive, fists, none(WeaponClass))

    test "Henchman can use weapons if held":
      check:
        getIsLegalMove(henchman, punchingBefore, fists, none(WeaponClass))
        not getIsLegalMove(henchman, punchingBefore, knife, none(WeaponClass))
        not getIsLegalMove(henchman, punchingBefore, gun, none(WeaponClass))
        not getIsLegalMove(henchman, punchingBefore, throwable, none(WeaponClass))

        not getIsLegalMove(henchman, knifingBefore, fists, none(WeaponClass))
        getIsLegalMove(henchman, knifingBefore, knife, none(WeaponClass))
        not getIsLegalMove(henchman, knifingBefore, gun, none(WeaponClass))
        not getIsLegalMove(henchman, knifingBefore, throwable, none(WeaponClass))

        not getIsLegalMove(henchman, shootingBefore, fists, none(WeaponClass))
        not getIsLegalMove(henchman, shootingBefore, knife, none(WeaponClass))
        getIsLegalMove(henchman, shootingBefore, gun, none(WeaponClass))
        not getIsLegalMove(henchman, shootingBefore, throwable, none(WeaponClass))

        not getIsLegalMove(henchman, throwingBefore, fists, none(WeaponClass))
        not getIsLegalMove(henchman, throwingBefore, knife, none(WeaponClass))
        not getIsLegalMove(henchman, throwingBefore, gun, none(WeaponClass))
        getIsLegalMove(henchman, throwingBefore, throwable, none(WeaponClass))

    test "Vigilante cannot use weapons":
      check:
        getIsLegalMove(vigilante, punchingBefore, fists, none(WeaponClass))
        not getIsLegalMove(vigilante, punchingBefore, knife, none(WeaponClass))
        not getIsLegalMove(vigilante, punchingBefore, gun, none(WeaponClass))

        not getIsLegalMove(vigilante, knifingBefore, fists, none(WeaponClass))
        not getIsLegalMove(vigilante, knifingBefore, knife, none(WeaponClass))
        not getIsLegalMove(vigilante, knifingBefore, gun, none(WeaponClass))

        not getIsLegalMove(vigilante, shootingBefore, fists, none(WeaponClass))
        not getIsLegalMove(vigilante, shootingBefore, knife, none(WeaponClass))
        not getIsLegalMove(vigilante, shootingBefore, gun, none(WeaponClass))

suite "Assets":
  test "Spritemap: Henchman":
    check:
      SPRITEMAP_HENCHMEN.getOrDefault("prone") == (0, 1)
      SPRITEMAP_HENCHMEN.getOrDefault("charging") == (3, 0)