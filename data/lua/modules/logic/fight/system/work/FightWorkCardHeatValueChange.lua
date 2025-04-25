module("modules.logic.fight.system.work.FightWorkCardHeatValueChange", package.seeall)

slot0 = class("FightWorkCardHeatValueChange", FightEffectBase)

function slot0.onStart(slot0)
	slot0:com_sendFightEvent(FightEvent.RefreshCardHeatShow)
	slot0:onDone(true)
end

return slot0
