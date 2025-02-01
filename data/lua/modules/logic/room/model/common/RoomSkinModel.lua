module("modules.logic.room.model.common.RoomSkinModel", package.seeall)

slot0 = class("RoomSkinModel", BaseModel)

function slot0.onInit(slot0)
	slot0:clear()
end

function slot0.reInit(slot0)
end

function slot0.clear(slot0)
	slot0:_clearData()
	uv0.super.clear(slot0)
end

function slot0._clearData(slot0)
	slot0._isInitSkinMoList = false
	slot0._otherPlayerRoomSkinDict = nil

	slot0:setIsShowRoomSkinList(false)
end

function slot0.initSkinMoList(slot0)
	for slot5, slot6 in ipairs(RoomConfig.instance:getAllSkinIdList()) do
		if not slot0:getById(slot6) then
			slot7 = RoomSkinMO.New()

			slot7:init(slot6)
			slot0:addAtLast(slot7)
		end
	end

	slot0._isInitSkinMoList = true
end

function slot0.updateRoomSkinInfo(slot0, slot1, slot2)
	slot3 = {}

	if slot1 then
		for slot7, slot8 in ipairs(slot1) do
			slot0:setRoomSkinEquipped(slot8.id, slot8.skinId)

			slot3[slot8.id] = true
		end
	end

	if slot2 then
		for slot7, slot8 in pairs(RoomInitBuildingEnum.InitBuildingId) do
			if not slot3[slot8] then
				slot0:setRoomSkinEquipped(slot8, RoomInitBuildingEnum.InitRoomSkinId[slot8])
			end
		end
	end
end

function slot0.setRoomSkinEquipped(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return
	end

	if not slot0:getRoomSkinMO(slot2, true) then
		return
	end

	if slot0:getEquipRoomSkin(slot1) and slot0:getRoomSkinMO(slot4, true) then
		slot5:setIsEquipped(false)
	end

	slot3:setIsEquipped(true)
end

function slot0.setIsShowRoomSkinList(slot0, slot1)
	slot0._isShowRoomSkinList = slot1
end

function slot0.setOtherPlayerRoomSkinDict(slot0, slot1)
	slot0._otherPlayerRoomSkinDict = {}

	if not slot1 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		slot0._otherPlayerRoomSkinDict[slot6.id] = slot6.skinId
	end
end

function slot0.getRoomSkinMO(slot0, slot1, slot2)
	if not slot0._isInitSkinMoList then
		slot0:initSkinMoList()
	end

	if not (slot1 and slot0:getById(slot1)) and slot2 then
		logError(string.format("RoomSkinModel:getRoomSkinMO error, skinMO is nil, skinId:%s", slot1))
	end

	return slot3
end

function slot0.getIsShowRoomSkinList(slot0)
	return slot0._isShowRoomSkinList
end

function slot0.getShowSkin(slot0, slot1)
	if not slot1 then
		return
	end

	if RoomController.instance:isVisitMode() then
		if not slot0:getOtherPlayerRoomSkinDict() or not slot4[slot1] or nil == 0 then
			slot2 = RoomInitBuildingEnum.InitRoomSkinId[slot1]
		end
	else
		slot5 = RoomSkinListModel.instance:getCurPreviewSkinId() and RoomConfig.instance:getBelongPart(slot4)
		slot2 = slot5 and slot5 == slot1 and slot4 or slot0:getEquipRoomSkin(slot1)
	end

	if not slot2 then
		logError(string.format("RoomSkinModel:getShowSkin error, show skin is nil, partId:%s", slot1))

		slot2 = RoomInitBuildingEnum.InitRoomSkinId[slot1]
	end

	return slot2
end

function slot0.getEquipRoomSkin(slot0, slot1)
	if not slot1 then
		return nil
	end

	for slot7, slot8 in ipairs(RoomConfig.instance:getSkinIdList(slot1)) do
		if slot0:isEquipRoomSkin(slot8) then
			slot2 = slot8

			break
		end
	end

	return slot2
end

function slot0.isUnlockRoomSkin(slot0, slot1)
	if not slot1 then
		return false
	end

	return slot0:getRoomSkinMO(slot1) and slot3:isUnlock()
end

function slot0.isNewRoomSkin(slot0, slot1)
	if not slot1 then
		return false
	end

	return RedDotModel.instance:isDotShow(RedDotEnum.DotNode.RoomNewSkinItem, slot1)
end

function slot0.isHasNewRoomSkin(slot0, slot1)
	if not slot1 then
		return false
	end

	for slot7, slot8 in ipairs(RoomConfig.instance:getSkinIdList(slot1)) do
		if slot0:isNewRoomSkin(slot8) then
			slot2 = true

			break
		end
	end

	return slot2
end

function slot0.isEquipRoomSkin(slot0, slot1)
	slot2 = false

	if slot0:getRoomSkinMO(slot1, true) then
		slot2 = slot3:isEquipped()
	end

	return slot2
end

function slot0.isDefaultRoomSkin(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return false
	end

	return slot2 == RoomInitBuildingEnum.InitRoomSkinId[slot1]
end

function slot0.getOtherPlayerRoomSkinDict(slot0)
	return slot0._otherPlayerRoomSkinDict
end

slot0.instance = slot0.New()

return slot0
