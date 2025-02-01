module("modules.logic.story.view.StoryVideoPlayList", package.seeall)

slot0 = class("StoryVideoPlayList", UserDataDispose)
slot0.MaxIndexCount = 7
slot0.PlayPos = {
	CommonPlay = 0,
	CommonPlay2 = 6,
	CommonLoop = 1
}
slot0.Empty = ""

function slot0.init(slot0, slot1, slot2)
	slot0:__onInit()

	slot0._isPlaying = false
	slot0.parentGO = slot2
	slot0.viewGO = slot1

	if SettingsModel.instance:getVideoEnabled() == false then
		slot0._uguiPlayList = AvProUGUIListPlayer_adjust.New()
		slot0._mediaPlayList = PlaylistMediaPlayer_adjust.New()
	else
		slot0._uguiPlayList = slot0.viewGO:GetComponent(typeof(ZProj.AvProUGUIListPlayer))
		slot0._mediaPlayList = slot0.viewGO:GetComponent(typeof(RenderHeads.Media.AVProVideo.PlaylistMediaPlayer))
		slot0._displayUGUI = slot0.viewGO:GetComponent(typeof(RenderHeads.Media.AVProVideo.DisplayUGUI))
	end

	slot0._uguiPlayList:SetEventListener(slot0._onVideoEvent, slot0)

	slot6 = 1080

	recthelper.setSize(slot0.viewGO.transform, 2592, slot6)
	gohelper.setActive(slot0.viewGO, false)

	slot0._path2StartCallback = {}
	slot0._path2StartCallbackObj = {}
	slot0._path2StartVideoItem = {}
	slot0._currentPlayNameMap = {}

	for slot6 = 0, uv0.MaxIndexCount - 1 do
		slot0._currentPlayNameMap[slot6] = uv0.Empty
	end
end

function slot0.buildAndStart(slot0, slot1, slot2, slot3, slot4, slot5)
	StoryController.instance:dispatchEvent(StoryEvent.VideoStart, slot1, slot2)

	slot6 = nil
	slot6 = (not slot2 or uv0.PlayPos.CommonLoop) and slot0:getNextNormalPlayIndex()
	slot7 = slot0._currentPlayNameMap[slot6]

	logNormal(string.format("StoryVideoPlayList play set path : [%s] \nto index [%s], loop = %s", tostring(slot1), tostring(slot6), tostring(slot2)))

	slot0._path2StartCallback[slot1] = slot3
	slot0._path2StartCallbackObj[slot1] = slot4
	slot0._path2StartVideoItem[slot1] = slot5

	gohelper.setActive(slot0.viewGO, true)
	slot0:setPathAtIndex(slot1, slot6)
	slot0._mediaPlayList:JumpToItem(slot6)

	if not slot0._isPlaying then
		slot0._mediaPlayList:Play()
		slot0._mediaPlayList:JumpToItem(slot6)

		slot0._isPlaying = true
	end

	if not string.nilorempty(slot7) then
		logNormal(string.format("video still playing : [%s], loop mode = [%s] will stop!", tostring(slot7), tostring(slot2)))
		slot0:stop(slot7)
	end

	slot0:_startIOSDetectPause()
end

function slot0.setPauseState(slot0, slot1, slot2)
	if slot1 == slot0._currentPlayNameMap[slot0._mediaPlayList.PlaylistIndex] and slot0._mediaPlayList then
		if slot2 then
			slot0._mediaPlayList:Play()
			slot0:_startIOSDetectPause()
		else
			slot0._mediaPlayList:Pause()
			slot0:_stopIOSDetectPause()
		end
	end
end

function slot0.stop(slot0, slot1)
	if not slot0._mediaPlayList then
		return
	end

	if slot0._currentPlayNameMap[slot0._mediaPlayList.PlaylistIndex] == slot1 or SettingsModel.instance:getVideoEnabled() == false then
		logNormal("targetName = " .. tostring(slot1) .. " stop!")
		slot0:_stopIOSDetectPause()

		if slot0._mediaPlayList then
			slot0._mediaPlayList:Stop()
		end

		slot0:setParent(slot0.parentGO)
		gohelper.setActive(slot0.viewGO, false)
	end

	for slot7, slot8 in pairs(slot0._currentPlayNameMap) do
		if slot8 == slot1 then
			slot0:setPathAtIndex(uv0.Empty, slot7)
		end
	end

	slot0._path2StartCallback[slot1] = nil
	slot0._path2StartCallbackObj[slot1] = nil
	slot0._path2StartVideoItem[slot1] = nil

	slot0:checkAllStop()
end

