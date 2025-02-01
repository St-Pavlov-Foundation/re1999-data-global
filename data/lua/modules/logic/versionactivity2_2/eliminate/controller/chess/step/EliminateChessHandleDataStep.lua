module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessHandleDataStep", package.seeall)

slot0 = class("EliminateChessHandleDataStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	if EliminateChessController.instance:getCurTurn() == nil then
		EliminateChessController.instance:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.ShowEvaluate))

		if EliminateChessModel.instance:getNeedResetData() ~= nil then
			EliminateChessController.instance:buildSeqFlow(EliminateStepUtil.createStep(EliminateEnum.StepWorkType.RefreshEliminate))
		end

		slot0:onDone(true)

		return
	end

	EliminateChessController.instance:handleEliminate(slot1.eliminate)
	EliminateChessController.instance:handleDrop(slot1.tidyUp, slot1.fillChessBoard)
	slot0:onDone(true)
end

return slot0
