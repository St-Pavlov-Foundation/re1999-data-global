module("modules.logic.fight.system.work.FightWorkPlayChangeRankFail", package.seeall)

slot0 = class("FightWorkPlayChangeRankFail", FightEffectBase)

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0._actEffectMO) then
		slot0:onDone(true)

		return
	end

	slot0:com_sendFightEvent(FightEvent.PlayChangeRankFail, slot0._actEffectMO.effectNum, slot0._actEffectMO.reserveStr)
	slot0:com_registTimer(slot0._delayAfterPerformance, FightEnum.PerformanceTime.CardLevelChange / FightModel.instance:getUISpeed())
end

function slot0.clearWork(slot0)
end

return slot0
