module("modules.logic.room.model.map.path.RoomMapResorcePointAreaMO", package.seeall)

local var_0_0 = pureTable("RoomMapResorcePointAreaMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.id = arg_1_1
	arg_1_0.resourceId = arg_1_2
	arg_1_0._resPointMap = {}
	arg_1_0._resPointList = {}
	arg_1_0._directionConnectsDic = arg_1_0._directionConnectsDic or {}
	arg_1_0._areaIdMap = {}
	arg_1_0._areaPointList = {}
	arg_1_0._isNeedUpdateAreaIdMap = false
end

function var_0_0.addResPoint(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_1.x
	local var_2_1 = arg_2_1.y
	local var_2_2 = arg_2_1.direction
	local var_2_3 = arg_2_0:_getResPointValue(arg_2_0._resPointMap, var_2_0, var_2_1, var_2_2)

	if var_2_3 then
		tabletool.removeValue(arg_2_0._resPointList, var_2_3)
	else
		arg_2_0._isNeedUpdateAreaIdMap = true
	end

	arg_2_0:_addResPointValue(arg_2_0._resPointMap, var_2_0, var_2_1, var_2_2, arg_2_1)
	table.insert(arg_2_0._resPointList, arg_2_1)
end

function var_0_0.removeByXYD(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_0:_getResPointValue(arg_3_0._resPointMap, arg_3_1, arg_3_2, arg_3_3)

	if var_3_0 then
		tabletool.removeValue(arg_3_0._resPointList, var_3_0)

		arg_3_0._isNeedUpdateAreaIdMap = true
	end
end

function var_0_0.removeByXY(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0._resPointMap[arg_4_1] and arg_4_0._resPointMap[arg_4_1][arg_4_2] then
		arg_4_0._resPointMap[arg_4_1][arg_4_2] = nil

		local var_4_0 = arg_4_0._resPointList
		local var_4_1
		local var_4_2 = #var_4_0

		for iter_4_0 = var_4_2, 1, -1 do
			local var_4_3 = var_4_0[iter_4_0]

			if var_4_3.x == arg_4_1 and var_4_3.y == arg_4_2 then
				var_4_0[iter_4_0] = var_4_0[var_4_2]

				table.remove(var_4_0, var_4_2)

				var_4_2 = var_4_2 - 1
			end
		end

		arg_4_0._isNeedUpdateAreaIdMap = true
	end
end

function var_0_0.getAreaIdByXYD(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	local var_5_0 = arg_5_0:getAreaIdMap()

	return (arg_5_0:_getResPointValue(var_5_0, arg_5_1, arg_5_2, arg_5_3))
end

function var_0_0.getResorcePiontListByXYD(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_0:getAreaIdByXYD(arg_6_1, arg_6_2, arg_6_3)

	if var_6_0 then
		return arg_6_0._areaPointList[var_6_0]
	end

	return nil
end

function var_0_0._checkUpdateArea(arg_7_0)
	if arg_7_0._isNeedUpdateAreaMap then
		return
	end

	local var_7_0 = {}
	local var_7_1 = {}
	local var_7_2 = arg_7_0._resPointList
	local var_7_3 = arg_7_0._resPointMap

	for iter_7_0 = 1, #var_7_2 do
		local var_7_4 = var_7_2[iter_7_0]

		arg_7_0:_addResPointValue(var_7_0, var_7_4.x, var_7_4.y, var_7_4.direction, -1)
	end

	local var_7_5 = 0

	for iter_7_1 = 1, #var_7_2 do
		local var_7_6 = var_7_2[iter_7_1]

		if arg_7_0:_getResPointValue(var_7_0, var_7_6.x, var_7_6.y, var_7_6.direction) == -1 then
			var_7_5 = var_7_5 + 1

			local var_7_7 = {}

			table.insert(var_7_1, var_7_7)
			arg_7_0:_searchArea(var_7_5, var_7_6, var_7_0, var_7_3, var_7_7)
		end
	end

	arg_7_0._isNeedUpdateAreaMap = false
	arg_7_0._areaIdMap = var_7_0
	arg_7_0._areaPointList = var_7_1
end

function var_0_0.getAreaIdMap(arg_8_0)
	arg_8_0:_checkUpdateArea()

	return arg_8_0._areaIdMap
end

function var_0_0.findeArea(arg_9_0)
	arg_9_0:_checkUpdateArea()

	return arg_9_0._areaPointList
end

function var_0_0._searchArea(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	if arg_10_0:_getResPointValue(arg_10_3, arg_10_2.x, arg_10_2.y, arg_10_2.direction) == -1 then
		arg_10_0:_addResPointValue(arg_10_3, arg_10_2.x, arg_10_2.y, arg_10_2.direction, arg_10_1)

		if arg_10_5 then
			table.insert(arg_10_5, arg_10_2)
		end

		local var_10_0 = arg_10_0:getConnectsAll(arg_10_2.direction)

		for iter_10_0, iter_10_1 in ipairs(var_10_0) do
			local var_10_1 = arg_10_0:_getResPointValue(arg_10_4, arg_10_2.x + iter_10_1.x, arg_10_2.y + iter_10_1.y, iter_10_1.direction)

			if var_10_1 then
				arg_10_0:_searchArea(arg_10_1, var_10_1, arg_10_3, arg_10_4, arg_10_5)
			end
		end
	end
end

function var_0_0.getConnectsAll(arg_11_0, arg_11_1)
	if not arg_11_0._directionConnectsDic[arg_11_1] then
		local var_11_0 = ResourcePoint(HexPoint(0, 0), arg_11_1)

		arg_11_0._directionConnectsDic[arg_11_1] = var_11_0:GetConnectsAll()
	end

	return arg_11_0._directionConnectsDic[arg_11_1]
end

function var_0_0._addResPointValue(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4, arg_12_5)
	arg_12_1[arg_12_2] = arg_12_1[arg_12_2] or {}
	arg_12_1[arg_12_2][arg_12_3] = arg_12_1[arg_12_2][arg_12_3] or {}
	arg_12_1[arg_12_2][arg_12_3][arg_12_4] = arg_12_5
end

function var_0_0._getResPointValue(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	return arg_13_1[arg_13_2] and arg_13_1[arg_13_2][arg_13_3] and arg_13_1[arg_13_2][arg_13_3][arg_13_4]
end

return var_0_0
