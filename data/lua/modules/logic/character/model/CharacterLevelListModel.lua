module("modules.logic.character.model.CharacterLevelListModel", package.seeall)

local var_0_0 = class("CharacterLevelListModel", ListScrollModel)

function var_0_0.setCharacterLevelList(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = {}
	local var_1_1 = arg_1_1.heroId
	local var_1_2 = arg_1_1.rank
	local var_1_3 = CharacterModel.instance:getrankEffects(var_1_1, var_1_2)[1]

	for iter_1_0 = arg_1_2 or arg_1_1.level, var_1_3 do
		local var_1_4 = {
			heroId = var_1_1,
			level = iter_1_0
		}

		var_1_0[#var_1_0 + 1] = var_1_4
	end

	arg_1_0:setList(var_1_0)
end

var_0_0.instance = var_0_0.New()

return var_0_0
