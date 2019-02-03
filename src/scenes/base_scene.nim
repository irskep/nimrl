import options

type
  Scene* = ref object of RootObj
    nextScene*: Option[Scene]

method name*(s: Scene): string {. base .} = "UNNAMED"
method update*(s: Scene) {. base .} = discard
method draw*(s: Scene) {. base .} = discard