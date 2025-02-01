module("modules.logic.explore.config.ExploreConfig", package.seeall)

slot0 = class("ExploreConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"explore_scene",
		"explore_dialogue",
		"explore_item",
		"explore_item_type",
		"explore_unit",
		"explore_unit_effect",
		"explore_hero_effect",
		"task_explore",
		"explore_story",
		"explore_chest",
		"explore_bubble",
		"explore_signs"
	}
end

function slot0.onInit(slot0)
	slot0._chapterToMapIds = {}
	slot0._taskCos = {}
	slot0._rewardCos = {}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "explore_scene" then
		slot0.sceneConfig = slot2
		slot0.mapIdConfig = {}

		for slot6, slot7 in ipairs(slot0.sceneConfig.configList) do
			slot0.mapIdConfig[slot7.id] = slot7

			if not slot0._chapterToMapIds[slot7.chapterId] then
				slot0._chapterToMapIds[slot7.chapterId] = {}
			end

			table.insert(slot0._chapterToMapIds[slot7.chapterId], slot7.id)
		end
	elseif slot1 == "explore_item" then
		slot0.itemConfig = slot2
	elseif slot1 == "explore_item_type" then
		slot0.itemTypeConfig = slot2
	elseif slot1 == "explore_unit" then
		slot0.unitConfig = slot2
	elseif slot1 == "explore_dialogue" then
		slot0.dialogueConfig = slot2
	elseif slot1 == "explore_unit_effect" then
		slot0.unitEffectConfig = slot2
	elseif slot1 == "task_explore" then
		slot0:_buildTaskConfig()
	elseif slot1 == "explore_chest" then
		slot0:_buildRewardConfig()
	end
end

function slot0.loadExploreConfig(slot0, slot1)
	slot0._mapConfig = addGlobalModule("modules.configs.explore.lua_explore_map_" .. tostring(slot1), "lua_explore_map_" .. tostring(slot1))
end

function slot1(slot0, slot1)
	return slot0.maxProgress < slot1.maxProgress
end

function slot2(slot0, slot1)
	return slot0.id < slot1.id
end

function slot0._buildRewardConfig(slot0)
	for slot4, slot5 in ipairs(lua_explore_chest.configList) do
		slot0._rewardCos[slot5.chapterId] = slot0._rewardCos[slot5.chapterId] or {}
		slot0._rewardCos[slot5.chapterId][slot5.episodeId] = slot0._rewardCos[slot5.chapterId][slot5.episodeId] or {}

		if slot5.isCount == 1 then
			table.insert(slot0._rewardCos[slot5.chapterId][slot5.episodeId], slot5)
		end
	end

	for slot4, slot5 in pairs(slot0._rewardCos) do
		for slot9, slot10 in pairs(slot5) do
			table.sort(slot10, uv0)
		end
	end
end

function slot0.getRewardConfig(slot0, slot1, slot2)
	if not slot0._rewardCos[slot1] then
		return {}
	end

	return slot0._rewardCos[slot1][slot2] or {}
end

function slot0._buildTaskConfig(slot0)
	for slot4, slot5 in ipairs(lua_task_explore.configList) do
		if not slot0._taskCos[string.splitToNumber(slot5.listenerParam, "#")[1]] then
			slot0._taskCos[slot6[1]] = {}
		end

		if not slot0._taskCos[slot6[1]][slot6[2]] then
			slot0._taskCos[slot6[1]][slot6[2]] = {}
		end

		table.insert(slot0._taskCos[slot6[1]][slot6[2]], slot5)
	end

	for slot4, slot5 in pairs(slot0._taskCos) do
		for slot9, slot10 in pairs(slot5) do
			table.sort(slot10, uv0)
		end
	end
end

function slot0.getTaskList(slot0, slot1, slot2)
	if not slot0._taskCos[slot1] or not slot0._taskCos[slot1][slot2] then
		return {}
	end

	return slot0._taskCos[slot1][slot2]
end

function slot0.getMapConfig(slot0)
	return slot0._mapConfig
end

function slot0.getSceneId(slot0, slot1)
	return slot0.mapIdConfig[slot1].sceneId
end

function slot0.getMapIdsByChapter(slot0, slot1)
	return slot0._chapterToMapIds[slot1] or {}
end

function slot0.getAnimLength(slot0, slot1, slot2)
	if not lua_explore_anim_length[slot1] then
		return
	end

	return slot3[slot2]
end

function slot0.getMapIdConfig(slot0, slot1)
	return slot0.mapIdConfig[slot1]
end

function slot0.getEpisodeId(slot0, slot1)
	return slot0.mapIdConfig[slot1].episodeId
end

function slot0.getDialogueConfig(slot0, slot1)
	return slot0.dialogueConfig.configDict[slot1]
end

function slot0.getItemCo(slot0, slot1)
	return slot0.itemConfig.configDict[slot1]
end

function slot0.isStackableItem(slot0, slot1)
	return slot0.itemConfig.configDict[slot1] and slot2.isClientStackable or false
end

function slot0.isActiveTypeItem(slot0, slot1)
	return slot0.itemTypeConfig.configDict[slot1] and slot2.isActiveType or false
end

function slot0.getUnitName(slot0, slot1)
	if slot0.unitConfig.configDict[slot1] then
		return slot0.unitConfig.configDict[slot1].name
	end

	return slot1
end

function slot0.getUnitNeedShowName(slot0, slot1)
	if slot0.unitConfig.configDict[slot1] then
		return slot0.unitConfig.configDict[slot1].isShow
	end

	return false
end

function slot0.getUnitEffectConfig(slot0, slot1, slot2)
	if not slot1 then
		return
	end

	if slot0.unitEffectConfig.configDict[string.match(slot1, "/([0-9a-zA-Z_]+)%.prefab$")] and slot4[slot2] then
		return slot4[slot2].effectPath, slot4[slot2].isOnce == 1, slot4[slot2].audioId, slot4[slot2].isBindGo == 1, slot4[slot2].isLoopAudio == 1
	end
end

function slot0.getAssetNeedAkGo(slot0, slot1)
	if not slot1 then
		return false
	end

	slot0._pathNeedAkDict = slot0._pathNeedAkDict or {}

	if slot0._pathNeedAkDict[slot1] ~= nil then
		return slot0._pathNeedAkDict[slot1]
	end

	slot2 = false

	if slot0.unitEffectConfig.configDict[string.match(slot1, "/([0-9a-zA-Z_]+)%.prefab$")] then
		for slot8, slot9 in pairs(slot4) do
			if slot9.isBindGo then
				slot2 = true

				break
			end
		end
	end

	slot0._pathNeedAkDict[slot1] = slot2

	return slot2
end

function slot0.getArchiveTotalCount(slot0, slot1)
	if not slot0._archiveCountDict then
		slot0._archiveCountDict = {}

		for slot5, slot6 in pairs(lua_explore_story.configDict) do
			slot0._archiveCountDict[slot5] = tabletool.len(slot6)
		end
	end

	return slot0._archiveCountDict[slot1] or 0
end

slot0.instance = slot0.New()

return slot0
