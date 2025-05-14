module("modules.logic.fight.fightcomponent.FightTimerComponent", package.seeall)

local var_0_0 = class("FightTimerComponent", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0._timerList = {}
end

function var_0_0.cancelTimer(arg_2_0, arg_2_1)
	if not arg_2_1 then
		return
	end

	arg_2_1.isDone = true
end

function var_0_0.registRepeatTimer(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)
	local var_3_0 = FightTimer.registRepeatTimer(arg_3_1, arg_3_2, arg_3_3, arg_3_4, arg_3_5)

	table.insert(arg_3_0._timerList, var_3_0)

	return var_3_0
end

function var_0_0.restartRepeatTimer(arg_4_0, arg_4_1, arg_4_2, arg_4_3, arg_4_4)
	return FightTimer.restartRepeatTimer(arg_4_1, arg_4_2, arg_4_3, arg_4_4)
end

function var_0_0.registSingleTimer(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	if arg_5_1 then
		if arg_5_1.isDone then
			return arg_5_0:registRepeatTimer(arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
		else
			arg_5_1:restart(arg_5_4, arg_5_5, arg_5_6)

			return arg_5_1
		end
	else
		return arg_5_0:registRepeatTimer(arg_5_2, arg_5_3, arg_5_4, arg_5_5, arg_5_6)
	end
end

function var_0_0.releaseAllTimer(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._timerList) do
		iter_6_1.isDone = true
	end
end

function var_0_0.onDestructor(arg_7_0)
	arg_7_0:releaseAllTimer()
end

return var_0_0
