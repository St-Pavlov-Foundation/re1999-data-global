module("modules.logic.room.utils.pathfinding.RoomCharacterAStarFinder", package.seeall)

slot0 = class("RoomCharacterAStarFinder", BaseAStarFinder)

function slot0.ctor(slot0, slot1, slot2)
	uv0.super.ctor(slot0)

	slot0.canMoveDict = slot1
	slot0.canMoveMaskDict = slot2
end

function slot0.getConnectPointsAndCost(slot0, slot1)
	slot3 = {}

	for slot7 = 1, #slot1:getConnects() do
		table.insert(slot3, 1)
	end

	return slot2, slot3
end

function slot0.heuristic(slot0, slot1, slot2)
	return RoomAStarHelper.heuristic(slot1, slot2)
end

function slot0.isWalkable(slot0, slot1)
	slot2 = slot0.canMoveDict[slot1.x] and slot0.canMoveDict[slot1.x][slot1.y] and slot0.canMoveDict[slot1.x][slot1.y][slot1.direction]

	return slot2 and slot0.canMoveMaskDict[slot2]
end

return slot0
