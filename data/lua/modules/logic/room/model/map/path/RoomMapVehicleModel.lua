module("modules.logic.room.model.map.path.RoomMapVehicleModel", package.seeall)

local var_0_0 = class("RoomMapVehicleModel", BaseModel)

function var_0_0.ctor(arg_1_0)
	var_0_0.super:ctor(arg_1_0)
	arg_1_0:_clearData()
end

function var_0_0.onInit(arg_2_0)
	arg_2_0:_clearData()
end

function var_0_0.reInit(arg_3_0)
	arg_3_0:_clearData()
end

function var_0_0.clear(arg_4_0)
	var_0_0.super.clear(arg_4_0)
	arg_4_0:_clearData()
end

function var_0_0._clearData(arg_5_0)
	arg_5_0._buildingUidToVehicleIdDic = {}
	arg_5_0._transportSiteTypeToVehicleIdDic = {}
	arg_5_0._resIndexDic = {}
end

function var_0_0.init(arg_6_0)
	arg_6_0:clear()
end

function var_0_0.initVehicle(arg_7_0)
	local var_7_0 = {}
	local var_7_1 = {}
	local var_7_2 = {}

	arg_7_0._resIndexDic = var_7_0

	arg_7_0:_initBuildingVehicle(var_7_1, var_7_0, var_7_2)
	arg_7_0:_initTransportSiteVehicle(var_7_1, var_7_0, var_7_2)

	local var_7_3 = RoomMapPathPlanModel.instance:getList()

	for iter_7_0, iter_7_1 in ipairs(var_7_3) do
		local var_7_4 = iter_7_1.resourceId
		local var_7_5 = RoomConfig.instance:getResourceConfig(var_7_4)
		local var_7_6 = var_7_5 and var_7_5.numLimit or 0
		local var_7_7 = var_7_5 and var_7_5.vehicleId or 0

		if var_7_6 > 0 and var_7_7 ~= 0 and var_7_6 <= iter_7_1:getCount() and RoomConfig.instance:getVehicleConfig(var_7_7) then
			local var_7_8 = arg_7_0:_createMOId(var_7_7, var_7_0)
			local var_7_9 = RoomMapVehicleMO.New()

			var_7_9:init(var_7_8, iter_7_1, var_7_7)
			table.insert(var_7_1, var_7_9)
		end
	end

	arg_7_0:setList(var_7_1)
end

