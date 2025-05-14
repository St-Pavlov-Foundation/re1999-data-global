module("modules.logic.character.model.HeroEquipAttributeMO", package.seeall)

local var_0_0 = pureTable("HeroEquipAttributeMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.equipAttr = HeroAttributeMO.New()

	arg_1_0.equipAttr:init(arg_1_1.equipAttr)
end

return var_0_0
