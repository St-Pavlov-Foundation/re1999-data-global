module("modules.logic.fight.fightcomponent.FightTimerComponent", package.seeall)

local var_0_0 = class("FightTimerComponent", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0.timerList = {}
end

function var_0_0.cancelTimer(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return
	end

	arg_2_1.isDone = true
end

function var_0_0.registRepeatTimer(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = FightTimer.registRepeatTimer(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)

	table.insert(arg_3_0.timerList, var_3_0)

	return var_3_0
end

function var_0_0.restartRepeatTimer(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	return FightTimer.restartRepeatTimer(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
end

function var_0_0.registSingleTimer(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
	if not arg_5_0.singleTimer then
		arg_5_0.singleTimer = {}
	end

	local var_5_0 = arg_5_0.singleTimer[arg_5_1]

	if var_5_0 then
		if var_5_0.isDone then
			var_5_0 = arg_5_0:registRepeatTimer(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)
			arg_5_0.singleTimer[arg_5_1] = var_5_0

			return var_5_0
		else
			var_5_0:restart(arg_5_3, arg_5_4, arg_5_5)

			return var_5_0
		end
	else
		local var_5_1 = arg_5_0:registRepeatTimer(arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5)

		arg_5_0.singleTimer[arg_5_1] = var_5_1

		return var_5_1
	end
end

function var_0_0.releaseAllTimer(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.timerList) do
		iter_6_1.isDone = true
	end
end

function var_0_0.onDestructor(arg_7_0)
	arg_7_0:releaseAllTimer()

	arg_7_0.timerList = nil
	arg_7_0.singleTimer = nil
end

return var_0_0
