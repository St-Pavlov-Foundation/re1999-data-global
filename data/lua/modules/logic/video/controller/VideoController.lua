module("modules.logic.video.controller.VideoController", package.seeall)

local var_0_0 = class("VideoController", BaseController)

function var_0_0.openFullScreenVideoView(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6)
	ViewMgr.instance:openView(ViewName.FullScreenVideoView, {
		videoPath = arg_1_1,
		videoAudio = arg_1_2,
		videoDuration = arg_1_3,
		doneCb = arg_1_4,
		doneCbObj = arg_1_5,
		waitViewOpen = arg_1_6 and arg_1_6.waitViewOpen,
		noShowBlackBg = arg_1_6 and arg_1_6.noShowBlackBg,
		getVideoPlayer = arg_1_6 and arg_1_6.getVideoPlayer,
		setVideoPlayer = arg_1_6 and arg_1_6.setVideoPlayer
	})
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
