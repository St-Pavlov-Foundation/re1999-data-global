module("modules.logic.explore.utils.ExploreAStarFindRoute", package.seeall)

slot0 = class("ExploreAStarFindRoute")
slot1 = {
	{
		-1,
		0
	},
	{
		0,
		-1
	},
	{
		0,
		1
	},
	{
		1,
		0
	}
}
slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9, slot10, slot11, slot12, slot13 = nil

function slot14(slot0)
	return string.format("%d_%d", slot0.x, slot0.y)
end

function slot15(slot0, slot1)
	slot2 = {
		x = slot0,
		y = slot1,
		last = nil,
		g = 0,
		h = 0,
		f = 0,
		key = uv0(slot2),
		fromDir = nil
	}

	return slot2
end

function slot16(slot0, slot1)
	return math.abs(slot1.x - slot0.x) + math.abs(slot1.y - slot0.y)
end

function slot17(slot0, slot1)
	return slot0.x == slot1.x and slot0.y == slot1.y
end

function slot18(slot0, slot1)
	return slot1[slot0.key]
end

function slot19(slot0)
	return slot0.g + 1
end

function slot20(slot0, slot1)
	return uv0(slot0, slot1)
end

function slot21(slot0)
	return slot0.g + slot0.h
end

function slot22(slot0, slot1, slot2)
	assert(slot0.x <= slot1 and slot0.y <= slot2, string.format("point error, (%d, %d) limit(%d, %d)", slot0.x, slot0.y, slot1, slot2))
end

function slot23(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0 or {}) do
		uv0(slot7, slot1, slot2)
	end
end

function slot24(slot0, slot1)
	if slot0.f == slot1.f and slot0.last == slot1.last then
		if uv0 then
			if ExploreHelper.isPosEqual(slot0, uv0) then
				return true
			elseif ExploreHelper.isPosEqual(slot1, uv0) then
				return false
			end
		end

		return (slot0.last and slot0.fromDir == slot0.last.fromDir and -1 or 1) < (slot1.last and slot1.fromDir == slot1.last.fromDir and -1 or 1)
	end

	return slot0.f < slot1.f
end

function slot0.ctor(slot0)
end

function slot0.startFindPath(slot0, slot1, slot2, slot3, slot4)
	uv0 = slot1
	uv1 = uv2(slot2.x, slot2.y)
	uv3 = uv2(slot3.x, slot3.y)
	uv4 = slot4
	uv5 = uv2(slot2.x, slot2.y)
	uv6 = {}
	uv7 = {}
	uv8 = {}
	uv9 = {}
	uv6[uv1.key] = uv1

	table.insert(uv7, uv1)

	uv10 = slot0:findPath() or {}

	return uv10, uv5
end

function slot0.getNextPoints(slot0, slot1)
	slot2 = {}

	for slot6 = 1, #uv0 do
		slot7 = uv0[slot6]
		slot8 = uv1(slot1.x + slot7[1], slot1.y + slot7[2])
		slot8.fromDir = slot7
		slot8.last = slot1

		if uv2(slot8, uv3) then
			slot8.g = uv4(slot1)
			slot8.h = uv5(slot1, uv6)
			slot8.f = uv7(slot8)

			table.insert(slot2, slot8)
		end
	end

	return slot2
end

function slot0.findPath(slot0)
	while #uv0 > 0 do
		uv1 = uv0[1]

		if slot0:getDistance(uv1, uv2) < slot0:getDistance(uv3, uv2) then
			uv3 = uv4(uv1.x, uv1.y)
		end

		table.remove(uv0, 1)

		uv5[uv1.key] = nil

		if uv6(uv1, uv2) then
			return slot0:makePath(uv1)
		else
			uv7[uv1.key] = uv1

			for slot5 = 1, #slot0:getNextPoints(uv1) do
				if uv5[slot1[slot5].key] == nil and uv7[slot6.key] == nil and uv8(slot6, uv9) then
					uv5[slot6.key] = slot6

					table.insert(uv0, slot6)
				end
			end

			table.sort(uv0, uv10)
		end
	end

	return nil
end

function slot0.makePath(slot0, slot1)
	slot2 = {}
	slot3 = slot1

	while slot3.last ~= nil do
		table.insert(slot2, slot3)

		slot3 = slot3.last
	end

	slot4 = slot3

	return slot2
end

function slot0.getDistance(slot0, slot1, slot2)
	return math.abs(slot1.x - slot2.x) + math.abs(slot1.y - slot2.y)
end

return slot0
