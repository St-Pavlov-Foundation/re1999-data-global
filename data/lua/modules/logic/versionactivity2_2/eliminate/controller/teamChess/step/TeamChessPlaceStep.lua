module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessPlaceStep", package.seeall)

slot0 = class("TeamChessPlaceStep", EliminateTeamChessStepBase)

function slot0.onStart(slot0)
	if EliminateTeamChessModel.instance:getCurTeamRoundStepState() == EliminateTeamChessEnum.TeamChessRoundType.enemy then
		EliminateLevelController.instance:registerCallback(EliminateChessEvent.LevelDialogClosed, slot0._checkRoundStep, slot0)
		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessEnemyPlaceBefore)
	else
		slot0:_checkRoundStep()
	end
end

function slot0._checkRoundStep(slot0)
	EliminateLevelController.instance:unregisterCallback(EliminateChessEvent.LevelDialogClosed, slot0._checkRoundStep, slot0)

	slot1 = slot0._data
	slot2 = EliminateTeamChessModel.instance:getStronghold(slot1.strongholdId)
	slot3 = slot1.chessPiece

	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.AddStrongholdChess, slot2:getChess(slot3.uid), slot1.strongholdId, slot2:updatePiece(slot3.teamType, slot3))
	TaskDispatcher.runDelay(slot0._onDone, slot0, EliminateTeamChessEnum.teamChessPlaceStep)
end

return slot0
