module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessCheckRoundStateStep", package.seeall)

slot0 = class("TeamChessCheckRoundStateStep", EliminateTeamChessStepBase)

function slot0.onStart(slot0)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.EnemyForecastChessIdUpdate)
	TaskDispatcher.runDelay(slot0._onDone, slot0, EliminateTeamChessEnum.teamChessToMatchStepTime)
end

function slot0._onDone(slot0)
	EliminateLevelController.instance:checkState()
	uv0.super._onDone(slot0)
end

return slot0
