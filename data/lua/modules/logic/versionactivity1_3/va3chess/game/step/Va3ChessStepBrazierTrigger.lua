module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepBrazierTrigger", package.seeall)

slot0 = class("Va3ChessStepBrazierTrigger", Va3ChessStepBase)

function slot0.start(slot0)
	if Va3ChessGameController.instance.interacts and slot2:get(slot0.originData.brazierId) then
		if slot3.originData then
			slot3.originData:setBrazierIsLight(true)
		end

		if slot3:getHandler() and slot4.refreshBrazier then
			slot4:refreshBrazier()
			AudioMgr.instance:trigger(AudioEnum.chess_activity142.LightBrazier)
		end
	end

	Va3ChessGameModel.instance:setFireBallCount(slot0.originData.fireballNum, true)
	slot0:finish()
end

function slot0.finish(slot0)
	uv0.super.finish(slot0)
end

function slot0.dispose(slot0)
	uv0.super.dispose(slot0)
end

return slot0
