module("modules.logic.achievement.controller.AchievementJumpController", package.seeall)

local var_0_0 = class("AchievementJumpController", BaseController)

function var_0_0.jumpToAchievement(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0:tryParaseParamsToNumber(arg_1_1)
	local var_1_1 = var_1_0 and var_1_0[2]
	local var_1_2 = arg_1_0:getJumpHandleFunc(var_1_1)
	local var_1_3 = false

	if var_1_2 then
		var_1_3 = var_1_2(unpack(var_1_0))
	else
		logError(string.format("cannot find JumpHandleFunction, jumpType = %s", var_1_1))
	end

	return var_1_3
end

function var_0_0.tryParaseParamsToNumber(arg_2_0, arg_2_1)
	local var_2_0 = {}

	if arg_2_1 then
		for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
			local var_2_1 = tonumber(iter_2_1)

			if var_2_1 then
				table.insert(var_2_0, var_2_1)
			else
				table.insert(var_2_0, iter_2_1)
			end
		end
	end

	return var_2_0
end

function var_0_0.getJumpHandleFunc(arg_3_0, arg_3_1)
	return var_0_0.instance["jumpHandleFunc_" .. tostring(arg_3_1)]
end

function var_0_0.jumpHandleFunc_1(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = true

	AchievementController.instance:openAchievementMainViewAndFocus(AchievementEnum.AchievementType.Single, arg_4_2, var_4_0)
end

function var_0_0.jumpHandleFunc_2(arg_5_0, arg_5_1, arg_5_2)
	AchievementController.instance:openAchievementMainViewAndFocus(AchievementEnum.AchievementType.Group, arg_5_2)
end

function var_0_0.jumpHandleFunc_3(arg_6_0, arg_6_1, arg_6_2)
	AchievementController.instance:openAchievementMainView(arg_6_2)
end

function var_0_0.jumpHandleFunc_4(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	AchievementController.instance:openAchievementGroupPreView(arg_7_2, arg_7_3)
end

var_0_0.instance = var_0_0.New()

return var_0_0
