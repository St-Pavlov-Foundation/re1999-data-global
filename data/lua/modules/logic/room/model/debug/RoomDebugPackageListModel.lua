module("modules.logic.room.model.debug.RoomDebugPackageListModel", package.seeall)

slot0 = class("RoomDebugPackageListModel", ListScrollModel)

function slot0.onInit(slot0)
	slot0:_clearData()
end

function slot0.reInit(slot0)
	slot0:_clearData()
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)
	slot0:_clearData()
end

function slot0._clearData(slot0)
	slot0._selectBlockId = nil
	slot0._filterPackageId = 0
	slot0._filterMainRes = nil
end

function slot0.setDebugPackageList(slot0)
	slot1 = {}

	if RoomDebugController.instance:getTempPackageConfig() then
		for slot6, slot7 in ipairs(slot2) do
			for slot11, slot12 in ipairs(slot7.infos) do
				if slot0._filterPackageId > 0 and slot0:isFilterPackageId(slot12.packageId) and slot0:isFilterMainRes(slot12.mainRes) then
					slot13 = RoomDebugPackageMO.New()

					slot13:init({
						id = slot12.blockId,
						packageId = slot12.packageId,
						packageOrder = slot12.packageOrder,
						defineId = slot12.defineId,
						mainRes = slot12.mainRes
					})
					table.insert(slot1, slot13)
				end
			end
		end
	end

	table.sort(slot1, slot0._sortFunction)
	slot0:setList(slot1)
	slot0:_refreshSelect()
end

function slot0.getCountByMainRes(slot0, slot1)
	slot2 = 0

	if RoomDebugController.instance:getTempPackageConfig() then
		for slot7, slot8 in ipairs(slot3) do
			for slot12, slot13 in ipairs(slot8.infos) do
				if slot0._filterPackageId > 0 and slot0:isFilterPackageId(slot13.packageId) and (slot1 == slot13.mainRes or (not slot1 or slot1 < 0) and (not slot13.mainRes or slot13.mainRes < 0)) then
					slot2 = slot2 + 1
				end
			end
		end
	end

	return slot2
end

function slot0._sortFunction(slot0, slot1)
	if slot0.packageOrder ~= slot1.packageOrder then
		return slot0.packageOrder < slot1.packageOrder
	end

	return slot0.id < slot1.id
end

function slot0.setFilterPackageId(slot0, slot1)
	slot0._filterPackageId = slot1
end

function slot0.isFilterPackageId(slot0, slot1)
	return slot0._filterPackageId == slot1
end

function slot0.getFilterPackageId(slot0)
	return slot0._filterPackageId
end

function slot0.setFilterMainRes(slot0, slot1)
	slot0._filterMainRes = slot1
end

function slot0.isFilterMainRes(slot0, slot1)
	return slot0._filterMainRes == slot1 or not slot0._filterMainRes and (not slot1 or slot1 == -1)
end

function slot0.getFilterMainRes(slot0)
	return slot0._filterMainRes
end

function slot0.clearSelect(slot0)
	for slot4, slot5 in ipairs(slot0._scrollViews) do
		slot5:setSelect(nil)
	end

	slot0._selectBlockId = nil
end

function slot0._refreshSelect(slot0)
	slot1 = nil

	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7.id == slot0._selectBlockId then
			slot1 = slot7
		end
	end

	for slot6, slot7 in ipairs(slot0._scrollViews) do
		slot7:setSelect(slot1)
	end
end

function slot0.setSelect(slot0, slot1)
	slot0._selectBlockId = slot1

	slot0:_refreshSelect()
end

function slot0.getSelect(slot0)
	return slot0._selectBlockId
end

function slot0.initDebugPackage(slot0)
	slot0:setDebugPackageList()
end

slot0.instance = slot0.New()

return slot0
