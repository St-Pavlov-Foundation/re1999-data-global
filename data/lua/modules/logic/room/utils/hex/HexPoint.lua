module("modules.logic.room.utils.hex.HexPoint", package.seeall)

local var_0_0 = {}

function var_0_0.New(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = 0

	if arg_1_0 == nil then
		var_1_0 = var_1_0 + 1
	end

	if arg_1_1 == nil then
		var_1_0 = var_1_0 + 1
	end

	if arg_1_2 == nil then
		var_1_0 = var_1_0 + 1
	end

	if var_1_0 > 1 then
		logError("HexPoint: xyz需要至少两个值")

		arg_1_0, arg_1_1, arg_1_2 = 0, 0, 0
	elseif arg_1_0 == nil then
		arg_1_0 = -arg_1_1 - arg_1_2
	elseif arg_1_1 == nil then
		arg_1_1 = -arg_1_2 - arg_1_0
	elseif arg_1_2 == nil then
		arg_1_2 = -arg_1_0 - arg_1_1
	end

	local var_1_1 = {
		x = arg_1_0,
		y = arg_1_1
	}

	setmetatable(var_1_1, var_0_0)

	return var_1_1
end

var_0_0.new = var_0_0.New

local var_0_1 = var_0_0.New
local var_0_2 = {
	z = function(arg_2_0)
		if arg_2_0.x == 0 and arg_2_0.y == 0 then
			return 0
		end

		return -arg_2_0.x - arg_2_0.y
	end,
	q = function(arg_3_0)
		return arg_3_0.x
	end,
	r = function(arg_4_0)
		return arg_4_0.y
	end
}

function var_0_2.s(arg_5_0)
	return var_0_2.z(arg_5_0)
end

function var_0_0.__index(arg_6_0, arg_6_1)
	local var_6_0

	if var_6_0 == nil then
		var_6_0 = rawget(var_0_0, arg_6_1)
	end

	if var_6_0 == nil then
		var_6_0 = rawget(arg_6_0, arg_6_1)
	end

	if var_6_0 == nil then
		var_6_0 = rawget(var_0_2, arg_6_1)

		if var_6_0 ~= nil then
			return var_6_0(arg_6_0)
		end
	end

	return var_6_0
end

var_0_0.directions = {
	[0] = var_0_1(0, 0),
	var_0_1(0, -1),
	var_0_1(1, -1),
	var_0_1(1, 0),
	var_0_1(0, 1),
	var_0_1(-1, 1),
	(var_0_1(-1, 0))
}

function var_0_0.Add(arg_7_0, arg_7_1)
	return var_0_1(arg_7_0.x + arg_7_1.x, arg_7_0.y + arg_7_1.y)
end

var_0_0.add = var_0_0.Add

local var_0_3 = var_0_0.Add

function var_0_0.Sub(arg_8_0, arg_8_1)
	return var_0_1(arg_8_0.x - arg_8_1.x, arg_8_0.y - arg_8_1.y)
end

var_0_0.sub = var_0_0.Sub

local var_0_4 = var_0_0.Sub

function var_0_0.Mul(arg_9_0, arg_9_1)
	return HexMath.round(var_0_1(arg_9_0.x * arg_9_1, arg_9_0.y * arg_9_1))
end

var_0_0.mul = var_0_0.Mul

local var_0_5 = var_0_0.Mul

function var_0_0.Div(arg_10_0, arg_10_1)
	return HexMath.round(var_0_1(arg_10_0.x / arg_10_1, arg_10_0.y / arg_10_1))
end

var_0_0.div = var_0_0.Div

local var_0_6 = var_0_0.Div

function var_0_0.Distance(arg_11_0, arg_11_1)
	return (math.abs(arg_11_0.x - arg_11_1.x) + math.abs(arg_11_0.y - arg_11_1.y) + math.abs(arg_11_0.z - arg_11_1.z)) / 2
end

var_0_0.distance = var_0_0.Distance
var_0_0.getDistance = var_0_0.Distance
var_0_0.GetDistance = var_0_0.Distance

function var_0_0.DirectDistance(arg_12_0, arg_12_1)
	local var_12_0 = HexMath.hexToPosition(arg_12_0)
	local var_12_1 = HexMath.hexToPosition(arg_12_1)

	return Vector2.Distance(var_12_0, var_12_1)
end

var_0_0.directDistance = var_0_0.DirectDistance
var_0_0.getDirectDistance = var_0_0.DirectDistance
var_0_0.GetDirectDistance = var_0_0.DirectDistance

function var_0_0.InRanges(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = {}

	arg_13_1 = math.abs(arg_13_1 or 0)

	for iter_13_0 = -arg_13_1, arg_13_1 do
		for iter_13_1 = math.max(-arg_13_1, -iter_13_0 - arg_13_1), math.min(arg_13_1, -iter_13_0 + arg_13_1) do
			if not arg_13_2 or iter_13_0 ~= 0 or iter_13_1 ~= 0 then
				table.insert(var_13_0, var_0_3(arg_13_0, var_0_1(iter_13_0, iter_13_1)))
			end
		end
	end

	return var_13_0
end

var_0_0.inRanges = var_0_0.InRanges
var_0_0.getInRanges = var_0_0.InRanges
var_0_0.GetInRanges = var_0_0.InRanges

function var_0_0.OnRanges(arg_14_0, arg_14_1)
	local var_14_0 = {}

	arg_14_1 = math.abs(arg_14_1 or 0)

	local var_14_1 = var_0_0.directions[5] * arg_14_1 + arg_14_0

	for iter_14_0 = 1, 6 do
		for iter_14_1 = 1, arg_14_1 do
			table.insert(var_14_0, var_14_1)

			var_14_1 = var_14_1 + var_0_0.directions[iter_14_0]
		end
	end

	return var_14_0
end

var_0_0.onRanges = var_0_0.OnRanges
var_0_0.getOnRanges = var_0_0.OnRanges
var_0_0.GetOnRanges = var_0_0.OnRanges

function var_0_0.Neighbors(arg_15_0)
	local var_15_0 = {}

	for iter_15_0 = 1, 6 do
		local var_15_1 = arg_15_0 + var_0_0.directions[iter_15_0]

		table.insert(var_15_0, var_15_1)
	end

	return var_15_0
end

var_0_0.neighbors = var_0_0.Neighbors
var_0_0.getNeighbors = var_0_0.Neighbors
var_0_0.GetNeighbors = var_0_0.Neighbors

function var_0_0.Neighbor(arg_16_0, arg_16_1)
	if arg_16_1 < 1 or arg_16_1 > 6 then
		logError("HexPoint: Neighbor index需要在1~6之间")

		return nil
	end

	return arg_16_0 + var_0_0.directions[arg_16_1]
end

var_0_0.neighbor = var_0_0.Neighbor
var_0_0.getNeighbor = var_0_0.Neighbor
var_0_0.GetNeighbor = var_0_0.Neighbor

function var_0_0.IntersectingRanges(arg_17_0, arg_17_1, arg_17_2, arg_17_3, arg_17_4)
	local var_17_0 = {}

	arg_17_2 = math.abs(arg_17_2 or 0)
	arg_17_3 = arg_17_3 and math.abs(arg_17_3) or arg_17_2

	logError("HexPoint: 未实现IntersectingRanges")

	return var_17_0
end

var_0_0.intersectingRanges = var_0_0.IntersectingRanges
var_0_0.getIntersectingRanges = var_0_0.IntersectingRanges
var_0_0.GetIntersectingRanges = var_0_0.IntersectingRanges

function var_0_0.Rotate(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_1 = arg_18_1 or var_0_1(0, 0)
	arg_18_2 = RoomRotateHelper.getMod(arg_18_2, 6)

	local var_18_0 = arg_18_0.x - arg_18_1.x
	local var_18_1 = arg_18_0.y - arg_18_1.y

	for iter_18_0 = 1, arg_18_2 do
		if arg_18_3 then
			var_18_0, var_18_1 = -var_18_1, var_18_0 + var_18_1
		else
			var_18_0, var_18_1 = var_18_0 + var_18_1, -var_18_0
		end
	end

	return var_0_1(var_18_0 + arg_18_1.x, var_18_1 + arg_18_1.y)
end

var_0_0.rotate = var_0_0.Rotate
var_0_0.getRotate = var_0_0.Rotate
var_0_0.GetRotate = var_0_0.Rotate

function var_0_0.ConvertToOffsetCoordinates(arg_19_0)
	local var_19_0 = arg_19_0.x
	local var_19_1 = arg_19_0.y
	local var_19_2 = var_19_0 + (var_19_1 - RoomRotateHelper.getMod(var_19_1, 2)) / 2
	local var_19_3 = var_19_1

	return Vector2(var_19_2, var_19_3)
end

var_0_0.convertToOffsetCoordinates = var_0_0.ConvertToOffsetCoordinates
var_0_0.getConvertToOffsetCoordinates = var_0_0.ConvertToOffsetCoordinates
var_0_0.GetConvertToOffsetCoordinates = var_0_0.ConvertToOffsetCoordinates

function var_0_0.OnLine(arg_20_0, arg_20_1)
	local var_20_0 = var_0_0.Distance(arg_20_0, arg_20_1)
	local var_20_1 = {}
	local var_20_2 = {}

	for iter_20_0 = 0, var_20_0 do
		local var_20_3 = HexMath.round(var_0_0.lerp(arg_20_0, arg_20_1, iter_20_0 / var_20_0))

		if not var_20_2[tostring(var_20_3)] then
			table.insert(var_20_1, var_20_3)

			var_20_2[tostring(var_20_3)] = true
		end
	end

	return var_20_1
end

function var_0_0.lerp(arg_21_0, arg_21_1, arg_21_2)
	return var_0_1(arg_21_0.x + (arg_21_1.x - arg_21_0.x) * arg_21_2, arg_21_0.y + (arg_21_1.y - arg_21_0.y) * arg_21_2)
end

function var_0_0.__add(arg_22_0, arg_22_1)
	return var_0_3(arg_22_0, arg_22_1)
end

function var_0_0.__sub(arg_23_0, arg_23_1)
	return var_0_4(arg_23_0, arg_23_1)
end

function var_0_0.__mul(arg_24_0, arg_24_1)
	return var_0_5(arg_24_0, arg_24_1)
end

function var_0_0.__div(arg_25_0, arg_25_1)
	return var_0_6(arg_25_0, arg_25_1)
end

function var_0_0.__unm(arg_26_0)
	return var_0_1(-arg_26_0.x, -arg_26_0.y)
end

function var_0_0.__eq(arg_27_0, arg_27_1)
	return arg_27_0.x == arg_27_1.x and arg_27_0.y == arg_27_1.y
end

function var_0_0.__tostring(arg_28_0)
	return string.format("(%s, %s, %s)", arg_28_0.x, arg_28_0.y, arg_28_0.z)
end

function var_0_0.__call(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	return var_0_1(arg_29_1, arg_29_2, arg_29_3)
end

setmetatable(var_0_0, var_0_0)

var_0_0.Zero = var_0_1(0, 0)
var_0_0.Up = var_0_1(0, -1)
var_0_0.TopRight = var_0_1(1, -1)
var_0_0.BottomRight = var_0_1(1, 0)
var_0_0.Down = var_0_1(0, 1)
var_0_0.BottomLeft = var_0_1(-1, 1)
var_0_0.TopLeft = var_0_1(-1, 0)
var_0_0.zero = var_0_0.Zero
var_0_0.up = var_0_0.Up
var_0_0.topRight = var_0_0.TopRight
var_0_0.bottomRight = var_0_0.BottomRight
var_0_0.down = var_0_0.Down
var_0_0.bottomLeft = var_0_0.BottomLeft
var_0_0.topLeft = var_0_0.TopLeft

return var_0_0
