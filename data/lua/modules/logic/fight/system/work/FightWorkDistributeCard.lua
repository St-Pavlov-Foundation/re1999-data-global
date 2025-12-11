module("modules.logic.fight.system.work.FightWorkDistributeCard", package.seeall)

local var_0_0 = class("FightWorkDistributeCard", FightWorkItem)

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.isEnterDistribute = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	if not FightDataHelper.roundMgr:getRoundData() then
		arg_2_0:onDone(false)

		return
	end

	arg_2_0:cancelFightWorkSafeTimer()
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.DistributeCard)
	FightController.instance:GuideFlowPauseAndContinue("OnGuideDistributePause", FightEvent.OnGuideDistributePause, FightEvent.OnGuideDistributeContinue, arg_2_0._distrubute, arg_2_0)
end

function var_0_0._distrubute(arg_3_0)
	FightViewPartVisible.set(false, true, false, false, false)
	FightController.instance:registerCallback(FightEvent.OnDistributeCards, arg_3_0._done, arg_3_0)

	local var_3_0 = FightDataHelper.handCardMgr.beforeCards1
	local var_3_1 = FightDataHelper.handCardMgr.teamACards1

	FightController.instance:dispatchEvent(FightEvent.DistributeCards, var_3_0, var_3_1, arg_3_0.isEnterDistribute)
end

function var_0_0._done(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnDistributeCards, arg_4_0._done, arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.DistributeCard)
	FightController.instance:unregisterCallback(FightEvent.OnDistributeCards, arg_5_0._done, arg_5_0)
end

return var_0_0
