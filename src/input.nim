import critbits
import options
import sequtils

import raynim

proc isInputActive*(inputID: string): bool =
  case inputID:
    # ../src/input.nim(9, 37) Error: type mismatch: got <KeyboardKey>
    # but expected one of: 
    # proc IsKeyPressed(key: cint): bool
    # 
    # expression: IsKeyPressed(265)
    #       Tip: 34 messages have been suppressed, use --verbose to show them.
    #     Error: Execution failed with exit code 256
    of "faceUp": return IsKeyPressed(KEY_UP)
    of "faceRight": return IsKeyPressed(KEY_RIGHT)
    of "faceDown": return IsKeyPressed(KEY_DOWN)
    of "faceLeft": return IsKeyPressed(KEY_LEFT)
    of "dodge": return IsKeyPressed(KEY_A)
    else: return false