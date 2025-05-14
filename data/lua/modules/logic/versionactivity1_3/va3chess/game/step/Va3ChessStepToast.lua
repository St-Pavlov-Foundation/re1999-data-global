module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepToast", package.seeall)

local var_0_0 = class("Va3ChessStepToast", Va3ChessStepBase)

function var_0_0.start(arg_1_0)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.GameToastUpdate, arg_1_0.originData.tipsId)
	TaskDispatcher.cancelTask(arg_1_0._onDelayFinish, arg_1_0)
	TaskDispatcher.runDelay(arg_1_0._onDelayFinish, arg_1_0, 0.2)
end

function var_0_0._onDelayFinish(arg_2_0)
	arg_2_0:finish()
end

function var_0_0.finish(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._onDelayFinish, arg_3_0)
	var_0_0.super.finish(arg_3_0)
end

function var_0_0.dispose(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._onDelayFinish, arg_4_0)
	var_0_0.super.dispose(arg_4_0)
end

return var_0_0
