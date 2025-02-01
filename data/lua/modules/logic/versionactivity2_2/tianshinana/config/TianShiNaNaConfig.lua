module("modules.logic.versionactivity2_2.tianshinana.config.TianShiNaNaConfig", package.seeall)

slot0 = class("TianShiNaNaConfig", BaseConfig)

function slot0.onInit(slot0)
	slot0._mapCos = {}
	slot0._taskDict = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"activity167_episode",
		"activity167_task",
		"activity167_bubble"
	}
end

function slot0.getMapCo(slot0, slot1)
	if not slot0._mapCos[slot1] then
		slot2 = TianShiNaNaMapCo.New()

		if not addGlobalModule("modules.configs.tianshinana.lua_tianshinana_map_" .. tostring(slot1), "lua_tianshinana_map_" .. tostring(slot1)) then
			logError("天使娜娜地图配置不存在" .. slot1)

			return
		end

		slot2:init(slot3)

		slot0._mapCos[slot1] = slot2
	end

	return slot0._mapCos[slot1]
end

function slot0.getEpisodeByMapId(slot0, slot1)
	if not slot0._mapIdToEpisodeCo then
		slot0._mapIdToEpisodeCo = {}

		for slot5, slot6 in ipairs(lua_activity167_episode.configList) do
			slot0._mapIdToEpisodeCo[slot6.mapId] = slot6
		end
	end

	return slot0._mapIdToEpisodeCo[slot1]
end

function slot0.getEpisodeCoList(slot0, slot1)
	if not slot0._episodeDict then
		slot0._episodeDict = {}

		for slot5, slot6 in ipairs(lua_activity167_episode.configList) do
			if not slot0._episodeDict[slot6.activityId] then
				slot0._episodeDict[slot6.activityId] = {}
			end

			table.insert(slot0._episodeDict[slot6.activityId], slot6)
		end
	end

	return slot0._episodeDict[slot1] or {}
end

function slot0.getBubbleCo(slot0, slot1, slot2)
	if not lua_activity167_bubble.configDict[slot1] then
		return
	end

	return slot3[slot2]
end

function slot0.getTaskByActId(slot0, slot1)
	if not slot0._taskDict[slot1] then
		slot2 = {}

		for slot6, slot7 in ipairs(lua_activity167_task.configList) do
			if slot7.activityId == slot1 then
				table.insert(slot2, slot7)
			end
		end

		slot0._taskDict[slot1] = slot2
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
