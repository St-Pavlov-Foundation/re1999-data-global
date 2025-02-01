module("modules.logic.room.utils.hex.ResourcePoint", package.seeall)

slot0 = {
	New = function (slot0, slot1)
		slot2 = nil

		if slot0 and slot1 then
			slot2 = {
				hexPoint = slot0,
				direction = slot1
			}
		elseif slot0 then
			slot3 = slot0
			slot2 = {
				hexPoint = HexPoint(slot3.x, slot3.y),
				direction = slot3.direction
			}
		end

		setmetatable(slot2, uv0)

		return slot2
	end
}
slot0.new = slot0.New
slot1 = slot0.New
slot2 = {
	x = function (slot0)
		return slot0.hexPoint.x
	end,
	y = function (slot0)
		return slot0.hexPoint.y
	end,
	z = function (slot0)
		return slot0.hexPoint.z
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

function slot0.Add(slot0, slot1)
	return uv0(slot0.hexPoint, RoomRotateHelper.rotateDirection(slot0.direction, slot1))
end

slot0.add = slot0.Add
slot3 = slot0.Add

function slot0.Sub(slot0, slot1)
	return uv0(slot0.hexPoint, RoomRotateHelper.rotateDirection(slot0.direction, -slot1))
end

slot0.sub = slot0.Sub
slot4 = slot0.Sub

function slot0.Connects(slot0)
	slot1 = {}

	if slot0.direction == 0 then
		for slot5 = 1, 6 do
			table.insert(slot1, uv0(slot0.hexPoint, slot5))
		end
	else
		table.insert(slot1, uv0(slot0.hexPoint, 0))
		table.insert(slot1, slot0 + 1)
		table.insert(slot1, slot0 - 1)
		table.insert(slot1, uv0(slot0.hexPoint:GetNeighbor(slot0.direction), RoomRotateHelper.oppositeDirection(slot0.direction)))
	end

	return slot1
end

slot0.connects = slot0.Connects
slot0.getConnects = slot0.Connects
slot0.GetConnects = slot0.Connects

function slot0.ConnectsAll(slot0)
	for slot5 = 0, 6 do
		if slot0.direction ~= slot5 then
			table.insert({}, uv0(slot0.hexPoint, slot5))
		end
	end

	if slot0.direction ~= 0 then
		table.insert(slot1, uv0(slot0.hexPoint:GetNeighbor(slot0.direction), RoomRotateHelper.oppositeDirection(slot0.direction)))
	end

	return slot1
end

slot0.connectsAll = slot0.ConnectsAll
slot0.getConnectsAll = slot0.ConnectsAll
slot0.GetConnectsAll = slot0.ConnectsAll

function slot0.__add(slot0, slot1)
	return uv0(slot0, slot1)
end

function slot0.__sub(slot0, slot1)
	return uv0(slot0, slot1)
end

function slot0.__unm(slot0)
	return uv0(slot0.hexPoint, RoomRotateHelper.oppositeDirection(slot0.direction))
end

function slot0.__eq(slot0, slot1)
	return slot0.hexPoint == slot1.hexPoint and slot0.direction == slot1.direction
end

function slot0.__tostring(slot0)
	return string.format("(x: %s, y: %s, direction: %s)", slot0.x, slot0.y, slot0.direction)
end

function slot0.__call(slot0, slot1, slot2)
	return uv0(slot1, slot2)
end

setmetatable(slot0, slot0)

return slot0
