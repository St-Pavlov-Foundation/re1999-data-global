module("modules.common.utils.Bitwise", package.seeall)

local var_0_0 = require("bit")
local var_0_1 = {
	["&"] = function(arg_1_0, arg_1_1)
		return var_0_0.band(arg_1_0, arg_1_1)
	end,
	["|"] = function(arg_2_0, arg_2_1)
		return var_0_0.bor(arg_2_0, arg_2_1)
	end,
	[">>"] = function(arg_3_0, arg_3_1)
		return var_0_0.rshift(arg_3_0, arg_3_1)
	end,
	["<<"] = function(arg_4_0, arg_4_1)
		return var_0_0.lshift(arg_4_0, arg_4_1)
	end,
	["^"] = function(arg_5_0, arg_5_1)
		return var_0_0.bxor(arg_5_0, arg_5_1)
	end,
	["~"] = function(arg_6_0)
		return var_0_0.bnot(arg_6_0)
	end
}
local var_0_2 = var_0_1

function var_0_2.hasAny(arg_7_0, arg_7_1)
	return var_0_1["&"](arg_7_0, arg_7_1) ~= 0
end

function var_0_2.has(arg_8_0, arg_8_1)
	return var_0_1["&"](arg_8_0, arg_8_1) == arg_8_1
end

function var_0_2.set(arg_9_0, arg_9_1)
	return var_0_1["|"](arg_9_0, arg_9_1)
end

function var_0_2.unset(arg_10_0, arg_10_1)
	return var_0_1["&"](arg_10_0, var_0_1["~"](arg_10_1))
end

function var_0_2.lowbit(arg_11_0)
	return var_0_1["&"](arg_11_0, -arg_11_0)
end

function var_0_2.isPow2(arg_12_0)
	if arg_12_0 == 0 then
		return true
	end

	return var_0_1["&"](arg_12_0, arg_12_0 - 1) == 0
end

function var_0_2.nextPow2(arg_13_0)
	arg_13_0 = arg_13_0 - 1
	arg_13_0 = var_0_1["|"](arg_13_0, var_0_1[">>"](arg_13_0, 1))
	arg_13_0 = var_0_1["|"](arg_13_0, var_0_1[">>"](arg_13_0, 2))
	arg_13_0 = var_0_1["|"](arg_13_0, var_0_1[">>"](arg_13_0, 4))
	arg_13_0 = var_0_1["|"](arg_13_0, var_0_1[">>"](arg_13_0, 8))
	arg_13_0 = var_0_1["|"](arg_13_0, var_0_1[">>"](arg_13_0, 16))
	arg_13_0 = var_0_1["|"](arg_13_0, var_0_1[">>"](arg_13_0, 32))

	return arg_13_0 + 1
end

function var_0_2.count1(arg_14_0)
	local var_14_0 = 0

	while arg_14_0 ~= 0 do
		arg_14_0 = arg_14_0 - var_0_1.lowbit(arg_14_0)
		var_14_0 = var_14_0 + 1
	end

	return var_14_0
end

function var_0_2.unitTest()
	assert(var_0_1["&"](2, 3) == 2)
	assert(var_0_1["|"](1, 2) == 3)
	assert(var_0_1[">>"](2, 1) == 1)
	assert(var_0_1["<<"](2, 1) == 4)
	assert(var_0_1["^"](1, 3) == 2)
	assert(var_0_1["~"](1) == -2)
	assert(var_0_1["~"](4) == -5)
	assert(var_0_2.hasAny(5, 1) == true)
	assert(var_0_2.hasAny(5, 2) == false)
	assert(var_0_2.hasAny(5, 3) == true)
	assert(var_0_2.has(5, 3) == false)
	assert(var_0_2.has(6, 3) == false)
	assert(var_0_2.has(6, 4) == true)
	assert(var_0_2.set(5, 1) == 5)
	assert(var_0_2.unset(5, 1) == 4)
	assert(var_0_2.unset(5, 3) == 4)
	assert(var_0_2.lowbit(5) == 1)
	assert(var_0_2.lowbit(4) == 4)
	assert(var_0_2.isPow2(0) == true)
	assert(var_0_2.isPow2(4) == true)
	assert(var_0_2.isPow2(64) == true)
	assert(var_0_2.isPow2(5) == false)
	assert(var_0_2.nextPow2(8) == 8)
	assert(var_0_2.nextPow2(16) == 16)
	assert(var_0_2.nextPow2(17) == 32)
	assert(var_0_2.nextPow2(1) == 1)
	assert(var_0_2.nextPow2(0) == 0)
	assert(var_0_2.nextPow2(320) == 512)
	assert(var_0_2.count1(5) == 2)
	assert(var_0_2.count1(15) == 4)
	assert(var_0_2.count1(128) == 1)
	assert(var_0_2.count1(127) == 7)
end

return var_0_2
