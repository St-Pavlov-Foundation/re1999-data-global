module("modules.logic.fight.system.work.FightWorkCardClear", package.seeall)

slot0 = class("FightWorkCardClear", FightEffectBase)

function slot0.onStart(slot0)
	slot0:com_sendFightEvent(FightEvent.CardClear)
	slot0:onDone(true)
end

return slot0
