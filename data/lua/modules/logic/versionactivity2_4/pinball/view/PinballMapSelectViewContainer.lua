module("modules.logic.versionactivity2_4.pinball.view.PinballMapSelectViewContainer", package.seeall)

local var_0_0 = class("PinballMapSelectViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		PinballMapSelectView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		local var_2_0 = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			var_2_0
		}
	end
end

return var_0_0
