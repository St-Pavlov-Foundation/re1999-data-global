module("modules.logic.versionactivity1_3.va3chess.game.step.Va3ChessStepCallEvent", package.seeall)

slot0 = class("Va3ChessStepCallEvent", Va3ChessStepBase)

function slot0.start(slot0)
	if Va3ChessGameController.instance.event then
		slot2:setCurEventByObj(slot0.originData.event)

		slot0._curEvent = slot2:getCurEvent()
	end

	if slot0._curEvent then
		Va3ChessGameController.instance:registerCallback(Va3ChessEvent.EventFinishPlay, slot0.onReceiveFinished, slot0)
	else
		slot0:finish()
	end
end

function slot0.onReceiveFinished(slot0, slot1)
	if slot0._curEvent == slot1 then
		Va3ChessGameController.instance:unregisterCallback(Va3ChessEvent.EventFinishPlay, slot0.onReceiveFinished, slot0)
		slot0:finish()
	end
end

function slot0.finish(slot0)
	if Va3ChessGameController.instance.event then
		slot1:setLockEvent()
	end

	uv0.super.finish(slot0)
end

function slot0.dispose(slot0)
	Va3ChessGameController.instance:unregisterCallback(Va3ChessEvent.EventFinishPlay, slot0.onReceiveFinished, slot0)

	slot0._curEvent = nil

	uv0.super.dispose(slot0)
end

return slot0
