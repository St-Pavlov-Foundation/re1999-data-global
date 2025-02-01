module("modules.logic.room.utils.hex.HexMath", package.seeall)

slot1 = math.sqrt(3)
slot2 = Vector2(1, 0)

return {
	hexToPosition = function (slot0, slot1)
		slot2, slot3 = uv0.hexXYToPosXY(slot0.x, slot0.y, slot1)

		return Vector2(slot2, slot3)
	end,
	hexXYToPosXY = function (slot0, slot1, slot2)
		slot3 = slot0
		slot2 = slot2 or 1

		return slot2 * 3 * slot3 / 2, slot2 * (-uv0 * slot3 / 2 - uv0 * slot1)
	end,
	point2HexDistance = function (slot0, slot1, slot2)
		slot3 = Vector2.Normalize(slot0 - slot1)

		if math.acos(Vector2.Dot(slot3, uv0) / Vector2.Magnitude(slot3)) % (math.pi / 3) > math.pi / 6 then
			slot4 = math.pi / 3 - slot4
		end

		return Vector2.Distance(slot0, slot1) - uv1 / 2 / math.cos(slot4) * slot2, slot3
	end,
	positionToHex = function (slot0, slot1)
		slot2, slot3 = uv0.posXYToHexXY(slot0.x, slot0.y, slot1)

		return HexPoint(slot2, slot3)
	end,
	posXYToHexXY = function (slot0, slot1, slot2)
		slot2 = slot2 or 1

		return 0.6666666666666666 * slot0 / slot2, (-0.3333333333333333 * slot0 - uv0 / 3 * slot1) / slot2
	end,
	positionToRoundHex = function (slot0, slot1)
		slot2, slot3 = uv0.posXYToHexXY(slot0.x, slot0.y, slot1)
		slot4, slot5, slot6, slot7 = uv0._roundXYZD(slot2, slot3)

		return HexPoint(slot4, slot5), slot7
	end,
	posXYToRoundHexYX = function (slot0, slot1, slot2)
		slot3, slot4 = uv0.posXYToHexXY(slot0, slot1, slot2)
		slot5, slot6, slot7, slot8 = uv0._roundXYZD(slot3, slot4)

		return slot5, slot6, slot8
	end,
	round = function (slot0)
		slot1, slot2, slot3, slot4 = uv0._roundXYZD(slot0.x, slot0.y, slot0.z)

		return HexPoint(slot1, slot2), slot4
	end,
	roundXY = function (slot0, slot1)
		slot2, slot3, slot4, slot5 = uv0._roundXYZD(slot0, slot1)

		return slot2, slot3, slot5
	end,
	_roundXYZD = function (slot0, slot1, slot2)
		if slot2 == nil then
			slot2 = -slot0 - slot1
		end

		if math.abs(Mathf.Round(slot1) - slot1) < math.abs(Mathf.Round(slot0) - slot0) and math.abs(Mathf.Round(slot2) - slot2) < slot6 then
			slot3 = -slot4 - slot5
		elseif slot8 < slot7 then
			slot4 = -slot3 - slot5
		else
			slot5 = -slot3 - slot4
		end

		slot9 = 0
		slot11 = slot1 - slot4
		slot12 = slot2 - slot5

		if slot0 - slot3 >= 0 and slot11 >= 0 then
			slot9 = slot11 <= slot10 and 3 or 4
		elseif slot11 >= 0 and slot12 >= 0 then
			slot9 = slot12 <= slot11 and 5 or 6
		elseif slot12 >= 0 and slot10 >= 0 then
			slot9 = slot10 <= slot12 and 1 or 2
		elseif slot10 < 0 and slot11 < 0 then
			slot9 = slot10 < slot11 and 6 or 1
		elseif slot11 < 0 and slot12 < 0 then
			slot9 = slot11 < slot12 and 2 or 3
		elseif slot12 < 0 and slot10 < 0 then
			slot9 = slot12 < slot10 and 4 or 5
		end

		return slot3, slot4, slot5, slot9
	end,
	resourcePointToPosition = function (slot0, slot1, slot2)
		return uv0.hexToPosition(uv0.resourcePointToHexPoint(slot0, slot2), slot1)
	end,
	resourcePointToHexPoint = function (slot0, slot1)
		slot2 = HexPoint.directions[slot0.direction]

		return HexPoint(slot0.x + slot2.x * slot1, slot0.y + slot2.y * slot1)
	end,
	zeroRadius = function (slot0, slot1)
		return (math.abs(slot0) + math.abs(slot1) + math.abs(slot0 - slot1)) / 2
	end,
	countByRadius = function (slot0)
		slot1 = 1

		if slot0 > 0 then
			slot1 = 1 + (slot0 + 1) * slot0 * 3
		end

		return slot1
	end,
	hexXYToSpiralIndex = function (slot0, slot1)
		if uv0.zeroRadius(slot0, slot1) < 1 then
			return 1
		end

		slot3 = uv0.countByRadius(slot2 - 1)
		slot5 = HexPoint.directions[5]
		slot6 = slot5.x * slot2
		slot7 = slot5.y * slot2

		for slot11 = 1, 6 do
			for slot15 = 1, slot2 do
				slot16 = slot4[slot11]

				if slot1 == slot7 + slot16.y and slot0 == slot6 + slot16.x then
					return slot3 + 1
				end
			end
		end

		return slot3
	end
}
