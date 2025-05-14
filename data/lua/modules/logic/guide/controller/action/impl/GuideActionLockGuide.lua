module("modules.logic.guide.controller.action.impl.GuideActionLockGuide", package.seeall)

local var_0_0 = class("GuideActionLockGuide", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.splitToNumber(arg_1_0.actionParam, "#")
	local var_1_1 = var_1_0[1] == 0
	local var_1_2 = var_1_0[2] == 1

	if not var_1_1 then
		GuideModel.instance:setLockGuide(arg_1_0.guideId, var_1_2)
	else
		GuideModel.instance:setLockGuide(nil, var_1_2)
	end

	arg_1_0:onDone(true)
end

return var_0_0
