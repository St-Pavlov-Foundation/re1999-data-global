module("modules.logic.activity.controller.chessmap.step.ActivityChessStepCallEvent", package.seeall)

slot0 = class("ActivityChessStepCallEvent", ActivityChessStepBase)

function slot0.start(slot0)
	if ActivityChessGameController.instance.event then
		slot2:setCurEventByObj(slot0.originData.event)

		slot0._curEvent = slot2:getCurEvent()
	end

	if slot0._curEvent then
		ActivityChessGameController.instance:registerCallback(ActivityChessEvent.EventFinishPlay, slot0.onReceiveFinished, slot0)
	else
		slot0:finish()
	end
end

function slot0.onReceiveFinished(slot0, slot1)
	if slot0._curEvent == slot1 then
		ActivityChessGameController.instance:unregisterCallback(ActivityChessEvent.EventFinishPlay, slot0.onReceiveFinished, slot0)
		slot0:finish()
	end
end

function slot0.finish(slot0)
	if ActivityChessGameController.instance.event then
		slot1:setLockEvent()
	end

	uv0.super.finish(slot0)
end

function slot0.dispose(slot0)
	ActivityChessGameController.instance:unregisterCallback(ActivityChessEvent.EventFinishPlay, slot0.onReceiveFinished, slot0)

	slot0._curEvent = nil

	uv0.super.dispose(slot0)
end

return slot0
