module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessForecastUpdateStep", package.seeall)

slot0 = class("TeamChessForecastUpdateStep", EliminateTeamChessStepBase)

function slot0.onStart(slot0)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.EnemyForecastChessIdUpdate)
	TaskDispatcher.runDelay(slot0._onDone, slot0, EliminateTeamChessEnum.teamChessForecastUpdateStep)
end

function slot0._onDone(slot0)
	slot1 = EliminateTeamChessModel.instance:getCurTeamChessWar()

	if EliminateTeamChessModel.instance:getServerTeamChessWar() and slot1 then
		slot1:updateForecastBehavior(slot2.enemyCharacter.forecastBehavior)
	end

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.EnemyForecastChessIdUpdate)
	uv0.super._onDone(slot0)
end

return slot0
