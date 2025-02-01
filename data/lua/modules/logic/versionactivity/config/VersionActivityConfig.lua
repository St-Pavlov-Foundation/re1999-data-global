module("modules.logic.versionactivity.config.VersionActivityConfig", package.seeall)

slot0 = class("VersionActivityConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
	return {
		"activity106_task",
		"activity106_order",
		"activity106_minigame",
		"version_activity_puzzle_question",
		"activity112_task",
		"activity112",
		"activity113_task",
		"activity113_dungeon",
		"activity105"
	}
end

function slot0.onInit(slot0)
	slot0.activityId2TaskCountDict = {}
	slot0.activityId2TaskConfigList = {}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity112_task" then
		slot0._activity112TaskConfig = slot2
	elseif slot1 == "activity112" then
		slot0._activity112Config = slot2
	end
end

function slot0.getAct112Config(slot0, slot1)
	return slot0._activity112Config.configDict[slot1]
end

function slot0.getActTaskDicConfig(slot0, slot1)
	if slot0._activity112TaskConfig.configDict[slot1] then
		return slot0._activity112TaskConfig.configDict[slot1]
	end
end

function slot0.getTaskConfig(slot0, slot1, slot2)
	if slot0._activity112TaskConfig.configDict[slot1] then
		return slot0._activity112TaskConfig.configDict[slot1][slot2]
	end
end

function slot0.getAct113TaskCount(slot0, slot1)
	if slot0.activityId2TaskCountDict[slot1] then
		return slot0.activityId2TaskCountDict[slot1]
	end

	for slot6, slot7 in ipairs(lua_activity113_task.configList) do
		if slot7.activityId == slot1 and slot7.isOnline == 1 then
			slot2 = 0 + 1
		end
	end

	slot0.activityId2TaskCountDict[slot1] = slot2

	return slot0.activityId2TaskCountDict[slot1]
end

function slot0.getAct113TaskList(slot0, slot1)
	if slot0.activityId2TaskConfigList[slot1] then
		return slot0.activityId2TaskConfigList[slot1]
	end

	slot2 = {}

	for slot6, slot7 in ipairs(lua_activity113_task.configList) do
		if slot7.activityId == slot1 then
			table.insert(slot2, slot7)
		end
	end

	slot0.activityId2TaskConfigList[slot1] = slot2

	return slot0.activityId2TaskConfigList[slot1]
end

function slot0.getAct113TaskConfig(slot0, slot1)
	return lua_activity113_task.configDict[slot1]
end

function slot0.getAct113DungeonChapterIsOpen(slot0, slot1)
	if not lua_activity113_dungeon.configDict[slot1] then
		return true
	end

	if ActivityHelper.getActivityStatus(slot2.activityId) ~= ActivityEnum.ActivityStatus.Normal then
		return false
	end

	return ServerTime.now() - (ActivityModel.instance:getActivityInfo()[slot2.activityId]:getRealStartTimeStamp() + (slot2.openDay - 1) * TimeUtil.OneDaySecond) >= 0
end

function slot0.getAct113DungeonChapterOpenTimeStamp(slot0, slot1)
	slot2 = lua_activity113_dungeon.configDict[slot1]

	return ActivityModel.instance:getActivityInfo()[slot2.activityId]:getRealStartTimeStamp() + (slot2.openDay - 1) * TimeUtil.OneDaySecond
end

slot0.instance = slot0.New()

return slot0
