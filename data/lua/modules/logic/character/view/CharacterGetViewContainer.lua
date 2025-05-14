module("modules.logic.character.view.CharacterGetViewContainer", package.seeall)

local var_0_0 = class("CharacterGetViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		CharacterGetView.New(),
		CharacterSkinGetDetailView.New()
	}
end

return var_0_0
