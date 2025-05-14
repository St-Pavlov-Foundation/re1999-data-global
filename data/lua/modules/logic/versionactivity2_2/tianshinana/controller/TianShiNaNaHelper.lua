module("modules.logic.versionactivity2_2.tianshinana.controller.TianShiNaNaHelper", package.seeall)

local var_0_0 = class("TianShiNaNaHelper")
local var_0_1 = Vector2()
local var_0_2 = Vector3()
local var_0_3 = Vector3()
local var_0_4 = Quaternion()

function var_0_0.nodeToV3(arg_1_0)
	var_0_2.x = (arg_1_0.x + arg_1_0.y) * TianShiNaNaEnum.GridXOffset
	var_0_2.y = (arg_1_0.y - arg_1_0.x) * TianShiNaNaEnum.GridYOffset
	var_0_2.z = (arg_1_0.y - arg_1_0.x) * TianShiNaNaEnum.GridZOffset

	return var_0_2
end

function var_0_0.v3ToNode(arg_2_0)
	local var_2_0 = arg_2_0.x / TianShiNaNaEnum.GridXOffset
	local var_2_1 = arg_2_0.y / TianShiNaNaEnum.GridYOffset

	var_0_1.x = Mathf.Round((var_2_0 - var_2_1) / 2)
	var_0_1.y = Mathf.Round((var_2_0 + var_2_1) / 2)

	return var_0_1
end

function var_0_0.getV2(arg_3_0, arg_3_1)
	var_0_1.x = arg_3_0 or 0
	var_0_1.y = arg_3_1 or 0

	return var_0_1
end

function var_0_0.getV3(arg_4_0, arg_4_1, arg_4_2)
	var_0_2.x = arg_4_0 or 0
	var_0_2.y = arg_4_1 or 0
	var_0_2.z = arg_4_2 or 0

	return var_0_2
end

