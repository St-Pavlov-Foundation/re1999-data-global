module("modules.logic.seasonver.act123.view.Season123PickHeroEntryViewContainer", package.seeall)

local var_0_0 = class("Season123PickHeroEntryViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		Season123CheckCloseView.New(),
		Season123PickHeroEntryView.New()
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0._navigateButtonView = NavigateButtonsView.New({
			true,
			false,
			true
		})

		arg_2_0._navigateButtonView:setHelpId(HelpEnum.HelpId.Season1_7SelectHeroHelp)

		return {
			arg_2_0._navigateButtonView
		}
	end
end

return var_0_0
