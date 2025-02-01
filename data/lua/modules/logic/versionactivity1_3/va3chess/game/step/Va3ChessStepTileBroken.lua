module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepTileBroken", package.seeall)

slot0 = class("Va3ChessStepTileBroken", Va3ChessStepBase)

function slot0.start(slot0)
	slot0:processNextTileStatus()
end

function slot0.processNextTileStatus(slot0)
	slot4 = Va3ChessEnum.TileTrigger.Broken

	if Va3ChessGameModel.instance:getTileMO(slot0.originData.x, slot0.originData.y) and slot3:isHasTrigger(slot4) then
		slot5 = nil

		if slot0.originData.stepType == Va3ChessEnum.Act142StepType.TileFragile then
			slot5 = Va3ChessEnum.TriggerStatus[slot4].Fragile
		elseif slot0.originData.stepType == Va3ChessEnum.Act142StepType.TileBroken then
			slot5 = slot6.Broken

			slot3:addFinishTrigger(slot4)
		end

		slot3:updateTrigger(slot4, slot5)
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.TileTriggerUpdate, slot1, slot2, slot4)
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
