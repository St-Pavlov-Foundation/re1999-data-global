module("modules.logic.login.model.ServerMO", package.seeall)

local var_0_0 = pureTable("ServerMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.name = nil
	arg_1_0.state = nil
	arg_1_0.prefix = nil
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.name = arg_2_1.name
	arg_2_0.state = arg_2_1.state
	arg_2_0.prefix = arg_2_1.prefix
end

return var_0_0
