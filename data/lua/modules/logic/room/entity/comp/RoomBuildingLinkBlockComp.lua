module("modules.logic.room.entity.comp.RoomBuildingLinkBlockComp", package.seeall)

slot0 = class("RoomBuildingLinkBlockComp", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0.entity = slot1
	slot0._effectKey = RoomEnum.EffectKey.BuildingGOKey
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0._linkBlockDefineIds = string.splitToNumber(slot0:getMO().config.linkBlock, "#") or {}
	slot0._linkBlockDefineDict = {}

	for slot6, slot7 in ipairs(slot0._linkBlockDefineIds) do
		slot0._linkBlockDefineDict[slot7] = true
	end

	slot0._isLink = slot0:_checkLinkBlock()
end

function slot0.addEventListeners(slot0)
	RoomMapController.instance:registerCallback(RoomEvent.ClientPlaceBlock, slot0._onBlockChange, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.ClientCancelBlock, slot0._onBlockChange, slot0)
	RoomMapController.instance:registerCallback(RoomEvent.ConfirmBackBlock, slot0._onBlockChange, slot0)
	RoomBuildingController.instance:registerCallback(RoomEvent.DropBuildingDown, slot0._onBlockChange, slot0)
end

function slot0.removeEventListeners(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.ClientPlaceBlock, slot0._onBlockChange, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.ClientCancelBlock, slot0._onBlockChange, slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.ConfirmBackBlock, slot0._onBlockChange, slot0)
	RoomBuildingController.instance:unregisterCallback(RoomEvent.DropBuildingDown, slot0._onBlockChange, slot0)
end

function slot0.beforeDestroy(slot0)
	slot0:removeEventListeners()
end

function slot0._onBlockChange(slot0)
	slot0:refreshLink()
end

function slot0.refreshLink(slot0)
	if slot0._isLink ~= slot0:_checkLinkBlock() then
		slot0._isLink = slot1

		slot0:_updateLink()
	end
end

function slot0._updateLink(slot0)
	if slot0.entity.effect:getGameObjectsByName(slot0._effectKey, RoomEnum.EntityChildKey.BuildingLinkBlockGOKey) and #slot1 > 0 then
		for slot5, slot6 in ipairs(slot1) do
			gohelper.setActive(slot6, slot0._isLink)
		end
	end
end

function slot0._checkLinkBlock(slot0)
	if not slot0._linkBlockDefineIds or #slot0._linkBlockDefineIds < 1 or slot0.entity.id == RoomBuildingController.instance:isPressBuilding() then
		return false
	end

	slot1, slot2 = slot0:_getOccupyDict()

	if not slot1 then
		return false
	end

	slot3 = RoomMapBlockModel.instance
	slot4 = HexPoint.directions

	for slot8, slot9 in ipairs(slot2) do
		for slot13 = 1, 6 do
			slot14 = slot4[slot13]
			slot16 = slot14.y + slot9.y

			if (not slot1[slot14.x + slot9.x] or not slot1[slot15][slot16]) and slot3:getBlockMO(slot15, slot16) and slot17:isInMapBlock() and slot0._linkBlockDefineDict[slot17:getDefineId()] then
				return true
			end
		end
	end

	return false
end

function slot0._getOccupyDict(slot0)
	return slot0.entity:getOccupyDict()
end

function slot0.getMO(slot0)
	return slot0.entity:getMO()
end

function slot0.onEffectRebuild(slot0)
	if slot0.entity.effect:isHasEffectGOByKey(slot0._effectKey) and not slot1:isSameResByKey(slot0._effectKey, slot0._effectRes) then
		slot0._effectRes = slot1:getEffectRes(slot0._effectKey)

		slot0:_updateLink()
	end
end

return slot0
