module("modules.logic.fight.system.work.FightWorkMultiHpChange", package.seeall)

slot0 = class("FightWorkMultiHpChange", FightEffectBase)

function slot0.beforePlayEffectData(slot0)
	slot0._entityId = slot0._actEffectMO.targetId
	slot0._oldEntityMO = FightDataHelper.entityMgr:getOldEntityMO(slot0._entityId)
end

function slot0.onStart(slot0)
	slot0._newEntityMO = FightDataHelper.entityMgr:getById(slot0._entityId)

	if not FightHelper.getEntity(slot0._entityId) or not slot0._oldEntityMO then
		slot0:onDone(true)

		return
	end

	slot2 = slot0:com_registWorkDoneFlowSequence()

	if slot0._newEntityMO then
		slot1.beforeMonsterChangeSkin = slot0._oldEntityMO.skin
		slot3 = FightWorkFlowSequence.New()

		slot3:registWork(FightWorkFunction, slot0._buildNewEntity, slot0)
		slot3:registWork(FightWorkSendEvent, FightEvent.MultiHpChange, slot0._newEntityMO.id)
		FightHelper.buildMonsterA2B(slot1, slot0._oldEntityMO, slot2, slot3)
	end

	slot2:start()
end

function slot0._buildNewEntity(slot0)
	if lua_fight_boss_evolution_client.configDict[slot0._oldEntityMO.skin] then
		slot2 = GameSceneMgr.instance:getCurScene().entityMgr

		if FightHelper.getEntity(slot0._newEntityMO.id) then
			slot2:removeUnit(slot3:getTag(), slot3.id)
		end

		if slot2:buildSpine(slot0._newEntityMO) and slot4.buff then
			xpcall(slot5.dealStartBuff, __G__TRACKBACK__, slot5)
		end
	end
end

function slot0.clearWork(slot0)
end

return slot0
