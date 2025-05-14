module("modules.logic.room.model.map.RoomMapBuildingAreaMO", package.seeall)

local var_0_0 = pureTable("RoomMapBuildingAreaMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.uid
	arg_1_0.buildingType = arg_1_1.config.buildingType

	arg_1_0:setMainBuildingMO(arg_1_1)
end

function var_0_0.setMainBuildingMO(arg_2_0, arg_2_1)
	arg_2_0.mainBuildingMO = arg_2_1

	arg_2_0:clearRangesHexList()
	arg_2_0:clearBuildingMOList()
end

function var_0_0.getMainBuildingCfg(arg_3_0)
	if arg_3_0.mainBuildingMO then
		return arg_3_0.mainBuildingMO.config
	end
end

function var_0_0.getRangesHexPointList(arg_4_0)
	if arg_4_0.mainBuildingMO then
		local var_4_0 = arg_4_0.mainBuildingMO.buildingId
		local var_4_1 = arg_4_0.mainBuildingMO.hexPoint
		local var_4_2 = arg_4_0.mainBuildingMO.rotate
		local var_4_3 = RoomBuildingEnum.BuildingAreaRange or 1

		if arg_4_0._builingId ~= var_4_0 or arg_4_0._rotate ~= var_4_2 or arg_4_0._hexPoint ~= var_4_1 then
			arg_4_0._builingId = var_4_0
			arg_4_0._hexPoint = var_4_1
			arg_4_0._rotate = var_4_2
			arg_4_0._rangsHexList = arg_4_0:_findBuildingInRanges(var_4_0, var_4_1, var_4_2, var_4_3)
		end
	else
		arg_4_0:clearRangesHexList()
	end

	return arg_4_0._rangsHexList
end

function var_0_0.isInRangesByHexPoint(arg_5_0, arg_5_1)
	if arg_5_1 and arg_5_0:isInRangesByHexXY(arg_5_1.x, arg_5_1.y) then
		return true
	end

	return false
end

function var_0_0.isInRangesByHexXY(arg_6_0, arg_6_1, arg_6_2)
	local var_6_0 = arg_6_0:getRangesHexPointList()
	local var_6_1

	for iter_6_0 = 1, #var_6_0 do
		local var_6_2 = var_6_0[iter_6_0]

		if var_6_2.x == arg_6_1 and var_6_2.y == arg_6_2 then
			return true
		end
	end

	return false
end

function var_0_0.clearRangesHexList(arg_7_0)
	if arg_7_0._rangsHexList and #arg_7_0._rangsHexList > 0 then
		arg_7_0._rangsHexList = {}
	end

	arg_7_0._builingId = 0
	arg_7_0._rotate = 0
	arg_7_0._hexPoint = nil
end

function var_0_0.getBuildingMOList(arg_8_0, arg_8_1)
	if not arg_8_0._buildingMOList then
		arg_8_0._buildingMOList = arg_8_0:_findMapBuildingMOList()
		arg_8_0._buildingMOWithMainList = {
			arg_8_0.mainBuildingMO
		}

		tabletool.addValues(arg_8_0._buildingMOWithMainList, arg_8_0._buildingMOList)
	end

	if arg_8_1 then
		return arg_8_0._buildingMOWithMainList
	end

	return arg_8_0._buildingMOList
end

function var_0_0.clearBuildingMOList(arg_9_0)
	arg_9_0._buildingMOList = nil
end

function var_0_0._findMapBuildingMOList(arg_10_0)
	local var_10_0 = {}

	if not arg_10_0.mainBuildingMO then
		return var_10_0
	end

	local var_10_1 = arg_10_0:getRangesHexPointList()
	local var_10_2 = RoomMapBuildingModel.instance

	for iter_10_0 = 1, #var_10_1 do
		local var_10_3 = var_10_1[iter_10_0]

		if var_10_3 then
			local var_10_4 = var_10_2:getBuildingMO(var_10_3.x, var_10_3.y)

			if var_10_4 and var_10_4:checkSameType(arg_10_0.buildingType) and not tabletool.indexOf(var_10_0, var_10_4) then
				table.insert(var_10_0, var_10_4)
			end
		end
	end

	return var_10_0
end

function var_0_0.getBuildingType(arg_11_0)
	return arg_11_0.buildingType
end

function var_0_0._findBuildingInRanges(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
	arg_12_2 = arg_12_2 or HexPoint(0, 0)
	arg_12_3 = arg_12_3 or 0
	arg_12_4 = arg_12_4 or 1

	local var_12_0 = {}
	local var_12_1 = {}
	local var_12_2 = RoomMapModel.instance:getBuildingPointList(arg_12_1, arg_12_3)

	for iter_12_0 = 1, #var_12_2 do
		local var_12_3 = arg_12_2 + var_12_2[iter_12_0]

		table.insert(var_12_0, var_12_3)
		tabletool.addValues(var_12_1, var_12_3:inRanges(arg_12_4, true))
	end

	for iter_12_1 = #var_12_1, 1, -1 do
		if tabletool.indexOf(var_12_0, var_12_1[iter_12_1]) then
			table.remove(var_12_1, iter_12_1)
		end
	end

	return var_12_1
end

return var_0_0
