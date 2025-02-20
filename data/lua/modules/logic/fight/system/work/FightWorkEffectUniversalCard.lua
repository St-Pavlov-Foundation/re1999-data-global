module("modules.logic.fight.system.work.FightWorkEffectUniversalCard", package.seeall)

slot0 = class("FightWorkEffectUniversalCard", FightEffectBase)
slot1 = "ui/viewres/fight/ui_effect_flusheddown.prefab"

function slot0.onStart(slot0)
	if not FightCardDataHelper.cardChangeIsMySide(slot0._actEffectMO) then
		slot0:onDone(true)

		return
	end

	FightCardModel.instance:clearCardOps()
	FightController.instance:dispatchEvent(FightEvent.PushCardInfo)

	slot1 = FightCardInfoMO.New()

	slot1:init({
		uid = "0",
		skillId = slot0._actEffectMO.effectNum
	})
	FightController.instance:dispatchEvent(FightEvent.UniversalAppear, slot1)
	slot0:com_registTimer(slot0._delayDone, 1.3 / FightModel.instance:getUISpeed())
	AudioMgr.instance:trigger(AudioEnum.UI.Play_ui_add_universalcard)
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
