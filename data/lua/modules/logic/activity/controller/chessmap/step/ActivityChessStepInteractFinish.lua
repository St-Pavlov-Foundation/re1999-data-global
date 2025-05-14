module("modules.logic.activity.controller.chessmap.step.ActivityChessStepInteractFinish", package.seeall)

local var_0_0 = class("ActivityChessStepInteractFinish", ActivityChessStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0.originData.id

	ActivityChessGameModel.instance:addFinishInteract(var_1_0)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.CurrentConditionUpdate)
	arg_1_0:finish()
end

function var_0_0.finish(arg_2_0)
	var_0_0.super.finish(arg_2_0)
end

return var_0_0
