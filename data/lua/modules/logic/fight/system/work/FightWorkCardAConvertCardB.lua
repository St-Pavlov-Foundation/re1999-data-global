module("modules.logic.fight.system.work.FightWorkCardAConvertCardB", package.seeall)

slot0 = class("FightWorkCardAConvertCardB", FightEffectBase)

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0._actEffectMO) then
		slot0:onDone(true)

		return
	end

	slot0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)
	AudioMgr.instance:trigger(2000072)

	if FightCardModel.instance:getHandCards()[slot0._actEffectMO.effectNum] then
		slot3:init(slot0._actEffectMO.cardInfo)

		if FightModel.instance:getVersion() >= 4 then
			FightController.instance:dispatchEvent(FightEvent.CardAConvertCardB, slot2)
			slot0:com_registTimer(slot0._delayAfterPerformance, FightEnum.PerformanceTime.CardAConvertCardB / FightModel.instance:getUISpeed())
		else
			FightController.instance:dispatchEvent(FightEvent.RefreshHandCard)
			slot0:onDone(true)
		end

		return
	end

	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return slot0
