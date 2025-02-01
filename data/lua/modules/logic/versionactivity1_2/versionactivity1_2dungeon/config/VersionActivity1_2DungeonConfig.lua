module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.config.VersionActivity1_2DungeonConfig", package.seeall)

slot0 = class("VersionActivity1_2DungeonConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._elements = {}
end

function slot0.reqConfigNames(slot0)
	return {
		"activity116_building",
		"activity116_episode_sp"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity116_building" then
		slot0:_initConfig()
	end
end

function slot0._initConfig(slot0)
	for slot4, slot5 in ipairs(lua_activity116_building.configList) do
		slot0._elements[slot5.elementId] = slot0._elements[slot5.elementId] or {}
		slot0._elements[slot5.elementId][slot5.id] = slot5
	end
end

function slot0.getBuildingConfigsByElementID(slot0, slot1)
	return slot0._elements and slot0._elements[slot1]
end

function slot0.get1_2EpisodeMapConfig(slot0, slot1)
	slot2 = DungeonConfig.instance:getEpisodeCO(slot1)
	slot4 = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1)[1].id
	slot2 = DungeonConfig.instance:getEpisodeCO(slot4 - slot4 % 100 + slot1 % 100)

	return DungeonConfig.instance:getChapterMapCfg(slot2.chapterId, slot2.preEpisode)
end

function slot0.getEpisodeIndex(slot0, slot1)
	if (DungeonConfig.instance:get1_2VersionActivityEpisodeCoList(slot1) and DungeonConfig.instance:getEpisodeCO(slot2[1]) or DungeonConfig.instance:getEpisodeCO(slot1)).chapterId == VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard then
		slot5 = DungeonConfig.instance:getChapterEpisodeCOList(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1)[1].id

		return DungeonConfig.instance:getChapterEpisodeIndexWithSP(VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1, slot5 - slot5 % 100 + slot1 % 100)
	else
		return DungeonConfig.instance:getChapterEpisodeIndexWithSP(slot3.chapterId, slot3.id)
	end
end

function slot0.getConfigByEpisodeId(slot0, slot1)
	for slot6, slot7 in ipairs(slot0._buildingType4 or slot0:getType4List()) do
		for slot12, slot13 in ipairs(string.splitToNumber(slot7.configType, "#")) do
			if slot13 == slot1 then
				return slot7
			end
		end
	end
end

function slot0.getType4List(slot0)
	if slot0._buildingType4 then
		return slot0._buildingType4
	end

	slot0._buildingType4 = {}

	for slot4, slot5 in ipairs(lua_activity116_building.configList) do
		if slot5.buildingType == 4 then
			table.insert(slot0._buildingType4, slot5)
		end
	end

	return slot0._buildingType4
end

slot0.instance = slot0.New()

return slot0
