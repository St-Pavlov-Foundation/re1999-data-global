module("modules.logic.login.config.LoginConfig", package.seeall)

local var_0_0 = class("LoginConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return nil
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._config = nil
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "" then
		arg_3_0._config = arg_3_2
	end
end

function var_0_0.getConfigTable(arg_4_0)
	return arg_4_0._config
end

var_0_0.instance = var_0_0.New()

return var_0_0
