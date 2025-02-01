module("modules.logic.room.model.map.RoomWaterReformModel", package.seeall)

slot0 = class("RoomWaterReformModel", BaseModel)

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
	slot0._waterAreaMo = nil
	slot0._isWaterReform = false

	slot0:setSelectWaterArea()
	slot0:clearChangeWaterTypeDict()
end

function slot0.clearChangeWaterTypeDict(slot0)
	slot0._changeWaterTypeDict = {}
end

function slot0.initWaterArea(slot0)
	slot0:setSelectWaterArea()

	slot1 = RoomResourceEnum.ResourceId.River
	slot0._waterAreaMo = RoomResourceHelper.getResourcePointAreaMODict(nil, {
		slot1
	}, true)[slot1]
end

function slot0.recordChangeWaterType(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return
	end

	if not slot0._changeWaterTypeDict then
		slot0:clearChangeWaterTypeDict()
	end

	slot0._changeWaterTypeDict[slot1] = slot2
end

function slot0.clearChangeWaterRecord(slot0, slot1)
	if not slot1 or not slot0._changeWaterTypeDict then
		return
	end

	slot0._changeWaterTypeDict[slot1] = nil
end

function slot0.hasChangedWaterType(slot0)
	return slot0:getRecordChangeWaterType() and next(slot1)
end

function slot0.resetChangeWaterType(slot0)
	if not slot0._changeWaterTypeDict then
		return
	end

	for slot4, slot5 in pairs(slot0._changeWaterTypeDict) do
		if RoomMapBlockModel.instance:getFullBlockMOById(slot4) then
			slot6:setTempWaterType()
		end
	end

	slot0:clearChangeWaterTypeDict()
end

function slot0.isWaterReform(slot0)
	return slot0._isWaterReform
end

function slot0.hasSelectWaterArea(slot0)
	return slot0._selectAreaId and true or false
end

function slot0.getSelectWaterBlockMoList(slot0)
	if not slot0:hasSelectWaterArea() then
		return {}
	end

	slot3 = {}
	slot4 = slot0._waterAreaMo and slot0._waterAreaMo:findeArea()

	if slot4 and slot4[slot0._selectAreaId] then
		for slot9, slot10 in ipairs(slot5) do
			slot12 = slot10.y

			if not slot3[slot10.x] or not slot3[slot11][slot12] then
				slot1[#slot1 + 1] = RoomMapBlockModel.instance:getBlockMO(slot11, slot12)
				slot3[slot11] = slot3[slot11] or {}
				slot3[slot11][slot12] = true
			end
		end
	end

	return slot1
end

function slot0.getWaterAreaId(slot0, slot1, slot2, slot3)
	return slot0._waterAreaMo:getAreaIdByXYD(slot1, slot2, slot3)
end

function slot0.getWaterAreaList(slot0)
	return slot0._waterAreaMo and slot0._waterAreaMo:findeArea() or {}
end

function slot0.getSelectWaterResourcePointList(slot0)
	return slot0:getWaterAreaList()[slot0._selectAreaId]
end

function slot0.isBlockInSelect(slot0, slot1)
	if not slot1 or not slot1:hasRiver() or not slot0:hasSelectWaterArea() or not slot0:isWaterReform() then
		return false
	end

	for slot10, slot11 in ipairs(slot0:getSelectWaterBlockMoList()) do
		if slot11.id == slot1.id then
			break
		end
	end

	return slot2
end

function slot0.getSelectAreaId(slot0)
	return slot0._selectAreaId
end

function slot0.getRecordChangeWaterType(slot0)
	return slot0._changeWaterTypeDict
end

function slot0.isUnlockWaterReform(slot0, slot1)
	slot2 = true

	if RoomConfig.instance:getWaterReformItemId(slot1) and slot3 ~= 0 then
		slot2 = ItemModel.instance:getItemCount(slot3) > 0
	end

	return slot2
end

function slot0.setWaterReform(slot0, slot1)
	slot0._isWaterReform = slot1 == true
end

function slot0.setSelectWaterArea(slot0, slot1)
	slot0._selectAreaId = slot1
end

slot0.instance = slot0.New()

return slot0
