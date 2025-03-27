module("modules.logic.versionactivity2_4.pinball.config.PinballConfig", package.seeall)

slot0 = class("PinballConfig", BaseConfig)

function slot0.onInit(slot0)
	slot0._mapCos = {}
	slot0._taskDict = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"activity178_building",
		"activity178_building_hole",
		"activity178_const",
		"activity178_episode",
		"activity178_talent",
		"activity178_task",
		"activity178_score",
		"activity178_resource",
		"activity178_marbles"
	}
end

function slot0.getTaskByActId(slot0, slot1)
	if not slot0._taskDict[slot1] then
		slot2 = {}

		for slot6, slot7 in ipairs(lua_activity178_task.configList) do
			if slot7.activityId == slot1 then
				table.insert(slot2, slot7)
			end
		end

		slot0._taskDict[slot1] = slot2
	end

	return slot2
end

function slot0.getMapCo(slot0, slot1)
	if not slot0._mapCos[slot1] then
		slot2 = PinballMapCo.New()

		if not addGlobalModule("modules.configs.pinball.lua_pinball_map_" .. tostring(slot1), "lua_pinball_map_" .. tostring(slot1)) then
			logError("弹珠地图配置不存在" .. slot1)

			return
		end

		slot2:init(slot3)

		slot0._mapCos[slot1] = slot2
	end

	return slot0._mapCos[slot1]
end

function slot0.getConstValue(slot0, slot1, slot2)
	if lua_activity178_const.configDict[slot1][slot2] then
		return slot3.value, slot3.value2
	else
		return 0, ""
	end
end

function slot0.getAllHoleCo(slot0, slot1)
	return lua_activity178_building_hole.configDict[slot1] or {}
end

function slot0.getTalentCoByRoot(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in pairs(lua_activity178_talent.configDict[slot1]) do
		if slot8.root == slot2 then
			table.insert(slot3, slot8)
		end
	end

	return slot3
end

function slot0.getAllBuildingCo(slot0, slot1, slot2)
	if not lua_activity178_building.configDict[slot1] then
		return {}
	end

	for slot8, slot9 in pairs(slot3) do
		if slot9[1] and slot9[1].size == slot2 and slot9[1].type ~= PinballEnum.BuildingType.MainCity then
			table.insert(slot4, slot9[1])
		end
	end

	return slot4
end

function slot0.getScoreLevel(slot0, slot1, slot2)
	if not lua_activity178_score.configDict[slot1] then
		return 0, 0, 0
	end

	slot4 = 1
	slot5 = 0
	slot6 = 0

	while true do
		if not slot3[slot4 + 1] then
			slot6 = slot3[slot4].value

			break
		end

		if slot7.value <= slot2 then
			slot4 = slot4 + 1
		else
			slot5 = slot3[slot4].value
			slot6 = slot7.value

			break
		end
	end

	return slot4, slot5, slot6
end

function slot0.getRandomEpisode(slot0, slot1, slot2)
	if not slot0._episodeByType then
		slot0._episodeByType = {}

		for slot6, slot7 in pairs(lua_activity178_episode.configList) do
			slot0._episodeByType[slot7.type] = slot0._episodeByType[slot7.type] or {}

			table.insert(slot0._episodeByType[slot7.type], slot7)
		end
	end

	if not slot0._episodeByType[slot1] then
		return
	end

	slot3 = {}

	for slot7, slot8 in pairs(slot0._episodeByType[slot1]) do
		if slot8.condition <= PinballModel.instance.maxProsperity and PinballModel.instance.maxProsperity <= slot8.condition2 then
			table.insert(slot3, slot8)
		end
	end

	if #slot3 <= 0 then
		return
	end

	if slot4 > 1 and slot3[math.random(1, slot4)].id == slot2 then
		if slot4 < slot5 + 1 then
			slot5 = 1
		end

		slot6 = slot3[slot5]
	end

	return slot6
end

slot0.instance = slot0.New()

return slot0
