module("modules.logic.fight.system.work.Work2FightWork", package.seeall)

slot0 = class("Work2FightWork", FightWorkItem)

function slot0.onAwake(slot0, slot1, ...)
	slot0._class = slot1
	slot0._param = {
		...
	}
	slot0._paramCount = select("#", ...)
end

function slot0.onStart(slot0)
	slot0:cancelFightWorkSafeTimer()

	slot0._work = slot0._class.New(unpack(slot0._param, 1, slot0._paramCount))

	slot0._work:registerDoneListener(slot0.onWorkItemDone, slot0)

	return slot0._work:onStartInternal(slot0.context)
end

function slot0.onWorkItemDone(slot0)
	return slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._work then
		slot0._work:unregisterDoneListener(slot0.onWorkItemDone, slot0)
		slot0._work:onDestroy()

		slot0._work = nil
	end
end

return slot0
