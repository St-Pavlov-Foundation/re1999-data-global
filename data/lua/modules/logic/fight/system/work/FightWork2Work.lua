module("modules.logic.fight.system.work.FightWork2Work", package.seeall)

slot0 = class("FightWork2Work", BaseWork)

function slot0.ctor(slot0, slot1, ...)
	slot0._param = {
		...
	}
	slot0._paramCount = select("#", ...)
	slot0._class = slot1
end

function slot0.onStart(slot0)
	slot0._work = slot0._class.New(unpack(slot0._param, 1, slot0._paramCount))

	slot0._work:registFinishCallback(slot0.onWorkItemDone, slot0)

	return slot0._work:start()
end

function slot0.onWorkItemDone(slot0)
	return slot0:onDone(true)
end

function slot0.clearWork(slot0)
	if slot0._work then
		slot0._work:disposeSelf()

		slot0._work = nil
	end
end

return slot0
