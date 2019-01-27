when isMainModule:
  import unittest
  import src/main

  suite "Combat":
    test "nothing":
      check:
        1 == 1
        1 != 2