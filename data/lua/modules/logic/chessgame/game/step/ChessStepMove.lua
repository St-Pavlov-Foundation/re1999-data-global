module("modules.logic.chessgame.game.step.ChessStepMove", package.seeall)

slot0 = class("ChessStepMove", BaseWork)

function slot0.init(slot0, slot1)
	slot0.originData = slot1
end

function slot0.onStart(slot0, slot1)
	slot3 = slot0.originData.x
	slot4 = slot0.originData.y
	slot5 = slot0.originData.direction
	slot0._catchObj = slot1

	if ChessGameController.instance.interactsMgr then
		if not slot6:get(slot0.originData.id) then
			slot0:onDone(true)

			return
		end

		slot0:updatePosInfo(slot7, slot3, slot4)
		slot0:startMove(slot7, slot3, slot4)

		if slot5 ~= nil then
			slot7:getHandler():faceTo(slot5)
		end
	end
end

function slot0.updatePosInfo(slot0, slot1, slot2, slot3)
	if slot1 and slot1:getHandler() then
		slot1:getHandler():updatePos(slot2, slot3)
	else
		slot0:onDone(true)
	end
end

function slot0.startMove(slot0, slot1, slot2, slot3)
	if slot1 and slot1:getHandler() then
		AudioMgr.instance:trigger(AudioEnum.VersionActivity2_1ChessGame.play_ui_molu_jlbn_move)

		if slot1.config.interactType == ChessGameEnum.InteractType.Role then
			if slot0._catchObj then
				slot5, slot6 = slot0._catchObj.mo:getXY()

				slot1:getHandler():moveTo((slot2 + slot5) / 2, (slot3 + slot6) / 2, slot0.onMainPlayerMoveEnd, slot0)
			else
				slot1:getHandler():moveTo(slot2, slot3, slot0.onMainPlayerMoveEnd, slot0)
			end
		else
			slot1:getHandler():moveTo(slot2, slot3, slot0.onOtherObjMoveEnd, slot0)
		end
	else
		slot0:onDone(true)
	end
end

function slot0.onMainPlayerMoveEnd(slot0)
	slot0:onObjMoveEnd()
	slot0:onDone(true)
end

function slot0.onOtherObjMoveEnd(slot0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.ObjMoveEnd, slot0.originData.id, slot0.originData.x, slot0.originData.y)
	slot0:onDone(true)
end

function slot0.onObjMoveEnd(slot0)
	ChessGameController.instance:dispatchEvent(ChessGameEvent.ObjMoveEnd, slot0.originData.id, slot0.originData.x, slot0.originData.y)
end

slot0.lastEnemyMoveTime = {}
slot0.minSkipAudioTime = 0.01

function slot0.playEnemyMoveAudio(slot0, slot1)
	if slot1 and slot1 ~= 0 and Time.realtimeSinceStartup >= (uv0.lastEnemyMoveTime[slot1] or -1) then
		uv0.lastEnemyMoveTime[slot1] = slot2 + uv0.minSkipAudioTime

		AudioMgr.instance:trigger(slot1)
	end
end

return slot0
