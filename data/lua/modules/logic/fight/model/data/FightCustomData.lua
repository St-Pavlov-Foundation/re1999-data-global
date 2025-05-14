module("modules.logic.fight.model.data.FightCustomData", package.seeall)

local var_0_0 = FightDataClass("FightCustomData")

var_0_0.CustomDataType = {
	Act183 = 1
}

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in ipairs(arg_1_1) do
		arg_1_0[iter_1_1.type] = iter_1_1.data
	end
end

return var_0_0
