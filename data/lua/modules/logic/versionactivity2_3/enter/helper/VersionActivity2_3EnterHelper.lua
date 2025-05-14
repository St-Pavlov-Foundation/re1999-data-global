module("modules.logic.versionactivity2_3.enter.helper.VersionActivity2_3EnterHelper", package.seeall)

local var_0_0 = class("VersionActivity2_3EnterHelper")

function var_0_0.GetIsShowReplayBtn(arg_1_0)
	local var_1_0 = false

	if arg_1_0 then
		var_1_0 = ActivityConfig.instance:getActivityTabButtonState(arg_1_0)
	end

	return var_1_0
end

function var_0_0.GetIsShowTabRemainTime(arg_2_0)
	if not arg_2_0 then
		return false
	end

	local var_2_0, var_2_1, var_2_2 = ActivityConfig.instance:getActivityTabButtonState(arg_2_0)

	return var_2_2
end

function var_0_0.GetIsShowAchievementBtn(arg_3_0)
	if not arg_3_0 then
		return false
	end

	local var_3_0, var_3_1 = ActivityConfig.instance:getActivityTabButtonState(arg_3_0)

	return var_3_1
end

function var_0_0.getItemTypeIdQuantity(arg_4_0)
	if not arg_4_0 then
		return
	end

	local var_4_0 = string.splitToNumber(arg_4_0, "#")

	return var_4_0[1], var_4_0[2], var_4_0[3]
end

function var_0_0.GetActivityPrefsKeyWithUser(arg_5_0)
	local var_5_0 = var_0_0.GetActivityPrefsKey(arg_5_0)

	return PlayerModel.instance:getPlayerPrefsKey(var_5_0)
end

function var_0_0.GetActivityPrefsKey(arg_6_0)
	return VersionActivity2_3Enum.ActivityId.EnterView .. arg_6_0
end

return var_0_0
