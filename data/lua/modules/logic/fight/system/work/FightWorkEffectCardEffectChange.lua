module("modules.logic.fight.system.work.FightWorkEffectCardEffectChange", package.seeall)

slot0 = class("FightWorkEffectCardEffectChange", FightEffectBase)

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0._actEffectMO) then
		slot0:onDone(true)

		return
	end

	for slot6, slot7 in ipairs(string.splitToNumber(slot0._actEffectMO.reserveStr, "#")) do
		FightCardModel.instance:getHandCards()[slot7]:init(slot0._actEffectMO.cardInfoList[slot6])
		FightController.instance:dispatchEvent(FightEvent.RefreshOneHandCard, slot7)
		FightController.instance:dispatchEvent(FightEvent.CardEffectChange, slot7)
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
