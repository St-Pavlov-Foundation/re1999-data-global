module("modules.logic.fight.model.mo.FightHeroSpAttributeInfoMO", package.seeall)

local var_0_0 = pureTable("FightHeroSpAttributeInfoMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.attribute = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.attribute) do
		local var_1_0 = HeroSpAttributeMO.New()

		var_1_0:init(iter_1_1)

		arg_1_0.attribute[iter_1_0] = var_1_0
	end
end

return var_0_0
