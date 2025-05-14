module("modules.logic.chessgame.controller.ChessGameHelper", package.seeall)

local var_0_0 = class("ChessGameHelper")

function var_0_0.isNodeWalkable(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = ChessGameNodeModel.instance:getNode(arg_1_0, arg_1_1)

	if not var_1_0 then
		return false
	end

	return var_1_0:isCanWalk(arg_1_2)
end

function var_0_0.nodePosToWorldPos(arg_2_0)
	local var_2_0 = Vector3.New()

	var_2_0.x = (arg_2_0.x + arg_2_0.y) * ChessGameEnum.NodeXOffset
	var_2_0.y = (arg_2_0.y - arg_2_0.x) * ChessGameEnum.NodeYOffset
	var_2_0.z = (arg_2_0.y - arg_2_0.x) * ChessGameEnum.NodeZOffset

	return var_2_0
end

function var_0_0.worldPosToNodePos(arg_3_0)
	local var_3_0 = Vector3.New()
	local var_3_1 = arg_3_0.x / ChessGameEnum.NodeXOffset
	local var_3_2 = arg_3_0.y / ChessGameEnum.NodeYOffset

	var_3_0.x = Mathf.Round((var_3_1 - var_3_2) / 2)
	var_3_0.y = Mathf.Round((var_3_1 + var_3_2) / 2)

	return var_3_0
end

function var_0_0.getMap()
	if GameSceneMgr.instance:getCurSceneType() ~= SceneType.ChessGame then
		return
	end

	return GameSceneMgr.instance:getCurScene().map
end

local var_0_1 = 8

function var_0_0.ToDirection(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if arg_5_2 < arg_5_0 then
		if arg_5_3 < arg_5_1 then
			return 1
		elseif arg_5_1 < arg_5_3 then
			return 7
		else
			return 4
		end
	elseif arg_5_0 < arg_5_2 then
		if arg_5_3 < arg_5_1 then
			return 3
		elseif arg_5_1 < arg_5_3 then
			return 9
		else
			return 6
		end
	elseif arg_5_3 < arg_5_1 then
		return 2
	elseif arg_5_1 < arg_5_3 then
		return 8
	else
		return 5
	end
end

function var_0_0.CalNextCellPos(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2 == 2 then
		return arg_6_0, arg_6_1 - 1
	elseif arg_6_2 == 8 then
		return arg_6_0, arg_6_1 + 1
	elseif arg_6_2 == 6 then
		return arg_6_0 + 1, arg_6_1
	elseif arg_6_2 == 4 then
		return arg_6_0 - 1, arg_6_1
	end
end

function var_0_0.CalOppositeDir(arg_7_0)
	if arg_7_0 == 2 then
		return 8
	elseif arg_7_0 == 8 then
		return 2
	elseif arg_7_0 == 6 then
		return 4
	elseif arg_7_0 == 4 then
		return 6
	end
end

function var_0_0.IsEdgeTile(arg_8_0, arg_8_1)
	return arg_8_1 == var_0_1 - 1
end

function var_0_0.getClearConditionDesc(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0[1]
	local var_9_1 = var_0_0.conditionDescFuncMap[var_9_0]

	return var_9_1 and var_9_1(arg_9_0, arg_9_1) or ""
end

function var_0_0.isClearConditionFinish(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0[1]
	local var_10_1 = var_0_0.conditionCheckMap[var_10_0]

	if var_10_1 then
		return var_10_1(arg_10_0, arg_10_1)
	end

	return false
end

function var_0_0.calPosIndex(arg_11_0, arg_11_1)
	return arg_11_0 + arg_11_1 * var_0_1
end

function var_0_0.calPosXY(arg_12_0)
	return arg_12_0 % var_0_1, math.floor(arg_12_0 / var_0_1)
end

function var_0_0.getConditionDescRoundLimit(arg_13_0, arg_13_1)
	return string.format(luaLang("chessgame_clear_round_limit"), arg_13_0[2])
end

function var_0_0.getConditionDescInteractFinish(arg_14_0, arg_14_1)
	local var_14_0 = ChessGameConfig.instance:getInteractObjectCo(arg_14_1, arg_14_0[2])

	return var_14_0 and string.format(luaLang("chessgame_clear_interact_finish"), var_14_0.name) or string.format(luaLang("chessgame_clear_interact_finish"), arg_14_0[2])
end

function var_0_0.checkRoundLimit(arg_15_0, arg_15_1)
	if not ChessGameModel.instance:getResult() then
		return false
	else
		return ChessGameModel.instance:getRound() <= arg_15_0[2]
	end
end

function var_0_0.checkInteractFinish(arg_16_0, arg_16_1)
	for iter_16_0 = 2, #arg_16_0 do
		if not ChessGameInteractModel.instance:checkInteractFinish(arg_16_0[iter_16_0]) then
			return false
		end
	end

	return #arg_16_0 > 1
end

function var_0_0.checkHpLimit(arg_17_0, arg_17_1)
	return ChessGameModel.instance:getHp() >= arg_17_0[2]
end

function var_0_0.checkAllInteractFinish(arg_18_0, arg_18_1)
	if ChessGameModel.instance:getResult() == false then
		return false
	end

	local var_18_0 = 0

	for iter_18_0 = 2, #arg_18_0 do
		if not ChessGameModel.instance:isInteractFinish(arg_18_0[iter_18_0]) then
			var_18_0 = var_18_0 + 1
		end
	end

	if var_18_0 > 0 then
		return false, var_18_0
	else
		return true
	end
end

function var_0_0.calBulletFlyTime(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
	local var_19_0 = ChessGameEnum.DEFAULT_BULLET_FLY_TIME

	arg_19_0 = arg_19_0 or ChessGameEnum.DEFAULT_BULLET_SPEED

	if arg_19_1 and arg_19_2 and arg_19_3 and arg_19_4 then
		local var_19_1 = math.pow(arg_19_3 - arg_19_1, 2)
		local var_19_2 = math.pow(arg_19_4 - arg_19_2, 2)

		var_19_0 = math.sqrt(var_19_1 + var_19_2) / arg_19_0
	end

	return var_19_0
end

var_0_0.conditionCheckMap = {
	[ChessGameEnum.ChessClearCondition.InteractFinish] = var_0_0.checkInteractFinish,
	[ChessGameEnum.ChessClearCondition.InteractAllFinish] = var_0_0.checkAllInteractFinish
}

return var_0_0
