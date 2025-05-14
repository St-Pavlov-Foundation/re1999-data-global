module("modules.logic.dungeon.controller.DungeonPuzzleMazeDrawController", package.seeall)

local var_0_0 = class("DungeonPuzzleMazeDrawController", BaseController)

function var_0_0.onInitFinish(arg_1_0)
	return
end

function var_0_0.addConstEvents(arg_2_0)
	return
end

function var_0_0.reInit(arg_3_0)
	arg_3_0._curPosX = nil
	arg_3_0._curPosY = nil
	arg_3_0._passedPosX = nil
	arg_3_0._passedPosY = nil
	arg_3_0._passedCheckPoint = nil
	arg_3_0._alertMoMap = nil
	arg_3_0._nextDir = nil
	arg_3_0._nextForwardX = nil
	arg_3_0._nextForwardY = nil
	arg_3_0._nextProgressX = nil
	arg_3_0._nextProgressY = nil
	arg_3_0._lineDirty = nil
end

local var_0_1 = DungeonPuzzleEnum.dir.left
local var_0_2 = DungeonPuzzleEnum.dir.right
local var_0_3 = DungeonPuzzleEnum.dir.down
local var_0_4 = DungeonPuzzleEnum.dir.up

function var_0_0.release(arg_4_0)
	arg_4_0._curPosX = nil
	arg_4_0._curPosY = nil
	arg_4_0._passedPosX = nil
	arg_4_0._passedPosY = nil
	arg_4_0._passedCheckPoint = nil
	arg_4_0._alertMoMap = nil
	arg_4_0._nextDir = nil
	arg_4_0._nextForwardX = nil
	arg_4_0._nextForwardY = nil
	arg_4_0._nextProgressX = nil
	arg_4_0._nextProgressY = nil
	arg_4_0._lineDirty = nil
end

function var_0_0.openGame(arg_5_0, arg_5_1)
	DungeonPuzzleMazeDrawModel.instance:initByElementCo(arg_5_1)
	ViewMgr.instance:openView(ViewName.DungeonPuzzleMazeDrawView)
end

function var_0_0.goStartPoint(arg_6_0)
	local var_6_0, var_6_1 = DungeonPuzzleMazeDrawModel.instance:getStartPoint()

	arg_6_0._curPosX = var_6_0
	arg_6_0._curPosY = var_6_1

	table.insert(arg_6_0._passedPosX, var_6_0)
	table.insert(arg_6_0._passedPosY, var_6_1)
end

function var_0_0.startGame(arg_7_0)
	arg_7_0._passedPosX = {}
	arg_7_0._passedPosY = {}
	arg_7_0._passedCheckPoint = {}
	arg_7_0._alertMoMap = {}

	arg_7_0:goStartPoint()
end

function var_0_0.isGameClear(arg_8_0)
	local var_8_0, var_8_1 = DungeonPuzzleMazeDrawModel.instance:getEndPoint()

	if not arg_8_0:hasAlertObj() and arg_8_0._curPosX == var_8_0 and arg_8_0._curPosY == var_8_1 then
		local var_8_2 = DungeonPuzzleMazeDrawModel.instance:getList()

		for iter_8_0, iter_8_1 in pairs(var_8_2) do
			if iter_8_1.objType == DungeonPuzzleEnum.MazeObjType.CheckPoint and not arg_8_0._passedCheckPoint[iter_8_1] then
				return false
			end
		end

		return true
	end

	return false
end

