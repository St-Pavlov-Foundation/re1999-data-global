module("modules.logic.versionactivity1_2.yaxian.controller.game.YaXianGameHelper", package.seeall)

local var_0_0 = class("YaXianGameHelper")

function var_0_0.getRowStartPosInScene(arg_1_0)
	return arg_1_0 * YaXianGameEnum.TileSetting.halfWidth, -arg_1_0 * YaXianGameEnum.TileSetting.halfHeight
end

function var_0_0.getPosZ(arg_2_0)
	local var_2_0 = (arg_2_0 - YaXianGameEnum.ScenePosYRange.Min) / YaXianGameEnum.ScenePosYRangeArea

	return Mathf.Lerp(YaXianGameEnum.LevelScenePosZRange.Min, YaXianGameEnum.LevelScenePosZRange.Max, var_2_0)
end

function var_0_0.calcTilePosInScene(arg_3_0, arg_3_1)
	local var_3_0, var_3_1 = var_0_0.getRowStartPosInScene(arg_3_0)
	local var_3_2 = var_3_0 + arg_3_1 * YaXianGameEnum.TileSetting.halfWidth
	local var_3_3 = var_3_1 + arg_3_1 * YaXianGameEnum.TileSetting.halfHeight
	local var_3_4 = var_3_2 + YaXianGameModel.instance.mapOffsetX
	local var_3_5 = var_3_3 + YaXianGameModel.instance.mapOffsetY

	return var_3_4, var_3_5, var_0_0.getPosZ(var_3_5)
end

function var_0_0.calBafflePosInScene(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0, var_4_1, var_4_2 = var_0_0.calcTilePosInScene(arg_4_0, arg_4_1)

	if arg_4_2 == YaXianGameEnum.BaffleDirection.Left then
		var_4_0 = var_4_0 - YaXianGameEnum.TileSetting.baffleOffsetX
		var_4_1 = var_4_1 + YaXianGameEnum.TileSetting.baffleOffsetY
	elseif arg_4_2 == YaXianGameEnum.BaffleDirection.Top then
		var_4_0 = var_4_0 + YaXianGameEnum.TileSetting.baffleOffsetX
		var_4_1 = var_4_1 + YaXianGameEnum.TileSetting.baffleOffsetY
	elseif arg_4_2 == YaXianGameEnum.BaffleDirection.Right then
		var_4_0 = var_4_0 + YaXianGameEnum.TileSetting.baffleOffsetX
		var_4_1 = var_4_1 - YaXianGameEnum.TileSetting.baffleOffsetY
	elseif arg_4_2 == YaXianGameEnum.BaffleDirection.Bottom then
		var_4_0 = var_4_0 - YaXianGameEnum.TileSetting.baffleOffsetX
		var_4_1 = var_4_1 - YaXianGameEnum.TileSetting.baffleOffsetY
	else
		logError("un support direction, please check ... " .. arg_4_2)
	end

	return var_4_0, var_4_1, var_0_0.getPosZ(var_4_1)
end

function var_0_0.hasBaffle(arg_5_0, arg_5_1)
	return bit.band(arg_5_0, bit.lshift(1, arg_5_1)) ~= 0
end

function var_0_0.getBaffleType(arg_6_0, arg_6_1)
	return bit.band(arg_6_0, bit.lshift(1, arg_6_1 - 1)) == 0 and 0 or 1
end

function var_0_0.canBlock(arg_7_0)
	if arg_7_0 then
		return arg_7_0.interactType == YaXianGameEnum.InteractType.Obstacle or arg_7_0.interactType == YaXianGameEnum.InteractType.TriggerFail or arg_7_0.interactType == YaXianGameEnum.InteractType.Player
	end

	return false
end

function var_0_0.canSelect(arg_8_0)
	return arg_8_0 and arg_8_0.interactType == YaXianGameEnum.InteractType.Player
end

function var_0_0.getDirection(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_0 ~= arg_9_2 then
		if arg_9_0 < arg_9_2 then
			return YaXianGameEnum.MoveDirection.Right
		else
			return YaXianGameEnum.MoveDirection.Left
		end
	end

	if arg_9_1 ~= arg_9_3 then
		if arg_9_1 < arg_9_3 then
			return YaXianGameEnum.MoveDirection.Top
		else
			return YaXianGameEnum.MoveDirection.Bottom
		end
	end

	logError(string.format("get direction fail ... startX : %s, startY : %s, targetX : %s, targetY : %s", arg_9_0, arg_9_1, arg_9_2, arg_9_3))
end

function var_0_0.getNextPos(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 == YaXianGameEnum.MoveDirection.Bottom then
		arg_10_1 = arg_10_1 - 1
	elseif arg_10_2 == YaXianGameEnum.MoveDirection.Left then
		arg_10_0 = arg_10_0 - 1
	elseif arg_10_2 == YaXianGameEnum.MoveDirection.Right then
		arg_10_0 = arg_10_0 + 1
	elseif arg_10_2 == YaXianGameEnum.MoveDirection.Top then
		arg_10_1 = arg_10_1 + 1
	else
		logError(string.format("un support direction, x : %s, y : %s, direction : %s", arg_10_0, arg_10_1, arg_10_2))
	end

	return arg_10_0, arg_10_1
end

function var_0_0.getPassPosGenerator(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = var_0_0.getDirection(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	local var_11_1 = false

	return function()
		if var_11_1 then
			return nil
		end

		local var_12_0, var_12_1 = var_0_0.getNextPos(arg_11_0, arg_11_1, var_11_0)

		if var_12_0 == arg_11_2 and var_12_1 == arg_11_3 then
			var_11_1 = true
		end

		arg_11_0, arg_11_1 = var_12_0, var_12_1

		return var_12_0, var_12_1
	end
end

function var_0_0.getPosHashKey(arg_13_0, arg_13_1)
	return arg_13_0 .. "." .. arg_13_1
end

return var_0_0
