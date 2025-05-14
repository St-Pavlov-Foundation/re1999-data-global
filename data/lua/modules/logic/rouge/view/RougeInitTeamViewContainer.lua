module("modules.logic.rouge.view.RougeInitTeamViewContainer", package.seeall)

local var_0_0 = class("RougeInitTeamViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, RougeInitTeamView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			false,
			false
		})

		arg_2_0.navigateView:setHelpId(HelpEnum.HelpId.RougeInitTeamViewHelp)

		return {
			arg_2_0.navigateView
		}
	end
end

return var_0_0
