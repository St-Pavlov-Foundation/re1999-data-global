module("modules.logic.fight.system.work.FightWorkShowRoundView", package.seeall)

local var_0_0 = class("FightWorkShowRoundView", BaseWork)

function var_0_0.onStart(arg_1_0)
	if FightModel.instance.hasNextWave and FightController.instance:canOpenRoundView() and GMFightShowState.roundSpecialView then
		FightController.instance:openRoundView()
		TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, 1 / FightModel.instance:getUISpeed())
	else
		arg_1_0:onDone(true)
	end
end

function var_0_0._delayDone(arg_2_0)
	arg_2_0:onDone(true)
end

function var_0_0.clearWork(arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._delayDone, arg_3_0)
end

return var_0_0
