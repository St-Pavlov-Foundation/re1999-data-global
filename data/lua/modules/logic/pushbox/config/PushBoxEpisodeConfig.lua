module("modules.logic.pushbox.config.PushBoxEpisodeConfig", package.seeall)

slot0 = class("PushBoxEpisodeConfig", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"push_box_episode",
		"push_box_activity",
		"push_box_task"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "push_box_episode" then
		-- Nothing
	end
end

function slot0.getConfig(slot0, slot1)
	return lua_push_box_episode.configDict[slot1]
end

function slot0.getEpisodeList(slot0)
	if slot0._episode_list then
		return slot0._episode_list
	end

	slot1 = {}
	slot5 = PushBoxModel.instance:getCurActivityID()

	for slot5, slot6 in pairs(lua_push_box_activity.configDict[slot5]) do
		table.insert(slot1, slot6)
	end

	function slot5(slot0, slot1)
		return slot0.stageId < slot1.stageId
	end

	table.sort(slot1, slot5)

	slot0._episode_list = {}
	slot0._episode2stageID = {}

	for slot5, slot6 in ipairs(slot1) do
		for slot10, slot11 in ipairs(slot6.episodeIds) do
			table.insert(slot0._episode_list, slot0:getConfig(slot11))

			slot0._episode2stageID[slot11] = slot6.stageId
		end
	end

	return slot0._episode_list
end

function slot0.getStageIDByEpisodeID(slot0, slot1)
	return slot0._episode2stageID[slot1]
end

function slot0.getStageConfig(slot0, slot1)
	return lua_push_box_activity.configDict[PushBoxModel.instance:getCurActivityID()][slot1]
end

function slot0.getTaskList(slot0)
	if slot0._task_list then
		return slot0._task_list
	end

	slot0._task_list = {}
	slot4 = PushBoxModel.instance:getCurActivityID()

	for slot4, slot5 in pairs(lua_push_box_task.configDict[slot4]) do
		table.insert(slot0._task_list, slot5)
	end

	return slot0._task_list
end

slot0.instance = slot0.New()

return slot0
