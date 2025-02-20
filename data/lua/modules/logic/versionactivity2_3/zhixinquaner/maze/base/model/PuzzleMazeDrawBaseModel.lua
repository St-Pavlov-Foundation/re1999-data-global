module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.model.PuzzleMazeDrawBaseModel", package.seeall)

slot0 = class("PuzzleMazeDrawBaseModel", BaseModel)

function slot0.reInit(slot0)
	slot0:release()
end

function slot0.release(slot0)
	slot0._statusMap = nil
	slot0._blockMap = nil
	slot0._objMap = nil
	slot0._objList = nil
	slot0._startX = nil
	slot0._startY = nil
	slot0._endX = nil
	slot0._endY = nil
	slot0._lineMap = nil
	slot0._interactCtrlMap = nil
	slot0._elementCo = nil

	slot0:clear()
end

function slot0.startGame(slot0, slot1)
	slot0:release()
	slot0:decode(slot1.param)

	slot0._elementCo = slot1
end

function slot0.decode(slot0, slot1)
	slot0._objMap = {}
	slot0._blockMap = {}
	slot0._lineMap = {}
	slot0._interactCtrlMap = {}
	slot2 = cjson.decode(slot1)
	slot0._width = slot2.width
	slot0._height = slot2.height
	slot0._pawnIconUrl = slot2.pawnIconUrl

	slot0:decodeObj(slot0._blockMap, slot2.blockMap)
	slot0:decodeObj(slot0._objMap, slot2.objMap)
	slot0:initMapLineState(slot2)
	slot0:findStartAndEndPos()
	slot0:initConst()
end

function slot0.findStartAndEndPos(slot0)
	for slot4, slot5 in pairs(slot0._objMap) do
		if slot5.objType == PuzzleEnum.MazeObjType.Start then
			slot0._startPosX = slot5.x
			slot0._startPosY = slot5.y
		elseif slot5.objType == PuzzleEnum.MazeObjType.End then
			slot0._endPosX = slot5.x
			slot0._endPosY = slot5.y
		end
	end
end

function slot0.decodeObj(slot0, slot1, slot2)
	if not slot2 then
		return
	end

	for slot6, slot7 in pairs(slot2) do
		slot9 = nil

		if #string.splitToNumber(slot7.key, "_") <= 2 then
			slot9 = slot0:createMOByPos(slot8[1], slot8[2], slot7)
		elseif slot10 >= 4 then
			slot9 = slot0:createMOByLine(slot8[1], slot8[2], slot8[3], slot8[4], slot7)
		end

		slot1[slot7.key] = slot9
	end
end

function slot0.createMOByPos(slot0, slot1, slot2, slot3)
	slot4 = PuzzleMazeDrawMO.New()

	slot4:initByPos(slot1, slot2, slot3.type, slot3.subType, slot3.group, slot3.priority, slot3.iconUrl, slot3.effects, slot3.interactLines)
	slot0:addAtLast(slot4)

	return slot4
end

function slot0.createMOByLine(slot0, slot1, slot2, slot3, slot4, slot5)
	slot6 = PuzzleMazeDrawMO.New()

	slot6:initByLine(slot1, slot2, slot3, slot4, slot5.type, slot5.subType, slot5.group, slot5.priority, slot5.iconUrl)
	slot0:addAtLast(slot6)

	return slot6
end

function slot0.initMapLineState(slot0, slot1)
	for slot6, slot7 in pairs(slot1 and slot1.blockMap or {}) do
		slot0._lineMap[slot7.key] = PuzzleEnum.LineState.Disconnect
	end

	for slot7, slot8 in pairs(slot1 and slot1.objMap or {}) do
		if slot8.interactLines then
			for slot12, slot13 in pairs(slot8.interactLines) do
				slot14 = PuzzleMazeHelper.getLineKey(slot13.x1, slot13.y1, slot13.x2, slot13.y2)
				slot0._lineMap[slot14] = PuzzleEnum.LineState.Switch_Off
				slot0._interactCtrlMap[slot14] = slot8
			end
		end
	end
end

function slot0.initConst(slot0)
	slot1, slot2 = slot0:getGameSize()
	slot0._startX = -slot1 * 0.5 - 0.5
	slot0._startY = -slot2 * 0.5 - 0.5
end

function slot0.getStartPoint(slot0)
	return slot0._startPosX, slot0._startPosY
end

function slot0.getEndPoint(slot0)
	return slot0._endPosX, slot0._endPosY
end

function slot0.getElementCo(slot0)
	return slot0._elementCo
end

function slot0.setGameStatus(slot0, slot1)
	if slot0._elementCo then
		slot0._statusMap = slot0._statusMap or {}
		slot0._statusMap[slot0._elementCo.id] = slot1
	end
end

function slot0.getClearStatus(slot0, slot1)
	if slot0._statusMap and slot0._statusMap[slot1] then
		return true
	end

	return false
end

function slot0.getObjAtPos(slot0, slot1, slot2)
	return slot0._objMap[PuzzleMazeHelper.getPosKey(slot1, slot2)]
end

function slot0.getObjAtLine(slot0, slot1, slot2, slot3, slot4)
	return slot0._blockMap[PuzzleMazeHelper.getLineKey(slot1, slot2, slot3, slot4)]
end

function slot0.getObjByLineKey(slot0, slot1)
	return slot0._blockMap[slot1]
end

function slot0.getGameSize(slot0)
	return slot0._width or 0, slot0._height or 0
end

function slot0.getUIGridSize(slot0)
	return PuzzleEnum.mazeUIGridWidth, PuzzleEnum.mazeUIGridHeight
