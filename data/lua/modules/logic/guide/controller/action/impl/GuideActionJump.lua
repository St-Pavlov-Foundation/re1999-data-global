module("modules.logic.guide.controller.action.impl.GuideActionJump", package.seeall)

local var_0_0 = class("GuideActionJump", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0.actionParam

	JumpController.instance:jumpByParam(var_1_0)
	arg_1_0:onDone(true)
end

return var_0_0
