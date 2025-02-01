module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessShowStartStep", package.seeall)

slot0 = class("EliminateChessShowStartStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	EliminateChessController.instance:openNoticeView(true, false, false, false, 0, slot0._data, slot0._onPlayEnd, slot0)
end

function slot0._onPlayEnd(slot0)
	EliminateChessController.instance:dispatchEvent(EliminateChessEvent.Match3ChessBeginViewClose)
	slot0:onDone(true)
end

return slot0
