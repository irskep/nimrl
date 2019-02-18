import raynim
import util

proc isInputActive*(inputID: string): bool =
  case inputID:
    of "faceUp": return IsKeyPressed(KEY_UP)
    of "faceRight": return IsKeyPressed(KEY_RIGHT)
    of "faceDown": return IsKeyPressed(KEY_DOWN)
    of "faceLeft": return IsKeyPressed(KEY_LEFT)
    of "dodge": return IsKeyPressed(KEY_A)
    else: return false