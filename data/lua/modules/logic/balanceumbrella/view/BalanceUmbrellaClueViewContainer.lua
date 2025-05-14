module("modules.logic.balanceumbrella.view.BalanceUmbrellaClueViewContainer", package.seeall)

local var_0_0 = class("BalanceUmbrellaClueViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		BalanceUmbrellaClueView.New()
	}
end

return var_0_0
