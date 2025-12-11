module("modules.logic.fight.system.flow.FightFastRestartSequence", package.seeall)

local var_0_0 = class("FightFastRestartSequence", FightWorkItem)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0:com_registFlowSequence()
	local var_1_1 = FightModel.instance:getFightParam()

	var_1_0:addWork(FightWorkRestartBefore.New(var_1_1))
	var_1_0:addWork(FightWorkFastRestartRequest.New(var_1_1))
	arg_1_0:playWorkAndDone(var_1_0)
end

return var_0_0
