module("modules.logic.story.view.StoryVideoItem", package.seeall)

local var_0_0 = class("StoryVideoItem")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	arg_1_0.viewGO = arg_1_1
	arg_1_0._videoName = arg_1_2
	arg_1_0._videoCo = arg_1_3
	arg_1_0._videoGo = nil
	arg_1_0._loop = arg_1_3.loop
	arg_1_0._startCallBack = arg_1_4
	arg_1_0._startCallBackObj = arg_1_5
	arg_1_0._playList = arg_1_6

	arg_1_0:_build()
end

function var_0_0.pause(arg_2_0, arg_2_1)
	if arg_2_1 then
		arg_2_0._playList:setPauseState(arg_2_0._videoName, false)
	else
		arg_2_0._playList:setPauseState(arg_2_0._videoName, true)
	end
end

function var_0_0.reset(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0.viewGO = arg_3_1
	arg_3_0._videoCo = arg_3_2
	arg_3_0._loop = arg_3_2.loop

	TaskDispatcher.cancelTask(arg_3_0._playVideo, arg_3_0)

	if arg_3_0._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_3_0:_playVideo()

		return
	end

	TaskDispatcher.runDelay(arg_3_0._playVideo, arg_3_0, arg_3_0._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0._build(arg_4_0)
	arg_4_0._videoName = string.split(arg_4_0._videoName, ".")[1]

	TaskDispatcher.cancelTask(arg_4_0._playVideo, arg_4_0)

	if arg_4_0._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_4_0:_playVideo()

		return
	end

	TaskDispatcher.runDelay(arg_4_0._playVideo, arg_4_0, arg_4_0._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0._playVideo(arg_5_0)
	StoryModel.instance:setSpecialVideoPlaying(arg_5_0._videoName)

	if arg_5_0._playList then
		arg_5_0._playList:buildAndStart(arg_5_0._videoName, arg_5_0._loop, arg_5_0._startCallBack, arg_5_0._startCallBackObj, arg_5_0)
		arg_5_0._playList:setParent(arg_5_0.viewGO)
	end
end

function var_0_0.destroyVideo(arg_6_0, arg_6_1)
	arg_6_0._videoCo = arg_6_1

	TaskDispatcher.cancelTask(arg_6_0._playVideo, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._realDestroy, arg_6_0)

	if arg_6_0._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()] < 0.1 then
		arg_6_0:_realDestroy()

		return
	end

	TaskDispatcher.runDelay(arg_6_0._realDestroy, arg_6_0, arg_6_0._videoCo.delayTimes[GameLanguageMgr.instance:getVoiceTypeStoryIndex()])
end

function var_0_0._realDestroy(arg_7_0)
	arg_7_0:onDestroy()
end

function var_0_0.onDestroy(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._realDestroy, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._playVideo, arg_8_0)
	StoryModel.instance:setSpecialVideoEnd(arg_8_0._videoName)
	arg_8_0._playList:stop(arg_8_0._videoName)
	gohelper.destroy(arg_8_0._videoGo)
end

return var_0_0
