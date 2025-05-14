module("modules.logic.versionactivity2_2.eliminate.model.mo.TeamChessUnitMO", package.seeall)

local var_0_0 = class("TeamChessUnitMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	arg_1_0.uid = arg_1_1 or 0
	arg_1_0.soldierId = arg_1_2 or 0
	arg_1_0.stronghold = arg_1_3 or 0
	arg_1_0.pos = arg_1_4 or 0
	arg_1_0.teamType = arg_1_5 or 0
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	arg_2_0.uid = arg_2_1
	arg_2_0.soldierId = arg_2_2
	arg_2_0.stronghold = arg_2_3
	arg_2_0.pos = arg_2_4
	arg_2_0.teamType = arg_2_5
end

function var_0_0.getUid(arg_3_0)
	return arg_3_0.uid
end

function var_0_0.getSoldierConfig(arg_4_0)
	return EliminateConfig.instance:getSoldierChessConfig(arg_4_0.soldierId)
end

function var_0_0.getUnitPath(arg_5_0)
	return EliminateConfig.instance:getSoldierChessModelPath(arg_5_0.soldierId)
end

function var_0_0.getScale(arg_6_0)
	return arg_6_0:getSoldierConfig().resZoom
end

function var_0_0.getOrder(arg_7_0)
	local var_7_0 = 0
	local var_7_1 = EliminateTeamChessModel.instance:getStronghold(arg_7_0.stronghold)

	if arg_7_0.teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		var_7_0 = EliminateConfig.instance:getStrongHoldConfig(arg_7_0.stronghold).enemyCapacity - var_7_1:getEnemySideIndexByUid(arg_7_0.uid)
	end

	if arg_7_0.teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		var_7_0 = var_7_1:getMySideIndexByUid(arg_7_0.uid)
	end

	return var_7_0
end

function var_0_0.canActiveMove(arg_8_0)
	local var_8_0 = EliminateTeamChessModel.instance:getChess(arg_8_0.uid)

	return var_8_0 and var_8_0:canActiveMove() or false
end

function var_0_0.clear(arg_9_0)
	arg_9_0.uid = 0
	arg_9_0.soldierId = 0
	arg_9_0.stronghold = 0
	arg_9_0.pos = 0
	arg_9_0.teamType = 0
end

return var_0_0
