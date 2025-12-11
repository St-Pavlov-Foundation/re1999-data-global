local var_0_0 = _G.rawset
local var_0_1 = _G.assert
local var_0_2 = string.format

local function var_0_3(arg_1_0, arg_1_1)
	return string.split(arg_1_0, arg_1_1) or {}
end

local function var_0_4(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = var_0_3(arg_2_0, ".")
	local var_2_1 = arg_2_2 or _G

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if iter_2_0 == #var_2_0 and arg_2_1 ~= nil then
			var_0_0(var_2_1, iter_2_1, arg_2_1)
		else
			var_0_0(var_2_1, iter_2_1, var_2_1[iter_2_1] or {})
		end

		var_2_1 = var_2_1[iter_2_1]
	end

	return var_2_1
end

local function var_0_5(arg_3_0)
	var_0_1(type(arg_3_0) == "string")

	return var_0_2("_r.%s", arg_3_0)
end

local function var_0_6(arg_4_0, arg_4_1)
	local var_4_0 = var_0_3(arg_4_1, ".")
	local var_4_1 = #var_4_0
	local var_4_2 = arg_4_0

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		var_4_2 = var_4_2[iter_4_1]

		if not var_4_2 then
			break
		end

		var_4_1 = var_4_1 - 1
	end

	return var_4_1 == 0 and var_4_2, var_4_2
end

return function(arg_5_0, arg_5_1)
	local var_5_0 = var_0_5(arg_5_1)
	local var_5_1, var_5_2 = var_0_6(arg_5_0, var_5_0)

	if var_5_1 then
		return var_5_2
	end

	local var_5_3, var_5_4 = var_0_6(arg_5_0, arg_5_1)

	var_0_1(var_5_3, var_0_2("can not found define.%s", arg_5_1))

	local var_5_5 = var_0_4(var_5_0, nil, arg_5_0)
	local var_5_6 = {}

	for iter_5_0, iter_5_1 in pairs(var_5_4) do
		var_5_5[iter_5_1] = iter_5_0

		var_0_1(not var_5_6[iter_5_1], var_0_2("%s: can not set same value when use RD, conflict between %s and %s", var_5_0, iter_5_1, iter_5_0))

		var_5_6[iter_5_1] = iter_5_0
	end

	return var_5_5
end
