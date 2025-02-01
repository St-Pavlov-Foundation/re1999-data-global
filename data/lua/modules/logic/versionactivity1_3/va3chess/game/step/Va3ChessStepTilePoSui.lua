module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepTilePoSui", package.seeall)

slot0 = class("Va3ChessStepTilePoSui", Va3ChessStepBase)

function slot0.start(slot0)
	slot0:processNextTileStatus()
end

function slot0.processNextTileStatus(slot0)
	if Va3ChessGameModel.instance:getTileMO(slot0.originData.x, slot0.originData.y) and slot1:isHasTrigger(Va3ChessEnum.TileTrigger.PoSui) then
		slot1:addFinishTrigger(Va3ChessEnum.TileTrigger.PoSui)
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.TilePosuiTrigger, slot0.originData.x, slot0.originData.y)
		TaskDispatcher.cancelTask(slot0._onDelayFinish, slot0)
		TaskDispatcher.runDelay(slot0._onDelayFinish, slot0, 0.2)
	else
		slot0:_onDelayFinish()
	end
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
