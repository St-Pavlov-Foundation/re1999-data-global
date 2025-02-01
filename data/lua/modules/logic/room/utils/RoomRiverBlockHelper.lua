module("modules.logic.room.utils.RoomRiverBlockHelper", package.seeall)

return {
	TypeToFunction = nil,
	_getFunctionByType = function (slot0)
		if not uv0.TypeToFunction then
			uv0.TypeToFunction = {
				[RoomDistributionEnum.DistributionType.C1TA] = uv0._getRiverBlockType_C1TA,
				[RoomDistributionEnum.DistributionType.C2TA] = uv0._getRiverBlockType_C2TA,
				[RoomDistributionEnum.DistributionType.C2TB] = uv0._getRiverBlockType_C2TB,
				[RoomDistributionEnum.DistributionType.C2TC] = uv0._getRiverBlockType_C2TC,
				[RoomDistributionEnum.DistributionType.C3TA] = uv0._getRiverBlockType_C3TA,
				[RoomDistributionEnum.DistributionType.C3TB] = uv0._getRiverBlockType_C3TB,
				[RoomDistributionEnum.DistributionType.C3TC] = uv0._getRiverBlockType_C3TC,
				[RoomDistributionEnum.DistributionType.C3TD] = uv0._getRiverBlockType_C3TD,
				[RoomDistributionEnum.DistributionType.C4TA] = uv0._getRiverBlockType_C4TA,
				[RoomDistributionEnum.DistributionType.C4TB] = uv0._getRiverBlockType_C4TB,
				[RoomDistributionEnum.DistributionType.C4TC] = uv0._getRiverBlockType_C4TC,
				[RoomDistributionEnum.DistributionType.C5TA] = uv0._getRiverBlockType_C5TA,
				[RoomDistributionEnum.DistributionType.C6TA] = uv0._getRiverBlockType_C6TA
			}
		end

		return uv0.TypeToFunction[slot0]
	end,
	getRiverBlockTypeByMO = function (slot0)
		for slot5 = 1, 6 do
			table.insert({}, slot0:getResourceId(slot5, false, true))
		end

		slot2 = {}

		if slot0:isInMap() then
			for slot6 = 1, 6 do
				slot7 = slot0.hexPoint:getNeighbor(slot6)

				if RoomMapBlockModel.instance:getBlockMO(slot7.x, slot7.y) then
					slot2[slot6] = {}

					for slot12 = 1, 6 do
						table.insert(slot2[slot6], slot8:getResourceId(slot12, false, true))
					end
				end
			end
		end

		return uv0.getRiverBlockType(slot1, slot2, slot0:getRotate(), slot0:getDefineBlockType(), slot0:getDefineWaterType())
	end,
	getRiverBlockType = function (slot0, slot1, slot2, slot3, slot4)
		slot5 = {}
		slot6 = {}
		slot7 = {}

		for slot12 = 1, 6 do
			if slot0[slot12] == RoomResourceEnum.ResourceId.River then
				slot8 = 0 + 1
			end

			table.insert(slot5, slot13)
		end

		for slot12 = 1, 6 do
			if slot1[slot12] then
				slot14 = true
				slot15 = RoomRotateHelper.oppositeDirection(slot12)

				for slot19 = 1, 6 do
					if not (slot13[slot19] == RoomResourceEnum.ResourceId.River or slot13[slot19] == RoomResourceEnum.ResourceId.Empty) then
						slot14 = false
					end

					if slot19 == slot15 then
						table.insert(slot6, slot20)
					end
				end

				table.insert(slot7, slot14)
			else
				table.insert(slot6, true)
				table.insert(slot7, true)
			end
		end

		if slot8 > 0 then
			for slot13, slot14 in ipairs(RoomDistributionEnum.CountToTypeList[slot8]) do
				slot15, slot16 = RoomDistributionHelper.matchType(slot14, slot5, slot2)

				if slot15 then
					slot18, slot19 = uv0._getFunctionByType(slot14)(slot5, slot6, slot7)
					slot20, slot21, slot22, slot23 = nil
					slot19 = slot19 or 0

					if slot18 then
						slot22, slot23 = RoomResHelper.getMapBlockResPath(RoomResourceEnum.ResourceId.River, slot18, slot4)
						slot20, slot21 = RoomResHelper.getMapRiverFloorResPath(slot18, slot3)
					end

					return slot22, RoomRotateHelper.rotateRotate(RoomRotateHelper.rotateRotate(slot16, -slot2), slot19), slot20, slot23, slot21
				end
			end
		end
	end,
	_getRiverX = function (slot0, slot1)
		return not slot1 and slot0 .. "x" or slot0
	end,
	_getRiverBlockType_C1TA = function (slot0, slot1, slot2)
		return RoomRiverEnum.RiverBlockType["4000"], -1
	end,
	_getRiverBlockType_C2TA = function (slot0, slot1, slot2)
		return RoomRiverEnum.RiverBlockType["4002"], -1
	end,
	_getRiverBlockType_C2TB = function (slot0, slot1, slot2)
		return RoomRiverEnum.RiverBlockType["4003"], -1
	end,
	_getRiverBlockType_C2TC = function (slot0, slot1, slot2)
		return RoomRiverEnum.RiverBlockType["4001"], -1
	end,
	_getRiverBlockType_C3TA = function (slot0, slot1, slot2)
		return RoomRiverEnum.RiverBlockType["4004"], 0
	end,
	_getRiverBlockType_C3TB = function (slot0, slot1, slot2)
		return RoomRiverEnum.RiverBlockType["4006"], 0
	end,
	_getRiverBlockType_C3TC = function (slot0, slot1, slot2)
		return RoomRiverEnum.RiverBlockType["4005"], -1
	end,
	_getRiverBlockType_C3TD = function (slot0, slot1, slot2)
		return RoomRiverEnum.RiverBlockType["4007"], -1
	end,
	_getRiverBlockType_C4TA = function (slot0, slot1, slot2)
		return RoomRiverEnum.RiverBlockType["4008"], 1
	end,
	_getRiverBlockType_C4TB = function (slot0, slot1, slot2)
		return RoomRiverEnum.RiverBlockType["4009"], 0
	end,
	_getRiverBlockType_C4TC = function (slot0, slot1, slot2)
		return RoomRiverEnum.RiverBlockType["4010"], -1
	end,
	_getRiverBlockType_C5TA = function (slot0, slot1, slot2)
		return RoomRiverEnum.RiverBlockType["4011"], -1
	end,
	_getRiverBlockType_C6TA = function (slot0, slot1, slot2)
		return nil
	end
}
