module("modules.logic.dungeon.model.DungeonPuzzleCircuitMO", package.seeall)

slot0 = pureTable("DungeonPuzzleCircuitMO")

function slot0.init(slot0, slot1, slot2)
	slot0.x = slot1
	slot0.y = slot2
	slot0.id = slot1 * 100 + slot2
	slot0.value = 0
	slot0.rawValue = 0
	slot0.type = 0
end

function slot0.toString(slot0)
	return string.format("id:%s,x:%s,y:%s,type:%s,value:%s", slot0.id, slot0.x, slot0.y, slot0.type, slot0.value)
end

return slot0
