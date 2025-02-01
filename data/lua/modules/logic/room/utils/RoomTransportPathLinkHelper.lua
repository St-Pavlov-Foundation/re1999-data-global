module("modules.logic.room.utils.RoomTransportPathLinkHelper", package.seeall)

return {
	_neighborMODict = {},
	_neighborLinkResIdDict = {},
	getPtahLineType = function (slot0, slot1, slot2)
		if not slot0 then
			return nil
		end

		if slot1 == nil and slot2 == nil then
			return RoomTransportPathEnum.PathLineType.Line00, 0
		end

		if not slot1 or HexPoint.Distance(slot0, slot1) ~= 1 then
			return uv0._getLine10(slot0, slot2)
		end

		if not slot2 or HexPoint.Distance(slot0, slot2) ~= 1 then
			return uv0._getLine10(slot0, slot1)
		end

		if math.abs(uv0.findLinkDirection(slot0, slot1) - uv0.findLinkDirection(slot0, slot2)) == 1 then
			return uv0._getLineAbs1(slot3, slot4)
		elseif slot5 == 2 then
			return uv0._getLineAbs2(slot3, slot4)
		elseif slot5 == 3 then
			return uv0._getLineAbs3(slot3, slot4)
		elseif slot5 == 4 then
			return uv0._getLineAbs4(slot3, slot4)
		elseif slot5 == 5 then
			return uv0._getLineAbs5(slot3, slot4)
		end
	end,
	_getLine10 = function (slot0, slot1)
		if not slot1 or HexPoint.Distance(slot0, slot1) ~= 1 then
			return nil
		end

		if uv0.findLinkDirection(slot0, slot1) then
			return RoomTransportPathEnum.PathLineType.Line10, slot2 - 1
		end
	end,
	_getLineAbs1 = function (slot0, slot1)
		return RoomTransportPathEnum.PathLineType.Line12, math.max(slot0, slot1) - 2
	end,
	_getLineAbs5 = function (slot0, slot1)
		return RoomTransportPathEnum.PathLineType.Line12, 5
	end,
	_getLineAbs2 = function (slot0, slot1)
		return RoomTransportPathEnum.PathLineType.Line13, math.max(slot0, slot1) - 3
	end,
	_getLineAbs4 = function (slot0, slot1)
		return RoomTransportPathEnum.PathLineType.Line13, math.max(slot0, slot1) - 1
	end,
	_getLineAbs3 = function (slot0, slot1)
		return RoomTransportPathEnum.PathLineType.Line14, math.max(slot0, slot1) - 4
	end,
	findLinkDirection = function (slot0, slot1)
		if slot1.x - slot0.x == 0 and slot1.y - slot0.y == 0 then
			return 0
		end

		for slot7 = 1, 6 do
			if slot2 == HexPoint.directions[slot7].x and slot3 == slot8.y then
				return slot7
			end
		end

		return nil
	end
}
