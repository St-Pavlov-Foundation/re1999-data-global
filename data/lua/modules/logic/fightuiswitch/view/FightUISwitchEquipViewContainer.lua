module("modules.logic.fightuiswitch.view.FightUISwitchEquipViewContainer", package.seeall)

local var_0_0 = class("FightUISwitchEquipViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, FightUISwitchEquipView.New())

	return var_1_0
end

return var_0_0
