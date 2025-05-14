module("modules.logic.permanent.config.PermanentConfig", package.seeall)

local var_0_0 = class("PermanentConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"permanent"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "permanent" then
		arg_3_0._permanentConfig = arg_3_2
	end
end

function var_0_0.getKvIconName(arg_4_0, arg_4_1)
	return arg_4_0:getPermanentCO(arg_4_1).kvIcon
end

function var_0_0.getPermanentDic(arg_5_0)
	return arg_5_0._permanentConfig.configDict
end

function var_0_0.getPermanentCO(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0._permanentConfig.configDict[arg_6_1]

	if not var_6_0 then
		logError("config permanent no activityId" .. arg_6_1)
	end

	return var_6_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
