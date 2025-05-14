module("modules.logic.activitywelfare.config.Activity160Config", package.seeall)

local var_0_0 = class("Activity160Config", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"activity160_mission"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity160_mission" then
		arg_3_0._missionConfig = arg_3_2
	end
end

function var_0_0.getActivityMissions(arg_4_0, arg_4_1)
	return arg_4_0._missionConfig.configDict[arg_4_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