function var_0_0.goPassLine(arg_9_0, arg_9_1, arg_9_2, arg_9_3, arg_9_4, arg_9_5, arg_9_6)
	local var_9_0
	local var_9_1

	arg_9_0._nextDir = nil
	arg_9_0._nextForwardX = arg_9_0._curPosX ~= arg_9_1 and arg_9_1 or arg_9_3
	arg_9_0._nextForwardY = arg_9_0._curPosY ~= arg_9_2 and arg_9_2 or arg_9_4

	if arg_9_0._curPosX ~= arg_9_1 or arg_9_0._curPosX ~= arg_9_3 then
		var_9_0 = arg_9_3 > arg_9_0._curPosX and var_0_1 or var_0_2
		var_9_1 = var_9_1 or {}

		if var_9_0 == var_0_1 then
			for iter_9_0 = arg_9_0._curPosX + 1, arg_9_1 do
				table.insert(var_9_1, {
					var_0_2,
					iter_9_0,
					arg_9_2
				})
			end

			arg_9_0._nextForwardX = arg_9_3
		else
			for iter_9_1 = arg_9_0._curPosX - 1, arg_9_3, -1 do
				table.insert(var_9_1, {
					var_0_1,
					iter_9_1,
					arg_9_2
				})
			end

			arg_9_0._nextForwardX = arg_9_1
		end

		arg_9_6 = nil
	end

	if arg_9_0._curPosY ~= arg_9_2 or arg_9_0._curPosY ~= arg_9_4 then
		if var_9_0 ~= nil then
			arg_9_0._nextForwardX = nil
			arg_9_0._nextForwardY = nil

			return false
		end

		var_9_0 = arg_9_4 > arg_9_0._curPosY and var_0_3 or var_0_4
		var_9_1 = var_9_1 or {}

		if var_9_0 == var_0_3 then
			for iter_9_2 = arg_9_0._curPosY + 1, arg_9_2 do
				table.insert(var_9_1, {
					var_0_4,
					arg_9_1,
					iter_9_2
				})
			end

			arg_9_0._nextForwardY = arg_9_4
		else
			for iter_9_3 = arg_9_0._curPosY - 1, arg_9_4, -1 do
				table.insert(var_9_1, {
					var_0_3,
					arg_9_1,
					iter_9_3
				})
			end

			arg_9_0._nextForwardY = arg_9_2
		end

		arg_9_5 = nil
	end

	arg_9_0._nextDir = var_9_0
	arg_9_0._nextProgressX = arg_9_5
	arg_9_0._nextProgressY = arg_9_6

	if var_9_1 and #var_9_1 > 0 then
		return arg_9_0:processPath(var_9_1, arg_9_5, arg_9_6)
	end

	return false
end

