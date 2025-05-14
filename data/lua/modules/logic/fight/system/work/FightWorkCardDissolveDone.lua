module("modules.logic.fight.system.work.FightWorkCardDissolveDone", package.seeall)

local var_0_0 = class("FightWorkCardDissolveDone", BaseWork)

function var_0_0.onStart(arg_1_0)
	if FightCardModel.instance:isDissolving() then
		TaskDispatcher.runDelay(arg_1_0._timeOut, arg_1_0, 10)
		TaskDispatcher.runRepeat(arg_1_0._frameCheck, arg_1_0, 0.01, 300)
		FightController.instance:registerCallback(FightEvent.OnCombineCardEnd, arg_1_0._onCombineCardEnd, arg_1_0)
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._frameCheck(arg_2_0)
	if not FightCardModel.instance:isDissolving() then
		arg_2_0:onDone(true)
	end
end

function var_0_0._onCombineCardEnd(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0._timeOut(arg_4_0)
	logNormal("FightWorkCardDissolveDone 奇怪，超时结束 done")
	FightCardModel.instance:setDissolving(false)
	arg_4_0:onDone(true)
end

function var_0_0.clearWork(arg_5_0)
	FightController.instance:unregisterCallback(FightEvent.OnCombineCardEnd, arg_5_0._onCombineCardEnd, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._timeOut, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._frameCheck, arg_5_0)
end

return var_0_0
