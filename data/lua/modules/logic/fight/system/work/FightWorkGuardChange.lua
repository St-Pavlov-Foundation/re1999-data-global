module("modules.logic.fight.system.work.FightWorkGuardChange", package.seeall)

local var_0_0 = class("FightWorkGuardChange", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0.actEffectData
	local var_1_1 = FightDataHelper.entityMgr:getById(var_1_0.targetId)

	if var_1_1 then
		FightController.instance:dispatchEvent(FightEvent.EntityGuardChange, var_1_1.id, arg_1_0.actEffectData.effectNum, var_1_1.guard)
	end

	arg_1_0:onDone(true)
end

function var_0_0.clearWork(arg_2_0)
	return
end

return var_0_0
