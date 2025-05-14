module("modules.logic.character.view.CharacterBackpackSearchFilterViewContainer", package.seeall)

local var_0_0 = class("CharacterBackpackSearchFilterViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		CharacterBackpackSearchFilterView.New()
	}
end

return var_0_0
