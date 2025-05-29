module("modules.logic.fight.model.data.FightPowerInfoData", package.seeall)

local var_0_0 = FightDataClass("FightPowerInfoData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.powerId = arg_1_1.powerId
	arg_1_0.num = arg_1_1.num
	arg_1_0.max = arg_1_1.max
end

return var_0_0
