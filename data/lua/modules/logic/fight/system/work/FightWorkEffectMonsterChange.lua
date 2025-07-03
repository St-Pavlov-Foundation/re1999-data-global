module("modules.logic.fight.system.work.FightWorkEffectMonsterChange", package.seeall)

local var_0_0 = class("FightWorkEffectMonsterChange", FightEffectBase)

function var_0_0.beforePlayEffectData(arg_1_0)
	arg_1_0._entityId = arg_1_0.actEffectData.entity.id
	arg_1_0._oldEntityMO = FightDataHelper.entityMgr:getOldEntityMO(arg_1_0._entityId)
end

function var_0_0.onStart(arg_2_0)
	arg_2_0._newEntityMO = FightDataHelper.entityMgr:getById(arg_2_0._entityId)

	if not arg_2_0._newEntityMO then
		arg_2_0:onDone(true)

		return
	end

	local var_2_0 = FightHelper.getEntity(arg_2_0.actEffectData.targetId)

	if not var_2_0 then
		arg_2_0:_buildNewEntity()
		arg_2_0:onDone(true)

		return
	end

	arg_2_0._newEntityMO.custom_refreshNameUIOp = true

	local var_2_1 = arg_2_0:com_registWorkDoneFlowSequence()

	var_2_1:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.MonsterChangeBefore, arg_2_0._oldEntityMO.modelId))

	if lua_fight_boss_evolution_client.configDict[arg_2_0._oldEntityMO.skin] then
		var_2_0.beforeMonsterChangeSkin = arg_2_0._oldEntityMO.skin

		local var_2_2 = FightWorkFlowSequence.New()
		local var_2_3 = FightWorkFunction.New(arg_2_0._buildNewEntity, arg_2_0)

		FightHelper.buildMonsterA2B(var_2_0, arg_2_0._oldEntityMO, var_2_2, var_2_3)
		var_2_2:registWork(FightWorkDelayTimer, 0.01)
		var_2_1:addWork(var_2_2)
	else
		var_2_1:registWork(FightWorkFunction, arg_2_0._removeOldEntity, arg_2_0, var_2_0)
		var_2_1:registWork(FightWorkFunction, arg_2_0._buildNewEntity, arg_2_0)
	end

	var_2_1:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.MonsterChangeAfter, arg_2_0._newEntityMO.modelId))
	var_2_1:registWork(FightWorkFunction, arg_2_0._dispatchChangeEvent, arg_2_0)
	var_2_1:start()
end

function var_0_0._removeOldEntity(arg_3_0, arg_3_1)
	GameSceneMgr.instance:getCurScene().entityMgr:removeUnit(arg_3_1:getTag(), arg_3_1.id)
end

function var_0_0._buildNewEntity(arg_4_0)
	local var_4_0 = GameSceneMgr.instance:getCurScene().entityMgr
	local var_4_1 = FightHelper.getEntity(arg_4_0._newEntityMO.id)

	if var_4_1 then
		var_4_0:removeUnit(var_4_1:getTag(), var_4_1.id)
	end

	local var_4_2 = var_4_0:buildSpine(arg_4_0._newEntityMO)
	local var_4_3 = var_4_2 and var_4_2.buff

	if var_4_3 then
		xpcall(var_4_3.dealStartBuff, __G__TRACKBACK__, var_4_3)
	end
end

function var_0_0._dispatchChangeEvent(arg_5_0)
	arg_5_0:com_sendFightEvent(FightEvent.OnMonsterChange, arg_5_0._oldEntityMO, arg_5_0._newEntityMO)
end

function var_0_0.clearWork(arg_6_0)
	return
end

return var_0_0
