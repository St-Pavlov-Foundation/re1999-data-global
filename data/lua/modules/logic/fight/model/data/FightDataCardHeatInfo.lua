module("modules.logic.fight.model.data.FightDataCardHeatInfo", package.seeall)

local var_0_0 = FightDataClass("FightDataCardHeatInfo")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.values = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.values) do
		arg_1_0.values[iter_1_1.id] = FightDataCardHeatValue.New(iter_1_1)
	end
end

return var_0_0
