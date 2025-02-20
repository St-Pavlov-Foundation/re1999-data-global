module("modules.logic.fight.system.work.FightWorkEffectCardLevelChange", package.seeall)

slot0 = class("FightWorkEffectCardLevelChange", FightEffectBase)

function slot0.onStart(slot0)
	slot0:_startChangeCardEffect()
end

function slot0._startChangeCardEffect(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0._actEffectMO) then
		slot0:onDone(true)

		return
	end

	if FightModel.instance:getVersion() < 1 then
		if not FightHelper.getEntity(slot0._actEffectMO.entityMO.id) then
			slot0:onDone(true)

			return
		end

		if not slot3:isMySide() then
			slot0:onDone(true)

			return
		end
	end

	slot3 = slot0._actEffectMO.effectNum

	if not FightCardModel.instance:getHandCards()[tonumber(slot0._actEffectMO.targetId)] then
		slot0:onDone(true)

		return
	end

	slot0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	slot5.uid = slot0._actEffectMO.entityMO.id
	slot5.skillId = slot3

	if FightModel.instance:getVersion() >= 4 then
		FightController.instance:dispatchEvent(FightEvent.CardLevelChange, slot5, slot2, slot5.skillId)
		slot0:com_registTimer(slot0._delayDone, FightEnum.PerformanceTime.CardLevelChange / FightModel.instance:getUISpeed())
	else
		FightCardModel.instance:coverCard(FightCardModel.calcCardsAfterCombine(slot4))
		FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
		slot0:onDone(true)
	end
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return slot0
