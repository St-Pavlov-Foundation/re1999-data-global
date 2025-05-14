module("modules.logic.fight.fightcomponent.FightWorkQueueComponent", package.seeall)

local var_0_0 = class("FightWorkQueueComponent", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.workQueue = {}
end

function var_0_0.addWork(arg_2_0, arg_2_1, arg_2_2)
	table.insert(arg_2_0.workQueue, {
		work = arg_2_1,
		context = arg_2_2
	})

	if #arg_2_0.workQueue == 1 then
		arg_2_1:registFinishCallback(arg_2_0._onQueueWorkFinish, arg_2_0)

		return arg_2_1:start(arg_2_2)
	end
end

function var_0_0.registWork(arg_3_0, arg_3_1, ...)
	local var_3_0 = arg_3_0:newClass(arg_3_1, ...)

	arg_3_0:addWork(var_3_0)

	return var_3_0
end

function var_0_0.registWorkWithContext(arg_4_0, arg_4_1, arg_4_2, ...)
	local var_4_0 = arg_4_0:newClass(arg_4_1, ...)

	arg_4_0:addWork(var_4_0, arg_4_2)

	return var_4_0
end

function var_0_0._onQueueWorkFinish(arg_5_0)
	local var_5_0 = arg_5_0.workQueue

	if var_5_0 then
		table.remove(var_5_0, 1)

		local var_5_1 = var_5_0[1]

		if var_5_1 then
			return var_5_1.work:start(var_5_1.context)
		end
	end
end

function var_0_0.onDestructor(arg_6_0)
	for iter_6_0 = #arg_6_0.workQueue, 1, -1 do
		arg_6_0.workQueue[iter_6_0]:disposeSelf()
	end
end

return var_0_0
