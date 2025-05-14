module("modules.logic.guide.controller.trigger.MainViewGuideCondition", package.seeall)

local var_0_0 = class("MainViewGuideCondition")
local var_0_1 = 19701

function var_0_0.getCondition(arg_1_0)
	return var_0_0.guideConditions[arg_1_0]
end

function var_0_0._checkRougeOpen()
	local var_2_0 = RougeOutsideModel.instance:isUnlock()
	local var_2_1 = GuideModel.instance:isDoingClickGuide()

	return var_2_0 and not var_2_1
end

var_0_0.guideConditions = {
	[var_0_1] = var_0_0._checkRougeOpen
}

return var_0_0
