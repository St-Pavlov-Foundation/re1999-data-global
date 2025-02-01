module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessShowEvaluateStep", package.seeall)

slot0 = class("EliminateChessShowEvaluateStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	if EliminateChessModel.instance:calEvaluateLevel() == nil then
		slot0:onDone(true)

		return
	end

	EliminateChessController.instance:openNoticeView(false, false, false, true, slot1, EliminateEnum.ShowEvaluateTime, slot0._onPlayEnd, slot0)
	EliminateChessModel.instance:clearTotalCount()
end

function slot0._onPlayEnd(slot0)
	slot0:onDone(true)
end

return slot0
