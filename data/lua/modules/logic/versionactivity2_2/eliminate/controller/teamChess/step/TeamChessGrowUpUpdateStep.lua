module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessGrowUpUpdateStep", package.seeall)

slot0 = class("TeamChessGrowUpUpdateStep", EliminateTeamChessStepBase)

function slot0.onStart(slot0)
	slot1 = slot0._data
	slot3 = slot1.skillId
	slot4 = slot1.upValue

	if slot1.uid == nil or slot3 == nil or slot4 == nil then
		slot0:onDone(true)

		return
	end

	EliminateTeamChessModel.instance:updateSkillGrowUp(slot2, slot3, slot4)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.TeamChessGrowUpSkillChange, slot2, slot3, slot4)
	TaskDispatcher.runDelay(slot0._onDone, slot0, EliminateTeamChessEnum.teamChessGrowUpChangeStepTime)
end

return slot0
