module("modules.logic.characterskin.view.StoreSkinPreviewVideoView", package.seeall)

slot0 = class("StoreSkinPreviewVideoView", BaseView)

function slot0.onInitView(slot0)
	slot0._startTime = Time.time
	slot0._videoRoot = gohelper.findChild(slot0.viewGO, "video")
	slot0._clickMask = gohelper.findChildClick(slot0._videoRoot, "clickMask")
	slot0._btnSkip = gohelper.findChildButtonWithAudio(slot0._videoRoot, "#btn_skip")
	slot0._videoGO = gohelper.findChild(slot0._videoRoot, "#go_video")

	gohelper.setActive(slot0._btnSkip.gameObject, false)
end

function slot0.addEvents(slot0)
	slot0._clickMask:AddClickListener(slot0._onClickMask, slot0)
	slot0._btnSkip:AddClickListener(slot0._onClickBtnSkip, slot0)
end

function slot0.removeEvents(slot0)
	slot0._clickMask:RemoveClickListener()
	slot0._btnSkip:RemoveClickListener()
end

function slot0._onClickMask(slot0)
	if not slot0._hasPlayFinish then
		gohelper.setActive(slot0._btnSkip.gameObject, true)
	end
end

function slot0._onClickBtnSkip(slot0)
	slot0:_stopMovie()
end

function slot0.onOpen(slot0)
	slot0._skinGoodMo = slot0.viewParam.goodsMO
	slot3 = string.splitToNumber(slot0._skinGoodMo.config.product, "#")[2]
	slot0.skinConfig = lua_skin.configDict[slot3]

	if not lua_character_limited.configDict[slot3] or VersionValidator.instance:isInReviewing() then
		slot0:checkVideoGuide()

		return
	end

	slot0._startTime = Time.time
	slot0._hasPlayFinish = false

	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onEscBtnClick, slot0)

	if not slot4 then
		return
	else
		slot0._videoAudioId = slot4.audio
		slot0._stopAudioId = slot4.stopAudio
		slot0._stopBgm = slot0._videoAudioId > 0
		slot0._videoPath = string.nilorempty(slot4.entranceMv) and "" or langVideoUrl(slot4.entranceMv)
		slot0._mvTime = slot4.mvtime
	end

	if slot0._stopBgm then
		slot0:_stopMainBgm()
		TaskDispatcher.runDelay(slot0._stopMainBgm, slot0, 0.5)
	end

	gohelper.setActive(slot0._videoRoot, true)

	if not string.nilorempty(slot0._videoPath) then
		if not slot0._videoPlayer then
			slot0._videoPlayer, slot0._displauUGUI, slot0._videoPlayerGO = AvProMgr.instance:getVideoPlayer(slot0._videoGO)
			slot5 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._videoPlayerGO, FullScreenVideoAdapter)
			slot0._videoPlayerGO = nil
		end

		slot0._videoPlayer:Play(slot0._displauUGUI, slot0._videoPath, false, slot0._videoStatusUpdate, slot0)

		if slot0._mvTime and slot0._mvTime > 0 then
			TaskDispatcher.runDelay(slot0._timeout, slot0, slot0._mvTime)
		end
	else
		TaskDispatcher.runDelay(slot0._hideVideoGo, slot0, 1)
	end
end

function slot0.checkVideoGuide(slot0)
	if slot0.skinConfig and slot0.skinConfig.isSkinVideo then
		CharacterController.instance:dispatchEvent(CharacterEvent.onClientVideoPlayFinish)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._timeout, slot0)
	TaskDispatcher.cancelTask(slot0._hideVideoGo, slot0)
	TaskDispatcher.cancelTask(slot0._stopMainBgm, slot0)

	if slot0._videoPlayer then
		slot0._videoPlayer:Stop()
		slot0._videoPlayer:Clear()

		slot0._videoPlayer = nil
	end

	if slot0._stopAudioId and slot0._stopAudioId > 0 then
		AudioMgr.instance:trigger(slot0._stopAudioId)
	end
end

function slot0._onEscBtnClick(slot0)
end

function slot0._videoStatusUpdate(slot0, slot1, slot2, slot3)
	if slot2 == AvProEnum.PlayerStatus.FinishedPlaying then
		TaskDispatcher.cancelTask(slot0._timeout, slot0)
		slot0:_playMovieFinish()
	end

	if (slot2 == AvProEnum.PlayerStatus.Started or slot2 == AvProEnum.PlayerStatus.StartedSeeking) and slot0._videoAudioId > 0 then
		AudioMgr.instance:trigger(slot0._videoAudioId)
	end
end

function slot0._timeout(slot0)
	if isDebugBuild then
		logError("播放入场视频超时")
	end

	slot0:_stopMovie()
end

function slot0._stopMovie(slot0)
	NavigateMgr.instance:removeEscape(slot0.viewName)
	slot0:_hideVideoGo()

	if slot0._videoPlayer then
		slot0._videoPlayer:Stop()
		slot0._videoPlayer:Clear()

		slot0._videoPlayer = nil
	end

	TaskDispatcher.cancelTask(slot0._timeout, slot0)

	if slot0._stopAudioId and slot0._stopAudioId > 0 then
		AudioMgr.instance:trigger(slot0._stopAudioId)
	end

	slot0:_playMainBgm()
end

function slot0._playMovieFinish(slot0)
	slot0._hasPlayFinish = true

	slot0:_hideVideoGo()
	NavigateMgr.instance:removeEscape(slot0.viewName)

	if slot0._stopAudioId and slot0._stopAudioId > 0 then
		AudioMgr.instance:trigger(slot0._stopAudioId)
	end

	slot0:_playMainBgm()
end

function slot0._playMainBgm(slot0)
	if ViewMgr.instance:isOpen(ViewName.CharacterSkinView) then
		AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Character)
	else
		AudioBgmManager.instance:playBgm(AudioBgmEnum.Layer.Main)
	end
end

function slot0._stopMainBgm(slot0)
	if ViewMgr.instance:isOpen(ViewName.CharacterSkinView) then
		AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Character)
	else
		AudioBgmManager.instance:stopBgm(AudioBgmEnum.Layer.Main)
	end
end

function slot0._hideVideoGo(slot0)
	gohelper.setActive(slot0._videoRoot, false)
	slot0:checkVideoGuide()
end

return slot0
