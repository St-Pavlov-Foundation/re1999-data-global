module("modules.logic.fight.system.work.FightWorkBFSGConvertCard", package.seeall)

slot0 = class("FightWorkBFSGConvertCard", FightEffectBase)

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0._actEffectMO) then
		slot0:onDone(true)

		return
	end

	if FightCardModel.instance:getHandCards()[slot0._actEffectMO.effectNum] then
		slot3:init(slot0._actEffectMO.cardInfo)
		FightController.instance:dispatchEvent(FightEvent.RefreshOneHandCard, slot2)
	end

	slot0:onDone(true)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
