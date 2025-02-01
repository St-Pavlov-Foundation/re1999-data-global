module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessFightResultStep", package.seeall)

slot0 = class("TeamChessFightResultStep", EliminateTeamChessStepBase)

function slot0.onStart(slot0)
	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessEnemyDie, EliminateLevelModel.instance:getLevelId())

	if GuideModel.instance:isGuideRunning(22013) then
		GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, slot0._finishStep, slot0)
	else
		slot0:_Done()
	end
end

function slot0._finishStep(slot0, slot1)
	if slot1 ~= 22013 then
		return
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, slot0._finishStep, slot0)
	slot0:_Done()
end

function slot0._Done(slot0)
	EliminateLevelController.instance:openEliminateResultView()
	slot0:onDone(true)
end

return slot0
