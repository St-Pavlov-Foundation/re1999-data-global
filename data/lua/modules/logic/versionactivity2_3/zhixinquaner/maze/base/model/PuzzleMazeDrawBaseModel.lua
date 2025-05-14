module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.model.PuzzleMazeDrawBaseModel", package.seeall)

local var_0_0 = class("PuzzleMazeDrawBaseModel", BaseModel)

function var_0_0.reInit(arg_1_0)
	arg_1_0:release()
end

function var_0_0.release(arg_2_0)
	arg_2_0._statusMap = nil
	arg_2_0._blockMap = nil
	arg_2_0._objMap = nil
	arg_2_0._objList = nil
	arg_2_0._startX = nil
	arg_2_0._startY = nil
	arg_2_0._endX = nil
	arg_2_0._endY = nil
	arg_2_0._lineMap = nil
	arg_2_0._interactCtrlMap = nil
	arg_2_0._elementCo = nil

	arg_2_0:clear()
end

function var_0_0.startGame(arg_3_0, arg_3_1)
	arg_3_0:release()
	arg_3_0:decode(arg_3_1.param)

	arg_3_0._elementCo = arg_3_1
end

function var_0_0.decode(arg_4_0, arg_4_1)
	arg_4_0._objMap = {}
	arg_4_0._blockMap = {}
	arg_4_0._lineMap = {}
	arg_4_0._interactCtrlMap = {}

	local var_4_0 = cjson.decode(arg_4_1)

	arg_4_0._width = var_4_0.width
	arg_4_0._height = var_4_0.height
	arg_4_0._pawnIconUrl = var_4_0.pawnIconUrl

	arg_4_0:decodeObj(arg_4_0._blockMap, var_4_0.blockMap)
	arg_4_0:decodeObj(arg_4_0._objMap, var_4_0.objMap)
	arg_4_0:initMapLineState(var_4_0)
	arg_4_0:findStartAndEndPos()
	arg_4_0:initConst()
end

function var_0_0.findStartAndEndPos(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._objMap) do
		if iter_5_1.objType == PuzzleEnum.MazeObjType.Start then
			arg_5_0._startPosX = iter_5_1.x
			arg_5_0._startPosY = iter_5_1.y
		elseif iter_5_1.objType == PuzzleEnum.MazeObjType.End then
			arg_5_0._endPosX = iter_5_1.x
			arg_5_0._endPosY = iter_5_1.y
		end
	end
end

function var_0_0.decodeObj(arg_6_0, arg_6_1, arg_6_2)
	if not arg_6_2 then
		return
	end

	for iter_6_0, iter_6_1 in pairs(arg_6_2) do
		local var_6_0 = string.splitToNumber(iter_6_1.key, "_")
		local var_6_1
		local var_6_2 = #var_6_0

		if var_6_2 <= 2 then
			var_6_1 = arg_6_0:createMOByPos(var_6_0[1], var_6_0[2], iter_6_1)
		elseif var_6_2 >= 4 then
			var_6_1 = arg_6_0:createMOByLine(var_6_0[1], var_6_0[2], var_6_0[3], var_6_0[4], iter_6_1)
		end

		arg_6_1[iter_6_1.key] = var_6_1
	end
end

