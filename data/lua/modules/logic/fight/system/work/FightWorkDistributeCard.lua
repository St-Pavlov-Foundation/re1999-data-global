module("modules.logic.fight.system.work.FightWorkDistributeCard", package.seeall)

local var_0_0 = class("FightWorkDistributeCard", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0)
	local var_2_0 = FightModel.instance:getCurRoundMO()

	if not var_2_0 then
		arg_2_0:onDone(false)

		return
	end

	FightController.instance:setCurStage(FightEnum.Stage.Distribute)

	local var_2_1 = var_2_0.beforeCards1
	local var_2_2 = var_2_0.teamACards1

	if #var_2_1 > 0 or #var_2_2 > 0 then
		FightCardModel.instance:clearDistributeQueue()
		FightCardModel.instance:enqueueDistribute(var_2_1, var_2_2)
	end

	FightController.instance:GuideFlowPauseAndContinue("OnGuideDistributePause", FightEvent.OnGuideDistributePause, FightEvent.OnGuideDistributeContinue, arg_2_0._distrubute, arg_2_0)
end

function var_0_0._distrubute(arg_3_0)
	FightViewPartVisible.set(false, true, false, false, false)
	FightController.instance:registerCallback(FightEvent.OnDistributeCards, arg_3_0._done, arg_3_0)
	FightController.instance:dispatchEvent(FightEvent.DistributeCards)
end

function var_0_0._done(arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnDistributeCards, arg_4_0._done, arg_4_0)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.OnDistributeCards, arg_5_0._done, arg_5_0)
end

return var_0_0
