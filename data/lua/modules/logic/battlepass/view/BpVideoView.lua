module("modules.logic.battlepass.view.BpVideoView", package.seeall)

local var_0_0 = class("BpVideoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._videoGo = gohelper.findChild(arg_1_0.viewGO, "#go_video")
end

function var_0_0.onOpen(arg_2_0)
	arg_2_0._videoPlayer, arg_2_0._displauUGUI = AvProMgr.instance:getVideoPlayer(arg_2_0._videoGo)

	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_permit_admission)
	arg_2_0._videoPlayer:Play(arg_2_0._displauUGUI, "videos/bp_open.mp4", false, arg_2_0._videoStatusUpdate, arg_2_0)
end

function var_0_0._videoStatusUpdate(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	if arg_3_2 == AvProEnum.PlayerStatus.FinishedPlaying then
		if not ViewMgr.instance:isOpen(ViewName.BpChargeView) then
			ViewMgr.instance:registerCallback(ViewEvent.OnOpenView, arg_3_0.closeThis, arg_3_0)
			ViewMgr.instance:openView(ViewName.BpChargeView, {
				first = true
			})
		else
			arg_3_0:closeThis()
		end
	end
end

function var_0_0.onDestroyView(arg_4_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenView, arg_4_0.closeThis, arg_4_0)

	if arg_4_0._videoPlayer then
		arg_4_0._videoPlayer:Stop()
		arg_4_0._videoPlayer:Clear()

		arg_4_0._videoPlayer = nil
	end
end

return var_0_0
