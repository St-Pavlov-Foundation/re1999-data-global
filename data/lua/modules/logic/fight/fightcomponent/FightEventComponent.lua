module("modules.logic.fight.fightcomponent.FightEventComponent", package.seeall)

local var_0_0 = class("FightEventComponent", FightBaseClass)

function var_0_0.onConstructor(arg_1_0)
	arg_1_0._eventItems = {}
end

function var_0_0.registEvent(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	for iter_2_0, iter_2_1 in ipairs(arg_2_0._eventItems) do
		if arg_2_1 == iter_2_1[1] and arg_2_2 == iter_2_1[2] and arg_2_3 == iter_2_1[3] and arg_2_4 == iter_2_1[4] then
			return
		end
	end

	arg_2_1:registerCallback(arg_2_2, arg_2_3, arg_2_4, arg_2_5)
	table.insert(arg_2_0._eventItems, {
		arg_2_1,
		arg_2_2,
		arg_2_3,
		arg_2_4,
		arg_2_5
	})
end

function var_0_0.cancelEvent(arg_3_0, arg_3_1, arg_3_2, arg_3_3, arg_3_4)
	for iter_3_0 = #arg_3_0._eventItems, 1, -1 do
		local var_3_0 = arg_3_0._eventItems[iter_3_0]

		if arg_3_1 == var_3_0[1] and arg_3_2 == var_3_0[2] and arg_3_3 == var_3_0[3] and arg_3_4 == var_3_0[4] then
			arg_3_1:unregisterCallback(arg_3_2, arg_3_3, arg_3_4)
			table.remove(arg_3_0._eventItems, iter_3_0)
		end
	end
end

function var_0_0.lockEvent(arg_4_0)
	if arg_4_0.LOCK then
		return
	end

	arg_4_0.LOCK = true

	for iter_4_0 = #arg_4_0._eventItems, 1, -1 do
		local var_4_0 = arg_4_0._eventItems[iter_4_0]

		var_4_0[1]:unregisterCallback(var_4_0[2], var_4_0[3], var_4_0[4])
	end
end

function var_0_0.unlockEvent(arg_5_0)
	if not arg_5_0.LOCK then
		return
	end

	arg_5_0.LOCK = nil

	for iter_5_0 = 1, #arg_5_0._eventItems do
		local var_5_0 = arg_5_0._eventItems[iter_5_0]

		var_5_0[1]:registerCallback(var_5_0[2], var_5_0[3], var_5_0[4], var_5_0[5])
	end
end

function var_0_0.onDestructor(arg_6_0)
	for iter_6_0 = #arg_6_0._eventItems, 1, -1 do
		local var_6_0 = arg_6_0._eventItems[iter_6_0]

		var_6_0[1]:unregisterCallback(var_6_0[2], var_6_0[3], var_6_0[4])
	end

	arg_6_0._eventItems = nil
end

return var_0_0
