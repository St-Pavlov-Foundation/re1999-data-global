module("modules.logic.fight.system.work.FightWorkCardInvalid", package.seeall)

slot0 = class("FightWorkCardInvalid", FightEffectBase)

function slot0.onStart(slot0)
	if FightModel.instance:getVersion() >= 1 and slot0._actEffectMO.teamType ~= FightEnum.TeamType.MySide then
		if FightModel.instance:getCurRoundMO() and slot2:getAILastUseCard()[slot0._actEffectMO.effectNum] then
			slot4.custom_done = true
		end

		FightController.instance:dispatchEvent(FightEvent.InvalidEnemyUsedCard, slot0._actEffectMO.effectNum)
		slot0:onDone(true)

		return
	end

	FightPlayCardModel.instance:playCard(slot0._actEffectMO.effectNum)
	FightController.instance:dispatchEvent(FightEvent.InvalidUsedCard, slot0._actEffectMO.effectNum, slot0._actEffectMO.configEffect)
	slot0:com_registTimer(slot0._delayDone, 1 / FightModel.instance:getUISpeed())
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
