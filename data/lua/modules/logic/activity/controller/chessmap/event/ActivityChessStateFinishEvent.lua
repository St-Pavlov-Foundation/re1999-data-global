module("modules.logic.activity.controller.chessmap.event.ActivityChessStateFinishEvent", package.seeall)

slot0 = class("ActivityChessStateFinishEvent", ActivityChessStateBase)

function slot0.start(slot0)
	logNormal("ActivityChessStateFinishEvent start")

	if ViewMgr.instance:isOpenFinish(ViewName.ActivityChessGame) then
		slot0:sendRequest()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
	end
end

function slot0.onOpenViewFinish(slot0, slot1)
	if slot1 == ViewName.ActivityChessGame then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
		slot0:sendRequest()
	end
end

function slot0.sendRequest(slot0)
	Activity109Rpc.instance:sendAct109EventEndRequest(ActivityChessGameModel.instance:getActId(), slot0.onReceiveReply, slot0)
end

function slot0.onReceiveReply(slot0, slot1, slot2)
	if slot2 == 0 then
		ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.EventFinishPlay, slot0)
	end
end

function slot0.dispose(slot0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, slot0.onOpenViewFinish, slot0)
	uv0.super.dispose(slot0)
end

return slot0
