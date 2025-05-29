module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepHpUpdate", package.seeall)

local var_0_0 = class("XugoujiGameStepHpUpdate", XugoujiGameStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0._stepData.isSelf
	local var_1_1 = arg_1_0._stepData.hpChange

	Activity188Model.instance:updateHp(var_1_0, var_1_1)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.HpUpdated)
	arg_1_0:finish()
end

function var_0_0.dispose(arg_2_0)
	TaskDispatcher.cancelTask(arg_2_0.finish, arg_2_0)
	XugoujiGameStepBase.dispose(arg_2_0)
end

return var_0_0
