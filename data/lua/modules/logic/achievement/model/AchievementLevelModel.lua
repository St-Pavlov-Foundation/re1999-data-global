module("modules.logic.achievement.model.AchievementLevelModel", package.seeall)

local var_0_0 = class("AchievementLevelModel", BaseModel)

function var_0_0.initData(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._achievementId = arg_1_1
	arg_1_0._achievementIds = arg_1_2

	arg_1_0:initAchievement()
end

function var_0_0.initAchievement(arg_2_0)
	arg_2_0._taskList = AchievementConfig.instance:getTasksByAchievementId(arg_2_0._achievementId)
	arg_2_0._selectIndex = arg_2_0:initSelectIndex()
end

function var_0_0.initSelectIndex(arg_3_0)
	if arg_3_0._taskList then
		for iter_3_0, iter_3_1 in ipairs(arg_3_0._taskList) do
			local var_3_0 = AchievementModel.instance:getById(iter_3_1.id)

			if var_3_0 and not var_3_0.hasFinished then
				return iter_3_0
			end
		end

		return #arg_3_0._taskList
	end

	return 0
end

function var_0_0.setSelectTask(arg_4_0, arg_4_1)
	local var_4_0 = AchievementConfig.instance:getTask(arg_4_1)

	if var_4_0 then
		arg_4_0._selectIndex = tabletool.indexOf(arg_4_0._taskList, var_4_0) or 0
	end
end

function var_0_0.getCurrentTask(arg_5_0)
	if arg_5_0._selectIndex ~= 0 then
		return arg_5_0._taskList[arg_5_0._selectIndex]
	end
end

function var_0_0.getTaskByIndex(arg_6_0, arg_6_1)
	return arg_6_0._taskList[arg_6_1]
end

function var_0_0.scrollTask(arg_7_0, arg_7_1)
	local var_7_0 = tabletool.indexOf(arg_7_0._achievementIds, arg_7_0._achievementId)

	if var_7_0 then
		if arg_7_1 and arg_7_0:hasNext() then
			arg_7_0._achievementId = arg_7_0._achievementIds[var_7_0 + 1]

			arg_7_0:initAchievement()

			return true
		elseif not arg_7_1 and arg_7_0:hasPrev() then
			arg_7_0._achievementId = arg_7_0._achievementIds[var_7_0 - 1]

			arg_7_0:initAchievement()

			return true
		end
	end

	return false
end

function var_0_0.hasNext(arg_8_0)
	local var_8_0 = tabletool.indexOf(arg_8_0._achievementIds, arg_8_0._achievementId)

	if var_8_0 then
		return var_8_0 < #arg_8_0._achievementIds
	end
end

function var_0_0.hasPrev(arg_9_0)
	local var_9_0 = tabletool.indexOf(arg_9_0._achievementIds, arg_9_0._achievementId)

	if var_9_0 then
		return var_9_0 > 1
	end
end

function var_0_0.getCurPageIndex(arg_10_0)
	return tabletool.indexOf(arg_10_0._achievementIds, arg_10_0._achievementId)
end

function var_0_0.getTotalPageCount(arg_11_0)
	return arg_11_0._achievementIds and #arg_11_0._achievementIds or 0
end

function var_0_0.getAchievement(arg_12_0)
	return arg_12_0._achievementId
end

var_0_0.instance = var_0_0.New()

return var_0_0
