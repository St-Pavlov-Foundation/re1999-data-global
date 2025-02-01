module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.EliminateTeamChessBeginStep", package.seeall)

slot0 = class("EliminateTeamChessBeginStep", EliminateTeamChessStepBase)

function slot0.onStart(slot0)
	slot1 = slot0._data.time

	EliminateChessController.instance:openNoticeView(false, false, true, false, 0, slot1, nil, )
	TaskDispatcher.runDelay(slot0._onDone, slot0, slot1)
end

function slot0._onDone(slot0)
	EliminateLevelController.instance:dispatchEvent(EliminateChessEvent.TeamChessRoundBegin, string.format("%s_%s", EliminateLevelModel.instance:getLevelId(), EliminateLevelModel.instance:getRoundNumber()))
	uv0.super._onDone(slot0)
end

return slot0
