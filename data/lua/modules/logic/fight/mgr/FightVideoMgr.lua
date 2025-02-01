module("modules.logic.fight.mgr.FightVideoMgr", package.seeall)

slot0 = class("FightVideoMgr")
slot1 = "ui/viewres/fight/fightvideo.prefab"

function slot0.ctor(slot0)
	slot0._avProVideoPlayer = nil
	slot0._displauUGUI = nil
	slot0._mediaPlayer = nil
	slot0._videoName = nil
	slot0._isPlaying = false
	slot0._callback = nil
	slot0._callbackObj = nil
	slot0._prefabLoader = nil
end

function slot0.init(slot0)
	slot0:_checkVideCopatible()
end

function slot0.dispose(slot0)
	slot0:stop()
end

function slot0._checkVideCopatible(slot0)
	if slot0._videoCopatible ~= SettingsModel.instance:getVideoCompatible() then
		slot0:stop()

		if slot0._avProVideoPlayer then
			slot0._avProVideoPlayer:Clear()

			slot0._avProVideoPlayer = nil
			slot0._mediaPlayer = nil
			slot0._displauUGUI = nil
		end

		if slot0._prefabLoader then
			slot0._prefabLoader:dispose()

			slot0._prefabLoader = nil
		end

		if slot0._videoRootGO then
			gohelper.destroy(slot0._videoRootGO)

			slot0._videoRootGO = nil
		end
	end
end

function slot0.isSameVideo(slot0, slot1)
	return slot1 == slot0._videoName
end

function slot0.play(slot0, slot1, slot2, slot3)
	if string.nilorempty(slot1) then
		logError("video path is nil")

		return
	end

	slot0._pause = false
	slot0._videoName = slot1
	slot0._callback = slot2
	slot0._callbackObj = slot3

	if slot0._videoRootGO then
		slot0:_playVideo()
	else
		slot0._videoCopatible = SettingsModel.instance:getVideoCompatible()
		slot0._prefabLoader = MultiAbLoader.New()

		slot0._prefabLoader:addPath(AvProMgr.instance:getFightUrl())
		slot0._prefabLoader:startLoad(slot0._onVideoPrefabLoaded, slot0)
	end

	FightController.instance:dispatchEvent(FightEvent.OnPlayVideo, slot1)
end

function slot0._onVideoPrefabLoaded(slot0, slot1)
	slot0._videoRootGO = gohelper.clone(slot1:getFirstAssetItem():GetResource(), ViewMgr.instance:getUILayer(UILayerName.PopUp), "FightVideo")
	slot3 = gohelper.findChild(slot0._videoRootGO, "FightVideo")

	if SettingsModel.instance:getVideoEnabled() == false then
		slot0._avProVideoPlayer = AvProUGUIPlayer_adjust.instance
		slot0._mediaPlayer = MediaPlayer_adjust.New()
	else
		slot0._displauUGUI = gohelper.onceAddComponent(slot3, typeof(RenderHeads.Media.AVProVideo.DisplayUGUI))
		slot0._displauUGUI.ScaleMode = UnityEngine.ScaleMode.ScaleAndCrop
		slot0._avProVideoPlayer = gohelper.onceAddComponent(slot3, typeof(ZProj.AvProUGUIPlayer))

		slot0._avProVideoPlayer:AddDisplayUGUI(slot0._displauUGUI)

		slot0._mediaPlayer = gohelper.onceAddComponent(slot3, typeof(RenderHeads.Media.AVProVideo.MediaPlayer))
	end

	slot0:_playVideo()
end

function slot0._playVideo(slot0)
	slot0:stop()

	slot0._isPlaying = true

	if slot0._avProVideoPlayer then
		gohelper.setActive(slot0._videoRootGO, true)
		slot0._avProVideoPlayer:LoadMedia(langVideoUrl(slot0._videoName))
		slot0._avProVideoPlayer:Play(slot0._displauUGUI, false)

		slot0._mediaPlayer.PlaybackRate = FightModel.instance:getSpeed() * Time.timeScale

		if slot0._pause then
			slot0:pause()
		end
	end
end

function slot0.stop(slot0)
	if slot0._isPlaying then
		slot0._pause = false
		slot0._isPlaying = false

		slot0:_stopVideo()
	end
end

function slot0.pause(slot0)
	if slot0._avProVideoPlayer then
		gohelper.setActive(slot0._videoRootGO, false)
	else
		slot0._pause = true
	end
end

function slot0.isPause(slot0)
	return slot0._pause
end

function slot0.continue(slot0, slot1)
	if slot0._videoName == slot1 and slot0._isPlaying then
		slot0._pause = false

		if slot0._avProVideoPlayer then
			gohelper.setActive(slot0._videoRootGO, true)
		end
	end
end

function slot0._stopVideo(slot0)
	if slot0._avProVideoPlayer then
		slot0._avProVideoPlayer:Stop()
		slot0._mediaPlayer:CloseMedia()
		gohelper.setActive(slot0._videoRootGO, false)
	end
end

slot0.instance = slot0.New()

return slot0
