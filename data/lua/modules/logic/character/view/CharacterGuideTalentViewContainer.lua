module("modules.logic.character.view.CharacterGuideTalentViewContainer", package.seeall)

local var_0_0 = class("CharacterGuideTalentViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	return {
		CharacterGuideTalentView.New()
	}
end

return var_0_0
