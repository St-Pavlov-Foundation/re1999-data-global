module("modules.logic.versionactivity2_3.zhixinquaner.maze.controller.ZhiXinQuanErStoryStep", package.seeall)

local var_0_0 = class("ZhiXinQuanErStoryStep", BaseWork)

function var_0_0.initData(arg_1_0, arg_1_1)
	arg_1_0._data = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	local var_2_0 = tonumber(arg_2_0._data.param)
	local var_2_1 = {}

	var_2_1.blur = true
	var_2_1.hideStartAndEndDark = true
	var_2_1.mark = true
	var_2_1.isReplay = false
	arg_2_0._initMaskActive = PostProcessingMgr.instance:getUIPPValue("LocalMaskActive")
	arg_2_0._initDistortStrength = PostProcessingMgr.instance:getUIPPValue("LocalDistortStrength")

	PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", false)
	PostProcessingMgr.instance:setUIPPValue("localDistortStrength", 0)
	StoryController.instance:playStory(var_2_0, var_2_1, arg_2_0.afterPlayStory, arg_2_0)
end

function var_0_0.afterPlayStory(arg_3_0)
	TaskDispatcher.runDelay(arg_3_0.onDoneTrue, arg_3_0, 0.3)
end

function var_0_0.onDoneTrue(arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	PostProcessingMgr.instance:setUIPPValue("LocalMaskActive", arg_5_0._initMaskActive)
	PostProcessingMgr.instance:setUIPPValue("LocalDistortStrength", arg_5_0._initDistortStrength)
	TaskDispatcher.cancelTask(arg_5_0.onDoneTrue, arg_5_0)
end

return var_0_0
