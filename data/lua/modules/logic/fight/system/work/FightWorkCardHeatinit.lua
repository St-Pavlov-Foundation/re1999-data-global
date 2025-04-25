module("modules.logic.fight.system.work.FightWorkCardHeatinit", package.seeall)

slot0 = class("FightWorkCardHeatinit", FightEffectBase)

function slot0.onStart(slot0)
	slot0:onDone(true)
end

return slot0
