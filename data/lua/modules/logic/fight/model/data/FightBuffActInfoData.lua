module("modules.logic.fight.model.data.FightBuffActInfoData", package.seeall)

local var_0_0 = FightDataClass("FightBuffActInfoData")

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.actId = arg_1_1.actId
	arg_1_0.param = {}

	local var_1_0 = arg_1_1.param

	for iter_1_0 = 1, #var_1_0 do
		arg_1_0.param[iter_1_0] = var_1_0[iter_1_0]
	end

	arg_1_0.strParam = arg_1_1.strParam
end

return var_0_0
