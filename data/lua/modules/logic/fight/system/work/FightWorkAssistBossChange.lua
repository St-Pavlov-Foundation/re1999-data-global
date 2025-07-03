module("modules.logic.fight.system.work.FightWorkAssistBossChange", package.seeall)

local var_0_0 = class("FightWorkAssistBossChange", FightEffectBase)

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
		arg_2_0:_dispatchChangeEvent()

		return arg_2_0:onDone(true)
	end

	local var_2_1 = arg_2_0:com_registWorkDoneFlowSequence()
	local var_2_2 = lua_fight_boss_evolution_client.configDict[arg_2_0._oldEntityMO.skin]

	if var_2_2 then
		var_2_0.beforeMonsterChangeSkin = arg_2_0._oldEntityMO.skin

		var_2_1:addWork(Work2FightWork.New(FightWorkPlayTimeline, var_2_0, var_2_2.timeline))
		var_2_1:registWork(FightWorkFunction, arg_2_0._removeOldEntity, arg_2_0, var_2_0)
		var_2_1:addWork(FightWorkFunction.New(arg_2_0._buildNewEntity, arg_2_0))
		var_2_1:registWork(FightWorkDelayTimer, 0.01)
	else
		var_2_1:registWork(FightWorkFunction, arg_2_0._removeOldEntity, arg_2_0, var_2_0)
		var_2_1:addWork(FightWorkFunction.New(arg_2_0._buildNewEntity, arg_2_0))
	end

	var_2_1:addWork(FightWorkFunction.New(arg_2_0._dispatchChangeEvent, arg_2_0))
	var_2_1:start()
end

function var_0_0._removeOldEntity(arg_3_0, arg_3_1)
	GameSceneMgr.instance:getCurScene().entityMgr:removeUnit(arg_3_1:getTag(), arg_3_1.id)
end

function var_0_0._buildNewEntity(arg_4_0)
	local var_4_0 = GameSceneMgr.instance:getCurScene().entityMgr:buildSpine(arg_4_0._newEntityMO)
	local var_4_1 = var_4_0 and var_4_0.buff

	if var_4_1 then
		xpcall(var_4_1.dealStartBuff, __G__TRACKBACK__, var_4_1)
	end
end

function var_0_0._dispatchChangeEvent(arg_5_0)
	arg_5_0:com_sendFightEvent(FightEvent.OnSwitchAssistBossSpine)
end

return var_0_0
