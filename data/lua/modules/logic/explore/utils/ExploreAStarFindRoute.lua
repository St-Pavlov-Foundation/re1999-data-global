module("modules.logic.explore.utils.ExploreAStarFindRoute", package.seeall)

local var_0_0 = class("ExploreAStarFindRoute")
local var_0_1 = {
	{
		-1,
		0
	},
	{
		0,
		-1
	},
	{
		0,
		1
	},
	{
		1,
		0
	}
}
local var_0_2
local var_0_3
local var_0_4
local var_0_5
local var_0_6
local var_0_7
local var_0_8
local var_0_9
local var_0_10
local var_0_11
local var_0_12
local var_0_13

local function var_0_14(arg_1_0)
	return string.format("%d_%d", arg_1_0.x, arg_1_0.y)
end

local function var_0_15(arg_2_0, arg_2_1)
	local var_2_0 = {
		x = arg_2_0,
		y = arg_2_1
	}

	var_2_0.last = nil
	var_2_0.g = 0
	var_2_0.h = 0
	var_2_0.f = 0
	var_2_0.key = var_0_14(var_2_0)
	var_2_0.fromDir = nil

	return var_2_0
end

local function var_0_16(arg_3_0, arg_3_1)
	return math.abs(arg_3_1.x - arg_3_0.x) + math.abs(arg_3_1.y - arg_3_0.y)
end

local function var_0_17(arg_4_0, arg_4_1)
	return arg_4_0.x == arg_4_1.x and arg_4_0.y == arg_4_1.y
end

local function var_0_18(arg_5_0, arg_5_1)
	return arg_5_1[arg_5_0.key]
end

local function var_0_19(arg_6_0)
	return arg_6_0.g + 1
end

local function var_0_20(arg_7_0, arg_7_1)
	return var_0_16(arg_7_0, arg_7_1)
end

local function var_0_21(arg_8_0)
	return arg_8_0.g + arg_8_0.h
end

local function var_0_22(arg_9_0, arg_9_1, arg_9_2)
	assert(arg_9_1 >= arg_9_0.x and arg_9_2 >= arg_9_0.y, string.format("point error, (%d, %d) limit(%d, %d)", arg_9_0.x, arg_9_0.y, arg_9_1, arg_9_2))
end

local function var_0_23(arg_10_0, arg_10_1, arg_10_2)
	for iter_10_0, iter_10_1 in pairs(arg_10_0 or {}) do
		var_0_22(iter_10_1, arg_10_1, arg_10_2)
	end
end

local function var_0_24(arg_11_0, arg_11_1)
	if arg_11_0.f == arg_11_1.f and arg_11_0.last == arg_11_1.last then
		if var_0_6 then
			if ExploreHelper.isPosEqual(arg_11_0, var_0_6) then
				return true
			elseif ExploreHelper.isPosEqual(arg_11_1, var_0_6) then
				return false
			end
		end

		return (arg_11_0.last and arg_11_0.fromDir == arg_11_0.last.fromDir and -1 or 1) < (arg_11_1.last and arg_11_1.fromDir == arg_11_1.last.fromDir and -1 or 1)
	end

	return arg_11_0.f < arg_11_1.f
end

function var_0_0.ctor(arg_12_0)
	return
end

function var_0_0.startFindPath(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	var_0_8 = arg_13_1
	var_0_2 = var_0_15(arg_13_2.x, arg_13_2.y)
	var_0_3 = var_0_15(arg_13_3.x, arg_13_3.y)
	var_0_6 = arg_13_4
	var_0_5 = var_0_15(arg_13_2.x, arg_13_2.y)
	var_0_10 = {}
	var_0_9 = {}
	var_0_11 = {}
	var_0_12 = {}
	var_0_10[var_0_2.key] = var_0_2

	table.insert(var_0_9, var_0_2)

	var_0_13 = arg_13_0:findPath() or {}

	return var_0_13, var_0_5
end

function var_0_0.getNextPoints(arg_14_0, arg_14_1)
	local var_14_0 = {}

	for iter_14_0 = 1, #var_0_1 do
		local var_14_1 = var_0_1[iter_14_0]
		local var_14_2 = var_0_15(arg_14_1.x + var_14_1[1], arg_14_1.y + var_14_1[2])

		var_14_2.fromDir = var_14_1
		var_14_2.last = arg_14_1

		if var_0_18(var_14_2, var_0_8) then
			var_14_2.g = var_0_19(arg_14_1)
			var_14_2.h = var_0_20(arg_14_1, var_0_3)
			var_14_2.f = var_0_21(var_14_2)

			table.insert(var_14_0, var_14_2)
		end
	end

	return var_14_0
end

function var_0_0.findPath(arg_15_0)
	while #var_0_9 > 0 do
		var_0_4 = var_0_9[1]

		if arg_15_0:getDistance(var_0_4, var_0_3) < arg_15_0:getDistance(var_0_5, var_0_3) then
			var_0_5 = var_0_15(var_0_4.x, var_0_4.y)
		end

		table.remove(var_0_9, 1)

		var_0_10[var_0_4.key] = nil

		if var_0_17(var_0_4, var_0_3) then
			return arg_15_0:makePath(var_0_4)
		else
			var_0_12[var_0_4.key] = var_0_4

			local var_15_0 = arg_15_0:getNextPoints(var_0_4)

			for iter_15_0 = 1, #var_15_0 do
				local var_15_1 = var_15_0[iter_15_0]

				if var_0_10[var_15_1.key] == nil and var_0_12[var_15_1.key] == nil and var_0_18(var_15_1, var_0_8) then
					var_0_10[var_15_1.key] = var_15_1

					table.insert(var_0_9, var_15_1)
				end
			end

			table.sort(var_0_9, var_0_24)
		end
	end

	return nil
end

function var_0_0.makePath(arg_16_0, arg_16_1)
	local var_16_0 = {}
	local var_16_1 = arg_16_1

	while var_16_1.last ~= nil do
		table.insert(var_16_0, var_16_1)

		var_16_1 = var_16_1.last
	end

	local var_16_2 = var_16_1

	return var_16_0
end

function var_0_0.getDistance(arg_17_0, arg_17_1, arg_17_2)
	return math.abs(arg_17_1.x - arg_17_2.x) + math.abs(arg_17_1.y - arg_17_2.y)
end

return var_0_0
