module("modules.logic.versionactivity.view.VersionActivityPushBoxTaskViewContainer", package.seeall)

local var_0_0 = class("VersionActivityPushBoxTaskViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		VersionActivityPushBoxTaskView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		return {
			arg_2_0._navigateButtonView
		}
	end
end

return var_0_0
