module("modules.logic.achievement.model.mo.AchievementTileMO", package.seeall)

local var_0_0 = pureTable("AchievementTileMO")

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
	return arg_3_0.groupId and arg_3_0.groupId ~= 0 and AchievementEnum.AchievementType.Group or AchievementEnum.AchievementType.Single
end

function var_0_0.isAchievementMatch(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = false

	if arg_4_1 == AchievementEnum.AchievementType.Single then
		if arg_4_0.achievementCfgs then
			for iter_4_0, iter_4_1 in ipairs(arg_4_0.achievementCfgs) do
				if iter_4_1.id == arg_4_2 then
					var_4_0 = true

					break
				end
			end
		end
	else
		var_4_0 = arg_4_2 == arg_4_0.groupId
	end

	return var_4_0
end

return var_0_0
