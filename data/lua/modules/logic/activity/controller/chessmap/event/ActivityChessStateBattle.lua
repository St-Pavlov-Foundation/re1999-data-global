module("modules.logic.activity.controller.chessmap.event.ActivityChessStateBattle", package.seeall)

slot0 = class("ActivityChessStateBattle", ActivityChessStateBase)

function slot0.start(slot0)
	logNormal("ActivityChessStateBattle start")

	slot1 = slot0.originData.battleId
	slot2 = slot0.originData.activityId
	slot3 = slot0.originData.interactId

	if ViewMgr.instance:isOpenFinish(ViewName.ActivityChessGame) then
		slot0:startBattle()
	else
		ActivityChessGameController.instance:registerCallback(ActivityChessEvent.GameViewOpened, slot0.onOpenViewFinish, slot0)
	end
end

function slot0.onOpenViewFinish(slot0, slot1)
	ActivityChessGameController.instance:unregisterCallback(ActivityChessEvent.GameViewOpened, slot0.onOpenViewFinish, slot0)

	if slot1 and slot1.fromRefuseBattle then
		Activity109Rpc.instance:sendAct109AbortRequest(slot0.originData.activityId, slot0.onReceiveAboveGame, slot0)
	else
		slot0:startBattle()
	end
end

function slot0.startBattle(slot0)
	Activity109ChessController.instance:enterActivityFight(slot0.originData.battleId)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.EventFinishPlay)
end

function slot0.onReceiveAboveGame(slot0, slot1, slot2)
	if slot2 ~= 0 then
		return
	end

	logNormal("game over by refuse battle !")
	ActivityChessGameController.instance:gameOver()
end

function slot0.dispose(slot0)
	ActivityChessGameController.instance:unregisterCallback(ActivityChessEvent.GameViewOpened, slot0.onOpenViewFinish, slot0)
end

return slot0
