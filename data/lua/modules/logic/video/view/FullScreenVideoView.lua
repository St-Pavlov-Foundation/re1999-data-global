module("modules.logic.video.view.FullScreenVideoView", package.seeall)

local var_0_0 = class("FullScreenVideoView", BaseView)

var_0_0.DefaultMaxDuration = 3

function var_0_0.onInitView(arg_1_0)
	arg_1_0._govideo = gohelper.findChild(arg_1_0.viewGO, "#go_video")
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0.videoDone = false
	arg_2_0.videoPlayer, arg_2_0.displayUGUI, arg_2_0.videoGo = AvProMgr.instance:getVideoPlayer(arg_2_0._govideo)

	if arg_2_0.viewParam.videoAudio then
		AudioMgr.instance:trigger(arg_2_0.viewParam.videoAudio)
	end

	arg_2_0.videoPlayer:Play(arg_2_0.displayUGUI, arg_2_0.viewParam.videoPath, false, arg_2_0.videoStatusUpdate, arg_2_0)

	arg_2_0.doneCb = arg_2_0.viewParam.doneCb
	arg_2_0.doneCbObj = arg_2_0.viewParam.doneCbObj
	arg_2_0.videoGo:GetComponent(typeof(ZProj.UIBgSelfAdapter)).enabled = false

	TaskDispatcher.runDelay(arg_2_0.onVideoOverTime, arg_2_0, arg_2_0.viewParam.videoDuration or var_0_0.DefaultMaxDuration)
end

function var_0_0.videoStatusUpdate(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_2 == AvProEnum.PlayerStatus.FinishedPlaying then
		arg_3_0:onPlayVideoDone()
	elseif arg_3_2 == AvProEnum.PlayerStatus.Closing then
		arg_3_0:onPlayVideoDone()
	end
end

function var_0_0.onPlayVideoDone(arg_4_0)
	if arg_4_0.videoDone then
		return
	end

	arg_4_0.videoDone = true

	TaskDispatcher.cancelTask(arg_4_0.onVideoOverTime, arg_4_0)
	arg_4_0:closeThis()

	if arg_4_0.doneCb then
		arg_4_0.doneCb(arg_4_0.doneCbObj)
	end

	arg_4_0.doneCb = nil
	arg_4_0.doneCbObj = nil

	VideoController.instance:dispatchEvent(VideoEvent.OnVideoPlayFinished)
end

function var_0_0.onVideoOverTime(arg_5_0)
	arg_5_0:onPlayVideoDone()
end

function var_0_0.onDestroyView(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0.onVideoOverTime, arg_6_0)

	if arg_6_0._videoPlayer then
		arg_6_0._videoPlayer:Stop()
		arg_6_0._videoPlayer:Clear()

		arg_6_0._videoPlayer = nil
	end
end

return var_0_0
