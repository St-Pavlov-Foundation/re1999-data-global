module("modules.logic.room.utils.hex.HexPoint", package.seeall)

slot0 = {
	New = function (slot0, slot1, slot2)
		if slot0 == nil then
			slot3 = 0 + 1
		end

		if slot1 == nil then
			slot3 = slot3 + 1
		end

		if slot2 == nil then
			slot3 = slot3 + 1
		end

		if slot3 > 1 then
			logError("HexPoint: xyz需要至少两个值")

			slot2 = 0
			slot1 = 0
			slot0 = 0
		elseif slot0 == nil then
			slot0 = -slot1 - slot2
		elseif slot1 == nil then
			slot1 = -slot2 - slot0
		elseif slot2 == nil then
			slot2 = -slot0 - slot1
		end

		slot4 = {
			x = slot0,
			y = slot1
		}

		setmetatable(slot4, uv0)

		return slot4
	end
}
slot0.new = slot0.New
slot1 = slot0.New
slot2 = {
	z = function (slot0)
		if slot0.x == 0 and slot0.y == 0 then
			return 0
		end

		return -slot0.x - slot0.y
	end,
	q = function (slot0)
		return slot0.x
	end,
	r = function (slot0)
		return slot0.y
	end,
	s = function (slot0)
		return uv0.z(slot0)
	end
}

function slot0.__index(slot0, slot1)
	if nil == nil then
		slot2 = rawget(uv0, slot1)
	end

	if slot2 == nil then
		slot2 = rawget(slot0, slot1)
	end

	if slot2 == nil and rawget(uv1, slot1) ~= nil then
		return slot2(slot0)
	end

	return slot2
end

slot0.directions = {
	[0] = slot1(0, 0),
	slot1(0, -1),
	slot1(1, -1),
	slot1(1, 0),
	slot1(0, 1),
	slot1(-1, 1),
	slot1(-1, 0)
}

function slot0.Add(slot0, slot1)
	return uv0(slot0.x + slot1.x, slot0.y + slot1.y)
end

slot0.add = slot0.Add
slot3 = slot0.Add

function slot0.Sub(slot0, slot1)
	return uv0(slot0.x - slot1.x, slot0.y - slot1.y)
end

slot0.sub = slot0.Sub
slot4 = slot0.Sub

function slot0.Mul(slot0, slot1)
	return HexMath.round(uv0(slot0.x * slot1, slot0.y * slot1))
end

slot0.mul = slot0.Mul
slot5 = slot0.Mul

function slot0.Div(slot0, slot1)
	return HexMath.round(uv0(slot0.x / slot1, slot0.y / slot1))
end

slot0.div = slot0.Div
slot6 = slot0.Div

function slot0.Distance(slot0, slot1)
	return (math.abs(slot0.x - slot1.x) + math.abs(slot0.y - slot1.y) + math.abs(slot0.z - slot1.z)) / 2
end

slot0.distance = slot0.Distance
slot0.getDistance = slot0.Distance
slot0.GetDistance = slot0.Distance

function slot0.DirectDistance(slot0, slot1)
	return Vector2.Distance(HexMath.hexToPosition(slot0), HexMath.hexToPosition(slot1))
end

slot0.directDistance = slot0.DirectDistance
slot0.getDirectDistance = slot0.DirectDistance
slot0.GetDirectDistance = slot0.DirectDistance

function slot0.InRanges(slot0, slot1, slot2)
	slot3 = {}
	slot1 = math.abs(slot1 or 0)

	for slot7 = -slot1, slot1 do
		slot11 = -slot7 + slot1

		for slot11 = math.max(-slot1, -slot7 - slot1), math.min(slot1, slot11) do
			if not slot2 or slot7 ~= 0 or slot11 ~= 0 then
				table.insert(slot3, uv0(slot0, uv1(slot7, slot11)))
			end
		end
	end

	return slot3
end

slot0.inRanges = slot0.InRanges
slot0.getInRanges = slot0.InRanges
slot0.GetInRanges = slot0.InRanges

function slot0.OnRanges(slot0, slot1)
	slot2 = {}
	slot3 = uv0.directions[5] * math.abs(slot1 or 0) + slot0

	for slot7 = 1, 6 do
		for slot11 = 1, slot1 do
			table.insert(slot2, slot3)

			slot3 = slot3 + uv0.directions[slot7]
		end
	end

	return slot2
end

slot0.onRanges = slot0.OnRanges
slot0.getOnRanges = slot0.OnRanges
slot0.GetOnRanges = slot0.OnRanges

