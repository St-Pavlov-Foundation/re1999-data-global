module("modules.logic.reddot.config.RedDotConfig", package.seeall)

local var_0_0 = class("RedDotConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._dotConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"reddot"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "reddot" then
		arg_3_0._dotConfig = arg_3_2
	end
end

function var_0_0.getRedDotsCO(arg_4_0)
	return arg_4_0._dotConfig.configDict
end

function var_0_0.getRedDotCO(arg_5_0, arg_5_1)
	return arg_5_0._dotConfig.configDict[arg_5_1]
end

function var_0_0.getParentRedDotId(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0:getRedDotCO(arg_6_1)

	return var_6_0 and var_6_0.parent or 0
end

var_0_0.instance = var_0_0.New()

return var_0_0