function var_0_0._initBuildingVehicle(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	local var_8_0 = RoomMapBuildingModel.instance:getBuildingMOList()

	for iter_8_0 = 1, #var_8_0 do
		local var_8_1 = var_8_0[iter_8_0]
		local var_8_2 = var_8_1.config and var_8_1.config.vehicleType or 0
		local var_8_3 = var_8_1.config and var_8_1.config.vehicleId or 0
		local var_8_4 = var_8_1.hexPoint

		if var_8_2 ~= 0 and var_8_3 ~= 0 and var_8_4 then
			local var_8_5 = RoomConfig.instance:getVehicleConfig(var_8_3)
			local var_8_6 = var_8_5 and RoomMapPathPlanModel.instance:getPlanMOByXY(var_8_4.x, var_8_4.y, var_8_5.resId)
			local var_8_7 = RoomConfig.instance:getResourceConfig(var_8_5.resId)
			local var_8_8 = var_8_7 and var_8_7.numLimit or 0
			local var_8_9 = {}

			if var_8_6 and var_8_8 > 0 and var_8_8 <= var_8_6:getCount() and arg_8_0:_checkAreaByBuildingMO(var_8_1, var_8_6, var_8_9) then
				local var_8_10 = RoomMapVehicleMO.New()
				local var_8_11 = arg_8_0:_createMOId(var_8_3, arg_8_2)

				arg_8_0:_checkAreaNodeList(var_8_9)
				var_8_10:init(var_8_11, var_8_6, var_8_3, var_8_9)

				var_8_10.vehicleType = var_8_2
				var_8_10.ownerType = RoomVehicleEnum.OwnerType.Building
				var_8_10.ownerId = var_8_1.id

				table.insert(arg_8_1, var_8_10)

				arg_8_0._buildingUidToVehicleIdDic[var_8_1.id] = var_8_11

				table.insert(arg_8_3, var_8_6.id)
			end
		end
	end
end

function var_0_0._checkAreaNodeList(arg_9_0, arg_9_1)
	if not arg_9_1 or #arg_9_1 < 2 then
		return
	end

	local var_9_0 = #arg_9_1

	if arg_9_1[1]:isEndNode() and not arg_9_1[var_9_0]:isEndNode() then
		local var_9_1 = math.floor(var_9_0 / 2)

		for iter_9_0 = 1, var_9_1 do
			local var_9_2 = var_9_0 + 1 - iter_9_0

			arg_9_1[var_9_2], arg_9_1[iter_9_0] = arg_9_1[iter_9_0], arg_9_1[var_9_2]
		end
	end
end

function var_0_0._checkAreaByBuildingMO(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	if not arg_10_1 or not arg_10_2 then
		return false
	end

	local var_10_0 = RoomMapModel.instance:getBuildingConfigParam(arg_10_1.buildingId)
	local var_10_1 = var_10_0.centerPoint
	local var_10_2 = var_10_0.pointList

	for iter_10_0, iter_10_1 in ipairs(var_10_2) do
		local var_10_3 = RoomBuildingHelper.getWorldHexPoint(iter_10_1, var_10_1, arg_10_1.hexPoint, arg_10_1.rotate)
		local var_10_4 = arg_10_2:getNodeByXY(var_10_3.x, var_10_3.y)

		if not var_10_4 then
			return false
		end

		if arg_10_3 then
			table.insert(arg_10_3, var_10_4)
		end
	end

	return true
end

function var_0_0._createMOId(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_2[arg_11_1] or 1

	arg_11_2[arg_11_1] = var_11_0 + 1

	return arg_11_1 * 1000 + var_11_0
end

function var_0_0.getVehicleMOByBuilingUid(arg_12_0, arg_12_1)
	if arg_12_0._buildingUidToVehicleIdDic[arg_12_1] then
		return arg_12_0:getById(arg_12_0._buildingUidToVehicleIdDic[arg_12_1])
	end
end

function var_0_0._initTransportSiteVehicle(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = RoomTransportHelper.getSiteBuildingTypeList()

	for iter_13_0 = 1, #var_13_0 do
		local var_13_1 = var_13_0[iter_13_0]
		local var_13_2 = arg_13_0:createVehicleMOBySiteType(var_13_1)

		if var_13_2 then
			table.insert(arg_13_1, var_13_2)
		end
	end
end

function var_0_0.createVehicleMOBySiteType(arg_14_0, arg_14_1)
	if not arg_14_1 then
		return
	end

	local var_14_0, var_14_1 = RoomTransportHelper.getSiteFromToByType(arg_14_1)
	local var_14_2 = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(var_14_0, var_14_1)

	if not var_14_2 or not var_14_2.buildingUid or var_14_2.buildingUid == 0 then
		return
	end

	local var_14_3 = RoomTransportHelper.getVehicleCfgByBuildingId(var_14_2.buildingId, var_14_2.buildingSkinId)

	if not var_14_3 then
		return
	end

	local var_14_4 = arg_14_0._transportSiteTypeToVehicleIdDic[arg_14_1] or arg_14_0:_createMOId(var_14_0, arg_14_0._resIndexDic)

	arg_14_0._transportSiteTypeToVehicleIdDic[arg_14_1] = var_14_4

	local var_14_5 = RoomMapPathPlanMO.New()
	local var_14_6 = RoomResourceEnum.ResourceId.Empty

	var_14_5:initHexPintList(var_14_4, var_14_6, var_14_2:getHexPointList())

	local var_14_7 = {}
	local var_14_8 = var_14_5:getNodeList()
	local var_14_9 = false

	if #var_14_8 > 0 then
		local var_14_10 = 1

		if var_14_2.fromType ~= arg_14_1 then
			var_14_10 = #var_14_8
		end

		local var_14_11 = var_14_8[var_14_10]

		table.insert(var_14_7, var_14_11)

		local var_14_12 = RoomMapBlockModel.instance:getBlockMO(var_14_11.hexPoint.x, var_14_11.hexPoint.y)

		if var_14_12 and var_14_12:hasRiver() then
			var_14_9 = true
		end
	end

	local var_14_13 = RoomMapVehicleMO.New()

	var_14_13:init(var_14_4, var_14_5, var_14_3.id, var_14_7)

	var_14_13.vehicleType = 1
	var_14_13.ownerType = RoomVehicleEnum.OwnerType.TransportSite
	var_14_13.ownerId = arg_14_1

	var_14_13:setReplaceType(var_14_9 and RoomVehicleEnum.ReplaceType.Water or RoomVehicleEnum.ReplaceType.Land)

	return var_14_13
end

function var_0_0.getVehicleIdBySiteType(arg_15_0, arg_15_1)
	return arg_15_0._transportSiteTypeToVehicleIdDic[arg_15_1]
end

function var_0_0.getVehicleMOBySiteType(arg_16_0, arg_16_1)
	return arg_16_0:getById(arg_16_0:getVehicleIdBySiteType(arg_16_1))
end

var_0_0.instance = var_0_0.New()

return var_0_0
