module("modules.logic.character.view.CharacterSkinGetDetailViewContainer", package.seeall)

local var_0_0 = class("CharacterSkinGetDetailViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		CharacterSkinGetDetailView.New()
	}
end

return var_0_0
