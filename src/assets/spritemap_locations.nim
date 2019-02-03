import options
import tables

import "../rules/combat_states"
import "../util"
import spritemap_henchman

proc spritemapIDHenchman*(state: CombatState): Option[string] =
  case state
    of standPassive:        return some("stand")
    of standActive:         return some("stand")
    of stumbling:           return some("stumbling")
    of stunned:             return some("stunned")
    of charging:            return some("charging")
    of prone:               return some("prone")
    of dead:                return some("dead")
    of dodging:             return some("dodging")
    of blocking:            return some("blocking")
    of punchingBefore:      return some("punching_before")
    of punchingAfter:       return some("punching_after")
    of knifingBefore:       return some("knifing_before")
    of knifingAfter:        return some("knifing_after")
    of shootingBefore:      return some("shooting_before")
    of shootingAfter:       return some("shooting_after")
    of superpunchingBefore: return some("superpunching_before")
    of superpunchingAfter:  return some("superpunching_after")
    of pickingUp:           return some("picking_up")
    of throwingBefore:      return some("throwing_before")
    of throwingAfter:       return some("throwing_after")
    of parryingBefore:      return none(string)
    of parryingAfter:       return none(string)
    of catching:            return none(string)
    of takingWeapon:        return none(string)
    of losingWeapon:        return some("losing_weapon")
    of breakingWeapon:      return none(string)

proc spritemapPointHenchman*(state: CombatState): IntPoint =
  let maybeID = spritemapIDHenchman(state)
  if maybeID.isNone:
    return (0, 0)
  else:
    return SPRITEMAP_HENCHMEN.getOrDefault(maybeID.get())

proc spritemapIDBatman*(state: CombatState): Option[string] =
  case state
    of standPassive:        return some("bm_stand")
    of standActive:         return some("bm_stand")
    of stumbling:           return some("bm_dodging")
    of stunned:             return some("bm_stunned")
    of charging:            return none(string)
    of prone:               return none(string)
    of dead:                return none(string)
    of dodging:             return some("bm_dodging")
    of blocking:            return none(string)
    of punchingBefore:      return some("bm_punching_before")
    of punchingAfter:       return some("bm_punching_after")
    of knifingBefore:       return none(string)
    of knifingAfter:        return none(string)
    of shootingBefore:      return none(string)
    of shootingAfter:       return none(string)
    of superpunchingBefore: return none(string)
    of superpunchingAfter:  return none(string)
    of pickingUp:           return some("bm_picking_up")
    of throwingBefore:      return some("throwing_before")
    of throwingAfter:       return some("throwing_after")
    of parryingBefore:      return some("bm_parrying_before")
    of parryingAfter:       return some("bm_parrying_after")
    of catching:            return some("bm_catching")
    of takingWeapon:        return some("bm_taking_weapon")
    of losingWeapon:        return none(string)
    of breakingWeapon:      return some("bm_disabling_weapon")

proc spritemapPointBatman*(state: CombatState): IntPoint =
  let maybeID = spritemapIDBatman(state)
  if maybeID.isNone:
    return (0, 0)
  else:
    return SPRITEMAP_HENCHMEN.getOrDefault(maybeID.get())