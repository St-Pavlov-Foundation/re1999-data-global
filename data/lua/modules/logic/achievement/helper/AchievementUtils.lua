module("modules.logic.achievement.helper.AchievementUtils", package.seeall)

local var_0_0 = class("AchievementUtils")

var_0_0.SingleShowTag = "1"
var_0_0.GroupShowTag = "2"

function var_0_0.decodeShowStr(arg_1_0)
	local var_1_0 = {}
	local var_1_1 = {}

	if string.nilorempty(arg_1_0) then
		return var_1_0, var_1_1
	end

	local var_1_2 = string.split(arg_1_0, ",")

	for iter_1_0 = 1, #var_1_2 do
		local var_1_3 = var_1_2[iter_1_0]

		if not string.nilorempty(var_1_3) then
			var_0_0.fillShowSet(var_1_0, var_1_1, var_1_3)
		end
	end

	return var_1_0, var_1_1
end

function var_0_0.fillShowSet(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = string.split(arg_2_2, ":")

	if #var_2_0 >= 2 then
		local var_2_1 = var_2_0[1]
		local var_2_2 = var_2_0[2]
		local var_2_3 = var_2_1 == var_0_0.GroupShowTag and arg_2_1 or arg_2_0

		if not string.nilorempty(var_2_2) then
			local var_2_4 = string.splitToNumber(var_2_2, "#")

			if var_2_4 and #var_2_4 > 0 then
				for iter_2_0, iter_2_1 in ipairs(var_2_4) do
					table.insert(var_2_3, iter_2_1)
				end
			end
		end
	end
end

function var_0_0.encodeShowStr()
	return
end

function var_0_0.isActivityGroup(arg_4_0)
	local var_4_0 = AchievementConfig.instance:getAchievement(arg_4_0)

	return var_4_0 and var_4_0.category == AchievementEnum.Type.Activity
end

function var_0_0.isGamePlayGroup(arg_5_0)
	local var_5_0 = AchievementConfig.instance:getAchievement(arg_5_0)

	return var_5_0 and var_5_0.category == AchievementEnum.Type.GamePlay
end

return var_0_0
