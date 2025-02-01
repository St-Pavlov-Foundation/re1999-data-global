module("modules.logic.fight.system.work.FightWorkEffectAddAct", package.seeall)

slot0 = class("FightWorkEffectAddAct", FightEffectBase)

function slot0.onStart(slot0)
	slot0:onDone(true)
end

return slot0
