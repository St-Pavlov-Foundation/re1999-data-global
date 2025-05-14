module("modules.logic.guide.controller.GuideAudioPreloadController", package.seeall)

local var_0_0 = class("GuideAudioPreloadController", BaseController)
local var_0_1 = {
	[106] = true,
	[206] = true,
	[104] = true,
	[205] = true,
	[101] = true
}

function var_0_0.addConstEvents(arg_1_0)
	GuideController.instance:registerCallback(GuideEvent.GuideEvent.StartGuideStep, arg_1_0._onStartGuideStep, arg_1_0)
	GuideController.instance:registerCallback(GuideEvent.GuideEvent.FinishGuideLastStep, arg_1_0._onFinishGuide, arg_1_0)
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._preloadGuideIdDict = {}
end

function var_0_0.reInit(arg_3_0)
	for iter_3_0, iter_3_1 in pairs(arg_3_0._preloadGuideIdDict) do
		arg_3_0:unload(iter_3_0)
	end

	arg_3_0._preloadGuideIdDict = {}
end

function var_0_0._onStartGuideStep(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:preload(arg_4_1)
end

function var_0_0._onFinishGuide(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:unload(arg_5_1)
end

function var_0_0.preload(arg_6_0, arg_6_1)
	if not var_0_1[arg_6_1] then
		return
	end

	if arg_6_0._preloadGuideIdDict[arg_6_1] then
		return
	end

	local var_6_0 = {}

	arg_6_0._preloadGuideIdDict[arg_6_1] = var_6_0

	local var_6_1 = GuideConfig.instance:getStepList(arg_6_1)

	for iter_6_0, iter_6_1 in ipairs(var_6_1) do
		local var_6_2 = AudioConfig.instance:getAudioCOById(iter_6_1.audio)

		if iter_6_1.audio > 0 and var_6_2 then
			var_6_0[var_6_2.bankName] = true
		end
	end

	for iter_6_2, iter_6_3 in pairs(var_6_0) do
		ZProj.AudioManager.Instance:LoadBank(iter_6_2)
	end
end

function var_0_0.unload(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0._preloadGuideIdDict[arg_7_1]

	if var_7_0 then
		arg_7_0._preloadGuideIdDict[arg_7_1] = nil

		for iter_7_0, iter_7_1 in pairs(var_7_0) do
			ZProj.AudioManager.Instance:UnloadBank(iter_7_0)
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
