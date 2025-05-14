module("modules.logic.balanceumbrella.config.BalanceUmbrellaConfig", package.seeall)

local var_0_0 = class("BalanceUmbrellaConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"balance_umbrella"
	}
end

var_0_0.instance = var_0_0.New()

return var_0_0
