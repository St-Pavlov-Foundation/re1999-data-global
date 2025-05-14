module("modules.logic.room.model.transport.RoomTransportPathMO", package.seeall)

local var_0_0 = pureTable("RoomTransportPathMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.hexPointList = {}

	arg_1_0:setId(arg_1_1 and arg_1_1.id)
end

function var_0_0.setId(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1 or 0
end

function var_0_0.updateCritterInfo(arg_3_0, arg_3_1)
	arg_3_0.critterUid = arg_3_1.critterUid or arg_3_0.critterUid or 0

	if tonumber(arg_3_0.critterUid) == 0 then
		arg_3_0.critterUid = 0
	end
end

function var_0_0.updateBuildingInfo(arg_4_0, arg_4_1)
	arg_4_0.buildingUid = arg_4_1.buildingUid or arg_4_0.buildingUid or 0
	arg_4_0.buildingId = arg_4_1.buildingId or arg_4_1.buildingDefineId or arg_4_0.buildingId or 0
	arg_4_0.buildingSkinId = arg_4_1.buildingSkinId or arg_4_1.skinId or arg_4_0.buildingSkinId or 0
end

function var_0_0.updateInfo(arg_5_0, arg_5_1)
	arg_5_0.fromType = arg_5_1.fromType or arg_5_0.fromType or 0
	arg_5_0.toType = arg_5_1.toType or arg_5_0.toType or 0
	arg_5_0.blockCleanType = arg_5_1.blockCleanType or arg_5_0.blockCleanType or 0

	arg_5_0:updateCritterInfo(arg_5_1)
	arg_5_0:updateBuildingInfo(arg_5_1)

	local var_5_0 = arg_5_1.hexPointList

	if var_5_0 then
		arg_5_0.hexPointList = {}

		tabletool.addValues(arg_5_0.hexPointList, var_5_0)
	end
end

function var_0_0.setServerRoadInfo(arg_6_0, arg_6_1)
	local var_6_0 = RoomTransportHelper.serverRoadInfo2Info(arg_6_1)

	arg_6_0:updateInfo(var_6_0)
end

function var_0_0.checkSameType(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_0.fromType == arg_7_1 and arg_7_0.toType == arg_7_2 or arg_7_0.fromType == arg_7_2 and arg_7_0.toType == arg_7_1 then
		return true
	end

	return false
end

function var_0_0.isLinkFinish(arg_8_0)
	if not arg_8_0.fromType or not arg_8_0.toType or arg_8_0.fromType == arg_8_0.toType then
		return false
	end

	if RoomBuildingEnum.BuildingArea[arg_8_0.fromType] and RoomBuildingEnum.BuildingArea[arg_8_0.toType] then
		return true
	end

	return false
end

function var_0_0.getHexPointList(arg_9_0)
	return arg_9_0.hexPointList
end

function var_0_0.getHexPointCount(arg_10_0)
	return arg_10_0.hexPointList and #arg_10_0.hexPointList or 0
end

function var_0_0.setHexPointList(arg_11_0, arg_11_1)
	arg_11_0.hexPointList = {}

	tabletool.addValues(arg_11_0.hexPointList, arg_11_1)
end

function var_0_0.getLastHexPoint(arg_12_0)
	return arg_12_0.hexPointList[#arg_12_0.hexPointList]
end

function var_0_0.getFirstHexPoint(arg_13_0)
	return arg_13_0.hexPointList[1]
end

function var_0_0.changeBenEnd(arg_14_0)
	if arg_14_0.hexPointList and #arg_14_0.hexPointList > 1 then
		arg_14_0.toType, arg_14_0.fromType = arg_14_0.fromType, arg_14_0.toType

		local var_14_0 = #arg_14_0.hexPointList
		local var_14_1 = math.floor(var_14_0 * 0.5)

		for iter_14_0 = 1, var_14_1 do
			local var_14_2 = arg_14_0.hexPointList[iter_14_0]
			local var_14_3 = var_14_0 - iter_14_0 + 1

			arg_14_0.hexPointList[iter_14_0] = arg_14_0.hexPointList[var_14_3]
			arg_14_0.hexPointList[var_14_3] = var_14_2
		end
	end
end

function var_0_0.removeLastHexPoint(arg_15_0)
	local var_15_0 = arg_15_0:getHexPointCount()

	if var_15_0 > 0 then
		table.remove(arg_15_0.hexPointList, var_15_0)
	end
end

function var_0_0.setIsEdit(arg_16_0, arg_16_1)
	arg_16_0._isEdit = arg_16_1
end

function var_0_0.getIsEdit(arg_17_0)
	return arg_17_0._isEdit
end

function var_0_0.setIsQuickLink(arg_18_0, arg_18_1)
	arg_18_0._isQuickLink = arg_18_1
end

function var_0_0.getIsQuickLink(arg_19_0)
	return arg_19_0._isQuickLink
end

function var_0_0.addHexPoint(arg_20_0, arg_20_1)
	if arg_20_0:isCanAddHexPoint(arg_20_1) then
		table.insert(arg_20_0.hexPointList, arg_20_1)

		return true
	end

	return false
end

function var_0_0.isCanAddHexPoint(arg_21_0, arg_21_1)
	if not arg_21_1 or arg_21_0:checkHexPoint(arg_21_1) then
		return false
	end

	local var_21_0 = arg_21_0:getLastHexPoint()

	if var_21_0 == nil or HexPoint.Distance(var_21_0, arg_21_1) == 1 then
		return true
	end

	return false
end

function var_0_0.checkHexPoint(arg_22_0, arg_22_1)
	if arg_22_1 then
		return arg_22_0:checkHexXY(arg_22_1.x, arg_22_1.y)
	end

	return false
end

function var_0_0.checkHexXY(arg_23_0, arg_23_1, arg_23_2)
	for iter_23_0, iter_23_1 in ipairs(arg_23_0.hexPointList) do
		if iter_23_1.x == arg_23_1 and iter_23_1.y == arg_23_2 then
			return true, iter_23_0
		end
	end

	return false
end

function var_0_0.checkTempTypes(arg_24_0, arg_24_1)
	arg_24_0.tempFromTypes = RoomTransportHelper.getBuildingTypeListByHexPoint(arg_24_0:getFirstHexPoint(), arg_24_1)
	arg_24_0.tempToTypes = RoomTransportHelper.getBuildingTypeListByHexPoint(arg_24_0:getLastHexPoint(), arg_24_1)
	arg_24_0.fromType, arg_24_0.toType = arg_24_0:_find2ListValue(arg_24_0.tempFromTypes, arg_24_0.tempToTypes, 0)
end

function var_0_0._find2ListValue(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	for iter_25_0 = 1, #arg_25_1 do
		for iter_25_1 = 1, #arg_25_2 do
			if arg_25_1[iter_25_0] ~= arg_25_2[iter_25_1] then
				return arg_25_1[iter_25_0], arg_25_2[iter_25_1]
			end
		end
	end

	return arg_25_1[1] or arg_25_3, arg_25_2[1] or arg_25_3
end

function var_0_0.isTransporting(arg_26_0)
	local var_26_0 = false

	if arg_26_0:hasCritterWorking() then
		local var_26_1 = ManufactureModel.instance:isAreaHasManufactureRunning(arg_26_0.fromType)
		local var_26_2 = ManufactureModel.instance:isAreaHasManufactureRunning(arg_26_0.toType)

		if var_26_1 or var_26_2 then
			var_26_0 = true
		end
	end

	return var_26_0
end

function var_0_0.hasCritterWorking(arg_27_0)
	local var_27_0 = 0
	local var_27_1 = CritterModel.instance:getCritterMOByUid(arg_27_0.critterUid)

	if var_27_1 then
		var_27_0 = var_27_1:getMoodValue()
	end

	return var_27_0 > 0
end

function var_0_0.clear(arg_28_0)
	if arg_28_0.hexPointList and #arg_28_0.hexPointList > 0 then
		arg_28_0.hexPointList = {}
		arg_28_0.fromType = 0
		arg_28_0.toType = 0
	end
end

return var_0_0
