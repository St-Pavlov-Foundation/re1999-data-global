module("modules.logic.activity.controller.chessmap.ActivityChessMapUtils", package.seeall)

local var_0_0 = class("ActivityChessMapUtils")

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

function var_0_0.getClearConditionDesc(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0[1]
	local var_2_1 = var_0_0.conditionDescFuncMap[var_2_0]

	return var_2_1 and var_2_1(arg_2_0, arg_2_1) or ""
end

function var_0_0.isClearConditionFinish(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0[1]
	local var_3_1 = var_0_0.conditionCheckMap[var_3_0]

	if var_3_1 then
		return var_3_1(arg_3_0, arg_3_1)
	end

	return false
end

function var_0_0.getConditionDescRoundLimit(arg_4_0, arg_4_1)
	return string.format(luaLang("chessgame_clear_round_limit"), arg_4_0[2])
end

function var_0_0.getConditionDescInteractFinish(arg_5_0, arg_5_1)
	local var_5_0 = Activity109Config.instance:getInteractObjectCo(arg_5_1, arg_5_0[2])

	return var_5_0 and string.format(luaLang("chessgame_clear_interact_finish"), var_5_0.name) or string.format(luaLang("chessgame_clear_interact_finish"), arg_5_0[2])
end

var_0_0.conditionDescFuncMap = {
	[ActivityChessEnum.ChessClearCondition.RoundLimit] = var_0_0.getConditionDescRoundLimit,
	[ActivityChessEnum.ChessClearCondition.InteractFinish] = var_0_0.getConditionDescInteractFinish
}

function var_0_0.checkRoundLimit(arg_6_0, arg_6_1)
	if not ActivityChessGameModel.instance:getResult() then
		return false
	else
		return ActivityChessGameModel.instance:getRound() <= arg_6_0[2]
	end
end

function var_0_0.checkInteractFinish(arg_7_0, arg_7_1)
	if ActivityChessGameModel.instance:getResult() == false then
		return false
	end

	return ActivityChessGameModel.instance:isInteractFinish(arg_7_0[2])
end

var_0_0.conditionCheckMap = {
	[ActivityChessEnum.ChessClearCondition.RoundLimit] = var_0_0.checkRoundLimit,
	[ActivityChessEnum.ChessClearCondition.InteractFinish] = var_0_0.checkInteractFinish
}

return var_0_0
