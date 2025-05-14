module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.controller.PuzzleMazeDrawBaseController", package.seeall)

local var_0_0 = class("PuzzleMazeDrawBaseController", BaseController)
local var_0_1 = PuzzleEnum.dir.left
local var_0_2 = PuzzleEnum.dir.right
local var_0_3 = PuzzleEnum.dir.down
local var_0_4 = PuzzleEnum.dir.up

function var_0_0.onInitFinish(arg_1_0)
	return
end

function var_0_0.addConstEvents(arg_2_0)
	return
end

function var_0_0.reInit(arg_3_0)
	arg_3_0:release()
end

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
	if not arg_5_0._modelInst then
		logError("进入游戏失败:未配置Model实例")

		return
	end

	arg_5_0:startGame(arg_5_1)
end

function var_0_0.setModelInst(arg_6_0, arg_6_1)
	arg_6_0._modelInst = arg_6_1
end

function var_0_0.goStartPoint(arg_7_0)
	local var_7_0, var_7_1 = arg_7_0._modelInst:getStartPoint()

	arg_7_0._curPosX = var_7_0
	arg_7_0._curPosY = var_7_1

	table.insert(arg_7_0._passedPosX, var_7_0)
	table.insert(arg_7_0._passedPosY, var_7_1)
end

function var_0_0.startGame(arg_8_0, arg_8_1)
	arg_8_0:release()
	arg_8_0._modelInst:startGame(arg_8_1)

	arg_8_0._passedPosX = {}
	arg_8_0._passedPosY = {}
	arg_8_0._passedCheckPoint = {}
	arg_8_0._alertMoMap = {}

	arg_8_0:goStartPoint()
end

function var_0_0.restartGame(arg_9_0)
	local var_9_0 = arg_9_0._modelInst:getElementCo()

	if var_9_0 then
		arg_9_0:startGame(var_9_0)
	end
end

function var_0_0.isGameClear(arg_10_0)
	local var_10_0, var_10_1 = arg_10_0._modelInst:getEndPoint()

	if not arg_10_0:hasAlertObj() and arg_10_0._curPosX == var_10_0 and arg_10_0._curPosY == var_10_1 then
		local var_10_2 = arg_10_0._modelInst:getList()

		for iter_10_0, iter_10_1 in pairs(var_10_2) do
			if iter_10_1.objType == PuzzleEnum.MazeObjType.CheckPoint and not arg_10_0._passedCheckPoint[iter_10_1] then
				return false
			end
		end

		return true
	end

	return false
end

function var_0_0.goPassLine(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5, arg_11_6)
	local var_11_0
	local var_11_1

	arg_11_0._nextDir = nil
	arg_11_0._nextForwardX = arg_11_0._curPosX ~= arg_11_1 and arg_11_1 or arg_11_3
	arg_11_0._nextForwardY = arg_11_0._curPosY ~= arg_11_2 and arg_11_2 or arg_11_4

	if arg_11_0._curPosX ~= arg_11_1 or arg_11_0._curPosX ~= arg_11_3 then
		var_11_0 = arg_11_3 > arg_11_0._curPosX and var_0_1 or var_0_2
		var_11_1 = var_11_1 or {}

		if var_11_0 == var_0_1 then
			for iter_11_0 = arg_11_0._curPosX + 1, arg_11_1 do
				table.insert(var_11_1, {
					var_0_2,
					iter_11_0,
					arg_11_2
				})
			end

			arg_11_0._nextForwardX = arg_11_3
		else
			for iter_11_1 = arg_11_0._curPosX - 1, arg_11_3, -1 do
				table.insert(var_11_1, {
					var_0_1,
					iter_11_1,
					arg_11_2
				})
			end

			arg_11_0._nextForwardX = arg_11_1
		end

		arg_11_6 = nil
	end

	if arg_11_0._curPosY ~= arg_11_2 or arg_11_0._curPosY ~= arg_11_4 then
		if var_11_0 ~= nil then
			arg_11_0._nextForwardX = nil
			arg_11_0._nextForwardY = nil

			return false
		end

		var_11_0 = arg_11_4 > arg_11_0._curPosY and var_0_3 or var_0_4
		var_11_1 = var_11_1 or {}

		if var_11_0 == var_0_3 then
			for iter_11_2 = arg_11_0._curPosY + 1, arg_11_2 do
				table.insert(var_11_1, {
					var_0_4,
					arg_11_1,
					iter_11_2
				})
			end

			arg_11_0._nextForwardY = arg_11_4
		else
			for iter_11_3 = arg_11_0._curPosY - 1, arg_11_4, -1 do
				table.insert(var_11_1, {
					var_0_3,
					arg_11_1,
					iter_11_3
				})
			end

			arg_11_0._nextForwardY = arg_11_2
		end

		arg_11_5 = nil
	end

	arg_11_0._nextDir = var_11_0
	arg_11_0._nextProgressX = arg_11_5
	arg_11_0._nextProgressY = arg_11_6

	if var_11_1 and #var_11_1 > 0 then
		return arg_11_0:processPath(var_11_1, arg_11_5, arg_11_6)
	end

	return false
