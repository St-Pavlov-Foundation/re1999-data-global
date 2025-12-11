module("modules.logic.fight.system.work.FightWorkKill110", package.seeall)

local var_0_0 = class("FightWorkKill110", FightEffectBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0.actEffectData.hurtInfo
	local var_1_1 = arg_1_0.actEffectData.targetId
	local var_1_2 = FightDataHelper.entityMgr:getById(var_1_1)

	if var_1_2 then
		local var_1_3 = var_1_2.currentHp
		local var_1_4 = var_1_3 + var_1_0.reduceHp

		FightController.instance:dispatchEvent(FightEvent.OnCurrentHpChange, var_1_1, var_1_4, var_1_3)
	end

	FightMsgMgr.sendMsg(FightMsgId.EntityHurt, var_1_1, var_1_0)

	return arg_1_0:onDone(true)
end

return var_0_0
