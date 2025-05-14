module("modules.logic.room.utils.RoomTransportHelper", package.seeall)

local var_0_0 = {}

var_0_0._pathBuidingTypeList = nil
var_0_0._pathBuidingTypesDict = nil
var_0_0._stieBuidingTypeList = nil

function var_0_0._initPathParam()
	if not var_0_0._pathBuidingTypeList then
		local var_1_0 = {
			{
				RoomBuildingEnum.BuildingType.Collect,
				RoomBuildingEnum.BuildingType.Process
			},
			{
				RoomBuildingEnum.BuildingType.Process,
				RoomBuildingEnum.BuildingType.Manufacture
			},
			{
				RoomBuildingEnum.BuildingType.Manufacture,
				RoomBuildingEnum.BuildingType.Collect
			}
		}

		var_0_0._pathBuidingTypeList = var_1_0
		var_0_0._pathBuidingTypesDict = {}
		var_0_0._stieBuidingTypeList = {}

		for iter_1_0, iter_1_1 in ipairs(var_1_0) do
			local var_1_1 = {}
			local var_1_2 = iter_1_1[1]

			tabletool.addValues(var_1_1, iter_1_1)

			var_0_0._pathBuidingTypesDict[var_1_2] = var_1_1

			table.insert(var_0_0._stieBuidingTypeList, var_1_2)
		end
	end
end

function var_0_0.getPathBuildingTypesList()
	var_0_0._initPathParam()

	return var_0_0._pathBuidingTypeList
end

function var_0_0.getSiteBuildingTypeList()
	var_0_0._initPathParam()

	return var_0_0._stieBuidingTypeList
end

function var_0_0.getPathBuildingTypes(arg_4_0)
	var_0_0._initPathParam()

	return var_0_0._pathBuidingTypesDict[arg_4_0]
end

function var_0_0.getVehicleCfgByBuildingId(arg_5_0, arg_5_1)
	local var_5_0 = RoomConfig.instance:getBuildingConfig(arg_5_0)

	if not var_5_0 then
		return
	end

	local var_5_1 = RoomConfig.instance:getBuildingSkinConfig(arg_5_1)
	local var_5_2 = var_5_1 and var_5_1.vehicleId or var_5_0.vehicleId
	local var_5_3 = RoomConfig.instance:getVehicleConfig(var_5_2)

	if not var_5_3 and var_5_0.buildingType == RoomBuildingEnum.BuildingType.Transport then
		logError(string.format("运输建筑【%s %s】找不到交通工具配置[%s]", var_5_0.name, var_5_0.id, var_5_2))
	end

	return var_5_3
end

function var_0_0.getSiteFromToByType(arg_6_0)
	local var_6_0 = var_0_0.getPathBuildingTypes(arg_6_0)

	if var_6_0 then
		return var_6_0[1], var_6_0[2]
	end
end

function var_0_0.getSiltParamBy2PathMO(arg_7_0, arg_7_1)
	local var_7_0
	local var_7_1
	local var_7_2 = arg_7_0:getFirstHexPoint()
	local var_7_3 = arg_7_0:getLastHexPoint()
	local var_7_4 = arg_7_1:getFirstHexPoint()
	local var_7_5 = arg_7_1:getLastHexPoint()

	if var_7_2 == var_7_4 or var_7_2 == var_7_5 then
		var_7_0 = var_7_2
	elseif var_7_3 == var_7_4 or var_7_3 == var_7_5 then
		var_7_0 = var_7_3
	end

	if arg_7_0.fromType == arg_7_1.fromType or arg_7_0.fromType == arg_7_1.toType then
		var_7_1 = arg_7_0.fromType
	elseif arg_7_0.toType == arg_7_1.fromType or arg_7_0.toType == arg_7_1.toType then
		var_7_1 = arg_7_0.toType
	end

	local var_7_6 = RoomMapBuildingAreaModel.instance:getAreaMOByBType(var_7_1)

	if var_7_0 ~= nil and var_7_6 and var_7_6:isInRangesByHexPoint(var_7_0) then
		return var_7_1, var_7_0
	end

	return nil, nil
end

function var_0_0.fromTo2SiteType(arg_8_0, arg_8_1)
	local var_8_0 = var_0_0.getSiteBuildingTypeList()

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		local var_8_1, var_8_2 = var_0_0.getSiteFromToByType(iter_8_1)

		if var_8_1 == arg_8_0 and var_8_2 == arg_8_1 or var_8_2 == arg_8_0 and var_8_1 == arg_8_1 then
			return iter_8_1
		end
	end
