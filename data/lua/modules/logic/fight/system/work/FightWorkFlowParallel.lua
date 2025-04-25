module("modules.logic.fight.system.work.FightWorkFlowParallel", package.seeall)

slot0 = class("FightWorkFlowParallel", FightWorkFlowBase)

function slot0.onConstructor(slot0)
	slot0._workList = {}
	slot0._finishCount = 0
end

function slot0.registWork(slot0, slot1, ...)
	slot2 = slot0:newClass(slot1, ...)

	table.insert(slot0._workList, slot2)

	return slot2
end

function slot0.addWork(slot0, slot1)
	if not slot1 then
		return
	end

	table.insert(slot0._workList, slot1)
end

function slot0.listen2Work(slot0, slot1)
	return slot0:registWork(FightWorkListen2WorkDone, slot1)
end

function slot0.onStart(slot0)
	slot0:cancelFightWorkSafeTimer()

	if #slot0._workList == 0 then
		return slot0:onDone(true)
	else
		for slot4, slot5 in ipairs(slot0._workList) do
			if slot5.WORKFINISHED or slot5.IS_DISPOSED then
				slot0._finishCount = slot0._finishCount + 1
			elseif not slot5.STARTED then
				slot5:registFinishCallback(slot0.onWorkItemDone, slot0, slot5)
				slot5:start(slot0.context)
			end
		end

		if not slot0.IS_DISPOSED and slot0._finishCount == #slot0._workList then
			return slot0:onDone(true)
		end
	end
end

function slot0.onWorkItemDone(slot0, slot1)
	slot0._finishCount = slot0._finishCount + 1

	if slot0._finishCount == #slot0._workList then
		return slot0:onDone(true)
	end
end

function slot0.onDestructor(slot0)
	for slot4 = #slot0._workList, 1, -1 do
		slot0._workList[slot4]:disposeSelf()
	end
end

return slot0