function var_0_0.goPassPos(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0
	local var_10_1

	if arg_10_0._curPosX ~= arg_10_1 then
		var_10_0 = arg_10_1 > arg_10_0._curPosX and var_0_1 or var_0_2
		var_10_1 = var_10_1 or {}

		if var_10_0 == var_0_1 then
			for iter_10_0 = arg_10_0._curPosX + 1, arg_10_1 do
				table.insert(var_10_1, {
					var_0_2,
					iter_10_0,
					arg_10_2
				})
			end
		else
			for iter_10_1 = arg_10_0._curPosX - 1, arg_10_1, -1 do
				table.insert(var_10_1, {
					var_0_1,
					iter_10_1,
					arg_10_2
				})
			end
		end
	end

	if arg_10_0._curPosY ~= arg_10_2 then
		if var_10_0 ~= nil then
			arg_10_0._nextDir = nil
			arg_10_0._nextForwardX = nil
			arg_10_0._nextForwardY = nil

			return false
		end

		local var_10_2 = arg_10_2 > arg_10_0._curPosY and var_0_3 or var_0_4

		var_10_1 = var_10_1 or {}

		if var_10_2 == var_0_3 then
			for iter_10_2 = arg_10_0._curPosY + 1, arg_10_2 do
				table.insert(var_10_1, {
					var_0_4,
					arg_10_1,
					iter_10_2
				})
			end
		else
			for iter_10_3 = arg_10_0._curPosY - 1, arg_10_2, -1 do
				table.insert(var_10_1, {
					var_0_3,
					arg_10_1,
					iter_10_3
				})
			end
		end
	end

	arg_10_0._nextProgressX = nil
	arg_10_0._nextProgressY = nil

	if var_10_1 and #var_10_1 > 0 then
		local var_10_3 = arg_10_0:processPath(var_10_1)
	end

	return false
end

function var_0_0.processPath(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		local var_11_0 = iter_11_1[1]
		local var_11_1 = iter_11_1[2]
		local var_11_2 = iter_11_1[3]
		local var_11_3 = arg_11_0:isBackward(var_11_1, var_11_2)
		local var_11_4

		if not var_11_3 then
			for iter_11_2, iter_11_3 in pairs(arg_11_0._alertMoMap) do
				return false
			end

			var_11_4 = 1
		end

		local var_11_5 = DungeonPuzzleMazeDrawModel.instance:getObjAtLine(var_0_0.formatPos(arg_11_0._curPosX, arg_11_0._curPosY, var_11_1, var_11_2))

		if var_11_5 ~= nil and var_11_5.objType == DungeonPuzzleEnum.MazeObjType.Block then
			arg_11_0._alertMoMap[var_11_5] = var_11_4
		end

		if var_11_3 then
			local var_11_6 = DungeonPuzzleMazeDrawModel.getPosKey(arg_11_0._curPosX, arg_11_0._curPosY)

			arg_11_0._alertMoMap[var_11_6] = nil

			local var_11_7 = DungeonPuzzleMazeDrawModel.instance:getObjAtPos(arg_11_0._curPosX, arg_11_0._curPosY)

			if var_11_7 ~= nil and var_11_7.objType == DungeonPuzzleEnum.MazeObjType.CheckPoint and not arg_11_0:alreadyPassed(arg_11_0._curPosX, arg_11_0._curPosY, true) then
				arg_11_0._passedCheckPoint[var_11_7] = var_11_4
			end
		else
			local var_11_8 = DungeonPuzzleMazeDrawModel.instance:getObjAtPos(var_11_1, var_11_2)

			if var_11_8 ~= nil and var_11_8.objType == DungeonPuzzleEnum.MazeObjType.CheckPoint then
				arg_11_0._passedCheckPoint[var_11_8] = var_11_4
			end

			if arg_11_0:alreadyPassed(var_11_1, var_11_2) then
				local var_11_9 = DungeonPuzzleMazeDrawModel.getPosKey(var_11_1, var_11_2)

				arg_11_0._alertMoMap[var_11_9] = var_11_4
			end
		end

		if var_11_3 then
			arg_11_0._passedPosX[#arg_11_0._passedPosX] = nil
			arg_11_0._passedPosY[#arg_11_0._passedPosY] = nil
		else
			table.insert(arg_11_0._passedPosX, var_11_1)
			table.insert(arg_11_0._passedPosY, var_11_2)
		end

		arg_11_0._curPosX = var_11_1
		arg_11_0._curPosY = var_11_2
		arg_11_0._nextDir = var_11_0
		arg_11_0._lineDirty = true
	end

	return true
end

function var_0_0.goBackPos(arg_12_0)
	local var_12_0 = #arg_12_0._passedPosX

	if var_12_0 >= 2 then
		arg_12_0:goPassPos(arg_12_0._passedPosX[var_12_0 - 1], arg_12_0._passedPosY[var_12_0 - 1])
	end
end

function var_0_0.isBackward(arg_13_0, arg_13_1, arg_13_2)
	return #arg_13_0._passedPosX > 1 and arg_13_0._passedPosX[#arg_13_0._passedPosX - 1] == arg_13_1 and arg_13_0._passedPosY[#arg_13_0._passedPosY - 1] == arg_13_2
end

function var_0_0.alreadyPassed(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_3 and #arg_14_0._passedPosX - 1 or #arg_14_0._passedPosX

	for iter_14_0 = 1, var_14_0 do
		local var_14_1 = arg_14_0._passedPosX[iter_14_0]
		local var_14_2 = arg_14_0._passedPosY[iter_14_0]

		if var_14_1 == arg_14_1 and var_14_2 == arg_14_2 then
			return true
		end
	end

	return false
end

function var_0_0.alreadyCheckPoint(arg_15_0, arg_15_1)
	return arg_15_0._passedCheckPoint and arg_15_0._passedCheckPoint[arg_15_1] ~= nil
end

function var_0_0.getLastPos(arg_16_0)
	return arg_16_0._curPosX, arg_16_0._curPosY
end

function var_0_0.getPassedPoints(arg_17_0)
	return arg_17_0._passedPosX, arg_17_0._passedPosY
end

function var_0_0.getProgressLine(arg_18_0)
	return arg_18_0._nextForwardX, arg_18_0._nextForwardY, arg_18_0._nextProgressX, arg_18_0._nextProgressY
end

function var_0_0.getAlertMap(arg_19_0)
	return arg_19_0._alertMoMap
end

function var_0_0.hasAlertObj(arg_20_0)
	for iter_20_0, iter_20_1 in pairs(arg_20_0._alertMoMap) do
		return true
	end

	return false
end

function var_0_0.isLineDirty(arg_21_0)
	return arg_21_0._lineDirty
end

function var_0_0.resetLineDirty(arg_22_0)
	arg_22_0._lineDirty = false
end

function var_0_0.formatPos(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if arg_23_2 < arg_23_0 then
		arg_23_0, arg_23_2 = arg_23_2, arg_23_0
	end

	if arg_23_3 < arg_23_1 then
		arg_23_1, arg_23_3 = arg_23_3, arg_23_1
	end

	return arg_23_0, arg_23_1, arg_23_2, arg_23_3
end

function var_0_0.getFromToDir(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if arg_24_0 ~= arg_24_2 then
		if arg_24_1 ~= arg_24_3 then
			return nil
		end

		return arg_24_0 < arg_24_2 and var_0_2 or var_0_1
	else
		return arg_24_1 < arg_24_3 and var_0_4 or var_0_3
	end
end

var_0_0.instance = var_0_0.New()

return var_0_0
