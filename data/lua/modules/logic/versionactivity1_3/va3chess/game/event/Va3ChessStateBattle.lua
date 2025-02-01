module("modules.logic.versionactivity1_3.va3chess.game.event.Va3ChessStateBattle", package.seeall)

slot0 = class("Va3ChessStateBattle", Va3ChessStateBase)

function slot0.start(slot0)
	logNormal("Va3ChessStateBattle start")

	slot1 = slot0.originData.battleId
	slot2 = slot0.originData.activityId
	slot3 = slot0.originData.interactId

	Va3ChessGameController.instance:registerCallback(Va3ChessEvent.GameViewOpened, slot0.onReturnChessFinish, slot0)
	slot0:startBattle()
end

function slot0.startBattle(slot0)
	Va3ChessController.instance:enterActivityFight(slot0.originData.battleId)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EventFinishPlay)
end

function slot0.onReturnChessFinish(slot0, slot1)
	Va3ChessGameController.instance:unregisterCallback(Va3ChessEvent.GameViewOpened, slot0.onReturnChessFinish, slot0)

	if slot1 and slot1.fromRefuseBattle then
		slot2 = slot0.originData.activityId

		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EventBattleReturn)
	end

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EventFinishPlay, slot0)
end

function slot0.onReceiveAboveGame(slot0, slot1, slot2)
	if slot2 ~= 0 then
		return
	end

	logNormal("game over by refuse battle !")
	Va3ChessGameController.instance:gameOver()
end

function slot0.dispose(slot0)
	Va3ChessGameController.instance:unregisterCallback(Va3ChessEvent.GameViewOpened, slot0.onReturnChessFinish, slot0)
end

return slot0
