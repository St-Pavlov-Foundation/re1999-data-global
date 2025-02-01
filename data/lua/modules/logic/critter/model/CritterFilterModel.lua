module("modules.logic.critter.model.CritterFilterModel", package.seeall)

slot0 = class("CritterFilterModel")

function slot0.generateFilterMO(slot0, slot1)
	slot0.filterMODict = slot0.filterMODict or {}
	slot2 = CritterFilterMO.New()

	slot2:init(slot1)

	slot0.filterMODict[slot1] = slot2

	return slot2
end

function slot0.getFilterMO(slot0, slot1, slot2)
	if not (slot0.filterMODict and slot0.filterMODict[slot1]) and slot1 and slot2 then
		slot3 = slot0:generateFilterMO(slot1)
	end

	return slot3
end

function slot0.clear(slot0, slot1)
	if slot0.filterMODict then
		slot0.filterMODict[slot1] = nil
	end
end

function slot0.reset(slot0, slot1)
	if slot0.filterMODict and slot0.filterMODict[slot1] then
		slot2:init(slot1)
	end
end

function slot0.applyMO(slot0, slot1)
	if not slot0.filterMODict[slot1.viewName] then
		slot0.filterMODict[slot2] = slot1

		CritterController.instance:dispatchEvent(CritterEvent.CritterChangeFilterType, slot2)

		return
	end

	if not slot0:isSameFilterDict(slot3:getFilterCategoryDict(), slot1:getFilterCategoryDict()) then
		slot3:updateMo(slot1)
		CritterController.instance:dispatchEvent(CritterEvent.CritterChangeFilterType, slot2)
	end
end

function slot0.isSameFilterDict(slot0, slot1, slot2)
	if type(slot1) ~= type(slot2) then
		return false
	end

	if slot3 ~= "table" then
		return slot1 == slot2
	end

	for slot8, slot9 in pairs(slot1) do
		if slot2[slot8] == nil or not slot0:isSameFilterDict(slot9, slot10) then
			return false
		end
	end

	for slot8, slot9 in pairs(slot2) do
		if slot1[slot8] == nil or not slot0:isSameFilterDict(slot10, slot9) then
			return false
		end
	end

	return true
end

slot0.instance = slot0.New()

return slot0
