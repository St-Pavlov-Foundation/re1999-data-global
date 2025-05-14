module("modules.logic.versionactivity2_3.zhixinquaner.maze.model.PuzzleMazeDrawModel", package.seeall)

local var_0_0 = class("PuzzleMazeDrawModel", PuzzleMazeDrawBaseModel)

function var_0_0.release(arg_1_0)
	var_0_0.super.release(arg_1_0)

	arg_1_0._interactPosX = nil
	arg_1_0._interactPosY = nil
	arg_1_0._effectDoneMap = nil
	arg_1_0._canFlyPlane = true
	arg_1_0._planePosX = nil
	arg_1_0._planePosY = nil
end

function var_0_0.startGame(arg_2_0, arg_2_1)
	var_0_0.super.startGame(arg_2_0, arg_2_1)
	arg_2_0:setCanFlyPane(true)
end

function var_0_0.switchLine(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_0:getInteractLines(arg_3_2, arg_3_3)

	if not var_3_0 then
		return
	end

	for iter_3_0, iter_3_1 in pairs(var_3_0) do
		local var_3_1 = iter_3_1.x1
		local var_3_2 = iter_3_1.y1
		local var_3_3 = iter_3_1.x2
		local var_3_4 = iter_3_1.y2
		local var_3_5 = PuzzleMazeHelper.getLineKey(var_3_1, var_3_2, var_3_3, var_3_4)

		arg_3_0._lineMap[var_3_5] = arg_3_1

		PuzzleMazeDrawController.instance:dispatchEvent(PuzzleEvent.SwitchLineState, var_3_1, var_3_2, var_3_3, var_3_4)
	end

	if arg_3_1 == PuzzleEnum.LineState.Connect then
		arg_3_0._interactPosX = arg_3_2
		arg_3_0._interactPosY = arg_3_3
	else
		arg_3_0._interactPosX = nil
		arg_3_0._interactPosY = nil
	end
end

function var_0_0.getInteractLines(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0:getObjAtPos(arg_4_1, arg_4_2)

	if var_4_0 then
		return var_4_0.interactLines
	end
end

function var_0_0.getInteractPos(arg_5_0)
	return arg_5_0._interactPosX, arg_5_0._interactPosY
end

function var_0_0.isCanFlyPlane(arg_6_0)
	return arg_6_0._canFlyPlane
end

function var_0_0.setCanFlyPane(arg_7_0, arg_7_1)
	arg_7_0._canFlyPlane = arg_7_1
end

function var_0_0.setPlanePlacePos(arg_8_0, arg_8_1, arg_8_2)
	arg_8_0._planePosX = arg_8_1
	arg_8_0._planePosY = arg_8_2
end

function var_0_0.getCurPlanePos(arg_9_0)
	if arg_9_0:isCanFlyPlane() then
		return PuzzleMazeDrawController.instance:getLastPos()
	else
		return arg_9_0._planePosX, arg_9_0._planePosY
	end
end

function var_0_0.setTriggerEffectDone(arg_10_0, arg_10_1, arg_10_2)
	arg_10_0._effectDoneMap = arg_10_0._effectDoneMap or {}

	local var_10_0 = PuzzleMazeHelper.getPosKey(arg_10_1, arg_10_2)

	arg_10_0._effectDoneMap[var_10_0] = true
end

function var_0_0.hasTriggerEffect(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = PuzzleMazeHelper.getPosKey(arg_11_1, arg_11_2)

	return arg_11_0._effectDoneMap and arg_11_0._effectDoneMap[var_11_0]
end

function var_0_0.canTriggerEffect(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0:hasTriggerEffect(arg_12_1, arg_12_2) then
		return false
	end

	local var_12_0 = arg_12_0:getObjAtPos(arg_12_1, arg_12_2)

	if not var_12_0 then
		return false
	end

	local var_12_1 = arg_12_0._effectDoneMap and tabletool.len(arg_12_0._effectDoneMap) or 0
	local var_12_2 = var_12_0.priority

	return var_12_1 + 1 == var_12_2
end

function var_0_0.getTriggerEffectDoneMap(arg_13_0)
	return arg_13_0._effectDoneMap
end

function var_0_0.setTriggerEffectDoneMap(arg_14_0, arg_14_1)
	arg_14_0._effectDoneMap = arg_14_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
