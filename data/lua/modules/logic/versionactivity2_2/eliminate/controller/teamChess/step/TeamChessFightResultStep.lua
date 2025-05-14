module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.TeamChessFightResultStep", package.seeall)

local var_0_0 = class("TeamChessFightResultStep", EliminateTeamChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = EliminateLevelModel.instance:getLevelId()

	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessEnemyDie, var_1_0)

	if GuideModel.instance:isGuideRunning(22013) then
		GuideController.instance:registerCallback(GuideEvent.FinishGuideLastStep, arg_1_0._finishStep, arg_1_0)
	else
		arg_1_0:_Done()
	end
end

function var_0_0._finishStep(arg_2_0, arg_2_1)
	if arg_2_1 ~= 22013 then
		return
	end

	GuideController.instance:unregisterCallback(GuideEvent.FinishGuideLastStep, arg_2_0._finishStep, arg_2_0)
	arg_2_0:_Done()
end

function var_0_0._Done(arg_3_0)
	EliminateLevelController.instance:openEliminateResultView()
	arg_3_0:onDone(true)
end

return var_0_0
