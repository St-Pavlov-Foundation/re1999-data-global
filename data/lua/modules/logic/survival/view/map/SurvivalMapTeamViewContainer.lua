module("modules.logic.survival.view.map.SurvivalMapTeamViewContainer", package.seeall)

local var_0_0 = class("SurvivalMapTeamViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		SurvivalMapTeamView.New(),
		TabViewGroup.New(1, "#go_lefttop")
	}
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
