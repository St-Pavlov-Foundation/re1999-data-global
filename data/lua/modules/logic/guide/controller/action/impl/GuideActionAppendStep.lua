module("modules.logic.guide.controller.action.impl.GuideActionAppendStep", package.seeall)

local var_0_0 = class("GuideActionAppendStep", BaseGuideAction)

function var_0_0.onStart(arg_1_0, arg_1_1)
	var_0_0.super.onStart(arg_1_0, arg_1_1)

	local var_1_0 = arg_1_0.guideId
	local var_1_1 = string.split(arg_1_0.actionParam, "#")
	local var_1_2 = tonumber(var_1_1[1])
	local var_1_3 = string.split(var_1_1[2], "_")
	local var_1_4 = GuideStepController.instance:getActionFlow(arg_1_0.sourceGuideId or var_1_0)
	local var_1_5 = GuideStepController.instance:getActionBuilder()

	for iter_1_0, iter_1_1 in ipairs(var_1_3) do
		local var_1_6 = tonumber(iter_1_1)

		var_1_5:addActionToFlow(var_1_4, var_1_2, var_1_6, true)
	end

	if var_1_4 then
		local var_1_7 = var_1_4:getWorkList()

		if var_1_7 then
			for iter_1_2, iter_1_3 in pairs(var_1_7) do
				iter_1_3.sourceGuideId = var_1_0
			end
		end
	end

	arg_1_0:onDone(true)
end

return var_0_0
