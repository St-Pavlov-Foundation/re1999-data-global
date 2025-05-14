module("modules.logic.versionactivity2_2.tianshinana.controller.step.TianShiNaNaStoryStep", package.seeall)

local var_0_0 = class("TianShiNaNaStoryStep", TianShiNaNaStepBase)

function var_0_0.onStart(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0._data.storyId
	local var_1_1 = {}

	var_1_1.blur = true
	var_1_1.hideStartAndEndDark = true
	var_1_1.mark = true
	var_1_1.isReplay = false
	arg_1_0._initMaskActive = PostProcessingMgr.instance:getUIPPValue("LocalMaskActive")
	arg_1_0._initDistortStrength = PostProcessingMgr.instance:getUIPPValue("LocalDistortStrength")

	PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", false)
	PostProcessingMgr.instance:setUIPPValue("localDistortStrength", 0)
	StoryController.instance:playStory(var_1_0, var_1_1, arg_1_0.afterPlayStory, arg_1_0)
end

function var_0_0.afterPlayStory(arg_2_0)
	TaskDispatcher.runDelay(arg_2_0.onDoneTrue, arg_2_0, 0.3)
end

function var_0_0.onDoneTrue(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", arg_4_0._initMaskActive)
	PostProcessingMgr.instance:setUIPPValue("LocalDistortStrength", arg_4_0._initDistortStrength)
	TaskDispatcher.cancelTask(arg_4_0.onDoneTrue, arg_4_0)
end

return var_0_0
