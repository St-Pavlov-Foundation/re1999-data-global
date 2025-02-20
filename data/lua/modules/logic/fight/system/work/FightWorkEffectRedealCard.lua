module("modules.logic.fight.system.work.FightWorkEffectRedealCard", package.seeall)

slot0 = class("FightWorkEffectRedealCard", FightEffectBase)

function slot0.onStart(slot0)
	FightCardModel.instance:clearCardOps()
	FightController.instance:dispatchEvent(FightEvent.PushCardInfo)

	if FightCardModel.instance.redealCardInfoList then
		slot0:_playRedealCardEffect()
	else
		slot0:onDone(true)
	end
end

function slot0._playRedealCardEffect(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_shuffle_allcard)

	slot1 = FightCardModel.instance:getHandCards()
	FightCardModel.instance.redealCardInfoList = nil

	FightCardModel.instance:coverCard(FightCardModel.instance.redealCardInfoList)

	if FightModel.instance:getVersion() < 4 then
		FightCardModel.instance:coverCard(FightCardModel.calcCardsAfterCombine(slot2))
	end

	slot0:com_registTimer(slot0._delayAfterPerformance, 1.5 / FightModel.instance:getUISpeed())
	FightController.instance:dispatchEvent(FightEvent.PlayRedealCardEffect, slot1, slot2)
end

function slot0.clearWork(slot0)
end

return slot0
