module("modules.logic.guide.controller.action.impl.GuideActionOpenView", package.seeall)

local var_0_0 = class("GuideActionOpenView", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.split(arg_1_0.actionParam, "#")
	local var_1_1 = var_1_0[1]
	local var_1_2 = not string.nilorempty(var_1_0[2]) and cjson.decode(var_1_0[2]) or nil
	local var_1_3 = {}

	var_1_3.openFromGuide = true
	var_1_3.guideId = arg_1_0.guideId
	var_1_3.stepId = arg_1_0.stepId
	var_1_3.viewParam = var_1_2

	ViewMgr.instance:openView(var_1_1, var_1_3, true)
	arg_1_0:onDone(true)
end

return var_0_0
