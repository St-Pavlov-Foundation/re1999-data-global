module("modules.common.model.MultiSortListScrollModel", package.seeall)

slot0 = class("MultiSortListScrollModel", ListScrollModel)

function slot0.initSort(slot0)
	slot0._addSortNum = 0
	slot0._curSortType = nil
	slot0._curSortAscending = nil
	slot0._sortFuncList = {}
	slot0._sortAscendingList = {}
	slot0._sortList = {}
	slot0._firstSort = nil
	slot0._lastSort = nil
	slot0._ipair = ipairs

	function slot0._tableSort(slot0, slot1)
		return uv0._sortFunc(slot0, slot1, uv1)
	end
end

function slot0.getSortState(slot0, slot1)
	return (slot0._curSortType == slot1 and slot0._curSortAscending or slot0._sortAscendingList[slot1]) and 1 or -1
end

function slot0.addOtherSort(slot0, slot1, slot2)
	slot0._firstSort = slot1
	slot0._lastSort = slot2
end

function slot0.addSortType(slot0, slot1, slot2, slot3)
	if slot0._sortFuncList[slot1] then
		logError("sortType already exist")

		return
	end

	if not slot2 then
		logError("sortFunc is nil")

		return
	end

	slot0._sortFuncList[slot1] = slot2
	slot0._sortAscendingList[slot1] = slot3 == true
	slot0._addSortNum = slot0._addSortNum + 1
end

function slot0.setCurSortType(slot0, slot1)
	if not slot0._sortFuncList[slot1] then
		logError("sortType is not exist")

		return
	end

	if slot0._curSortType == slot1 then
		slot0._curSortAscending = not slot0._curSortAscending
	else
		slot0._curSortAscending = slot0._sortAscendingList[slot1]
		slot0._curSortType = slot1
	end

	slot0:_doSort()
end

function slot0.getCurSortType(slot0)
	return slot0._curSortType
end

function slot0.setSortList(slot0, slot1)
	slot0._sortList = slot1

	slot0:_doSort()
end

function slot0._doSort(slot0)
	if not slot0._sortList then
		return
	end

	if slot0._curSortType then
		if slot0._addSortNum ~= #slot0._sortFuncList then
			logError("sortFuncList is not complete")

			return
		end

		table.sort(slot0._sortList, slot0._tableSort)
	end

	slot0:setList(slot0._sortList)
end

function slot0._sortFunc(slot0, slot1, slot2)
	slot3 = nil

	if slot2._firstSort then
		slot3 = slot2._firstSort(slot0, slot1, slot2)
	end

	if slot3 ~= nil then
		return slot3
	end

	if slot2._sortFuncList[slot2._curSortType](slot0, slot1, slot2._curSortAscending, slot2) ~= nil then
		return slot3
	end

	for slot8, slot9 in slot2._ipair(slot2._sortFuncList) do
		if slot8 ~= slot2._curSortType and slot9(slot0, slot1, slot2._sortAscendingList[slot8], slot2) ~= nil then
			return slot3
		end
	end

	if (slot2._lastSort and slot2._lastSort(slot0, slot1, slot2) or nil) ~= nil then
		return slot3
	end

	return false
end

return slot0
