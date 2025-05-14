module("modules.logic.room.utils.RoomCameraHelper", package.seeall)

local var_0_0 = {}

function var_0_0.getConvexHull(arg_1_0)
	return var_0_0.getSubConvexHull(arg_1_0)
end

function var_0_0.getSubConvexHull(arg_2_0)
	if not arg_2_0 then
		return {}
	end

	arg_2_0 = var_0_0.derepeat(arg_2_0)

	if #arg_2_0 <= 2 then
		return arg_2_0
	end

	local var_2_0 = {}
	local var_2_1 = 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_0) do
		if iter_2_0 == 1 or iter_2_1.y < arg_2_0[var_2_1].y or iter_2_1.y == arg_2_0[var_2_1].y and iter_2_1.x < arg_2_0[var_2_1].x then
			var_2_1 = iter_2_0
		end
	end

	arg_2_0[1], arg_2_0[var_2_1] = arg_2_0[var_2_1], arg_2_0[1]

	local var_2_2 = arg_2_0[1]

	table.sort(arg_2_0, function(arg_3_0, arg_3_1)
		if arg_3_0 == var_2_2 and arg_3_1 ~= var_2_2 then
			return true
		elseif arg_3_0 ~= var_2_2 and arg_3_1 == var_2_2 then
			return false
		end

		local var_3_0 = var_0_0.getCross(arg_3_0, arg_3_1, var_2_2)

		if var_3_0 ~= 0 then
			return var_3_0 > 0
		end

		if arg_3_0.y ~= arg_3_1.y then
			return arg_3_0.y > arg_3_1.y
		end

		return math.abs(arg_3_0.x - var_2_2.x) > math.abs(arg_3_1.x - var_2_2.x)
	end)

	arg_2_0 = var_0_0.collineation(arg_2_0)

	local var_2_3 = #arg_2_0
	local var_2_4 = 1
	local var_2_5 = 1

	while var_2_5 <= var_2_3 + 1 do
		local var_2_6 = arg_2_0[(var_2_5 - 1) % var_2_3 + 1]

		while var_2_4 > 2 do
			if var_0_0.getCross(var_2_0[var_2_4 - 1], var_2_6, var_2_0[var_2_4 - 2]) > 0 then
				break
			end

			var_2_4 = var_2_4 - 1
		end

		if var_2_5 <= var_2_3 then
			var_2_0[var_2_4] = var_2_6
		else
			var_2_0[var_2_4] = Vector2(var_2_6.x, var_2_6.y)
		end

		var_2_4 = var_2_4 + 1
		var_2_5 = var_2_5 + 1
	end

	for iter_2_2 = #var_2_0, 1, -1 do
		if var_2_4 <= iter_2_2 then
			table.remove(var_2_0, iter_2_2)
		end
	end

	return var_2_0
end

function var_0_0.getCross(arg_4_0, arg_4_1, arg_4_2)
	return (arg_4_0.x - arg_4_2.x) * (arg_4_1.y - arg_4_2.y) - (arg_4_0.y - arg_4_2.y) * (arg_4_1.x - arg_4_2.x)
end

function var_0_0.collineation(arg_5_0)
	local var_5_0 = {}
	local var_5_1 = arg_5_0[1]
	local var_5_2 = {}
	local var_5_3 = 2

	for iter_5_0 = 3, #arg_5_0 do
		local var_5_4 = arg_5_0[var_5_3]
		local var_5_5 = arg_5_0[iter_5_0]

		if math.abs(var_0_0.getCross(var_5_4, var_5_5, var_5_1)) < 1e-05 then
			if var_5_4.y > var_5_5.y or var_5_4.y == var_5_5.y and math.abs(var_5_4.x - var_5_1.x) > math.abs(var_5_5.x - var_5_1.x) then
				var_5_2[iter_5_0] = true
			else
				var_5_2[var_5_3] = true
				var_5_3 = iter_5_0
			end
		else
			var_5_3 = iter_5_0
		end
	end

	for iter_5_1, iter_5_2 in ipairs(arg_5_0) do
		if not var_5_2[iter_5_1] then
			table.insert(var_5_0, iter_5_2)
		end
	end

	return var_5_0
