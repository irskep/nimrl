import sequtils

import ../util

import ecs_base

type
  Tilemap* = ref object of RootObj
    layersCount*: int
    width*: int
    height*: int
    cells*: seq[seq[seq[seq[Entity]]]] # layer, row, col, items

proc newTilemap*(layers: int, w: int, h: int): Tilemap =
  proc makeLayer(): seq[seq[seq[Entity]]] =
    result = newSeq[seq[seq[Entity]]](h)
    for y in 0..<h:
      result[y] = newSeq[seq[Entity]](w)
      for x in 0..<w:
        result[y][x] = newSeq[Entity](0)

  var cells = newSeq[seq[seq[seq[Entity]]]](layers)
  for i in 0..<layers:
    cells[i] = makeLayer()

  result = Tilemap(layersCount: layers, width: w, height: h, cells: cells)

proc entities*(tilemap: Tilemap, layer: int, point: IntPoint): seq[Entity] =
  result = tilemap.cells[layer][point.y][point.x]

proc add*(tilemap: Tilemap, entity: Entity, layer: int, point: IntPoint) =
  tilemap.cells[layer][point.y][point.x].add(entity)

proc remove*(tilemap: Tilemap, entity: Entity, layer: int, point: IntPoint) =
  if not tilemap.cells[layer][point.y][point.x].contains(entity):
    echo("looking for ", entity, " in layer ", layer)
    echo(tilemap.cells)
    assert(
      tilemap.cells[layer][point.y][point.x].contains(entity),
      "Can't remove entity; it isn't there")
  tilemap.cells[layer][point.y][point.x].keepIf(proc(e: Entity): bool = e != entity)

proc isInBounds*(tilemap: Tilemap, point: IntPoint): bool =
  return point.x >= 0 and point.y >= 0 and point.x < tilemap.width and point.y < tilemap.height