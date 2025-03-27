module("modules.logic.fight.system.work.FightWorkDelayTimer", package.seeall)

slot0 = class("FightWorkDelayTimer", FightWorkItem)

function slot0.onAwake(slot0, slot1)
	slot0._waitSeconds = slot1 or 0.01
end

function slot0.onStart(slot0)
	if slot0._waitSeconds == 0 then
		slot0:onDone(true)

		return
	end

	slot0:cancelFightWorkSafeTimer()
	slot0:com_registTimer(slot0._onTimeEnd, slot0._waitSeconds)
end

function slot0.clearWork(slot0)
end

function slot0._onTimeEnd(slot0)
	slot0:onDone(true)
end

return slot0
