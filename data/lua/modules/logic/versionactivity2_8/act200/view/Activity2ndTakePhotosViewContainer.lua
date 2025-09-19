module("modules.logic.versionactivity2_8.act200.view.Activity2ndTakePhotosViewContainer", package.seeall)

local var_0_0 = class("Activity2ndTakePhotosViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Activity2ndTakePhotosView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_2_0._navigateButtonView:setOverrideClose(arg_2_0._overrideCloseFunc, arg_2_0)

		return {
			arg_2_0._navigateButtonView
		}
	end
end

return var_0_0
