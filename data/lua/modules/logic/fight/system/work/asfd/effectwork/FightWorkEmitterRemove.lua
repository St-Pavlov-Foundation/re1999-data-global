module("modules.logic.fight.system.work.asfd.effectwork.FightWorkEmitterRemove", package.seeall)

local var_0_0 = class("FightWorkEmitterRemove", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	local var_1_0 = arg_1_0.actEffectData.effectNum

	arg_1_0.emitterMo = FightDataHelper.entityMgr:getASFDEntityMo(var_1_0)
end

function var_0_0.onStart(arg_2_0)
	if not arg_2_0.emitterMo then
		return arg_2_0:onDone(true)
	end

	local var_2_0 = GameSceneMgr.instance:getCurScene()
	local var_2_1 = var_2_0 and var_2_0.entityMgr

	if not var_2_1 then
		return arg_2_0:onDone(true)
	end

	local var_2_2 = FightHelper.getEntity(arg_2_0.emitterMo.id)

	if var_2_2 then
		var_2_1:removeUnit(var_2_2:getTag(), var_2_2.id)
	end

	arg_2_0:onDone(true)
end

return var_0_0
