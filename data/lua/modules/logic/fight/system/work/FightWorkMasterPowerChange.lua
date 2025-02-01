module("modules.logic.fight.system.work.FightWorkMasterPowerChange", package.seeall)

slot0 = class("FightWorkMasterPowerChange", FightEffectBase)

function slot0.onStart(slot0)
	slot0:_delayDone()
end

function slot0._delayDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
end

return slot0
