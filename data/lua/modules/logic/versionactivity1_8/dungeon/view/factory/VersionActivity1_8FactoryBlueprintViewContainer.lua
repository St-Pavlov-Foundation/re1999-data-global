module("modules.logic.versionactivity1_8.dungeon.view.factory.VersionActivity1_8FactoryBlueprintViewContainer", package.seeall)

local var_0_0 = class("VersionActivity1_8FactoryBlueprintViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		VersionActivity1_8FactoryBlueprintView.New(),
		TabViewGroup.New(1, "#go_topleft"),
		TabViewGroup.New(2, "#go_topright")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			var_2_0
		}
	elseif arg_2_1 == 2 then
		arg_2_0._currencyView = CurrencyView.New({
			CurrencyEnum.CurrencyType.V1a8FactoryPart
		})
		arg_2_0._currencyView.foreHideBtn = true

		return {
			arg_2_0._currencyView
		}
	end
end

function var_0_0.setCurrencyType(arg_3_0, arg_3_1)
	if not arg_3_0._currencyView then
		return
	end

	arg_3_0._currencyView:setCurrencyType(arg_3_1)
end

return var_0_0
