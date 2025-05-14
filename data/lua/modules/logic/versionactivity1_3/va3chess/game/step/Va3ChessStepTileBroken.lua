module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepTileBroken", package.seeall)

local var_0_0 = class("Va3ChessStepTileBroken", Va3ChessStepBase)

function var_0_0.start(arg_1_0)
	arg_1_0:processNextTileStatus()
end

function var_0_0.processNextTileStatus(arg_2_0)
	local var_2_0 = arg_2_0.originData.x
	local var_2_1 = arg_2_0.originData.y
	local var_2_2 = Va3ChessGameModel.instance:getTileMO(var_2_0, var_2_1)
	local var_2_3 = Va3ChessEnum.TileTrigger.Broken

	if var_2_2 and var_2_2:isHasTrigger(var_2_3) then
		local var_2_4
		local var_2_5 = Va3ChessEnum.TriggerStatus[var_2_3]

		if arg_2_0.originData.stepType == Va3ChessEnum.Act142StepType.TileFragile then
			var_2_4 = var_2_5.Fragile
		elseif arg_2_0.originData.stepType == Va3ChessEnum.Act142StepType.TileBroken then
			var_2_4 = var_2_5.Broken

			var_2_2:addFinishTrigger(var_2_3)
		end

		var_2_2:updateTrigger(var_2_3, var_2_4)
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.TileTriggerUpdate, var_2_0, var_2_1, var_2_3)
		TaskDispatcher.cancelTask(arg_2_0._onDelayFinish, arg_2_0)
		TaskDispatcher.runDelay(arg_2_0._onDelayFinish, arg_2_0, 0.2)
	else
		arg_2_0:_onDelayFinish()
	end
end

function var_0_0._onDelayFinish(arg_3_0)
	arg_3_0:finish()
end

function var_0_0.finish(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._onDelayFinish, arg_4_0)
	var_0_0.super.finish(arg_4_0)
end

function var_0_0.dispose(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._onDelayFinish, arg_5_0)
	var_0_0.super.dispose(arg_5_0)
end

return var_0_0