end

function var_0_0.derepeat(arg_6_0)
	local var_6_0 = {}
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_0) do
		if not (var_6_1[iter_6_1.x] and var_6_1[iter_6_1.x][iter_6_1.y]) then
			table.insert(var_6_0, iter_6_1)

			var_6_1[iter_6_1.x] = var_6_1[iter_6_1.x] or {}
			var_6_1[iter_6_1.x][iter_6_1.y] = true
		end
	end

	return var_6_0
end

function var_0_0.isPointInConvexHull(arg_7_0, arg_7_1)
	if not arg_7_0 or not arg_7_1 or #arg_7_1 <= 2 then
		return true
	end

	local var_7_0 = true
	local var_7_1 = 0
	local var_7_2
	local var_7_3
	local var_7_4 = 0

	for iter_7_0 = 1, #arg_7_1 do
		local var_7_5 = arg_7_1[iter_7_0]
		local var_7_6 = arg_7_1[iter_7_0 + 1]

		if var_7_5 and var_7_6 and var_0_0.getCross(var_7_6, arg_7_0, var_7_5) < 0 then
			var_7_0 = false

			local var_7_7 = var_0_0.getDistance(arg_7_0, var_7_5, var_7_6)

			if var_7_1 < var_7_7 or var_7_1 == 0 then
				var_7_1 = var_7_7
				var_7_2 = var_7_5
				var_7_3 = var_7_6
			end

			var_7_4 = var_7_4 + 1
		end
	end

	return var_7_0, var_7_1, var_7_2, var_7_3, var_7_4
end

function var_0_0.getDistance(arg_8_0, arg_8_1, arg_8_2)
	if arg_8_1 == arg_8_2 then
		return Vector2.Distance(arg_8_1, arg_8_0)
	end

	if arg_8_1.y == arg_8_2.y then
		local var_8_0 = arg_8_1.y

		return math.abs(arg_8_0.y - var_8_0)
	end

	if arg_8_1.x == arg_8_2.x then
		local var_8_1 = arg_8_1.x

		return math.abs(arg_8_0.x - var_8_1)
	end

	local var_8_2 = (arg_8_1.y - arg_8_2.y) / (arg_8_1.x - arg_8_2.x)
	local var_8_3 = (arg_8_1.x * arg_8_2.y - arg_8_2.x * arg_8_1.y) / (arg_8_1.x - arg_8_2.x)

	return math.abs((var_8_2 * arg_8_0.x - arg_8_0.y + var_8_3) / math.sqrt(var_8_2 * var_8_2 + 1))
end

