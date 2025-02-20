module("modules.logic.versionactivity2_3.zhixinquaner.maze.model.PuzzleMazeDrawMO", package.seeall)

slot0 = pureTable("PuzzleMazeDrawMO")

function slot0.initByPos(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9)
	slot0.y = slot2
	slot0.x = slot1
	slot0.objType = slot3
	slot0.subType = slot4 or 0
	slot0.group = slot5 or 0
	slot0.priority = slot6 or 0
	slot0.iconUrl = slot7
	slot0.effects = slot8
	slot0.interactLines = slot9
	slot0.positionType = PuzzleEnum.PositionType.Point
end

function slot0.initByLine(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9)
	slot0.y2 = slot4
	slot0.x2 = slot3
	slot0.y1 = slot2
	slot0.x1 = slot1
	slot0.objType = slot5
	slot0.subType = slot6 or 0
	slot0.group = slot7 or 0
	slot0.priority = slot8 or 0
	slot0.iconUrl = slot9
	slot0.positionType = PuzzleEnum.PositionType.Line
end

function slot0.getKey(slot0)
	slot1 = ""

	return (slot0.positionType ~= PuzzleEnum.PositionType.Point or PuzzleMazeHelper.getPosKey(slot0.x, slot0.y)) and PuzzleMazeHelper.getLineKey(slot0.x1, slot0.y1, slot0.x2, slot0.y2)
end

return slot0
