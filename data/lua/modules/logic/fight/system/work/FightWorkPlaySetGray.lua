module("modules.logic.fight.system.work.FightWorkPlaySetGray", package.seeall)

slot0 = class("FightWorkPlaySetGray", FightEffectBase)

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0._actEffectMO) then
		slot0:onDone(true)

		return
	end

	if FightPlayCardModel.instance:getUsedCards()[slot0._actEffectMO.effectNum] then
		slot3:init(slot0._actEffectMO.cardInfo)
		FightController.instance:dispatchEvent(FightEvent.PlayCardAroundSetGray, slot1)
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
