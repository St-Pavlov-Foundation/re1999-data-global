module("modules.logic.versionactivity2_2.lopera.config.Activity168Config", package.seeall)

slot0 = class("Activity168Config", BaseConfig)

function slot0.onInit(slot0)
	slot0._episodeConfig = nil
	slot0._eventConfig = nil
	slot0._optionConfig = nil
	slot0._effectConfig = nil
	slot0._itemConfig = nil
	slot0._taskCfg = nil
	slot0._composeTypeCfg = nil
	slot0._composeItemCfg = nil
	slot0._constCfg = nil
	slot0._endlessCfg = nil
	slot0._episodeDict = {}
	slot0._mapCfgField = {
		id = 1,
		name = 3,
		coord = 2,
		isStart = 6,
		dir = 4,
		event = 5,
		isEnd = 7
	}
end

function slot0.reqConfigNames(slot0)
	return {
		"activity168_episode",
		"activity168_event",
		"activity168_option",
		"activity168_effect",
		"activity168_item",
		"activity168_compose_type",
		"activity168_task",
		"activity168_const",
		"activity168_endless_event"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity168_episode" then
		slot0._episodeConfig = slot2
		slot0._episodeDict = {}

		for slot6, slot7 in ipairs(slot0._episodeConfig.configList) do
			slot0._episodeDict[slot7.activityId] = slot0._episodeDict[slot7.activityId] or {}

			table.insert(slot0._episodeDict[slot7.activityId], slot7)
		end
	elseif slot1 == "activity168_event" then
		slot0._eventConfig = slot2
	elseif slot1 == "activity168_option" then
		slot0._optionConfig = slot2
	elseif slot1 == "activity168_effect" then
		slot0._effectConfig = slot2
	elseif slot1 == "activity168_item" then
		slot0._itemConfig = slot2
	elseif slot1 == "activity168_task" then
		slot0._taskCfg = slot2
	elseif slot1 == "activity168_compose_type" then
		slot0._composeTypeCfg = slot2
	elseif slot1 == "activity168_const" then
		slot0._constCfg = slot2
	elseif slot1 == "activity168_endless_event" then
		slot0._endlessCfg = slot2
	end
end

function slot0.getEpisodeCfgList(slot0, slot1)
	return slot0._episodeDict[slot1] or {}
end

function slot0.getEpisodeCfg(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot0._episodeDict[slot1]) do
		if slot8.id == slot2 then
			return slot8
		end
	end
end

function slot0.getEventCfg(slot0, slot1, slot2)
	return slot0._eventConfig.configDict[slot1] and slot3[slot2]
end

function slot0.getEventOptionCfg(slot0, slot1, slot2)
	return slot0._optionConfig.configDict[slot1] and slot3[slot2]
end

function slot0.getOptionEffectCfg(slot0, slot1)
	return slot0._effectConfig.configDict[slot1]
end

function slot0.getGameItemCfg(slot0, slot1, slot2)
	for slot7, slot8 in pairs(slot0._itemConfig.configDict[slot1]) do
		if slot8.itemId == slot2 then
			return slot8
		end
	end
end

function slot0.getGameItemListCfg(slot0, slot1, slot2)
	slot3 = {}

	for slot8, slot9 in pairs(slot0._itemConfig.configDict[slot1]) do
		if slot2 == nil or slot9.compostType == slot2 then
			slot3[#slot3 + 1] = slot9
		end
	end

	return slot3
end

function slot0.InitMapCfg(slot0, slot1)
	slot0._mapId = slot1
	slot6 = tostring(slot1)
	slot5 = "lua_act168_map_" .. slot6
	slot0._mapCfg = addGlobalModule("modules.configs.act168.lua_act168_map_" .. tostring(slot1), slot5)
	slot0._mapRowNum = 0
	slot0._mapCalNum = 0

	for slot5, slot6 in ipairs(slot0._mapCfg) do
		slot7 = slot6[slot0._mapCfgField.coord]
		slot0._mapRowNum = math.max(slot0._mapRowNum, slot7[2])
		slot0._mapCalNum = math.max(slot0._mapCalNum, slot7[1])
	end

	slot0._mapRowNum = slot0._mapRowNum + 1
	slot0._mapCalNum = slot0._mapCalNum + 1
end

function slot0.getMapCfg(slot0, slot1)
	if not slot0._mapCfg or slot0._mapId ~= slot1 then
		slot0:InitMapCfg(slot1)
	end

	return slot0._mapCfg
end

function slot0.getMapStartCell(slot0)
	for slot4, slot5 in ipairs(slot0._mapCfg) do
		if slot5[slot0._mapCfgField.isStart] then
			return slot5
		end
	end
end

function slot0.getMapEndCell(slot0)
	for slot4, slot5 in ipairs(slot0._mapCfg) do
		if slot5[slot0._mapCfgField.isEnd] then
			return slot5
		end
	end
end

function slot0.getMapCell(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._mapCfg) do
		if slot6[slot0._mapCfgField.id] == slot1 then
			return slot6
		end
	end
end

function slot0.getMapCellByCoord(slot0, slot1)
	return slot0._mapCfg[slot1[1] + slot0._mapCalNum * slot1[2] + 1]
end

function slot0.getTaskList(slot0, slot1)
	if slot0._task_list then
		return slot0._task_list
	end

	slot0._task_list = {}

	for slot5, slot6 in pairs(slot0._taskCfg.configDict) do
		if slot1 == slot6.activityId then
			slot0._task_list[#slot0._task_list + 1] = slot6
		end
	end

	return slot0._task_list
end

function slot0.getComposeTypeList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0._composeTypeCfg.configList) do
		if slot1 == slot7.activityId then
			slot2[#slot2 + 1] = slot7
		end
	end

	return slot2
end

function slot0.getComposeTypeCfg(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0._composeTypeCfg.configList) do
		if slot1 == slot7.activityId and slot2 == slot7.composeType then
			return slot7
		end
	end
end

function slot0.getConstCfg(slot0, slot1, slot2)
	if not slot0._constCfg.configDict[slot1] then
		return
	end

	for slot7, slot8 in pairs(slot3) do
		if slot2 == slot8.id then
			return slot8
		end
	end
end

function slot0.getConstValueCfg(slot0, slot1, slot2)
	if not slot0._constCfg.configDict[slot1] then
		return
	end

	for slot7, slot8 in ipairs(slot3) do
		if slot2 == slot8.value1 then
			return slot8
		end
	end
end

function slot0.getEndlessLevelCfg(slot0, slot1, slot2)
	if not slot0._endlessCfg.configDict[slot1] then
		return
	end

	for slot7, slot8 in ipairs(slot3) do
		if slot2 == slot8.id then
			return slot8
		end
	end
end

slot0.instance = slot0.New()

return slot0
