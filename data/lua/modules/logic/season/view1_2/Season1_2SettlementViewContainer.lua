module("modules.logic.season.view1_2.Season1_2SettlementViewContainer", package.seeall)

local var_0_0 = class("Season1_2SettlementViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season1_2SettlementView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		-- block empty
	end
end

return var_0_0
