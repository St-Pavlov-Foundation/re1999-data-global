module("modules.logic.fight.system.work.FightWorkFlowSequence", package.seeall)

slot0 = class("FightWorkFlowSequence", FightWorkFlowBase)

function slot0.onConstructor(slot0)
	slot0._workList = {}
	slot0._curIndex = 0
	slot0._startIndex = 0
	slot0._playStartCount = 0
end

function slot0.registWork(slot0, slot1, ...)
	return slot0:registWorkAtIndex(#slot0._workList + 1, slot1, ...)
end

function slot0.registWorkAtIndex(slot0, slot1, slot2, ...)
	slot3 = slot0:newClass(slot2, ...)

	table.insert(slot0._workList, slot1, slot3)

	return slot3
end

function slot0.addWork(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:addWorkAtIndex(#slot0._workList + 1, slot1)
end

function slot0.addWorkAtIndex(slot0, slot1, slot2)
	if not slot2 then
		return
	end

	table.insert(slot0._workList, slot1, slot2)
end

function slot0.listen2Work(slot0, slot1)
	slot0:listen2WorkAtIndex(#slot0._workList + 1, slot1)
end

function slot0.listen2WorkAtIndex(slot0, slot1, slot2)
	slot0:registWorkAtIndex(slot1, FightWorkListen2WorkDone, slot2)
end

function slot0.onStart(slot0)
	slot0:cancelFightWorkSafeTimer()

	return slot0:_playNext()
end

function slot0._playNext(slot0)
	slot0._curIndex = slot0._curIndex + 1

	if slot0._workList[slot0._curIndex] then
		if slot1.WORKFINISHED or slot1.IS_DISPOSED then
			return slot0:_playNext()
		elseif not slot1.STARTED then
			slot0._playStartCount = slot0._playStartCount + 1

			if slot0._playStartCount == 1 then
				slot0._startIndex = slot0._curIndex

				while slot0._playStartCount ~= 0 do
					slot2 = slot0._workList[slot0._startIndex]

					slot2:registFinishCallback(slot0.onWorkItemDone, slot0, slot2)
					xpcall(slot2.start, __G__TRACKBACK__, slot2, slot0.context)

					slot0._playStartCount = slot0._playStartCount - 1
					slot0._startIndex = slot0._startIndex + 1
				end

				if slot0._curIndex > #slot0._workList then
					return slot0:onDone(true)
				end
			elseif slot0._playStartCount < 1 then
				return slot0:onDone(true)
			end
		end
	elseif slot0._playStartCount == 0 then
		return slot0:onDone(true)
	end
end

function slot0.onWorkItemDone(slot0, slot1)
	if slot1 == slot0._workList[slot0._curIndex] then
		return slot0:_playNext()
	end
end

function slot0.onDestructor(slot0)
	for slot4 = #slot0._workList, 1, -1 do
		slot0._workList[slot4]:disposeSelf()
	end
end

function slot0.registWorkAtNext(slot0, slot1, ...)
	return slot0:registWorkAtIndex(slot0._curIndex + 1, slot1, ...)
end

function slot0.addWorkAtNext(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:addWorkAtIndex(slot0._curIndex + 1, slot1)
end

function slot0.listen2WorkAtNext(slot0, slot1)
	slot0:listen2WorkAtIndex(slot0._curIndex + 1, slot1)
end

return slot0
