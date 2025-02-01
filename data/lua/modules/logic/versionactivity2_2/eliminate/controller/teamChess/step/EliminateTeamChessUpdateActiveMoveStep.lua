module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.EliminateTeamChessUpdateActiveMoveStep", package.seeall)

slot0 = class("EliminateTeamChessUpdateActiveMoveStep", EliminateTeamChessStepBase)

function slot0.onStart(slot0)
	slot1 = slot0._data
	slot3 = slot1.displacementState

	if slot1.uid == nil or slot3 == nil then
		slot0:onDone(true)

		return
	end

	EliminateTeamChessModel.instance:updateDisplacementState(slot2, slot3)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessUpdateActiveMoveState, slot2)
	TaskDispatcher.runDelay(slot0._onDone, slot0, EliminateTeamChessEnum.teamChessUpdateActiveMoveStepTime)
end

return slot0
