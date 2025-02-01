module("modules.logic.room.model.critter.RoomTrainSlotListModel", package.seeall)

slot0 = class("RoomTrainSlotListModel", ListScrollModel)
slot1 = 4

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
	slot0:clearData()
end

function slot0.clearData(slot0)
	uv0.super.clear(slot0)

	slot0._selectId = nil
end

function slot0.setSlotList(slot0)
	slot1 = CritterModel.instance:getCultivatingCritters()
	slot2 = {}

	for slot7 = 1, uv0 do
		slot8 = RoomTrainSlotMO.New()

		slot8:init({
			id = slot7,
			isLock = slot0:checkIsLock(slot7)
		})
		slot8:setCritterMO(slot1 and slot1[slot7])

		if not slot8:isFree() then
			slot3 = nil or slot8.id
		end

		if slot9 and slot9.id == slot0._selectCritterUid then
			slot3 = slot8.id
		end

		table.insert(slot2, slot8)
	end

	slot0._selectId = slot3 or slot0._selectId

	slot0:setList(slot2)
	slot0:_refreshSelect()
end

function slot0.updateSlotList(slot0)
	for slot5 = 1, #slot0:getList() do
		slot1[slot5].isLock = slot0:checkIsLock(slot5)
	end

	slot0:onModelUpdate()
end

function slot0.getTradeLevelCfgBySlotNum(slot0, slot1)
	if not slot0._unLockDict then
		slot0._unLockDict = {}
		slot0._maxSloNum = 0

		for slot6, slot7 in ipairs(lua_trade_level.configList) do
			slot8 = slot0._unLockDict[slot7.maxTrainSlotCount]

			if slot0._maxSloNum < slot7.maxTrainSlotCount then
				slot0._maxSloNum = slot7.maxTrainSlotCount
			end

			if not slot8 or slot7.level < slot8.level then
				slot0._unLockDict[slot7.maxTrainSlotCount] = slot7
			end
		end
	end

	return slot0._unLockDict[slot1]
end

function slot0.checkIsLock(slot0, slot1)
	if uv0 < slot1 then
		return true
	end

	if slot0:getTradeLevelCfgBySlotNum(slot1) and (ManufactureModel.instance:getTradeLevel() or 0) < slot2.level then
		return true
	end

	return false
end

function slot0.clearSelect(slot0)
	for slot4, slot5 in ipairs(slot0._scrollViews) do
		slot5:setSelect(nil)
	end

	slot0._selectId = nil
end

function slot0._refreshSelect(slot0)
	slot1 = nil

	for slot6, slot7 in ipairs(slot0:getList()) do
		if slot7.id == slot0._selectId then
			slot1 = slot7
		end
	end

	for slot6, slot7 in ipairs(slot0._scrollViews) do
		slot7:setSelect(slot1)
	end
end

function slot0.findFreeSlotMO(slot0)
	for slot5 = 1, #slot0:getList() do
		if slot1[slot5] and not slot6.isLock and not slot6.critterMO then
			return slot6
		end
	end
end

function slot0.setSelectCritterUid(slot0, slot1)
	slot0._selectCritterUid = slot1

	if slot0:getSlotMOByCritterUi(slot1) then
		slot0:setSelect(slot2.id)
	end
end

function slot0.findWaitingSlotMOByUid(slot0, slot1)
	for slot6 = 1, #slot0:getList() do
		if slot2[slot6].waitingTrainUid == slot1 then
			return slot7
		end
	end
end

function slot0.getSlotMOByCritterUi(slot0, slot1)
	for slot6 = 1, #slot0:getList() do
		if slot2[slot6].critterMO and slot7.critterMO.id == slot1 then
			return slot7
		end
	end
end

function slot0.getSlotMOByHeroId(slot0, slot1)
	for slot6 = 1, #slot0:getList() do
		if slot2[slot6].critterMO and slot7.critterMO.trainInfo and slot7.critterMO.trainInfo.heroId == slot1 then
			return slot7
		end
	end
end

function slot0._getTrainAndFreeCount(slot0)
	slot3 = 0

	for slot7 = 1, #slot0:getList() do
		if slot1[slot7] and not slot8.isLock then
			if slot8.critterMO then
				slot2 = 0 + 1
			else
				slot3 = slot3 + 1
			end
		end
	end

	return slot2, slot3
end

function slot0.getTrarinAndFreeCount(slot0)
	return slot0:_getTrainAndFreeCount()
end

function slot0.getSelectMO(slot0)
	return slot0:getById(slot0._selectId)
end

function slot0.getSelect(slot0)
	return slot0._selectId
end

function slot0.setSelect(slot0, slot1)
	slot0._selectId = slot1

	slot0:_refreshSelect()
end

slot0.instance = slot0.New()

return slot0
