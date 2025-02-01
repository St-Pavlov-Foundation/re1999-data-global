module("modules.logic.room.utils.pathfinding.BaseAStarFinder", package.seeall)

slot0 = class("BaseAStarFinder")

function slot0.ctor(slot0)
end

function slot0.pathFinding(slot0, slot1, slot2)
	if slot1 == slot2 then
		return {}
	end

	if not slot0:isWalkable(slot1) or not slot0:isWalkable(slot2) then
		return nil
	end

	slot5 = {
		cost = 0,
		point = slot1,
		heuristic = slot0:heuristic(slot1, slot2)
	}

	return slot0:_pathFinding(slot1, slot2, {
		[tostring(slot5.point)] = slot5
	}, {})
end

function slot0._pathFinding(slot0, slot1, slot2, slot3, slot4)
	while LuaUtil.tableNotEmpty(slot3) do
		slot7, slot8 = slot0:getConnectPointsAndCost(slot0:_getNextNode(slot3).point)

		for slot12 = 1, #slot7 do
			slot14 = slot8[slot12] or 0

			if not slot4[tostring(slot7[slot12])] and slot0:isWalkable(slot13) then
				if not slot3[tostring(slot13)] or slot5.cost + slot14 < slot16.cost then
					slot16 = {
						point = slot13,
						cost = slot5.cost + slot14,
						heuristic = slot0:heuristic(slot13, slot2),
						last = slot5
					}
					slot3[tostring(slot16.point)] = slot16
				end

				if slot16.point == slot2 then
					return slot0:_makePath(slot16)
				end
			end
		end

		slot4[tostring(slot5.point)] = slot5
	end

	return nil
end

function slot0._getNextNode(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in pairs(slot1) do
		if not slot2 or slot7.cost + slot7.heuristic < slot2.cost + slot2.heuristic then
			slot2 = slot7
		end
	end

	slot1[tostring(slot2.point)] = nil

	return slot2
end

function slot0._makePath(slot0, slot1)
	slot2 = {}
	slot3 = slot1

	while slot3.last ~= nil do
		table.insert(slot2, slot3.point)

		slot3 = slot3.last
	end

	slot4 = {}

	for slot8 = #slot2, 1, -1 do
		table.insert(slot4, slot2[slot8])
	end

	return slot4
end

function slot0.getConnectPointsAndCost(slot0, slot1)
end

function slot0.heuristic(slot0, slot1, slot2)
end

function slot0.isWalkable(slot0, slot1)
end

return slot0
