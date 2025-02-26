module("modules.logic.versionactivity1_5.dungeon.config.VersionActivity1_5DungeonConfig", package.seeall)

slot0 = class("VersionActivity1_5DungeonConfig", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"act139_dispatch_task",
		"activity140_building",
		"activity11502_episode_element",
		"act139_explore_task",
		"act139_hero_task",
		"act139_sub_hero_task",
		"activity139_const",
		"activity140_const"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity139_const" then
		slot0.exploreTaskReward = string.splitToNumber(slot2.configDict[1].value, "#")
		slot0.exploreTaskUnlockEpisodeId = tonumber(slot2.configDict[2].value)
		slot0.exploreTaskLockToastId = tonumber(slot2.configDict[3].value)
		slot0.revivalTaskUnlockEpisodeId = tonumber(slot2.configDict[4].value)
		slot0.revivalTaskLockToastId = tonumber(slot2.configDict[5].value)
	elseif slot1 == "activity140_const" then
		slot0.buildReward = string.splitToNumber(slot2.configDict[2].value, "#")
		slot0.buildUnlockEpisodeId = tonumber(slot2.configDict[3].value)
		slot0.buildLockToastId = tonumber(slot2.configDict[4].value)
	end
end

function slot0.initSubHeroTaskCo(slot0)
	if slot0.initedSubHeroTask then
		return
	end

	slot1 = {
		__index = function (slot0, slot1)
			return rawget(slot0, slot1) or rawget(slot0, "srcCo")[slot1]
		end
	}
	slot0.taskId2SubTaskListDict = {}
	slot0.subHeroTaskElementIdDict = {}

	for slot5, slot6 in ipairs(lua_act139_sub_hero_task.configList) do
		if not slot0.taskId2SubTaskListDict[slot6.taskId] then
			slot0.taskId2SubTaskListDict[slot6.taskId] = {}
		end

		slot8 = {}

		setmetatable(slot8, slot1)

		slot8.elementList = string.splitToNumber(slot6.elementIds, "#")
		slot8.srcCo = slot6
		slot8.id = slot6.id

		table.insert(slot7, slot8)

		for slot12, slot13 in ipairs(slot8.elementList) do
			slot0.subHeroTaskElementIdDict[slot13] = slot8
		end
	end

	for slot5, slot6 in ipairs(slot0.taskId2SubTaskListDict) do
		table.sort(slot6, function (slot0, slot1)
			return slot0.id < slot1.id
		end)
	end
end

function slot0.getDispatchCo(slot0, slot1)
	return lua_act139_dispatch_task.configDict[slot1]
end

function slot0.initExploreTaskCo(slot0)
	if slot0.initedExploreTask then
		return
	end

	slot0.exploreTaskCoDict = {}
	slot0.exploreTaskCoList = {}
	slot0.elementId2ExploreCoDict = {}
	slot0.initedExploreTask = true

	for slot5, slot6 in ipairs(lua_act139_explore_task.configList) do
		slot7 = {}

		setmetatable(slot7, {
			__index = function (slot0, slot1)
				return rawget(slot0, slot1) or rawget(slot0, "srcCo")[slot1]
			end
		})

		slot7.srcCo = slot6
		slot7.elementList = string.splitToNumber(slot6.elementIds, "#")
		slot8 = string.splitToNumber(slot6.areaPos, "#")
		slot7.areaPosX = slot8[1]
		slot7.areaPosY = slot8[2]

		table.insert(slot0.exploreTaskCoList, slot7)

		slot0.exploreTaskCoDict[slot6.id] = slot7

		for slot12, slot13 in ipairs(slot7.elementList) do
			slot0.elementId2ExploreCoDict[slot13] = slot7
		end
	end
end

function slot0.getExploreTaskList(slot0)
	slot0:initExploreTaskCo()

	return slot0.exploreTaskCoList
end

function slot0.getExploreTask(slot0, slot1)
	slot0:initExploreTaskCo()

	return slot0.exploreTaskCoDict[slot1]
end

function slot0.getExploreTaskByElementId(slot0, slot1)
	slot0:initExploreTaskCo()

	return slot0.elementId2ExploreCoDict[slot1]
end

function slot0.getHeroTaskCo(slot0, slot1)
	return lua_act139_hero_task.configDict[slot1]
end

function slot0.getSubHeroTaskList(slot0, slot1)
	slot0:initSubHeroTaskCo()

	return slot0.taskId2SubTaskListDict[slot1]
end

function slot0.getExploreReward(slot0)
	return slot0.exploreTaskReward[1], slot0.exploreTaskReward[2], slot0.exploreTaskReward[3]
end

function slot0.getExploreUnlockEpisodeId(slot0)
	return slot0.exploreTaskUnlockEpisodeId
end

function slot0.getSubHeroTaskCoByElementId(slot0, slot1)
	slot0:initSubHeroTaskCo()

	return slot0.subHeroTaskElementIdDict[slot1]
end

function slot0.initBuildInfoList(slot0)
	if slot0.initBuild then
		return
	end

	slot1 = {
		__index = function (slot0, slot1)
			return rawget(slot0, slot1) or rawget(slot0, "srcCo")[slot1]
		end
	}
	slot0.initBuild = true
	slot0.groupId2CoDict = {}
	slot0.buildCoList = {}

	for slot5, slot6 in ipairs(lua_activity140_building.configList) do
		if not slot0.groupId2CoDict[slot6.group] then
			slot0.groupId2CoDict[slot6.group] = {}
		end

		slot8 = {}

		setmetatable(slot8, slot1)

		slot8.costList = string.splitToNumber(slot6.cost, "#")
		slot8.id = slot6.id
		slot8.srcCo = slot6
		slot9 = string.splitToNumber(slot6.focusPos, "#")
		slot8.focusPosX = slot9[1]
		slot8.focusPosY = slot9[2]

		table.insert(slot0.buildCoList, slot8)

		slot7[slot6.type] = slot8
	end
end

function slot0.getBuildCo(slot0, slot1)
	slot0:initBuildInfoList()

	for slot5, slot6 in ipairs(slot0.buildCoList) do
		if slot6.id == slot1 then
			return slot6
		end
	end

	logError("not found build id : " .. tostring(slot1))
end

function slot0.getBuildCoByGroupAndType(slot0, slot1, slot2)
	slot0:initBuildInfoList()

	return slot0.groupId2CoDict[slot1][slot2]
end

function slot0.getBuildCoList(slot0, slot1)
	slot0:initBuildInfoList()

	return slot0.groupId2CoDict[slot1]
end

function slot0.getBuildReward(slot0)
	return slot0.buildReward[1], slot0.buildReward[2], slot0.buildReward[3]
end

function slot0.getBuildUnlockEpisodeId(slot0)
	return slot0.buildUnlockEpisodeId
end

function slot0.checkElementBelongMapId(slot0, slot1, slot2)
	slot4 = nil

	return tabletool.indexOf((string.nilorempty(lua_activity11502_episode_element.configDict[slot1.id].mapIds) or string.splitToNumber(slot3.mapIds, "#")) and {
		slot1.mapId
	}, slot2)
end

slot0.instance = slot0.New()

return slot0
