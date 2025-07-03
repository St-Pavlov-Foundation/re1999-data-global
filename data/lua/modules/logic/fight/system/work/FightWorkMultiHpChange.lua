module("modules.logic.fight.system.work.FightWorkMultiHpChange", package.seeall)

local var_0_0 = class("FightWorkMultiHpChange", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	arg_1_0._entityId = arg_1_0.actEffectData.targetId
	arg_1_0._oldEntityMO = FightDataHelper.entityMgr:getOldEntityMO(arg_1_0._entityId)
end

function var_0_0.onStart(arg_2_0)
	arg_2_0._newEntityMO = FightDataHelper.entityMgr:getById(arg_2_0._entityId)

	local var_2_0 = FightHelper.getEntity(arg_2_0._entityId)

	if not var_2_0 or not arg_2_0._oldEntityMO then
		arg_2_0:onDone(true)

		return
	end

	local var_2_1 = arg_2_0:com_registWorkDoneFlowSequence()

	if arg_2_0._newEntityMO then
		var_2_0.beforeMonsterChangeSkin = arg_2_0._oldEntityMO.skin

		local var_2_2 = FightWorkFlowSequence.New()

		var_2_2:registWork(FightWorkFunction, arg_2_0._buildNewEntity, arg_2_0)
		var_2_2:registWork(FightWorkSendEvent, FightEvent.MultiHpChange, arg_2_0._newEntityMO.id)
		FightHelper.buildMonsterA2B(var_2_0, arg_2_0._oldEntityMO, var_2_1, var_2_2)
	end

	var_2_1:start()
end

function var_0_0._buildNewEntity(arg_3_0)
	if lua_fight_boss_evolution_client.configDict[arg_3_0._oldEntityMO.skin] then
		local var_3_0 = GameSceneMgr.instance:getCurScene().entityMgr
		local var_3_1 = FightHelper.getEntity(arg_3_0._newEntityMO.id)

		if var_3_1 then
			var_3_0:removeUnit(var_3_1:getTag(), var_3_1.id)
		end

		local var_3_2 = var_3_0:buildSpine(arg_3_0._newEntityMO)
		local var_3_3 = var_3_2 and var_3_2.buff

		if var_3_3 then
			xpcall(var_3_3.dealStartBuff, __G__TRACKBACK__, var_3_3)
		end
	end
end

function var_0_0.clearWork(arg_4_0)
	return
end

return var_0_0
