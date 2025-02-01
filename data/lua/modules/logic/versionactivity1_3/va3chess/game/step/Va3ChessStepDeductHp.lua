module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepDeductHp", package.seeall)

slot0 = class("Va3ChessStepDeductHp", Va3ChessStepBase)

function slot0.start(slot0)
	slot0:finish()
end

function slot0.finish(slot0)
	if Va3ChessGameController.instance.event then
		slot1:setCurEvent(nil)
	end

	Va3ChessGameModel.instance:setHp(slot0.originData.hp)
	Va3ChessGameController.instance:tryResumeSelectObj()
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.CurrentHpUpdate)
	uv0.super.finish(slot0)
end

return slot0
