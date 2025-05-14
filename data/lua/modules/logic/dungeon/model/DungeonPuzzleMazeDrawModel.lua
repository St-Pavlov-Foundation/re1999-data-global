module("modules.logic.dungeon.model.DungeonPuzzleMazeDrawModel", package.seeall)

local var_0_0 = class("DungeonPuzzleMazeDrawModel", BaseModel)

function var_0_0.reInit(arg_1_0)
	arg_1_0:release()

	arg_1_0._clearMap = nil
end

function var_0_0.release(arg_2_0)
	arg_2_0._blockMap = nil
	arg_2_0._objMap = nil
	arg_2_0._objList = nil
	arg_2_0._startX = nil
	arg_2_0._startY = nil
	arg_2_0._endX = nil
	arg_2_0._endY = nil

	arg_2_0:clear()
end

function var_0_0.initByElementCo(arg_3_0, arg_3_1)
	arg_3_0._cfgElement = arg_3_1

	arg_3_0:initData(arg_3_0._cfgElement.param)
end

function var_0_0.initData(arg_4_0, arg_4_1)
	arg_4_0:release()
	arg_4_0:initConst()

	arg_4_0._objMap = {}
	arg_4_0._blockMap = {}

	arg_4_0:decode(arg_4_1)
end

function var_0_0.decode(arg_5_0, arg_5_1)
	if string.nilorempty(arg_5_1) then
		return
	end

	local var_5_0 = string.split(arg_5_1, ",")
	local var_5_1 = 1
	local var_5_2 = arg_5_0:decodeObjMap(arg_5_0._blockMap, var_5_0, var_5_1)
	local var_5_3 = arg_5_0:decodeObjMap(arg_5_0._objMap, var_5_0, var_5_2)

	for iter_5_0, iter_5_1 in pairs(arg_5_0._objMap) do
		if iter_5_1.objType == DungeonPuzzleEnum.MazeObjType.Start then
			local var_5_4 = string.splitToNumber(iter_5_0, "_")

			arg_5_0._startPosX = var_5_4[1]
			arg_5_0._startPosY = var_5_4[2]
		elseif iter_5_1.objType == DungeonPuzzleEnum.MazeObjType.End then
			local var_5_5 = string.splitToNumber(iter_5_0, "_")

			arg_5_0._endPosX = var_5_5[1]
			arg_5_0._endPosY = var_5_5[2]
		end
	end
end

