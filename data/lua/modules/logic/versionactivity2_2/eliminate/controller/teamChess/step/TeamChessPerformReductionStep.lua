module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessPerformReductionStep", package.seeall)

slot0 = class("TeamChessPerformReductionStep", EliminateTeamChessStepBase)

function slot0.onStart(slot0)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.StrongHoldPerformReduction)
	TeamChessUnitEntityMgr.instance:restoreEntityShowMode()

	for slot6, slot7 in pairs(EliminateTeamChessModel.instance:getStrongholds()) do
		slot2 = 0 + slot7:getPlayerSoliderCount()
	end

	slot3 = EliminateLevelModel.instance:getLevelId()

	if slot2 > 0 then
		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamSettleEndAndIsHavePlayerSolider)
	end

	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamSettleEndAndPlayerSoliderCount, string.format("%s_%s", slot3, slot2))

	if GuideModel.instance:isGuideRunning(22011) or GuideModel.instance:isGuideRunning(22012) then
		GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, slot0._gudieEnd, slot0)
	else
		TaskDispatcher.runDelay(slot0._onDone, slot0, EliminateTeamChessEnum.teamChessUpdateActiveMoveStepTime)
	end
end

function slot0._gudieEnd(slot0, slot1)
	if slot1 ~= 22011 and slot1 ~= 22012 then
		return
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, slot0._gudieEnd, slot0)
	slot0:_onDone(true)
end

return slot0
