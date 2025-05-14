module("modules.logic.versionactivity1_4.act134.view.Activity134ViewContainer", package.seeall)

local var_0_0 = class("Activity134ViewContainer", BaseViewContainer)
local var_0_1 = 1
local var_0_2 = 2

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Activity134View.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == var_0_1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0._navigateButtonView
		}
	elseif arg_2_1 == var_0_2 then
		local var_2_0 = CurrencyEnum.CurrencyType.Act134Clue

		arg_2_0._currencyView = CurrencyView.New({
			var_2_0
		})

		return {
			arg_2_0._currencyView
		}
	end
end

return var_0_0
