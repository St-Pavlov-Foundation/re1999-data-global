module("modules.logic.seasonver.act123.view1_9.Season123_1_9PickHeroEntryViewContainer", package.seeall)

local var_0_0 = class("Season123_1_9PickHeroEntryViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season123_1_9CheckCloseView.New(),
		Season123_1_9PickHeroEntryView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_2_0._navigateButtonView:setHelpId(HelpEnum.HelpId.Season1_9SelectHeroHelp)
		arg_2_0._navigateButtonView:hideHelpIcon()

		return {
			arg_2_0._navigateButtonView
		}
	end
end

return var_0_0
