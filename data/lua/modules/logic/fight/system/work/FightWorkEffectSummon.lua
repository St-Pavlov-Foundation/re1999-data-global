module("modules.logic.fight.system.work.FightWorkEffectSummon", package.seeall)

slot0 = class("FightWorkEffectSummon", FightEffectBase)

function slot0.onStart(slot0)
	slot0._entityMO = FightDataHelper.entityMgr:getById(slot0._actEffectMO.entityMO.id)

	if slot0._entityMO then
		if FightDataHelper.entityMgr:isDeadUid(slot0._entityMO.uid) then
			slot0:onDone(true)

			return
		end

		slot0:com_registTimer(slot0._delayDone, 10)
		FightController.instance:registerCallback(FightEvent.OnSpineLoaded, slot0._onSpineLoaded, slot0)

		slot0._entityId = slot0._entityMO.id

		if isTypeOf(GameSceneMgr.instance:getCurScene().entityMgr:buildSpine(slot0._entityMO), FightEntityAssembledMonsterSub) then
			slot0:onDone(true)

			return
		end
	else
		slot0:onDone(true)
	end
end

function slot0._onSpineLoaded(slot0, slot1)
	if slot0._entityId == slot1.unitSpawn.id then
		slot0._entity = FightHelper.getEntity(slot0._entityId)
		slot0._audioId = 410000038

		if slot0._entityMO.side == FightEnum.EntitySide.MySide then
			slot0._flow = FlowParallel.New()

			slot0._flow:addWork(FightWorkStartBornNormal.New(slot0._entity, false))
		else
			slot0._flow = FlowParallel.New()
			slot2 = "buff/buff_zhaohuan"
			slot3 = 0.6
			slot4 = ModuleEnum.SpineHangPoint.mountbody

			if lua_fight_summon_show.configDict[slot0._entityMO.skin] then
				if not string.nilorempty(slot5.actionName) then
					slot2 = nil

					slot0._flow:addWork(FightWorkEntityPlayAct.New(slot0._entity, slot5.actionName))
				end

				if slot5.audioId ~= 0 then
					slot0._audioId = slot5.audioId
				end

				if not string.nilorempty(slot5.effect) then
					slot2 = slot5.effect

					if slot5.effectTime and slot5.effectTime ~= 0 then
						slot3 = slot5.effectTime / 1000 or slot3
					end
				end

				if not string.nilorempty(slot5.effectHangPoint) then
					slot4 = slot5.effectHangPoint
				end

				if slot5.ingoreEffect == 1 then
					slot2 = nil
				end
			end

			if slot2 then
				slot0._flow:addWork(FightWorkStartBornExtendForEffect.New(slot0._entity, false, slot2, slot4, slot3 / FightModel.instance:getSpeed()))
			end
		end

		slot0:com_registTimer(slot0._delayDone, 60)
		slot0._flow:addWork(FightWorkNormalDialog.New(FightViewDialog.Type.AfterSummon, slot0._entityMO.modelId))
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
