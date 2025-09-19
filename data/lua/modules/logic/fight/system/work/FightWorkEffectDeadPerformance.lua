module("modules.logic.fight.system.work.FightWorkEffectDeadPerformance", package.seeall)

local var_0_0 = class("FightWorkEffectDeadPerformance", FightEffectBase)

function var_0_0.onAwake(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.fightStepData = arg_1_1
	arg_1_0.actEffectData = arg_1_2
	arg_1_0._waitForLastHit = arg_1_3
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = arg_2_0:com_registWorkDoneFlowSequence()

	var_2_0:registWork(FightWorkEffectDeadNew, arg_2_0.fightStepData, arg_2_0.actEffectData, arg_2_0._waitForLastHit)

	if FightModel.instance:getVersion() < 1 and arg_2_0.actEffectData and arg_2_0.actEffectData.targetId then
		var_2_0:addWork(Work2FightWork.New(FightWorkDissolveCardForDeadVersion0, arg_2_0.actEffectData))
	end

	var_2_0:start()
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
