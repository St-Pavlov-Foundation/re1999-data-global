module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepTilePoSui", package.seeall)

local var_0_0 = class("Va3ChessStepTilePoSui", Va3ChessStepBase)

function var_0_0.start(arg_1_0)
	arg_1_0:processNextTileStatus()
end

function var_0_0.processNextTileStatus(arg_2_0)
	local var_2_0 = Va3ChessGameModel.instance:getTileMO(arg_2_0.originData.x, arg_2_0.originData.y)

	if var_2_0 and var_2_0:isHasTrigger(Va3ChessEnum.TileTrigger.PoSui) then
		var_2_0:addFinishTrigger(Va3ChessEnum.TileTrigger.PoSui)
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.TilePosuiTrigger, arg_2_0.originData.x, arg_2_0.originData.y)
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