function var_0_0.decodeObjMap(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_2[arg_6_3] and tonumber(arg_6_2[arg_6_3]) or 0

	if var_6_0 > 0 then
		arg_6_3 = arg_6_3 + 1

		for iter_6_0 = 1, var_6_0 do
			local var_6_1 = arg_6_2[arg_6_3]
			local var_6_2 = tonumber(arg_6_2[arg_6_3 + 1])
			local var_6_3 = tonumber(arg_6_2[arg_6_3 + 2])
			local var_6_4 = string.splitToNumber(var_6_1, "_")
			local var_6_5
			local var_6_6 = #var_6_4

			if var_6_6 <= 2 then
				var_6_5 = arg_6_0:createMOByPos(var_6_4[1], var_6_4[2], var_6_2, var_6_3)
			elseif var_6_6 >= 4 then
				var_6_5 = arg_6_0:createMOByLine(var_6_4[1], var_6_4[2], var_6_4[3], var_6_4[4], var_6_2, var_6_3)
			end

			arg_6_1[arg_6_2[arg_6_3]] = var_6_5
			arg_6_3 = arg_6_3 + 3
		end
	end

	return arg_6_3
end

function var_0_0.createMOByPos(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	local var_7_0 = DungeonPuzzleMazeDrawMO.New()

	var_7_0:initByPos(arg_7_1, arg_7_2, arg_7_3, arg_7_4)
	arg_7_0:addAtLast(var_7_0)

	return var_7_0
end

function var_0_0.createMOByLine(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
	local var_8_0 = DungeonPuzzleMazeDrawMO.New()

	var_8_0:initByLine(arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5, arg_8_6)
	arg_8_0:addAtLast(var_8_0)

	return var_8_0
end

function var_0_0.initConst(arg_9_0)
	local var_9_0, var_9_1 = arg_9_0:getGameSize()

	arg_9_0._startX = -var_9_0 * 0.5 - 0.5
	arg_9_0._startY = -var_9_1 * 0.5 - 0.5
end

function var_0_0.getStartPoint(arg_10_0)
	return arg_10_0._startPosX, arg_10_0._startPosY
end

function var_0_0.getEndPoint(arg_11_0)
	return arg_11_0._endPosX, arg_11_0._endPosY
end

function var_0_0.getElementCo(arg_12_0)
	return arg_12_0._cfgElement
end

function var_0_0.setClearStatus(arg_13_0, arg_13_1)
	if arg_13_0._cfgElement then
		arg_13_0._clearMap = arg_13_0._clearMap or {}
		arg_13_0._clearMap[arg_13_0._cfgElement.id] = arg_13_1
	end
end

function var_0_0.getClearStatus(arg_14_0, arg_14_1)
	if arg_14_0._clearMap and arg_14_0._clearMap[arg_14_1] then
		return true
	end

	return false
end

function var_0_0.getObjAtPos(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.getPosKey(arg_15_1, arg_15_2)

	return arg_15_0._objMap[var_15_0]
end

function var_0_0.getObjAtLine(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = arg_16_0.getLineKey(arg_16_1, arg_16_2, arg_16_3, arg_16_4)

	return arg_16_0._blockMap[var_16_0]
end

function var_0_0.getObjByLineKey(arg_17_0, arg_17_1)
	return arg_17_0._blockMap[arg_17_1]
end

function var_0_0.getGameSize(arg_18_0)
	return DungeonPuzzleEnum.mazeDrawWidth, DungeonPuzzleEnum.mazeDrawHeight
end

function var_0_0.getUIGridSize(arg_19_0)
	return DungeonPuzzleEnum.mazeUIGridWidth, DungeonPuzzleEnum.mazeUIGridHeight
end

function var_0_0.getObjectAnchor(arg_20_0, arg_20_1, arg_20_2)
	return arg_20_0:getGridCenterPos(arg_20_1 - 0.5, arg_20_2 - 0.5)
end

function var_0_0.getLineObjectAnchor(arg_21_0, arg_21_1, arg_21_2, arg_21_3, arg_21_4)
	local var_21_0 = arg_21_1
	local var_21_1 = arg_21_2
	local var_21_2 = var_21_0 + (arg_21_3 - arg_21_1) * 0.5 - 0.5
	local var_21_3 = var_21_1 + (arg_21_2 - arg_21_2) * 0.5

	if arg_21_2 == arg_21_4 then
		var_21_3 = var_21_3 - 0.5
	end

	return arg_21_0:getGridCenterPos(var_21_2, var_21_3)
end

function var_0_0.getLineAnchor(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	local var_22_0 = arg_22_1
	local var_22_1 = arg_22_2
	local var_22_2 = var_22_0 + (arg_22_3 - arg_22_1) * 0.5 - 0.5
	local var_22_3 = var_22_1 + (arg_22_2 - arg_22_2) * 0.5

	if arg_22_2 == arg_22_4 then
		var_22_3 = var_22_3 - 0.5
	end

	return arg_22_0:getGridCenterPos(var_22_2, var_22_3)
end

function var_0_0.getGridCenterPos(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0, var_23_1 = arg_23_0:getUIGridSize()

	return (arg_23_0._startX + arg_23_1) * var_23_0, (arg_23_0._startY + arg_23_2) * var_23_1
end

function var_0_0.getIntegerPosByTouchPos(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0, var_24_1 = arg_24_0:getUIGridSize()
	local var_24_2 = math.floor((arg_24_1 - (arg_24_0._startX + 0.5) * var_24_0) / var_24_0)
	local var_24_3 = math.floor((arg_24_2 - (arg_24_0._startY + 0.5) * var_24_1) / var_24_1)
	local var_24_4, var_24_5 = arg_24_0:getGameSize()
	local var_24_6 = -1
	local var_24_7 = -1
	local var_24_8 = DungeonPuzzleEnum.mazeUILineWidth * 0.5

	if var_24_2 >= 0 and var_24_2 < var_24_4 and var_24_3 >= 0 and var_24_3 < var_24_5 then
		var_24_6, var_24_7 = var_24_2 + 1, var_24_3 + 1
	else
		local var_24_9 = var_24_2 >= 0 and var_24_2 < var_24_4 and var_24_2 + 1 or -1
		local var_24_10 = var_24_3 >= 0 and var_24_3 < var_24_5 and var_24_3 + 1 or -1
		local var_24_11 = arg_24_1 - (arg_24_0._startX + 0.5) * var_24_0
		local var_24_12 = arg_24_2 - (arg_24_0._startY + 0.5) * var_24_1

		if var_24_2 < 0 and var_24_11 > -var_24_8 then
			var_24_9 = 1
		elseif var_24_4 <= var_24_2 and var_24_11 < var_24_4 * var_24_0 + arg_24_0._startX + var_24_8 then
			var_24_9 = var_24_4
		end

		if var_24_3 < 0 and var_24_12 > -var_24_8 then
			var_24_10 = 1
		elseif var_24_5 <= var_24_3 and var_24_12 < var_24_5 * var_24_1 + arg_24_0._startY + var_24_8 then
			var_24_10 = var_24_5
		end

		if var_24_9 ~= -1 and var_24_10 ~= -1 then
			var_24_6, var_24_7 = var_24_9, var_24_10
		end
	end

	return var_24_6, var_24_7
end

function var_0_0.getClosePosByTouchPos(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0, var_25_1 = arg_25_0:getUIGridSize()
	local var_25_2, var_25_3 = arg_25_0:getIntegerPosByTouchPos(arg_25_1, arg_25_2)

	if var_25_2 ~= -1 then
		local var_25_4 = DungeonPuzzleEnum.mazeUILineWidth * 0.5
		local var_25_5 = arg_25_1 - (arg_25_0._startX + 0.5) * var_25_0
		local var_25_6 = (var_25_2 - 1) * var_25_0
		local var_25_7 = false

		if var_25_5 >= var_25_6 + var_25_4 then
			if var_25_5 >= var_25_6 + (var_25_0 - var_25_4) then
				var_25_2 = var_25_2 + 1
			else
				var_25_7 = true
			end
		end

		local var_25_8 = arg_25_2 - (arg_25_0._startY + 0.5) * var_25_1
		local var_25_9 = (var_25_3 - 1) * var_25_1
		local var_25_10 = false

		if var_25_8 >= var_25_9 + var_25_4 then
			if var_25_8 >= var_25_9 + (var_25_1 - var_25_4) then
				var_25_3 = var_25_3 + 1
			else
				var_25_10 = true
			end
		end

		if var_25_7 or var_25_10 then
			return -1, -1
		end
	end

	return var_25_2, var_25_3
end

function var_0_0.getLineFieldByTouchPos(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0, var_26_1 = arg_26_0:getUIGridSize()
	local var_26_2, var_26_3 = arg_26_0:getIntegerPosByTouchPos(arg_26_1, arg_26_2)
	local var_26_4 = var_26_2
	local var_26_5 = var_26_3
	local var_26_6 = var_26_2
	local var_26_7 = var_26_3
	local var_26_8
	local var_26_9

	if var_26_2 ~= -1 then
		local var_26_10 = DungeonPuzzleEnum.mazeUILineWidth * 0.5
		local var_26_11 = (var_26_2 - 1) * var_26_0
		local var_26_12 = arg_26_1 - (arg_26_0._startX + 0.5) * var_26_0
		local var_26_13 = false

		if var_26_12 >= var_26_11 + var_26_10 then
			var_26_4 = var_26_4 + 1

			if var_26_12 < var_26_11 + (var_26_0 - var_26_10) then
				var_26_13 = true
				var_26_8 = (var_26_12 - var_26_11) / var_26_0
			else
				var_26_2 = var_26_2 + 1
			end
		end

		local var_26_14 = (var_26_3 - 1) * var_26_1
		local var_26_15 = arg_26_2 - (arg_26_0._startY + 0.5) * var_26_1
		local var_26_16 = false

		if var_26_15 >= var_26_14 + var_26_10 then
			var_26_5 = var_26_5 + 1

			if var_26_15 < var_26_14 + (var_26_1 - var_26_10) then
				var_26_16 = true
				var_26_9 = (var_26_15 - var_26_14) / var_26_1
			else
				var_26_3 = var_26_3 + 1
			end
		end

		if not var_26_13 or not var_26_16 then
			return true, var_26_2, var_26_3, var_26_4, var_26_5, var_26_8, var_26_9
		end
	end

	return false
end

function var_0_0.getPosKey(arg_27_0, arg_27_1)
	return string.format("%s_%s", arg_27_0, arg_27_1)
end

function var_0_0.getLineKey(arg_28_0, arg_28_1, arg_28_2, arg_28_3)
	return string.format("%s_%s_%s_%s", arg_28_0, arg_28_1, arg_28_2, arg_28_3)
end

var_0_0.instance = var_0_0.New()

return var_0_0
