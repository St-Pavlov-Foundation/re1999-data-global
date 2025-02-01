module("framework.core.datastruct.PriorityQueue", package.seeall)

slot0 = class("PriorityQueue")

function slot0.ctor(slot0, slot1)
	slot0._compareFunc = slot1
	slot0._dataList = {}
	slot0._markRemoveDict = {}
	slot0._removeCount = 0
end

function slot0.getFirst(slot0)
	slot0:_disposeMarkRemove()

	return slot0._dataList[1]
end

function slot0.getFirstAndRemove(slot0)
	slot0:_disposeMarkRemove()

	slot2 = #slot0._dataList
	slot0._dataList[1] = slot0._dataList[slot2]
	slot0._dataList[slot2] = nil

	slot0:_sink(1)

	return slot0._dataList[1]
end

function slot0.add(slot0, slot1)
	slot2 = #slot0._dataList + 1
	slot0._dataList[slot2] = slot1

	slot0:_float(slot2)
end

function slot0.getSize(slot0)
	return #slot0._dataList - slot0._removeCount
end

function slot0.markRemove(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._dataList) do
		if not slot0._markRemoveDict[slot6] and slot1(slot6) then
			if not (type(slot6) == "table" or slot8 == "userdata" or slot8 == "function") then
				logWarn("PriorityQueue mark remove warnning, type = " .. slot8 .. ", value = " .. tostring(slot6))
			end

			slot10 = slot9 and slot6 or {
				slot6
			}
			slot0._dataList[slot5] = slot10
			slot0._markRemoveDict[slot10] = true
			slot0._removeCount = slot0._removeCount + 1
		end
	end
end

function slot0._sink(slot0, slot1)
	slot2 = #slot0._dataList

	while slot2 >= 2 * slot1 do
		if slot2 >= 2 * slot1 + 1 and not slot0._compareFunc(slot0._dataList[slot3], slot0._dataList[slot3 + 1]) then
			slot3 = slot3 + 1
		end

		if slot0._compareFunc(slot0._dataList[slot1], slot0._dataList[slot3]) then
			break
		end

		slot0:_swap(slot1, slot3)

		slot1 = slot3
	end
end

function slot0._float(slot0, slot1)
	while slot1 > 1 do
		if not slot0._compareFunc(slot0._dataList[slot1], slot0._dataList[bit.rshift(slot1, 1)]) then
			break
		end

		slot0:_swap(slot1, slot2)

		slot1 = slot2
	end
end

function slot0._swap(slot0, slot1, slot2)
	slot0._dataList[slot1] = slot0._dataList[slot2]
	slot0._dataList[slot2] = slot0._dataList[slot1]
end

function slot0._disposeMarkRemove(slot0)
	while #slot0._dataList > 0 and slot0._markRemoveDict[slot0._dataList[1]] do
		slot0._markRemoveDict[slot0._dataList[1]] = nil
		slot0._removeCount = slot0._removeCount - 1
		slot1 = #slot0._dataList
		slot0._dataList[1] = slot0._dataList[slot1]
		slot0._dataList[slot1] = nil

		slot0:_sink(1)
	end
end

return slot0
