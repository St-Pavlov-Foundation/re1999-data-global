﻿module("modules.logic.tower.view.bosstower.TowerBossSpEpisodeViewContainer", package.seeall)

local var_0_0 = class("TowerBossSpEpisodeViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TowerBossSpEpisodeView.New())
	table.insert(var_1_0, TowerBossEpisodeLeftView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			false
		})

		return {
			arg_2_0.navigateView
		}
	end
end

function var_0_0.isSp(arg_3_0)
	return true
end

return var_0_0
