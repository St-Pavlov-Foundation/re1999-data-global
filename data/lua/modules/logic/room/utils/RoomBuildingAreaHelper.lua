module("modules.logic.room.utils.RoomBuildingAreaHelper", package.seeall)

return {
	checkBuildingArea = function(arg_1_0, arg_1_1, arg_1_2)
		local var_1_0 = RoomConfig.instance:getBuildingConfig(arg_1_0)

		if var_1_0 and RoomBuildingEnum.BuildingArea[var_1_0.buildingType] and var_1_0.isAreaMainBuilding == false then
			local var_1_1 = RoomMapBuildingAreaModel.instance:getAreaMOByBType(var_1_0.buildingType)

			if not var_1_1 then
				return false, RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.NoAreaMainBuilding
			end

			local var_1_2 = RoomMapModel.instance:getBuildingPointList(arg_1_0, arg_1_2)

			if var_1_2 then
				local var_1_3

				for iter_1_0 = 1, #var_1_2 do
					local var_1_4 = var_1_2[iter_1_0]

					if var_1_1:isInRangesByHexXY(var_1_4.x + arg_1_1.x, var_1_4.y + arg_1_1.y) then
						return true
					end
				end
			end

			return false, RoomBuildingEnum.ConfirmPlaceBuildingErrorCode.OutSizeAreaBuilding
		end

		return true
	end,
	isBuildingArea = function(arg_2_0)
		local var_2_0 = RoomConfig.instance:getBuildingConfig(arg_2_0)

		if var_2_0 and RoomBuildingEnum.BuildingArea[var_2_0.buildingType] then
			return true
		end

		return false
	end,
	isAreaMainBuilding = function(arg_3_0)
		local var_3_0 = RoomConfig.instance:getBuildingConfig(arg_3_0)

		if var_3_0 and RoomBuildingEnum.BuildingArea[var_3_0.buildingType] and var_3_0.isAreaMainBuilding == true then
			return true
		end

		return false
	end,
	formatBuildingMOListNameStr = function(arg_4_0)
		if not arg_4_0 or #arg_4_0 < 1 then
			return ""
		end

		local var_4_0 = {}

		for iter_4_0, iter_4_1 in ipairs(arg_4_0) do
			local var_4_1 = iter_4_1.buildingId

			if not var_4_0[var_4_1] then
				var_4_0[var_4_1] = 1
			else
				var_4_0[var_4_1] = var_4_0[var_4_1] + 1
			end
		end

		local var_4_2 = {}

		for iter_4_2, iter_4_3 in pairs(var_4_0) do
			local var_4_3 = RoomConfig.instance:getBuildingConfig(iter_4_2)

			if var_4_3 then
				if iter_4_3 == 1 then
					table.insert(var_4_2, var_4_3.name)
				elseif iter_4_3 > 1 then
					table.insert(var_4_2, string.format("%s * %s", var_4_3.name, iter_4_3))
				end
			end
		end

		local var_4_4 = luaLang("room_levelup_init_and1")

		return table.concat(var_4_2, var_4_4)
	end,
	findTempOutBuildingMOList = function(arg_5_0)
		local var_5_0 = RoomMapBuildingAreaModel.instance:getTempAreaMO()
		local var_5_1

		if not var_5_0 then
			return var_5_1
		end

		local var_5_2 = var_5_0.buildingType
		local var_5_3 = RoomMapBuildingModel.instance:getBuildingMOList()

		for iter_5_0 = 1, #var_5_3 do
			local var_5_4 = var_5_3[iter_5_0]

			if var_5_4 and var_5_4:checkSameType(var_5_2) and not var_5_4:isAreaMainBuilding() and (arg_5_0 == true or not var_5_0:isInRangesByHexPoint(var_5_4.hexPoint)) then
				var_5_1 = var_5_1 or {}

				table.insert(var_5_1, var_5_4)
			end
		end

		return var_5_1
	end,
	isHasWorkingByType = function(arg_6_0)
		local var_6_0 = RoomMapBuildingAreaModel.instance:getAreaMOByBType(arg_6_0)

		if not var_6_0 then
			return false
		end

		local var_6_1 = var_6_0:getBuildingMOList(true)

		for iter_6_0 = 1, #var_6_1 do
			if var_6_1[iter_6_0]:getManufactureState() ~= RoomManufactureEnum.SlotState.Stop then
				return true
			end
		end

		return false
	end,
	findTempOutTransportMOList = function(arg_7_0)
		local var_7_0 = RoomMapBuildingAreaModel.instance:getTempAreaMO()
		local var_7_1

		if not var_7_0 then
			return var_7_1
		end

		local var_7_2 = var_7_0.buildingType
		local var_7_3 = RoomMapTransportPathModel.instance:getTransportPathMOList()

		for iter_7_0 = 1, #var_7_3 do
			local var_7_4 = var_7_3[iter_7_0]

			if var_7_4 and (var_7_4.fromType == var_7_2 and (arg_7_0 == true or not var_7_0:isInRangesByHexPoint(var_7_4:getFirstHexPoint())) or var_7_4.toType == var_7_2 and (arg_7_0 == true or not var_7_0:isInRangesByHexPoint(var_7_4:getLastHexPoint()))) then
				var_7_1 = var_7_1 or {}

				table.insert(var_7_1, var_7_4)
			end
		end

		return var_7_1
	end,
	logTestAreaMO = function(arg_8_0)
		if not arg_8_0 then
			return
		end

		local var_8_0 = arg_8_0:getMainBuildingCfg()

		if not var_8_0 then
			return
		end

		local var_8_1 = arg_8_0:getRangesHexPointList() or {}
		local var_8_2 = string.format("name:%s id:%s -->", var_8_0.name, var_8_0.id)
		local var_8_3 = arg_8_0.mainBuildingMO.hexPoint
		local var_8_4 = string.format("%s (%s,%s)  | ", var_8_2, var_8_3.x, var_8_3.y)

		for iter_8_0, iter_8_1 in ipairs(var_8_1) do
			if iter_8_1 then
				var_8_4 = string.format("%s (%s,%s)", var_8_4, iter_8_1.x, iter_8_1.y)
			end
		end

		logNormal(var_8_4)
	end
}
