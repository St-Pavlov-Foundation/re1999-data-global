module("modules.logic.guide.controller.exception.GuideExceptionHandler", package.seeall)

local var_0_0 = _M

function var_0_0.finishStep(arg_1_0, arg_1_1)
	GuideController.instance:finishStep(arg_1_0, arg_1_1, true)
end

function var_0_0.finishGuide(arg_2_0, arg_2_1, arg_2_2)
	GuideController.instance:oneKeyFinishGuide(arg_2_0, true)
end

function var_0_0.gotoStep(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = GuideModel.instance:getById(arg_3_0)
	local var_3_1 = tonumber(arg_3_2)
	local var_3_2
	local var_3_3
	local var_3_4 = GuideConfig.instance:getStepList(arg_3_0)

	for iter_3_0 = #var_3_4, 1, -1 do
		local var_3_5 = var_3_4[iter_3_0]
		local var_3_6 = var_3_5.stepId

		if var_3_6 == var_3_0.currStepId then
			if var_3_5.keyStep == 1 then
				var_3_3 = var_3_6
			end

			break
		elseif var_3_2 then
			if var_3_5.keyStep == 1 then
				var_3_3 = var_3_6

				break
			end
		elseif var_3_6 == var_3_1 then
			var_3_2 = true
		end
	end

	if var_3_3 then
		var_3_0:toGotoStep(var_3_1)
		GuideRpc.instance:sendFinishGuideRequest(arg_3_0, var_3_3)
	else
		var_3_0:gotoStep(var_3_1)
		GuideStepController.instance:clearFlow(arg_3_0)
		GuideController.instance:execNextStep(arg_3_0)
	end
end

function var_0_0.openView(arg_4_0, arg_4_1, arg_4_2)
	ViewMgr.instance:openView(arg_4_2)
end

function var_0_0.closeView(arg_5_0, arg_5_1, arg_5_2)
	ViewMgr.instance:closeView(arg_5_2, true)
end

return var_0_0
