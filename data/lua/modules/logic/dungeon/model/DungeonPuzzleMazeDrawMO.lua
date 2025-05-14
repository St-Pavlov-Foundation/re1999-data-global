module("modules.logic.dungeon.model.DungeonPuzzleMazeDrawMO", package.seeall)

local var_0_0 = pureTable("DungeonPuzzleMazeDrawMO")

function var_0_0.initByPos(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.x, arg_1_0.y = arg_1_1, arg_1_2
	arg_1_0.objType = arg_1_3
	arg_1_0.val = arg_1_4 or 0
	arg_1_0.isPos = true
end

function var_0_0.initByLine(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6)
	arg_2_0.x1, arg_2_0.y1, arg_2_0.x2, arg_2_0.y2 = arg_2_1, arg_2_2, arg_2_3, arg_2_4
	arg_2_0.objType = arg_2_5
	arg_2_0.val = arg_2_6 or 0
	arg_2_0.isPos = false
end

return var_0_0
