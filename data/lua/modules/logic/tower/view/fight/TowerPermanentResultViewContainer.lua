module("modules.logic.tower.view.fight.TowerPermanentResultViewContainer", package.seeall)

local var_0_0 = class("TowerPermanentResultViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TowerPermanentResultView.New())

	return var_1_0
end

return var_0_0
