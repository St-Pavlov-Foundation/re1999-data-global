module("modules.logic.achievement.model.PlayerViewAchievementModel", package.seeall)

local var_0_0 = class("PlayerViewAchievementModel", BaseModel)

function var_0_0.decodeShowAchievement(arg_1_0, arg_1_1)
	local var_1_0, var_1_1 = AchievementUtils.decodeShowStr(arg_1_1)
	local var_1_2 = {}

	for iter_1_0, iter_1_1 in pairs(var_1_0) do
		local var_1_3 = AchievementConfig.instance:getTask(iter_1_1)

		if var_1_3 then
			table.insert(var_1_2, var_1_3.id)
		end
	end

	local var_1_4 = {}

	for iter_1_2, iter_1_3 in pairs(var_1_1) do
		local var_1_5 = AchievementConfig.instance:getTask(iter_1_3)

		if var_1_5 then
			local var_1_6 = AchievementConfig.instance:getAchievement(var_1_5.achievementId)

			if var_1_6.groupId ~= 0 then
				var_1_4[var_1_6.groupId] = var_1_4[var_1_6.groupId] or {}

				table.insert(var_1_4[var_1_6.groupId], var_1_5.id)
			end
		end
	end

	return var_1_2, var_1_4
end

function var_0_0.getShowAchievements(arg_2_0, arg_2_1)
	local var_2_0, var_2_1 = arg_2_0:decodeShowAchievement(arg_2_1)
	local var_2_2 = var_2_1 and tabletool.len(var_2_1) > 0

	return var_2_2, var_2_2 and var_2_1 or var_2_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
