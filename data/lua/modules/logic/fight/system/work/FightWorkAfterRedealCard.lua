module("modules.logic.fight.system.work.FightWorkAfterRedealCard", package.seeall)

slot0 = class("FightWorkAfterRedealCard", FightEffectBase)

function slot0.onStart(slot0)
	slot0:onDone(true)
end

return slot0
