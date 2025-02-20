module("modules.logic.fight.system.work.FightWorkHeroUpgrade", package.seeall)

slot0 = class("FightWorkHeroUpgrade", FightEffectBase)

function slot0.onStart(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
