module("modules.logic.versionactivity3_0.karong.model.KaRongDrawMO", package.seeall)

local var_0_0 = pureTable("KaRongDrawMO")

function var_0_0.initByPos(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5, arg_1_6, arg_1_7, arg_1_8, arg_1_9)
	arg_1_0.key = PuzzleMazeHelper.getPosKey(arg_1_1, arg_1_2)
	arg_1_0.x, arg_1_0.y = arg_1_1, arg_1_2
	arg_1_0.objType = arg_1_3
	arg_1_0.subType = arg_1_4 or 1
	arg_1_0.group = arg_1_5 or 0
	arg_1_0.priority = arg_1_6 or 0
	arg_1_0.iconUrl = arg_1_7
	arg_1_0.effects = arg_1_8
	arg_1_0.interactLines = arg_1_9
	arg_1_0.positionType = KaRongDrawEnum.PositionType.Point
	arg_1_0.obstacle = arg_1_3 == KaRongDrawEnum.MazeObjType.Block
end

function var_0_0.initByLine(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5, arg_2_6, arg_2_7, arg_2_8, arg_2_9)
	arg_2_0.key = PuzzleMazeHelper.getLineKey(arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	arg_2_0.x1, arg_2_0.y1, arg_2_0.x2, arg_2_0.y2 = arg_2_1, arg_2_2, arg_2_3, arg_2_4
	arg_2_0.objType = arg_2_5
	arg_2_0.subType = arg_2_6 or 1
	arg_2_0.group = arg_2_7 or 0
	arg_2_0.priority = arg_2_8 or 0
	arg_2_0.iconUrl = arg_2_9
	arg_2_0.positionType = KaRongDrawEnum.PositionType.Line
end

function var_0_0.removeObstacle(arg_3_0)
	if arg_3_0.objType ~= KaRongDrawEnum.MazeObjType.Block then
		logError("该类型不可以使用removeObstacle方法" .. arg_3_0.objType)

		return
	end

	arg_3_0.obstacle = false
end

return var_0_0
