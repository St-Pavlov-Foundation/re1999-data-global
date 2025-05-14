module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.StrongHoldSettleStep", package.seeall)

local var_0_0 = class("StrongHoldSettleStep", EliminateTeamChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = arg_1_0._data
	local var_1_1 = var_1_0.strongholdId
	local var_1_2 = var_1_0.state

	TeamChessUnitEntityMgr.instance:cacheEntityShowMode(var_1_1)
	EliminateTeamChessModel.instance:strongHoldSettle(var_1_1, var_1_2)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.StrongHoldSettle, var_1_1, var_1_2)

	local var_1_3 = ""

	if EliminateTeamChessEnum.StrongHoldState.enemySide == var_1_2 then
		var_1_3 = tostring(EliminateTeamChessEnum.TeamChessTeamType.enemy)
	end

	if EliminateTeamChessEnum.StrongHoldState.mySide == var_1_2 then
		var_1_3 = tostring(EliminateTeamChessEnum.TeamChessTeamType.player)
	end

	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.SettleAndToHaveDamage, var_1_3)

	local var_1_4 = EliminateTeamChessModel.instance:getStronghold(var_1_1)
	local var_1_5 = var_1_4:getPlayerSoliderCount()
	local var_1_6 = var_1_4:getEnemySoliderCount()
	local var_1_7 = 0

	if var_1_5 > 0 or var_1_6 > 0 then
		var_1_7 = var_1_7 + EliminateTeamChessEnum.teamChessUpdateActiveMoveStepTime
		var_1_7 = var_1_7 + EliminateTeamChessEnum.StrongHoldBattleVxTime
	end

	if var_1_4.enemyScore ~= var_1_4.myScore then
		var_1_7 = var_1_7 + math.max(EliminateTeamChessEnum.teamChessWinOpenTime, EliminateTeamChessEnum.teamChessUpdateActiveMoveStepTime)
	end

	if var_1_7 > 0 then
		TaskDispatcher.runDelay(arg_1_0._onDone, arg_1_0, var_1_7)
	else
		arg_1_0:onDone(true)
	end
end

return var_0_0
