module("modules.logic.fight.fightcomponent.FightWorkParallelComponent", package.seeall)

local var_0_0 = class("FightWorkParallelComponent", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.workParallel = {}
	arg_1_0.callback = nil
	arg_1_0.callbackHandle = nil
	arg_1_0.finishCount = 0
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
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		iter_5_1:registFinishCallback(arg_5_0._onWorkFinish, arg_5_0)
		table.insert(arg_5_0.workParallel, {
			work = iter_5_1,
			context = arg_5_2
		})
	end

	for iter_5_2, iter_5_3 in ipairs(arg_5_1) do
		iter_5_3:start(arg_5_2)
	end
end

function var_0_0._onWorkFinish(arg_6_0)
	arg_6_0.finishCount = arg_6_0.finishCount + 1

	if arg_6_0.finishCount == #arg_6_0.workParallel and arg_6_0.callback then
		arg_6_0.callback(arg_6_0.callbackHandle)
	end
end

function var_0_0.onDestructor(arg_7_0)
	for iter_7_0 = #arg_7_0.workParallel, 1, -1 do
		arg_7_0.workParallel[iter_7_0].work:disposeSelf()
	end

	arg_7_0:clearFinishCallback()
end

return var_0_0
