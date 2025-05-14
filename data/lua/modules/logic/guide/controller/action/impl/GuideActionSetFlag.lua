module("modules.logic.guide.controller.action.impl.GuideActionSetFlag", package.seeall)

local var_0_0 = class("GuideActionSetFlag", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = string.split(arg_1_0.actionParam, "#")
	local var_1_1 = tonumber(var_1_0[1])
	local var_1_2 = var_1_0[2] == "1"
	local var_1_3 = var_1_0[3] or true

	if var_1_2 then
		GuideModel.instance:setFlag(var_1_1, var_1_3, arg_1_0.guideId)
	else
		GuideModel.instance:setFlag(var_1_1, nil, arg_1_0.guideId)
	end

	arg_1_0:onDone(true)
end

return var_0_0
