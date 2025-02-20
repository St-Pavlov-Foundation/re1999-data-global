module("modules.logic.roleactivity.config.RoleActivityConfig", package.seeall)

slot0 = class("RoleActivityConfig", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"roleactivity_enter",
		"role_activity_task"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "roleactivity_enter" then
		slot0._enterConfig = slot2
	elseif slot1 == "role_activity_task" then
		slot0._taskConfig = slot2

		slot0:_rebuildTaskConfig()
	end
end

function slot0._rebuildTaskConfig(slot0)
	slot0._taskDic = {}

	for slot4, slot5 in pairs(slot0._taskConfig.configList) do
		slot0._taskDic[slot5.id] = slot5
	end
end

function slot0.getActivityEnterInfo(slot0, slot1)
	return slot0._enterConfig.configDict[slot1]
end

function slot0.getTaskCo(slot0, slot1)
	return slot0._taskDic[slot1]
end

function slot0.getStoryLevelList(slot0, slot1)
	return DungeonConfig.instance:getChapterEpisodeCOList(slot0._enterConfig.configDict[slot1].storyGroupId)
end

function slot0.getBattleLevelList(slot0, slot1)
	slot3 = DungeonConfig.instance:getChapterEpisodeCOList(slot0._enterConfig.configDict[slot1].episodeGroupId) or {}

	table.sort(slot3, uv0.SortById)

	return slot3
end

function slot0.getActicityTaskList(slot0, slot1)
	return slot0._taskConfig.configDict[slot1]
end

function slot0.SortById(slot0, slot1)
	return slot0.id < slot1.id
end

slot0.instance = slot0.New()

return slot0
