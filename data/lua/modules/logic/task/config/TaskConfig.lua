module("modules.logic.task.config.TaskConfig", package.seeall)

slot0 = string.format
slot1 = class("TaskConfig", BaseConfig)

function slot1.ctor(slot0)
	slot0.taskdailyConfig = nil
	slot0.taskweeklyConfig = nil
	slot0.taskactivitybonusConfig = nil
	slot0.taskachievementConfig = nil
	slot0.tasknoviceConfig = nil
	slot0.tasktypeConfig = nil
	slot0.taskseasonConfig = nil
	slot0.taskactivityshowConfig = nil
end

function slot1.reqConfigNames(slot0)
	return {
		"task_daily",
		"task_weekly",
		"task_activity_bonus",
		"task_achievement",
		"task_guide",
		"task_type",
		"task_room",
		"task_weekwalk",
		"task_season",
		"task_activity_show"
	}
end

function slot1.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "task_daily" then
		slot0.taskdailyConfig = slot2
	elseif slot1 == "task_weekly" then
		slot0.taskweeklyConfig = slot2
	elseif slot1 == "task_activity_bonus" then
		slot0.taskactivitybonusConfig = slot2
	elseif slot1 == "task_achievement" then
		slot0.taskachievementConfig = slot2
	elseif slot1 == "task_guide" then
		slot0.tasknoviceConfig = slot2
	elseif slot1 == "task_type" then
		slot0.tasktypeConfig = slot2
	elseif slot1 == "task_room" then
		slot0.taskroomConfig = slot2
	elseif slot1 == "task_weekwalk" then
		slot0:_initWeekWalkTask()
	elseif slot1 == "task_season" then
		slot0.taskseasonConfig = slot2
	elseif slot1 == "task_activity_show" then
		slot0.taskactivityshowConfig = slot2
	end
end

function slot1.getSeasonTaskCo(slot0, slot1)
	return slot0.taskseasonConfig.configDict[slot1]
end

function slot1.getWeekWalkTaskList(slot0, slot1)
	return slot0._taskTypeList[slot1]
end

function slot1._initWeekWalkTask(slot0)
	slot0._taskRewardList = {}
	slot0._taskTypeList = {}

	for slot4, slot5 in ipairs(lua_task_weekwalk.configList) do
		slot6 = slot0._taskTypeList[slot5.minTypeId] or {}

		table.insert(slot6, slot5)

		slot0._taskTypeList[slot5.minTypeId] = slot6

		slot0:_initTaskReward(slot5)
	end
end

function slot1._initTaskReward(slot0, slot1)
	slot2 = nil

	if not ((slot1.listenerType ~= "WeekwalkBattle" or tonumber(string.split(slot1.listenerParam, "#")[1])) and tonumber(slot1.listenerParam)) then
		return
	end

	slot0._taskRewardList[slot2] = slot0._taskRewardList[slot2] or {}

	for slot8 = 1, #string.split(slot1.bonus, "|") do
		if string.splitToNumber(slot4[slot8], "#")[1] == MaterialEnum.MaterialType.Currency and slot9[2] == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			slot0._taskRewardList[slot2][slot1.id] = slot9[3]
		end
	end
end

function slot1.getWeekWalkRewardList(slot0, slot1)
	return slot0._taskRewardList[slot1]
end

function slot1.gettaskdailyCO(slot0, slot1)
	return slot0.taskdailyConfig.configDict[slot1]
end

function slot1.gettaskweeklyCO(slot0, slot1)
	return slot0.taskweeklyConfig.configDict[slot1]
end

function slot1.gettaskNoviceConfigs(slot0)
	return slot0.tasknoviceConfig.configDict
end

function slot1.gettaskNoviceConfig(slot0, slot1)
	return slot0.tasknoviceConfig.configDict[slot1]
end

function slot1.gettaskactivitybonusCO(slot0, slot1, slot2)
	if slot0.taskactivitybonusConfig.configDict[slot1] then
		return slot3[slot2]
	end
end

function slot1.getTaskActivityBonusConfig(slot0, slot1)
	return slot0.taskactivitybonusConfig.configDict[slot1]
end

function slot1.getTaskBonusValue(slot0, slot1, slot2, slot3)
	slot0.taskBonusValueDict = slot0.taskBonusValueDict or {}

	if not slot0.taskBonusValueDict[slot1] then
		slot0.taskBonusValueDict[slot1] = {}

		if not slot0:getTaskActivityBonusConfig(slot1) then
			logError("not found task bonus , type : " .. tostring(slot1))

			return 0
		end

		slot5 = {}

		for slot9, slot10 in pairs(slot4) do
			table.insert(slot5, slot10)
		end

		table.sort(slot5, function (slot0, slot1)
			return slot0.id < slot1.id
		end)

		slot6 = nil

		for slot10, slot11 in ipairs(slot5) do
			slot0.taskBonusValueDict[slot1][slot10] = (slot6 and slot0.taskBonusValueDict[slot1][slot6] or 0) + slot11.needActivity
			slot6 = slot10
		end
	end

	return (slot0.taskBonusValueDict[slot1][slot2 - 1] or 0) + slot3
end

function slot1.gettaskachievementCO(slot0, slot1)
	return slot0.taskachievementConfig.configDict[slot1]
end

function slot1.gettasktypeCO(slot0, slot1)
	return slot0.tasktypeConfig.configDict[slot1]
end

function slot1.gettaskRoomCO(slot0, slot1)
	return slot0.taskroomConfig.configDict[slot1]
end

function slot1.gettaskroomlist(slot0)
	return slot0.taskroomConfig.configList
end

function slot1.getTaskActivityShowConfig(slot0, slot1)
	return slot0.taskactivityshowConfig.configDict[slot1]
end

slot2 = "ReadTask"

function slot1.initReadTaskList(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6 = nil

	if isDebugBuild then
		slot6 = ConfigsCheckerMgr.instance:createStrBuf(slot1)
	end

	for slot10, slot11 in ipairs(slot4.configList) do
		if not slot2[slot11.activityId] then
			slot13 = {}

			for slot17, slot18 in pairs(slot3) do
				if isDebugBuild then
					slot6:appendLineIfOK(slot13[slot18], uv0("redefined enum enumKey: %s, enumValue: %s", slot17, slot18))
				end

				slot13[slot18] = {}
			end

			slot2[slot12] = slot13
		end

		if slot11.isOnline then
			if slot11.listenerType == uv1 then
				if not slot3[slot11.tag] then
					slot5 = uv0("[TaskConfig]: error actId: %s, taskId: %s", slot12, slot11.id)

					if isDebugBuild then
						slot6:appendLine(slot5)
					end

					logError(slot5)
				elseif slot13[slot15] then
					slot16[slot14] = slot11
				else
					slot5 = uv0("[TaskConfig]: unsupported actId: %s, tag: %s", slot12, slot11.tag)

					if isDebugBuild then
						slot6:appendLine(slot5)
					end

					logError(slot5)
				end
			end
		end
	end

	if isDebugBuild then
		slot6:logErrorIfGot()
	end
end

slot1.instance = slot1.New()

return slot1
