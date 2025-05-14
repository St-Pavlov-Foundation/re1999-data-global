module("modules.logic.guide.controller.action.impl.GuideActionEnablePress", package.seeall)

local var_0_0 = class("GuideActionEnablePress", BaseGuideAction)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_0.super.ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)

	arg_1_0._isEnable = arg_1_3 == "1"
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	var_0_0.super.onStart(arg_2_0, arg_2_1)
	GuideViewMgr.instance:enablePress(arg_2_0._isEnable)
	arg_2_0:onDone(true)
end

return var_0_0
