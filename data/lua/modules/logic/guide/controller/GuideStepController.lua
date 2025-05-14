module("modules.logic.guide.controller.GuideStepController", package.seeall)

local var_0_0 = class("GuideStepController", BaseController)

function var_0_0.onInit(arg_1_0)
	arg_1_0._guideId = nil
	arg_1_0._stepId = nil
	arg_1_0._againGuideId = nil
	arg_1_0._actionFlow = nil
	arg_1_0._actionFlowsParallel = {}
	arg_1_0._actionBuilder = GuideActionBuilder.New()
	arg_1_0._startTime = 0
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:clearStep()
end

function var_0_0.execStep(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	GuideAudioPreloadController.instance:preload(arg_3_1)

	arg_3_0._guideId = arg_3_1
	arg_3_0._stepId = arg_3_2
	arg_3_0._againGuideId = arg_3_3

	if GuideConfig.instance:getGuideCO(arg_3_1).parallel == 1 or arg_3_0._actionFlow == nil then
		arg_3_0:_reallyStartGuide({})

		if not GuideModel.instance:isStepFinish(arg_3_1, arg_3_2) then
			local var_3_0 = arg_3_0._againGuideId > 0 and arg_3_0._againGuideId or arg_3_0._guideId

			GuideExceptionController.instance:checkStep(var_3_0, arg_3_2)
		end
	end
end

function var_0_0.clearFlow(arg_4_0, arg_4_1)
	GuideExceptionController.instance:stopCheck()

	if arg_4_0._actionFlowsParallel[arg_4_1] then
		arg_4_0._actionFlowsParallel[arg_4_1]:destroy()

		arg_4_0._actionFlowsParallel[arg_4_1] = nil
	elseif arg_4_0._actionFlow and arg_4_0._actionFlow.guideId == arg_4_1 then
		local var_4_0 = arg_4_0._actionFlow

		arg_4_0._actionFlow = nil

		var_4_0:destroy()
	end
end

function var_0_0.clearStep(arg_5_0)
	GuideExceptionController.instance:stopCheck()

	if arg_5_0._actionFlow then
		local var_5_0 = arg_5_0._actionFlow

		arg_5_0._actionFlow = nil

		var_5_0:destroy()
	end

	for iter_5_0, iter_5_1 in pairs(arg_5_0._actionFlowsParallel) do
		iter_5_1:destroy()
	end

	arg_5_0._actionFlowsParallel = {}
end

function var_0_0._reallyStartGuide(arg_6_0, arg_6_1)
	local var_6_0 = GuideConfig.instance:getGuideCO(arg_6_0._guideId)

	if var_6_0.parallel and arg_6_0._actionFlowsParallel[arg_6_0._guideId] or not var_6_0.parallel and arg_6_0._actionFlow then
		return
	end

	local var_6_1 = arg_6_0._actionBuilder:buildActionFlow(arg_6_0._guideId, arg_6_0._stepId, arg_6_0._againGuideId)

	if var_6_1 then
		if var_6_0.parallel == 1 then
			arg_6_0._actionFlowsParallel[arg_6_0._guideId] = var_6_1
		else
			arg_6_0._actionFlow = var_6_1
		end

		local var_6_2 = arg_6_0._againGuideId > 0 and arg_6_0._againGuideId or arg_6_0._guideId

		GuideController.instance:dispatchEvent(GuideEvent.StartGuideStep, var_6_2, arg_6_0._stepId)
		var_6_1:start(arg_6_1)
	else
		logNormal(string.format("<color=#FFA500>guide_%d_%d</color> has no action", arg_6_0._guideId, arg_6_0._stepId))
	end
end

function var_0_0.getActionBuilder(arg_7_0)
	return arg_7_0._actionBuilder
end

function var_0_0.getActionFlow(arg_8_0, arg_8_1)
	local var_8_0 = GuideConfig.instance:getGuideCO(arg_8_1)

	if var_8_0 and var_8_0.parallel == 1 then
		return arg_8_0._actionFlowsParallel[arg_8_1]
	else
		return arg_8_0._actionFlow
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
