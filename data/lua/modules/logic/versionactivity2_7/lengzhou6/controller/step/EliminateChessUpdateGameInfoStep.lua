module("modules.logic.versionactivity2_7.lengzhou6.controller.step.EliminateChessUpdateGameInfoStep", package.seeall)

local var_0_0 = class("EliminateChessUpdateGameInfoStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.UpdateGameInfo)
	LengZhou6EliminateController.instance:dispatchEvent(LengZhou6Event.UpdatePlayerSkill)
	LocalEliminateChessModel.instance:updateSpEffectCd()
	LengZhou6GameModel.instance:clearTempData()
	LocalEliminateChessModel.instance:roundDataClear()

	if LengZhou6GameModel.instance:gameIsOver() then
		LengZhou6GameController.instance:gameEnd()
	else
		local var_1_0 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.EliminateCheckAndRefresh)

		LengZhou6EliminateController.instance:buildSeqFlow(var_1_0)
	end

	arg_1_0:_onDone()
end

return var_0_0
