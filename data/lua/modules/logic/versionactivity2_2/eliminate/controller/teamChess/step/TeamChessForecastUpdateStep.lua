module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessForecastUpdateStep", package.seeall)

local var_0_0 = class("TeamChessForecastUpdateStep", EliminateTeamChessStepBase)

function var_0_0.onStart(arg_1_0)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.EnemyForecastChessIdUpdate)
	TaskDispatcher.runDelay(arg_1_0._onDone, arg_1_0, EliminateTeamChessEnum.teamChessForecastUpdateStep)
end

function var_0_0._onDone(arg_2_0)
	local var_2_0 = EliminateTeamChessModel.instance:getCurTeamChessWar()
	local var_2_1 = EliminateTeamChessModel.instance:getServerTeamChessWar()

	if var_2_1 and var_2_0 then
		var_2_0:updateForecastBehavior(var_2_1.enemyCharacter.forecastBehavior)
	end

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.EnemyForecastChessIdUpdate)
	var_0_0.super._onDone(arg_2_0)
end

return var_0_0
