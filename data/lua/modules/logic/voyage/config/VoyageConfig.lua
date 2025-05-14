module("modules.logic.voyage.config.VoyageConfig", package.seeall)

local var_0_0 = class("VoyageConfig", Activity1001Config)

function var_0_0.getTaskList(arg_1_0)
	return arg_1_0:_createOrGetShowTaskList()
end

function var_0_0.getRewardStrList(arg_2_0, arg_2_1)
	return string.split(arg_2_0:getRewardStr(arg_2_1), "|")
end

var_0_0.instance = var_0_0.New(ActivityEnum.Activity.ActivityGiftForTheVoyage)

return var_0_0
