module("modules.logic.fight.FightUpdateMgr", package.seeall)

local var_0_0 = class("FightUpdateMgr")
local var_0_1 = FightUpdateItem
local var_0_2 = Time
local var_0_3 = {}
local var_0_4 = 0
local var_0_5 = 0
local var_0_6 = 10

function var_0_0.registUpdate(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = var_0_1.New(arg_1_0, arg_1_1, arg_1_2)

	var_0_4 = var_0_4 + 1
	var_0_3[var_0_4] = var_1_0

	return var_1_0
end

function var_0_0.cancelUpdate(arg_2_0)
	if not arg_2_0 then
		return
	end

	arg_2_0.isDone = true
end

function var_0_0.update()
	if var_0_4 == 0 then
		return
	end

	local var_3_0 = var_0_2.deltaTime

	for iter_3_0 = 1, var_0_4 do
		var_0_3[iter_3_0]:update(var_3_0)
	end

	var_0_5 = var_0_5 + var_3_0

	if var_0_5 > var_0_6 then
		var_0_5 = 0

		local var_3_1 = 1

		for iter_3_1 = 1, var_0_4 do
			local var_3_2 = var_0_3[iter_3_1]

			if not var_3_2.isDone then
				if iter_3_1 ~= var_3_1 then
					var_0_3[var_3_1] = var_3_2
					var_0_3[iter_3_1] = nil
				end

				var_3_1 = var_3_1 + 1
			else
				var_0_3[iter_3_1] = nil
			end
		end

		var_0_4 = var_3_1 - 1
	end
end

UpdateBeat:Add(var_0_0.update, var_0_0)

return var_0_0
