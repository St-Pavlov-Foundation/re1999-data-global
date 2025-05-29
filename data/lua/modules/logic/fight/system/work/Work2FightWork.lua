module("modules.logic.fight.system.work.Work2FightWork", package.seeall)

local var_0_0 = class("Work2FightWork", FightWorkItem)

function var_0_0.onAwake(arg_1_0, arg_1_1, ...)
	arg_1_0._class = arg_1_1
	arg_1_0._param = {
		...
	}
	arg_1_0._paramCount = select("#", ...)
end

function var_0_0.onStart(arg_2_0)
	arg_2_0._work = arg_2_0._class.New(unpack(arg_2_0._param, 1, arg_2_0._paramCount))

	arg_2_0._work:registerDoneListener(arg_2_0.onWorkItemDone, arg_2_0)
	arg_2_0:cancelFightWorkSafeTimer()

	return arg_2_0._work:onStartInternal(arg_2_0.context)
end

function var_0_0.onWorkItemDone(arg_3_0)
	return arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	if arg_4_0._work then
		arg_4_0._work:unregisterDoneListener(arg_4_0.onWorkItemDone, arg_4_0)
		arg_4_0._work:onDestroy()

		arg_4_0._work = nil
	end
end

return var_0_0
