module("modules.logic.versionactivity.view.VersionActivityPushBoxGameViewContainer", package.seeall)

local var_0_0 = class("VersionActivityPushBoxGameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		TabViewGroup.New(1, "#go_btns"),
		VersionActivityPushBoxGameView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			true
		}, HelpEnum.HelpId.PushBox)

		return {
			arg_2_0._navigateButtonView
		}
	end
end

return var_0_0
