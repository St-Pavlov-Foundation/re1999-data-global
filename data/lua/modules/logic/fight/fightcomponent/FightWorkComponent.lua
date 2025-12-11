module("modules.logic.fight.fightcomponent.FightWorkComponent", package.seeall)

local var_0_0 = class("FightWorkComponent", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.workList = {}
	arg_1_0.count = 0
end

function var_0_0.registWork(arg_2_0, arg_2_1, ...)
	local var_2_0 = arg_2_0:newClass(arg_2_1, ...)

	arg_2_0.count = arg_2_0.count + 1
	arg_2_0.workList[arg_2_0.count] = var_2_0

	var_2_0:registFinishCallback(arg_2_0.onWorkFinish, arg_2_0)

	return var_2_0
end

function var_0_0.playWork(arg_3_0, arg_3_1, ...)
	local var_3_0 = arg_3_0:newClass(arg_3_1, ...)

	arg_3_0.count = arg_3_0.count + 1
	arg_3_0.workList[arg_3_0.count] = var_3_0

	var_3_0:registFinishCallback(arg_3_0.onWorkFinish, arg_3_0)

	return var_3_0:start()
end

function var_0_0.addWork(arg_4_0, arg_4_1)
	arg_4_0.count = arg_4_0.count + 1
	arg_4_0.workList[arg_4_0.count] = arg_4_1

	arg_4_1:registFinishCallback(arg_4_0.onWorkFinish, arg_4_0)

	return arg_4_1
end

function var_0_0.onWorkFinish(arg_5_0)
	arg_5_0:com_registSingleTimer(arg_5_0.clearDeadWork, 1)
end

function var_0_0.clearDeadWork(arg_6_0)
	local var_6_0 = 1

	for iter_6_0 = 1, arg_6_0.count do
		local var_6_1 = arg_6_0.workList[iter_6_0]

		if not var_6_1.IS_DISPOSED then
			if iter_6_0 ~= var_6_0 then
				arg_6_0.workList[var_6_0] = var_6_1
				arg_6_0.workList[iter_6_0] = nil
			end

			var_6_0 = var_6_0 + 1
		else
			arg_6_0.workList[iter_6_0] = nil
		end
	end

	arg_6_0.count = var_6_0 - 1
end

function var_0_0.getWorkList(arg_7_0)
	return arg_7_0.workList
end

function var_0_0.hasAliveWork(arg_8_0)
	for iter_8_0, iter_8_1 in ipairs(arg_8_0.workList) do
		if iter_8_1:isAlive() then
			return true
		end
	end

	return false
end

function var_0_0.disposeAllWork(arg_9_0)
	for iter_9_0 = arg_9_0.count, 1, -1 do
		arg_9_0.workList[iter_9_0]:disposeSelf()
	end

	arg_9_0:com_registSingleTimer(arg_9_0.clearDeadWork, 1)
end

function var_0_0.onDestructor(arg_10_0)
	for iter_10_0 = arg_10_0.count, 1, -1 do
		arg_10_0.workList[iter_10_0]:disposeSelf()
	end

	arg_10_0.workList = nil
end

return var_0_0
