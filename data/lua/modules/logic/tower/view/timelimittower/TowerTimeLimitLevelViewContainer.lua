module("modules.logic.tower.view.timelimittower.TowerTimeLimitLevelViewContainer", package.seeall)

local var_0_0 = class("TowerTimeLimitLevelViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	arg_1_0.towerTimeLimitLevelInfoView = TowerTimeLimitLevelInfoView.New()

	table.insert(var_1_0, TowerTimeLimitLevelView.New())
	table.insert(var_1_0, arg_1_0.towerTimeLimitLevelInfoView)
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.TowerLimit)

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.getTowerTimeLimitLevelInfoView(arg_3_0)
	return arg_3_0.towerTimeLimitLevelInfoView
end

function var_0_0.setOverrideCloseClick(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.navigateView:setOverrideClose(arg_4_1, arg_4_2)
end

return var_0_0
