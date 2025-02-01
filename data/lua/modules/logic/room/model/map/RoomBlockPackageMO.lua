module("modules.logic.room.model.map.RoomBlockPackageMO", package.seeall)

slot0 = pureTable("RoomBlockPackageMO")

function slot0.init(slot0, slot1, slot2)
	slot0.id = slot1.id
	slot0._blockModel = slot0:_clearOrCreateModel(slot0._blockModel)
	slot0._useBlockModel = slot0:_clearOrCreateModel(slot0._useBlockModel)
	slot0._unUseBlockModel = slot0:_clearOrCreateModel(slot0._unUseBlockModel)
	slot0._useCount = 0
	slot4 = {}
	slot0._resIdDic = {}
	slot0._resIdList = {}

	for slot8, slot9 in ipairs(RoomConfig.instance:getBlockListByPackageId(slot0.id) or {}) do
		if slot9.ownType ~= RoomBlockEnum.OwnType.Special or tabletool.indexOf(slot2 or {}, slot9.blockId) then
			table.insert(slot4, slot0:_createBlockMOByCfg(slot9))
		end

		if not slot0._resIdDic[slot9.mainRes] then
			slot0._resIdDic[slot9.mainRes] = true

			table.insert(slot0._resIdList, slot9.mainRes)
		end
	end

	slot0._blockModel:setList(slot4)
	slot0._unUseBlockModel:setList(slot4)

	if #slot0._resIdList > 1 then
		table.sort(slot0._resIdList, function (slot0, slot1)
			if slot0 ~= slot1 then
				return slot0 < slot1
			end
		end)
	end
end

function slot0._clearModel(slot0, slot1)
	if slot1 then
		slot1:clear()
	end
end

function slot0._clearOrCreateModel(slot0, slot1)
	if slot1 then
		slot1:clear()
	else
		slot1 = BaseModel.New()
	end

	return slot1
end

function slot0._sumCount(slot0, slot1)
	return slot1:getCount()
end

function slot0._sumCountByResId(slot0, slot1, slot2)
	for slot8, slot9 in ipairs(slot1:getList()) do
		if slot9:getMainRes() == slot2 then
			slot4 = 0 + 1
		end
	end

	return slot4
end

function slot0._getBlockMOByResId(slot0, slot1, slot2)
	for slot7 = 1, #slot1:getList() do
		if slot3[slot7]:getMainRes() == slot2 then
			return slot8
		end
	end
end

function slot0._createBlockMOByCfg(slot0, slot1)
	slot2 = RoomBlockMO.New()
	slot2.blockState = RoomBlockEnum.BlockState.Inventory

	slot2:init(slot1)

	if slot2.defineId == RoomBlockEnum.EmptyDefineId then
		slot2.rotate = math.random(0, 6)
	end

	return slot2
end

function slot0.getUnUseBlockMOByResId(slot0, slot1)
	return slot0:_getBlockMOByResId(slot0._unUseBlockModel, slot1)
end

function slot0.getResIdList(slot0)
	return slot0._resIdList
end

function slot0.getBlockMOById(slot0, slot1)
	return slot0._blockModel:getById(slot1)
end

function slot0.getUnUseBlockMOById(slot0, slot1)
	return slot0._unUseBlockModel:getById(slot1)
end

function slot0.getCount(slot0)
	return slot0:_sumCount(slot0._blockModel)
end

function slot0.getUseCount(slot0)
	return slot0:_sumCount(slot0._uselockModel)
end

function slot0.getUnUseCount(slot0)
	return slot0:_sumCount(slot0._unUseBlockModel)
end

function slot0.getCountByResId(slot0, slot1)
	return slot0:_sumCountByResId(slot0._blockModel, slot1)
end

function slot0.getUseCountByResId(slot0, slot1)
	return slot0:_sumCountByResId(slot0._uselockModel, slot1)
end

function slot0.getUnUseCountByResId(slot0, slot1)
	return slot0:_sumCountByResId(slot0._unUseBlockModel, slot1)
end

function slot0.getUseBlockMOById(slot0, slot1)
	return slot0._useBlockModel:getById(slot1)
end

function slot0.getBlockMOList(slot0)
	return slot0._blockModel:getList()
end

function slot0.getUseBlockMOList(slot0)
	return slot0._useBlockModel:getList()
end

function slot0.getUnUseBlockMOList(slot0)
	return slot0._unUseBlockModel:getList()
end

function slot0.addBlockIdList(slot0, slot1)
	for slot5 = 1, #slot1 do
		slot0:addBlockById(slot1[slot5])
	end
end

function slot0.addBlockById(slot0, slot1)
	if slot0._blockModel:getById(slot1) then
		return
	end

	if RoomConfig.instance:getBlock(slot1) and slot2.packageId == slot0.id then
		slot3 = slot0:_createBlockMOByCfg(slot2)

		slot0._blockModel:addAtLast(slot3)
		slot0._unUseBlockModel:addAtLast(slot3)
	end
end

function slot0.useBlockId(slot0, slot1)
	if slot0._unUseBlockModel:getById(slot1) then
		slot2.blockState = RoomBlockEnum.BlockState.Map

		slot0._unUseBlockModel:remove(slot2)
		slot0._useBlockModel:addAtLast(slot2)
	end
end

function slot0.useBlockIds(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0:useBlockId(slot6)
	end
end

function slot0.unUseBlockId(slot0, slot1)
	if slot0._useBlockModel:getById(slot1) then
		slot2.blockState = RoomBlockEnum.BlockState.Inventory

		slot0._useBlockModel:remove(slot2)
		slot0._unUseBlockModel:addAtLast(slot2)
	end
end

function slot0.unUseBlockIds(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		slot0:unUseBlockId(slot6)
	end
end

function slot0.reset(slot0)
	for slot5, slot6 in ipairs(slot0._useBlockModel:getList()) do
		slot6.blockState = RoomBlockEnum.BlockState.Inventory
	end

	slot0:_clearModel(slot0._useBlockModel)
	slot0:_clearModel(slot0._unUseBlockModel)
	slot0._unUseBlockModel:setList(slot0._blockModel:getList())
end

function slot0.clear(slot0)
	slot0:_clearModel(slot0._blockModel)
	slot0:_clearModel(slot0._useBlockModel)
	slot0:_clearModel(slot0._unUseBlockModel)
end

function slot0.sortBlock(slot0, slot1)
	if slot0.packageOrder ~= slot1.packageOrder then
		return slot1.packageOrder < slot0.packageOrder
	end
end

return slot0
