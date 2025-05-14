module("modules.logic.versionactivity1_3.va3chess.game.Va3ChessMapUtils", package.seeall)

local var_0_0 = class("Va3ChessMapUtils")
local var_0_1 = 8

function var_0_0.ToDirection(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if arg_1_2 < arg_1_0 then
		if arg_1_3 < arg_1_1 then
			return 1
		elseif arg_1_1 < arg_1_3 then
			return 7
		else
			return 4
		end
	elseif arg_1_0 < arg_1_2 then
		if arg_1_3 < arg_1_1 then
			return 3
		elseif arg_1_1 < arg_1_3 then
			return 9
		else
			return 6
		end
	elseif arg_1_3 < arg_1_1 then
		return 2
	elseif arg_1_1 < arg_1_3 then
		return 8
	else
		return 5
	end
end

function var_0_0.CalNextCellPos(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 == 2 then
		return arg_2_0, arg_2_1 - 1
	elseif arg_2_2 == 8 then
		return arg_2_0, arg_2_1 + 1
	elseif arg_2_2 == 6 then
		return arg_2_0 + 1, arg_2_1
	elseif arg_2_2 == 4 then
		return arg_2_0 - 1, arg_2_1
	end
end

function var_0_0.CalOppositeDir(arg_3_0)
	if arg_3_0 == 2 then
		return 8
	elseif arg_3_0 == 8 then
		return 2
	elseif arg_3_0 == 6 then
		return 4
	elseif arg_3_0 == 4 then
		return 6
	end
end

function var_0_0.IsEdgeTile(arg_4_0, arg_4_1)
	return arg_4_1 == var_0_1 - 1
end

function var_0_0.getClearConditionDesc(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0[1]
	local var_5_1 = var_0_0.conditionDescFuncMap[var_5_0]

	return var_5_1 and var_5_1(arg_5_0, arg_5_1) or ""
end

function var_0_0.isClearConditionFinish(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0[1]
	local var_6_1 = var_0_0.conditionCheckMap[var_6_0]

	if var_6_1 then
		return var_6_1(arg_6_0, arg_6_1)
	end

	return false
end

function var_0_0.calPosIndex(arg_7_0, arg_7_1)
	return arg_7_0 + arg_7_1 * var_0_1
end

function var_0_0.calPosXY(arg_8_0)
	return arg_8_0 % var_0_1, math.floor(arg_8_0 / var_0_1)
end

function var_0_0.getConditionDescRoundLimit(arg_9_0, arg_9_1)
	return string.format(luaLang("chessgame_clear_round_limit"), arg_9_0[2])
end

function var_0_0.getConditionDescInteractFinish(arg_10_0, arg_10_1)
	local var_10_0 = Va3ChessConfig.instance:getInteractObjectCo(arg_10_1, arg_10_0[2])

	return var_10_0 and string.format(luaLang("chessgame_clear_interact_finish"), var_10_0.name) or string.format(luaLang("chessgame_clear_interact_finish"), arg_10_0[2])
end

var_0_0.conditionDescFuncMap = {
	[Va3ChessEnum.ChessClearCondition.RoundLimit] = var_0_0.getConditionDescRoundLimit,
	[Va3ChessEnum.ChessClearCondition.InteractFinish] = var_0_0.getConditionDescInteractFinish
}

function var_0_0.checkRoundLimit(arg_11_0, arg_11_1)
	if not Va3ChessGameModel.instance:getResult() then
		return false
	else
		return Va3ChessGameModel.instance:getRound() <= arg_11_0[2]
	end
end

function var_0_0.checkInteractFinish(arg_12_0, arg_12_1)
	if arg_12_1 == VersionActivity1_3Enum.ActivityId.Act304 then
		return Va3ChessGameModel.instance:isInteractFinish(arg_12_0[2], true)
	end

	for iter_12_0 = 2, #arg_12_0 do
		if not Va3ChessGameModel.instance:isInteractFinish(arg_12_0[iter_12_0]) then
			return false
		end
	end

	return #arg_12_0 > 1
end

function var_0_0.checkHpLimit(arg_13_0, arg_13_1)
	return Va3ChessGameModel.instance:getHp() >= arg_13_0[2]
end

function var_0_0.checkAllInteractFinish(arg_14_0, arg_14_1)
	if Va3ChessGameModel.instance:getResult() == false then
		return false
	end

	local var_14_0 = 0

	for iter_14_0 = 2, #arg_14_0 do
		if not Va3ChessGameModel.instance:isInteractFinish(arg_14_0[iter_14_0]) then
			var_14_0 = var_14_0 + 1
		end
	end

	if var_14_0 > 0 then
		return false, var_14_0
	else
		return true
	end
end

function var_0_0.calBulletFlyTime(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = Va3ChessEnum.DEFAULT_BULLET_FLY_TIME

	arg_15_0 = arg_15_0 or Va3ChessEnum.DEFAULT_BULLET_SPEED

	if arg_15_1 and arg_15_2 and arg_15_3 and arg_15_4 then
		local var_15_1 = math.pow(arg_15_3 - arg_15_1, 2)
		local var_15_2 = math.pow(arg_15_4 - arg_15_2, 2)

		var_15_0 = math.sqrt(var_15_1 + var_15_2) / arg_15_0
	end

	return var_15_0
end

var_0_0.conditionCheckMap = {
	[Va3ChessEnum.ChessClearCondition.RoundLimit] = var_0_0.checkRoundLimit,
	[Va3ChessEnum.ChessClearCondition.InteractFinish] = var_0_0.checkInteractFinish,
	[Va3ChessEnum.ChessClearCondition.HpLimit] = var_0_0.checkHpLimit,
	[Va3ChessEnum.ChessClearCondition.InteractAllFinish] = var_0_0.checkAllInteractFinish
}

return var_0_0
