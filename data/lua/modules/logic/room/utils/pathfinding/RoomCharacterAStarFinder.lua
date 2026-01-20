-- chunkname: @modules/logic/room/utils/pathfinding/RoomCharacterAStarFinder.lua

module("modules.logic.room.utils.pathfinding.RoomCharacterAStarFinder", package.seeall)

local RoomCharacterAStarFinder = class("RoomCharacterAStarFinder", BaseAStarFinder)

function RoomCharacterAStarFinder:ctor(canMoveDict, canMoveMaskDict)
	RoomCharacterAStarFinder.super.ctor(self)

	self.canMoveDict = canMoveDict
	self.canMoveMaskDict = canMoveMaskDict
end

function RoomCharacterAStarFinder:getConnectPointsAndCost(point)
	local connectPoints = point:getConnects()
	local connectCosts = {}

	for i = 1, #connectPoints do
		table.insert(connectCosts, 1)
	end

	return connectPoints, connectCosts
end

function RoomCharacterAStarFinder:heuristic(point, targetPoint)
	return RoomAStarHelper.heuristic(point, targetPoint)
end

function RoomCharacterAStarFinder:isWalkable(point)
	local canMove = self.canMoveDict[point.x] and self.canMoveDict[point.x][point.y] and self.canMoveDict[point.x][point.y][point.direction]

	canMove = canMove and self.canMoveMaskDict[canMove]

	return canMove
end

return RoomCharacterAStarFinder
