module("modules.logic.room.model.map.path.RoomMapVehicleMO", package.seeall)

local var_0_0 = pureTable("RoomMapVehicleMO")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0.id = arg_1_1
	arg_1_0.vehicleId = arg_1_3
	arg_1_0.resourceId = arg_1_2.resourceId
	arg_1_0.resId = arg_1_2.resourceId
	arg_1_0.pathPlanMO = arg_1_2
	arg_1_0.config = RoomConfig.instance:getVehicleConfig(arg_1_3)
	arg_1_0._areaNodeList = {}
	arg_1_0._initAreaNodeList = {}

	tabletool.addValues(arg_1_0._initAreaNodeList, arg_1_4)

	arg_1_0.startMO = arg_1_0._initAreaNodeList[1] or arg_1_0:_findMaxNodeNum(arg_1_2:getNodeList())
	arg_1_0.curPathNodeMO = arg_1_0.startMO
	arg_1_0.enterDirection = 4
	arg_1_0.moveOffsetDirs = {
		3,
		4,
		2,
		5,
		1,
		0
	}
	arg_1_0.mapHexPointDic = arg_1_0:_getHexPiontDic(arg_1_2:getNodeList())
	arg_1_0._areaNodeNum = math.max(1, #arg_1_0._initAreaNodeList)
	arg_1_0._recentHistoryNum = 10
	arg_1_0._recentHistory = {}
	arg_1_0.vehicleType = 0
	arg_1_0.ownerType = 0
	arg_1_0.owerId = 0
	arg_1_0._replaceType = RoomVehicleEnum.ReplaceType.None

	if not arg_1_0.config then
		logError(string.format("找不到交通工具配置,id:%s ", arg_1_0.vehicleId))
	end

	if #arg_1_0._initAreaNodeList > 1 then
		for iter_1_0 = #arg_1_0._initAreaNodeList, 1, -1 do
			arg_1_0:moveToNode(arg_1_0._initAreaNodeList[iter_1_0], arg_1_0.enterDirection)
		end
	else
		arg_1_0:moveToNode(arg_1_0.startMO, arg_1_0.enterDirection)
	end
end

function var_0_0.setReplaceType(arg_2_0, arg_2_1)
	if arg_2_0.ownerType == RoomVehicleEnum.OwnerType.TransportSite then
		arg_2_0._replaceType = arg_2_1
	else
		arg_2_0._replaceType = RoomVehicleEnum.ReplaceType.None
	end
end

function var_0_0.getReplaceDefideCfg(arg_3_0)
	if arg_3_0.ownerType == RoomVehicleEnum.OwnerType.TransportSite then
		arg_3_0:_initReplaceDefideCfg()

		return arg_3_0._replacConfigMap[arg_3_0._replaceType] or arg_3_0.config
	end

	return arg_3_0.config
end

function var_0_0._initReplaceDefideCfg(arg_4_0)
	if arg_4_0._replacConfigMap and arg_4_0._lasetDefideId == arg_4_0.vehicleId then
		return
	end

	arg_4_0._replacConfigMap = {}

	if not arg_4_0.config or string.nilorempty(arg_4_0.config.replaceConditionStr) then
		return
	end

	local var_4_0 = GameUtil.splitString2(arg_4_0.config.replaceConditionStr, true)

	for iter_4_0, iter_4_1 in ipairs(var_4_0) do
		if iter_4_1 and #iter_4_1 > 1 then
			local var_4_1 = RoomConfig.instance:getVehicleConfig(iter_4_1[2])

			if var_4_1 then
				arg_4_0._replacConfigMap[iter_4_1[1]] = var_4_1
			end
		end
	end
end

function var_0_0._findSideNode(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		if iter_5_1:isSideNode() then
			return iter_5_1
		end
	end

	return arg_5_1[1]
end

function var_0_0._findMaxNodeNum(arg_6_0, arg_6_1)
	local var_6_0
	local var_6_1

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		if not iter_6_1.hasBuilding and (var_6_0 == nil or var_6_0.connectNodeNum < iter_6_1.connectNodeNum) then
			var_6_0 = iter_6_1
		end

		if iter_6_1:isSideNode() and (var_6_1 == nil or var_6_1.connectNodeNum < iter_6_1.connectNodeNum) then
			var_6_1 = iter_6_1
		end
	end

	return var_6_0 or var_6_1 or arg_6_1[1]
end

function var_0_0._getHexPiontDic(arg_7_0, arg_7_1)
	local var_7_0 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_1 = var_7_0[iter_7_1.hexPoint.x]

		if var_7_1 == nil then
			var_7_1 = {}
			var_7_0[iter_7_1.hexPoint.x] = var_7_1
		end

		var_7_1[iter_7_1.hexPoint.y] = 0
	end

	return var_7_0
end

function var_0_0.resetHistory(arg_8_0)
	local var_8_0 = arg_8_0.mapHexPointDic

	for iter_8_0, iter_8_1 in pairs(var_8_0) do
		for iter_8_2, iter_8_3 in pairs(iter_8_1) do
			iter_8_1[iter_8_2] = 0
		end
	end
end

function var_0_0.getHistoryCount(arg_9_0, arg_9_1, arg_9_2)
	return arg_9_0.mapHexPointDic[arg_9_1] and arg_9_0.mapHexPointDic[arg_9_1][arg_9_2] or 0
end

function var_0_0.setHistoryCount(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_0.mapHexPointDic[arg_10_1] then
		arg_10_0.mapHexPointDic[arg_10_1] = {}
	end

	arg_10_0.mapHexPointDic[arg_10_1][arg_10_2] = arg_10_3
end

function var_0_0._isNextStar(arg_11_0)
	local var_11_0 = arg_11_0.curPathNodeMO

	if var_11_0.hexPoint == arg_11_0.startMO.hexPoint and arg_11_0:getHistoryCount(var_11_0.hexPoint.x, var_11_0.hexPoint.y) >= 5 then
		return true
	end

	local var_11_1 = false

	for iter_11_0 = 1, 6 do
		local var_11_2 = var_11_0:getConnctNode(iter_11_0)

		if var_11_2 and arg_11_0:getHistoryCount(var_11_2.hexPoint.x, var_11_2.hexPoint.y) >= 5 then
			var_11_1 = true
		end
	end

	return var_11_1
end

function var_0_0.getCurNode(arg_12_0)
	return arg_12_0.curPathNodeMO
end

function var_0_0.findNextWeightNode(arg_13_0)
	local var_13_0 = arg_13_0.curPathNodeMO
	local var_13_1 = arg_13_0.enterDirection or 4
	local var_13_2
	local var_13_3 = 0
	local var_13_4 = var_13_1
	local var_13_5 = var_13_1
	local var_13_6 = 0

	for iter_13_0 = 1, #arg_13_0.moveOffsetDirs do
		local var_13_7 = (var_13_1 + arg_13_0.moveOffsetDirs[iter_13_0] - 1) % 6 + 1
		local var_13_8 = var_13_0:getConnctNode(var_13_7)

		if var_13_8 then
			var_13_6 = var_13_6 + 1

			local var_13_9 = arg_13_0:_getWeight(var_13_8, iter_13_0)

			if var_13_3 < var_13_9 or var_13_2 == nil then
				var_13_2 = var_13_8
				var_13_3 = var_13_9
				var_13_5 = var_13_7
				var_13_4 = var_13_0:getConnectDirection(var_13_7)
			end
		end
	end

	return var_13_2 or var_13_0, var_13_4, var_13_5
end

function var_0_0.moveToNode(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if arg_14_1 then
		local var_14_0 = arg_14_0:getHistoryCount(arg_14_1.hexPoint.x, arg_14_1.hexPoint.y) + 1

		if arg_14_1:isEndNode() then
			var_14_0 = var_14_0 + 1
		end

		arg_14_0:setHistoryCount(arg_14_1.hexPoint.x, arg_14_1.hexPoint.y, var_14_0)

		if arg_14_3 ~= true then
			arg_14_0.enterDirection = arg_14_2
			arg_14_0.curPathNodeMO = arg_14_1

			arg_14_0:_addAreaNode(arg_14_1)
		end

		arg_14_0:_addRecentHistory(arg_14_1.id)
	end

	return arg_14_0.curPathNodeMO
end

function var_0_0._getWeight(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = (7 - arg_15_2) * 30 - arg_15_0:getHistoryCount(arg_15_1.hexPoint.x, arg_15_1.hexPoint.y) * 200

	if arg_15_1:isSideNode() then
		var_15_0 = var_15_0 + 1000
	end

	local var_15_1 = arg_15_0:_getRecentHistoryIndexOf(arg_15_1.id)

	if var_15_1 then
		var_15_0 = var_15_0 - var_15_1 * 1000
	end

	return var_15_0
end

function var_0_0._addRecentHistory(arg_16_0, arg_16_1)
	table.insert(arg_16_0._recentHistory, arg_16_1)

	if #arg_16_0._recentHistory > arg_16_0._recentHistoryNum then
		table.remove(arg_16_0._recentHistory, 1)
	end
end

function var_0_0._getRecentHistoryIndexOf(arg_17_0, arg_17_1)
	for iter_17_0 = #arg_17_0._recentHistory, 1, -1 do
		if arg_17_0._recentHistory[iter_17_0] == arg_17_1 then
			return iter_17_0
		end
	end
end

function var_0_0.findEndDir(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_1 then
		return arg_18_2
	end

	for iter_18_0 = 1, #arg_18_0.moveOffsetDirs do
		local var_18_0 = (arg_18_2 + arg_18_0.moveOffsetDirs[iter_18_0] - 1) % 6 + 1

		if tabletool.indexOf(arg_18_1.directionList, var_18_0) then
			return var_18_0
		end
	end

	return arg_18_2
end

function var_0_0._addAreaNode(arg_19_0, arg_19_1)
	table.insert(arg_19_0._areaNodeList, 1, arg_19_1)

	while #arg_19_0._areaNodeList > arg_19_0._areaNodeNum do
		table.remove(arg_19_0._areaNodeList, #arg_19_0._areaNodeList)
	end
end

function var_0_0.getAreaNode(arg_20_0)
	return arg_20_0._areaNodeList
end

function var_0_0.getInitAreaNode(arg_21_0)
	return arg_21_0._initAreaNodeList
end

return var_0_0
