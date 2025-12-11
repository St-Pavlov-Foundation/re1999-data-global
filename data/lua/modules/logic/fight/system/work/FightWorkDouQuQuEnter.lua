module("modules.logic.fight.system.work.FightWorkDouQuQuEnter", package.seeall)

local var_0_0 = class("FightWorkDouQuQuEnter", FightWorkItem)

function var_0_0.onLogicEnter(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._index = arg_1_1
	arg_1_0._needClearFight = arg_1_2
end

function var_0_0.onStart(arg_2_0)
	FightWorkDouQuQuStat.startTime = ServerTime.now()

	arg_2_0:cancelFightWorkSafeTimer()

	if arg_2_0._needClearFight then
		local var_2_0 = arg_2_0:com_registFlowSequence()

		var_2_0:registWork(Work2FightWork, FightWorkRestartBefore)
		var_2_0:registFinishCallback(arg_2_0._onClearFinish, arg_2_0)
		var_2_0:start({
			noReloadScene = true
		})
	else
		arg_2_0:_onClearFinish()
	end
end

function var_0_0._onClearFinish(arg_3_0)
	arg_3_0:com_registMsg(FightMsgId.FightAct174Reply, arg_3_0._onFightAct174Reply)
	Activity174Rpc.instance:sendViewFightAct174Request(arg_3_0._index, 0)
end

function var_0_0._onFightAct174Reply(arg_4_0, arg_4_1)
	local var_4_0 = FightData.New(arg_4_1.fight)
	local var_4_1 = arg_4_1.startRound

	FightMgr.instance:startFight(var_4_0)
	FightModel.instance:updateFight(var_4_0)
	FightModel.instance:refreshBattleId(var_4_0)
	FightModel.instance:updateFightRound(var_4_1)
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.DouQuQu)
	arg_4_0:com_sendFightEvent(FightEvent.RefreshUIRound)
	arg_4_0:com_registEvent(GameSceneMgr.instance, SceneType.Fight, arg_4_0._onFightSceneStart)
	arg_4_0:com_registFightEvent(FightEvent.OnStartSequenceFinish, arg_4_0._onStartSequenceFinish)
	GameSceneMgr.instance:getCurScene().director:registRespBeginFight()
	FightController.instance:dispatchEvent(FightEvent.RespBeginFight)
end

function var_0_0._onFightSceneStart(arg_5_0)
	FightGameMgr.playMgr:playStart()
end

function var_0_0._onStartSequenceFinish(arg_6_0)
	arg_6_0:onDone(true)
end

return var_0_0
