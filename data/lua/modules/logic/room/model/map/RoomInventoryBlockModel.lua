module("modules.logic.room.model.map.RoomInventoryBlockModel", package.seeall)

slot0 = class("RoomInventoryBlockModel", BaseModel)

function slot0.onInit(slot0)
	slot0._selectPackageIds = {}

	slot0:_clearData()
end

function slot0.reInit(slot0)
	slot0._selectPackageIds = {}
	slot0._unUseBlockList = {}

	slot0:_clearData()
end

function slot0.clear(slot0)
	uv0.super.clear(slot0)
	slot0:_clearData()
end

function slot0._clearData(slot0)
	if slot0._blockPackageModel then
		for slot5, slot6 in ipairs(slot0._blockPackageModel:getList()) do
			slot6:clear()
		end

		slot0._blockPackageModel:clear()
	end

	slot0._blockPackageModel = BaseModel.New()
	slot0._unUseBlockList = slot0._unUseBlockList or {}
end

function slot0.initInventory(slot0, slot1, slot2, slot3, slot4)
	slot0:_clearData()
	tabletool.addValues({}, slot1)

	slot2 = slot2 or {}
	slot6 = slot0:_getSpercialMaps(slot4)

	for slot10 = 1, #slot5 do
		if not slot6[slot5[slot10]] then
			slot6[slot11] = {}
		end
	end

	for slot10, slot11 in pairs(slot6) do
		slot12 = RoomBlockPackageMO.New()

		slot12:init({
			id = slot10
		}, slot11)
		slot0._blockPackageModel:addAtLast(slot12)
	end

	slot0:addBlockPackageList(slot2)

	slot3 = slot3 or {}

	for slot10 = 1, #slot3 do
		slot0:placeBlock(slot3[slot10].blockId)
	end

	if not slot0:getCurPackageMO() and slot0._blockPackageModel:getCount() > 0 then
		slot7 = slot0:_findHasUnUsePackageMO() or slot0._blockPackageModel:getByIndex(1)

		slot0:setSelectBlockPackageIds({
			slot7.id
		})
		RoomHelper.hideBlockPackageReddot(slot7.id)
	end
end

function slot0.addSpecialBlockIds(slot0, slot1)
	for slot6, slot7 in pairs(slot0:_getSpercialMaps(slot1)) do
		if slot0._blockPackageModel:getById(slot6) then
			slot8:addBlockIdList(slot7)
		else
			slot8 = RoomBlockPackageMO.New()

			slot8:init({
				id = slot6
			}, slot7)
			slot0._blockPackageModel:addAtLast(slot8)
		end
	end
end

function slot0._getSpercialMaps(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(slot1 or {}) do
		if RoomConfig.instance:getBlock(slot8) then
			if not slot2[slot9.packageId] then
				slot2[slot9.packageId] = {}
			end

			table.insert(slot10, slot8)
		end
	end

	return slot2
end

function slot0._findHasUnUsePackageMO(slot0)
	for slot5 = 1, #slot0._blockPackageModel:getList() do
		if slot1[slot5]:getUnUseCount() > 0 then
			return slot1[slot5]
		end
	end
end

function slot0.addBlockPackageList(slot0, slot1)
	if not slot1 then
		return
	end

	for slot5 = 1, #slot1 do
		if not slot0._blockPackageModel:getById(slot1[slot5].blockPackageId) then
			slot8 = RoomBlockPackageMO.New()

			slot8:init({
				id = slot7
			})
			slot0._blockPackageModel:addAtLast(slot8)
		end

		slot8:reset()
		slot8:useBlockIds(slot6.useBlockIds)
	end
end

function slot0.setSelectBlockPackageIds(slot0, slot1)
	slot0._selectPackageIds = {}

	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0._selectPackageIds, slot6)
	end
end

function slot0.isSelectBlockPackageById(slot0, slot1)
	return tabletool.indexOf(slot0._selectPackageIds, slot1) and true or false
end

function slot0.rotateFirst(slot0, slot1)
	if slot0:getSelectInventoryBlockMO() then
		slot2.rotate = slot1
	end
end

function slot0.placeBlock(slot0, slot1)
	if slot0._selectInventoryBlockId == slot1 then
		slot0._selectInventoryBlockId = nil
	end

	if RoomConfig.instance:getBlock(slot1) then
		if slot0._blockPackageModel:getById(slot2.packageId) then
			slot3:useBlockId(slot1)
		end

		tabletool.removeValue(slot0._unUseBlockList, slot1)
	else
		logError(string.format("地块配置中找不到地块. can not find blockCfg for BlockConfig : [blockId:%s]", slot1 or "nil"))
	end
end

function slot0.blackBlocksByIds(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0:blackBlockById(slot6)
	end
end

function slot0.blackBlockById(slot0, slot1)
	if RoomConfig.instance:getBlock(slot1) then
		if slot0._blockPackageModel:getById(slot2.packageId) then
			slot3:unUseBlockId(slot1)
			table.insert(slot0._unUseBlockList, slot1)
		else
			logError("还没获得对应的资源包：" .. slot2.packageId)
		end
	end
end

function slot0.findFristUnUseBlockMO(slot0, slot1, slot2)
	if not slot0._blockPackageModel:getById(slot1) then
		return nil
	end

	for slot8, slot9 in ipairs(slot0._unUseBlockList or {}) do
		if slot3:getUnUseBlockMOById(slot9) and slot10:getMainRes() == slot2 then
			return slot10
		end
	end

	return slot3:getUnUseBlockMOByResId(slot2)
end

function slot0.getCurPackageMO(slot0)
	slot1 = nil
	slot2 = slot0._blockPackageModel:getList()

	for slot6, slot7 in ipairs(slot0._selectPackageIds) do
		if slot0._blockPackageModel:getById(slot7) and slot8:getUnUseCount() > 0 then
			return slot8
		elseif slot1 == nil then
			slot1 = slot8
		end
	end

	return slot1
end

function slot0.getPackageMOById(slot0, slot1)
	return slot0._blockPackageModel:getById(slot1)
end

function slot0.openSelectOp(slot0)
	return true
end

function slot0.setSelectInventoryBlockId(slot0, slot1)
	slot0._selectInventoryBlockId = slot1
end

function slot0.getSelectInventoryBlockId(slot0)
	return slot0._selectInventoryBlockId
end

function slot0.setSelectResId(slot0, slot1)
	slot0._selectResId = slot1
end

function slot0.getSelectResId(slot0)
	return slot0._selectResId
end

function slot0.getSelectInventoryBlockMO(slot0)
	return slot0:getInventoryBlockMOById(slot0._selectInventoryBlockId)
end

function slot0.getInventoryBlockCount(slot0)
	return 0
end

function slot0.getInventoryBlockMOById(slot0, slot1)
	slot3 = nil

	for slot7, slot8 in ipairs(slot0._blockPackageModel:getList()) do
		if slot8:getBlockMOById(slot1) then
			return slot3
		end
	end

	return nil
end

function slot0.getInventoryBlockPackageMOList(slot0)
	return slot0._blockPackageModel:getList()
end

function slot0.isMaxNum(slot0)
	slot1 = RoomMapBlockModel.instance

	return slot1:getMaxBlockCount() <= slot1:getConfirmBlockCount()
end

function slot0.getBlockSortIndex(slot0, slot1, slot2)
	slot3 = #slot0._unUseBlockList + 1

	if tabletool.indexOf(slot0._unUseBlockList, slot2) then
		return slot3 - slot4
	end

	return slot3
end

slot0.instance = slot0.New()

return slot0
