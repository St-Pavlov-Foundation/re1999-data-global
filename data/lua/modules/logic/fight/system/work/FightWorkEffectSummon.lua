module("modules.logic.fight.system.work.FightWorkEffectSummon", package.seeall)

slot0 = class("FightWorkEffectSummon", FightEffectBase)

function slot0.onStart(slot0)
	if slot0._actEffectMO.entityMO then
		if FightEntityModel.instance:isDeadUid(slot1.uid) then
			slot0:onDone(true)

			return
		end

		slot0:com_registTimer(slot0._delayDone, 10)
		FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)
		FightHelper.setEffectEntitySide(slot0._actEffectMO)
		FightEntityModel.instance:addEntityMO(slot1)

		slot0._entityId = slot1.id
		slot3 = GameSceneMgr.instance:getCurScene().entityMgr:buildSpine(slot1)
	else
		logError("summon fail, no entity")
		slot0:onDone(true)
	end
end

function slot0._onSpineLoaded(slot0, slot1)
	if slot0._entityId == slot1.unitSpawn.id then
		slot0._entity = FightHelper.getEntity(slot0._entityId)
		slot0._audioId = 410000038

		if slot0._actEffectMO.entityMO.side == FightEnum.EntitySide.MySide then
			slot0._flow = FlowParallel.New()

			slot0._flow:addWork(FightWorkStartBornNormal.New(slot0._entity, false))
		else
			slot0._flow = FlowParallel.New()
			slot3 = "buff/buff_zhaohuan"
			slot4 = 0.6
			slot5 = ModuleEnum.SpineHangPoint.mountbody

			if lua_fight_summon_show.configDict[slot2.skin] then
				if not string.nilorempty(slot6.actionName) then
					slot3 = nil

					slot0._flow:addWork(FightWorkEntityPlayAct.New(slot0._entity, slot6.actionName))
				end

				if slot6.audioId ~= 0 then
					slot0._audioId = slot6.audioId
				end

				if not string.nilorempty(slot6.effect) then
					slot3 = slot6.effect

					if slot6.effectTime and slot6.effectTime ~= 0 then
						slot4 = slot6.effectTime / 1000 or slot4
					end
				end

				if not string.nilorempty(slot6.effectHangPoint) then
					slot5 = slot6.effectHangPoint
				end

				if slot6.ingoreEffect == 1 then
					slot3 = nil
				end
			end

			if slot3 then
				slot0._flow:addWork(FightWorkStartBornExtendForEffect.New(slot0._entity, false, slot3, slot5, slot4 / FightModel.instance:getSpeed()))
			end
		end

		slot0:com_registTimer(slot0._delayDone, 60)
		slot0._flow:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.AfterSummon, slot2.modelId))
		slot0._flow:registerDoneListener(slot0._onSummonBornDone, slot0)
		slot0._flow:start()
		AudioMgr.instance:trigger(slot0._audioId)
		FightController.instance:dispatchEvent(FightEvent.OnSummon, slot0._entity)
	end
end

function slot0._playAudio(slot0, slot1)
	AudioMgr.instance:trigger(slot1)
end

function slot0._onSummonBornDone(slot0)
	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	logError("召唤效果超时")
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)

	if slot0._flow then
		slot0._flow:unregisterDoneListener(slot0._onAniFlowDone, slot0)
		slot0._flow:stop()

		slot0._flow = nil
	end
end

return slot0
