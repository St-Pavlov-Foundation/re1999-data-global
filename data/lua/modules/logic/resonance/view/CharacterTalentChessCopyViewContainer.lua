module("modules.logic.resonance.view.CharacterTalentChessCopyViewContainer", package.seeall)

local var_0_0 = class("CharacterTalentChessCopyViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, CharacterTalentChessCopyView.New())

	return var_1_0
end

return var_0_0
