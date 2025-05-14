module("modules.logic.versionactivity1_5.sportsnews.rpc.SportsNewsRpc", package.seeall)

local var_0_0 = class("SportsNewsRpc", BaseRpc)

function var_0_0.sendFinishReadTaskRequest(arg_1_0, arg_1_1, arg_1_2)
	return TaskRpc.instance:sendFinishReadTaskRequest(arg_1_2)
end

var_0_0.instance = var_0_0.New()

return var_0_0
