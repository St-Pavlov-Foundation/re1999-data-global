module("modules.logic.versionactivity2_3.zhixinquaner.maze.controller.PuzzleMazeDrawController", package.seeall)

local var_0_0 = class("PuzzleMazeDrawController", PuzzleMazeDrawBaseController)

function var_0_0.openGame(arg_1_0, arg_1_1)
	arg_1_0:setModelInst(PuzzleMazeDrawModel.instance)
	var_0_0.super.openGame(arg_1_0, arg_1_1)
	ViewMgr.instance:openView(ViewName.PuzzleMazeDrawView)
end

function var_0_0.interactSwitchObj(arg_2_0, arg_2_1, arg_2_2)
	PuzzleMazeDrawModel.instance:setCanFlyPane(false)
	PuzzleMazeDrawModel.instance:setPlanePlacePos(arg_2_1, arg_2_2)
	PuzzleMazeDrawModel.instance:switchLine(PuzzleEnum.LineState.Switch_On, arg_2_1, arg_2_2)
	var_0_0.instance:dispatchEvent(PuzzleEvent.SimulatePlane, arg_2_1, arg_2_2)
end

function var_0_0.recyclePlane(arg_3_0)
	local var_3_0, var_3_1 = PuzzleMazeDrawModel.instance:getCurPlanePos()

	PuzzleMazeDrawModel.instance:switchLine(PuzzleEnum.LineState.Switch_Off, var_3_0, var_3_1)
	PuzzleMazeDrawModel.instance:setCanFlyPane(true)
	var_0_0.instance:dispatchEvent(PuzzleEvent.RecyclePlane)
end