end

function slot0.getObjectAnchor(slot0, slot1, slot2)
	return slot0:getGridCenterPos(slot1 - 0.5, slot2 - 0.5)
end

function slot0.getLineObjectAnchor(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot1 + (slot3 - slot1) * 0.5 - 0.5

	if slot2 == slot4 then
		slot6 = slot2 + (slot2 - slot2) * 0.5 - 0.5
	end

	return slot0:getGridCenterPos(slot5, slot6)
end

function slot0.getLineAnchor(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot1 + (slot3 - slot1) * 0.5 - 0.5

	if slot2 == slot4 then
		slot6 = slot2 + (slot2 - slot2) * 0.5 - 0.5
	end

	return slot0:getGridCenterPos(slot5, slot6)
end

function slot0.getGridCenterPos(slot0, slot1, slot2)
	slot3, slot4 = slot0:getUIGridSize()

	return (slot0._startX + slot1) * slot3, (slot0._startY + slot2) * slot4
end

function slot0.getIntegerPosByTouchPos(slot0, slot1, slot2)
	slot3, slot4 = slot0:getUIGridSize()
	slot6 = math.floor((slot2 - (slot0._startY + 0.5) * slot4) / slot4)
	slot7, slot8 = slot0:getGameSize()
	slot9 = -1
	slot10 = -1
	slot11 = PuzzleEnum.mazeUILineWidth * 0.5

	if math.floor((slot1 - (slot0._startX + 0.5) * slot3) / slot3) >= 0 and slot5 < slot7 and slot6 >= 0 and slot6 < slot8 then
		slot10 = slot6 + 1
		slot9 = slot5 + 1
	else
		slot12 = slot5 >= 0 and slot5 < slot7 and slot5 + 1 or -1
		slot13 = slot6 >= 0 and slot6 < slot8 and slot6 + 1 or -1
		slot15 = slot2 - (slot0._startY + 0.5) * slot4

		if slot5 < 0 and slot1 - (slot0._startX + 0.5) * slot3 > -slot11 then
			slot12 = 1
		elseif slot7 <= slot5 and slot14 < slot7 * slot3 + slot0._startX + slot11 then
			slot12 = slot7
		end

		if slot6 < 0 and slot15 > -slot11 then
			slot13 = 1
		elseif slot8 <= slot6 and slot15 < slot8 * slot4 + slot0._startY + slot11 then
			slot13 = slot8
		end

		if slot12 ~= -1 and slot13 ~= -1 then
			slot10 = slot13
			slot9 = slot12
		end
	end

	return slot9, slot10
end

function slot0.getClosePosByTouchPos(slot0, slot1, slot2)
	slot3, slot4 = slot0:getUIGridSize()
	slot5, slot6 = slot0:getIntegerPosByTouchPos(slot1, slot2)

	if slot5 ~= -1 then
		slot10 = false

		if slot1 - (slot0._startX + 0.5) * slot3 >= (slot5 - 1) * slot3 + PuzzleEnum.mazeUILineWidth * 0.5 then
			if slot8 >= slot9 + slot3 - slot7 then
				slot5 = slot5 + 1
			else
				slot10 = true
			end
		end

		slot13 = false

		if slot2 - (slot0._startY + 0.5) * slot4 >= (slot6 - 1) * slot4 + slot7 then
			if slot11 >= slot12 + slot4 - slot7 then
				slot6 = slot6 + 1
			else
				slot13 = true
			end
		end

		if slot10 or slot13 then
			return -1, -1
		end
	end

	return slot5, slot6
end

function slot0.getLineFieldByTouchPos(slot0, slot1, slot2)
	slot3, slot4 = slot0:getUIGridSize()
	slot5, slot8 = slot0:getIntegerPosByTouchPos(slot1, slot2)
	slot9, slot10 = nil

	if slot5 ~= -1 then
		slot14 = false

		if slot1 - (slot0._startX + 0.5) * slot3 >= (slot5 - 1) * slot3 + PuzzleEnum.mazeUILineWidth * 0.5 then
			slot7 = slot5 + 1

			if slot13 < slot12 + slot3 - slot11 then
				slot14 = true
				slot9 = (slot13 - slot12) / slot3
			else
				slot5 = slot5 + 1
			end
		end

		slot17 = false

		if slot2 - (slot0._startY + 0.5) * slot4 >= (slot6 - 1) * slot4 + slot11 then
			slot8 = slot8 + 1

			if slot16 < slot15 + slot4 - slot11 then
				slot17 = true
				slot10 = (slot16 - slot15) / slot4
			else
				slot6 = slot6 + 1
			end
		end

		if not slot14 or not slot17 then
			return true, slot5, slot6, slot7, slot8, slot9, slot10
		end
	end

	return false
end

function slot0.getMapLineState(slot0, slot1, slot2, slot3, slot4)
	return slot0._lineMap and slot0._lineMap[PuzzleMazeHelper.getLineKey(slot1, slot2, slot3, slot4)]
end

function slot0.getAllMapLines(slot0)
	return slot0._lineMap
end

function slot0.getInteractLineCtrl(slot0, slot1, slot2, slot3, slot4)
	return slot0._interactCtrlMap and slot0._interactCtrlMap[PuzzleMazeHelper.getLineKey(slot1, slot2, slot3, slot4)]
end

function slot0.pawnIconUrl(slot0)
	return slot0._pawnIconUrl
end

function slot0.setMapLineState(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._lineMap[PuzzleMazeHelper.getLineKey(slot1, slot2, slot3, slot4)] = slot5
end

slot0.instance = slot0.New()

return slot0
