module("modules.logic.story.view.StoryActivityVideoItem", package.seeall)

local var_0_0 = class("StoryActivityVideoItem")

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0.viewGO = arg_1_1
end

function var_0_0.playVideo(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_1 then
		arg_2_0._videoName = string.split(arg_2_1, ".")[1]
	else
		arg_2_0._videoName = nil
	end

	arg_2_2 = arg_2_2 or {}
	arg_2_0._loop = arg_2_2.loop
	arg_2_0._videoStartCallback = arg_2_2.startCallback
	arg_2_0._videoStartCallbackObj = arg_2_2.startCallbackObj
	arg_2_0._videoOutCallback = arg_2_2.outCallback
	arg_2_0._videoOutCallbackObj = arg_2_2.outCallbackObj
	arg_2_0._audioId = arg_2_2.audioId
	arg_2_0._audioNoStopByFinish = arg_2_2.audioNoStopByFinish

	if arg_2_0._videoName then
		if not arg_2_0._videoGo then
			arg_2_0:_build()
		end

		arg_2_0:_playVideo()
	else
		arg_2_0:onVideoStart()
	end
end

function var_0_0._build(arg_3_0)
	arg_3_0._videoGo = gohelper.create2d(arg_3_0.viewGO, arg_3_0._videoName)
	arg_3_0._avProVideoPlayer = gohelper.onceAddComponent(arg_3_0._videoGo, typeof(ZProj.AvProUGUIPlayer))
	arg_3_0._displauUGUI = gohelper.onceAddComponent(arg_3_0._videoGo, typeof(RenderHeads.Media.AVProVideo.DisplayUGUI))
	arg_3_0._displauUGUI.ScaleMode = UnityEngine.ScaleMode.ScaleAndCrop

	arg_3_0._avProVideoPlayer:AddDisplayUGUI(arg_3_0._displauUGUI)
	arg_3_0._avProVideoPlayer:SetEventListener(arg_3_0._onVideoEvent, arg_3_0)
	recthelper.setSize(arg_3_0._videoGo.transform, 2592, 1080)
end

function var_0_0._playVideo(arg_4_0)
	gohelper.setActive(arg_4_0._videoGo, true)

	local var_4_0 = langVideoUrl(arg_4_0._videoName)

	arg_4_0._avProVideoPlayer:LoadMedia(var_4_0)
	StoryModel.instance:setSpecialVideoPlaying(arg_4_0._videoName)
	TaskDispatcher.runDelay(arg_4_0._startVideo, arg_4_0, 0.1)

	if BootNativeUtil.isIOS() then
		TaskDispatcher.runRepeat(arg_4_0._detectPause, arg_4_0, 0.05)
	end
end

function var_0_0._startVideo(arg_5_0)
	arg_5_0._avProVideoPlayer:Play(arg_5_0._displauUGUI, arg_5_0._loop)
end

function var_0_0.onVideoStart(arg_6_0)
	if arg_6_0._audioId then
		AudioEffectMgr.instance:playAudio(arg_6_0._audioId)
	end

	if arg_6_0._videoStartCallback then
		arg_6_0._videoStartCallback(arg_6_0._videoStartCallbackObj)
	end
end

function var_0_0.onVideoOut(arg_7_0, arg_7_1)
	arg_7_0:hide(arg_7_1)

	if arg_7_0._videoOutCallback then
		arg_7_0._videoOutCallback(arg_7_0._videoOutCallbackObj)
	end
end

function var_0_0._onVideoEvent(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	if arg_8_3 ~= AvProEnum.ErrorCode.None then
		arg_8_0:hide(true)
	end

	if arg_8_2 == AvProEnum.PlayerStatus.FirstFrameReady then
		arg_8_0:onVideoStart()
	end

	if arg_8_2 == AvProEnum.PlayerStatus.FinishedPlaying then
		arg_8_0:onVideoOut(true)
	end
end

function var_0_0.hide(arg_9_0, arg_9_1)
	if arg_9_0._avProVideoPlayer then
		arg_9_0._avProVideoPlayer:Stop()
	end

	if BootNativeUtil.isIOS() then
		TaskDispatcher.cancelTask(arg_9_0._detectPause, arg_9_0)
	end

	if arg_9_1 then
		if not arg_9_0._audioNoStopByFinish then
			arg_9_0:stopAudio()
		end
	else
		arg_9_0:stopAudio()
	end

	gohelper.setActive(arg_9_0._videoGo, false)
end

function var_0_0._detectPause(arg_10_0)
	if arg_10_0._avProVideoPlayer:IsPaused() then
		arg_10_0._avProVideoPlayer:Play()
	end
end

function var_0_0.stopAudio(arg_11_0)
	if arg_11_0._audioId then
		AudioEffectMgr.instance:stopAudio(arg_11_0._audioId)

		arg_11_0._audioId = nil
	end
end

function var_0_0.onDestroy(arg_12_0)
	if arg_12_0._videoName then
		StoryModel.instance:setSpecialVideoEnd(arg_12_0._videoName)
	end

	if arg_12_0._avProVideoPlayer ~= nil then
		arg_12_0._avProVideoPlayer:Clear()

		arg_12_0._avProVideoPlayer = nil
	end

	if BootNativeUtil.isIOS() then
		TaskDispatcher.cancelTask(arg_12_0._detectPause, arg_12_0)
	end

	if arg_12_0._videoGo then
		gohelper.destroy(arg_12_0._videoGo)

		arg_12_0._videoGo = nil
	end

	arg_12_0._videoOutCallback = nil
	arg_12_0._videoOutCallbackObj = nil
	arg_12_0._videoStartCallback = nil
	arg_12_0._videoStartCallbackObj = nil

	arg_12_0:stopAudio()
end

return var_0_0
