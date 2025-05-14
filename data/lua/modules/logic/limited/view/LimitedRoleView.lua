module("modules.logic.limited.view.LimitedRoleView", package.seeall)

local var_0_0 = class("LimitedRoleView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._startTime = Time.time
	arg_1_0._clickMask = gohelper.findChildClick(arg_1_0.viewGO, "clickMask")
	arg_1_0._btnSkip = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_skip")
	arg_1_0._videoGO = gohelper.findChild(arg_1_0.viewGO, "#go_video")

	gohelper.setActive(arg_1_0._btnSkip.gameObject, false)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._clickMask:AddClickListener(arg_2_0._onClickMask, arg_2_0)
	arg_2_0._btnSkip:AddClickListener(arg_2_0._onClickBtnSkip, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._clickMask:RemoveClickListener()
	arg_3_0._btnSkip:RemoveClickListener()
end

function var_0_0._onClickMask(arg_4_0)
	if Time.time - arg_4_0._startTime > 2 and not arg_4_0._hasPlayFinish then
		gohelper.setActive(arg_4_0._btnSkip.gameObject, true)
	end
end

function var_0_0._onClickBtnSkip(arg_5_0)
	LimitedRoleController.instance:dispatchEvent(LimitedRoleController.ManualSkip)
	arg_5_0:closeThis()
end

function var_0_0._stopMainBgm(arg_6_0)
	AudioBgmManager.instance:stopBgm(arg_6_0._stopBgm)
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0._startTime = Time.time
	arg_7_0._hasPlayFinish = false

	NavigateMgr.instance:addEscape(arg_7_0.viewName, arg_7_0._onEscBtnClick, arg_7_0)

	arg_7_0._limitCO = arg_7_0.viewParam.limitedCO
	arg_7_0._stopBgm = arg_7_0.viewParam.stopBgm

	if arg_7_0._stopBgm then
		arg_7_0:_stopMainBgm()
		TaskDispatcher.runRepeat(arg_7_0._stopMainBgm, arg_7_0, 0.2, 100)
	end

	if arg_7_0._limitCO then
		if not arg_7_0._videoPlayer then
			arg_7_0._videoPlayer, arg_7_0._displauUGUI, arg_7_0._videoPlayerGO = AvProMgr.instance:getVideoPlayer(arg_7_0._videoGO)

			local var_7_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_7_0._videoPlayerGO, FullScreenVideoAdapter)

			arg_7_0._videoPlayerGO = nil
		end

		arg_7_0._videoPlayer:Play(arg_7_0._displauUGUI, langVideoUrl(arg_7_0._limitCO.entranceMv), false, arg_7_0._videoStatusUpdate, arg_7_0)

		if arg_7_0._limitCO.mvtime and arg_7_0._limitCO.mvtime > 0 then
			TaskDispatcher.runDelay(arg_7_0._timeout, arg_7_0, arg_7_0._limitCO.mvtime)
		end
	else
		logError("open viewParam limitCO = null")
		TaskDispatcher.runDelay(arg_7_0.closeThis, arg_7_0, 1)
	end
end

function var_0_0.onClose(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0.closeThis, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._timeout, arg_8_0)

	if arg_8_0._stopBgm then
		TaskDispatcher.cancelTask(arg_8_0._stopMainBgm, arg_8_0)
	end

	if arg_8_0._limitCO and arg_8_0._limitCO.stopAudio > 0 then
		AudioMgr.instance:trigger(arg_8_0._limitCO.stopAudio)
	end
end

function var_0_0._onEscBtnClick(arg_9_0)
	return
end

function var_0_0._timeout(arg_10_0)
	if isDebugBuild then
		logError("播放入场视频超时")
	end

	arg_10_0:_dispatchPlayActionAndDelayClose()
end

function var_0_0._videoStatusUpdate(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	LimitedRoleController.instance:dispatchEvent(LimitedRoleController.VideoState, arg_11_2)

	if arg_11_2 == AvProEnum.PlayerStatus.FinishedPlaying then
		TaskDispatcher.cancelTask(arg_11_0._timeout, arg_11_0)
		arg_11_0:_onPlayMovieFinish()
	end

	if (arg_11_2 == AvProEnum.PlayerStatus.Started or arg_11_2 == AvProEnum.PlayerStatus.StartedSeeking) and arg_11_0._limitCO and arg_11_0._limitCO.audio > 0 then
		AudioMgr.instance:trigger(arg_11_0._limitCO.audio)
	end
end

function var_0_0._stopMovie(arg_12_0)
	if arg_12_0._videoPlayer then
		arg_12_0._videoPlayer:Stop()
		arg_12_0._videoPlayer:Clear()

		arg_12_0._videoPlayer = nil
	end
end

function var_0_0._onPlayMovieFinish(arg_13_0)
	arg_13_0._hasPlayFinish = true

	gohelper.setActive(arg_13_0._btnSkip.gameObject, false)
	arg_13_0:_dispatchPlayActionAndDelayClose()
end

function var_0_0._dispatchPlayActionAndDelayClose(arg_14_0)
	TaskDispatcher.runDelay(arg_14_0._delayCloseThis, arg_14_0, 0.2)
	LimitedRoleController.instance:dispatchEvent(LimitedRoleController.PlayAction)
end

function var_0_0._delayCloseThis(arg_15_0)
	TaskDispatcher.cancelTask(arg_15_0._delayCloseThis, arg_15_0)

	if arg_15_0._videoPlayer then
		arg_15_0._videoPlayer:Stop()
	end

	arg_15_0:closeThis()
end

function var_0_0.onDestroyView(arg_16_0)
	NavigateMgr.instance:removeEscape(arg_16_0.viewName)
	arg_16_0:_stopMovie()
end

return var_0_0
