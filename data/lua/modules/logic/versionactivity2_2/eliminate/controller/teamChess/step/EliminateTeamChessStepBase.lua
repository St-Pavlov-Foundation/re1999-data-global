module("modules.logic.versionactivity2_2.eliminate.controller.teamChess.step.EliminateTeamChessStepBase", package.seeall)

slot0 = class("EliminateTeamChessStepBase", BaseWork)

function slot0.initData(slot0, slot1)
	slot0._data = slot1
end

function slot0.onStart(slot0)
	slot0:onDone(true)
end

function slot0._onDone(slot0)
	slot0:onDone(true)
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._onDone, slot0)
end

return slot0
