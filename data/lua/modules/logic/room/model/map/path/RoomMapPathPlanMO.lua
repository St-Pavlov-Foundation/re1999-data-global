module("modules.logic.room.model.map.path.RoomMapPathPlanMO", package.seeall)

local var_0_0 = pureTable("RoomMapPathPlanMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.id = arg_1_1
	arg_1_0.resourceId = arg_1_2
	arg_1_0.resId = arg_1_2
	arg_1_0._mapNodeDic, arg_1_0._nodeList = arg_1_0:_getMapPoint(arg_1_3, arg_1_2)
end

function var_0_0.initHexPintList(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0.id = arg_2_1
	arg_2_0.resourceId = arg_2_2
	arg_2_0.resId = arg_2_2
	arg_2_0._mapNodeDic, arg_2_0._nodeList = arg_2_0:_getMapHexPointList(arg_2_3, arg_2_2)
end

function var_0_0._getMapHexPointList(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = {}
	local var_3_1 = {}

	for iter_3_0 = 1, #arg_3_1 do
		local var_3_2 = arg_3_1[iter_3_0]
		local var_3_3 = RoomHelper.get2KeyValue(var_3_0, var_3_2.x, var_3_2.y)

		if var_3_3 == nil then
			var_3_3 = RoomMapPathNodeMO.New()

			RoomHelper.add2KeyValue(var_3_0, var_3_2.x, var_3_2.y, var_3_3)
			var_3_3:init(iter_3_0, var_3_2, arg_3_2)
			table.insert(var_3_1, var_3_3)
		end

		arg_3_0:_addLinkHexPoint(var_3_3, arg_3_1[iter_3_0 - 1])
		arg_3_0:_addLinkHexPoint(var_3_3, arg_3_1[iter_3_0 + 1])
	end

	arg_3_0:_updateNeighborParams(var_3_1, var_3_0)

	return var_3_0, var_3_1
end

function var_0_0._addLinkHexPoint(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_2 then
		local var_4_0 = RoomTransportPathLinkHelper.findLinkDirection(arg_4_1.hexPoint, arg_4_2)

		if var_4_0 then
			arg_4_1:addDirection(var_4_0)
		end
	end
end

function var_0_0._getMapPoint(arg_5_0, arg_5_1, arg_5_2)
	if not arg_5_1 or #arg_5_1 <= 0 then
		return nil
	end

	local var_5_0 = {}
	local var_5_1 = {}
	local var_5_2 = 0

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		local var_5_3 = RoomHelper.get2KeyValue(var_5_0, iter_5_1.x, iter_5_1.y)

		if var_5_3 == nil then
			var_5_3 = RoomMapPathNodeMO.New()

			RoomHelper.add2KeyValue(var_5_0, iter_5_1.x, iter_5_1.y, var_5_3)

			var_5_2 = var_5_2 + 1

			var_5_3:init(var_5_2, HexPoint(iter_5_1.x, iter_5_1.y), arg_5_2)
			table.insert(var_5_1, var_5_3)
		end

		var_5_3:addDirection(iter_5_1.direction)
	end

	arg_5_0:_updateNeighborParams(var_5_1, var_5_0)

	return var_5_0, var_5_1
end

function var_0_0._updateNeighborParams(arg_6_0, arg_6_1, arg_6_2)
	for iter_6_0 = 1, #arg_6_1 do
		local var_6_0 = arg_6_1[iter_6_0]
		local var_6_1, var_6_2 = arg_6_0:_findNeighborCount(var_6_0, arg_6_2)

		var_6_0.neighborNum = var_6_1
		var_6_0.connectNodeNum = var_6_2
		var_6_0.hasBuilding = arg_6_0:_isHasBuilding(var_6_0)
	end
end

function var_0_0._isHasBuilding(arg_7_0, arg_7_1)
	if RoomMapBuildingModel.instance:getBuildingParam(arg_7_1.hexPoint.x, arg_7_1.hexPoint.y) then
		return true
	end

	return false
end

function var_0_0._findNeighborCount(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = 0
	local var_8_1 = 0
	local var_8_2 = arg_8_1.directionList

	for iter_8_0 = 1, #var_8_2 do
		local var_8_3 = var_8_2[iter_8_0]
		local var_8_4 = arg_8_0:_getNeighbor(arg_8_1, arg_8_2, var_8_3)

		if var_8_4 then
			var_8_0 = var_8_0 + 1

			if var_8_4:isHasDirection(arg_8_1:getConnectDirection(var_8_3)) then
				arg_8_1:setConnctNode(var_8_3, var_8_4)

				var_8_1 = var_8_1 + 1
			end
		end
	end

	return var_8_0, var_8_1
end

function var_0_0._getNeighbor(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	local var_9_0 = HexPoint.directions[arg_9_3]

	if var_9_0 then
		local var_9_1 = arg_9_1.hexPoint.x + var_9_0.x
		local var_9_2 = arg_9_1.hexPoint.y + var_9_0.y

		return arg_9_2[var_9_1] and arg_9_2[var_9_1][var_9_2]
	end

	return nil
end

function var_0_0.getNodeList(arg_10_0)
	return arg_10_0._nodeList
end

function var_0_0.getCount(arg_11_0)
	return #arg_11_0._nodeList
end

function var_0_0.getNode(arg_12_0, arg_12_1)
	return arg_12_0:getNodeByXY(arg_12_1.x, arg_12_1.y)
end

function var_0_0.getNodeByXY(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_0._mapNodeDic[arg_13_1] and arg_13_0._mapNodeDic[arg_13_1][arg_13_2]
end

return var_0_0
