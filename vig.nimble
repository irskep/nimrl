# Package

version       = "0.1.0"
author        = "Steve Johnson"
description   = "A new awesome nimble package"
license       = "MIT"
srcDir        = "src"
bin           = @["main"]


# Dependencies

requires("nim >= 0.19.2",
  "https://github.com/genotrance/nimterop#head",
  "https://github.com/irskep/nim-glfw#raw-cdecls",
  "https://github.com/irskep/raynim#head")