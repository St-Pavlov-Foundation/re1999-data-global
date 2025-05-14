module("modules.logic.achievement.model.AchievementModel", package.seeall)

local var_0_0 = class("AchievementModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._levelMap = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:release()

	arg_2_0._levelMap = {}
end

function var_0_0.release(arg_3_0)
	arg_3_0._record = nil
	arg_3_0._achievementMap = nil
	arg_3_0._levelMap = nil
	arg_3_0._isInited = false
end

function var_0_0.initDatas(arg_4_0, arg_4_1)
	arg_4_0:checkBuildAchievementMap()

	arg_4_0._isInited = true

	local var_4_0 = {}

	if arg_4_1 then
		for iter_4_0 = 1, #arg_4_1 do
			local var_4_1 = arg_4_1[iter_4_0]
			local var_4_2 = AchievementConfig.instance:getTask(var_4_1.id)

			if var_4_2 then
				local var_4_3 = AchiementTaskMO.New()

				var_4_3:init(var_4_2)
				var_4_3:updateByServerData(var_4_1)
				table.insert(var_4_0, var_4_3)
			end
		end
	end

	arg_4_0:setList(var_4_0)
	arg_4_0:updateLevelMap()
end

function var_0_0.updateDatas(arg_5_0, arg_5_1)
	arg_5_0:checkBuildAchievementMap()

	if not arg_5_1 then
		return
	end

	local var_5_0 = {}

	for iter_5_0 = 1, #arg_5_1 do
		local var_5_1 = arg_5_1[iter_5_0]
		local var_5_2 = arg_5_0:getById(var_5_1.id)

		if var_5_2 == nil then
			local var_5_3 = AchievementConfig.instance:getTask(var_5_1.id)

			if var_5_3 then
				var_5_2 = AchiementTaskMO.New()

				var_5_2:init(var_5_3)
				var_5_2:updateByServerData(var_5_1)
				arg_5_0:addAtLast(var_5_2)
			end
		else
			local var_5_4 = var_5_2.hasFinished

			var_5_2:updateByServerData(var_5_1)

			if var_5_2.hasFinished and not var_5_4 then
				table.insert(var_5_0, var_5_2)
			end
		end
	end

	arg_5_0:updateLevelMap()

	return var_5_0
end

function var_0_0.updateLevelMap(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._achievementMap) do
		local var_6_0 = 0

		for iter_6_2, iter_6_3 in ipairs(iter_6_1) do
			local var_6_1 = arg_6_0:getById(iter_6_3.id)

			if var_6_1 and var_6_1.hasFinished then
				var_6_0 = iter_6_3.level
			end
		end

		arg_6_0._levelMap[iter_6_0] = var_6_0
	end
end

function var_0_0.checkBuildAchievementMap(arg_7_0)
	arg_7_0._achievementMap = {}

	local var_7_0 = AchievementConfig.instance:getAllTasks()

	for iter_7_0, iter_7_1 in ipairs(var_7_0) do
		arg_7_0._achievementMap[iter_7_1.achievementId] = arg_7_0._achievementMap[iter_7_1.achievementId] or {}

		table.insert(arg_7_0._achievementMap[iter_7_1.achievementId], iter_7_1)
	end

	for iter_7_2, iter_7_3 in pairs(arg_7_0._achievementMap) do
		if not AchievementConfig.instance:getAchievement(iter_7_2) then
			logError("achievementId in achievement_task not in config : [" .. tostring(iter_7_2) .. "]")
		end

		table.sort(iter_7_3, var_0_0.sortMapTask)
	end
end

function var_0_0.sortMapTask(arg_8_0, arg_8_1)
	return arg_8_0.level < arg_8_1.level
end

function var_0_0.getAchievementLevel(arg_9_0, arg_9_1)
	if arg_9_0._levelMap then
		return arg_9_0._levelMap[arg_9_1] or 0
	end

	return 0
end

function var_0_0.getGroupLevel(arg_10_0, arg_10_1)
	local var_10_0 = 0
	local var_10_1 = AchievementConfig.instance:getAchievementsByGroupId(arg_10_1)

	if var_10_1 then
		for iter_10_0, iter_10_1 in pairs(var_10_1) do
			local var_10_2 = arg_10_0:getAchievementLevel(iter_10_1.id)

			if var_10_0 < var_10_2 then
				var_10_0 = var_10_2
			end
		end
	end

	return var_10_0
end

function var_0_0.cleanAchievementNew(arg_11_0, arg_11_1)
	local var_11_0 = false

	if not arg_11_1 then
		return var_11_0
	end

	for iter_11_0 = 1, #arg_11_1 do
		arg_11_0:getById(arg_11_1[iter_11_0]).isNew = false
		var_11_0 = true
	end

	return var_11_0
end

function var_0_0.achievementHasNew(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0:getAchievementTaskCoList(arg_12_1)

	if var_12_0 then
		for iter_12_0, iter_12_1 in ipairs(var_12_0) do
			local var_12_1 = arg_12_0:getById(iter_12_1.id)

			if var_12_1 and var_12_1.isNew then
				return true
			end
		end
	end

	return false
end

function var_0_0.getAchievementTaskCoList(arg_13_0, arg_13_1)
	if arg_13_0._achievementMap then
		return arg_13_0._achievementMap[arg_13_1]
	end
end

function var_0_0.getGroupUnlockTime(arg_14_0, arg_14_1)
	local var_14_0
	local var_14_1 = AchievementConfig.instance:getAchievementsByGroupId(arg_14_1)

	if var_14_1 then
		for iter_14_0, iter_14_1 in ipairs(var_14_1) do
			local var_14_2 = arg_14_0:getAchievementTaskCoList(iter_14_1.id)

			if var_14_2 then
				for iter_14_2, iter_14_3 in ipairs(var_14_2) do
					local var_14_3 = arg_14_0:getById(iter_14_3.id)

					if var_14_3 and var_14_3.hasFinished and (not var_14_0 or var_14_0 > var_14_3.finishTime) then
						var_14_0 = var_14_3.finishTime
					end
				end
			end
		end
	end

	return var_14_0
end

function var_0_0.getAchievementUnlockTime(arg_15_0, arg_15_1)
	local var_15_0
	local var_15_1 = arg_15_0:getAchievementTaskCoList(arg_15_1)

	if var_15_1 then
		for iter_15_0, iter_15_1 in ipairs(var_15_1) do
			local var_15_2 = arg_15_0:getById(iter_15_1.id)

			if var_15_2 and var_15_2.hasFinished and (not var_15_0 or var_15_0 > var_15_2.finishTime) then
				var_15_0 = var_15_2.finishTime
			end
		end
	end

	return var_15_0
end

function var_0_0.achievementHasLocked(arg_16_0, arg_16_1)
	local var_16_0 = arg_16_0:getAchievementTaskCoList(arg_16_1)

	if var_16_0 then
		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			local var_16_1 = arg_16_0:getById(iter_16_1.id)

			if var_16_1 and var_16_1.hasFinished then
				return false
			end
		end
	end

	return true
end

function var_0_0.achievementGroupHasLocked(arg_17_0, arg_17_1)
	local var_17_0 = AchievementConfig.instance:getAchievementsByGroupId(arg_17_1)

	if var_17_0 then
		for iter_17_0, iter_17_1 in pairs(var_17_0) do
			if not arg_17_0:achievementHasLocked(iter_17_1.id) then
				return false
			end
		end
	end

	return true
end

function var_0_0.isGroupFinished(arg_18_0, arg_18_1)
	local var_18_0 = AchievementConfig.instance:getAchievementsByGroupId(arg_18_1)
	local var_18_1 = false

	if var_18_0 then
		for iter_18_0, iter_18_1 in pairs(var_18_0) do
			local var_18_2 = arg_18_0:getAchievementTaskCoList(iter_18_1.id)

			if var_18_2 then
				local var_18_3 = false

				for iter_18_2, iter_18_3 in pairs(var_18_2) do
					local var_18_4 = arg_18_0:getById(iter_18_3.id)

					var_18_3 = var_18_4 and var_18_4.hasFinished

					if not var_18_3 then
						break
					end
				end

				var_18_1 = var_18_3

				if not var_18_3 then
					break
				end
			end
		end
	end

	return var_18_1
end

function var_0_0.isAchievementFinished(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0:getAchievementTaskCoList(arg_19_1)

	if var_19_0 then
		for iter_19_0, iter_19_1 in ipairs(var_19_0) do
			local var_19_1 = arg_19_0:getById(iter_19_1.id)

			if not var_19_1 or not var_19_1.hasFinished then
				return false
			end
		end

		return true
	end
end

function var_0_0.getGroupFinishTaskList(arg_20_0, arg_20_1)
	local var_20_0 = AchievementConfig.instance:getAchievementsByGroupId(arg_20_1)

	if var_20_0 then
		local var_20_1 = {}

		for iter_20_0, iter_20_1 in ipairs(var_20_0) do
			local var_20_2 = AchievementConfig.instance:getTasksByAchievementId(iter_20_1.id)

			if var_20_2 then
				for iter_20_2, iter_20_3 in ipairs(var_20_2) do
					local var_20_3 = arg_20_0:getById(iter_20_3.id)

					if var_20_3 and var_20_3.hasFinished then
						table.insert(var_20_1, iter_20_3)
					end
				end
			end
		end

		return var_20_1
	end
end

function var_0_0.isAchievementTaskFinished(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_0:getById(arg_21_1)

	return var_21_0 and var_21_0.hasFinished
end

var_0_0.instance = var_0_0.New()

return var_0_0
