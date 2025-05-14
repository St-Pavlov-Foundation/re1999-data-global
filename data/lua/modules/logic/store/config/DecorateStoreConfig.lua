module("modules.logic.store.config.DecorateStoreConfig", package.seeall)

local var_0_0 = class("DecorateStoreConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._storeDecorateConfig = nil
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"store_decorate"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "store_decorate" then
		arg_3_0._storeDecorateConfig = arg_3_2
	end
end

function var_0_0.getDecorateConfig(arg_4_0, arg_4_1)
	return arg_4_0._storeDecorateConfig.configDict[arg_4_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
