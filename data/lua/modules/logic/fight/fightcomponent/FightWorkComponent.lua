module("modules.logic.fight.fightcomponent.FightWorkComponent", package.seeall)

local var_0_0 = class("FightWorkComponent", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.workList = {}
end

function var_0_0.registWork(arg_2_0, arg_2_1, ...)
	local var_2_0 = arg_2_0:newClass(arg_2_1, ...)

	table.insert(arg_2_0.workList, var_2_0)
	var_2_0:registFinishCallback(arg_2_0.onOneWorkFinish, arg_2_0)

	return var_2_0
end

function var_0_0.playWork(arg_3_0, arg_3_1, ...)
	local var_3_0 = arg_3_0:newClass(arg_3_1, ...)

	table.insert(arg_3_0.workList, var_3_0)
	var_3_0:registFinishCallback(arg_3_0.onOneWorkFinish, arg_3_0)

	return var_3_0:start()
end

function var_0_0.addWork(arg_4_0, arg_4_1)
	table.insert(arg_4_0.workList, arg_4_1)
	arg_4_1:registFinishCallback(arg_4_0.onOneWorkFinish, arg_4_0)

	return arg_4_1
end

function var_0_0.onOneWorkFinish(arg_5_0)
	arg_5_0:com_registSingleTimer(arg_5_0.clearDeadWork, 1)
end

function var_0_0.clearDeadWork(arg_6_0)
	for iter_6_0 = #arg_6_0.workList, 1, -1 do
		if arg_6_0.workList[iter_6_0].IS_DISPOSED then
			table.remove(arg_6_0.workList, iter_6_0)
		end
	end
end

function var_0_0.getWorkList(arg_7_0)
	return arg_7_0.workList
end

function var_0_0.getAliveWorkList(arg_8_0)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0.workList) do
		if not iter_8_1.WORKFINISHED and not iter_8_1.IS_DISPOSED then
			table.insert(var_8_0, iter_8_1)
		end
	end

	return var_8_0
end

function var_0_0.disposeAllWork(arg_9_0)
	arg_9_0:disposeObjectList(arg_9_0.workList)
	arg_9_0:onOneWorkFinish()
end

function var_0_0.onDestructor(arg_10_0)
	arg_10_0:disposeObjectList(arg_10_0.workList)

	arg_10_0.workList = nil
end

return var_0_0
