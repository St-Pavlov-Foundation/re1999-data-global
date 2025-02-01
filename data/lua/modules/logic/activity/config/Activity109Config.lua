module("modules.logic.activity.config.Activity109Config", package.seeall)

slot0 = class("Activity109Config", BaseConfig)

function slot0.ctor(slot0)
	slot0._act109Objects = nil
	slot0._act109Map = nil
	slot0._act109Episode = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"activity109_map",
		"activity109_interact_object",
		"activity109_episode",
		"activity109_task"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity109_interact_object" then
		slot0._act109Objects = slot2
	elseif slot1 == "activity109_map" then
		slot0._act109Map = slot2
	elseif slot1 == "activity109_episode" then
		slot0._act109Episode = slot2
	end
end

function slot0.getInteractObjectCo(slot0, slot1, slot2)
	if slot0._act109Objects.configDict[slot1] then
		return slot0._act109Objects.configDict[slot1][slot2]
	end

	return nil
end

function slot0.getMapCo(slot0, slot1, slot2)
	if slot0._act109Map.configDict[slot1] then
		return slot0._act109Map.configDict[slot1][slot2]
	end

	return nil
end

function slot0.getEpisodeCo(slot0, slot1, slot2)
	if slot0._act109Episode.configDict[slot1] then
		return slot0._act109Episode.configDict[slot1][slot2]
	end

	return nil
end

function slot0.getEpisodeList(slot0, slot1)
	if slot0._episode_list then
		return slot0._episode_list, slot0._chapter_id_list
	end

	slot0._episode_list = {}
	slot0._chapter_id_list = {}

	for slot5, slot6 in pairs(lua_activity109_episode.configDict[slot1]) do
		table.insert(slot0._episode_list, slot6)

		if not tabletool.indexOf(slot0._chapter_id_list, slot6.chapterId) and slot6.chapterId then
			table.insert(slot0._chapter_id_list, slot6.chapterId)
		end
	end

	table.sort(slot0._episode_list, uv0.sortEpisode)
	table.sort(slot0._chapter_id_list, uv0.sortChapter)

	return slot0._episode_list, slot0._chapter_id_list
end

function slot0.sortEpisode(slot0, slot1)
	return slot0.id < slot1.id
end

function slot0.sortChapter(slot0, slot1)
	return slot0 < slot1
end

function slot0.getTaskList(slot0)
	if slot0._task_list then
		return slot0._task_list
	end

	slot0._task_list = {}

	for slot4, slot5 in pairs(lua_activity109_task.configDict) do
		if Activity109Model.instance:getCurActivityID() == slot5.activityId then
			table.insert(slot0._task_list, slot5)
		end
	end

	return slot0._task_list
end

slot0.instance = slot0.New()

return slot0
