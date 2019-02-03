import options
import tables

import ../rules/combat_states
import ../util

proc makeSpritemap(values: seq[seq[string]]): ref Table[string, IntPoint] =
  result = newTable[string, IntPoint](64)

  for row_i, row in pairs(values):
    for col_i, s in pairs(row):
      result[s] = (x: col_i, y: row_i)

let SPRITEMAP_HENCHMEN* = makeSpritemap(@[
  @["stand", "stumbling", "stunned", "charging"],
  @["prone", "dead", "dodging", "blocking"],
  @["punching_before", "punching_after", "knifing_before", "knifing_after"],
  @["shooting_before", "shooting_after", "superpunching_before", "superpunching_after"],
  @["picking_up", "throwing_before", "throwing_after", "box_in_flight", "losing_weapon"],
  @[
    "bm_stand",
    "bm_parrying_before",
    "bm_parrying_after",
    "bm_dodging",
    "bm_throwing_before",
    "bm_throwing_after",
    "bm_punching_before",
    "bm_punching_after",
  ],
  @[
    "bm_catching",
    "bm_taking_weapon",
    "bm_disabling_weapon",
    "bm_picking_up",
    "bm_stunned"],
])

let SPRITEMAP_TILES = makeSpritemap(@[
  @["floor", "wall", "door_closed", "door_open"],
  @[],
  @[],
  @[],
  @[],
  @[],
  @[],
  @["throwable", "gun", "knife"],
])

proc spritemapIDHenchman(state: CombatState): Option[string] =
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

proc spritemapIDVigilante(state: CombatState): Option[string] =
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
    of throwingBefore:      return some("bm_throwing_before")
    of throwingAfter:       return some("bm_throwing_after")
    of parryingBefore:      return some("bm_parrying_before")
    of parryingAfter:       return some("bm_parrying_after")
    of catching:            return some("bm_catching")
    of takingWeapon:        return some("bm_taking_weapon")
    of losingWeapon:        return none(string)
    of breakingWeapon:      return some("bm_disabling_weapon")

proc actorSpritemapPoint*(actorKind: ActorKind, state: CombatState): IntPoint =
  let maybeID = case actorKind
    of henchman: spritemapIDHenchman(state)
    of vigilante: spritemapIDVigilante(state)
  if maybeID.isNone:
    result = (0, 0)
  else:
    result = SPRITEMAP_HENCHMEN.getOrDefault(maybeID.get())

proc tileSpritemapPoint*(tile: EnvironmentTile): IntPoint =
  let name = case tile
    of floor: "floor"
    of wall: "wall"
    of doorClosed: "door_closed"
    of doorOpen: "door_open"
  result = SPRITEMAP_TILES.getOrDefault(name)