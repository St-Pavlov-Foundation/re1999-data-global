module("modules.logic.versionactivity2_3.zhixinquaner.maze.controller.PuzzleMazeDrawController", package.seeall)

slot0 = class("PuzzleMazeDrawController", PuzzleMazeDrawBaseController)

function slot0.openGame(slot0, slot1)
	slot0:setModelInst(PuzzleMazeDrawModel.instance)
	uv0.super.openGame(slot0, slot1)
	ViewMgr.instance:openView(ViewName.PuzzleMazeDrawView)
end

function slot0.interactSwitchObj(slot0, slot1, slot2)
	PuzzleMazeDrawModel.instance:setCanFlyPane(false)
	PuzzleMazeDrawModel.instance:setPlanePlacePos(slot1, slot2)
	PuzzleMazeDrawModel.instance:switchLine(PuzzleEnum.LineState.Switch_On, slot1, slot2)
	uv0.instance:dispatchEvent(PuzzleEvent.SimulatePlane, slot1, slot2)
end

function slot0.recyclePlane(slot0)
	slot1, slot2 = PuzzleMazeDrawModel.instance:getCurPlanePos()

	PuzzleMazeDrawModel.instance:switchLine(PuzzleEnum.LineState.Switch_Off, slot1, slot2)
	PuzzleMazeDrawModel.instance:setCanFlyPane(true)
	uv0.instance:dispatchEvent(PuzzleEvent.RecyclePlane)
end

function slot0.processPath(slot0, slot1, slot2, slot3)
	for slot7, slot8 in ipairs(slot1) do
		slot9 = slot8[1]
		slot13 = nil

		if not slot0:isBackward(slot8[2], slot8[3]) then
			for slot17, slot18 in pairs(slot0._alertMoMap) do
				return false
			end

			slot13 = 1
		end

		if PuzzleMazeDrawModel.instance:getObjAtLine(slot0._curPosX, slot0._curPosY, slot10, slot11) ~= nil and slot15.objType == PuzzleEnum.MazeObjType.Block then
			slot0._alertMoMap[PuzzleMazeHelper.getLineKey(slot0._curPosX, slot0._curPosY, slot10, slot11)] = PuzzleEnum.MazeAlertType.VisitBlock
		end

		if slot12 then
			slot0._alertMoMap[PuzzleMazeHelper.getPosKey(slot0._curPosX, slot0._curPosY)] = nil
			slot0._alertMoMap[PuzzleMazeHelper.getLineKey(slot0._curPosX, slot0._curPosY, slot10, slot11)] = nil

			if PuzzleMazeDrawModel.instance:getObjAtPos(slot0._curPosX, slot0._curPosY) ~= nil and slot15.objType == PuzzleEnum.MazeObjType.CheckPoint and not slot0:alreadyPassed(slot0._curPosX, slot0._curPosY, true) then
				slot0._passedCheckPoint[slot15] = slot13
			end
		else
			if not slot0:canPassLine(slot10, slot11) then
				slot0._alertMoMap[slot14] = PuzzleEnum.MazeAlertType.DisconnectLine
			elseif slot0:alreadyPassed(slot10, slot11) then
				slot0._alertMoMap[PuzzleMazeHelper.getPosKey(slot10, slot11)] = PuzzleEnum.MazeAlertType.VisitRepeat
			end

			if PuzzleMazeDrawModel.instance:getObjAtPos(slot10, slot11) ~= nil and slot15.objType == PuzzleEnum.MazeObjType.CheckPoint then
				slot0._passedCheckPoint[slot15] = slot13
			end
		end

		if slot12 then
			slot0._passedPosX[#slot0._passedPosX] = nil
			slot0._passedPosY[#slot0._passedPosY] = nil
		else
			table.insert(slot0._passedPosX, slot10)
			table.insert(slot0._passedPosY, slot11)
		end

		slot0._curPosX = slot10
		slot0._curPosY = slot11
		slot0._nextDir = slot9
		slot0._lineDirty = true
	end

	return true
end

function slot0.canPassLine(slot0, slot1, slot2)
	return PuzzleMazeDrawModel.instance:getMapLineState(slot0._curPosX, slot0._curPosY, slot1, slot2) ~= PuzzleEnum.LineState.Disconnect and slot3 ~= PuzzleEnum.LineState.Switch_Off
end

function slot0.savePuzzleProgress(slot0)
	if not PuzzleMazeDrawModel.instance:getElementCo() then
		return
	end

	if slot0:hasAlertObj() then
		return
	end

	slot3, slot4 = slot0:getPassedPoints()
	slot5, slot6 = PuzzleMazeDrawModel.instance:getInteractPos()

	if slot5 and slot6 then
		-- Nothing
	end

	DungeonRpc.instance:sendSavePuzzleProgressRequest(slot1.id, cjson.encode({
		passX = slot3,
		passY = slot4,
		interactPosX = slot5,
		interactPosY = slot6
	}))
end

function slot0.getPuzzleDrawProgress(slot0)
	if not PuzzleMazeDrawModel.instance:getElementCo() then
		return
	end

	DungeonRpc.instance:sendGetPuzzleProgressRequest(slot1.id)
end

function slot0.onGetPuzzleDrawProgress(slot0, slot1, slot2)
	if string.nilorempty(slot2) then
		return
	end

	if cjson.decode(slot2).interactPosX and slot3.interactPosY then
		slot0:interactSwitchObj(slot3.interactPosX, slot3.interactPosY)
	end

	for slot8 = 1, slot3.passX and #slot3.passX or 0 do
		slot9 = slot3.passX[slot8]
		slot10 = slot3.passY[slot8]
		slot12 = slot3.passY[slot8 - 1]
		slot13 = false

		if slot3.passX[slot8 - 1] ~= nil and slot0._modelInst:getMapLineState(slot11, slot12, slot9, slot10) == PuzzleEnum.LineState.Switch_Off then
			slot0._modelInst:setMapLineState(slot11, slot12, slot9, slot10, PuzzleEnum.LineState.Switch_On)

			slot13 = true
		end

		slot0:goPassPos(slot9, slot10)

		if slot13 then
			slot0._modelInst:setMapLineState(slot11, slot12, slot9, slot10, PuzzleEnum.LineState.Switch_Off)
		end
	end
end

function slot0.hasAlertObj(slot0)
	for slot4, slot5 in pairs(slot0._alertMoMap) do
		return true
	end

	if (slot0._passedPosX and #slot0._passedPosX or 0) >= 2 and not slot0._modelInst:getObjAtPos(slot0._passedPosX and slot0._passedPosX[slot1], slot0._passedPosY and slot0._passedPosY[slot1]) then
		return true
	end

	return false
end

function slot0.goBackPos(slot0)
	if #slot0._passedPosX >= 2 then
		slot5 = slot0._passedPosY[slot1 - 1]

		slot0:goPassPos(slot0._passedPosX[slot1 - 1], slot5)

		for slot5 = slot1 - 1, 2, -1 do
			if slot0._modelInst:getObjAtPos(slot0._passedPosX[slot5], slot0._passedPosY[slot5]) then
				break
			end

			slot0:goPassPos(slot0._passedPosX[slot5 - 1], slot0._passedPosY[slot5 - 1])
		end
	end
end

function slot0.restartGame(slot0)
	uv0.super.restartGame(slot0)
	slot0._modelInst:setTriggerEffectDoneMap(slot0._modelInst:getTriggerEffectDoneMap())
end

slot0.instance = slot0.New()

LuaEventSystem.addEventMechanism(slot0.instance)

return slot0