function var_0_0.createMOByPos(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	local var_7_0 = PuzzleMazeDrawMO.New()

	var_7_0:initByPos(arg_7_1, arg_7_2, arg_7_3.type, arg_7_3.subType, arg_7_3.group, arg_7_3.priority, arg_7_3.iconUrl, arg_7_3.effects, arg_7_3.interactLines)
	arg_7_0:addAtLast(var_7_0)

	return var_7_0
end

function var_0_0.createMOByLine(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	local var_8_0 = PuzzleMazeDrawMO.New()

	var_8_0:initByLine(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5.type, arg_8_5.subType, arg_8_5.group, arg_8_5.priority, arg_8_5.iconUrl)
	arg_8_0:addAtLast(var_8_0)

	return var_8_0
end

function var_0_0.initMapLineState(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1 and arg_9_1.blockMap

	for iter_9_0, iter_9_1 in pairs(var_9_0 or {}) do
		local var_9_1 = iter_9_1.key

		arg_9_0._lineMap[var_9_1] = PuzzleEnum.LineState.Disconnect
	end

	local var_9_2 = arg_9_1 and arg_9_1.objMap

	for iter_9_2, iter_9_3 in pairs(var_9_2 or {}) do
		if iter_9_3.interactLines then
			for iter_9_4, iter_9_5 in pairs(iter_9_3.interactLines) do
				local var_9_3 = PuzzleMazeHelper.getLineKey(iter_9_5.x1, iter_9_5.y1, iter_9_5.x2, iter_9_5.y2)

				arg_9_0._lineMap[var_9_3] = PuzzleEnum.LineState.Switch_Off
				arg_9_0._interactCtrlMap[var_9_3] = iter_9_3
			end
		end
	end
end

function var_0_0.initConst(arg_10_0)
	local var_10_0, var_10_1 = arg_10_0:getGameSize()

	arg_10_0._startX = -var_10_0 * 0.5 - 0.5
	arg_10_0._startY = -var_10_1 * 0.5 - 0.5
end

function var_0_0.getStartPoint(arg_11_0)
	return arg_11_0._startPosX, arg_11_0._startPosY
end

function var_0_0.getEndPoint(arg_12_0)
	return arg_12_0._endPosX, arg_12_0._endPosY
end

function var_0_0.getElementCo(arg_13_0)
	return arg_13_0._elementCo
end

function var_0_0.setGameStatus(arg_14_0, arg_14_1)
	if arg_14_0._elementCo then
		arg_14_0._statusMap = arg_14_0._statusMap or {}
		arg_14_0._statusMap[arg_14_0._elementCo.id] = arg_14_1
	end
end

function var_0_0.getClearStatus(arg_15_0, arg_15_1)
	if arg_15_0._statusMap and arg_15_0._statusMap[arg_15_1] then
		return true
	end

	return false
end

function var_0_0.getObjAtPos(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = PuzzleMazeHelper.getPosKey(arg_16_1, arg_16_2)

	return arg_16_0._objMap[var_16_0]
end

function var_0_0.getObjAtLine(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = PuzzleMazeHelper.getLineKey(arg_17_1, arg_17_2, arg_17_3, arg_17_4)

	return arg_17_0._blockMap[var_17_0]
end

function var_0_0.getObjByLineKey(arg_18_0, arg_18_1)
	return arg_18_0._blockMap[arg_18_1]
end

function var_0_0.getGameSize(arg_19_0)
	return arg_19_0._width or 0, arg_19_0._height or 0
end

function var_0_0.getUIGridSize(arg_20_0)
	return PuzzleEnum.mazeUIGridWidth, PuzzleEnum.mazeUIGridHeight
end

function var_0_0.getObjectAnchor(arg_21_0, arg_21_1, arg_21_2)
	return arg_21_0:getGridCenterPos(arg_21_1 - 0.5, arg_21_2 - 0.5)
end

function var_0_0.getLineObjectAnchor(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0 = arg_22_1
	local var_22_1 = arg_22_2
	local var_22_2 = var_22_0 + (arg_22_3 - arg_22_1) * 0.5 - 0.5
	local var_22_3 = var_22_1 + (arg_22_2 - arg_22_2) * 0.5

	if arg_22_2 == arg_22_4 then
		var_22_3 = var_22_3 - 0.5
	end

	return arg_22_0:getGridCenterPos(var_22_2, var_22_3)
end

function var_0_0.getLineAnchor(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = arg_23_1
	local var_23_1 = arg_23_2
	local var_23_2 = var_23_0 + (arg_23_3 - arg_23_1) * 0.5 - 0.5
	local var_23_3 = var_23_1 + (arg_23_2 - arg_23_2) * 0.5

	if arg_23_2 == arg_23_4 then
		var_23_3 = var_23_3 - 0.5
	end

	return arg_23_0:getGridCenterPos(var_23_2, var_23_3)
end

function var_0_0.getGridCenterPos(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0, var_24_1 = arg_24_0:getUIGridSize()

	return (arg_24_0._startX + arg_24_1) * var_24_0, (arg_24_0._startY + arg_24_2) * var_24_1
end

function var_0_0.getIntegerPosByTouchPos(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0, var_25_1 = arg_25_0:getUIGridSize()
	local var_25_2 = math.floor((arg_25_1 - (arg_25_0._startX + 0.5) * var_25_0) / var_25_0)
	local var_25_3 = math.floor((arg_25_2 - (arg_25_0._startY + 0.5) * var_25_1) / var_25_1)
	local var_25_4, var_25_5 = arg_25_0:getGameSize()
	local var_25_6 = -1
	local var_25_7 = -1
	local var_25_8 = PuzzleEnum.mazeUILineWidth * 0.5

	if var_25_2 >= 0 and var_25_2 < var_25_4 and var_25_3 >= 0 and var_25_3 < var_25_5 then
		var_25_6, var_25_7 = var_25_2 + 1, var_25_3 + 1
	else
		local var_25_9 = var_25_2 >= 0 and var_25_2 < var_25_4 and var_25_2 + 1 or -1
		local var_25_10 = var_25_3 >= 0 and var_25_3 < var_25_5 and var_25_3 + 1 or -1
		local var_25_11 = arg_25_1 - (arg_25_0._startX + 0.5) * var_25_0
		local var_25_12 = arg_25_2 - (arg_25_0._startY + 0.5) * var_25_1

		if var_25_2 < 0 and var_25_11 > -var_25_8 then
			var_25_9 = 1
		elseif var_25_4 <= var_25_2 and var_25_11 < var_25_4 * var_25_0 + arg_25_0._startX + var_25_8 then
			var_25_9 = var_25_4
		end

		if var_25_3 < 0 and var_25_12 > -var_25_8 then
			var_25_10 = 1
		elseif var_25_5 <= var_25_3 and var_25_12 < var_25_5 * var_25_1 + arg_25_0._startY + var_25_8 then
			var_25_10 = var_25_5
		end

		if var_25_9 ~= -1 and var_25_10 ~= -1 then
			var_25_6, var_25_7 = var_25_9, var_25_10
		end
	end

	return var_25_6, var_25_7
end

function var_0_0.getClosePosByTouchPos(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0, var_26_1 = arg_26_0:getUIGridSize()
	local var_26_2, var_26_3 = arg_26_0:getIntegerPosByTouchPos(arg_26_1, arg_26_2)

	if var_26_2 ~= -1 then
		local var_26_4 = PuzzleEnum.mazeUILineWidth * 0.5
		local var_26_5 = arg_26_1 - (arg_26_0._startX + 0.5) * var_26_0
		local var_26_6 = (var_26_2 - 1) * var_26_0
		local var_26_7 = false

		if var_26_5 >= var_26_6 + var_26_4 then
			if var_26_5 >= var_26_6 + (var_26_0 - var_26_4) then
				var_26_2 = var_26_2 + 1
			else
				var_26_7 = true
			end
		end

		local var_26_8 = arg_26_2 - (arg_26_0._startY + 0.5) * var_26_1
		local var_26_9 = (var_26_3 - 1) * var_26_1
		local var_26_10 = false

		if var_26_8 >= var_26_9 + var_26_4 then
			if var_26_8 >= var_26_9 + (var_26_1 - var_26_4) then
				var_26_3 = var_26_3 + 1
			else
				var_26_10 = true
			end
		end

		if var_26_7 or var_26_10 then
			return -1, -1
		end
	end

	return var_26_2, var_26_3
end

function var_0_0.getLineFieldByTouchPos(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0, var_27_1 = arg_27_0:getUIGridSize()
	local var_27_2, var_27_3 = arg_27_0:getIntegerPosByTouchPos(arg_27_1, arg_27_2)
	local var_27_4 = var_27_2
	local var_27_5 = var_27_3
	local var_27_6
	local var_27_7

	if var_27_2 ~= -1 then
		local var_27_8 = PuzzleEnum.mazeUILineWidth * 0.5
		local var_27_9 = (var_27_2 - 1) * var_27_0
		local var_27_10 = arg_27_1 - (arg_27_0._startX + 0.5) * var_27_0
		local var_27_11 = false

		if var_27_10 >= var_27_9 + var_27_8 then
			var_27_4 = var_27_4 + 1

			if var_27_10 < var_27_9 + (var_27_0 - var_27_8) then
				var_27_11 = true
				var_27_6 = (var_27_10 - var_27_9) / var_27_0
			else
				var_27_2 = var_27_2 + 1
			end
		end

		local var_27_12 = (var_27_3 - 1) * var_27_1
		local var_27_13 = arg_27_2 - (arg_27_0._startY + 0.5) * var_27_1
		local var_27_14 = false

		if var_27_13 >= var_27_12 + var_27_8 then
			var_27_5 = var_27_5 + 1

			if var_27_13 < var_27_12 + (var_27_1 - var_27_8) then
				var_27_14 = true
				var_27_7 = (var_27_13 - var_27_12) / var_27_1
			else
				var_27_3 = var_27_3 + 1
			end
		end

		if not var_27_11 or not var_27_14 then
			return true, var_27_2, var_27_3, var_27_4, var_27_5, var_27_6, var_27_7
		end
	end

	return false
end

function var_0_0.getMapLineState(arg_28_0, arg_28_1, arg_28_2, arg_28_3, arg_28_4)
	local var_28_0 = PuzzleMazeHelper.getLineKey(arg_28_1, arg_28_2, arg_28_3, arg_28_4)

	return arg_28_0._lineMap and arg_28_0._lineMap[var_28_0]
end

function var_0_0.getAllMapLines(arg_29_0)
	return arg_29_0._lineMap
end

function var_0_0.getInteractLineCtrl(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4)
	local var_30_0 = PuzzleMazeHelper.getLineKey(arg_30_1, arg_30_2, arg_30_3, arg_30_4)

	return arg_30_0._interactCtrlMap and arg_30_0._interactCtrlMap[var_30_0]
end

function var_0_0.pawnIconUrl(arg_31_0)
	return arg_31_0._pawnIconUrl
end

function var_0_0.setMapLineState(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4, arg_32_5)
	local var_32_0 = PuzzleMazeHelper.getLineKey(arg_32_1, arg_32_2, arg_32_3, arg_32_4)

	arg_32_0._lineMap[var_32_0] = arg_32_5
end

var_0_0.instance = var_0_0.New()

return var_0_0
