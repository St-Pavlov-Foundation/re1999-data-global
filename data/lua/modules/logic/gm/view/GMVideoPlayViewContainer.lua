module("modules.logic.gm.view.GMVideoPlayViewContainer", package.seeall)

local var_0_0 = class("GMVideoPlayViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {}
end

function var_0_0.onContainerInit(arg_2_0)
	arg_2_0._clickMask = gohelper.findChildClick(arg_2_0.viewGO, "clickMask")
	arg_2_0._btnSkip = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "#btn_skip")
	arg_2_0._videoGO = gohelper.findChild(arg_2_0.viewGO, "#go_video")

	gohelper.setActive(arg_2_0._btnSkip.gameObject, false)
	arg_2_0._clickMask:AddClickListener(arg_2_0._onClickMask, arg_2_0)
	arg_2_0._btnSkip:AddClickListener(arg_2_0.closeThis, arg_2_0)
end

function var_0_0.onContainerDestroy(arg_3_0)
	arg_3_0._clickMask:RemoveClickListener()
	arg_3_0._btnSkip:RemoveClickListener()
	arg_3_0:_stopMovie()
end

function var_0_0.onContainerOpen(arg_4_0)
	local var_4_0 = arg_4_0.viewParam

	if not arg_4_0._videoPlayer then
		arg_4_0._videoPlayer, arg_4_0._displauUGUI, arg_4_0._videoPlayerGO = AvProMgr.instance:getVideoPlayer(arg_4_0._videoGO)

		local var_4_1 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._videoPlayerGO, FullScreenVideoAdapter)

		arg_4_0._videoPlayerGO = nil
	end

	arg_4_0._videoPlayer:Play(arg_4_0._displauUGUI, langVideoUrl(var_4_0), false, arg_4_0._videoStatusUpdate, arg_4_0)
end

function var_0_0._onClickMask(arg_5_0)
	gohelper.setActive(arg_5_0._btnSkip.gameObject, true)
end

function var_0_0._videoStatusUpdate(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_2 == AvProEnum.PlayerStatus.FinishedPlaying then
		arg_6_0:closeThis()
	end
end

function var_0_0._stopMovie(arg_7_0)
	if arg_7_0._videoPlayer then
		arg_7_0._videoPlayer:Stop()
		arg_7_0._videoPlayer:Clear()

		arg_7_0._videoPlayer = nil
	end
end

return var_0_0