end

function var_0_0.canPathByHexPoint(arg_9_0, arg_9_1)
	local var_9_0 = RoomMapBlockModel.instance:getBlockMO(arg_9_0.hexX, arg_9_0.hexY)

	return var_0_0.canPathByBlockMO(var_9_0, arg_9_1)
end

function var_0_0.canPathByhexXY(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = RoomMapBlockModel.instance:getBlockMO(arg_10_0, arg_10_1)

	return var_0_0.canPathByBlockMO(var_10_0, arg_10_2)
end

function var_0_0.canSiteByHexPoint(arg_11_0, arg_11_1)
	if not arg_11_0 then
		return false
	end

	local var_11_0 = RoomMapBuildingAreaModel.instance:getAreaMOByBType(arg_11_1)

	if var_11_0 and var_11_0:isInRangesByHexPoint(arg_11_0) then
		local var_11_1 = RoomMapTransportPathModel.instance
		local var_11_2 = var_0_0.getSiteBuildingTypeList()
		local var_11_3 = false

		for iter_11_0, iter_11_1 in ipairs(var_11_2) do
			local var_11_4 = var_11_1:getSiteHexPointByType(iter_11_1)

			if arg_11_1 == iter_11_1 then
				var_11_3 = true
			elseif var_11_4 and HexPoint.Distance(var_11_4, arg_11_0) < 2 then
				return false
			end
		end

		return var_11_3
	end

	return false
end

function var_0_0.canPathByBlockMO(arg_12_0, arg_12_1)
	if not arg_12_0 or not arg_12_0:isInMapBlock() then
		return false
	end

	if arg_12_0.packageId == RoomBlockPackageEnum.ID.RoleBirthday then
		return false
	end

	local var_12_0 = arg_12_0.hexPoint

	if RoomBuildingHelper.isInInitBlock(var_12_0) then
		return false
	end

	local var_12_1 = RoomMapBuildingModel.instance:getBuildingParam(var_12_0.x, var_12_0.y)

	if var_12_1 then
		if arg_12_1 == nil then
			arg_12_1 = RoomMapTransportPathModel.instance:getIsRemoveBuilding()
		end

		local var_12_2 = RoomMapBuildingModel.instance:getBuildingMOById(var_12_1.buildingUid)
		local var_12_3 = var_12_2 and var_12_2.config

		if var_12_3 and not RoomBuildingEnum.CanDateleBuildingType[var_12_3.buildingType] then
			return false
		end

		if arg_12_1 ~= true then
			return false
		end
	end

	return true
end

function var_0_0.initTransportPathModel(arg_13_0, arg_13_1)
	local var_13_0 = {}

	if arg_13_1 then
		for iter_13_0 = 1, #arg_13_1 do
			local var_13_1 = arg_13_1[iter_13_0]
			local var_13_2 = arg_13_0:getById(var_13_1.id) or RoomTransportPathMO.New()

			var_13_2:setId(var_13_1.id)
			var_13_2:setServerRoadInfo(var_13_1)
			table.insert(var_13_0, var_13_2)
		end
	end

	arg_13_0:setList(var_13_0)
end

function var_0_0.serverRoadInfo2Info(arg_14_0)
	local var_14_0 = {}
	local var_14_1 = {}
	local var_14_2 = arg_14_0.buildingDefineId or arg_14_0.buildingId or 0
	local var_14_3 = arg_14_0.skinId or arg_14_0.buildingSkinId

	var_14_0.fromType = arg_14_0.fromType or 0
	var_14_0.toType = arg_14_0.toType or 0
	var_14_0.critterUid = arg_14_0.critterUid or 0
	var_14_0.buildingUid = arg_14_0.buildingUid or 0
	var_14_0.blockCleanType = arg_14_0.blockCleanType or 0
	var_14_0.buildingId = var_14_2
	var_14_0.buildingSkinId = var_14_3
	var_14_0.hexPointList = var_14_1
	var_14_0.id = arg_14_0.id

	local var_14_4 = RoomMapHexPointModel.instance

	if arg_14_0.roadPoints then
		for iter_14_0, iter_14_1 in ipairs(arg_14_0.roadPoints) do
			table.insert(var_14_1, var_14_4:getHexPoint(iter_14_1.x, iter_14_1.y))
		end
	end

	return var_14_0
end

function var_0_0.findInfoInListByType(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_0 or #arg_15_0 < 1 then
		return nil
	end

	for iter_15_0 = 1, #arg_15_0 do
		local var_15_0 = arg_15_0[iter_15_0]

		if var_15_0.fromType == arg_15_1 and var_15_0.toType == arg_15_2 or var_15_0.fromType == arg_15_2 and var_15_0.toType == arg_15_1 then
			return var_15_0, iter_15_0
		end
	end

	return nil
end

function var_0_0.getBuildingTypeListByHexPoint(arg_16_0, arg_16_1)
	local var_16_0 = {}
	local var_16_1 = arg_16_1 and #arg_16_1 > 0
	local var_16_2 = RoomMapTransportPathModel.instance:getSiteTypeByHexPoint(arg_16_0)

	if var_16_2 and var_16_2 ~= 0 then
		if not var_16_1 or tabletool.indexOf(arg_16_1, var_16_2) then
			table.insert(var_16_0, var_16_2)
		end

		return var_16_0
	end

	local var_16_3 = RoomMapBuildingAreaModel.instance:getList()

	for iter_16_0 = 1, #var_16_3 do
		local var_16_4 = var_16_3[iter_16_0]
		local var_16_5 = var_16_4.buildingType

		if (not var_16_1 or tabletool.indexOf(arg_16_1, var_16_5)) and var_16_4:isInRangesByHexPoint(arg_16_0) then
			table.insert(var_16_0, var_16_5)
		end
	end

	for iter_16_1 = #var_16_0, 1, -1 do
		local var_16_6 = RoomMapTransportPathModel.instance:getSiteHexPointByType(var_16_0[iter_16_1])

		if var_16_6 and var_16_6 ~= arg_16_0 then
			table.remove(var_16_0, iter_16_1)
		end
	end

	return var_16_0
end

function var_0_0.getBuildingTypeByHexPoint(arg_17_0, arg_17_1)
	local var_17_0 = var_0_0.getBuildingAreaByHexPoint(arg_17_0, arg_17_1)

	return var_17_0 and var_17_0.buildingType or 0
end

function var_0_0.getBuildingAreaByHexPoint(arg_18_0, arg_18_1)
	local var_18_0 = RoomMapBuildingAreaModel.instance:getList()
	local var_18_1 = arg_18_1 and #arg_18_1 > 0

	for iter_18_0 = 1, #var_18_0 do
		local var_18_2 = var_18_0[iter_18_0]

		if (not var_18_1 or tabletool.indexOf(arg_18_1, var_18_2.buildingType)) and var_18_2:isInRangesByHexPoint(arg_18_0) then
			return var_18_2
		end
	end
end

function var_0_0.getBuildingAreaByHexXY(arg_19_0, arg_19_1)
	local var_19_0 = RoomMapBuildingAreaModel.instance:getList()

	for iter_19_0 = 1, #var_19_0 do
		local var_19_1 = var_19_0[iter_19_0]

		if var_19_1:isInRangesByHexXY(arg_19_0, arg_19_1) then
			return var_19_1
		end
	end
end

function var_0_0.checkBuildingInLoad(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = RoomMapModel.instance:getBuildingPointList(arg_20_0, arg_20_2)

	if var_20_0 then
		local var_20_1

		for iter_20_0 = 1, #var_20_0 do
			local var_20_2 = var_20_0[iter_20_0]

			if var_0_0.checkInLoadHexXY(var_20_2.x + arg_20_1.x, var_20_2.y + arg_20_1.y) then
				return true
			end
		end
	end

	return false
end

function var_0_0.checkInLoadHexXY(arg_21_0, arg_21_1)
	local var_21_0 = RoomTransportPathModel.instance:getTransportPathMOList()

	for iter_21_0 = 1, #var_21_0 do
		if var_21_0[iter_21_0]:checkHexXY(arg_21_0, arg_21_1) then
			return true
		end
	end

	return false
end

function var_0_0.saveQuickLink(arg_22_0, arg_22_1)
	if arg_22_0 then
		RoomHelper.setNumberByKey(PlayerPrefsKey.RoomTransportPathQuickLinkKey .. arg_22_0, arg_22_1 and 1 or 0)
	end
end

function var_0_0.getIsQuickLink(arg_23_0)
	if arg_23_0 and RoomHelper.getNumberByKey(PlayerPrefsKey.RoomTransportPathQuickLinkKey .. arg_23_0) == 1 then
		return true
	end

	return false
end

return var_0_0
