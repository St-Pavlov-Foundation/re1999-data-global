module("modules.logic.gm.view.GMVideoPlayViewContainer", package.seeall)

slot0 = class("GMVideoPlayViewContainer", BaseViewContainer)

function slot0.buildViews(slot0)
	return {}
end

function slot0.onContainerInit(slot0)
	slot0._clickMask = gohelper.findChildClick(slot0.viewGO, "clickMask")
	slot0._btnSkip = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_skip")
	slot0._videoGO = gohelper.findChild(slot0.viewGO, "#go_video")

	gohelper.setActive(slot0._btnSkip.gameObject, false)
	slot0._clickMask:AddClickListener(slot0._onClickMask, slot0)
	slot0._btnSkip:AddClickListener(slot0.closeThis, slot0)
end

function slot0.onContainerDestroy(slot0)
	slot0._clickMask:RemoveClickListener()
	slot0._btnSkip:RemoveClickListener()
	slot0:_stopMovie()
end

function slot0.onContainerOpen(slot0)
	slot1 = slot0.viewParam

	if not slot0._videoPlayer then
		slot0._videoPlayer, slot0._displauUGUI, slot0._videoPlayerGO = AvProMgr.instance:getVideoPlayer(slot0._videoGO)
		slot2 = MonoHelper.addNoUpdateLuaComOnceToGo(slot0._videoPlayerGO, FullScreenVideoAdapter)
		slot0._videoPlayerGO = nil
	end

	slot0._videoPlayer:Play(slot0._displauUGUI, langVideoUrl(slot1), false, slot0._videoStatusUpdate, slot0)
end

function slot0._onClickMask(slot0)
	gohelper.setActive(slot0._btnSkip.gameObject, true)
end

function slot0._videoStatusUpdate(slot0, slot1, slot2, slot3)
	if slot2 == AvProEnum.PlayerStatus.FinishedPlaying then
		slot0:closeThis()
	end
end

function slot0._stopMovie(slot0)
	if slot0._videoPlayer then
		slot0._videoPlayer:Stop()
		slot0._videoPlayer:Clear()

		slot0._videoPlayer = nil
	end
end

return slot0
