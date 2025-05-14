module("modules.logic.versionactivity1_6.enter.view.VersionActivity1_6EnterVideoView", package.seeall)

local var_0_0 = class("VersionActivity1_6EnterVideoView", BaseView)
local var_0_1 = 3
local var_0_2 = "videos/1_6_enter.mp4"

function var_0_0.onInitView(arg_1_0)
	arg_1_0._videoRoot = gohelper.findChild(arg_1_0.viewGO, "#go_video")
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0._videoPlayer, arg_2_0._displauUGUI, arg_2_0._videoGo = AvProMgr.instance:getVideoPlayer(arg_2_0._videoRoot)

	AudioMgr.instance:trigger(AudioEnum.UI.Act1_6EnterViewVideo)
	arg_2_0._videoPlayer:Play(arg_2_0._displauUGUI, langVideoUrl("1_6_enter"), false, arg_2_0._videoStatusUpdate, arg_2_0)

	arg_2_0._videoGo:GetComponent(typeof(ZProj.UIBgSelfAdapter)).enabled = false

	TaskDispatcher.runDelay(arg_2_0.handleVideoOverTime, arg_2_0, var_0_1)
end

function var_0_0._videoStatusUpdate(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_2 == AvProEnum.PlayerStatus.FinishedPlaying or arg_3_2 == AvProEnum.PlayerStatus.Error then
		arg_3_0:_stopVideoOverTimeAction()
		arg_3_0:closeThis()
		VersionActivity1_6EnterController.instance:dispatchEvent(VersionActivity1_6EnterEvent.OnEnterVideoFinished)
	end
end

function var_0_0.handleVideoOverTime(arg_4_0)
	arg_4_0:_stopVideoOverTimeAction()
	arg_4_0:closeThis()
	VersionActivity1_6EnterController.instance:dispatchEvent(VersionActivity1_6EnterEvent.OnEnterVideoFinished)
end

function var_0_0._stopVideoOverTimeAction(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0.handleVideoOverTime, arg_5_0)
end

function var_0_0.onDestroyView(arg_6_0)
	arg_6_0:_stopVideoOverTimeAction()

	if arg_6_0._videoPlayer then
		arg_6_0._videoPlayer:Stop()
		arg_6_0._videoPlayer:Clear()

		arg_6_0._videoPlayer = nil
	end
end

return var_0_0
