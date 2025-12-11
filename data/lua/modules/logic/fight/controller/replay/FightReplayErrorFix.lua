module("modules.logic.fight.controller.replay.FightReplayErrorFix", package.seeall)

local var_0_0 = class("FightReplayErrorFix")
local var_0_1 = 2

function var_0_0.ctor(arg_1_0)
	arg_1_0._hasStartErrorCheck = false
	arg_1_0._lostConnect = false
	arg_1_0._startTime = Time.time
end

function var_0_0.addConstEvents(arg_2_0)
	FightController.instance:registerCallback(FightEvent.PushEndFight, arg_2_0._stopReplay, arg_2_0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnLostConnect, arg_2_0._onLostConnect, arg_2_0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnReconnectSucc, arg_2_0._onReconnectSucc, arg_2_0)
	ConnectAliveMgr.instance:registerCallback(ConnectEvent.OnServerKickedOut, arg_2_0._onServerKickedOut, arg_2_0)
end

function var_0_0.reInit(arg_3_0)
	arg_3_0:_stopReplay()
end

function var_0_0.startReplayErrorFix(arg_4_0)
	arg_4_0._lostConnect = false
	arg_4_0._hasStartErrorCheck = true
	arg_4_0._startTime = Time.time

	TaskDispatcher.runRepeat(arg_4_0._onSecond, arg_4_0, 1)

	arg_4_0._callbackDict = {}

	for iter_4_0, iter_4_1 in pairs(FightEvent) do
		local function var_4_0()
			arg_4_0._startTime = Time.time
		end

		arg_4_0._callbackDict[iter_4_1] = var_4_0

		FightController.instance:registerCallback(iter_4_1, var_4_0, nil)
	end

	GameStateMgr.instance:registerCallback(GameStateEvent.onApplicationPause, arg_4_0._onApplicationPause, arg_4_0)
end

function var_0_0._onApplicationPause(arg_6_0)
	arg_6_0._startTime = Time.time
end

function var_0_0._onLostConnect(arg_7_0)
	arg_7_0._lostConnect = true
end

function var_0_0._onReconnectSucc(arg_8_0)
	arg_8_0._startTime = Time.time
	arg_8_0._lostConnect = false
end

function var_0_0._onServerKickedOut(arg_9_0)
	arg_9_0:_stopReplay()
end

function var_0_0._stopReplay(arg_10_0)
	if arg_10_0._hasStartErrorCheck then
		arg_10_0._hasStartErrorCheck = false

		TaskDispatcher.cancelTask(arg_10_0._onSecond, arg_10_0)
		arg_10_0:_clearEvtCbs()
	end

	arg_10_0._hasLog = nil
end

function var_0_0._clearEvtCbs(arg_11_0)
	if arg_11_0._callbackDict then
		for iter_11_0, iter_11_1 in pairs(arg_11_0._callbackDict) do
			FightController.instance:unregisterCallback(iter_11_0, iter_11_1, nil)
		end

		arg_11_0._callbackDict = nil
	end

	GameStateMgr.instance:unregisterCallback(GameStateEvent.onApplicationPause, arg_11_0._onApplicationPause, arg_11_0)
end

function var_0_0._onSecond(arg_12_0)
	if arg_12_0._lostConnect then
		return
	end

	if #ConnectAliveMgr.instance:getUnresponsiveMsgList() > 0 then
		return
	end

	if Time.time - arg_12_0._startTime > var_0_1 then
		arg_12_0:_fixErrorState()
	end
end

function var_0_0._fixErrorState(arg_13_0)
	FightMsgMgr.sendMsg(FightMsgId.ForceReleasePlayFlow)

	if FightModel.instance:isFinish() then
		FightRpc.instance:sendEndFightRequest(false)
	else
		FightReplayController.instance:doneCardStage()
		FightRpc.instance:sendBeginRoundRequest({})
	end
end

function var_0_0._log(arg_14_0, arg_14_1)
	if not arg_14_0._hasLog then
		arg_14_0._hasLog = true

		local var_14_0 = FightModel.instance:getFightParam()
		local var_14_1 = var_14_0 and var_14_0.episodeId
		local var_14_2 = var_14_0 and var_14_0.battleId

		if var_14_1 then
			logError(arg_14_1 .. " episode_" .. var_14_1)
		else
			logError(arg_14_1 .. " battle_" .. (var_14_2 or "nil"))
		end
	end
end

return var_0_0
