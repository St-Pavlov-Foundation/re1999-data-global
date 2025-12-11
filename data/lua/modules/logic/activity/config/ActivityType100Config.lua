module("modules.logic.activity.config.ActivityType100Config", package.seeall)

local var_0_0 = class("ActivityType100Config", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity_const",
		"warmup_h5"
	}
end

local function var_0_1(arg_2_0)
	return lua_warmup_h5.configDict[arg_2_0]
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	return
end

function var_0_0.getWarmUpH5ActivityId(arg_4_0, arg_4_1)
	return ActivityConfig.instance:getConstAsNum(3, arg_4_1 or 13119)
end

function var_0_0.getWarmUpH5Link(arg_5_0, arg_5_1)
	local var_5_0 = var_0_1(arg_5_1)

	if not var_5_0 then
		return
	end

	return SettingsModel.instance:extractByRegion(var_5_0.link)
end

var_0_0.instance = var_0_0.New()

return var_0_0
