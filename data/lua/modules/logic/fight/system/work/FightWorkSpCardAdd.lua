module("modules.logic.fight.system.work.FightWorkSpCardAdd", package.seeall)

slot0 = class("FightWorkSpCardAdd", FightEffectBase)

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0._actEffectMO) then
		slot0:onDone(true)

		return
	end

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)

	slot1 = FightCardInfoMO.New()

	slot1:init({
		uid = "0",
		skillId = slot0._actEffectMO.effectNum
	})

	slot2 = FightCardModel.instance:getHandCards()

	table.insert(slot2, slot1)
	FightCardModel.instance:coverCard(slot2)

	slot0._revertVisible = true

	FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_add_universalcard)
	FightController.instance:dispatchEvent(FightEvent.SpCardAdd, #slot2)
	slot0:com_registTimer(slot0._delayAfterPerformance, 0.7 / FightModel.instance:getUISpeed())
end

function slot0.clearWork(slot0)
	if slot0._revertVisible then
		FightController.instance:dispatchEvent(FightEvent.SetHandCardVisible, true, true)
	end
end

return slot0