function var_0_0.getDirection(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = Vector2.Normalize(arg_9_2 - arg_9_1)

	return Vector2(-var_9_0.y, var_9_0.x)
end

function var_0_0.getOffsetPosition(arg_10_0, arg_10_1, arg_10_2)
	if RoomController.instance:isDebugMode() then
		return arg_10_1
	end

	if not arg_10_2 or #arg_10_2 <= 2 then
		return arg_10_1
	end

	local var_10_0, var_10_1, var_10_2, var_10_3, var_10_4 = var_0_0.isPointInConvexHull(arg_10_1, arg_10_2)

	if var_10_0 then
		return arg_10_1
	elseif var_10_4 >= 2 then
		local var_10_5 = arg_10_1 + var_0_0.getDirection(arg_10_1, var_10_2, var_10_3) * (var_10_1 + 0.0001)

		if var_0_0.isPointInConvexHull(var_10_5, arg_10_2) then
			return var_10_5
		else
			return arg_10_0
		end
	else
		return arg_10_1 + var_0_0.getDirection(arg_10_1, var_10_2, var_10_3) * var_10_1
	end
end

function var_0_0.expandConvexHull(arg_11_0, arg_11_1)
	local var_11_0 = {}
	local var_11_1 = #arg_11_0

	if var_11_1 <= 0 then
		return arg_11_0
	end

	for iter_11_0, iter_11_1 in ipairs(arg_11_0) do
		if iter_11_0 < var_11_1 then
			local var_11_2 = arg_11_0[iter_11_0 - 1] or arg_11_0[var_11_1 - 1]
			local var_11_3 = arg_11_0[iter_11_0 + 1]

			if var_11_2 and var_11_3 then
				local var_11_4 = var_0_0.expandPoint(iter_11_1, var_11_2, var_11_3, arg_11_1)

				table.insert(var_11_0, var_11_4)
			end
		end
	end

	local var_11_5 = var_11_0[1]

	table.insert(var_11_0, Vector2(var_11_5.x, var_11_5.y))

	return (var_0_0.getConvexHull(var_11_0))
end

function var_0_0.expandPoint(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = Vector2.Normalize(arg_12_1 - arg_12_0)
	local var_12_1 = Vector2.Normalize(arg_12_2 - arg_12_0)

	if Mathf.Abs(Vector2.Dot(var_12_0, var_12_1)) <= 0.0001 then
		local var_12_2 = arg_12_0
		local var_12_3 = Vector2(var_12_0.y, var_12_0.x)
		local var_12_4 = -var_12_3

		if Vector2.Dot(var_12_2, var_12_3) > 0 then
			return arg_12_0 + var_12_3 * arg_12_3
		elseif Vector2.Dot(var_12_2, var_12_4) > 0 then
			return arg_12_0 + var_12_4 * arg_12_3
		end

		return arg_12_0
	end

	local var_12_5 = -Vector2.Normalize(var_12_0 + var_12_1)
	local var_12_6 = Vector2.Dot(var_12_0, var_12_1)

	if var_12_6 < -1 then
		var_12_6 = -1
	elseif var_12_6 > 1 then
		var_12_6 = 1
	end

	local var_12_7 = Mathf.Acos(var_12_6)
	local var_12_8 = Mathf.Sin(var_12_7 / 2)

	if var_12_8 == 0 then
		return arg_12_0
	end

	return arg_12_0 + var_12_5 * (arg_12_3 / var_12_8)
end

function var_0_0.getConvexHexPointDict(arg_13_0)
	local var_13_0 = {}

	if not arg_13_0 or #arg_13_0 <= 2 then
		return var_13_0
	end

	local var_13_1 = {}
	local var_13_2 = {
		HexPoint(0, 0)
	}

	var_13_1[0] = var_13_1[0] or {}
	var_13_1[0][0] = true

	while #var_13_2 > 0 do
		local var_13_3 = {}

		for iter_13_0, iter_13_1 in ipairs(var_13_2) do
			local var_13_4 = HexMath.hexToPosition(iter_13_1, RoomBlockEnum.BlockSize)

			if var_0_0.isPointInConvexHull(var_13_4, arg_13_0) then
				var_13_0[iter_13_1.x] = var_13_0[iter_13_1.x] or {}
				var_13_0[iter_13_1.x][iter_13_1.y] = true

				local var_13_5 = iter_13_1:getNeighbors()

				for iter_13_2, iter_13_3 in ipairs(var_13_5) do
					if not var_13_1[iter_13_3.x] or not var_13_1[iter_13_3.x][iter_13_3.y] then
						table.insert(var_13_3, iter_13_3)

						var_13_1[iter_13_3.x] = var_13_1[iter_13_3.x] or {}
						var_13_1[iter_13_3.x][iter_13_3.y] = true
					end
				end
			end
		end

		var_13_2 = var_13_3
	end

	return var_13_0
end

return var_0_0
