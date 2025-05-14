module("modules.logic.achievement.model.mo.AchievementSelectListMO", package.seeall)

local var_0_0 = pureTable("AchievementSelectListMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.achievementCfgs = arg_1_1
	arg_1_0.groupId = arg_1_2
end

function var_0_0.getLineHeight(arg_2_0)
	if arg_2_0.groupId == 0 then
		return 313
	else
		return 460
	end
end

function var_0_0.getAchievementType(arg_3_0)
	return arg_3_0.groupId and arg_3_0.groupId ~= 0 and AchievementEnum.AchievementType.Single or AchievementEnum.AchievementType.Group
end

return var_0_0
