module("modules.logic.room.utils.RoomCameraHelper", package.seeall)

return {
	getConvexHull = function (slot0)
		return uv0.getSubConvexHull(slot0)
	end,
	getSubConvexHull = function (slot0)
		if not slot0 then
			return {}
		end

		if #uv0.derepeat(slot0) <= 2 then
			return slot0
		end

		slot2 = {}
		slot3 = 0

		for slot7, slot8 in ipairs(slot0) do
			if slot7 == 1 or slot8.y < slot0[slot3].y or slot8.y == slot0[slot3].y and slot8.x < slot0[slot3].x then
				slot3 = slot7
			end
		end

		slot0[slot3] = slot0[1]
		slot0[1] = slot0[slot3]
		slot4 = slot0[1]

		table.sort(slot0, function (slot0, slot1)
			if slot0 == uv0 and slot1 ~= uv0 then
				return true
			elseif slot0 ~= uv0 and slot1 == uv0 then
				return false
			end

			if uv1.getCross(slot0, slot1, uv0) ~= 0 then
				return slot2 > 0
			end

			if slot0.y ~= slot1.y then
				return slot1.y < slot0.y
			end

			return math.abs(slot1.x - uv0.x) < math.abs(slot0.x - uv0.x)
		end)

		slot1 = #uv0.collineation(slot0)
		slot5 = 1
		slot6 = 1

		while slot6 <= slot1 + 1 do
			slot8 = slot0[(slot6 - 1) % slot1 + 1]

			while slot5 > 2 do
				if uv0.getCross(slot2[slot5 - 1], slot8, slot2[slot5 - 2]) > 0 then
					break
				end

				slot5 = slot5 - 1
			end

			if slot6 <= slot1 then
				slot2[slot5] = slot8
			else
				slot2[slot5] = Vector2(slot8.x, slot8.y)
			end

			slot5 = slot5 + 1
			slot6 = slot6 + 1
		end

		for slot10 = #slot2, 1, -1 do
			if slot5 <= slot10 then
				table.remove(slot2, slot10)
			end
		end

		return slot2
	end,
	getCross = function (slot0, slot1, slot2)
		return (slot0.x - slot2.x) * (slot1.y - slot2.y) - (slot0.y - slot2.y) * (slot1.x - slot2.x)
	end,
	collineation = function (slot0)
		slot1 = {}
		slot2 = slot0[1]
		slot3 = {
			[slot8] = true
		}

		for slot8 = 3, #slot0 do
			if math.abs(uv0.getCross(slot0[2], slot0[slot8], slot2)) < 1e-05 then
				if slot10.y < slot9.y or slot9.y == slot10.y and math.abs(slot10.x - slot2.x) < math.abs(slot9.x - slot2.x) then
					-- Nothing
				else
					slot3[slot4] = true
					slot4 = slot8
				end
			else
				slot4 = slot8
			end
		end

		for slot8, slot9 in ipairs(slot0) do
			if not slot3[slot8] then
				table.insert(slot1, slot9)
			end
		end

		return slot1
	end,
	derepeat = function (slot0)
		slot1 = {}
		slot2 = {}

		for slot6, slot7 in ipairs(slot0) do
			if not (slot2[slot7.x] and slot2[slot7.x][slot7.y]) then
				table.insert(slot1, slot7)

				slot2[slot7.x] = slot2[slot7.x] or {}
				slot2[slot7.x][slot7.y] = true
			end
		end

		return slot1
	end,
	isPointInConvexHull = function (slot0, slot1)
		if not slot0 or not slot1 or #slot1 <= 2 then
			return true
		end

		slot2 = true
		slot3 = 0
		slot4, slot5 = nil
		slot6 = 0

		for slot10 = 1, #slot1 do
			slot12 = slot1[slot10 + 1]

			if slot1[slot10] and slot12 and uv0.getCross(slot12, slot0, slot11) < 0 then
				slot2 = false

				if slot3 < uv0.getDistance(slot0, slot11, slot12) or slot3 == 0 then
					slot3 = slot13
					slot4 = slot11
					slot5 = slot12
				end

				slot6 = slot6 + 1
			end
		end

		return slot2, slot3, slot4, slot5, slot6
	end,
	getDistance = function (slot0, slot1, slot2)
		if slot1 == slot2 then
			return Vector2.Distance(slot1, slot0)
		end

		if slot1.y == slot2.y then
			return math.abs(slot0.y - slot1.y)
		end

		if slot1.x == slot2.x then
			return math.abs(slot0.x - slot1.x)
		end

		slot3 = (slot1.y - slot2.y) / (slot1.x - slot2.x)

		return math.abs((slot3 * slot0.x - slot0.y + (slot1.x * slot2.y - slot2.x * slot1.y) / (slot1.x - slot2.x)) / math.sqrt(slot3 * slot3 + 1))
	end,
	getDirection = function (slot0, slot1, slot2)
		slot3 = Vector2.Normalize(slot2 - slot1)

		return Vector2(-slot3.y, slot3.x)
	end,
	getOffsetPosition = function (slot0, slot1, slot2)
		if RoomController.instance:isDebugMode() then
			return slot1
		end

		if not slot2 or #slot2 <= 2 then
			return slot1
		end

		slot3, slot4, slot5, slot6, slot7 = uv0.isPointInConvexHull(slot1, slot2)

		if slot3 then
			return slot1
		elseif slot7 >= 2 then
			if uv0.isPointInConvexHull(slot1 + uv0.getDirection(slot1, slot5, slot6) * (slot4 + 0.0001), slot2) then
				return slot9
			else
				return slot0
			end
		else
			return slot1 + uv0.getDirection(slot1, slot5, slot6) * slot4
		end
	end,
	expandConvexHull = function (slot0, slot1)
		slot2 = {}

		if #slot0 <= 0 then
			return slot0
		end

		for slot7, slot8 in ipairs(slot0) do
			if slot7 < slot3 then
				slot10 = slot0[slot7 + 1]

				if (slot0[slot7 - 1] or slot0[slot3 - 1]) and slot10 then
					table.insert(slot2, uv0.expandPoint(slot8, slot9, slot10, slot1))
				end
			end
		end

		slot4 = slot2[1]

		table.insert(slot2, Vector2(slot4.x, slot4.y))

		return uv0.getConvexHull(slot2)
	end,
	expandPoint = function (slot0, slot1, slot2, slot3)
		if Mathf.Abs(Vector2.Dot(Vector2.Normalize(slot1 - slot0), Vector2.Normalize(slot2 - slot0))) <= 0.0001 then
			slot7 = Vector2(slot4.y, slot4.x)
			slot8 = -slot7

			if Vector2.Dot(slot0, slot7) > 0 then
				return slot0 + slot7 * slot3
			elseif Vector2.Dot(slot6, slot8) > 0 then
				return slot0 + slot8 * slot3
			end

			return slot0
		end

		slot6 = -Vector2.Normalize(slot4 + slot5)

		if Vector2.Dot(slot4, slot5) < -1 then
			slot7 = -1
		elseif slot7 > 1 then
			slot7 = 1
		end

		if Mathf.Sin(Mathf.Acos(slot7) / 2) == 0 then
			return slot0
		end

		return slot0 + slot6 * slot3 / slot9
	end,
	getConvexHexPointDict = function (slot0)
		if not slot0 or #slot0 <= 2 then
			return {}
		end

		slot3 = {
			HexPoint(0, 0)
		}
		slot2[0] = ({})[0] or {}
		slot2[0][0] = true

		while #slot3 > 0 do
			slot4 = {}

			for slot8, slot9 in ipairs(slot3) do
				if uv0.isPointInConvexHull(HexMath.hexToPosition(slot9, RoomBlockEnum.BlockSize), slot0) then
					slot1[slot9.x] = slot1[slot9.x] or {}
					slot1[slot9.x][slot9.y] = true

					for slot15, slot16 in ipairs(slot9:getNeighbors()) do
						if not slot2[slot16.x] or not slot2[slot16.x][slot16.y] then
							table.insert(slot4, slot16)

							slot2[slot16.x] = slot2[slot16.x] or {}
							slot2[slot16.x][slot16.y] = true
						end
					end
				end
			end

			slot3 = slot4
		end

		return slot1
	end
}
