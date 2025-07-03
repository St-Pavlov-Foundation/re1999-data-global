module("modules.logic.fight.system.flow.FightReconnectSequence", package.seeall)

local var_0_0 = class("FightReconnectSequence", BaseFightSequence)

function var_0_0.buildFlow(arg_1_0, arg_1_1)
	var_0_0.super.buildFlow(arg_1_0)
	arg_1_0:addWork(FunctionWork.New(function()
		FightRpc.instance:dealCardInfoPushData()
	end))
	arg_1_0:addWork(FightWorkDetectReplayEnterSceneActive.New())
	arg_1_0:addWork(FightWorkFbStory.New(FightWorkFbStory.Type_EnterWave))
	arg_1_0:addWork(WorkWaitSeconds.New(0.5))
	arg_1_0:addWork(FightWorkFocusMonster.New())
	arg_1_0:addWork(FunctionWork.New(function()
		for iter_3_0, iter_3_1 in ipairs(FightHelper.getAllEntitys()) do
			if iter_3_1.buff then
				iter_3_1.buff:dealStartBuff()
			end
		end
	end))
	arg_1_0:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.BeforeEnterStepBehaviour)
	end))

	local var_1_0 = FightStepBuilder.buildStepWorkList(arg_1_1.fightStep)

	if var_1_0 then
		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			arg_1_0:addWork(iter_1_1)
		end
	end

	arg_1_0:addWork(FunctionWork.New(function()
		local var_5_0 = FightDataHelper.roundMgr:getRoundData()

		FightDataMgr.instance:afterPlayRoundData(var_5_0)
	end))
	arg_1_0:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.AfterEnterStepBehaviour)
	end))
	arg_1_0:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.OnFightReconnectLastWork)
	end))
end

return var_0_0
