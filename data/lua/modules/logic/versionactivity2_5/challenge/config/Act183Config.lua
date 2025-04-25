module("modules.logic.versionactivity2_5.challenge.config.Act183Config", package.seeall)

slot0 = class("Act183Config", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"challenge_episode",
		"challenge_daily_unlock",
		"challenge_condition",
		"challenge_badge",
		"challenge_task",
		"challenge_const"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "challenge_episode" then
		slot0:_onEpisodeConfigLoaded(slot2)
	elseif slot1 == "challenge_reward" then
		slot0:_onRewardConfigsLoad(slot2)
	elseif slot1 == "challenge_task" then
		slot0:_onTaskConfigLoaded(slot2)
	end
end

function slot0._onEpisodeConfigLoaded(slot0, slot1)
	slot0._episodeTab = slot1
	slot0._episodeGroupTab = {}

	for slot5, slot6 in ipairs(slot1.configList) do
		slot7 = slot6.groupId

		if not slot0._episodeGroupTab[slot6.activityId] then
			slot0._episodeGroupTab[slot8] = {}
		end

		if not slot9[slot7] then
			slot9[slot7] = {}
		end

		table.insert(slot10, slot6)
	end
end

function slot0.getEpisodeCo(slot0, slot1)
	if not slot0._episodeTab.configDict[slot1] then
		logError(string.format("关卡配置不存在 episodeId = %s", slot1))
	end

	return slot2
end

function slot0.getEpisodeCosByGroupId(slot0, slot1, slot2)
	if not (slot0._episodeGroupTab[slot1] and slot3[slot2]) then
		logError(string.format("关卡组配置不存在 activityId = %s, groupId = %s", slot1, slot2))
	end

	return slot4
end

function slot0.getEpisodeAllRuleDesc(slot0, slot1)
	slot4 = slot0:getEpisodeRuleDesc(slot1, 2)

	if not string.nilorempty(slot0:getEpisodeRuleDesc(slot1, 1)) then
		table.insert({}, slot3)
	end

	if not string.nilorempty(slot4) then
		table.insert(slot2, slot4)
	end

	return slot2
end

function slot0.getEpisodeRuleDesc(slot0, slot1, slot2)
	if not slot0:getEpisodeCo(slot1) then
		return
	end

	if slot2 == 1 then
		return slot3.ruleDesc1
	elseif slot2 == 2 then
		return slot3.ruleDesc2
	else
		logError(string.format("关卡机制序号不存在 episodeId = %s, ruleIndex = %s", slot1, slot2))
	end
end

function slot0._onRewardConfigsLoad(slot0, slot1)
	slot0._taskTab = slot1
	slot0._taskChapterTab = {}

	for slot5, slot6 in ipairs(slot1.configList) do
		if not slot0._taskChapterTab[slot6.type1] then
			slot0._taskChapterTab[slot6.type1] = {}
		end

		if not slot7[slot6.type2] then
			slot7[slot6.type2] = {}
		end

		table.insert(slot8, slot6)
	end
end

function slot0.getAllTaskByType(slot0, slot1)
	if not slot0._taskChapterTab[slot1] then
		logError(string.format("无法找到挑战任务配置! taskType = %s", slot1))
	end

	return slot2
end

function slot0.getChapterTasks(slot0, slot1, slot2)
	if not (slot0:getAllTaskByType(slot1) and slot3[slot2]) then
		logError(string.format("无法找到挑战任务配置! taskType = %s, subTaskType = %s", slot1, slot2))
	end

	return slot4
end

function slot0.getConditionCo(slot0, slot1)
	if not (lua_challenge_condition and lua_challenge_condition.configDict[slot1]) then
		logError(string.format("战斗条件配置为空 conditionId = %s", slot1))
	end

	return slot2
end

function slot0.getActivityBadgeCos(slot0, slot1)
	if not lua_challenge_badge.configDict[slot1] then
		logError(string.format("活动中的神秘刻纹配置为空 activityId = %s", slot1, slot1))
	end

	return slot2
end

function slot0.getBadgeCo(slot0, slot1, slot2)
	if not (slot0:getActivityBadgeCos(slot1) and slot3[slot2]) then
		logError(string.format("神秘刻纹配置为空 activityId = %s, badgeNum = %s", slot1, slot2))
	end

	return slot4
end

function slot0.getEpisodeConditions(slot0, slot1, slot2)
	if slot0:getEpisodeCo(slot1, slot2) then
		return string.splitToNumber(slot3.condition, "#")
	end
end

function slot0.getGroupSubEpisodeConditions(slot0, slot1, slot2)
	if not slot0:getEpisodeCosByGroupId(slot1, slot2) then
		return
	end

	slot4 = {}

	for slot8, slot9 in ipairs(slot3) do
		if Act183Helper.getEpisodeType(slot9.episodeId) == Act183Enum.EpisodeType.Sub then
			tabletool.addValues(slot4, string.splitToNumber(slot9.condition, "#"))
		end
	end

	return slot4
end

function slot0._onTaskConfigLoaded(slot0, slot1)
	slot0._taskTab = slot1
	slot0._taskTypeMap = {}
	slot0._taskGroupMap = {}

	for slot5, slot6 in ipairs(slot1.configList) do
		slot0:_onSingleTaskConfigLoaded(slot6)
	end
end

function slot0._onSingleTaskConfigLoaded(slot0, slot1)
	if not (slot1.isOnline == 1) then
		return
	end

	if not slot0._taskTypeMap[slot1.activityId] then
		slot0._taskTypeMap[slot3] = {}
	end

	if not slot4[slot1.type] then
		slot4[slot5] = {}
	end

	table.insert(slot6, slot1)

	slot0._taskGroupMap[slot7] = slot0._taskGroupMap[slot1.groupId] or {}

	table.insert(slot0._taskGroupMap[slot7], slot1)
end

function slot0.getAllOnlineTypeTasks(slot0, slot1, slot2)
	return slot0._taskTypeMap[slot1] and slot3[slot2]
end

function slot0.getAllOnlineGroupTasks(slot0, slot1)
	return slot0._taskGroupMap and slot0._taskGroupMap[slot1]
end

function slot0.getTaskConfig(slot0, slot1)
	if not lua_challenge_task.configDict[slot1] then
		logError(string.format("任务配置不存在 taskId = %s", slot1))
	end

	return slot2
end

function slot0.getPreEpisodeIds(slot0, slot1, slot2)
	if slot0:getEpisodeCo(slot1, slot2) and string.nilorempty(slot3.preEpisodeIds) then
		return string.splitToNumber(slot3.preEpisodeIds, "#")
	end
end

slot0.instance = slot0.New()

return slot0
