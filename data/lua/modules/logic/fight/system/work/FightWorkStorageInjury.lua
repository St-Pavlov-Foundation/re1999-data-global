module("modules.logic.fight.system.work.FightWorkStorageInjury", package.seeall)

slot0 = class("FightWorkStorageInjury", FightEffectBase)

function slot0.onStart(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
