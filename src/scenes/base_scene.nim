type
  Scene* = ref object of RootObj

method name*(s: Scene): string {. base .} = "UNNAMED"
method update*(s: Scene) {. base .} = discard
method draw*(s: Scene) {. base .} = discard