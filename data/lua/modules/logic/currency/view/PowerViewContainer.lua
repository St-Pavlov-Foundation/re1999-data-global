module("modules.logic.currency.view.PowerViewContainer", package.seeall)

local var_0_0 = class("PowerViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, PowerView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_righttop"))
	table.insert(var_1_0, TabViewGroup.New(2, "#go_lefttop"))

	return var_1_0
end

local var_0_1 = {
	duration = 0.01
}

function var_0_0.playOpenTransition(arg_2_0)
	var_0_0.super.playOpenTransition(arg_2_0, var_0_1)
end

function var_0_0.buildTabViews(arg_3_0, arg_3_1)
	if arg_3_1 == 1 then
		local var_3_0 = CurrencyEnum.CurrencyType
		local var_3_1 = {
			var_3_0.Diamond,
			var_3_0.FreeDiamondCoupon
		}

		return {
			CurrencyView.New(var_3_1)
		}
	elseif arg_3_1 == 2 then
		arg_3_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.Power)

		return {
			arg_3_0.navigateView
		}
	end
end

return var_0_0
