module("modules.logic.fight.view.work.FightAutoDetectForceEndWork", package.seeall)

local var_0_0 = class("FightAutoDetectForceEndWork", BaseWork)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.onStart(arg_2_0)
	TaskDispatcher.runDelay(arg_2_0._delayDone, arg_2_0, 1)

	if not FightDataHelper.operationDataMgr:isCardOpEnd() then
		FightController.instance:dispatchEvent(FightEvent.ForceEndAutoCardFlow)
	end

	arg_2_0:onDone(true)
end

function var_0_0._delayDone(arg_3_0)
	arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayDone, arg_4_0)
end

return var_0_0
