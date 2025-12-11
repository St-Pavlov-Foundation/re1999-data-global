module("modules.logic.fight.system.work.FightWorkPlayReconnect", package.seeall)

local var_0_0 = class("FightWorkPlayReconnect", FightWorkItem)

function var_0_0.onStart(arg_1_0)
	if FightDataHelper.stateMgr.isReplay then
		FightReplayController.instance._replayErrorFix:startReplayErrorFix()
	end

	local var_1_0 = FightDataHelper.roundMgr:getRoundData()
	local var_1_1 = arg_1_0:com_registFlowSequence()

	var_1_1:addWork(FunctionWork.New(function()
		FightRpc.instance:dealCardInfoPushData()
	end))
	var_1_1:addWork(FightWorkDetectReplayEnterSceneActive.New())
	var_1_1:addWork(FightWorkFbStory.New(FightWorkFbStory.Type_EnterWave))
	var_1_1:addWork(WorkWaitSeconds.New(0.5))
	var_1_1:addWork(FightWorkFocusMonster.New())
	var_1_1:addWork(FunctionWork.New(function()
		for iter_3_0, iter_3_1 in ipairs(FightHelper.getAllEntitys()) do
			if iter_3_1.buff then
				iter_3_1.buff:dealStartBuff()
			end
		end
	end))
	var_1_1:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.BeforeEnterStepBehaviour)
	end))

	local var_1_2 = FightStepBuilder.buildStepWorkList(var_1_0.fightStep)

	if var_1_2 then
		for iter_1_0, iter_1_1 in ipairs(var_1_2) do
			var_1_1:addWork(iter_1_1)
		end
	end

	var_1_1:addWork(FunctionWork.New(function()
		local var_5_0 = FightDataHelper.roundMgr:getRoundData()

		FightDataMgr.instance:afterPlayRoundData(var_5_0)
	end))
	var_1_1:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.AfterEnterStepBehaviour)
	end))
	var_1_1:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.OnFightReconnectLastWork)
	end))
	var_1_1:registFinishCallback(arg_1_0.onFlowFinish, arg_1_0)
	arg_1_0:playWorkAndDone(var_1_1, {})
end

function var_0_0.onFlowFinish(arg_8_0)
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.Enter)
	FightController.instance:dispatchEvent(FightEvent.OnStartSequenceFinish)
end

return var_0_0
