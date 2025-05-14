module("modules.logic.room.model.map.RoomMapTransportPathModel", package.seeall)

local var_0_0 = class("RoomMapTransportPathModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:_clearData()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0:_clearData()
end

function var_0_0.clear(arg_3_0)
	var_0_0.super.clear(arg_3_0)
	arg_3_0:_clearData()
end

function var_0_0._clearData(arg_4_0)
	arg_4_0._siteHexPointDict = {}
	arg_4_0._buildingTypesDict = {}
	arg_4_0._opParams = {}
end

function var_0_0.removeByIds(arg_5_0, arg_5_1)
	if arg_5_1 and #arg_5_1 > 0 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
			local var_5_0 = arg_5_0:getById(iter_5_1)

			arg_5_0:remove(var_5_0)
		end
	end
end

function var_0_0.updateInofoById(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:getById(arg_6_1)

	if var_6_0 and arg_6_2 then
		var_6_0:updateInfo(arg_6_2)
	end
end

function var_0_0.getTransportPathMOByCritterUid(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_0:getList()

	for iter_7_0 = 1, #var_7_0 do
		local var_7_1 = var_7_0[iter_7_0]

		if var_7_1 and var_7_1.critterUid == arg_7_1 then
			return var_7_1
		end
	end
end

function var_0_0.getTransportPathMOByBuildingUid(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getList()

	for iter_8_0 = 1, #var_8_0 do
		local var_8_1 = var_8_0[iter_8_0]

		if var_8_1 and var_8_1.buildingUid == arg_8_1 then
			return var_8_1
		end
	end
end

function var_0_0.getTransportPathMO(arg_9_0, arg_9_1)
	return arg_9_0:getById(arg_9_1)
end

function var_0_0.getTransportPathMOList(arg_10_0)
	return arg_10_0:getList()
end

function var_0_0.initPath(arg_11_0, arg_11_1)
	RoomTransportHelper.initTransportPathModel(arg_11_0, arg_11_1)

	arg_11_0._buildingTypesDict = {}
end

function var_0_0.resetByTransportPathMOList(arg_12_0, arg_12_1)
	local var_12_0 = {}

	if arg_12_1 then
		for iter_12_0 = 1, #arg_12_1 do
			local var_12_1 = arg_12_1[iter_12_0]
			local var_12_2 = arg_12_0:getByIndex(var_12_1.id)

			if not var_12_2 then
				var_12_2 = RoomTransportPathMO.New()

				var_12_2:setId(-iter_12_0)
			end

			var_12_2:setIsEdit(false)
			var_12_2:setIsQuickLink(nil)
			var_12_2:updateInfo(var_12_1)
			table.insert(var_12_0, var_12_2)
		end
	end

	arg_12_0:setList(var_12_0)
end

function var_0_0.updateSiteHexPoint(arg_13_0)
	arg_13_0._siteHexPointDict = {}

	local var_13_0 = arg_13_0:getList()
	local var_13_1 = {}

	for iter_13_0 = 1, #var_13_0 do
		local var_13_2 = var_13_0[iter_13_0]

		if var_13_2 and var_13_2:isLinkFinish() then
			table.insert(var_13_1, var_13_2)
		end
	end

	for iter_13_1 = 1, #var_13_1 do
		local var_13_3 = var_13_1[iter_13_1]

		for iter_13_2 = iter_13_1 + 1, #var_13_1 do
			local var_13_4, var_13_5 = RoomTransportHelper.getSiltParamBy2PathMO(var_13_3, var_13_1[iter_13_2])

			if var_13_4 ~= nil and var_13_5 ~= nil then
				arg_13_0._siteHexPointDict[var_13_4] = var_13_5
			end
		end
	end

	for iter_13_3 = 1, #var_13_1 do
		local var_13_6 = var_13_1[iter_13_3]

		var_13_6:checkTempTypes({
			var_13_6.fromType,
			var_13_6.toType
		})
	end

	local var_13_7 = RoomTransportHelper.getPathBuildingTypesList()

	for iter_13_4 = 1, #var_13_7 do
		local var_13_8 = var_13_7[iter_13_4]
		local var_13_9 = var_13_8[1]
		local var_13_10 = var_13_8[2]
		local var_13_11 = arg_13_0:getTransportPathMOBy2Type(var_13_9, var_13_10)

		if var_13_11 and var_13_11:isLinkFinish() then
			arg_13_0._siteHexPointDict[var_13_11.fromType] = arg_13_0._siteHexPointDict[var_13_11.fromType] or var_13_11:getFirstHexPoint()
			arg_13_0._siteHexPointDict[var_13_11.toType] = arg_13_0._siteHexPointDict[var_13_11.toType] or var_13_11:getLastHexPoint()
		end
	end
end

function var_0_0.getSiteHexPointByType(arg_14_0, arg_14_1)
	return arg_14_0._siteHexPointDict and arg_14_0._siteHexPointDict[arg_14_1]
end

function var_0_0.getSiteTypeByHexPoint(arg_15_0, arg_15_1)
	if arg_15_0._siteHexPointDict and arg_15_1 then
		for iter_15_0, iter_15_1 in pairs(arg_15_0._siteHexPointDict) do
			if arg_15_1 == iter_15_1 then
				return iter_15_0
			end
		end
	end

	return 0
end

function var_0_0.setSiteHexPointByType(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._siteHexPointDict = arg_16_0._siteHexPointDict or {}
	arg_16_0._siteHexPointDict[arg_16_1] = arg_16_2
end

function var_0_0.isHasEdit(arg_17_0)
	local var_17_0 = arg_17_0:getList()

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		if iter_17_1:getIsEdit() then
			return true
		end
	end

	return false
end

function var_0_0.setSelectBuildingType(arg_18_0, arg_18_1)
	arg_18_0._selectBuildingType = arg_18_1
end

function var_0_0.getSelectBuildingType(arg_19_0)
	return arg_19_0._selectBuildingType
end

function var_0_0.setOpParam(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0._opParams = arg_20_0._opParams or {}
	arg_20_0._opParams.isDragPath = arg_20_1 == true
	arg_20_0._opParams.siteType = arg_20_2
end

function var_0_0.getOpParam(arg_21_0)
	return arg_21_0._opParams
end

function var_0_0.setIsRemoveBuilding(arg_22_0, arg_22_1)
	arg_22_0._isRemoveBuilding = arg_22_1
end

function var_0_0.getIsRemoveBuilding(arg_23_0)
	return arg_23_0._isRemoveBuilding
end

function var_0_0.placeTempTransportPathMO(arg_24_0)
	arg_24_0._tempTransportPathMO = nil
end

function var_0_0.getTempTransportPathMO(arg_25_0)
	return arg_25_0._tempTransportPathMO
end

function var_0_0.addTempTransportPathMO(arg_26_0, arg_26_1, arg_26_2, arg_26_3)
	local var_26_0 = arg_26_0:getTransportPathMOBy2Type(arg_26_2, arg_26_3) or arg_26_0:_findTransportPathMOByHexPoint(arg_26_1, false)

	if not var_26_0 then
		local var_26_1

		if arg_26_2 and arg_26_3 then
			var_26_1 = {
				arg_26_2,
				arg_26_3
			}
		end

		var_26_0 = arg_26_0:_createTempTransportPathMOByHexPoint(arg_26_1, var_26_1)
	end

	arg_26_0._tempTransportPathMO = var_26_0

	return var_26_0
end

function var_0_0.getTransportPathMOByHexPoint(arg_27_0, arg_27_1, arg_27_2)
	return arg_27_0:_findTransportPathMOByHexPoint(arg_27_1, arg_27_2)
end

function var_0_0.getTransportPathMOListByHexPoint(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0
	local var_28_1 = arg_28_0:getList()

	for iter_28_0 = 1, #var_28_1 do
		local var_28_2 = var_28_1[iter_28_0]

		if (arg_28_2 == nil or arg_28_2 == var_28_2:isLinkFinish()) and var_28_2:checkHexPoint(arg_28_1) then
			var_28_0 = var_28_0 or {}

			table.insert(var_28_0, var_28_2)
		end
	end

	return var_28_0
end

function var_0_0.getLinkFinishCount(arg_29_0)
	return arg_29_0:_countTransportPathMO(nil, true)
end

function var_0_0.getLinkFailCount(arg_30_0)
	local var_30_0 = arg_30_0:getLinkFinishCount()

	return arg_30_0:getMaxCount() - var_30_0
end

function var_0_0.getTransportPathMOBy2Type(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0:getList()

	for iter_31_0 = 1, #var_31_0 do
		local var_31_1 = var_31_0[iter_31_0]

		if var_31_1:checkSameType(arg_31_1, arg_31_2) then
			return var_31_1
		end
	end
end

function var_0_0._countTransportPathMO(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = arg_32_0:getList()
	local var_32_1 = 0

	for iter_32_0 = 1, #var_32_0 do
		local var_32_2 = var_32_0[iter_32_0]

		if (arg_32_1 == nil or var_32_2:checkHexPoint(arg_32_1)) and (arg_32_2 == nil or arg_32_2 == var_32_2:isLinkFinish()) then
			var_32_1 = var_32_1 + 1
		end
	end

	return var_32_1
end

function var_0_0._findTransportPathMOByHexPoint(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0:getList()

	for iter_33_0 = 1, #var_33_0 do
		local var_33_1 = var_33_0[iter_33_0]

		if var_33_1:checkHexPoint(arg_33_1) and (arg_33_2 == nil or arg_33_2 == var_33_1:isLinkFinish()) then
			return var_33_1
		end
	end
end

function var_0_0._createTempTransportPathMOByHexPoint(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = RoomTransportHelper.getBuildingTypeListByHexPoint(arg_34_1, arg_34_2)

	if not var_34_0 or #var_34_0 < 1 then
		return nil
	end

	local var_34_1
	local var_34_2 = arg_34_0:getList()

	for iter_34_0 = 1, #var_34_2 do
		if var_34_2[iter_34_0]:getHexPointCount() < 1 then
			var_34_1 = var_34_2[iter_34_0]

			var_34_1:addHexPoint(arg_34_1)

			break
		end
	end

	if not var_34_1 and arg_34_0:getMaxCount() > arg_34_0:getCount() then
		var_34_1 = RoomTransportPathMO.New()

		var_34_1:init()

		local var_34_3 = 0

		while arg_34_0:getById(var_34_3) ~= nil do
			var_34_3 = var_34_3 - 1
		end

		var_34_1:setId(var_34_3)
		var_34_1:addHexPoint(arg_34_1)
		arg_34_0:addAtLast(var_34_1)
	end

	return var_34_1
end

function var_0_0.getMaxCount(arg_35_0)
	local var_35_0 = RoomMapBuildingAreaModel.instance:getCount() - 1

	return (var_35_0 + 1) * var_35_0 * 0.5
end

var_0_0.instance = var_0_0.New()

return var_0_0
