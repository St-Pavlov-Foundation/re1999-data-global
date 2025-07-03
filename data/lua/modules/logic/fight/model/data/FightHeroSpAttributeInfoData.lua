module("modules.logic.fight.model.data.FightHeroSpAttributeInfoData", package.seeall)

local var_0_0 = FightDataClass("FightHeroSpAttributeInfoData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.uid = arg_1_1.uid
	arg_1_0.attribute = FightHeroSpAttributeData.New(arg_1_1.attribute)
end

return var_0_0
