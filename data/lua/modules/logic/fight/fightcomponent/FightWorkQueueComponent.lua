module("modules.logic.fight.fightcomponent.FightWorkQueueComponent", package.seeall)

local var_0_0 = class("FightWorkQueueComponent", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.workQueue = {}
	arg_1_0.callback = nil
	arg_1_0.callbackHandle = nil
end

function var_0_0.registFinishCallback(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.callback = arg_2_1
	arg_2_0.callbackHandle = arg_2_2
end

function var_0_0.clearFinishCallback(arg_3_0)
	arg_3_0.callback = nil
	arg_3_0.callbackHandle = nil
end

function var_0_0.addWork(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:addWorkList({
		arg_4_1
	}, arg_4_2)
end

function var_0_0.addWorkList(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = false

	if #arg_5_0.workQueue == 0 then
		var_5_0 = true
	end

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		iter_5_1:registFinishCallback(arg_5_0._onWorkFinish, arg_5_0)
		table.insert(arg_5_0.workQueue, {
			work = iter_5_1,
			context = arg_5_2
		})
	end

	if var_5_0 then
		arg_5_0:_onWorkFinish()
	end
end

function var_0_0._onWorkFinish(arg_6_0)
	local var_6_0 = arg_6_0.workQueue
	local var_6_1 = table.remove(var_6_0, 1)

	if var_6_1 then
		return var_6_1.work:start(var_6_1.context)
	elseif arg_6_0.callback then
		arg_6_0.callback(arg_6_0.callbackHandle)
	end
end

function var_0_0.onDestructor(arg_7_0)
	for iter_7_0 = #arg_7_0.workQueue, 1, -1 do
		arg_7_0.workQueue[iter_7_0].work:disposeSelf()
	end

	arg_7_0:clearFinishCallback()
end

return var_0_0
