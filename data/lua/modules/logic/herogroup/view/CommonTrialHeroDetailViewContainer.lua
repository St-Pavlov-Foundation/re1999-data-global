module("modules.logic.herogroup.view.CommonTrialHeroDetailViewContainer", package.seeall)

local var_0_0 = class("CommonTrialHeroDetailViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		CommonTrialHeroDetailView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		return {
			NavigateButtonsView.New({
				true,
				false,
				false
			})
		}
	end
end

return var_0_0
