module("modules.logic.versionactivity2_3.zhixinquaner.maze.model.PuzzleMazeDrawMO", package.seeall)

local var_0_0 = pureTable("PuzzleMazeDrawMO")

function var_0_0.initByPos(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7, arg_1_8, arg_1_9)
	arg_1_0.x, arg_1_0.y = arg_1_1, arg_1_2
	arg_1_0.objType = arg_1_3
	arg_1_0.subType = arg_1_4 or 0
	arg_1_0.group = arg_1_5 or 0
	arg_1_0.priority = arg_1_6 or 0
	arg_1_0.iconUrl = arg_1_7
	arg_1_0.effects = arg_1_8
	arg_1_0.interactLines = arg_1_9
	arg_1_0.positionType = PuzzleEnum.PositionType.Point
end

function var_0_0.initByLine(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7, arg_2_8, arg_2_9)
	arg_2_0.x1, arg_2_0.y1, arg_2_0.x2, arg_2_0.y2 = arg_2_1, arg_2_2, arg_2_3, arg_2_4
	arg_2_0.objType = arg_2_5
	arg_2_0.subType = arg_2_6 or 0
	arg_2_0.group = arg_2_7 or 0
	arg_2_0.priority = arg_2_8 or 0
	arg_2_0.iconUrl = arg_2_9
	arg_2_0.positionType = PuzzleEnum.PositionType.Line
end

function var_0_0.getKey(arg_3_0)
	local var_3_0 = ""

	if arg_3_0.positionType == PuzzleEnum.PositionType.Point then
		var_3_0 = PuzzleMazeHelper.getPosKey(arg_3_0.x, arg_3_0.y)
	else
		var_3_0 = PuzzleMazeHelper.getLineKey(arg_3_0.x1, arg_3_0.y1, arg_3_0.x2, arg_3_0.y2)
	end

	return var_3_0
end

return var_0_0
