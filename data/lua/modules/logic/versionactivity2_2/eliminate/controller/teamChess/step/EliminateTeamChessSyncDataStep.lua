module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.EliminateTeamChessSyncDataStep", package.seeall)

local var_0_0 = class("EliminateTeamChessSyncDataStep", EliminateTeamChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = false
	local var_1_1 = EliminateTeamChessModel.instance:getCurTeamChessWar()
	local var_1_2 = EliminateTeamChessModel.instance:getServerTeamChessWar()

	if var_1_2 and var_1_1 then
		var_1_0 = var_1_1:updateCondition(var_1_2.winCondition, var_1_2.extraWinCondition)

		var_1_1:updateForecastBehavior(var_1_2.enemyCharacter.forecastBehavior)
	end

	if var_1_0 then
		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.LevelConditionChange)
	end

	arg_1_0:onDone(true)
end

return var_0_0
