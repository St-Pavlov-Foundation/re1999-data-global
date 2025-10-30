module("modules.common.utils.MathUtil", package.seeall)

local var_0_0 = class("MathUtil")
local var_0_1 = math.atan2
local var_0_2 = math.deg

function var_0_0.vec2_lengthSqr(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	if not arg_1_0 or not arg_1_1 or not arg_1_2 or not arg_1_3 then
		logError("Error | vec2_length  Error |: Args: ", tostring(arg_1_0), tostring(arg_1_1), tostring(arg_1_2), tostring(arg_1_3))

		return 99999
	end

	local var_1_0 = arg_1_0 - arg_1_2
	local var_1_1 = arg_1_1 - arg_1_3

	return var_1_0 * var_1_0 + var_1_1 * var_1_1
end

function var_0_0.vec2_length(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	local var_2_0 = var_0_0.vec2_lengthSqr(arg_2_0, arg_2_1, arg_2_2, arg_2_3)

	return math.sqrt(var_2_0)
end

function var_0_0.vec2_normalize(arg_3_0, arg_3_1)
	local var_3_0 = math.sqrt(arg_3_0 * arg_3_0 + arg_3_1 * arg_3_1)

	if var_3_0 < 1e-06 then
		var_3_0 = 1
	end

	return arg_3_0 / var_3_0, arg_3_1 / var_3_0
end

function var_0_0.calculateV2Angle(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	if not arg_4_0 or not arg_4_1 or not arg_4_2 or not arg_4_3 then
		logError("Error | calculateV2Angle  Error |: Args: ", tostring(arg_4_0), tostring(arg_4_1), tostring(arg_4_2), tostring(arg_4_3))

		return 0
	end

	local var_4_0 = arg_4_0 - arg_4_2
	local var_4_1 = arg_4_1 - arg_4_3
	local var_4_2 = var_0_1(var_4_1, var_4_0)

	return (var_0_2(var_4_2))
end

function var_0_0.isPointInCircleRange(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	if arg_5_0 == nil or arg_5_1 == nil or arg_5_2 == nil or arg_5_3 == nil or arg_5_4 == nil then
		logError("Error | isPointInCircleRange  Error |: Args: ", tostring(arg_5_0), tostring(arg_5_1), tostring(arg_5_2), tostring(arg_5_3), tostring(arg_5_4))

		return false
	end

	local var_5_0 = arg_5_3 - arg_5_0
	local var_5_1 = arg_5_4 - arg_5_1

	return var_5_0 * var_5_0 + var_5_1 * var_5_1 <= arg_5_2 * arg_5_2
end

function var_0_0.is_point_in_sector(arg_6_0, arg_6_1, arg_6_2, arg_6_3, arg_6_4, arg_6_5, arg_6_6)
	local var_6_0 = arg_6_0 - arg_6_2
	local var_6_1 = arg_6_1 - arg_6_3

	if var_6_0 * var_6_0 + var_6_1 * var_6_1 > arg_6_4 * arg_6_4 then
		return false
	end

	local var_6_2 = math.rad(arg_6_5)
	local var_6_3 = math.rad(arg_6_6)

	if math.abs(var_6_3) >= 2 * math.pi then
		return true
	end

	local var_6_4 = var_6_2 % (2 * math.pi)

	if var_6_4 < 0 then
		var_6_4 = var_6_4 + 2 * math.pi
	end

	local var_6_5 = math.atan2(var_6_1, var_6_0)

	if var_6_5 < 0 then
		var_6_5 = var_6_5 + 2 * math.pi
	end

	if var_6_3 >= 0 then
		local var_6_6 = (var_6_5 - var_6_4) % (2 * math.pi)

		if var_6_6 < 0 then
			var_6_6 = var_6_6 + 2 * math.pi
		end

		return var_6_6 <= var_6_3
	else
		local var_6_7 = (var_6_4 - var_6_5) % (2 * math.pi)

		if var_6_7 < 0 then
			var_6_7 = var_6_7 + 2 * math.pi
		end

		return var_6_7 <= -var_6_3
	end
end

function var_0_0.hasPassedPoint(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4, arg_7_5)
	local var_7_0 = arg_7_2 - arg_7_0
	local var_7_1 = arg_7_3 - arg_7_1

	return arg_7_4 * var_7_0 + arg_7_5 * var_7_1 <= 0
end

function var_0_0.calculateVisiblePoints(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4, arg_8_5)
	local var_8_0 = arg_8_3 - arg_8_0
	local var_8_1 = arg_8_4 - arg_8_1
	local var_8_2 = math.sqrt(var_8_0 * var_8_0 + var_8_1 * var_8_1)

	if var_8_2 < 1e-10 then
		return arg_8_0, arg_8_1, arg_8_3, arg_8_4
	end

	local var_8_3 = var_8_0 / var_8_2
	local var_8_4 = var_8_1 / var_8_2
	local var_8_5 = arg_8_0 + var_8_3 * arg_8_2
	local var_8_6 = arg_8_1 + var_8_4 * arg_8_2
	local var_8_7 = arg_8_3 - var_8_3 * arg_8_5
	local var_8_8 = arg_8_4 - var_8_4 * arg_8_5

	return var_8_5, var_8_6, var_8_7, var_8_8
end

return var_0_0
