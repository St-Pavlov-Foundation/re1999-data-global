module("modules.logic.fight.FightUpdateMgr", package.seeall)

local var_0_0 = class("FightUpdateMgr")
local var_0_1 = {}
local var_0_2 = 0
local var_0_3 = 10

function var_0_0.registUpdate(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = FightUpdateItem.New(arg_1_0, arg_1_1, arg_1_2)

	table.insert(var_0_1, var_1_0)

	return var_1_0
end

function var_0_0.cancelUpdate(arg_2_0)
	if not arg_2_0 then
		return
	end

	arg_2_0.isDone = true
end

function var_0_0.update()
	local var_3_0 = Time.deltaTime

	for iter_3_0, iter_3_1 in ipairs(var_0_1) do
		iter_3_1:update(var_3_0)
	end

	var_0_2 = var_0_2 + var_3_0

	if var_0_2 > var_0_3 then
		var_0_2 = 0

		for iter_3_2 = #var_0_1, 1, -1 do
			if var_0_1[iter_3_2].isDone then
				table.remove(var_0_1, iter_3_2)
			end
		end
	end
end

UpdateBeat:Add(var_0_0.update, var_0_0)

return var_0_0
