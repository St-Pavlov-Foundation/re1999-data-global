module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepInteractFinish", package.seeall)

slot0 = class("Va3ChessStepInteractFinish", Va3ChessStepBase)

function slot0.start(slot0)
	Va3ChessGameModel.instance:addFinishInteract(slot0.originData.id)

	if slot0.originData.finishedId then
		Va3ChessGameModel.instance:addAllMapFinishInteract(slot2)
	end

	TaskDispatcher.cancelTask(slot0._onDelayFinish, slot0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.CurrentConditionUpdate)
	TaskDispatcher.runDelay(slot0._onDelayFinish, slot0, 0.2)
end

function slot0._onDelayFinish(slot0)
	slot0:finish()
end

function slot0.finish(slot0)
	TaskDispatcher.cancelTask(slot0._onDelayFinish, slot0)
	uv0.super.finish(slot0)
end

function slot0.dispose(slot0)
	TaskDispatcher.cancelTask(slot0._onDelayFinish, slot0)
	uv0.super.dispose(slot0)
end

return slot0
