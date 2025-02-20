module("modules.logic.versionactivity2_3.zhixinquaner.maze.model.PuzzleMazeDrawModel", package.seeall)

slot0 = class("PuzzleMazeDrawModel", PuzzleMazeDrawBaseModel)

function slot0.release(slot0)
	uv0.super.release(slot0)

	slot0._interactPosX = nil
	slot0._interactPosY = nil
	slot0._effectDoneMap = nil
	slot0._canFlyPlane = true
	slot0._planePosX = nil
	slot0._planePosY = nil
end

function slot0.startGame(slot0, slot1)
	uv0.super.startGame(slot0, slot1)
	slot0:setCanFlyPane(true)
end

function slot0.switchLine(slot0, slot1, slot2, slot3)
	if not slot0:getInteractLines(slot2, slot3) then
		return
	end

	for slot8, slot9 in pairs(slot4) do
		slot10 = slot9.x1
		slot11 = slot9.y1
		slot12 = slot9.x2
		slot13 = slot9.y2
		slot0._lineMap[PuzzleMazeHelper.getLineKey(slot10, slot11, slot12, slot13)] = slot1

		PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.SwitchLineState, slot10, slot11, slot12, slot13)
	end

	if slot1 == PuzzleEnum.LineState.Connect then
		slot0._interactPosX = slot2
		slot0._interactPosY = slot3
	else
		slot0._interactPosX = nil
		slot0._interactPosY = nil
	end
end

function slot0.getInteractLines(slot0, slot1, slot2)
	if slot0:getObjAtPos(slot1, slot2) then
		return slot3.interactLines
	end
end

function slot0.getInteractPos(slot0)
	return slot0._interactPosX, slot0._interactPosY
end

function slot0.isCanFlyPlane(slot0)
	return slot0._canFlyPlane
end

function slot0.setCanFlyPane(slot0, slot1)
	slot0._canFlyPlane = slot1
end

function slot0.setPlanePlacePos(slot0, slot1, slot2)
	slot0._planePosX = slot1
	slot0._planePosY = slot2
end

function slot0.getCurPlanePos(slot0)
	if slot0:isCanFlyPlane() then
		return PuzzleMazeDrawController.instance:getLastPos()
	else
		return slot0._planePosX, slot0._planePosY
	end
end

function slot0.setTriggerEffectDone(slot0, slot1, slot2)
	slot0._effectDoneMap = slot0._effectDoneMap or {}
	slot0._effectDoneMap[PuzzleMazeHelper.getPosKey(slot1, slot2)] = true
end

function slot0.hasTriggerEffect(slot0, slot1, slot2)
	return slot0._effectDoneMap and slot0._effectDoneMap[PuzzleMazeHelper.getPosKey(slot1, slot2)]
end

function slot0.canTriggerEffect(slot0, slot1, slot2)
	if slot0:hasTriggerEffect(slot1, slot2) then
		return false
	end

	if not slot0:getObjAtPos(slot1, slot2) then
		return false
	end

	return (slot0._effectDoneMap and tabletool.len(slot0._effectDoneMap) or 0) + 1 == slot4.priority
end

function slot0.getTriggerEffectDoneMap(slot0)
	return slot0._effectDoneMap
end

function slot0.setTriggerEffectDoneMap(slot0, slot1)
	slot0._effectDoneMap = slot1
end

slot0.instance = slot0.New()

return slot0
