module("modules.logic.fight.model.data.FightCardHeatValueData", package.seeall)

local var_0_0 = FightDataClass("FightCardHeatValueData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.upperLimit = arg_1_1.upperLimit
	arg_1_0.lowerLimit = arg_1_1.lowerLimit
	arg_1_0.value = arg_1_1.value
	arg_1_0.changeValue = arg_1_1.changeValue
end

return var_0_0
