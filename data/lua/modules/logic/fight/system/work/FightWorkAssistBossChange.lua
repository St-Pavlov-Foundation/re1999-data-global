module("modules.logic.fight.system.work.FightWorkAssistBossChange", package.seeall)

slot0 = class("FightWorkAssistBossChange", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0._entityId = slot0._actEffectMO.entityMO.id
	slot0._oldEntityMO = FightDataHelper.entityMgr:getOldEntityMO(slot0._entityId)
end

function slot0.onStart(slot0)
	slot0._newEntityMO = FightDataHelper.entityMgr:getById(slot0._entityId)

	if not slot0._newEntityMO then
		slot0:onDone(true)

		return
	end

	if not FightHelper.getEntity(slot0._actEffectMO.targetId) then
		slot0:_buildNewEntity()
		slot0:_dispatchChangeEvent()

		return slot0:onDone(true)
	end

	slot2 = slot0:com_registWorkDoneFlowSequence()

	if lua_fight_boss_evolution_client.configDict[slot0._oldEntityMO.skin] then
		slot1.beforeMonsterChangeSkin = slot0._oldEntityMO.skin

		slot2:addWork(Work2FightWork.New(FightWorkPlayTimeline, slot1, slot3.timeline))
		slot2:registWork(FightWorkFunction, slot0._removeOldEntity, slot0, slot1)
		slot2:addWork(FightWorkFunction.New(slot0._buildNewEntity, slot0))
		slot2:registWork(FightWorkDelayTimer, 0.01)
	else
		slot2:registWork(FightWorkFunction, slot0._removeOldEntity, slot0, slot1)
		slot2:addWork(FightWorkFunction.New(slot0._buildNewEntity, slot0))
	end

	slot2:addWork(FightWorkFunction.New(slot0._dispatchChangeEvent, slot0))
	slot2:start()
end

function slot0._removeOldEntity(slot0, slot1)
	GameSceneMgr.instance:getCurScene().entityMgr:removeUnit(slot1:getTag(), slot1.id)
end

function slot0._buildNewEntity(slot0)
	if GameSceneMgr.instance:getCurScene().entityMgr:buildSpine(slot0._newEntityMO) and slot2.buff then
		xpcall(slot3.dealStartBuff, __G__TRACKBACK__, slot3)
	end
end

function slot0._dispatchChangeEvent(slot0)
	slot0:com_sendFightEvent(FightEvent.OnSwitchAssistBossSpine)
end

return slot0
