module("modules.logic.guide.controller.action.impl.GuideActionOpenMaskHole", package.seeall)

local var_0_0 = class("GuideActionOpenMaskHole", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)
	GuideViewMgr.instance:open(arg_1_0.guideId, arg_1_0.stepId)
	arg_1_0:onDone(true)
end

function var_0_0.onDestroy(arg_2_0)
	var_0_0.super.onDestroy(arg_2_0)
	GuideViewMgr.instance:close()
end

return var_0_0
