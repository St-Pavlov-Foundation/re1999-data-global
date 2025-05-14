module("modules.logic.fight.fightcomponent.FightWorkComponent", package.seeall)

local var_0_0 = class("FightWorkComponent", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.workList = {}
end

function var_0_0.registWork(arg_2_0, arg_2_1, ...)
	local var_2_0 = arg_2_0:newClass(arg_2_1, ...)

	table.insert(arg_2_0.workList, var_2_0)

	return var_2_0
end

function var_0_0.playWork(arg_3_0, arg_3_1, ...)
	local var_3_0 = arg_3_0:newClass(arg_3_1, ...)

	table.insert(arg_3_0.workList, var_3_0)

	return var_3_0:start()
end

function var_0_0.addWork(arg_4_0, arg_4_1)
	table.insert(arg_4_0.workList, arg_4_1)

	return arg_4_1
end

function var_0_0.getWorkList(arg_5_0)
	return arg_5_0.workList
end

function var_0_0.getAliveWorkList(arg_6_0)
	local var_6_0 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0.workList) do
		if not iter_6_1.WORKFINISHED then
			table.insert(var_6_0, iter_6_1)
		end
	end

	return var_6_0
end

function var_0_0.disposeAllWork(arg_7_0)
	arg_7_0:disposeClassList(arg_7_0.workList)

	arg_7_0.workList = {}
end

function var_0_0.onDestructor(arg_8_0)
	arg_8_0:disposeClassList(arg_8_0.workList)

	arg_8_0.workList = nil
end

return var_0_0
