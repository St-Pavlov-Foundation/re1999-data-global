module("modules.logic.tower.view.assistboss.TowerAssistBossTalentViewContainer", package.seeall)

local var_0_0 = class("TowerAssistBossTalentViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TowerAssistBossTalentView.New())
	table.insert(var_1_0, TowerAssistBossTalentTreeView.New())
	table.insert(var_1_0, TowerAssistBossTalentPlanModifyView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_lefttop"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.TowerTalent)

		return {
			arg_2_0.navigateView
		}
	end
end

return var_0_0
