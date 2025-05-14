module("modules.logic.characterskin.view.StoreSkinPreviewVideoView", package.seeall)

local var_0_0 = class("StoreSkinPreviewVideoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._startTime = Time.time
	arg_1_0._videoRoot = gohelper.findChild(arg_1_0.viewGO, "video")
	arg_1_0._clickMask = gohelper.findChildClick(arg_1_0._videoRoot, "clickMask")
	arg_1_0._btnSkip = gohelper.findChildButtonWithAudio(arg_1_0._videoRoot, "#btn_skip")
	arg_1_0._videoGO = gohelper.findChild(arg_1_0._videoRoot, "#go_video")

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
	if not arg_4_0._hasPlayFinish then
		gohelper.setActive(arg_4_0._btnSkip.gameObject, true)
	end
end

function var_0_0._onClickBtnSkip(arg_5_0)
	arg_5_0:_stopMovie()
end

function var_0_0.onOpen(arg_6_0)
	arg_6_0._skinGoodMo = arg_6_0.viewParam.goodsMO

	local var_6_0 = arg_6_0._skinGoodMo.config.product
	local var_6_1 = string.splitToNumber(var_6_0, "#")[2]

	arg_6_0.skinConfig = lua_skin.configDict[var_6_1]

	local var_6_2 = lua_character_limited.configDict[var_6_1]

	if not var_6_2 or VersionValidator.instance:isInReviewing() then
		arg_6_0:checkVideoGuide()

		return
	end

	arg_6_0._startTime = Time.time
	arg_6_0._hasPlayFinish = false

	NavigateMgr.instance:addEscape(arg_6_0.viewName, arg_6_0._onEscBtnClick, arg_6_0)

	if not var_6_2 then
		return
	else
		arg_6_0._videoAudioId = var_6_2.audio
		arg_6_0._stopAudioId = var_6_2.stopAudio
		arg_6_0._stopBgm = arg_6_0._videoAudioId > 0
		arg_6_0._videoPath = string.nilorempty(var_6_2.entranceMv) and "" or langVideoUrl(var_6_2.entranceMv)
		arg_6_0._mvTime = var_6_2.mvtime
	end

	if arg_6_0._stopBgm then
		arg_6_0:_stopMainBgm()
		TaskDispatcher.runDelay(arg_6_0._stopMainBgm, arg_6_0, 0.5)
	end

	gohelper.setActive(arg_6_0._videoRoot, true)

	if not string.nilorempty(arg_6_0._videoPath) then
		if not arg_6_0._videoPlayer then
			arg_6_0._videoPlayer, arg_6_0._displauUGUI, arg_6_0._videoPlayerGO = AvProMgr.instance:getVideoPlayer(arg_6_0._videoGO)

			local var_6_3 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_6_0._videoPlayerGO, FullScreenVideoAdapter)

			arg_6_0._videoPlayerGO = nil
		end

		arg_6_0._videoPlayer:Play(arg_6_0._displauUGUI, arg_6_0._videoPath, false, arg_6_0._videoStatusUpdate, arg_6_0)

		if arg_6_0._mvTime and arg_6_0._mvTime > 0 then
			TaskDispatcher.runDelay(arg_6_0._timeout, arg_6_0, arg_6_0._mvTime)
		end
	else
		TaskDispatcher.runDelay(arg_6_0._hideVideoGo, arg_6_0, 1)
	end
end

function var_0_0.checkVideoGuide(arg_7_0)
	if arg_7_0.skinConfig and arg_7_0.skinConfig.isSkinVideo then
		CharacterController.instance:dispatchEvent(CharacterEvent.onClientVideoPlayFinish)
	end
end

function var_0_0.onClose(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._timeout, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._hideVideoGo, arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._stopMainBgm, arg_8_0)

	if arg_8_0._videoPlayer then
		arg_8_0._videoPlayer:Stop()
		arg_8_0._videoPlayer:Clear()

		arg_8_0._videoPlayer = nil
	end

	if arg_8_0._stopAudioId and arg_8_0._stopAudioId > 0 then
		AudioMgr.instance:trigger(arg_8_0._stopAudioId)
	end
end

function var_0_0._onEscBtnClick(arg_9_0)
	return
end

function var_0_0._videoStatusUpdate(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if arg_10_2 == AvProEnum.PlayerStatus.FinishedPlaying then
		TaskDispatcher.cancelTask(arg_10_0._timeout, arg_10_0)
		arg_10_0:_playMovieFinish()
	end

	if (arg_10_2 == AvProEnum.PlayerStatus.Started or arg_10_2 == AvProEnum.PlayerStatus.StartedSeeking) and arg_10_0._videoAudioId > 0 then
		AudioMgr.instance:trigger(arg_10_0._videoAudioId)
	end
end

function var_0_0._timeout(arg_11_0)
	if isDebugBuild then
		logError("播放入场视频超时")
	end

	arg_11_0:_stopMovie()
end

function var_0_0._stopMovie(arg_12_0)
	NavigateMgr.instance:removeEscape(arg_12_0.viewName)
	arg_12_0:_hideVideoGo()

	if arg_12_0._videoPlayer then
		arg_12_0._videoPlayer:Stop()
		arg_12_0._videoPlayer:Clear()

		arg_12_0._videoPlayer = nil
	end

	TaskDispatcher.cancelTask(arg_12_0._timeout, arg_12_0)

	if arg_12_0._stopAudioId and arg_12_0._stopAudioId > 0 then
		AudioMgr.instance:trigger(arg_12_0._stopAudioId)
	end

	arg_12_0:_playMainBgm()
end

function var_0_0._playMovieFinish(arg_13_0)
	arg_13_0._hasPlayFinish = true

	arg_13_0:_hideVideoGo()
	NavigateMgr.instance:removeEscape(arg_13_0.viewName)

	if arg_13_0._stopAudioId and arg_13_0._stopAudioId > 0 then
		AudioMgr.instance:trigger(arg_13_0._stopAudioId)
	end

	arg_13_0:_playMainBgm()
end

function var_0_0._playMainBgm(arg_14_0)
	if ViewMgr.instance:isOpen(ViewName.CharacterSkinView) then
		AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Character)
	else
		AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Main)
	end
end

function var_0_0._stopMainBgm(arg_15_0)
	if ViewMgr.instance:isOpen(ViewName.CharacterSkinView) then
		AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Character)
	else
		AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Main)
	end
end

function var_0_0._hideVideoGo(arg_16_0)
	gohelper.setActive(arg_16_0._videoRoot, false)
	arg_16_0:checkVideoGuide()
end

return var_0_0
