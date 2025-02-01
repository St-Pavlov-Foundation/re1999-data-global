module("modules.logic.activity.controller.chessmap.step.ActivityChessStepInteractFinish", package.seeall)

slot0 = class("ActivityChessStepInteractFinish", ActivityChessStepBase)

function slot0.start(slot0)
	ActivityChessGameModel.instance:addFinishInteract(slot0.originData.id)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.CurrentConditionUpdate)
	slot0:finish()
end

function slot0.finish(slot0)
	uv0.super.finish(slot0)
end

return slot0
