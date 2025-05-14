module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessRemoveStep", package.seeall)

local var_0_0 = class("TeamChessRemoveStep", EliminateTeamChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data

	arg_1_0.strongholdId = var_1_0.strongholdId
	arg_1_0.uid = var_1_0.uid

	local var_1_1 = var_1_0.targetStrongholdId
	local var_1_2 = EliminateTeamChessEnum.soliderChessOutAniTime
	local var_1_3 = arg_1_0:calMoveOtherChessTime(var_1_2)

	if var_1_1 ~= nil then
		var_1_3 = var_1_3 + EliminateTeamChessEnum.chessShowMoveStateAniTime

		local var_1_4 = EliminateTeamChessModel.instance:sourceStrongHoldInRight(arg_1_0.strongholdId, var_1_1) and -1 or 1
		local var_1_5, var_1_6, var_1_7 = TeamChessUnitEntityMgr.instance:getEntity(arg_1_0.uid):getTopPosXYZ()

		EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.ShowChessEffect, EliminateTeamChessEnum.VxEffectType.Move, var_1_5, var_1_6, var_1_7, var_1_4, var_1_4, var_1_4)
		TaskDispatcher.runDelay(arg_1_0._playRemoveChess, arg_1_0, EliminateTeamChessEnum.chessShowMoveStateAniTime)
	else
		arg_1_0:_playRemoveChess()
	end

	TaskDispatcher.runDelay(arg_1_0._onDone, arg_1_0, var_1_3)
end

function var_0_0.calMoveOtherChessTime(arg_2_0, arg_2_1)
	local var_2_0 = EliminateTeamChessModel.instance:getStronghold(arg_2_0.strongholdId)
	local var_2_1 = var_2_0:getChess(arg_2_0.uid)
	local var_2_2 = false
	local var_2_3 = 0
	local var_2_4 = 0

	if var_2_1.teamType == EliminateTeamChessEnum.TeamChessTeamType.player then
		var_2_3 = var_2_0:getMySideIndexByUid(arg_2_0.uid)
		var_2_4 = var_2_0:getPlayerSoliderCount()
	end

	if var_2_1.teamType == EliminateTeamChessEnum.TeamChessTeamType.enemy then
		var_2_3 = var_2_0:getEnemySideIndexByUid(arg_2_0.uid)
		var_2_4 = var_2_0:getEnemySoliderCount()
	end

	if var_2_4 > 1 and var_2_3 ~= var_2_4 then
		arg_2_1 = arg_2_1 + EliminateTeamChessEnum.teamChessPlaceStep
	end

	return arg_2_1
end

function var_0_0._playRemoveChess(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._playRemoveChess, arg_3_0)

	local var_3_0 = EliminateTeamChessModel.instance:getStronghold(arg_3_0.strongholdId)
	local var_3_1 = var_3_0:getMySideIndexByUid(arg_3_0.uid)
	local var_3_2 = var_3_0:getChess(arg_3_0.uid)

	EliminateTeamChessModel.instance:removeStrongholdChess(arg_3_0.strongholdId, arg_3_0.uid)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.RemoveStrongholdChess, arg_3_0.strongholdId, arg_3_0.uid, var_3_1, var_3_2.teamType)
end

return var_0_0
