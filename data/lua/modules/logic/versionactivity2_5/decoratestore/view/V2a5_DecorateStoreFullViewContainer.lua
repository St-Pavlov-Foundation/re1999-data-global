module("modules.logic.versionactivity2_5.decoratestore.view.V2a5_DecorateStoreFullViewContainer", package.seeall)

local var_0_0 = class("V2a5_DecorateStoreFullViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, V2a5_DecorateStoreView.New())

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

return var_0_0
