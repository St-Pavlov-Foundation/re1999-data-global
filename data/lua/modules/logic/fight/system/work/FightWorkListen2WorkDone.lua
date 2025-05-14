module("modules.logic.fight.system.work.FightWorkListen2WorkDone", package.seeall)

local var_0_0 = class("FightWorkListen2WorkDone", FightWorkItem)

function var_0_0.onConstructor(arg_1_0, arg_1_1)
	arg_1_0._work = arg_1_1
end

function var_0_0.onStart(arg_2_0)
	if arg_2_0._work.IS_DISPOSED then
		arg_2_0:onDone(true)

		return
	end

	if arg_2_0._work.WORKFINISHED then
		arg_2_0:onDone(true)

		return
	end

	arg_2_0:cancelFightWorkSafeTimer()

	if arg_2_0._work.STARTED then
		arg_2_0._work:registFinishCallback(arg_2_0.onWorkItemDone, arg_2_0)

		return
	end

	arg_2_0._work:registFinishCallback(arg_2_0.onWorkItemDone, arg_2_0)

	return arg_2_0._work:start(arg_2_0.context)
end

function var_0_0.onWorkItemDone(arg_3_0)
	return arg_3_0:onDone(true)
end

function var_0_0.clearWork(arg_4_0)
	arg_4_0._work:disposeSelf()
end

return var_0_0
