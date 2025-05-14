module("modules.logic.sdk.config.SDKConfig", package.seeall)

local var_0_0 = class("SDKConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"const"
	}
end

function var_0_0.getGuestBindRewards(arg_3_0)
	return CommonConfig.instance:getConstStr(ConstEnum.guestBindRewards)
end

var_0_0.instance = var_0_0.New()

return var_0_0
