module("modules.logic.video.view.FullScreenVideoView", package.seeall)

local var_0_0 = class("FullScreenVideoView", BaseView)

var_0_0.DefaultMaxDuration = 3

function var_0_0.onInitView(arg_1_0)
	arg_1_0._goblackbg = gohelper.findChild(arg_1_0.viewGO, "blackbg")
	arg_1_0._govideo = gohelper.findChild(arg_1_0.viewGO, "#go_video")
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0.doneCb = arg_2_0.viewParam.doneCb
	arg_2_0.doneCbObj = arg_2_0.viewParam.doneCbObj
	arg_2_0.waitViewOpen = arg_2_0.viewParam.waitViewOpen
	arg_2_0.videoDone = false

	local var_2_0 = arg_2_0.viewParam.getVideoPlayer

	arg_2_0._setVideoPlayer = arg_2_0.viewParam.setVideoPlayer

	if var_2_0 then
		arg_2_0._videoPlayer, arg_2_0.displayUGUI, arg_2_0.videoGo = var_2_0(arg_2_0.doneCbObj)

		gohelper.addChild(arg_2_0._govideo, arg_2_0.videoGo)
		transformhelper.setLocalScale(arg_2_0.videoGo.transform, 1, 1, 1)
		gohelper.setActive(arg_2_0.videoGo, true)

		arg_2_0.displayUGUI.enabled = false
	else
		arg_2_0._videoPlayer, arg_2_0.displayUGUI, arg_2_0.videoGo = AvProMgr.instance:getVideoPlayer(arg_2_0._govideo)
	end

	if arg_2_0.viewParam.videoAudio then
		AudioMgr.instance:trigger(arg_2_0.viewParam.videoAudio)
	end

	arg_2_0._videoPath = arg_2_0.viewParam.videoPath

	arg_2_0._videoPlayer:Play(arg_2_0.displayUGUI, arg_2_0.viewParam.videoPath, false, arg_2_0.videoStatusUpdate, arg_2_0)
	gohelper.setActive(arg_2_0._goblackbg, not arg_2_0.viewParam.noShowBlackBg)

	arg_2_0.videoGo:GetComponent(typeof(ZProj.UIBgSelfAdapter)).enabled = false
	arg_2_0._time = arg_2_0.viewParam.videoDuration or var_0_0.DefaultMaxDuration

	TaskDispatcher.runDelay(arg_2_0.onVideoOverTime, arg_2_0, arg_2_0._time)
end

function var_0_0.videoStatusUpdate(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_2 == AvProEnum.PlayerStatus.FinishedPlaying then
		arg_3_0:onPlayVideoDone()
	elseif arg_3_2 == AvProEnum.PlayerStatus.Closing then
		arg_3_0:onPlayVideoDone()
	elseif arg_3_2 == AvProEnum.PlayerStatus.Started then
		TaskDispatcher.cancelTask(arg_3_0.onVideoOverTime, arg_3_0)
		TaskDispatcher.runDelay(arg_3_0.onVideoOverTime, arg_3_0, arg_3_0._time)
		VideoController.instance:dispatchEvent(VideoEvent.OnVideoStarted, arg_3_0._videoPath)
	elseif arg_3_2 == AvProEnum.PlayerStatus.FirstFrameReady then
		TaskDispatcher.cancelTask(arg_3_0.onVideoOverTime, arg_3_0)
		TaskDispatcher.runDelay(arg_3_0.onVideoOverTime, arg_3_0, arg_3_0._time)
		VideoController.instance:dispatchEvent(VideoEvent.OnVideoFirstFrameReady, arg_3_0._videoPath)
	end
end

function var_0_0.onPlayVideoDone(arg_4_0)
	if arg_4_0.videoDone then
		return
	end

	arg_4_0.videoDone = true

	TaskDispatcher.cancelTask(arg_4_0.onVideoOverTime, arg_4_0)

	if not arg_4_0.waitViewOpen or ViewMgr.instance:isOpen(arg_4_0.waitViewOpen) then
		arg_4_0:closeThis()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_4_0._onViewOpen, arg_4_0)
	end

	if arg_4_0.doneCb then
		arg_4_0.doneCb(arg_4_0.doneCbObj)
	end

	VideoController.instance:dispatchEvent(VideoEvent.OnVideoPlayFinished)
end

function var_0_0.onVideoOverTime(arg_5_0)
	arg_5_0:onPlayVideoDone()
end

function var_0_0._onViewOpen(arg_6_0, arg_6_1)
	if arg_6_0.waitViewOpen == arg_6_1 then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_6_0._onViewOpen, arg_6_0)
		arg_6_0:closeThis()
	end
end

function var_0_0.onDestroyView(arg_7_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_7_0._onViewOpen, arg_7_0)
	TaskDispatcher.cancelTask(arg_7_0.onVideoOverTime, arg_7_0)

	if arg_7_0._setVideoPlayer then
		arg_7_0._setVideoPlayer(arg_7_0.doneCbObj, arg_7_0._videoPlayer, arg_7_0.displayUGUI, arg_7_0.videoGo)

		arg_7_0._setVideoPlayer = nil
		arg_7_0._videoPlayer = nil
	end

	if arg_7_0._videoPlayer then
		arg_7_0._videoPlayer:Stop()
		arg_7_0._videoPlayer:Clear()

		arg_7_0._videoPlayer = nil
	end

	arg_7_0.doneCb = nil
	arg_7_0.doneCbObj = nil
end

return var_0_0
