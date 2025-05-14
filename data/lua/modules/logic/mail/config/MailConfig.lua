module("modules.logic.mail.config.MailConfig", package.seeall)

local var_0_0 = class("MailConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._mailConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"mail"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "mail" then
		arg_3_0._mailConfig = arg_3_2
	end
end

function var_0_0.getCategoryCO(arg_4_0)
	return arg_4_0._mailConfig.configDict
end

function var_0_0.getPropDetailCO(arg_5_0, arg_5_1)
	return arg_5_0._mailConfig.configDict[arg_5_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
