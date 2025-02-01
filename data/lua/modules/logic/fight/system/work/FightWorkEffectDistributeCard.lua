module("modules.logic.fight.system.work.FightWorkEffectDistributeCard", package.seeall)

slot0 = class("FightWorkEffectDistributeCard", FightEffectBase)
slot0.handCardScale = 0.52
slot0.handCardScaleTime = 0.25

function slot0.getHandCardScaleTime()
	return uv0.handCardScaleTime / FightModel.instance:getUISpeed()
end

function slot0.onStart(slot0)
	slot0:com_registTimer(slot0._delayDone, 20)

	if FightCardModel.instance:isDissolving() then
		FightController.instance:registerCallback(FightEvent.OnDissolveCombineEnd, slot0._onDissolveCombineEnd, slot0)
		TaskDispatcher.runDelay(slot0._dissolveTimeout, slot0, 10 / Mathf.Clamp(FightModel.instance:getUISpeed(), 0.01, 100))
	else
		TaskDispatcher.runDelay(slot0._delayDistribute, slot0, 0.01)
	end
end

function slot0._onDissolveCombineEnd(slot0)
	FightController.instance:unregisterCallback(FightEvent.OnDissolveCombineEnd, slot0._onDissolveCombineEnd, slot0)
	TaskDispatcher.cancelTask(slot0._dissolveTimeout, slot0)
	slot0:_delayDistribute()
end

function slot0._dissolveTimeout(slot0)
	logError("溶牌超时，继续发牌")
	FightController.instance:unregisterCallback(FightEvent.OnDissolveCombineEnd, slot0._onDissolveCombineEnd, slot0)
	slot0:_delayDistribute()
end

function slot0._delayDistribute(slot0)
	if not FightModel.instance:getCurRoundMO() then
		logError("回合数据不存在")
		slot0:onDone(false)

		return
	end

	FightController.instance:setCurStage(FightEnum.Stage.FillCard)

	if slot0._actEffectMO.effectType == FightEnum.EffectType.DEALCARD2 then
		slot3 = slot1.teamACards2

		if #slot1.beforeCards2 > 0 or #slot3 > 0 then
			FightCardModel.instance:clearDistributeQueue()
			FightCardModel.instance:enqueueDistribute(slot2, slot3)
			FightController.instance:registerCallback(FightEvent.OnDistributeCards, slot0._distributeDone, slot0)
			FightViewPartVisible.set(false, true, false, false, false)
			FightController.instance:dispatchEvent(FightEvent.DistributeCards)
		else
			slot0:_distributeDone()
		end
	else
		slot0:onDone(true)
	end
end

function slot0._distributeDone(slot0)
	FightController.instance:setCurStage(FightEnum.Stage.Play)
	FightController.instance:unregisterCallback(FightEvent.OnDistributeCards, slot0._distributeDone, slot0)

	if not gohelper.isNil(FightViewHandCard.handCardContainer) and #FightHelper.getSideEntitys(FightEnum.EntitySide.EnemySide, true) > 0 and slot0:_checkHasEnemySkill() then
		FightViewPartVisible.set(false, true, false, true, false)

		slot4 = uv0.handCardScale

		ZProj.TweenHelper.DOScale(slot1.transform, slot4, slot4, slot4, uv0.getHandCardScaleTime(), slot0._onHandCardsShrink, slot0)
	else
		slot0:_onHandCardsShrink()
	end
end

function slot0._checkHasEnemySkill(slot0)
	for slot6, slot7 in ipairs(FightModel.instance:getCurRoundMO().fightStepMOs) do
		if not false and slot7.actType == FightEnum.ActType.EFFECT then
			for slot11, slot12 in ipairs(slot7.actEffectMOs) do
				if slot12.effectType == FightEnum.EffectType.DEALCARD2 then
					slot2 = true

					break
				end
			end
		elseif slot2 and slot7.actType == FightEnum.ActType.SKILL and FightHelper.getEntity(slot7.fromId) and slot8:isEnemySide() then
			return true
		end
	end

	return false
end

function slot0._onHandCardsShrink(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._delayDistribute, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnDistributeCards, slot0._distributeDone, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnDissolveCombineEnd, slot0._onDissolveCombineEnd, slot0)
	TaskDispatcher.cancelTask(slot0._dissolveTimeout, slot0)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

return slot0
