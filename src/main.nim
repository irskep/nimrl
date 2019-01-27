# {.deadCodeElim: on.}
when defined(windows):
  discard
elif defined(macosx):
  {.passL: "-Lbin -lraylib bin/libraylib.a" .}
  {.passL: "-framework OpenGL -framework IOKit -framework AppKit -framework CoreVideo" .}
else:
  # linux?
  discard

import raynim

when isMainModule:
  echo("Hello, World!")
