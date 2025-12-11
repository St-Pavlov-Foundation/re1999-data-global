module("modules.logic.fight.system.work.FightWorkDelayTimer", package.seeall)

local var_0_0 = class("FightWorkDelayTimer", FightWorkItem)

function var_0_0.onLogicEnter(arg_1_0, arg_1_1)
	arg_1_0._waitSeconds = arg_1_1 or 0.01
end

function var_0_0.onStart(arg_2_0)
	if arg_2_0._waitSeconds == 0 then
		arg_2_0:onDone(true)

		return
	end

	arg_2_0:cancelFightWorkSafeTimer()
	arg_2_0:com_registTimer(arg_2_0._onTimeEnd, arg_2_0._waitSeconds)
end

function var_0_0.clearWork(arg_3_0)
	return
end

function var_0_0._onTimeEnd(arg_4_0)
	arg_4_0:onDone(true)
end

return var_0_0
