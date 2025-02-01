module("modules.logic.activity.controller.chessmap.step.ActivityChessStepMove", package.seeall)

slot0 = class("ActivityChessStepMove", ActivityChessStepBase)

function slot0.start(slot0)
	slot4 = slot0.originData.direction

	if ActivityChessGameController.instance.interacts then
		slot0:startMove(slot5:get(slot0.originData.id), slot0.originData.x, slot0.originData.y)

		if slot4 ~= nil then
			slot6:getHandler():faceTo(slot4)
		end
	end
end

function slot0.startMove(slot0, slot1, slot2, slot3)
	if slot1 and slot1:getHandler() then
		ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetAlwayUpdateRenderOrder, true)

		if slot1.config.interactType == ActivityChessEnum.InteractType.Player then
			slot1:getHandler():moveTo(slot2, slot3, slot0.finish, slot0)
			AudioMgr.instance:trigger(AudioEnum.ChessGame.PlayerMove)
		else
			slot1:getHandler():moveTo(slot2, slot3)

			slot5 = ActivityChessGameController.instance.event

			slot0:playEnemyMoveAudio()
			slot0:finish()
		end
	else
		slot0:finish()
	end
end

slot0.lastEnemyMoveTime = nil
slot0.minSkipAudioTime = 0.01

function slot0.playEnemyMoveAudio(slot0)
	if not (uv0.lastEnemyMoveTime ~= nil and Time.realtimeSinceStartup - uv0.lastEnemyMoveTime <= uv0.minSkipAudioTime) then
		AudioMgr.instance:trigger(AudioEnum.ChessGame.EnemyMove)

		uv0.lastEnemyMoveTime = slot1
	end
end

function slot0.finish(slot0)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.SetAlwayUpdateRenderOrder, false)
	uv0.super.finish(slot0)
end

return slot0
