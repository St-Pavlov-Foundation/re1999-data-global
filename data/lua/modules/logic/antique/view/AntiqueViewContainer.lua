module("modules.logic.antique.view.AntiqueViewContainer", package.seeall)

local var_0_0 = class("AntiqueViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		AntiqueView.New(),
		TabViewGroup.New(1, "#go_btns")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigationView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0.navigationView
		}
	end
end

return var_0_0
