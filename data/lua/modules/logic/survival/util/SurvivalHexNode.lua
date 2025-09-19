module("modules.logic.survival.util.SurvivalHexNode", package.seeall)

local var_0_0 = {}

function var_0_0.New(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = setmetatable({}, var_0_0)

	var_1_0:set(arg_1_0, arg_1_1, arg_1_2)

	return var_1_0
end

function var_0_0.set(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.q = arg_2_1 or 0
	arg_2_0.r = arg_2_2 or 0
	arg_2_0.s = arg_2_3 or -arg_2_0.q - arg_2_0.r
	arg_2_0.gCost = 0
	arg_2_0.hCost = 0
	arg_2_0.parent = nil
end

function var_0_0.fCost(arg_3_0)
	return arg_3_0.gCost + arg_3_0.hCost
end

function var_0_0.rotateDir(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 < 0 then
		arg_4_2 = arg_4_2 + 6
	end

	local var_4_0
	local var_4_1
	local var_4_2
	local var_4_3 = arg_4_0.q - arg_4_1.q
	local var_4_4 = arg_4_0.r - arg_4_1.r
	local var_4_5 = arg_4_0.s - arg_4_1.s

	if arg_4_2 == 0 then
		var_4_0, var_4_1, var_4_2 = var_4_3, var_4_4, var_4_5
	elseif arg_4_2 == 1 then
		var_4_0 = -var_4_4
		var_4_1 = -var_4_5
		var_4_2 = -var_4_3
	elseif arg_4_2 == 2 then
		var_4_0 = var_4_5
		var_4_1 = var_4_3
		var_4_2 = var_4_4
	elseif arg_4_2 == 3 then
		var_4_0 = -var_4_3
		var_4_1 = -var_4_4
		var_4_2 = -var_4_5
	elseif arg_4_2 == 4 then
		var_4_0 = var_4_4
		var_4_1 = var_4_5
		var_4_2 = var_4_3
	elseif arg_4_2 == 5 then
		var_4_0 = -var_4_5
		var_4_1 = -var_4_3
		var_4_2 = -var_4_4
	end

	arg_4_0.q = arg_4_1.q + var_4_0
	arg_4_0.r = arg_4_1.r + var_4_1
	arg_4_0.s = arg_4_1.s + var_4_2
end

function var_0_0.Add(arg_5_0, arg_5_1)
	arg_5_0.q = arg_5_0.q + arg_5_1.q
	arg_5_0.r = arg_5_0.r + arg_5_1.r
	arg_5_0.s = arg_5_0.s + arg_5_1.s
end

function var_0_0.__eq(arg_6_0, arg_6_1)
	return arg_6_0.q == arg_6_1.q and arg_6_0.r == arg_6_1.r
end

function var_0_0.__add(arg_7_0, arg_7_1)
	return var_0_0.New(arg_7_0.q + arg_7_1.q, arg_7_0.r + arg_7_1.r)
end

function var_0_0.__sub(arg_8_0, arg_8_1)
	return var_0_0.New(arg_8_0.q - arg_8_1.q, arg_8_0.r - arg_8_1.r)
end

function var_0_0.__tostring(arg_9_0)
	return string.format("[%d,%d,%d]", arg_9_0.q, arg_9_0.r, arg_9_0.s)
end

var_0_0.__index = var_0_0

return var_0_0
