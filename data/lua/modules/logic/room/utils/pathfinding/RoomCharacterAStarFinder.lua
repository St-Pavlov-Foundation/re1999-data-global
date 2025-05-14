module("modules.logic.room.utils.pathfinding.RoomCharacterAStarFinder", package.seeall)

local var_0_0 = class("RoomCharacterAStarFinder", BaseAStarFinder)

function var_0_0.ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.ctor(arg_1_0)

	arg_1_0.canMoveDict = arg_1_1
	arg_1_0.canMoveMaskDict = arg_1_2
end

function var_0_0.getConnectPointsAndCost(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1:getConnects()
	local var_2_1 = {}

	for iter_2_0 = 1, #var_2_0 do
		table.insert(var_2_1, 1)
	end

	return var_2_0, var_2_1
end

function var_0_0.heuristic(arg_3_0, arg_3_1, arg_3_2)
	return RoomAStarHelper.heuristic(arg_3_1, arg_3_2)
end

function var_0_0.isWalkable(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.canMoveDict[arg_4_1.x] and arg_4_0.canMoveDict[arg_4_1.x][arg_4_1.y] and arg_4_0.canMoveDict[arg_4_1.x][arg_4_1.y][arg_4_1.direction]

	var_4_0 = var_4_0 and arg_4_0.canMoveMaskDict[var_4_0]

	return var_4_0
end

return var_0_0
