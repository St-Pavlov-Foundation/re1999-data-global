module("modules.logic.character.view.CharacterSkinTagViewContainer", package.seeall)

local var_0_0 = class("CharacterSkinTagViewContainer", BaseViewContainer)

function var_0_0.buildViews(arg_1_0)
	local var_1_0 = {}

	table.insert(var_1_0, CharacterSkinTagView.New())

	return var_1_0
end

return var_0_0
