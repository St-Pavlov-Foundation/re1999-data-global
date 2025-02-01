module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.EliminateTeamChessSyncDataStep", package.seeall)

slot0 = class("EliminateTeamChessSyncDataStep", EliminateTeamChessStepBase)

function slot0.onStart(slot0)
	slot1 = false
	slot2 = EliminateTeamChessModel.instance:getCurTeamChessWar()

	if EliminateTeamChessModel.instance:getServerTeamChessWar() and slot2 then
		slot1 = slot2:updateCondition(slot3.winCondition, slot3.extraWinCondition)

		slot2:updateForecastBehavior(slot3.enemyCharacter.forecastBehavior)
	end

	if slot1 then
		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.LevelConditionChange)
	end

	slot0:onDone(true)
end

return slot0
