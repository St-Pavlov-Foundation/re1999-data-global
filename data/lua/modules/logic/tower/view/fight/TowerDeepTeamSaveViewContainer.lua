module("modules.logic.tower.view.fight.TowerDeepTeamSaveViewContainer", package.seeall)

local var_0_0 = class("TowerDeepTeamSaveViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TowerDeepTeamSaveView.New())

	return var_1_0
end

return var_0_0
