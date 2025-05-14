module("modules.logic.guide.controller.action.impl.GuideActionEmptyStep", package.seeall)

local var_0_0 = class("GuideActionEmptyStep", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	arg_1_0:onDone(true)
end

return var_0_0
