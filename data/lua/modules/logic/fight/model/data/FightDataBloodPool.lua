module("modules.logic.fight.model.data.FightDataBloodPool", package.seeall)

local var_0_0 = FightDataClass("FightDataBloodPool")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.value = arg_1_1 and arg_1_1.value or 0
	arg_1_0.max = arg_1_1 and arg_1_1.max or 0
end

function var_0_0.changeMaxValue(arg_2_0, arg_2_1)
	arg_2_0.max = arg_2_0.max + arg_2_1
end

function var_0_0.changeValue(arg_3_0, arg_3_1)
	arg_3_0.value = arg_3_0.value + arg_3_1
end

return var_0_0
