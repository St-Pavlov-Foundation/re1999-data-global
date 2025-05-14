module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessPerformReductionStep", package.seeall)

local var_0_0 = class("TeamChessPerformReductionStep", EliminateTeamChessStepBase)

function var_0_0.onStart(arg_1_0)
	EliminateTeamChessController.instance:dispatchEvent(EliminateChessEvent.StrongHoldPerformReduction)
	TeamChessUnitEntityMgr.instance:restoreEntityShowMode()

	local var_1_0 = EliminateTeamChessModel.instance:getStrongholds()
	local var_1_1 = 0

	for iter_1_0, iter_1_1 in pairs(var_1_0) do
		var_1_1 = var_1_1 + iter_1_1:getPlayerSoliderCount()
	end

	local var_1_2 = EliminateLevelModel.instance:getLevelId()

	if var_1_1 > 0 then
		EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamSettleEndAndIsHavePlayerSolider)
	end

	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamSettleEndAndPlayerSoliderCount, string.format("%s_%s", var_1_2, var_1_1))

	if GuideModel.instance:isGuideRunning(22011) or GuideModel.instance:isGuideRunning(22012) then
		GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, arg_1_0._gudieEnd, arg_1_0)
	else
		TaskDispatcher.runDelay(arg_1_0._onDone, arg_1_0, EliminateTeamChessEnum.teamChessUpdateActiveMoveStepTime)
	end
end

function var_0_0._gudieEnd(arg_2_0, arg_2_1)
	if arg_2_1 ~= 22011 and arg_2_1 ~= 22012 then
		return
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, arg_2_0._gudieEnd, arg_2_0)
	arg_2_0:_onDone(true)
end

return var_0_0
