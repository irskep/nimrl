import ecs_base

type
  ItemComponent* = ref object of Component
  ItemSystem* = ref object of System[ItemComponent]

proc newItemSystem*(): ItemSystem = ItemSystem()