module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessHandleDataStep", package.seeall)

local var_0_0 = class("EliminateChessHandleDataStep", EliminateChessStepBase)

function var_0_0.onStart(arg_1_0)
	local var_1_0 = EliminateChessController.instance:getCurTurn()

	if var_1_0 == nil then
		local var_1_1 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.ShowEvaluate)

		EliminateChessController.instance:buildSeqFlow(var_1_1)

		if EliminateChessModel.instance:getNeedResetData() ~= nil then
			local var_1_2 = EliminateStepUtil.createStep(EliminateEnum.StepWorkType.RefreshEliminate)

			EliminateChessController.instance:buildSeqFlow(var_1_2)
		end

		arg_1_0:onDone(true)

		return
	end

	EliminateChessController.instance:handleEliminate(var_1_0.eliminate)
	EliminateChessController.instance:handleDrop(var_1_0.tidyUp, var_1_0.fillChessBoard)
	arg_1_0:onDone(true)
end

return var_0_0
