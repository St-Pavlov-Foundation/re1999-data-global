module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessShowEndStep", package.seeall)

slot0 = class("EliminateChessShowEndStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	slot0._cb = slot0._data.cb

	if slot0._data.needShowEnd then
		EliminateChessController.instance:dispatchEvent(EliminateChessEvent.Match3ChessEndViewOpen)
		EliminateChessController.instance:openNoticeView(false, true, false, false, 0, math.min(slot0._data.time, EliminateTeamChessEnum.matchToTeamChessStepTime), nil, )
	end

	TaskDispatcher.runDelay(slot0._onDone, slot0, slot3)
end

function slot0._onDone(slot0)
	if slot0._cb then
		slot0._cb()
	end

	uv0.super._onDone(slot0)
end

return slot0
