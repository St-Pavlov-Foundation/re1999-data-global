module("modules.logic.activity.controller.chessmap.step.ActivityChessStepGameFinish", package.seeall)

slot0 = class("ActivityChessStepGameFinish", ActivityChessStepBase)

function slot0.start(slot0)
	slot0:processSelectObj()
	slot0:processWinStatus()
end

function slot0.processSelectObj(slot0)
	ActivityChessGameController.instance:setSelectObj(nil)
end

function slot0.processWinStatus(slot0)
	if slot0.originData.win == true then
		logNormal("game clear!")
		ActivityChessGameController.instance:gameClear()
	else
		logNormal("game over!")

		if slot0.originData.failReason == ActivityChessEnum.FailReason.FailInteract then
			slot2 = ActivityChessGameController.instance.interacts

			if slot0.originData.failCharacter ~= 0 and slot2 then
				slot6 = "OnChessFailPause" .. Activity109ChessModel.instance:getEpisodeId() .. "_" .. (slot2:get(slot1).config and slot4.id or "")

				GuideController.instance:GuideFlowPauseAndContinue(slot6, GuideEvent[slot6], GuideEvent.OnChessFailContinue, uv0._gameOver, slot0)

				return
			end
		end

		slot0:_gameOver()
	end
end

function slot0._gameOver(slot0)
	ActivityChessGameController.instance:gameOver()
end

return slot0