function var_0_0.getRoundDis(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	return math.abs(arg_5_0 - arg_5_2) + math.abs(arg_5_1 - arg_5_3)
end

function var_0_0.getMinDis(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	return math.max(math.abs(arg_6_0 - arg_6_2), math.abs(arg_6_1 - arg_6_3))
end

function var_0_0.isPosSame(arg_7_0, arg_7_1)
	return arg_7_0.x == arg_7_1.x and arg_7_0.y == arg_7_1.y
end

function var_0_0.havePos(arg_8_0, arg_8_1)
	for iter_8_0, iter_8_1 in pairs(arg_8_0) do
		if var_0_0.isPosSame(arg_8_1, iter_8_1) then
			return true
		end
	end

	return false
end

function var_0_0.getClickNodePos(arg_9_0)
	local var_9_0 = CameraMgr.instance:getMainCamera()
	local var_9_1 = recthelper.screenPosToWorldPos(arg_9_0 or GamepadController.instance:getMousePosition(), var_9_0, var_0_3)
	local var_9_2 = TianShiNaNaModel.instance.nowScenePos

	var_9_1.x = var_9_1.x - var_9_2.x
	var_9_1.y = var_9_1.y - var_9_2.y

	return var_0_0.v3ToNode(var_9_1)
end

function var_0_0.getSortIndex(arg_10_0, arg_10_1)
	return 500 + (arg_10_0 - arg_10_1) * 2
end

function var_0_0.getDir(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_0.x > arg_11_1.x then
		return TianShiNaNaEnum.OperDir.Left
	elseif arg_11_0.x < arg_11_1.x then
		return TianShiNaNaEnum.OperDir.Right
	elseif arg_11_0.y > arg_11_1.y then
		return TianShiNaNaEnum.OperDir.Back
	elseif arg_11_0.y < arg_11_1.y then
		return TianShiNaNaEnum.OperDir.Forward
	else
		return arg_11_2 or TianShiNaNaEnum.OperDir.Right
	end
end

function var_0_0.lerpQ(arg_12_0, arg_12_1, arg_12_2)
	arg_12_2 = Mathf.Clamp(arg_12_2, 0, 1)

	local var_12_0 = var_0_4

	if Quaternion.Dot(arg_12_0, arg_12_1) < 0 then
		var_12_0.x = arg_12_0.x + arg_12_2 * (-arg_12_1.x - arg_12_0.x)
		var_12_0.y = arg_12_0.y + arg_12_2 * (-arg_12_1.y - arg_12_0.y)
		var_12_0.z = arg_12_0.z + arg_12_2 * (-arg_12_1.z - arg_12_0.z)
		var_12_0.w = arg_12_0.w + arg_12_2 * (-arg_12_1.w - arg_12_0.w)
	else
		var_12_0.x = arg_12_0.x + (arg_12_1.x - arg_12_0.x) * arg_12_2
		var_12_0.y = arg_12_0.y + (arg_12_1.y - arg_12_0.y) * arg_12_2
		var_12_0.z = arg_12_0.z + (arg_12_1.z - arg_12_0.z) * arg_12_2
		var_12_0.w = arg_12_0.w + (arg_12_1.w - arg_12_0.w) * arg_12_2
	end

	return var_0_4
end

function var_0_0.lerpV3(arg_13_0, arg_13_1, arg_13_2)
	arg_13_2 = Mathf.Clamp(arg_13_2, 0, 1)
	var_0_2.x = arg_13_0.x + (arg_13_1.x - arg_13_0.x) * arg_13_2
	var_0_2.y = arg_13_0.y + (arg_13_1.y - arg_13_0.y) * arg_13_2
	var_0_2.z = arg_13_0.z + (arg_13_1.z - arg_13_0.z) * arg_13_2

	return var_0_2
end

function var_0_0.getCanOperDirs(arg_14_0, arg_14_1)
	local var_14_0 = {
		[TianShiNaNaEnum.OperDir.Left] = TianShiNaNaModel.instance:isNodeCanPlace(arg_14_0.x - 1, arg_14_0.y, arg_14_1 == TianShiNaNaEnum.CubeType.Type1),
		[TianShiNaNaEnum.OperDir.Right] = TianShiNaNaModel.instance:isNodeCanPlace(arg_14_0.x + 1, arg_14_0.y, arg_14_1 == TianShiNaNaEnum.CubeType.Type1),
		[TianShiNaNaEnum.OperDir.Forward] = TianShiNaNaModel.instance:isNodeCanPlace(arg_14_0.x, arg_14_0.y + 1, arg_14_1 == TianShiNaNaEnum.CubeType.Type1),
		[TianShiNaNaEnum.OperDir.Back] = TianShiNaNaModel.instance:isNodeCanPlace(arg_14_0.x, arg_14_0.y - 1, arg_14_1 == TianShiNaNaEnum.CubeType.Type1)
	}

	if arg_14_1 == TianShiNaNaEnum.CubeType.Type2 then
		var_14_0[TianShiNaNaEnum.OperDir.Left] = var_14_0[TianShiNaNaEnum.OperDir.Left] and TianShiNaNaModel.instance:isNodeCanPlace(arg_14_0.x - 2, arg_14_0.y)
		var_14_0[TianShiNaNaEnum.OperDir.Right] = var_14_0[TianShiNaNaEnum.OperDir.Right] and TianShiNaNaModel.instance:isNodeCanPlace(arg_14_0.x + 2, arg_14_0.y)
		var_14_0[TianShiNaNaEnum.OperDir.Forward] = var_14_0[TianShiNaNaEnum.OperDir.Forward] and TianShiNaNaModel.instance:isNodeCanPlace(arg_14_0.x, arg_14_0.y + 2)
		var_14_0[TianShiNaNaEnum.OperDir.Back] = var_14_0[TianShiNaNaEnum.OperDir.Back] and TianShiNaNaModel.instance:isNodeCanPlace(arg_14_0.x, arg_14_0.y - 2)
	end

	var_14_0[TianShiNaNaEnum.OperDir.Left] = var_14_0[TianShiNaNaEnum.OperDir.Left] or nil
	var_14_0[TianShiNaNaEnum.OperDir.Right] = var_14_0[TianShiNaNaEnum.OperDir.Right] or nil
	var_14_0[TianShiNaNaEnum.OperDir.Forward] = var_14_0[TianShiNaNaEnum.OperDir.Forward] or nil
	var_14_0[TianShiNaNaEnum.OperDir.Back] = var_14_0[TianShiNaNaEnum.OperDir.Back] or nil

	return var_14_0
end

function var_0_0.getOperDir(arg_15_0, arg_15_1)
	if arg_15_0 >= 0 and arg_15_1 <= 0 then
		return TianShiNaNaEnum.OperDir.Right
	elseif arg_15_0 <= 0 and arg_15_1 >= 0 then
		return TianShiNaNaEnum.OperDir.Left
	elseif arg_15_0 >= 0 and arg_15_1 >= 0 then
		return TianShiNaNaEnum.OperDir.Forward
	elseif arg_15_0 <= 0 and arg_15_1 <= 0 then
		return TianShiNaNaEnum.OperDir.Back
	end
end

function var_0_0.isRevertDir(arg_16_0, arg_16_1, arg_16_2)
	if arg_16_0 == TianShiNaNaEnum.OperDir.Left and arg_16_1 > 0 then
		return true
	elseif arg_16_0 == TianShiNaNaEnum.OperDir.Right and arg_16_1 < 0 then
		return true
	elseif arg_16_0 == TianShiNaNaEnum.OperDir.Forward and arg_16_2 < 0 then
		return true
	elseif arg_16_0 == TianShiNaNaEnum.OperDir.Back and arg_16_2 > 0 then
		return true
	end
end

function var_0_0.getOperOffset(arg_17_0)
	var_0_1:Set(0, 0)

	if arg_17_0 == TianShiNaNaEnum.OperDir.Left then
		var_0_1.x = -1
	elseif arg_17_0 == TianShiNaNaEnum.OperDir.Right then
		var_0_1.x = 1
	elseif arg_17_0 == TianShiNaNaEnum.OperDir.Forward then
		var_0_1.y = 1
	elseif arg_17_0 == TianShiNaNaEnum.OperDir.Back then
		var_0_1.y = -1
	end

	return var_0_1
end

function var_0_0.getLimitTimeStr()
	local var_18_0 = ActivityModel.instance:getActMO(VersionActivity2_2Enum.ActivityId.TianShiNaNa)

	if not var_18_0 then
		return ""
	end

	local var_18_1 = var_18_0:getRealEndTimeStamp() - ServerTime.now()

	if var_18_1 > 0 then
		return TimeUtil.SecondToActivityTimeFormat(var_18_1)
	end

	return ""
end

function var_0_0.isBanOper()
	return GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.TianShiNaNaBanOper)
end

return var_0_0
