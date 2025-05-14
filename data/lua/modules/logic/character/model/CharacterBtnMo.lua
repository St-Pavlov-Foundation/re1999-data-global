module("modules.logic.character.model.CharacterBtnMo", package.seeall)

local var_0_0 = pureTable("CharacterBtnMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.name = ""
	arg_1_0.icon = ""
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.name = arg_2_1.name
	arg_2_0.icon = arg_2_1.iconres
end

return var_0_0