function slot0.Neighbors(slot0)
	slot1 = {}

	for slot5 = 1, 6 do
		table.insert(slot1, slot0 + uv0.directions[slot5])
	end

	return slot1
end

slot0.neighbors = slot0.Neighbors
slot0.getNeighbors = slot0.Neighbors
slot0.GetNeighbors = slot0.Neighbors

function slot0.Neighbor(slot0, slot1)
	if slot1 < 1 or slot1 > 6 then
		logError("HexPoint: Neighbor index需要在1~6之间")

		return nil
	end

	return slot0 + uv0.directions[slot1]
end

slot0.neighbor = slot0.Neighbor
slot0.getNeighbor = slot0.Neighbor
slot0.GetNeighbor = slot0.Neighbor

function slot0.IntersectingRanges(slot0, slot1, slot2, slot3, slot4)
	slot3 = slot3 and math.abs(slot3) or math.abs(slot2 or 0)

	logError("HexPoint: 未实现IntersectingRanges")

	return {}
end

slot0.intersectingRanges = slot0.IntersectingRanges
slot0.getIntersectingRanges = slot0.IntersectingRanges
slot0.GetIntersectingRanges = slot0.IntersectingRanges

function slot0.Rotate(slot0, slot1, slot2, slot3)
	slot1 = slot1 or uv0(0, 0)

	for slot9 = 1, RoomRotateHelper.getMod(slot2, 6) do
		if slot3 then
			slot4 = -(slot0.x - slot1.x + slot0.y - slot1.y)
		else
			slot4 = slot4 + -slot4
		end
	end

	return uv0(slot4 + slot1.x, slot5 + slot1.y)
end

slot0.rotate = slot0.Rotate
slot0.getRotate = slot0.Rotate
slot0.GetRotate = slot0.Rotate

function slot0.ConvertToOffsetCoordinates(slot0)
	slot2 = slot0.y

	return Vector2(slot0.x + (slot2 - RoomRotateHelper.getMod(slot2, 2)) / 2, slot2)
end

slot0.convertToOffsetCoordinates = slot0.ConvertToOffsetCoordinates
slot0.getConvertToOffsetCoordinates = slot0.ConvertToOffsetCoordinates
slot0.GetConvertToOffsetCoordinates = slot0.ConvertToOffsetCoordinates

function slot0.OnLine(slot0, slot1)
	slot3 = {}
	slot4 = {}

	for slot8 = 0, uv0.Distance(slot0, slot1) do
		if not slot4[tostring(HexMath.round(uv0.lerp(slot0, slot1, slot8 / slot2)))] then
			table.insert(slot3, slot9)

			slot4[tostring(slot9)] = true
		end
	end

	return slot3
end

function slot0.lerp(slot0, slot1, slot2)
	return uv0(slot0.x + (slot1.x - slot0.x) * slot2, slot0.y + (slot1.y - slot0.y) * slot2)
end

function slot0.__add(slot0, slot1)
	return uv0(slot0, slot1)
end

function slot0.__sub(slot0, slot1)
	return uv0(slot0, slot1)
end

function slot0.__mul(slot0, slot1)
	return uv0(slot0, slot1)
end

function slot0.__div(slot0, slot1)
	return uv0(slot0, slot1)
end

function slot0.__unm(slot0)
	return uv0(-slot0.x, -slot0.y)
end

function slot0.__eq(slot0, slot1)
	return slot0.x == slot1.x and slot0.y == slot1.y
end

function slot0.__tostring(slot0)
	return string.format("(%s, %s, %s)", slot0.x, slot0.y, slot0.z)
end

function slot0.__call(slot0, slot1, slot2, slot3)
	return uv0(slot1, slot2, slot3)
end

setmetatable(slot0, slot0)

slot0.Zero = slot1(0, 0)
slot0.Up = slot1(0, -1)
slot0.TopRight = slot1(1, -1)
slot0.BottomRight = slot1(1, 0)
slot0.Down = slot1(0, 1)
slot0.BottomLeft = slot1(-1, 1)
slot0.TopLeft = slot1(-1, 0)
slot0.zero = slot0.Zero
slot0.up = slot0.Up
slot0.topRight = slot0.TopRight
slot0.bottomRight = slot0.BottomRight
slot0.down = slot0.Down
slot0.bottomLeft = slot0.BottomLeft
slot0.topLeft = slot0.TopLeft

return slot0
