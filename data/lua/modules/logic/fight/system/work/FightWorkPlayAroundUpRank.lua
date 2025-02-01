module("modules.logic.fight.system.work.FightWorkPlayAroundUpRank", package.seeall)

slot0 = class("FightWorkPlayAroundUpRank", FightEffectBase)

function slot0.onStart(slot0)
	if not FightCardMOHelper.cardChangeIsMySide(slot0._actEffectMO) then
		slot0:onDone(true)

		return
	end

	if FightPlayCardModel.instance:getUsedCards()[slot0._actEffectMO.effectNum] then
		slot3:init(slot0._actEffectMO.cardInfo)
		slot0:com_sendFightEvent(FightEvent.PlayCardAroundUpRank, slot1, slot3.skillId)
	end

	slot0:com_registTimer(slot0._delayAfterPerformance, FightEnum.PerformanceTime.CardLevelChange / FightModel.instance:getUISpeed())
end

function slot0.clearWork(slot0)
end

return slot0
