module("modules.logic.achievement.model.AchievementToastModel", package.seeall)

local var_0_0 = class("AchievementToastModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0._waitToastList = {}
	arg_1_0._groupUnlockToastMap = {}
	arg_1_0._groupFinishedToastMap = {}
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:release()
end

function var_0_0.release(arg_3_0)
	arg_3_0._waitToastList = nil
	arg_3_0._groupUnlockToastMap = nil
	arg_3_0._groupFinishedToastMap = nil
end

function var_0_0.updateNeedPushToast(arg_4_0, arg_4_1)
	arg_4_0._waitToastList = arg_4_0._waitToastList or {}
	arg_4_0._waitToastMap = arg_4_0._waitToastMap or {}
	arg_4_0._groupUnlockToastMap = arg_4_0._groupUnlockToastMap or {}
	arg_4_0._groupFinishedToastMap = arg_4_0._groupFinishedToastMap or {}

	if arg_4_1 then
		for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
			local var_4_0 = iter_4_1.id

			if iter_4_1 and iter_4_1.new then
				arg_4_0:checkTaskSatify(var_4_0)
			end
		end
	end
end

function var_0_0.checkTaskSatify(arg_5_0, arg_5_1)
	local var_5_0 = AchievementConfig.instance:getTask(arg_5_1)
	local var_5_1 = arg_5_0:getToastTypeList()

	if var_5_0 and var_5_1 then
		for iter_5_0, iter_5_1 in ipairs(var_5_1) do
			local var_5_2 = arg_5_0:getToastCheckFunction(iter_5_1)

			if var_5_2 and var_5_2(arg_5_0, var_5_0) then
				table.insert(arg_5_0._waitToastList, {
					taskId = arg_5_1,
					toastType = iter_5_0
				})
			end
		end
	end
end

function var_0_0.getToastCheckFunction(arg_6_0, arg_6_1)
	if not arg_6_0._toastCheckFuncTab then
		arg_6_0._toastCheckFuncTab = {
			[AchievementEnum.ToastType.TaskFinished] = arg_6_0.checkIsTaskFinished,
			[AchievementEnum.ToastType.GroupUnlocked] = arg_6_0.checkGroupUnlocked,
			[AchievementEnum.ToastType.GroupUpgrade] = arg_6_0.checkGroupUpgrade,
			[AchievementEnum.ToastType.GroupFinished] = arg_6_0.checkIsGroupFinished
		}
	end

	return arg_6_0._toastCheckFuncTab[arg_6_1]
end

function var_0_0.getToastTypeList(arg_7_0)
	if not arg_7_0._toastTypeList then
		arg_7_0._toastTypeList = {
			AchievementEnum.ToastType.TaskFinished,
			AchievementEnum.ToastType.GroupUnlocked,
			AchievementEnum.ToastType.GroupUpgrade,
			AchievementEnum.ToastType.GroupFinished
		}
	end

	return arg_7_0._toastTypeList
end

function var_0_0.checkIsTaskFinished(arg_8_0, arg_8_1)
	return AchievementModel.instance:isAchievementTaskFinished(arg_8_1.id)
end

function var_0_0.checkGroupUnlocked(arg_9_0, arg_9_1)
	local var_9_0 = false
	local var_9_1 = AchievementModel.instance:isAchievementTaskFinished(arg_9_1.id)
	local var_9_2 = AchievementConfig.instance:getAchievement(arg_9_1.achievementId)
	local var_9_3 = var_9_2 and var_9_2.groupId

	if var_9_1 and AchievementUtils.isActivityGroup(arg_9_1.achievementId) and not arg_9_0._groupUnlockToastMap[var_9_3] then
		local var_9_4 = AchievementModel.instance:getGroupFinishTaskList(var_9_3)

		if (var_9_4 and #var_9_4 or 0) <= 1 then
			var_9_0 = true
			arg_9_0._groupUnlockToastMap[var_9_3] = true
		end
	end

	return var_9_0
end

function var_0_0.checkGroupUpgrade(arg_10_0, arg_10_1)
	local var_10_0 = AchievementConfig.instance:getAchievement(arg_10_1.achievementId)
	local var_10_1 = false

	if var_10_0 and AchievementUtils.isActivityGroup(arg_10_1.achievementId) then
		local var_10_2 = AchievementConfig.instance:getGroup(var_10_0.groupId)

		var_10_1 = var_10_2 and var_10_2.unLockAchievement == arg_10_1.id
	end

	return var_10_1
end

function var_0_0.checkIsGroupFinished(arg_11_0, arg_11_1)
	local var_11_0 = AchievementConfig.instance:getAchievement(arg_11_1.achievementId)
	local var_11_1 = false
	local var_11_2 = var_11_0 and var_11_0.groupId

	if AchievementUtils.isActivityGroup(arg_11_1.achievementId) and not arg_11_0._groupFinishedToastMap[var_11_2] then
		var_11_1 = AchievementModel.instance:isGroupFinished(var_11_0.groupId)

		if var_11_1 then
			arg_11_0._groupFinishedToastMap[var_11_2] = true
		end
	end

	return var_11_1
end

function var_0_0.getWaitToastList(arg_12_0)
	return arg_12_0._waitToastList
end

function var_0_0.onToastFinished(arg_13_0)
	arg_13_0._waitToastList = nil
end

var_0_0.instance = var_0_0.New()

return var_0_0
