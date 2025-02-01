module("modules.logic.dungeon.model.DungeonPuzzleMazeDrawMO", package.seeall)

slot0 = pureTable("DungeonPuzzleMazeDrawMO")

function slot0.initByPos(slot0, slot1, slot2, slot3, slot4)
	slot0.y = slot2
	slot0.x = slot1
	slot0.objType = slot3
	slot0.val = slot4 or 0
	slot0.isPos = true
end

function slot0.initByLine(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.y2 = slot4
	slot0.x2 = slot3
	slot0.y1 = slot2
	slot0.x1 = slot1
	slot0.objType = slot5
	slot0.val = slot6 or 0
	slot0.isPos = false
end

return slot0
