module("modules.logic.room.utils.RoomTransportPathLinkHelper", package.seeall)

local var_0_0 = {
	_neighborMODict = {},
	_neighborLinkResIdDict = {}
}

function var_0_0.getPtahLineType(arg_1_0, arg_1_1, arg_1_2)
	if not arg_1_0 then
		return nil
	end

	if arg_1_1 == nil and arg_1_2 == nil then
		return RoomTransportPathEnum.PathLineType.Line00, 0
	end

	if not arg_1_1 or HexPoint.Distance(arg_1_0, arg_1_1) ~= 1 then
		return var_0_0._getLine10(arg_1_0, arg_1_2)
	end

	if not arg_1_2 or HexPoint.Distance(arg_1_0, arg_1_2) ~= 1 then
		return var_0_0._getLine10(arg_1_0, arg_1_1)
	end

	local var_1_0 = var_0_0.findLinkDirection(arg_1_0, arg_1_1)
	local var_1_1 = var_0_0.findLinkDirection(arg_1_0, arg_1_2)
	local var_1_2 = math.abs(var_1_0 - var_1_1)

	if var_1_2 == 1 then
		return var_0_0._getLineAbs1(var_1_0, var_1_1)
	elseif var_1_2 == 2 then
		return var_0_0._getLineAbs2(var_1_0, var_1_1)
	elseif var_1_2 == 3 then
		return var_0_0._getLineAbs3(var_1_0, var_1_1)
	elseif var_1_2 == 4 then
		return var_0_0._getLineAbs4(var_1_0, var_1_1)
	elseif var_1_2 == 5 then
		return var_0_0._getLineAbs5(var_1_0, var_1_1)
	end
end

function var_0_0._getLine10(arg_2_0, arg_2_1)
	if not arg_2_1 or HexPoint.Distance(arg_2_0, arg_2_1) ~= 1 then
		return nil
	end

	local var_2_0 = var_0_0.findLinkDirection(arg_2_0, arg_2_1)

	if var_2_0 then
		local var_2_1 = var_2_0 - 1

		return RoomTransportPathEnum.PathLineType.Line10, var_2_1
	end
end

function var_0_0._getLineAbs1(arg_3_0, arg_3_1)
	local var_3_0 = math.max(arg_3_0, arg_3_1) - 2

	return RoomTransportPathEnum.PathLineType.Line12, var_3_0
end

function var_0_0._getLineAbs5(arg_4_0, arg_4_1)
	return RoomTransportPathEnum.PathLineType.Line12, 5
end

function var_0_0._getLineAbs2(arg_5_0, arg_5_1)
	local var_5_0 = math.max(arg_5_0, arg_5_1) - 3

	return RoomTransportPathEnum.PathLineType.Line13, var_5_0
end

function var_0_0._getLineAbs4(arg_6_0, arg_6_1)
	local var_6_0 = math.max(arg_6_0, arg_6_1) - 1

	return RoomTransportPathEnum.PathLineType.Line13, var_6_0
end

function var_0_0._getLineAbs3(arg_7_0, arg_7_1)
	local var_7_0 = math.max(arg_7_0, arg_7_1) - 4

	return RoomTransportPathEnum.PathLineType.Line14, var_7_0
end

function var_0_0.findLinkDirection(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.x - arg_8_0.x
	local var_8_1 = arg_8_1.y - arg_8_0.y

	if var_8_0 == 0 and var_8_1 == 0 then
		return 0
	end

	for iter_8_0 = 1, 6 do
		local var_8_2 = HexPoint.directions[iter_8_0]

		if var_8_0 == var_8_2.x and var_8_1 == var_8_2.y then
			return iter_8_0
		end
	end

	return nil
end

return var_0_0
