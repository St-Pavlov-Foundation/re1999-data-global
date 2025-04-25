module("modules.logic.fight.fightcomponent.FightWorkQueueComponent", package.seeall)

slot0 = class("FightWorkQueueComponent", FightBaseClass)

function slot0.onConstructor(slot0)
	slot0.workQueue = {}
end

function slot0.addWork(slot0, slot1, slot2)
	table.insert(slot0.workQueue, {
		work = slot1,
		context = slot2
	})

	if #slot0.workQueue == 1 then
		slot1:registFinishCallback(slot0._onQueueWorkFinish, slot0)

		return slot1:start(slot2)
	end
end

function slot0.registWork(slot0, slot1, ...)
	slot2 = slot0:newClass(slot1, ...)

	slot0:addWork(slot2)

	return slot2
end

function slot0.registWorkWithContext(slot0, slot1, slot2, ...)
	slot3 = slot0:newClass(slot1, ...)

	slot0:addWork(slot3, slot2)

	return slot3
end

function slot0._onQueueWorkFinish(slot0)
	if slot0.workQueue then
		table.remove(slot1, 1)

		if slot1[1] then
			return slot2.work:start(slot2.context)
		end
	end
end

function slot0.onDestructor(slot0)
	for slot4 = #slot0.workQueue, 1, -1 do
		slot0.workQueue[slot4]:disposeSelf()
	end
end

return slot0
