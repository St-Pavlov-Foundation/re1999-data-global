module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessCheckRoundStateStep", package.seeall)

local var_0_0 = class("TeamChessCheckRoundStateStep", EliminateTeamChessStepBase)

function var_0_0.onStart(arg_1_0)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.EnemyForecastChessIdUpdate)
	TaskDispatcher.runDelay(arg_1_0._onDone, arg_1_0, EliminateTeamChessEnum.teamChessToMatchStepTime)
end

function var_0_0._onDone(arg_2_0)
	EliminateLevelController.instance:checkState()
	var_0_0.super._onDone(arg_2_0)
end

return var_0_0
