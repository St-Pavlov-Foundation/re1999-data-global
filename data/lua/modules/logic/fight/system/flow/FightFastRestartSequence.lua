module("modules.logic.fight.system.flow.FightFastRestartSequence", package.seeall)

local var_0_0 = class("FightFastRestartSequence", BaseFightSequence)

function var_0_0.buildFlow(arg_1_0)
	var_0_0.super.buildFlow(arg_1_0)

	local var_1_0 = FightModel.instance:getFightParam()

	arg_1_0:addWork(FightWorkRestartBefore.New(var_1_0))
	arg_1_0:addWork(FightWorkFastRestartRequest.New(var_1_0))
end

return var_0_0
