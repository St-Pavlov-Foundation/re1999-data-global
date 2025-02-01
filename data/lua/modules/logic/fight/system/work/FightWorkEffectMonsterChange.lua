module("modules.logic.fight.system.work.FightWorkEffectMonsterChange", package.seeall)

slot0 = class("FightWorkEffectMonsterChange", FightEffectBase)
slot0.needWaitBeforeChange = nil

function slot0.onStart(slot0)
	slot0:cancelFightWorkSafeTimer()

	uv0.needWaitBeforeChange = nil

	if slot0._actEffectMO.entityMO and slot0._actEffectMO.entityMO.modelId then
		slot0:com_sendFightEvent(FightEvent.BeforeMonsterChange, slot0._actEffectMO.entityMO.modelId)
	end

	if uv0.needWaitBeforeChange then
		slot0:com_registFightEvent(FightEvent.ContinueMonsterChange, slot0._continueMonsterChange)
	else
		slot0:_continueMonsterChange()
	end
end

function slot0._replaceEntity(slot0, slot1)
	FightEntityModel.instance:replaceEntityMO(slot0._actEffectMO.entityMO)

	if GameSceneMgr.instance:getCurScene().entityMgr:buildSpine(slot0._actEffectMO.entityMO) and slot3.buff then
		xpcall(slot4.dealStartBuff, __G__TRACKBACK__, slot4)
	end

	slot0:com_sendFightEvent(FightEvent.OnMonsterChange, slot1, slot0._actEffectMO.entityMO)
end

function slot0._continueMonsterChange(slot0)
	slot0:com_cancelFightEvent(FightEvent.ContinueMonsterChange, slot0._continueMonsterChange)
	FightHelper.setEffectEntitySide(slot0._actEffectMO)

	slot2 = FightHelper.getEntity(slot0._actEffectMO.targetId) and slot1:getMO()

	if slot0._actEffectMO.entityMO then
		slot0._actEffectMO.entityMO.custom_refreshNameUIOp = true
	end

	if slot2 and lua_fight_boss_evolution_client.configDict[slot2.skin] and slot1 and slot2 and slot0._actEffectMO.entityMO then
		slot4 = slot0:com_registFlowSequence()

		FightHelper.buildMonsterA2B(slot1, slot4, FightWorkFunction.New(slot0._replaceEntity, slot0, slot2))
		slot4:registWork(FightWorkDelayTimer, 0.01)
		slot4:registFinishCallback(slot0.finishWork, slot0)
		slot4:start()
	else
		slot4 = nil

		if GameSceneMgr.instance:getCurScene().entityMgr then
			if FightHelper.getEntity(slot0._actEffectMO.targetId) then
				slot2 = slot6:getMO()

				slot5:removeUnit(slot6:getTag(), slot6.id)
			end

			if slot0._actEffectMO.entityMO then
				FightEntityModel.instance:replaceEntityMO(slot0._actEffectMO.entityMO)

				if slot5:buildSpine(slot0._actEffectMO.entityMO) and slot4.buff then
					xpcall(slot7.dealStartBuff, __G__TRACKBACK__, slot7)
				end
			elseif slot6 then
				FightEntityModel.instance:removeEntityById(slot6.id)
			end
		end

		if slot4 then
			slot0._newEntityMO = slot4:getMO()
			uv0.needWaitBeforeChange = nil

			if slot0._actEffectMO.entityMO and slot0._actEffectMO.entityMO.modelId then
				slot0:com_sendFightEvent(FightEvent.AfterMonsterChange, slot0._actEffectMO.entityMO.modelId)
			end

			if slot2 and slot0._newEntityMO then
				slot0:com_sendFightEvent(FightEvent.OnMonsterChange, slot2, slot0._newEntityMO)
			end

			if uv0.needWaitBeforeChange then
				slot0:com_registFightEvent(FightEvent.ContinueMonsterChange, slot0._continueMonsterChangeAfter)
			else
				slot0:_continueMonsterChangeAfter()
			end
		else
			if slot5 then
				logError("MonsterChange error, no actEffectMO.entityMO")
			else
				logError("MonsterChange error, not in fight scene")
			end

			slot0:onDone(true)
		end
	end
end

function slot0._continueMonsterChangeAfter(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
