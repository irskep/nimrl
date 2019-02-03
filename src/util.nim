import raynim

type
  IntPoint* = tuple[x: int, y: int]

proc IsKeyPressed*(k: KeyboardKey): bool = IsKeyPressed((cint)k)
proc IsKeyReleased*(k: KeyboardKey): bool = IsKeyReleased((cint)k)
proc IsKeyDown*(k: KeyboardKey): bool = IsKeyDown((cint)k)
proc IsKeyUp*(k: KeyboardKey): bool = IsKeyUp((cint)k)