end

function var_0_0.goPassPos(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0
	local var_12_1

	if arg_12_0._curPosX ~= arg_12_1 then
		var_12_0 = arg_12_1 > arg_12_0._curPosX and var_0_1 or var_0_2
		var_12_1 = var_12_1 or {}

		if var_12_0 == var_0_1 then
			for iter_12_0 = arg_12_0._curPosX + 1, arg_12_1 do
				table.insert(var_12_1, {
					var_0_2,
					iter_12_0,
					arg_12_2
				})
			end
		else
			for iter_12_1 = arg_12_0._curPosX - 1, arg_12_1, -1 do
				table.insert(var_12_1, {
					var_0_1,
					iter_12_1,
					arg_12_2
				})
			end
		end
	end

	if arg_12_0._curPosY ~= arg_12_2 then
		if var_12_0 ~= nil then
			arg_12_0._nextDir = nil
			arg_12_0._nextForwardX = nil
			arg_12_0._nextForwardY = nil

			return false
		end

		local var_12_2 = arg_12_2 > arg_12_0._curPosY and var_0_3 or var_0_4

		var_12_1 = var_12_1 or {}

		if var_12_2 == var_0_3 then
			for iter_12_2 = arg_12_0._curPosY + 1, arg_12_2 do
				table.insert(var_12_1, {
					var_0_4,
					arg_12_1,
					iter_12_2
				})
			end
		else
			for iter_12_3 = arg_12_0._curPosY - 1, arg_12_2, -1 do
				table.insert(var_12_1, {
					var_0_3,
					arg_12_1,
					iter_12_3
				})
			end
		end
	end

	arg_12_0._nextProgressX = nil
	arg_12_0._nextProgressY = nil

	if var_12_1 and #var_12_1 > 0 then
		local var_12_3 = arg_12_0:processPath(var_12_1)
	end

	return false
end

function var_0_0.processPath(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		local var_13_0 = iter_13_1[1]
		local var_13_1 = iter_13_1[2]
		local var_13_2 = iter_13_1[3]
		local var_13_3 = arg_13_0:isBackward(var_13_1, var_13_2)
		local var_13_4

		if not var_13_3 then
			for iter_13_2, iter_13_3 in pairs(arg_13_0._alertMoMap) do
				return false
			end

			var_13_4 = 1
		end

		local var_13_5 = arg_13_0._modelInst:getObjAtLine(arg_13_0._curPosX, arg_13_0._curPosY, var_13_1, var_13_2)
		local var_13_6 = arg_13_0._modelInst:getMapLineState(arg_13_0._curPosX, arg_13_0._curPosY, var_13_1, var_13_2)

		if var_13_5 and var_13_6 == PuzzleEnum.LineState.Disconnect then
			arg_13_0._alertMoMap[var_13_5] = var_13_4
		end

		if var_13_3 then
			local var_13_7 = PuzzleMazeHelper.getPosKey(arg_13_0._curPosX, arg_13_0._curPosY)

			arg_13_0._alertMoMap[var_13_7] = nil

			local var_13_8 = arg_13_0._modelInst:getObjAtPos(arg_13_0._curPosX, arg_13_0._curPosY)

			if var_13_8 ~= nil and var_13_8.objType == PuzzleEnum.MazeObjType.CheckPoint and not arg_13_0:alreadyPassed(arg_13_0._curPosX, arg_13_0._curPosY, true) then
				arg_13_0._passedCheckPoint[var_13_8] = var_13_4
			end
		else
			local var_13_9 = arg_13_0._modelInst:getObjAtPos(var_13_1, var_13_2)

			if var_13_9 ~= nil and var_13_9.objType == PuzzleEnum.MazeObjType.CheckPoint then
				arg_13_0._passedCheckPoint[var_13_9] = var_13_4
			end

			if arg_13_0:alreadyPassed(var_13_1, var_13_2) then
				local var_13_10 = PuzzleMazeHelper.getPosKey(var_13_1, var_13_2)

				arg_13_0._alertMoMap[var_13_10] = var_13_4
			end
		end

		if var_13_3 then
			arg_13_0._passedPosX[#arg_13_0._passedPosX] = nil
			arg_13_0._passedPosY[#arg_13_0._passedPosY] = nil
		else
			table.insert(arg_13_0._passedPosX, var_13_1)
			table.insert(arg_13_0._passedPosY, var_13_2)
		end

		arg_13_0._curPosX = var_13_1
		arg_13_0._curPosY = var_13_2
		arg_13_0._nextDir = var_13_0
		arg_13_0._lineDirty = true
	end

	return true
end

function var_0_0.goBackPos(arg_14_0)
	local var_14_0 = #arg_14_0._passedPosX

	if var_14_0 >= 2 then
		arg_14_0:goPassPos(arg_14_0._passedPosX[var_14_0 - 1], arg_14_0._passedPosY[var_14_0 - 1])
	end
end

function var_0_0.isBackward(arg_15_0, arg_15_1, arg_15_2)
	return #arg_15_0._passedPosX > 1 and arg_15_0._passedPosX[#arg_15_0._passedPosX - 1] == arg_15_1 and arg_15_0._passedPosY[#arg_15_0._passedPosY - 1] == arg_15_2
end

function var_0_0.alreadyPassed(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0 = arg_16_0._passedPosX and #arg_16_0._passedPosX or 0
	local var_16_1 = arg_16_3 and var_16_0 - 1 or var_16_0

	for iter_16_0 = 1, var_16_1 do
		local var_16_2 = arg_16_0._passedPosX[iter_16_0]
		local var_16_3 = arg_16_0._passedPosY[iter_16_0]

		if var_16_2 == arg_16_1 and var_16_3 == arg_16_2 then
			return true
		end
	end

	return false
end

function var_0_0.alreadyCheckPoint(arg_17_0, arg_17_1)
	return arg_17_0._passedCheckPoint and arg_17_0._passedCheckPoint[arg_17_1] ~= nil
end

function var_0_0.getLastPos(arg_18_0)
	return arg_18_0._curPosX, arg_18_0._curPosY
end

function var_0_0.getPassedPoints(arg_19_0)
	return arg_19_0._passedPosX, arg_19_0._passedPosY
end

function var_0_0.getProgressLine(arg_20_0)
	return arg_20_0._nextForwardX, arg_20_0._nextForwardY, arg_20_0._nextProgressX, arg_20_0._nextProgressY
end

function var_0_0.getAlertMap(arg_21_0)
	return arg_21_0._alertMoMap
end

function var_0_0.hasAlertObj(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0._alertMoMap) do
		return true
	end

	return false
end

function var_0_0.isLineDirty(arg_23_0)
	return arg_23_0._lineDirty
end

function var_0_0.resetLineDirty(arg_24_0)
	arg_24_0._lineDirty = false
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
