module("modules.logic.chargepush.config.ChargePushConfig", package.seeall)

local var_0_0 = class("ChargePushConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"store_push_goods"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "store_push_goods" then
		arg_3_0._chargePushGoodsConfig = arg_3_2
	end
end

function var_0_0.getPushGoodsConfig(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._chargePushGoodsConfig.configDict[arg_4_1]

	if not var_4_0 then
		logError(string.format("chargepushgoods config is nil, id:%s", arg_4_1))
	end

	return var_4_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
