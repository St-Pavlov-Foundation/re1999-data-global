module("modules.logic.seasonver.act123.view2_3.Season123_2_3ResetViewContainer", package.seeall)

local var_0_0 = class("Season123_2_3ResetViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season123_2_3CheckCloseView.New(),
		Season123_2_3ResetView.New(),
		TabViewGroup.New(1, "#go_topleft")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		arg_2_0._navigateButtonView:setHelpId(HelpEnum.HelpId.Season2_3ResetViewHelp)
		arg_2_0._navigateButtonView:hideHelpIcon()

		return {
			arg_2_0._navigateButtonView
		}
	end
end

return var_0_0
