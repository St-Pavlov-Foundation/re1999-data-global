module("modules.logic.versionactivity2_4.wuerlixi.config.WuErLiXiConfig", package.seeall)

slot0 = class("WuErLiXiConfig", BaseConfig)

function slot0.onInit(slot0)
	slot0._taskDict = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"activity180_episode",
		"activity180_task",
		"activity180_element"
	}
end

function slot0.getMapCo(slot0, slot1)
	if not addGlobalModule("modules.configs.wuerlixi.lua_wuerlixi_map_" .. tostring(slot1), "lua_wuerlixi_map_" .. tostring(slot1)) then
		logError("乌尔里希地图配置不存在" .. slot1)

		return
	end

	return slot2
end

function slot0.getEpisodeByMapId(slot0, slot1)
	if not slot0._mapIdToEpisodeCo then
		slot0._mapIdToEpisodeCo = {}

		for slot5, slot6 in ipairs(lua_activity180_episode.configList) do
			slot0._mapIdToEpisodeCo[slot6.mapId] = slot6
		end
	end

	return slot0._mapIdToEpisodeCo[slot1]
end

function slot0.getEpisodeCoList(slot0, slot1)
	if not slot0._episodeDict then
		slot0._episodeDict = {}

		for slot5, slot6 in ipairs(lua_activity180_episode.configList) do
			if not slot0._episodeDict[slot6.activityId] then
				slot0._episodeDict[slot6.activityId] = {}
			end

			table.insert(slot0._episodeDict[slot6.activityId], slot6)
		end
	end

	return slot0._episodeDict[slot1] or {}
end

function slot0.getEpisodeCo(slot0, slot1, slot2)
	for slot7, slot8 in pairs(slot0:getEpisodeCoList(slot1)) do
		if slot8.episodeId == slot2 then
			return slot8
		end
	end
end

function slot0.getTaskByActId(slot0, slot1)
	if not slot0._taskDict[slot1] then
		slot2 = {}

		for slot6, slot7 in ipairs(lua_activity180_task.configList) do
			if slot7.activityId == slot1 then
				table.insert(slot2, slot7)
			end
		end

		slot0._taskDict[slot1] = slot2
	end

	return slot2
end

function slot0.getElementList(slot0)
	return lua_activity180_element.configList
end

function slot0.getElementCo(slot0, slot1)
	return lua_activity180_element.configDict[slot1]
end

slot0.instance = slot0.New()

return slot0
