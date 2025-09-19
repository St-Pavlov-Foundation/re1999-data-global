module("modules.logic.versionactivity2_8.act197.view.Activity197ViewContainer", package.seeall)

local var_0_0 = class("Activity197ViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Activity197View.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))
	table.insert(var_1_0, TabViewGroup.New(2, "#go_topright"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0.navigateView
		}
	elseif arg_2_1 == 2 then
		local var_2_0 = {
			Activity197Enum.KeyCurrency,
			Activity197Enum.BulbCurrency
		}

		arg_2_0.currencyView = CurrencyView.New(var_2_0)
		arg_2_0.currencyView.foreHideBtn = true

		return {
			arg_2_0.currencyView
		}
	end
end

function var_0_0.onClickCurrency(arg_3_0)
	return
end

return var_0_0
