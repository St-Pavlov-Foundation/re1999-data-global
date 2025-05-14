﻿module("modules.logic.fight.system.work.FightWorkEffectDeadPerformance", package.seeall)

local var_0_0 = class("FightWorkEffectDeadPerformance", FightEffectBase)

function var_0_0.onAwake(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0._fightStepMO = arg_1_1
	arg_1_0._actEffectMO = arg_1_2
	arg_1_0._waitForLastHit = arg_1_3
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = arg_2_0:com_registWorkDoneFlowSequence()

	var_2_0:addWork(Work2FightWork.New(FightWorkEffectDeadNew, arg_2_0._fightStepMO, arg_2_0._actEffectMO, arg_2_0._waitForLastHit))

	if FightModel.instance:getVersion() < 1 and arg_2_0._actEffectMO and arg_2_0._actEffectMO.targetId then
		var_2_0:addWork(Work2FightWork.New(FightWorkDissolveCardForDeadVersion0, arg_2_0._actEffectMO))
	end

	var_2_0:start()
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
