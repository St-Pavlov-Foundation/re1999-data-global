module("modules.logic.seasonver.act123.view1_8.Season123_1_8SettlementViewContainer", package.seeall)

local var_0_0 = class("Season123_1_8SettlementViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season123_1_8SettlementView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		-- block empty
	end
end

return var_0_0
