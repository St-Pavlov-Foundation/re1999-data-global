module("modules.logic.achievement.config.AchievementConfig", package.seeall)

slot0 = class("AchievementConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._achievementConfig = nil
	slot0._achievementGroupConfig = nil
	slot0._achievementTaskConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"achievement",
		"achievement_group",
		"achievement_task"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "achievement" then
		slot0:buildAchievementCfgs(slot2)
	elseif slot1 == "achievement_group" then
		slot0._achievementGroupConfig = slot2
	elseif slot1 == "achievement_task" then
		slot0._achievementTaskConfig = slot2

		slot0:initAchievementTask()
	end
end

function slot0.buildAchievementCfgs(slot0, slot1)
	slot0._achievementConfig = slot1

	slot0:initAchievementStateDict()
end

function slot0.initAchievementStateDict(slot0)
	slot0._achievementState = {}
	slot0._waitOnlineList = {}
	slot0._waitOfflineList = {}

	for slot4, slot5 in pairs(AchievementEnum.AchievementState) do
		slot0._achievementState[slot5] = {}
	end
end

function slot0.initWaitAchievements(slot0)
	slot0:initAchievementStateDict()

	for slot4, slot5 in ipairs(slot0._achievementConfig.configList) do
		slot6, slot7, slot8 = slot0:checkAchievementState(slot5)

		table.insert(slot0._achievementState[slot6], slot5)

		if slot7 then
			table.insert(slot0._waitOnlineList, slot5)
		end

		if slot8 then
			table.insert(slot0._waitOfflineList, slot5)
		end
	end
end

function slot0.checkAchievementState(slot0, slot1)
	slot3 = slot1.endTime
	slot4, slot5 = nil
	slot6 = AchievementEnum.AchievementState.Online

	if not string.nilorempty(slot1.startTime) then
		slot4 = TimeUtil.stringToTimestamp(slot2) + ServerTime.clientToServerOffset() - ServerTime.now()
	end

	if not string.nilorempty(slot3) then
		slot5 = TimeUtil.stringToTimestamp(slot3) + ServerTime.clientToServerOffset() - ServerTime.now()
	end

	if slot4 and slot5 and slot5 <= slot4 then
		logError("成就下架时间不可早于或等于成就上架时间,成就id = " .. slot1.id)
	end

	slot8 = slot5 and slot5 > 0

	if slot4 and slot4 > 0 or slot5 and slot5 < 0 then
		slot6 = AchievementEnum.AchievementState.Offline
	end

	return slot6, slot7, slot8
end

function slot0.initAchievementTask(slot0)
	slot0._taskFirstLevelDict = {}

	for slot4, slot5 in ipairs(slot0._achievementTaskConfig.configList) do
		if (slot0._taskFirstLevelDict[slot5.achievementId] or slot5) and slot5.level < slot6.level then
			slot6 = slot5
		end

		slot0._taskFirstLevelDict[slot5.achievementId] = slot6
	end
end

function slot0.getAchievement(slot0, slot1)
	return slot0._achievementConfig.configDict[slot1]
end

function slot0.getTask(slot0, slot1)
	return slot0._achievementTaskConfig.configDict[slot1]
end

function slot0.getGroup(slot0, slot1)
	return slot0._achievementGroupConfig.configDict[slot1]
end

function slot0.getAchievementFirstTask(slot0, slot1)
	return slot0._taskFirstLevelDict[slot1]
end

function slot0.getTaskByAchievementLevel(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot0._achievementTaskConfig.configList) do
		if slot7.achievementId == slot1 and slot7.level == slot2 then
			return slot7
		end
	end

	return nil
end

function slot0.getAchievementMaxLevelTask(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0._achievementTaskConfig.configList) do
		if slot7.achievementId == slot1 then
			table.insert(slot2, slot7)
		end
	end

	table.sort(slot2, slot0.achievementTaskSortFuncByLevel)

	return slot2[1]
end

function slot0.achievementTaskSortFuncByLevel(slot0, slot1)
	if slot0.level ~= slot1.level then
		return slot1.level < slot0.level
	end

	return slot0.id < slot1.id
end

function slot0.getAchievementsByGroupId(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in ipairs(slot0._achievementConfig.configList) do
		if slot8.groupId == slot1 then
			table.insert(slot3, slot8)
		end
	end

	table.sort(slot3, slot2 or uv0.achievmentSortFuncInGroup)

	return slot3
end

function slot0.achievmentSortFuncInGroup(slot0, slot1)
	if slot0.order ~= slot1.order then
		return slot0.order < slot1.order
	else
		return slot0.id < slot1.id
	end
end

function slot0.getTasksByAchievementId(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0._achievementTaskConfig.configList) do
		if slot7.achievementId == slot1 then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.getAllAchievements(slot0)
	return slot0._achievementConfig.configList
end

function slot0.getOnlineAchievements(slot0)
	return slot0._achievementState[AchievementEnum.AchievementState.Online]
end

function slot0.getAllTasks(slot0)
	return slot0._achievementTaskConfig.configList
end

function slot0.getCategoryAchievementMap(slot0)
	slot1 = {
		[slot5] = {}
	}

	for slot5, slot6 in ipairs(AchievementEnum.Type) do
		-- Nothing
	end

	if slot0:getOnlineAchievements() then
		for slot6, slot7 in ipairs(slot2) do
			slot1[slot7.category] = slot1[slot7.category] or {}

			table.insert(slot1[slot7.category], slot7)
		end
	end

	return slot1
end

function slot0.getGroupBgUrl(slot0, slot1, slot2, slot3)
	if slot0:getGroupEditConfigData(slot1, slot2) then
		return slot3 and slot4.groupUpgradeBgUrl or slot4.groupNormalBgUrl
	end
end

function slot0.getAchievementPosAndScaleInGroup(slot0, slot1, slot2, slot3)
	if slot0:getGroupEditConfigData(slot1, slot3) and slot4.id[slot2] then
		return slot4.pX[slot2], slot4.pY[slot2], slot4.sX[slot2], slot4.sY[slot2]
	end
end

function slot0.getGroupTitleColorConfig(slot0, slot1, slot2)
	if slot0:getGroupEditConfigData(slot1, slot2) and slot3.groupTitleColor then
		return slot3.groupTitleColor
	end
end

function slot0.getGroupParamIdTab(slot0, slot1, slot2)
	if slot0:getGroupEditConfigData(slot1, slot2) and slot3.id then
		return slot3.id
	end
end

function slot0.getGroupEditConfigData(slot0, slot1, slot2)
	slot0._groupParamTab = slot0._groupParamTab or {}

	if not slot0._groupParamTab[slot1] then
		slot0._groupParamTab[slot1] = {}
	end

	if not slot0._groupParamTab[slot1][slot2] then
		slot3 = slot0:getGroup(slot1)

		if slot2 == AchievementEnum.GroupParamType.List then
			if not string.nilorempty(slot3.uiListParam) then
				slot0._groupParamTab[slot1][slot2] = cjson.decode(slot3.uiListParam)
			end
		elseif slot2 == AchievementEnum.GroupParamType.Player and not string.nilorempty(slot3.uiPlayerParam) then
			slot0._groupParamTab[slot1][slot2] = cjson.decode(slot3.uiPlayerParam)
		end
	end

	return slot0._groupParamTab[slot1][slot2]
end

function slot0.getWaitOnlineAchievementList(slot0)
	return slot0._waitOnlineList
end

function slot0.getWaitOfflineAchievementList(slot0)
	return slot0._waitOfflineList
end

function slot0.getStateAchievement(slot0, slot1)
	return slot0._achievementState and slot0._achievementState[slot1]
end

function slot0.updateAchievementStateInternal(slot0, slot1, slot2, slot3)
	if slot0:getStateAchievement(slot2) then
		tabletool.removeValue(slot4, slot1)
	end

	table.insert(slot0:getStateAchievement(slot3), slot1)
end

function slot0.onAchievementArriveOnlineTime(slot0, slot1)
	slot2 = slot0:getAchievement(slot1)

	slot0:updateAchievementStateInternal(slot2, AchievementEnum.AchievementState.Offline, AchievementEnum.AchievementState.Online)
	tabletool.removeValue(slot0._waitOnlineList, slot2)
end

function slot0.onAchievementArriveOfflineTime(slot0, slot1)
	slot2 = slot0:getAchievement(slot1)

	slot0:updateAchievementStateInternal(slot2, AchievementEnum.AchievementState.Online, AchievementEnum.AchievementState.Offline)
	tabletool.removeValue(slot0._waitOfflineList, slot2)
end

slot0.instance = slot0.New()

return slot0
