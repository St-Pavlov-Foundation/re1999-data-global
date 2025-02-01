module("modules.logic.versionactivity1_3.va3chess.game.event.Va3ChessStateFinishEvent", package.seeall)

slot0 = class("Va3ChessStateFinishEvent", Va3ChessStateBase)

function slot0.start(slot0)
	logNormal("Va3ChessStateFinishEvent start")

	if ViewMgr.instance:isOpenFinish(Va3ChessGameController.instance:getViewName()) then
		slot0:sendRequest()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
	end
end

function slot0.onOpenViewFinish(slot0, slot1)
	if slot1 == Va3ChessGameController.instance:getViewName() then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
		slot0:sendRequest()
	end
end

function slot0.sendRequest(slot0)
	Va3ChessRpcController.instance:sendActEventEndRequest(Va3ChessGameModel.instance:getActId(), slot0.onReceiveReply, slot0)
end

function slot0.onReceiveReply(slot0, slot1, slot2)
	if slot2 == 0 then
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EventFinishPlay, slot0)
	end
end

function slot0.dispose(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
	uv0.super.dispose(slot0)
end

return slot0
