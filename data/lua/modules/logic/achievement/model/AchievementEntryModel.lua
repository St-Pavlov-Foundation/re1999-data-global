module("modules.logic.achievement.model.AchievementEntryModel", package.seeall)

local var_0_0 = class("AchievementEntryModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.reInit(arg_2_0)
	return
end

function var_0_0.initData(arg_3_0)
	arg_3_0.infoDict = AchievementConfig.instance:getCategoryAchievementMap()

	arg_3_0:initCategory()
end

function var_0_0.initCategory(arg_4_0)
	local var_4_0 = AchievementConfig.instance:getOnlineAchievements()

	arg_4_0._category2TotalDict = {}
	arg_4_0._category2FinishedDict = {}
	arg_4_0._totalAchievementGotCount = 0
	arg_4_0._level2AchievementDict = {}

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		local var_4_1 = AchievementModel.instance:getAchievementLevel(iter_4_1.id)
		local var_4_2 = iter_4_1.category

		if var_4_1 > 0 then
			if arg_4_0._category2FinishedDict[var_4_2] == nil then
				arg_4_0._category2FinishedDict[var_4_2] = 1
			else
				arg_4_0._category2FinishedDict[var_4_2] = arg_4_0._category2FinishedDict[var_4_2] + 1
			end

			arg_4_0._totalAchievementGotCount = arg_4_0._totalAchievementGotCount + 1
		end

		arg_4_0._level2AchievementDict[var_4_1] = arg_4_0._level2AchievementDict[var_4_1] or 0
		arg_4_0._level2AchievementDict[var_4_1] = arg_4_0._level2AchievementDict[var_4_1] + 1

		if arg_4_0._category2TotalDict[var_4_2] == nil then
			arg_4_0._category2TotalDict[var_4_2] = 1
		else
			arg_4_0._category2TotalDict[var_4_2] = arg_4_0._category2TotalDict[var_4_2] + 1
		end
	end
end

function var_0_0.getFinishCount(arg_5_0, arg_5_1)
	return arg_5_0._category2FinishedDict[arg_5_1] or 0, arg_5_0._category2TotalDict[arg_5_1] or 0
end

function var_0_0.getLevelCount(arg_6_0, arg_6_1)
	if arg_6_0._level2AchievementDict then
		return arg_6_0._level2AchievementDict[arg_6_1] or 0
	end
end

function var_0_0.getTotalFinishedCount(arg_7_0)
	return arg_7_0._totalAchievementGotCount or 0
end

function var_0_0.categoryHasNew(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0.infoDict[arg_8_1]

	if var_8_0 then
		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			if AchievementModel.instance:achievementHasNew(iter_8_1.id) then
				return true
			end
		end
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
