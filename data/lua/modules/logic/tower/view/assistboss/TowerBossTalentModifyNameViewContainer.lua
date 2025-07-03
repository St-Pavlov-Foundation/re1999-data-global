module("modules.logic.tower.view.assistboss.TowerBossTalentModifyNameViewContainer", package.seeall)

local var_0_0 = class("TowerBossTalentModifyNameViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, TowerBossTalentModifyNameView.New())

	return var_1_0
end

return var_0_0
