module("modules.logic.season.view1_2.Season1_2StoreViewContainer", package.seeall)

local var_0_0 = class("Season1_2StoreViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Season1_2StoreView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_btns"))
	table.insert(var_1_0, TabViewGroup.New(2, "#go_righttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				true,
				false
			})
		}
	end

	if arg_2_1 == 2 then
		local var_2_0 = Activity104Model.instance:getCurSeasonId()
		local var_2_1 = CurrencyView.New({
			Activity104Enum.StoreUTTU[var_2_0]
		})

		var_2_1.foreHideBtn = true

		return {
			var_2_1
		}
	end
end

function var_0_0._closeCallback(arg_3_0)
	arg_3_0:closeThis()
end

function var_0_0._homeCallback(arg_4_0)
	arg_4_0:closeThis()
end

return var_0_0
