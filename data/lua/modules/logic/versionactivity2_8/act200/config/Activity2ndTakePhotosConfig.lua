module("modules.logic.versionactivity2_8.act200.config.Activity2ndTakePhotosConfig", package.seeall)

local var_0_0 = class("Activity2ndTakePhotosConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity200"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._config = {}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity200" then
		arg_3_0._config = arg_3_2
	end
end

function var_0_0.getConfigList(arg_4_0)
	return arg_4_0._config.configList
end

function var_0_0.getConfigById(arg_5_0, arg_5_1)
	return arg_5_0._config.configList[arg_5_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