function slot0.checkAllStop(slot0)
	if not slot0._currentPlayNameMap then
		logNormal("null playlist, now stop play.")

		slot0._isPlaying = false
	else
		for slot4, slot5 in pairs(slot0._currentPlayNameMap) do
			if slot5 ~= uv0.Empty then
				return
			end
		end

		logNormal("empty playlist, now stop play.")

		slot0._isPlaying = false
	end
end

function slot0.clearOtherIndex(slot0, slot1)
	for slot5, slot6 in pairs(slot0._currentPlayNameMap) do
		if slot5 ~= slot1 then
			slot7 = slot0._currentPlayNameMap[slot5]
			slot0._currentPlayNameMap[slot5] = nil
			slot0._path2StartCallback[slot7] = nil
			slot0._path2StartCallbackObj[slot7] = nil
			slot0._path2StartVideoItem[slot7] = nil
		end
	end
end

function slot0.fixNeedPlayVideo(slot0, slot1)
	slot2, slot3 = nil

	for slot7, slot8 in pairs(slot0._currentPlayNameMap) do
		if slot8 ~= uv0.Empty then
			slot2 = slot8
			slot3 = slot7

			break
		end
	end

	logNormal(string.format("check need fix video curName [%s] evt [%s] curPos [%s] list [%s]", tostring(slot2), tostring(slot1), tostring(slot3), tostring(slot0._mediaPlayList.PlaylistIndex)))

	if slot2 ~= slot1 and not gohelper.isNil(slot0._mediaPlayList) and slot0._mediaPlayList.PlaylistIndex == slot3 then
		slot0._mediaPlayList:JumpToItem(slot3)
		slot0._mediaPlayList:Play()
		slot0._mediaPlayList:JumpToItem(slot3)
		logNormal("try fix play index : " .. tostring(slot3) .. " name : " .. tostring(slot2))
	end
end

function slot0.setPathAtIndex(slot0, slot1, slot2)
	if string.nilorempty(slot1) then
		slot0._uguiPlayList:SetMediaPath(uv0.Empty, slot2)

		slot0._currentPlayNameMap[slot2] = uv0.Empty
	else
		slot0:clearOtherIndex(slot2)
		slot0._uguiPlayList:SetMediaPath(SLFramework.FrameworkSettings.GetAssetFullPathForWWW(langVideoUrl(slot1)), slot2)

		slot0._currentPlayNameMap[slot2] = slot1
	end
end

function slot0.setParent(slot0, slot1)
	gohelper.addChildPosStay(slot1, slot0.viewGO)
end

function slot0._onVideoEvent(slot0, slot1, slot2, slot3)
	slot4 = string.split(slot1, "/")

	logNormal(string.format("StoryVideoPlayList:_onVideoEvent, path = %s \nstatus = %s errorCode = %s\ntime = %s", tostring(slot1), tostring(AvProEnum.getPlayerStatusEnumName(slot2)), AvProEnum.getErrorCodeEnumName(slot3), tostring(Time.time)))

	if slot2 == AvProEnum.PlayerStatus.FinishedPlaying then
		slot0:fixNeedPlayVideo(string.split(slot4[#slot4], ".")[1] or slot5)
		slot0:_stopIOSDetectPause()
	elseif slot2 == AvProEnum.PlayerStatus.FirstFrameReady and BootNativeUtil.isIOS() and slot0._path2StartCallback[slot5] then
		slot0._path2StartCallback[slot5](slot0._path2StartCallbackObj[slot5], slot0._path2StartVideoItem[slot5])
	end

	if slot3 ~= AvProEnum.ErrorCode.None then
		slot0:stop(slot5)
		slot0:_stopIOSDetectPause()
	end
end

function slot0._detectPause(slot0)
	if slot0._mediaPlayList and slot0._mediaPlayList:IsPaused() then
		slot0._mediaPlayList:Play()
	end
end

function slot0._startIOSDetectPause(slot0)
	if BootNativeUtil.isIOS() then
		TaskDispatcher.runRepeat(slot0._detectPause, slot0, 0.05)
	end
end

function slot0._stopIOSDetectPause(slot0)
	if BootNativeUtil.isIOS() then
		TaskDispatcher.cancelTask(slot0._detectPause, slot0)
	end
end

function slot0.getNextNormalPlayIndex(slot0)
	if slot0._lastNormalIndex == nil or slot0._lastNormalIndex == uv0.PlayPos.CommonPlay2 then
		slot0._lastNormalIndex = uv0.PlayPos.CommonPlay
	else
		slot0._lastNormalIndex = uv0.PlayPos.CommonPlay2
	end

	return slot0._lastNormalIndex
end

function slot0.dispose(slot0)
	if slot0._uguiPlayList then
		slot1 = slot0._uguiPlayList.PlaylistMediaPlayer

		slot0._uguiPlayList:Clear()
	end

	slot0:_stopIOSDetectPause()
	slot0:__onDispose()
end

return slot0
