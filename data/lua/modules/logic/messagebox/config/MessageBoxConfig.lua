module("modules.logic.messagebox.config.MessageBoxConfig", package.seeall)

local var_0_0 = class("MessageBoxConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._messageBoxConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"messagebox"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "messagebox" then
		arg_3_0._messageBoxConfig = arg_3_2
	end
end

function var_0_0.getMessageBoxCO(arg_4_0, arg_4_1)
	return arg_4_0._messageBoxConfig.configDict[arg_4_1]
end

function var_0_0.getMessage(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0:getMessageBoxCO(arg_5_1)

	if not var_5_0 then
		logError("找不到弹窗配置, id: " .. tostring(arg_5_1))
	end

	return var_5_0 and var_5_0.content or ""
end

var_0_0.instance = var_0_0.New()

return var_0_0
