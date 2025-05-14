module("modules.logic.versionactivity1_3.va3chess.game.event.Va3ChessStateBattle", package.seeall)

local var_0_0 = class("Va3ChessStateBattle", Va3ChessStateBase)

function var_0_0.start(arg_1_0)
	logNormal("Va3ChessStateBattle start")

	local var_1_0 = arg_1_0.originData.battleId
	local var_1_1 = arg_1_0.originData.activityId
	local var_1_2 = arg_1_0.originData.interactId

	Va3ChessGameController.instance:registerCallback(Va3ChessEvent.GameViewOpened, arg_1_0.onReturnChessFinish, arg_1_0)
	arg_1_0:startBattle()
end

function var_0_0.startBattle(arg_2_0)
	Va3ChessController.instance:enterActivityFight(arg_2_0.originData.battleId)
	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EventFinishPlay)
end

function var_0_0.onReturnChessFinish(arg_3_0, arg_3_1)
	Va3ChessGameController.instance:unregisterCallback(Va3ChessEvent.GameViewOpened, arg_3_0.onReturnChessFinish, arg_3_0)

	if arg_3_1 and arg_3_1.fromRefuseBattle then
		local var_3_0 = arg_3_0.originData.activityId

		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EventBattleReturn)
	end

	Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EventFinishPlay, arg_3_0)
end

function var_0_0.onReceiveAboveGame(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 ~= 0 then
		return
	end

	logNormal("game over by refuse battle !")
	Va3ChessGameController.instance:gameOver()
end

function var_0_0.dispose(arg_5_0)
	Va3ChessGameController.instance:unregisterCallback(Va3ChessEvent.GameViewOpened, arg_5_0.onReturnChessFinish, arg_5_0)
end

return var_0_0
