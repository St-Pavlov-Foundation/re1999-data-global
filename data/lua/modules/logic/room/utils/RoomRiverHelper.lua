module("modules.logic.room.utils.RoomRiverHelper", package.seeall)

return {
	_neighborMODict = {},
	_neighborLinkResIdDict = {},
	getRiverTypeDictByMO = function (slot0)
		if not slot0:isFullWater() then
			return {}, {}, {}
		end

		if not slot0:isInMapBlock() or uv0._isNotLink(slot0) then
			for slot8 = 1, 6 do
				slot1[slot8] = RoomRiverEnum.LakeOutLinkType.NoLink
				slot2[slot8] = slot0:getDefineBlockType()
			end

			return slot1, slot2
		end

		slot7 = slot0.hexPoint

		for slot11 = 1, 6 do
			slot12 = HexPoint.directions[slot11]

			if RoomMapBlockModel.instance:getBlockMO(slot7.x + slot12.x, slot7.y + slot12.y) and slot13:isInMapBlock() and not uv0._isNotLink(slot13) then
				uv0._neighborMODict[slot11] = slot13
				uv0._neighborLinkResIdDict[slot11] = slot13:getResourceId(RoomRotateHelper.rotateDirection(slot11, 3), false, true)
			else
				slot4[slot11] = nil
				slot5[slot11] = nil
			end
		end

		for slot12 = 1, 6 do
			slot1[slot12], slot14, slot3[slot12] = uv0._getRiverTypeByDirection(slot0, slot12, slot4, slot5)
			slot2[slot12] = slot14 or slot0:getDefineBlockType()
		end

		return slot1, slot2, slot3
	end,
	_isNotLink = function (slot0)
		if slot0 then
			return slot0:getBlockDefineCfg() and slot1.waterLink == 1
		end

		return false
	end,
	_getRiverTypeByDirection = function (slot0, slot1, slot2, slot3)
		if slot0:getResourceId(slot1, false, true) ~= RoomResourceEnum.ResourceId.River or not slot0:isInMapBlock() then
			return RoomRiverEnum.LakeOutLinkType.NoLink
		end

		if slot2[slot1] then
			if slot3[slot1] ~= RoomResourceEnum.ResourceId.River then
				return RoomRiverEnum.LakeOutLinkType.Floor, slot5:getDefineBlockType()
			end

			if not slot5:isFullWater() then
				return RoomRiverEnum.LakeOutLinkType.River, slot5:getDefineBlockType()
			end
		end

		slot7 = RoomRotateHelper.rotateDirection(slot1, 1)
		slot8 = RoomRotateHelper.rotateDirection(slot1, -1)
		slot16 = uv0._checkSideFloor(RoomResourceEnum.ResourceId.River, slot2[slot8], slot3[slot8])

		if not uv0._checkSideFloor(RoomResourceEnum.ResourceId.River, slot2[slot7], slot3[slot7]) and not slot16 then
			return RoomRiverEnum.LakeOutLinkType.NoLink
		end

		if slot15 and not slot16 then
			return RoomRiverEnum.LakeOutLinkType.Left, slot9:getDefineBlockType()
		end

		if not slot15 and slot16 then
			return RoomRiverEnum.LakeOutLinkType.Right, slot10:getDefineBlockType()
		end

		return RoomRiverEnum.LakeOutLinkType.RightLeft, slot10:getDefineBlockType(), slot9:getDefineBlockType()
	end,
	_checkSideFloor = function (slot0, slot1, slot2)
		if slot0 ~= RoomResourceEnum.ResourceId.River or not slot1 or slot1:isFullWater() and slot2 == RoomResourceEnum.ResourceId.River then
			return false
		end

		return true
	end
}
