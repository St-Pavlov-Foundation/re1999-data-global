module("modules.logic.player.model.KeyValueSimplePropertyMO", package.seeall)

local var_0_0 = pureTable("KeyValueSimplePropertyMO")

function var_0_0.ctor(arg_1_0)
	arg_1_0._isNumber = true
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.id
	arg_2_0.property = arg_2_1.property
	arg_2_0._map = {}

	local var_2_0 = GameUtil.splitString2(arg_2_1.property, arg_2_0._isNumber, "|", "#")

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		local var_2_1 = iter_2_1[1]
		local var_2_2 = iter_2_1[2]

		arg_2_0._map[var_2_1] = var_2_2
	end
end

function var_0_0.getValue(arg_3_0, arg_3_1, arg_3_2)
	return arg_3_0._map and arg_3_0._map[arg_3_1] or arg_3_2
end

function var_0_0.setValue(arg_4_0, arg_4_1, arg_4_2)
	if not arg_4_0._map then
		arg_4_0._map = {}
	end

	arg_4_0._map[arg_4_1] = arg_4_2
end

function var_0_0.getString(arg_5_0)
	local var_5_0 = ""

	if not arg_5_0._map then
		return var_5_0
	end

	for iter_5_0, iter_5_1 in pairs(arg_5_0._map) do
		local var_5_1 = string.format("%s#%s", iter_5_0, iter_5_1)

		if not string.nilorempty(var_5_0) then
			var_5_0 = var_5_0 .. "|" .. var_5_1
		else
			var_5_0 = var_5_1
		end
	end

	return var_5_0
end

return var_0_0
