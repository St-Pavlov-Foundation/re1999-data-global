module("modules.logic.video.AvProMgr", package.seeall)

slot0 = class("AvProMgr")
slot0.Type_AvProUGUIPlayer = typeof(ZProj.AvProUGUIPlayer)
slot0.Type_DisplayUGUI = typeof(RenderHeads.Media.AVProVideo.DisplayUGUI)

function slot0.preload(slot0, slot1, slot2)
	slot0._callback = slot1
	slot0._callbackObj = slot2
	slot0._resDict = {}
	slot0._loader = MultiAbLoader.New()

	slot0._loader:setPathList(AvProMgrConfig.getPreloadList())
	slot0._loader:setOneFinishCallback(slot0._onOnePreloadCallback, slot0)
	slot0._loader:startLoad(slot0._onPreloadCallback, slot0)
end

function slot0._onOnePreloadCallback(slot0, slot1, slot2)
	slot0._resDict[slot2.ResPath] = slot2
end

function slot0._onPreloadCallback(slot0)
	if slot0._callback then
		slot0._callback(slot0._callbackObj)
	end

	slot0._callback = nil
	slot0._callbackObj = nil
end

function slot0._getGOInstance(slot0, slot1, slot2, slot3)
	if SettingsModel.instance:getVideoEnabled() == false then
		slot1 = AvProMgrConfig.UrlVideoDisable
	end

	if slot0._resDict[slot1] then
		if slot4:GetResource(slot1) then
			return gohelper.clone(slot5, slot2, slot3)
		else
			logError(slot1 .. " prefab not in ab")
		end
	end

	logError(slot1 .. " videoPrefab need preload")
end

function slot0.swicthVideoUrl(slot0, slot1, slot2)
	if SettingsModel.instance:getVideoCompatible() then
		return slot2
	end

	return slot1
end

function slot0.getVideoPlayer(slot0, slot1, slot2)
	slot4 = slot0:_getGOInstance(slot0:swicthVideoUrl(AvProMgrConfig.UrlVideo, AvProMgrConfig.UrlVideoCompatible), slot1, slot2)

	if SettingsModel.instance:getVideoEnabled() == false then
		return AvProUGUIPlayer_adjust.instance, nil, slot4
	end

	slot6 = slot4:GetComponent(uv0.Type_DisplayUGUI)
	slot6.ScaleMode = UnityEngine.ScaleMode.ScaleAndCrop

	return slot4:GetComponent(uv0.Type_AvProUGUIPlayer), slot6, slot4
end

function slot0.getFightUrl(slot0)
	if SettingsModel.instance:getVideoEnabled() == false then
		return AvProMgrConfig.UrlVideoDisable
	end

	return slot0:swicthVideoUrl(AvProMgrConfig.UrlFightVideo, AvProMgrConfig.UrlFightVideoCompatible)
end

function slot0.getStoryUrl(slot0)
	if SettingsModel.instance:getVideoEnabled() == false then
		return AvProMgrConfig.UrlVideoDisable
	end

	return slot0:swicthVideoUrl(AvProMgrConfig.UrlStoryVideo, AvProMgrConfig.UrlStoryVideoCompatible)
end

function slot0.getNicknameUrl(slot0)
	if SettingsModel.instance:getVideoEnabled() == false then
		return AvProMgrConfig.UrlVideoDisable
	end

	return slot0:swicthVideoUrl(AvProMgrConfig.UrlNicknameVideo, AvProMgrConfig.UrlNicknameVideoCompatible)
end

function slot0.getRolesprefabUrl(slot0, slot1)
	if SettingsModel.instance:getVideoCompatible() or BootNativeUtil.isWindows() then
		return AvProMgrConfig.URLRolesprefabDict[slot1] or slot1
	end

	return slot1
end

slot0.instance = slot0.New()

return slot0
