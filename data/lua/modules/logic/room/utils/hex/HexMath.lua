module("modules.logic.room.utils.hex.HexMath", package.seeall)

local var_0_0 = {}
local var_0_1 = math.sqrt(3)
local var_0_2 = Vector2(1, 0)

function var_0_0.hexToPosition(arg_1_0, arg_1_1)
	local var_1_0, var_1_1 = var_0_0.hexXYToPosXY(arg_1_0.x, arg_1_0.y, arg_1_1)

	return Vector2(var_1_0, var_1_1)
end

function var_0_0.hexXYToPosXY(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0
	local var_2_1 = arg_2_1

	arg_2_2 = arg_2_2 or 1

	local var_2_2 = arg_2_2 * (3 * var_2_0 / 2)
	local var_2_3 = arg_2_2 * (-var_0_1 * var_2_0 / 2 - var_0_1 * var_2_1)

	return var_2_2, var_2_3
end

function var_0_0.point2HexDistance(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = Vector2.Normalize(arg_3_0 - arg_3_1)
	local var_3_1 = math.acos(Vector2.Dot(var_3_0, var_0_2) / Vector2.Magnitude(var_3_0)) % (math.pi / 3)

	if var_3_1 > math.pi / 6 then
		var_3_1 = math.pi / 3 - var_3_1
	end

	local var_3_2 = var_0_1 / 2 / math.cos(var_3_1) * arg_3_2

	return Vector2.Distance(arg_3_0, arg_3_1) - var_3_2, var_3_0
end

function var_0_0.positionToHex(arg_4_0, arg_4_1)
	local var_4_0, var_4_1 = var_0_0.posXYToHexXY(arg_4_0.x, arg_4_0.y, arg_4_1)

	return HexPoint(var_4_0, var_4_1)
end

function var_0_0.posXYToHexXY(arg_5_0, arg_5_1, arg_5_2)
	arg_5_2 = arg_5_2 or 1

	local var_5_0 = 0.6666666666666666 * arg_5_0 / arg_5_2
	local var_5_1, var_5_2 = (-0.3333333333333333 * arg_5_0 - var_0_1 / 3 * arg_5_1) / arg_5_2, var_5_0

	return var_5_2, var_5_1
end

function var_0_0.positionToRoundHex(arg_6_0, arg_6_1)
	local var_6_0, var_6_1 = var_0_0.posXYToHexXY(arg_6_0.x, arg_6_0.y, arg_6_1)
	local var_6_2, var_6_3, var_6_4, var_6_5 = var_0_0._roundXYZD(var_6_0, var_6_1)

	return HexPoint(var_6_2, var_6_3), var_6_5
end

function var_0_0.posXYToRoundHexYX(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0, var_7_1 = var_0_0.posXYToHexXY(arg_7_0, arg_7_1, arg_7_2)
	local var_7_2, var_7_3, var_7_4, var_7_5 = var_0_0._roundXYZD(var_7_0, var_7_1)

	return var_7_2, var_7_3, var_7_5
end

function var_0_0.round(arg_8_0)
	local var_8_0, var_8_1, var_8_2, var_8_3 = var_0_0._roundXYZD(arg_8_0.x, arg_8_0.y, arg_8_0.z)

	return HexPoint(var_8_0, var_8_1), var_8_3
end

function var_0_0.roundXY(arg_9_0, arg_9_1)
	local var_9_0, var_9_1, var_9_2, var_9_3 = var_0_0._roundXYZD(arg_9_0, arg_9_1)

	return var_9_0, var_9_1, var_9_3
end

function var_0_0._roundXYZD(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_2 == nil then
		arg_10_2 = -arg_10_0 - arg_10_1
	end

	local var_10_0 = Mathf.Round(arg_10_0)
	local var_10_1 = Mathf.Round(arg_10_1)
	local var_10_2 = Mathf.Round(arg_10_2)
	local var_10_3 = math.abs(var_10_0 - arg_10_0)
	local var_10_4 = math.abs(var_10_1 - arg_10_1)
	local var_10_5 = math.abs(var_10_2 - arg_10_2)

	if var_10_4 < var_10_3 and var_10_5 < var_10_3 then
		var_10_0 = -var_10_1 - var_10_2
	elseif var_10_5 < var_10_4 then
		var_10_1 = -var_10_0 - var_10_2
	else
		var_10_2 = -var_10_0 - var_10_1
	end

	local var_10_6 = 0
	local var_10_7 = arg_10_0 - var_10_0
	local var_10_8 = arg_10_1 - var_10_1
	local var_10_9 = arg_10_2 - var_10_2

	if var_10_7 >= 0 and var_10_8 >= 0 then
		var_10_6 = var_10_8 <= var_10_7 and 3 or 4
	elseif var_10_8 >= 0 and var_10_9 >= 0 then
		var_10_6 = var_10_9 <= var_10_8 and 5 or 6
	elseif var_10_9 >= 0 and var_10_7 >= 0 then
		var_10_6 = var_10_7 <= var_10_9 and 1 or 2
	elseif var_10_7 < 0 and var_10_8 < 0 then
		var_10_6 = var_10_7 < var_10_8 and 6 or 1
	elseif var_10_8 < 0 and var_10_9 < 0 then
		var_10_6 = var_10_8 < var_10_9 and 2 or 3
	elseif var_10_9 < 0 and var_10_7 < 0 then
		var_10_6 = var_10_9 < var_10_7 and 4 or 5
	end

	return var_10_0, var_10_1, var_10_2, var_10_6
end

function var_0_0.resourcePointToPosition(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = var_0_0.resourcePointToHexPoint(arg_11_0, arg_11_2)

	return (var_0_0.hexToPosition(var_11_0, arg_11_1))
end

function var_0_0.resourcePointToHexPoint(arg_12_0, arg_12_1)
	local var_12_0 = HexPoint.directions[arg_12_0.direction]

	return (HexPoint(arg_12_0.x + var_12_0.x * arg_12_1, arg_12_0.y + var_12_0.y * arg_12_1))
end

function var_0_0.zeroRadius(arg_13_0, arg_13_1)
	return (math.abs(arg_13_0) + math.abs(arg_13_1) + math.abs(arg_13_0 - arg_13_1)) / 2
end

function var_0_0.countByRadius(arg_14_0)
	local var_14_0 = 1

	if arg_14_0 > 0 then
		var_14_0 = 1 + (arg_14_0 + 1) * arg_14_0 * 3
	end

	return var_14_0
end

function var_0_0.hexXYToSpiralIndex(arg_15_0, arg_15_1)
	local var_15_0 = var_0_0.zeroRadius(arg_15_0, arg_15_1)

	if var_15_0 < 1 then
		return 1
	end

	local var_15_1 = var_0_0.countByRadius(var_15_0 - 1)
	local var_15_2 = HexPoint.directions
	local var_15_3 = var_15_2[5]
	local var_15_4 = var_15_3.x * var_15_0
	local var_15_5 = var_15_3.y * var_15_0

	for iter_15_0 = 1, 6 do
		for iter_15_1 = 1, var_15_0 do
			var_15_1 = var_15_1 + 1

			local var_15_6 = var_15_2[iter_15_0]

			var_15_4 = var_15_4 + var_15_6.x
			var_15_5 = var_15_5 + var_15_6.y

			if arg_15_1 == var_15_5 and arg_15_0 == var_15_4 then
				return var_15_1
			end
		end
	end

	return var_15_1
end

return var_0_0
