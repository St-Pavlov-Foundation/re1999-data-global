module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepMove", package.seeall)

slot0 = class("Va3ChessStepMove", Va3ChessStepBase)

function slot0.start(slot0)
	slot1 = slot0.originData.id
	slot2 = slot0.originData.x
	slot3 = slot0.originData.y
	slot4 = slot0.originData.direction

	if Va3ChessGameController.instance.interacts then
		slot6 = slot5:get(slot1)

		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.ObjMoveStep, slot1, slot2, slot3)
		slot0:updatePosInfo(slot6, slot2, slot3)
		slot0:startMove(slot6, slot2, slot3)

		if slot4 ~= nil then
			slot6:getHandler():faceTo(slot4)
		end
	end
end

function slot0.updatePosInfo(slot0, slot1, slot2, slot3)
	if slot1 and slot1:getHandler() then
		slot1:getHandler():updatePos(slot2, slot3)
	else
		slot0:finish()
	end
end

function slot0.startMove(slot0, slot1, slot2, slot3)
	if slot1 and slot1:getHandler() then
		slot4 = slot1.config.interactType

		if slot1.config and slot1.config.moveAudioId and slot5 ~= 0 then
			slot0:playEnemyMoveAudio(slot5)
		end

		if slot4 == Va3ChessEnum.InteractType.Player or slot4 == Va3ChessEnum.InteractType.AssistPlayer then
			slot1:getHandler():moveTo(slot2, slot3, slot0.onMainPlayerMoveEnd, slot0)
		else
			slot1:getHandler():moveTo(slot2, slot3, slot0.onOtherObjMoveEnd, slot0)
		end
	else
		slot0:finish()
	end
end

function slot0.onMainPlayerMoveEnd(slot0)
	slot0:onObjMoveEnd()
	slot0:finish()
end

function slot0.onOtherObjMoveEnd(slot0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.ObjMoveEnd, slot0.originData.id, slot0.originData.x, slot0.originData.y)
	slot0:finish()
end

function slot0.onObjMoveEnd(slot0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.ObjMoveEnd, slot0.originData.id, slot0.originData.x, slot0.originData.y)
end

slot0.lastEnemyMoveTime = {}
slot0.minSkipAudioTime = 0.01

function slot0.playEnemyMoveAudio(slot0, slot1)
	if slot1 and slot1 ~= 0 and Time.realtimeSinceStartup >= (uv0.lastEnemyMoveTime[slot1] or -1) then
		uv0.lastEnemyMoveTime[slot1] = slot2 + uv0.minSkipAudioTime

		AudioMgr.instance:trigger(slot1)
	end
end

function slot0.finish(slot0)
	uv0.super.finish(slot0)
end

return slot0
