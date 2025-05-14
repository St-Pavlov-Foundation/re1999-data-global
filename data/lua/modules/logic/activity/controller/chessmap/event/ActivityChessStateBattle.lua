module("modules.logic.activity.controller.chessmap.event.ActivityChessStateBattle", package.seeall)

local var_0_0 = class("ActivityChessStateBattle", ActivityChessStateBase)

function var_0_0.start(arg_1_0)
	logNormal("ActivityChessStateBattle start")

	local var_1_0 = arg_1_0.originData.battleId
	local var_1_1 = arg_1_0.originData.activityId
	local var_1_2 = arg_1_0.originData.interactId

	if ViewMgr.instance:isOpenFinish(ViewName.ActivityChessGame) then
		arg_1_0:startBattle()
	else
		ActivityChessGameController.instance:registerCallback(ActivityChessEvent.GameViewOpened, arg_1_0.onOpenViewFinish, arg_1_0)
	end
end

function var_0_0.onOpenViewFinish(arg_2_0, arg_2_1)
	ActivityChessGameController.instance:unregisterCallback(ActivityChessEvent.GameViewOpened, arg_2_0.onOpenViewFinish, arg_2_0)

	if arg_2_1 and arg_2_1.fromRefuseBattle then
		local var_2_0 = arg_2_0.originData.activityId

		Activity109Rpc.instance:sendAct109AbortRequest(var_2_0, arg_2_0.onReceiveAboveGame, arg_2_0)
	else
		arg_2_0:startBattle()
	end
end

function var_0_0.startBattle(arg_3_0)
	Activity109ChessController.instance:enterActivityFight(arg_3_0.originData.battleId)
	ActivityChessGameController.instance:dispatchEvent(ActivityChessEvent.EventFinishPlay)
end

function var_0_0.onReceiveAboveGame(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 ~= 0 then
		return
	end

	logNormal("game over by refuse battle !")
	ActivityChessGameController.instance:gameOver()
end

function var_0_0.dispose(arg_5_0)
	ActivityChessGameController.instance:unregisterCallback(ActivityChessEvent.GameViewOpened, arg_5_0.onOpenViewFinish, arg_5_0)
end

return var_0_0
