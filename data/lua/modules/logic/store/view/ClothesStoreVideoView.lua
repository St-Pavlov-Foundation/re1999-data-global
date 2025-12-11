module("modules.logic.store.view.ClothesStoreVideoView", package.seeall)

local var_0_0 = class("ClothesStoreVideoView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._videoRoot = gohelper.findChild(arg_1_0.viewGO, "#go_has/character/bg/video/videoRoot")
	arg_1_0._videoGO = gohelper.findChild(arg_1_0._videoRoot, "#go_video")
	arg_1_0.viewCanvasGroup = gohelper.onceAddComponent(arg_1_0.viewGO, typeof(UnityEngine.CanvasGroup))
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(StoreController.instance, StoreEvent.OnPlaySkinVideo, arg_2_0._onPlaySkinVideo, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(StoreController.instance, StoreEvent.OnPlaySkinVideo, arg_3_0._onPlaySkinVideo, arg_3_0)
end

function var_0_0._onPlaySkinVideo(arg_4_0, arg_4_1)
	arg_4_0:playSkinVideo(arg_4_1)
end

function var_0_0.onOpen(arg_5_0)
	return
end

function var_0_0.playSkinVideo(arg_6_0, arg_6_1)
	if not arg_6_1 then
		arg_6_0:_stopMovie()

		return
	end

	local var_6_0 = arg_6_1.config.product
	local var_6_1 = string.splitToNumber(var_6_0, "#")[2]
	local var_6_2 = lua_character_limited.configDict[var_6_1]

	if not var_6_2 or VersionValidator.instance:isInReviewing() then
		return
	end

	if arg_6_0._stopAudioId and arg_6_0._stopAudioId > 0 then
		AudioMgr.instance:trigger(arg_6_0._stopAudioId)
	end

	arg_6_0._hasPlayFinish = false

	NavigateMgr.instance:addEscape(arg_6_0.viewName, arg_6_0._onEscBtnClick, arg_6_0)

	arg_6_0._videoAudioId = var_6_2.audio
	arg_6_0._stopAudioId = var_6_2.stopAudio
	arg_6_0._stopBgm = arg_6_0._videoAudioId > 0
	arg_6_0._videoPath = string.nilorempty(var_6_2.entranceMv) and "" or langVideoUrl(var_6_2.entranceMv)
	arg_6_0._mvTime = var_6_2.mvtime

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

function var_0_0.onClose(arg_7_0)
	arg_7_0:_stopMovie()
end

function var_0_0._onEscBtnClick(arg_8_0)
	return
end

function var_0_0._videoStatusUpdate(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_2 == AvProEnum.PlayerStatus.FinishedPlaying then
		TaskDispatcher.cancelTask(arg_9_0._timeout, arg_9_0)
		arg_9_0:_playMovieFinish()
	end

	if arg_9_2 == AvProEnum.PlayerStatus.Started or arg_9_2 == AvProEnum.PlayerStatus.StartedSeeking then
		if arg_9_0._videoAudioId > 0 then
			AudioMgr.instance:trigger(arg_9_0._videoAudioId)
		end

		arg_9_0.viewCanvasGroup.alpha = 1
	end
end

function var_0_0._timeout(arg_10_0)
	arg_10_0:_stopMovie()
end

function var_0_0._stopMovie(arg_11_0)
	NavigateMgr.instance:removeEscape(arg_11_0.viewName)
	arg_11_0:_hideVideoGo()

	if arg_11_0._videoPlayer then
		arg_11_0._videoPlayer:Stop()
		arg_11_0._videoPlayer:Clear()

		arg_11_0._videoPlayer = nil
	end

	TaskDispatcher.cancelTask(arg_11_0._timeout, arg_11_0)

	if arg_11_0._stopAudioId and arg_11_0._stopAudioId > 0 then
		AudioMgr.instance:trigger(arg_11_0._stopAudioId)
	end

	arg_11_0:_playMainBgm()
end

function var_0_0._playMovieFinish(arg_12_0)
	arg_12_0._hasPlayFinish = true

	arg_12_0:_hideVideoGo()
	NavigateMgr.instance:removeEscape(arg_12_0.viewName)

	if arg_12_0._stopAudioId and arg_12_0._stopAudioId > 0 then
		AudioMgr.instance:trigger(arg_12_0._stopAudioId)
	end

	arg_12_0:_playMainBgm()
	ViewMgr.instance:closeView(ViewName.StoreSkinDefaultShowView)
end

function var_0_0._playMainBgm(arg_13_0)
	if ViewMgr.instance:isOpen(ViewName.CharacterSkinView) then
		AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Character)
	else
		AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Main)
	end
end

function var_0_0._stopMainBgm(arg_14_0)
	if ViewMgr.instance:isOpen(ViewName.CharacterSkinView) then
		AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Character)
	else
		AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Main)
	end
end

function var_0_0._hideVideoGo(arg_15_0)
	gohelper.setActive(arg_15_0._videoRoot, false)
end

return var_0_0
