module("modules.logic.limited.view.LimitedRoleView", package.seeall)

slot0 = class("LimitedRoleView", BaseView)

function slot0.onInitView(slot0)
	slot0._startTime = Time.time
	slot0._clickMask = gohelper.findChildClick(slot0.viewGO, "clickMask")
	slot0._btnSkip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_skip")
	slot0._videoGO = gohelper.findChild(slot0.viewGO, "#go_video")

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
	if Time.time - slot0._startTime > 2 and not slot0._hasPlayFinish then
		gohelper.setActive(slot0._btnSkip.gameObject, true)
	end
end

function slot0._onClickBtnSkip(slot0)
	LimitedRoleController.instance:dispatchEvent(LimitedRoleController.ManualSkip)
	slot0:closeThis()
end

function slot0._stopMainBgm(slot0)
	AudioBgmManager.instance:stopBgm(slot0._stopBgm)
end

function slot0.onOpen(slot0)
	slot0._startTime = Time.time
	slot0._hasPlayFinish = false

	NavigateMgr.instance:addEscape(slot0.viewName, slot0._onEscBtnClick, slot0)

	slot0._limitCO = slot0.viewParam.limitedCO
	slot0._stopBgm = slot0.viewParam.stopBgm

	if slot0._stopBgm then
		slot0:_stopMainBgm()
		TaskDispatcher.runRepeat(slot0._stopMainBgm, slot0, 0.2, 100)
	end

	if slot0._limitCO then
		if not slot0._videoPlayer then
			slot0._videoPlayer, slot0._displauUGUI, slot0._videoPlayerGO = AvProMgr.instance:getVideoPlayer(slot0._videoGO)
			slot1 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._videoPlayerGO, FullScreenVideoAdapter)
			slot0._videoPlayerGO = nil
		end

		slot0._videoPlayer:Play(slot0._displauUGUI, langVideoUrl(slot0._limitCO.entranceMv), false, slot0._videoStatusUpdate, slot0)

		if slot0._limitCO.mvtime and slot0._limitCO.mvtime > 0 then
			TaskDispatcher.runDelay(slot0._timeout, slot0, slot0._limitCO.mvtime)
		end
	else
		logError("open viewParam limitCO = null")
		TaskDispatcher.runDelay(slot0.closeThis, slot0, 1)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.closeThis, slot0)
	TaskDispatcher.cancelTask(slot0._timeout, slot0)

	if slot0._stopBgm then
		TaskDispatcher.cancelTask(slot0._stopMainBgm, slot0)
	end

	if slot0._limitCO and slot0._limitCO.stopAudio > 0 then
		AudioMgr.instance:trigger(slot0._limitCO.stopAudio)
	end
end

function slot0._onEscBtnClick(slot0)
end

function slot0._timeout(slot0)
	if isDebugBuild then
		logError("播放入场视频超时")
	end

	slot0:_dispatchPlayActionAndDelayClose()
end

function slot0._videoStatusUpdate(slot0, slot1, slot2, slot3)
	LimitedRoleController.instance:dispatchEvent(LimitedRoleController.VideoState, slot2)

	if slot2 == AvProEnum.PlayerStatus.FinishedPlaying then
		TaskDispatcher.cancelTask(slot0._timeout, slot0)
		slot0:_onPlayMovieFinish()
	end

	if (slot2 == AvProEnum.PlayerStatus.Started or slot2 == AvProEnum.PlayerStatus.StartedSeeking) and slot0._limitCO and slot0._limitCO.audio > 0 then
		AudioMgr.instance:trigger(slot0._limitCO.audio)
	end
end

function slot0._stopMovie(slot0)
	if slot0._videoPlayer then
		slot0._videoPlayer:Stop()
		slot0._videoPlayer:Clear()

		slot0._videoPlayer = nil
	end
end

function slot0._onPlayMovieFinish(slot0)
	slot0._hasPlayFinish = true

	gohelper.setActive(slot0._btnSkip.gameObject, false)
	slot0:_dispatchPlayActionAndDelayClose()
end

function slot0._dispatchPlayActionAndDelayClose(slot0)
	TaskDispatcher.runDelay(slot0._delayCloseThis, slot0, 0.2)
	LimitedRoleController.instance:dispatchEvent(LimitedRoleController.PlayAction)
end

function slot0._delayCloseThis(slot0)
	TaskDispatcher.cancelTask(slot0._delayCloseThis, slot0)

	if slot0._videoPlayer then
		slot0._videoPlayer:Stop()
	end

	slot0:closeThis()
end

function slot0.onDestroyView(slot0)
	NavigateMgr.instance:removeEscape(slot0.viewName)
	slot0:_stopMovie()
end

return slot0
