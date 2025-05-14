module("modules.logic.guide.controller.action.impl.GuideActionOpenHelpView", package.seeall)

local var_0_0 = class("GuideActionOpenHelpView", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = tonumber(arg_1_0.actionParam)
	local var_1_1 = {}

	var_1_1.openFromGuide = true
	var_1_1.guideId = arg_1_0.guideId
	var_1_1.stepId = arg_1_0.stepId
	var_1_1.viewParam = var_1_0
	var_1_1.matchAllPage = true

	ViewMgr.instance:openView(ViewName.HelpView, var_1_1)
	arg_1_0:onDone(true)
end

return var_0_0
