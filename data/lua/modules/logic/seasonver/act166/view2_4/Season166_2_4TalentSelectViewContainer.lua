﻿module("modules.logic.seasonver.act166.view2_4.Season166_2_4TalentSelectViewContainer", package.seeall)

local var_0_0 = class("Season166_2_4TalentSelectViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Season166_2_4TalentSelectView.New())
	table.insert(var_1_0, TabViewGroup.New(1, "#go_topleft"))

	return var_1_0
end

function var_0_0.buildTabViews(arg_2_0, arg_2_1)
	if arg_2_1 == 1 then
		arg_2_0.navigateView = NavigateButtonsView.New({
			true,
			true,
			true
		}, HelpEnum.HelpId.Season166TalentTreeHelp)

		return {
			arg_2_0.navigateView
		}
	end
end

return var_0_0
