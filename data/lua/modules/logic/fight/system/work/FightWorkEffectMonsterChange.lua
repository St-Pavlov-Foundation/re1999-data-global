module("modules.logic.fight.system.work.FightWorkEffectMonsterChange", package.seeall)

slot0 = class("FightWorkEffectMonsterChange", FightEffectBase)

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
		slot0:onDone(true)

		return
	end

	slot0._newEntityMO.custom_refreshNameUIOp = true

	slot0:com_registWorkDoneFlowSequence():addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.MonsterChangeBefore, slot0._oldEntityMO.modelId))

	if lua_fight_boss_evolution_client.configDict[slot0._oldEntityMO.skin] then
		slot1.beforeMonsterChangeSkin = slot0._oldEntityMO.skin
		slot4 = FightWorkFlowSequence.New()

		FightHelper.buildMonsterA2B(slot1, slot0._oldEntityMO, slot4, FightWorkFunction.New(slot0._buildNewEntity, slot0))
		slot4:registWork(FightWorkDelayTimer, 0.01)
		slot2:addWork(slot4)
	else
		slot2:registWork(FightWorkFunction, slot0._removeOldEntity, slot0, slot1)
		slot2:registWork(FightWorkFunction, slot0._buildNewEntity, slot0)
	end

	slot2:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.MonsterChangeAfter, slot0._newEntityMO.modelId))
	slot2:registWork(FightWorkFunction, slot0._dispatchChangeEvent, slot0)
	slot2:start()
end

function slot0._removeOldEntity(slot0, slot1)
	GameSceneMgr.instance:getCurScene().entityMgr:removeUnit(slot1:getTag(), slot1.id)
end

function slot0._buildNewEntity(slot0)
	slot1 = GameSceneMgr.instance:getCurScene().entityMgr

	if FightHelper.getEntity(slot0._newEntityMO.id) then
		slot1:removeUnit(slot2:getTag(), slot2.id)
	end

	if slot1:buildSpine(slot0._newEntityMO) and slot3.buff then
		xpcall(slot4.dealStartBuff, __G__TRACKBACK__, slot4)
	end
end

function slot0._dispatchChangeEvent(slot0)
	slot0:com_sendFightEvent(FightEvent.OnMonsterChange, slot0._oldEntityMO, slot0._newEntityMO)
end

function slot0.clearWork(slot0)
end

return slot0
