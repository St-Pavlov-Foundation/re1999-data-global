module("modules.logic.fight.view.work.FightAutoPlayCardWork", package.seeall)

local var_0_0 = class("FightAutoPlayCardWork", BaseWork)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._beginRoundOp = arg_1_1
end

function var_0_0.onStart(arg_2_0, arg_2_1)
	if arg_2_0._beginRoundOp then
		FightController.instance:dispatchEvent(FightEvent.AutoToSelectSkillTarget, arg_2_0._beginRoundOp.toId)
	end

	FightController.instance:registerCallback(FightEvent.PlayCardOver, arg_2_0._onPlayCardOver, arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 10)

	if arg_2_0._beginRoundOp then
		local var_2_0 = arg_2_0._beginRoundOp.param1
		local var_2_1 = FightDataHelper.handCardMgr.handCard[var_2_0]

		FightController.instance:dispatchEvent(FightEvent.PlayHandCard, var_2_1 and var_2_0 or 1, arg_2_0._beginRoundOp.toId, arg_2_0._beginRoundOp.param2, arg_2_0._beginRoundOp.param3)
	end
end

function var_0_0._delayDone(arg_3_0)
	logError("自动战斗打牌超时")
	FightController.instance:dispatchEvent(FightEvent.ForceEndAutoCardFlow)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.PlayCardOver, arg_4_0._onPlayCardOver, arg_4_0)
end

function var_0_0._onPlayCardOver(arg_5_0)
	arg_5_0:onDone(true)
end

return var_0_0
