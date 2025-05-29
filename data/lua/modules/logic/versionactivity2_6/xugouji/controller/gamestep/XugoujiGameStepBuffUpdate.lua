module("modules.logic.versionactivity2_6.xugouji.controller.gamestep.XugoujiGameStepBuffUpdate", package.seeall)

local var_0_0 = class("XugoujiGameStepBuffUpdate", XugoujiGameStepBase)

function var_0_0.start(arg_1_0)
	local var_1_0 = arg_1_0._stepData.isSelf
	local var_1_1 = arg_1_0._stepData.buffs

	Activity188Model.instance:setBuffs(var_1_1, var_1_0)
	XugoujiController.instance:dispatchEvent(XugoujiEvent.BuffUpdated, var_1_0)
	arg_1_0:finish()
end

function var_0_0.finish(arg_2_0)
	var_0_0.super.finish(arg_2_0)
end

return var_0_0
