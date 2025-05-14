module("modules.logic.room.utils.hex.ResourcePoint", package.seeall)

local var_0_0 = {}

function var_0_0.New(arg_1_0, arg_1_1)
	local var_1_0

	if arg_1_0 and arg_1_1 then
		local var_1_1 = arg_1_0
		local var_1_2 = arg_1_1

		var_1_0 = {
			hexPoint = var_1_1,
			direction = var_1_2
		}
	elseif arg_1_0 then
		local var_1_3 = arg_1_0

		var_1_0 = {
			hexPoint = HexPoint(var_1_3.x, var_1_3.y),
			direction = var_1_3.direction
		}
	end

	setmetatable(var_1_0, var_0_0)

	return var_1_0
end

var_0_0.new = var_0_0.New

local var_0_1 = var_0_0.New
local var_0_2 = {
	x = function(arg_2_0)
		return arg_2_0.hexPoint.x
	end,
	y = function(arg_3_0)
		return arg_3_0.hexPoint.y
	end,
	z = function(arg_4_0)
		return arg_4_0.hexPoint.z
	end
}

function var_0_0.__index(arg_5_0, arg_5_1)
	local var_5_0

	if var_5_0 == nil then
		var_5_0 = rawget(var_0_0, arg_5_1)
	end

	if var_5_0 == nil then
		var_5_0 = rawget(arg_5_0, arg_5_1)
	end

	if var_5_0 == nil then
		var_5_0 = rawget(var_0_2, arg_5_1)

		if var_5_0 ~= nil then
			return var_5_0(arg_5_0)
		end
	end

	return var_5_0
end

function var_0_0.Add(arg_6_0, arg_6_1)
	local var_6_0 = RoomRotateHelper.rotateDirection(arg_6_0.direction, arg_6_1)

	return var_0_1(arg_6_0.hexPoint, var_6_0)
end

var_0_0.add = var_0_0.Add

local var_0_3 = var_0_0.Add

function var_0_0.Sub(arg_7_0, arg_7_1)
	local var_7_0 = RoomRotateHelper.rotateDirection(arg_7_0.direction, -arg_7_1)

	return var_0_1(arg_7_0.hexPoint, var_7_0)
end

var_0_0.sub = var_0_0.Sub

local var_0_4 = var_0_0.Sub

function var_0_0.Connects(arg_8_0)
	local var_8_0 = {}

	if arg_8_0.direction == 0 then
		for iter_8_0 = 1, 6 do
			table.insert(var_8_0, var_0_0(arg_8_0.hexPoint, iter_8_0))
		end
	else
		table.insert(var_8_0, var_0_0(arg_8_0.hexPoint, 0))
		table.insert(var_8_0, arg_8_0 + 1)
		table.insert(var_8_0, arg_8_0 - 1)

		local var_8_1 = arg_8_0.hexPoint:GetNeighbor(arg_8_0.direction)

		table.insert(var_8_0, var_0_0(var_8_1, RoomRotateHelper.oppositeDirection(arg_8_0.direction)))
	end

	return var_8_0
end

var_0_0.connects = var_0_0.Connects
var_0_0.getConnects = var_0_0.Connects
var_0_0.GetConnects = var_0_0.Connects

function var_0_0.ConnectsAll(arg_9_0)
	local var_9_0 = {}

	for iter_9_0 = 0, 6 do
		if arg_9_0.direction ~= iter_9_0 then
			table.insert(var_9_0, var_0_0(arg_9_0.hexPoint, iter_9_0))
		end
	end

	if arg_9_0.direction ~= 0 then
		local var_9_1 = arg_9_0.hexPoint:GetNeighbor(arg_9_0.direction)

		table.insert(var_9_0, var_0_0(var_9_1, RoomRotateHelper.oppositeDirection(arg_9_0.direction)))
	end

	return var_9_0
end

var_0_0.connectsAll = var_0_0.ConnectsAll
var_0_0.getConnectsAll = var_0_0.ConnectsAll
var_0_0.GetConnectsAll = var_0_0.ConnectsAll

function var_0_0.__add(arg_10_0, arg_10_1)
	return var_0_3(arg_10_0, arg_10_1)
end

function var_0_0.__sub(arg_11_0, arg_11_1)
	return var_0_4(arg_11_0, arg_11_1)
end

function var_0_0.__unm(arg_12_0)
	local var_12_0 = RoomRotateHelper.oppositeDirection(arg_12_0.direction)

	return var_0_1(arg_12_0.hexPoint, var_12_0)
end

function var_0_0.__eq(arg_13_0, arg_13_1)
	return arg_13_0.hexPoint == arg_13_1.hexPoint and arg_13_0.direction == arg_13_1.direction
end

function var_0_0.__tostring(arg_14_0)
	return string.format("(x: %s, y: %s, direction: %s)", arg_14_0.x, arg_14_0.y, arg_14_0.direction)
end

function var_0_0.__call(arg_15_0, arg_15_1, arg_15_2)
	return var_0_1(arg_15_1, arg_15_2)
end

setmetatable(var_0_0, var_0_0)

return var_0_0
