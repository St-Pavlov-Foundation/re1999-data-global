module("modules.logic.main.controller.work.MainUseExpireItemWork", package.seeall)

local var_0_0 = class("MainUseExpireItemWork", BaseWork)

function var_0_0.onStart(arg_1_0, arg_1_1)
	ItemRpc.instance:sendAutoUseExpirePowerItemRequest()
	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
