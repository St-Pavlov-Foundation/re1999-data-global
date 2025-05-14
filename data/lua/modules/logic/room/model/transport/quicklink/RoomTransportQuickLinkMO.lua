module("modules.logic.room.model.transport.quicklink.RoomTransportQuickLinkMO", package.seeall)

local var_0_0 = pureTable("RoomTransportQuickLinkMO")

function var_0_0.init(arg_1_0)
	arg_1_0._nodeMap = {}
	arg_1_0._nodeList = {}
	arg_1_0._nodePoolList = {}
	arg_1_0._maxSearchIndex = 200

	local var_1_0 = RoomMapBlockModel.instance:getFullBlockMOList()

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		if RoomTransportHelper.canPathByBlockMO(iter_1_1, true) then
			local var_1_1 = arg_1_0:_popNode()
			local var_1_2 = iter_1_1.hexPoint

			var_1_1:init(var_1_2)
			RoomHelper.add2KeyValue(arg_1_0._nodeMap, var_1_2.x, var_1_2.y, var_1_1)
			table.insert(arg_1_0._nodeList, var_1_1)
		end
	end

	arg_1_0._maxSearchIndex = #arg_1_0._nodeList
end

function var_0_0.findPath(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0:_resetNodeParam(arg_2_3)

	local var_2_0 = RoomMapTransportPathModel.instance:getTransportPathMOList()

	for iter_2_0, iter_2_1 in ipairs(var_2_0) do
		if iter_2_1:isLinkFinish() then
			local var_2_1 = iter_2_1:getHexPointList()

			for iter_2_2, iter_2_3 in ipairs(var_2_1) do
				local var_2_2 = RoomHelper.get2KeyValue(arg_2_0._nodeMap, iter_2_3.x, iter_2_3.y)

				if var_2_2 then
					var_2_2.isBlock = true
				end
			end
		end
	end

	local var_2_3 = {
		arg_2_1,
		arg_2_2
	}

	for iter_2_4, iter_2_5 in ipairs(var_2_3) do
		local var_2_4 = RoomMapTransportPathModel.instance:getSiteHexPointByType(iter_2_5)

		if var_2_4 then
			local var_2_5 = RoomHelper.get2KeyValue(arg_2_0._nodeMap, var_2_4.x, var_2_4.y)

			if var_2_5 then
				var_2_5.isBlock = false
			end
		end
	end

	arg_2_0._fromNodeList = {}
	arg_2_0._toNodeList = {}

	arg_2_0:_addNodeList(arg_2_0._fromNodeList, arg_2_1)
	arg_2_0:_addNodeList(arg_2_0._toNodeList, arg_2_2)
	arg_2_0:_searchNode(arg_2_0._toNodeList, 0)
	table.sort(arg_2_0._fromNodeList, var_0_0._sortFunction)
	arg_2_0:_clearSelectPathFlag()

	return (arg_2_0:_findNodePathList(arg_2_0._fromNodeList[1]))
end

function var_0_0._sortFunction(arg_3_0, arg_3_1)
	local var_3_0 = var_0_0._getLinkIdx(arg_3_0)
	local var_3_1 = var_0_0._getLinkIdx(arg_3_1)

	if var_3_0 ~= var_3_1 then
		return var_3_0 < var_3_1
	end

	if arg_3_0.searchIndex ~= arg_3_1.searchIndex then
		return arg_3_0.searchIndex < arg_3_1.searchIndex
	end
end

function var_0_0._getLinkIdx(arg_4_0)
	if arg_4_0.isBlock or arg_4_0.searchIndex == -1 then
		return 10000
	end

	if arg_4_0.linkNum > 1 then
		if arg_4_0.searchIndex == 0 then
			return 2
		end

		return 1
	end

	if arg_4_0.searchIndex == 0 then
		return 100
	end

	return 10
end

function var_0_0._addNodeList(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = RoomMapTransportPathModel.instance:getSiteHexPointByType(arg_5_2)

	if var_5_0 then
		local var_5_1 = RoomHelper.get2KeyValue(arg_5_0._nodeMap, var_5_0.x, var_5_0.y)

		if var_5_1 then
			table.insert(arg_5_1, var_5_1)

			return
		end
	end

	local var_5_2 = RoomMapBuildingAreaModel.instance:getAreaMOByBType(arg_5_2)

	if var_5_2 then
		local var_5_3 = var_5_2:getRangesHexPointList()

		for iter_5_0, iter_5_1 in ipairs(var_5_3) do
			local var_5_4 = RoomHelper.get2KeyValue(arg_5_0._nodeMap, iter_5_1.x, iter_5_1.y)

			if var_5_4 then
				table.insert(arg_5_1, var_5_4)
			end
		end
	end
end

function var_0_0._updateNodeListLinkNum(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		iter_6_1.linkNum = 0

		for iter_6_2 = 1, 6 do
			local var_6_0 = HexPoint.directions[iter_6_2]
			local var_6_1 = RoomHelper.get2KeyValue(arg_6_0._nodeMap, var_6_0.x + iter_6_1.hexPoint.x, var_6_0.y + iter_6_1.hexPoint.y)

			if var_6_1 and not var_6_1.isBlock and var_6_1.searchIndex ~= -1 then
				iter_6_1.linkNum = iter_6_1.linkNum + 1
			end
		end
	end
end

function var_0_0._resetNodeParam(arg_7_0, arg_7_1)
	local var_7_0 = RoomMapBuildingModel.instance

	for iter_7_0 = 1, #arg_7_0._nodeList do
		local var_7_1 = arg_7_0._nodeList[iter_7_0]

		var_7_1:resetParam()

		var_7_1.isBuilding = var_7_0:isHasBuilding(var_7_1.hexPoint.x, var_7_1.hexPoint.y)

		if arg_7_1 then
			var_7_1.isBlock = false
		else
			var_7_1.isBlock = var_7_1.isBuilding
		end
	end
end

function var_0_0._findNodePathList(arg_8_0, arg_8_1, arg_8_2)
	if not arg_8_1 or arg_8_1.isBlock or arg_8_1.searchIndex == -1 then
		return nil
	end

	if arg_8_1.searchIndex == 0 and arg_8_2 and #arg_8_2 > 1 then
		return arg_8_2
	end

	local var_8_0
	local var_8_1 = arg_8_1.searchIndex - 1

	if var_8_1 < 0 then
		var_8_1 = 0
	end

	for iter_8_0 = 1, 6 do
		local var_8_2 = HexPoint.directions[iter_8_0]
		local var_8_3 = RoomHelper.get2KeyValue(arg_8_0._nodeMap, var_8_2.x + arg_8_1.hexPoint.x, var_8_2.y + arg_8_1.hexPoint.y)

		if var_8_3 and var_8_3.searchIndex == var_8_1 and var_8_3.isSelectPath ~= true then
			var_8_3.isSelectPath = true

			if not arg_8_2 then
				arg_8_1.isSelectPath = true
				arg_8_2 = {
					arg_8_1
				}
			end

			var_8_0 = var_8_3

			table.insert(arg_8_2, var_8_3)

			break
		end
	end

	return arg_8_0:_findNodePathList(var_8_0, arg_8_2)
end

function var_0_0._clearSelectPathFlag(arg_9_0)
	for iter_9_0, iter_9_1 in ipairs(arg_9_0._nodeList) do
		iter_9_1.isSelectPath = false
	end
end

function var_0_0._searchNode(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_1 or #arg_10_1 < 1 or arg_10_2 > arg_10_0._maxSearchIndex then
		return
	end

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		if not iter_10_1.isBlock and (iter_10_1.searchIndex == -1 or arg_10_2 < iter_10_1.searchIndex) then
			iter_10_1.searchIndex = arg_10_2
		end
	end

	local var_10_0
	local var_10_1 = arg_10_2 + 1

	for iter_10_2, iter_10_3 in ipairs(arg_10_1) do
		if not iter_10_3.isBlock and iter_10_3.searchIndex == arg_10_2 then
			for iter_10_4 = 1, 6 do
				local var_10_2 = HexPoint.directions[iter_10_4]
				local var_10_3 = RoomHelper.get2KeyValue(arg_10_0._nodeMap, var_10_2.x + iter_10_3.hexPoint.x, var_10_2.y + iter_10_3.hexPoint.y)

				if var_10_3 and not var_10_3.isBlock and (var_10_3.searchIndex == -1 or var_10_1 < var_10_3.searchIndex) then
					var_10_3.searchIndex = var_10_1
					var_10_0 = var_10_0 or {}

					table.insert(var_10_0, var_10_3)
				end
			end
		end
	end

	arg_10_0:_searchNode(var_10_0, var_10_1)
end

function var_0_0._popNode(arg_11_0)
	local var_11_0
	local var_11_1 = #arg_11_0._nodePoolList

	if var_11_1 > 0 then
		var_11_0 = arg_11_0._nodePoolList[var_11_1]

		table.remove(arg_11_0._nodePoolList, var_11_1)
	else
		var_11_0 = RoomTransportNodeMO.New()
	end

	return var_11_0
end

function var_0_0._pushNode(arg_12_0, arg_12_1)
	if arg_12_1 then
		table.insert(arg_12_0._nodePoolList, arg_12_1)
	end
end

function var_0_0.getNodeList(arg_13_0)
	return arg_13_0._nodeList
end

return var_0_0
