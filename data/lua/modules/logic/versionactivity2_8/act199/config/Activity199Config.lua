module("modules.logic.versionactivity2_8.act199.config.Activity199Config", package.seeall)

local var_0_0 = class("Activity199Config", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"activity199"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "activity199" then
		arg_3_0._summonNewPickConfig = arg_3_2
	end
end

function var_0_0.getSummonConfigById(arg_4_0, arg_4_1)
	return arg_4_0._summonNewPickConfig.configDict[arg_4_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
