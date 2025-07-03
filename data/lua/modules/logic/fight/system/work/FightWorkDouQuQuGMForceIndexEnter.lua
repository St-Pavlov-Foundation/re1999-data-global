module("modules.logic.fight.system.work.FightWorkDouQuQuGMForceIndexEnter", package.seeall)

local var_0_0 = class("FightWorkDouQuQuGMForceIndexEnter", FightWorkItem)

function var_0_0.onAwake(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._index = arg_1_1
	arg_1_0._needClearFight = arg_1_2
end

function var_0_0.onStart(arg_2_0)
	arg_2_0:cancelFightWorkSafeTimer()

	if arg_2_0._needClearFight then
		local var_2_0 = arg_2_0:com_registFlowSequence()

		var_2_0:registWork(Work2FightWork, FightWorkRestartBefore)
		var_2_0:registFinishCallback(arg_2_0._onClearFinish, arg_2_0)
		var_2_0:start()
	else
		arg_2_0:_onClearFinish()
	end
end

function var_0_0._onClearFinish(arg_3_0)
	arg_3_0._msgItem = arg_3_0:com_registMsg(FightMsgId.FightAct174Reply, arg_3_0._onFightAct174Reply)

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
	arg_4_0:com_registEvent(GameSceneMgr.instance, SceneType.Fight, arg_4_0._onFightSceneStart)
	arg_4_0:com_registFightEvent(FightEvent.OnStartSequenceFinish, arg_4_0._onStartSequenceFinish)

	local var_4_2 = FightDataModel.instance.douQuQuMgr

	if var_4_2.isGMStartRound <= 1 then
		GameSceneMgr.instance:getCurScene().director:registRespBeginFight()
		FightController.instance:dispatchEvent(FightEvent.RespBeginFight)
	else
		arg_4_0:com_removeMsg(arg_4_0._msgItem)
		arg_4_0:com_registMsg(FightMsgId.FightAct174Reply, arg_4_0._onFightAct174ReplyRound)

		arg_4_0._endRound = var_4_2.isGMStartRound - 1

		for iter_4_0 = 1, arg_4_0._endRound do
			Activity174Rpc.instance:sendViewFightAct174Request(var_4_2.index, iter_4_0)
		end
	end
end

function var_0_0._onFightAct174ReplyRound(arg_5_0, arg_5_1)
	arg_5_0._endRound = arg_5_0._endRound - 1

	FightDataHelper.paTaMgr:resetOp()
	FightModel.instance:updateFightRound(arg_5_1.fightRound)

	if arg_5_0._endRound == 0 then
		local var_5_0 = {
			dataMgr = true,
			cacheFightMgr = true,
			class = true
		}

		FightDataUtil.coverData(FightLocalDataMgr.instance, FightDataMgr.instance, var_5_0)

		FightModel.instance._curRoundId = FightDataModel.instance.douQuQuMgr.isGMStartRound

		arg_5_0:com_sendFightEvent(FightEvent.ChangeRound)

		FightDataHelper.roundMgr:getRoundData().fightStep = nil

		GameSceneMgr.instance:getCurScene().director:registRespBeginFight()
		FightController.instance:dispatchEvent(FightEvent.RespBeginFight)
	end
end

function var_0_0._onFightSceneStart(arg_6_0)
	FightSystem.instance:startFight()
end

function var_0_0._onStartSequenceFinish(arg_7_0)
	arg_7_0:com_registTimer(arg_7_0._delayDone, 1)
end

function var_0_0._delayDone(arg_8_0)
	arg_8_0:onDone(true)
end

return var_0_0
