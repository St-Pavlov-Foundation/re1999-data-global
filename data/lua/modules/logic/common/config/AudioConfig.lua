module("modules.logic.common.config.AudioConfig", package.seeall)

slot0 = class("AudioConfig", BaseConfig)

setNeedLoadModule("modules.logic.common.config.auto_mouth_data", "auto_mouth_data")

function slot0.reqConfigNames(slot0)
	return {
		"role_audio",
		"ui_audio",
		"bg_audio",
		"fight_audio",
		"story_audio",
		"story_role_audio",
		"effect_audio",
		"effect_with_audio",
		"story_audio_main",
		"story_audio_branch",
		"story_audio_system",
		"story_audio_role",
		"story_audio_effect",
		"story_audio_short"
	}
end

function slot0.onInit(slot0)
	slot0:_loadAutoMouthConfig()
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "effect_with_audio" then
		slot0._effectToAudioConfigDict = {}

		for slot8, slot9 in pairs(slot2.configDict) do
			slot0._effectToAudioConfigDict["effects/prefabs/" .. slot9.effect .. ".prefab"] = slot9
		end
	end
end

function slot0.InitCSByConfig(slot0, slot1)
	slot6 = slot0

	for slot5, slot6 in pairs(slot0.getAudioCO(slot6)) do
		slot0:_InitCS(slot1, slot6)
	end
end

function slot0._InitCS(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	slot1:InitConfig(slot2.id, slot2.eventName, slot2.bankName)
end

function slot0.getAudioCO(slot0)
	if not slot0._audioId2AudioCODict then
		slot0._audioId2AudioCODict = {}

		slot0:_buildRelation(lua_role_audio.configList)
		slot0:_buildRelation(lua_ui_audio.configList)
		slot0:_buildRelation(lua_bg_audio.configList)
		slot0:_buildRelation(lua_fight_audio.configList)
		slot0:_buildRelation(lua_story_audio.configList)
		slot0:_buildRelation(lua_story_audio_main.configList)
		slot0:_buildRelation(lua_story_audio_branch.configList)
		slot0:_buildRelation(lua_story_audio_system.configList)
		slot0:_buildRelation(lua_story_audio_role.configList)
		slot0:_buildRelation(lua_story_audio_effect.configList)
		slot0:_buildRelation(lua_story_audio_short.configList)
		slot0:_buildRelation(lua_story_role_audio.configList)
		slot0:_buildRelation(lua_effect_audio.configList)
	end

	return slot0._audioId2AudioCODict
end

function slot0.getAudioCOById(slot0, slot1)
	slot0:getAudioCO()

	return slot0._audioId2AudioCODict[slot1]
end

function slot0._buildRelation(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0._audioId2AudioCODict[slot6.id] = slot6
	end
end

function slot0.getAudioConfig(slot0, slot1)
	return slot0._effectToAudioConfigDict and slot0._effectToAudioConfigDict[slot1]
end

function slot0._loadAutoMouthConfig(slot0)
	slot0._allMouthDic = {}

	if GameResMgr.IsFromEditorDir then
		for slot6 = 1, SLFramework.FileHelper.GetDirFilePaths(SLFramework.FrameworkSettings.AssetRootDir .. "/configs/auto_mouth").Length do
			if not string.find(slot1[slot6 - 1], ".meta") then
				loadNonAbAsset("configs/auto_mouth/" .. SLFramework.FileHelper.GetFileName(slot7, true), SLFramework.AssetType.TEXT, slot0._onConfigNoAbCallback, slot0)
			end
		end
	else
		loadAbAsset("configs/auto_mouth", false, slot0._onConfigAbCallback, slot0)
	end
end

function slot0._onConfigNoAbCallback(slot0, slot1)
	if not slot1.IsLoadSuccess then
		logError("config load fail: " .. slot1.ResPath)

		return
	end

	slot0._allMouthDic[SLFramework.FileHelper.GetFileName(slot1.ResPath, false)] = slot0:_decodeJsonStr(slot1.TextAsset)
end

function slot0._decodeJsonStr(slot0, slot1)
	slot2 = nil

	if isDebugBuild then
		slot3, slot4 = pcall(cjson.decode, slot1)

		if not slot3 then
			logError("配置解析失败: " .. slot1)

			return
		end

		slot2 = slot4
	else
		slot2 = cjson.decode(slot1)
	end

	return slot2
end

function slot0._onConfigAbCallback(slot0, slot1)
	if not slot1.IsLoadSuccess then
		logError("config load fail: " .. slot1.ResPath)

		return
	end

	slot1:Retain()

	slot0._autoMouthAssetItem = slot1
end

function slot0.getAutoMouthData(slot0, slot1, slot2)
	if slot0:getAudioCOById(slot1) then
		if slot0._allMouthDic[slot3.bankName] == nil and slot0._autoMouthAssetItem and slot0._autoMouthAssetItem:GetResource("configs/auto_mouth/" .. slot3.bankName .. ".json") then
			slot0._allMouthDic[slot3.bankName] = cjson.decode(slot5.text)
		end

		if slot4 and slot4[slot3.eventName] then
			return slot4[slot3.eventName][slot2]
		end
	end
end

slot0.instance = slot0.New()

return slot0
