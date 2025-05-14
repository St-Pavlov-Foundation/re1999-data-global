module("modules.logic.guide.controller.trigger.GuideTriggerOpenView", package.seeall)

local var_0_0 = class("GuideTriggerOpenView", BaseGuideTrigger)

function var_0_0.ctor(arg_1_0, arg_1_1)
	var_0_0.super.ctor(arg_1_0, arg_1_1)
	ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_1_0._onOpenView, arg_1_0)
end

function var_0_0.assertGuideSatisfy(arg_2_0, arg_2_1, arg_2_2)
	return arg_2_1 == arg_2_2
end

function var_0_0._onOpenView(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:checkStartGuide(arg_3_1)
end

return var_0_0