function var_0_0.processPath(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_0 = iter_4_1[1]
		local var_4_1 = iter_4_1[2]
		local var_4_2 = iter_4_1[3]
		local var_4_3 = arg_4_0:isBackward(var_4_1, var_4_2)
		local var_4_4

		if not var_4_3 then
			for iter_4_2, iter_4_3 in pairs(arg_4_0._alertMoMap) do
				return false
			end

			var_4_4 = 1
		end

		local var_4_5 = PuzzleMazeHelper.getLineKey(arg_4_0._curPosX, arg_4_0._curPosY, var_4_1, var_4_2)
		local var_4_6 = PuzzleMazeDrawModel.instance:getObjAtLine(arg_4_0._curPosX, arg_4_0._curPosY, var_4_1, var_4_2)

		if var_4_6 ~= nil and var_4_6.objType == PuzzleEnum.MazeObjType.Block then
			arg_4_0._alertMoMap[var_4_5] = PuzzleEnum.MazeAlertType.VisitBlock
		end

		if var_4_3 then
			local var_4_7 = PuzzleMazeHelper.getPosKey(arg_4_0._curPosX, arg_4_0._curPosY)

			arg_4_0._alertMoMap[var_4_7] = nil

			local var_4_8 = PuzzleMazeHelper.getLineKey(arg_4_0._curPosX, arg_4_0._curPosY, var_4_1, var_4_2)

			arg_4_0._alertMoMap[var_4_8] = nil

			local var_4_9 = PuzzleMazeDrawModel.instance:getObjAtPos(arg_4_0._curPosX, arg_4_0._curPosY)

			if var_4_9 ~= nil and var_4_9.objType == PuzzleEnum.MazeObjType.CheckPoint and not arg_4_0:alreadyPassed(arg_4_0._curPosX, arg_4_0._curPosY, true) then
				arg_4_0._passedCheckPoint[var_4_9] = var_4_4
			end
		else
			if not arg_4_0:canPassLine(var_4_1, var_4_2) then
				arg_4_0._alertMoMap[var_4_5] = PuzzleEnum.MazeAlertType.DisconnectLine
			elseif arg_4_0:alreadyPassed(var_4_1, var_4_2) then
				local var_4_10 = PuzzleMazeHelper.getPosKey(var_4_1, var_4_2)

				arg_4_0._alertMoMap[var_4_10] = PuzzleEnum.MazeAlertType.VisitRepeat
			end

			local var_4_11 = PuzzleMazeDrawModel.instance:getObjAtPos(var_4_1, var_4_2)

			if var_4_11 ~= nil and var_4_11.objType == PuzzleEnum.MazeObjType.CheckPoint then
				arg_4_0._passedCheckPoint[var_4_11] = var_4_4
			end
		end

		if var_4_3 then
			arg_4_0._passedPosX[#arg_4_0._passedPosX] = nil
			arg_4_0._passedPosY[#arg_4_0._passedPosY] = nil
		else
			table.insert(arg_4_0._passedPosX, var_4_1)
			table.insert(arg_4_0._passedPosY, var_4_2)
		end

		arg_4_0._curPosX = var_4_1
		arg_4_0._curPosY = var_4_2
		arg_4_0._nextDir = var_4_0
		arg_4_0._lineDirty = true
	end

	return true
end

function var_0_0.canPassLine(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = PuzzleMazeDrawModel.instance:getMapLineState(arg_5_0._curPosX, arg_5_0._curPosY, arg_5_1, arg_5_2)

	return var_5_0 ~= PuzzleEnum.LineState.Disconnect and var_5_0 ~= PuzzleEnum.LineState.Switch_Off
end

function var_0_0.savePuzzleProgress(arg_6_0)
	local var_6_0 = PuzzleMazeDrawModel.instance:getElementCo()

	if not var_6_0 then
		return
	end

	if arg_6_0:hasAlertObj() then
		return
	end

	local var_6_1, var_6_2 = arg_6_0:getPassedPoints()
	local var_6_3, var_6_4 = PuzzleMazeDrawModel.instance:getInteractPos()
	local var_6_5 = {
		passX = var_6_1,
		passY = var_6_2
	}

	if var_6_3 and var_6_4 then
		var_6_5.interactPosX = var_6_3
		var_6_5.interactPosY = var_6_4
	end

	local var_6_6 = cjson.encode(var_6_5)

	DungeonRpc.instance:sendSavePuzzleProgressRequest(var_6_0.id, var_6_6)
end

function var_0_0.getPuzzleDrawProgress(arg_7_0)
	local var_7_0 = PuzzleMazeDrawModel.instance:getElementCo()

	if not var_7_0 then
		return
	end

	DungeonRpc.instance:sendGetPuzzleProgressRequest(var_7_0.id)
end

function var_0_0.onGetPuzzleDrawProgress(arg_8_0, arg_8_1, arg_8_2)
	if string.nilorempty(arg_8_2) then
		return
	end

	local var_8_0 = cjson.decode(arg_8_2)

	if var_8_0.interactPosX and var_8_0.interactPosY then
		arg_8_0:interactSwitchObj(var_8_0.interactPosX, var_8_0.interactPosY)
	end

	local var_8_1 = var_8_0.passX and #var_8_0.passX or 0

	for iter_8_0 = 1, var_8_1 do
		local var_8_2 = var_8_0.passX[iter_8_0]
		local var_8_3 = var_8_0.passY[iter_8_0]
		local var_8_4 = var_8_0.passX[iter_8_0 - 1]
		local var_8_5 = var_8_0.passY[iter_8_0 - 1]
		local var_8_6 = false

		if var_8_4 ~= nil and arg_8_0._modelInst:getMapLineState(var_8_4, var_8_5, var_8_2, var_8_3) == PuzzleEnum.LineState.Switch_Off then
			arg_8_0._modelInst:setMapLineState(var_8_4, var_8_5, var_8_2, var_8_3, PuzzleEnum.LineState.Switch_On)

			var_8_6 = true
		end

		arg_8_0:goPassPos(var_8_2, var_8_3)

		if var_8_6 then
			arg_8_0._modelInst:setMapLineState(var_8_4, var_8_5, var_8_2, var_8_3, PuzzleEnum.LineState.Switch_Off)
		end
	end
end

function var_0_0.hasAlertObj(arg_9_0)
	for iter_9_0, iter_9_1 in pairs(arg_9_0._alertMoMap) do
		return true
	end

	local var_9_0 = arg_9_0._passedPosX and #arg_9_0._passedPosX or 0

	if var_9_0 >= 2 then
		local var_9_1 = arg_9_0._passedPosX and arg_9_0._passedPosX[var_9_0]
		local var_9_2 = arg_9_0._passedPosY and arg_9_0._passedPosY[var_9_0]

		if not arg_9_0._modelInst:getObjAtPos(var_9_1, var_9_2) then
			return true
		end
	end

	return false
end

function var_0_0.goBackPos(arg_10_0)
	local var_10_0 = #arg_10_0._passedPosX

	if var_10_0 >= 2 then
		arg_10_0:goPassPos(arg_10_0._passedPosX[var_10_0 - 1], arg_10_0._passedPosY[var_10_0 - 1])

		for iter_10_0 = var_10_0 - 1, 2, -1 do
			local var_10_1 = arg_10_0._passedPosX[iter_10_0]
			local var_10_2 = arg_10_0._passedPosY[iter_10_0]

			if arg_10_0._modelInst:getObjAtPos(var_10_1, var_10_2) then
				break
			end

			arg_10_0:goPassPos(arg_10_0._passedPosX[iter_10_0 - 1], arg_10_0._passedPosY[iter_10_0 - 1])
		end
	end
end

function var_0_0.restartGame(arg_11_0)
	local var_11_0 = arg_11_0._modelInst:getTriggerEffectDoneMap()

	var_0_0.super.restartGame(arg_11_0)
	arg_11_0._modelInst:setTriggerEffectDoneMap(var_11_0)
end

var_0_0.instance = var_0_0.New()

LuaEventSystem.addEventMechanism(var_0_0.instance)

return var_0_0
