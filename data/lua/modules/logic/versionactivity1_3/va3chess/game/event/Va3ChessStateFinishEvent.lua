﻿module("modules.logic.versionactivity1_3.va3chess.game.event.Va3ChessStateFinishEvent", package.seeall)

local var_0_0 = class("Va3ChessStateFinishEvent", Va3ChessStateBase)

function var_0_0.start(arg_1_0)
	logNormal("Va3ChessStateFinishEvent start")

	if ViewMgr.instance:isOpenFinish(Va3ChessGameController.instance:getViewName()) then
		arg_1_0:sendRequest()
	else
		ViewMgr.instance:registerCallback(ViewEvent.OnOpenViewFinish, arg_1_0.onOpenViewFinish, arg_1_0)
	end
end

function var_0_0.onOpenViewFinish(arg_2_0, arg_2_1)
	if arg_2_1 == Va3ChessGameController.instance:getViewName() then
		ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_2_0.onOpenViewFinish, arg_2_0)
		arg_2_0:sendRequest()
	end
end

function var_0_0.sendRequest(arg_3_0)
	local var_3_0 = Va3ChessGameModel.instance:getActId()

	Va3ChessRpcController.instance:sendActEventEndRequest(var_3_0, arg_3_0.onReceiveReply, arg_3_0)
end

function var_0_0.onReceiveReply(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 == 0 then
		Va3ChessGameController.instance:dispatchEvent(Va3ChessEvent.EventFinishPlay, arg_4_0)
	end
end

function var_0_0.dispose(arg_5_0)
	ViewMgr.instance:unregisterCallback(ViewEvent.OnOpenViewFinish, arg_5_0.onOpenViewFinish, arg_5_0)
	var_0_0.super.dispose(arg_5_0)
end

return var_0_0
