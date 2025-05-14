module("modules.logic.versionactivity1_4.act131.view.Activity131BattleViewContainer", package.seeall)

local var_0_0 = class("Activity131BattleViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, Activity131BattleView.New())

	return var_1_0
end

return var_0_0
