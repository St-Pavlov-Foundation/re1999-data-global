module("modules.logic.fight.system.work.FightWorkListen2WorkDone", package.seeall)

slot0 = class("FightWorkListen2WorkDone", FightWorkItem)

function slot0.onConstructor(slot0, slot1)
	slot0._work = slot1
end

function slot0.onStart(slot0)
	if slot0._work.IS_DISPOSED then
		slot0:onDone(true)

		return
	end

	if slot0._work.WORKFINISHED then
		slot0:onDone(true)

		return
	end

	slot0:cancelFightWorkSafeTimer()

	if slot0._work.STARTED then
		slot0._work:registFinishCallback(slot0.onWorkItemDone, slot0)

		return
	end

	slot0._work:registFinishCallback(slot0.onWorkItemDone, slot0)

	return slot0._work:start(slot0.context)
end

function slot0.onWorkItemDone(slot0)
	return slot0:onDone(true)
end

function slot0.clearWork(slot0)
	slot0._work:disposeSelf()
end

return slot0
