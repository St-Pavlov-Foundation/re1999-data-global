module("modules.logic.fight.model.data.FightBloodPoolData", package.seeall)

local var_0_0 = FightDataClass("FightBloodPoolData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.value = arg_1_1.value
	arg_1_0.max = arg_1_1.max
end

return var_0_0
