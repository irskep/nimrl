import tables
import "../util"

let values: seq[seq[string]] = @[
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
]

let SPRITEMAP_HENCHMEN* = newTable[string, IntPoint](64)

for row_i, row in pairs(values):
  for col_i, s in pairs(row):
    SPRITEMAP_HENCHMEN[s] = (x: col_i, y: row_i)