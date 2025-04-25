module("modules.logic.fight.system.work.FightWorkDoneFlowParallel", package.seeall)

slot0 = class("FightWorkDoneFlowParallel", FightWorkFlowParallel)

function slot0.start(slot0, slot1)
	if slot0.PARENT_ROOT_CLASS and slot0.PARENT_ROOT_CLASS.PARENT_ROOT_CLASS and slot2.cancelFightWorkSafeTimer then
		slot2:cancelFightWorkSafeTimer()
	end

	return uv0.super.start(slot0, slot1)
end

return slot0
