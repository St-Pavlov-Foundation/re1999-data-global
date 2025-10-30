module("modules.logic.fight.FightTimer", package.seeall)

local var_0_0 = class("FightTimer")
local var_0_1 = FightTimerItem
local var_0_2 = {}
local var_0_3 = 0
local var_0_4 = 0
local var_0_5 = 10

function var_0_0.registTimer(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	return var_0_0.registRepeatTimer(arg_1_0, arg_1_1, arg_1_2, 1, arg_1_3)
end

function var_0_0.registRepeatTimer(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4)
	local var_2_0 = var_0_1.New(arg_2_2, arg_2_3, arg_2_0, arg_2_1, arg_2_4)

	var_0_3 = var_0_3 + 1
	var_0_2[var_0_3] = var_2_0

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

	var_0_3 = var_0_3 + 1
	var_0_2[var_0_3] = arg_4_0

	return arg_4_0
end

function var_0_0.update(arg_5_0, arg_5_1)
	if var_0_3 == 0 then
		return
	end

	for iter_5_0 = 1, var_0_3 do
		var_0_2[iter_5_0]:update(arg_5_1)
	end

	var_0_4 = var_0_4 + arg_5_1

	if var_0_4 > var_0_5 then
		var_0_4 = 0

		local var_5_0 = 1

		for iter_5_1 = 1, var_0_3 do
			local var_5_1 = var_0_2[iter_5_1]

			if not var_5_1.isDone then
				if iter_5_1 ~= var_5_0 then
					var_0_2[var_5_0] = var_5_1
					var_0_2[iter_5_1] = nil
				end

				var_5_0 = var_5_0 + 1
			else
				var_0_2[iter_5_1] = nil
			end
		end

		var_0_3 = var_5_0 - 1
	end
end

FightUpdateMgr.registUpdate(var_0_0.update, var_0_0)

return var_0_0
