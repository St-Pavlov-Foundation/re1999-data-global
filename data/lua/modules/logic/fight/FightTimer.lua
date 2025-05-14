module("modules.logic.fight.FightTimer", package.seeall)

local var_0_0 = class("FightTimer")
local var_0_1 = {}
local var_0_2 = 0
local var_0_3 = 10

function var_0_0.registTimer(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	return var_0_0.registRepeatTimer(arg_1_0, arg_1_1, arg_1_2, 1, arg_1_3)
end

function var_0_0.registRepeatTimer(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = FightTimerItem.New(arg_2_2, arg_2_3, arg_2_0, arg_2_1, arg_2_4)

	table.insert(var_0_1, var_2_0)

	return var_2_0
end

function var_0_0.cancelTimer(arg_3_0)
	if not arg_3_0 then
		return
	end

	arg_3_0.isDone = true
end

function var_0_0.restartRepeatTimer(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_0:restart(arg_4_1, arg_4_2, arg_4_3)
	table.insert(var_0_1, arg_4_0)

	return arg_4_0
end

function var_0_0.update()
	local var_5_0 = Time.deltaTime

	for iter_5_0, iter_5_1 in ipairs(var_0_1) do
		iter_5_1:update(var_5_0)
	end

	var_0_2 = var_0_2 + var_5_0

	if var_0_2 > var_0_3 then
		var_0_2 = 0

		for iter_5_2 = #var_0_1, 1, -1 do
			if var_0_1[iter_5_2].isDone then
				table.remove(var_0_1, iter_5_2)
			end
		end
	end
end

UpdateBeat:Add(var_0_0.update, var_0_0)

return var_0_0
