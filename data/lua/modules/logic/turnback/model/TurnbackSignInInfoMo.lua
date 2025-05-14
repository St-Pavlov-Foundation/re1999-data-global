module("modules.logic.turnback.model.TurnbackSignInInfoMo", package.seeall)

local var_0_0 = pureTable("TurnbackSignInInfoMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.turnbackId = 0
	arg_1_0.id = 0
	arg_1_0.state = 0
	arg_1_0.config = nil
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.turnbackId = arg_2_2
	arg_2_0.id = arg_2_1.id
	arg_2_0.state = arg_2_1.state
	arg_2_0.config = TurnbackConfig.instance:getTurnbackSignInDayCo(arg_2_0.turnbackId, arg_2_0.id)
end

function var_0_0.updateState(arg_3_0, arg_3_1)
	arg_3_0.state = arg_3_1
end

return var_0_0
