module("modules.logic.fight.system.work.FightWorkPlayNormalWork", package.seeall)

local var_0_0 = class("FightWorkPlayNormalWork", FightWorkItem)

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0.normalWork = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	arg_2_0.normalWork:registerDoneListener(arg_2_0.finishWork, arg_2_0)
	arg_2_0:cancelFightWorkSafeTimer()

	return arg_2_0.normalWork:onStartInternal(arg_2_0.context)
end

function var_0_0.onDestructor(arg_3_0)
	if arg_3_0.normalWork.status ~= WorkStatus.Done then
		arg_3_0.normalWork:onDestroyInternal()
	end
end

return var_0_0
