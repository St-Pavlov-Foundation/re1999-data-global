module("modules.logic.fight.system.work.FightWorkStepBuff", package.seeall)

local var_0_0 = class("FightWorkStepBuff", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	local var_1_0 = arg_1_0.actEffectData.buff

	arg_1_0._buffUid = var_1_0 and var_1_0.uid
	arg_1_0._buffId = var_1_0 and var_1_0.buffId
	arg_1_0._entityId = arg_1_0.actEffectData.targetId
	arg_1_0._entityMO = FightDataHelper.entityMgr:getById(arg_1_0._entityId)

	if not arg_1_0._entityMO then
		return
	end

	local var_1_1 = arg_1_0._entityMO:getBuffMO(arg_1_0._buffUid)

	arg_1_0._oldBuffMO = FightHelper.deepCopySimpleWithMeta(var_1_1)
end

function var_0_0.onStart(arg_2_0)
	if not arg_2_0._entityMO then
		arg_2_0:onDone(true)

		return
	end

	local var_2_0 = FightHelper.getEntity(arg_2_0._entityId)

	if not var_2_0 then
		arg_2_0:onDone(true)

		return
	end

	if not var_2_0.buff then
		arg_2_0:onDone(true)

		return
	end

	var_0_0.updateWaitTime = FightBuffHelper.canPlayDormantBuffAni(arg_2_0.actEffectData, arg_2_0.fightStepData)

	local var_2_1 = arg_2_0.actEffectData.effectType

	if var_2_1 == FightEnum.EffectType.BUFFADD or var_2_1 == FightEnum.EffectType.BUFFUPDATE then
		arg_2_0._newBuffMO = arg_2_0._entityMO:getBuffMO(arg_2_0._buffUid)

		if not arg_2_0._newBuffMO then
			arg_2_0:onDone(true)

			return
		end
	end

	if var_2_1 == FightEnum.EffectType.BUFFADD then
		var_2_0.buff:addBuff(arg_2_0._newBuffMO, false, arg_2_0.fightStepData.stepUid)
	elseif var_2_1 == FightEnum.EffectType.BUFFDEL or var_2_1 == FightEnum.EffectType.BUFFDELNOEFFECT then
		var_2_0.buff:delBuff(arg_2_0._buffUid)
	elseif var_2_1 == FightEnum.EffectType.BUFFUPDATE then
		var_2_0.buff:updateBuff(arg_2_0._newBuffMO, arg_2_0._oldBuffMO or arg_2_0._newBuffMO, arg_2_0.actEffectData)
	end

	FightController.instance:dispatchEvent(FightEvent.OnBuffUpdate, arg_2_0._entityId, var_2_1, arg_2_0._buffId, arg_2_0._buffUid, arg_2_0.actEffectData.configEffect, arg_2_0.actEffectData.buff)

	local var_2_2 = FightDataHelper.tempMgr.buffDurationDic[arg_2_0._entityId]

	if not var_2_2 then
		var_2_2 = {}
		FightDataHelper.tempMgr.buffDurationDic[arg_2_0._entityId] = var_2_2
	end

	var_2_2[arg_2_0._buffUid] = arg_2_0.actEffectData.buff.duration

	if var_0_0.canPlayDormantBuffAni then
		arg_2_0:com_registTimer(arg_2_0._delayDone, var_0_0.updateWaitTime / FightModel.instance:getSpeed())

		return
	end

	if arg_2_0._buffId == 229601 then
		arg_2_0:com_registTimer(arg_2_0._delayDone, 1.5)

		return
	end

	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	return
end

return var_0_0
