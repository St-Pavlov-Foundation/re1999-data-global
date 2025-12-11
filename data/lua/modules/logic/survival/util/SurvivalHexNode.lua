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

	return arg_2_0
end

function var_0_0.copyFrom(arg_3_0, arg_3_1)
	arg_3_0.q = arg_3_1.q
	arg_3_0.r = arg_3_1.r
	arg_3_0.s = arg_3_1.s
	arg_3_0.gCost = 0
	arg_3_0.hCost = 0
	arg_3_0.parent = nil

	return arg_3_0
end

function var_0_0.clone(arg_4_0)
	return var_0_0.New(arg_4_0.q, arg_4_0.r)
end

function var_0_0.fCost(arg_5_0)
	return arg_5_0.gCost + arg_5_0.hCost
end

function var_0_0.rotateDir(arg_6_0, arg_6_1, arg_6_2)
	if arg_6_2 < 0 then
		arg_6_2 = arg_6_2 + 6
	end

	local var_6_0
	local var_6_1
	local var_6_2
	local var_6_3 = arg_6_0.q - arg_6_1.q
	local var_6_4 = arg_6_0.r - arg_6_1.r
	local var_6_5 = arg_6_0.s - arg_6_1.s

	if arg_6_2 == 0 then
		var_6_0, var_6_1, var_6_2 = var_6_3, var_6_4, var_6_5
	elseif arg_6_2 == 1 then
		var_6_0 = -var_6_4
		var_6_1 = -var_6_5
		var_6_2 = -var_6_3
	elseif arg_6_2 == 2 then
		var_6_0 = var_6_5
		var_6_1 = var_6_3
		var_6_2 = var_6_4
	elseif arg_6_2 == 3 then
		var_6_0 = -var_6_3
		var_6_1 = -var_6_4
		var_6_2 = -var_6_5
	elseif arg_6_2 == 4 then
		var_6_0 = var_6_4
		var_6_1 = var_6_5
		var_6_2 = var_6_3
	elseif arg_6_2 == 5 then
		var_6_0 = -var_6_5
		var_6_1 = -var_6_3
		var_6_2 = -var_6_4
	end

	arg_6_0.q = arg_6_1.q + var_6_0
	arg_6_0.r = arg_6_1.r + var_6_1
	arg_6_0.s = arg_6_1.s + var_6_2
end

function var_0_0.Add(arg_7_0, arg_7_1)
	arg_7_0.q = arg_7_0.q + arg_7_1.q
	arg_7_0.r = arg_7_0.r + arg_7_1.r
	arg_7_0.s = arg_7_0.s + arg_7_1.s

	return arg_7_0
end

function var_0_0.__eq(arg_8_0, arg_8_1)
	return arg_8_0.q == arg_8_1.q and arg_8_0.r == arg_8_1.r
end

function var_0_0.__add(arg_9_0, arg_9_1)
	return var_0_0.New(arg_9_0.q + arg_9_1.q, arg_9_0.r + arg_9_1.r)
end

function var_0_0.__sub(arg_10_0, arg_10_1)
	return var_0_0.New(arg_10_0.q - arg_10_1.q, arg_10_0.r - arg_10_1.r)
end

function var_0_0.__tostring(arg_11_0)
	return string.format("[%d,%d,%d]", arg_11_0.q, arg_11_0.r, arg_11_0.s)
end

var_0_0.__index = var_0_0

return var_0_0
