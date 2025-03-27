module("modules.logic.fight.system.work.FightWorkAverageLife", package.seeall)

slot0 = class("FightWorkAverageLife", FightEffectBase)

function slot0.onStart(slot0)
	slot0:com_sendFightEvent(FightEvent.OnCurrentHpChange, slot0._actEffectMO.targetId)
	slot0:onDone(true)
end

return slot0
