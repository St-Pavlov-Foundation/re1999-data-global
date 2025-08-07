module("modules.logic.fight.model.data.FightProgressInfoData", package.seeall)

local var_0_0 = FightDataClass("FightProgressInfoData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		local var_1_0 = {}
		local var_1_1 = iter_1_1.id

		var_1_0.id = var_1_1
		var_1_0.max = iter_1_1.max
		var_1_0.value = iter_1_1.value
		var_1_0.showId = iter_1_1.showId
		arg_1_0[var_1_1] = var_1_0
	end
end

return var_0_0
