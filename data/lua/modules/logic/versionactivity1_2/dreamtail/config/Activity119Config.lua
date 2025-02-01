module("modules.logic.versionactivity1_2.dreamtail.config.Activity119Config", package.seeall)

slot0 = class("Activity119Config", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"activity119_episode",
		"activity119_task"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
end

function slot0.onInit(slot0)
	slot0._dict = nil
end

function slot0.getConfig(slot0, slot1, slot2)
	if not slot0._dict then
		slot0._dict = {}

		for slot6, slot7 in ipairs(lua_activity119_episode.configList) do
			if not slot0._dict[slot7.activityId] then
				slot0._dict[slot7.activityId] = {}
			end

			if not slot0._dict[slot7.activityId][slot7.tabId] then
				slot0._dict[slot7.activityId][slot7.tabId] = {
					taskList = {},
					tabId = slot7.tabId
				}
			end

			if DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot7.id).chapterId).type == DungeonEnum.ChapterType.DreamTailHard then
				slot0._dict[slot7.activityId][slot7.tabId].hardCO = slot7
			else
				slot0._dict[slot7.activityId][slot7.tabId].normalCO = slot7
			end
		end

		for slot6, slot7 in ipairs(lua_activity119_task.configList) do
			slot0._dict[slot7.activityId][slot7.tabId].taskList[slot7.sort] = slot7
		end
	end

	return slot0._dict[slot1][slot2]
end

slot0.instance = slot0.New()

return slot0
