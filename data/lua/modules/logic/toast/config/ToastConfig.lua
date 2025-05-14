module("modules.logic.toast.config.ToastConfig", package.seeall)

local var_0_0 = class("ToastConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0.toastConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"toast"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "toast" then
		arg_3_0.toastConfig = arg_3_2
	end
end

function var_0_0.getToastCO(arg_4_0, arg_4_1)
	return arg_4_0.toastConfig.configDict[arg_4_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
