module("modules.logic.fight.system.work.FightWorkDoneFlowParallel", package.seeall)

slot0 = class("FightWorkDoneFlowParallel", FightWorkFlowParallel)

function slot0.start(slot0, slot1)
	if slot0.PARENTROOTCLASS and slot0.PARENTROOTCLASS.PARENTROOTCLASS and slot2.cancelFightWorkSafeTimer then
		slot2:cancelFightWorkSafeTimer()
	end

	return uv0.super.start(slot0, slot1)
end

return slot0
