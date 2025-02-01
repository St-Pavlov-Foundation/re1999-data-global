module("modules.logic.versionactivity2_2.eliminate.controller.chess.step.EliminateChessDieStep", package.seeall)

slot0 = class("EliminateChessDieStep", EliminateChessStepBase)

function slot0.onStart(slot0)
	slot0.resourceIds = slot0._data.resourceIds
	slot3 = slot0._data.source
	slot0.chess = EliminateChessItemController.instance:getChessItem(slot0._data.x, slot0._data.y)

	if not slot0.chess then
		logError("步骤 Die 棋子：" .. slot1, slot2 .. "不存在")
		slot0:onDone(true)

		return
	end

	slot0.chess:toDie(EliminateEnum.AniTime.Die, slot3)
	TaskDispatcher.runDelay(slot0._onDone, slot0, EliminateEnum.DieStepTime)
	TaskDispatcher.runDelay(slot0._playFly, slot0, EliminateEnum.DieToFlyOffsetTime)
end

function slot0._playFly(slot0)
	TaskDispatcher.cancelTask(slot0._playFly, slot0)

	if slot0.chess ~= nil and slot0.resourceIds ~= nil then
		slot0.chess:toFlyResource(slot0.resourceIds)
	end
end

function slot0.clearWork(slot0)
	TaskDispatcher.cancelTask(slot0._playFly, slot0)
	uv0.super.clearWork(slot0)
end

return slot0
