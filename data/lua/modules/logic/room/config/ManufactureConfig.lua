module("modules.logic.room.config.ManufactureConfig", package.seeall)

local var_0_0 = class("ManufactureConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"manufacture_const",
		"trade_level",
		"manufacture_building",
		"rest_building",
		"manufacture_building_level",
		"manufacture_building_trade_level",
		"manufacture_item",
		"trade_level_unlock"
	}
end

function var_0_0.onInit(arg_2_0)
	arg_2_0._levelGroupDict = {}
	arg_2_0._tradeLevelGroupDict = {}
	arg_2_0._belongBuildingDict = nil
	arg_2_0._belongBuildingTypeDict = nil
	arg_2_0._itemId2ManufactureItemDict = nil
	arg_2_0._levelUnlockDict = {}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0[string.format("%sConfigLoaded", arg_3_1)]

	if var_3_0 then
		var_3_0(arg_3_0, arg_3_2)
	end
end

function var_0_0.manufacture_itemConfigLoaded(arg_4_0, arg_4_1)
	arg_4_0._itemId2ManufactureItemDict = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_1.configList) do
		local var_4_0 = iter_4_1.itemId
		local var_4_1 = arg_4_0._itemId2ManufactureItemDict[var_4_0]

		if not var_4_1 then
			var_4_1 = {}
			arg_4_0._itemId2ManufactureItemDict[var_4_0] = var_4_1
		end

		table.insert(var_4_1, iter_4_0)
	end
end

function var_0_0.trade_levelConfigLoaded(arg_5_0, arg_5_1)
	if not arg_5_0._systemUnlockLevel then
		arg_5_0._systemUnlockLevel = {}
	end

	for iter_5_0, iter_5_1 in pairs(arg_5_1.configList) do
		if not string.nilorempty(iter_5_1.unlockId) then
			local var_5_0 = string.splitToNumber(iter_5_1.unlockId, "#")

			for iter_5_2, iter_5_3 in ipairs(var_5_0) do
				arg_5_0._systemUnlockLevel[iter_5_3] = iter_5_1.level
			end
		end
	end
end

function var_0_0.manufacture_buildingConfigLoaded(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in pairs(arg_6_1.configList) do
		local var_6_0 = iter_6_1.placeTradeLevel
		local var_6_1 = arg_6_0._levelUnlockDict[var_6_0]

		if not var_6_1 then
			var_6_1 = {}
			arg_6_0._levelUnlockDict[var_6_0] = var_6_1
		end

		local var_6_2 = var_6_1[RoomTradeEnum.LevelUnlock.NewBuilding]

		if not var_6_2 then
			var_6_2 = {}
			var_6_1[RoomTradeEnum.LevelUnlock.NewBuilding] = var_6_2
		end

		table.insert(var_6_2, iter_6_1.id)
	end
end

function var_0_0.manufacture_building_levelConfigLoaded(arg_7_0, arg_7_1)
	arg_7_0._levelGroupDict = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_1.configDict) do
		local var_7_0 = {
			maxLevel = 0,
			maxSlotCount = 0,
			manufactureItem2LevelDict = {}
		}

		for iter_7_2, iter_7_3 in pairs(iter_7_1) do
			if iter_7_2 > var_7_0.maxLevel then
				var_7_0.maxLevel = iter_7_2
			end

			local var_7_1 = iter_7_3.slotCount

			if var_7_1 > var_7_0.maxSlotCount then
				var_7_0.maxSlotCount = var_7_1
			end

			local var_7_2 = string.splitToNumber(iter_7_3.productions, "#")

			for iter_7_4, iter_7_5 in ipairs(var_7_2) do
				var_7_0.manufactureItem2LevelDict[iter_7_5] = iter_7_2
			end

			local var_7_3 = iter_7_3.needTradeLevel
			local var_7_4 = arg_7_0._levelUnlockDict[var_7_3]

			if not var_7_4 then
				var_7_4 = {}
				arg_7_0._levelUnlockDict[var_7_3] = var_7_4
			end

			local var_7_5 = var_7_4[RoomTradeEnum.LevelUnlock.BuildingMaxLevel]

			if not var_7_5 then
				var_7_5 = {}
				var_7_4[RoomTradeEnum.LevelUnlock.BuildingMaxLevel] = var_7_5
			end

			if iter_7_2 > 1 then
				local var_7_6 = {
					groupId = iter_7_0,
					Level = iter_7_2
				}

				table.insert(var_7_5, var_7_6)
			end
		end

		arg_7_0._levelGroupDict[iter_7_0] = var_7_0
	end
end

function var_0_0.manufacture_building_trade_levelConfigLoaded(arg_8_0, arg_8_1)
	arg_8_0._tradeLevelGroupDict = {}

	for iter_8_0, iter_8_1 in pairs(arg_8_1.configDict) do
		local var_8_0 = {
			totalCritterCount = 0
		}

		for iter_8_2, iter_8_3 in pairs(iter_8_1) do
			local var_8_1 = iter_8_3.maxCritterCount

			if var_8_1 > var_8_0.totalCritterCount then
				var_8_0.totalCritterCount = var_8_1
			end
		end

		arg_8_0._tradeLevelGroupDict[iter_8_0] = var_8_0
	end
end

function var_0_0.getManufactureConstCfg(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0

	if arg_9_1 then
		var_9_0 = lua_manufacture_const.configDict[arg_9_1]
	end

	if not var_9_0 and arg_9_2 then
		logError(string.format("ManufactureConfig:getManufactureConstCfg error, cfg is nil, constId:%s", arg_9_1))
	end

	return var_9_0
end

function var_0_0.getManufactureConst(arg_10_0, arg_10_1)
	local var_10_0
	local var_10_1 = arg_10_0:getManufactureConstCfg(arg_10_1, true)

	if var_10_1 then
		var_10_0 = var_10_1.value
	end

	return var_10_0
end

function var_0_0.getTradeLevelCfg(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = lua_trade_level.configDict[arg_11_1]

	if not var_11_0 and arg_11_2 then
		logError(string.format("ManufactureConfig:getTradeLevelCfg error, cfg is nil, level:%s", arg_11_1))
	end

	return var_11_0
end

function var_0_0.getUnlockSystemTradeLevel(arg_12_0, arg_12_1, arg_12_2)
	return arg_12_0._systemUnlockLevel[arg_12_1]
end

function var_0_0.getManufactureBuildingCfg(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = lua_manufacture_building.configDict[arg_13_1]

	if not var_13_0 and arg_13_2 then
		logError(string.format("ManufactureConfig:getManufactureBuildingCfg error, cfg is nil, buildingId:%s", arg_13_1))
	end

	return var_13_0
end

function var_0_0.getRestBuildingCfg(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = lua_rest_building.configDict[arg_14_1]

	if not var_14_0 and arg_14_2 then
		logError(string.format("ManufactureConfig:getRestBuildingCfg error, cfg is nil, buildingId:%s", arg_14_1))
	end

	return var_14_0
end

function var_0_0.isManufactureBuilding(arg_15_0, arg_15_1)
	local var_15_0 = false
	local var_15_1 = RoomConfig.instance:getBuildingType(arg_15_1)

	if var_15_1 == RoomBuildingEnum.BuildingType.Collect or var_15_1 == RoomBuildingEnum.BuildingType.Process or var_15_1 == RoomBuildingEnum.BuildingType.Manufacture then
		var_15_0 = true
	end

	return var_15_0
end

function var_0_0.isManufactureItemBelongBuilding(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = false
	local var_16_1 = arg_16_0:getBuildingUpgradeGroup(arg_16_1)

	if (arg_16_0._levelGroupDict[var_16_1] and arg_16_0._levelGroupDict[var_16_1].manufactureItem2LevelDict)[arg_16_2] then
		var_16_0 = true
	end

	return var_16_0
end

function var_0_0.getManufactureItemBelongBuildingList(arg_17_0, arg_17_1)
	arg_17_0:_initManufactureItemBelongBuildingDict()

	return arg_17_0._belongBuildingDict[arg_17_1] or {}
end

function var_0_0.getManufactureItemBelongBuildingType(arg_18_0, arg_18_1)
	arg_18_0:_initManufactureItemBelongBuildingDict()

	return arg_18_0._belongBuildingTypeDict[arg_18_1]
end

function var_0_0._initManufactureItemBelongBuildingDict(arg_19_0)
	if arg_19_0._belongBuildingDict or arg_19_0._belongBuildingTypeDict then
		return
	end

	arg_19_0._belongBuildingDict = {}
	arg_19_0._belongBuildingTypeDict = {}

	for iter_19_0, iter_19_1 in ipairs(lua_manufacture_building.configList) do
		local var_19_0 = iter_19_1.upgradeGroupId

		if var_19_0 and var_19_0 ~= 0 then
			local var_19_1 = iter_19_1.id
			local var_19_2 = arg_19_0._levelGroupDict[var_19_0] and arg_19_0._levelGroupDict[var_19_0].manufactureItem2LevelDict

			if var_19_2 then
				local var_19_3 = RoomConfig.instance:getBuildingType(var_19_1)

				for iter_19_2, iter_19_3 in pairs(var_19_2) do
					local var_19_4 = arg_19_0._belongBuildingDict[iter_19_2]

					if not var_19_4 then
						var_19_4 = {}
						arg_19_0._belongBuildingDict[iter_19_2] = var_19_4
					end

					var_19_4[#var_19_4 + 1] = var_19_1

					local var_19_5 = arg_19_0._belongBuildingTypeDict[iter_19_2]

					if not var_19_5 then
						arg_19_0._belongBuildingTypeDict[iter_19_2] = var_19_3
					elseif var_19_5 ~= var_19_3 then
						logError(string.format("ManufactureConfig:_initManufactureItemBelongBuildingDict error, buildingType repeated manufactureItemId:%s hasBuildingType:%s newBuildingType:%s", iter_19_2, var_19_5, var_19_3))
					end
				end
			else
				logError(string.format("ManufactureConfig:_initManufactureItemBelongBuildingDict error, no manu2LevelDict, groupId:%s", var_19_0))
			end
		end
	end
end

function var_0_0.getManufactureItemNeedLevel(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0

	if arg_20_0:isManufactureItemBelongBuilding(arg_20_1, arg_20_2) then
		local var_20_1 = arg_20_0:getBuildingUpgradeGroup(arg_20_1)

		var_20_0 = (arg_20_0._levelGroupDict[var_20_1] and arg_20_0._levelGroupDict[var_20_1].manufactureItem2LevelDict)[arg_20_2]
	else
		logError(string.format("ManufactureConfig:getManufactureItemNeedLevel error, can't product, buildingId:%s manufactureItemId:%s", arg_20_1, arg_20_2))
	end

	return var_20_0
end

function var_0_0.getAllManufactureItems(arg_21_0, arg_21_1)
	local var_21_0 = {}
	local var_21_1 = arg_21_0:getBuildingUpgradeGroup(arg_21_1)

	if arg_21_0._levelGroupDict and arg_21_0._levelGroupDict[var_21_1] then
		for iter_21_0, iter_21_1 in pairs(arg_21_0._levelGroupDict[var_21_1].manufactureItem2LevelDict) do
			var_21_0[#var_21_0 + 1] = iter_21_0
		end
	end

	return var_21_0
end

function var_0_0.getAllLevelUnlockInfo(arg_22_0, arg_22_1)
	return arg_22_0._levelUnlockDict[arg_22_1]
end

function var_0_0.getBuildingUpgradeGroup(arg_23_0, arg_23_1)
	local var_23_0 = 0
	local var_23_1 = arg_23_0:getManufactureBuildingCfg(arg_23_1)

	if var_23_1 then
		var_23_0 = var_23_1.upgradeGroupId
	end

	return var_23_0
end

function var_0_0.getBuildingIdsByGroup(arg_24_0, arg_24_1)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs(lua_manufacture_building.configList) do
		if iter_24_1.upgradeGroupId == arg_24_1 then
			table.insert(var_24_0, iter_24_1.id)
		end
	end

	return var_24_0
end

function var_0_0.getTrainsBuildingCos(arg_25_0)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in ipairs(lua_manufacture_building.configList) do
		if arg_25_0:isManufactureBuilding(iter_25_1.id) then
			table.insert(var_25_0, iter_25_1)
		end
	end

	return var_25_0
end

function var_0_0.getBuildingTradeLevelGroup(arg_26_0, arg_26_1)
	local var_26_0 = 0
	local var_26_1 = arg_26_0:getManufactureBuildingCfg(arg_26_1)

	if var_26_1 then
		var_26_0 = var_26_1.tradeGroupId
	end

	return var_26_0
end

function var_0_0.getBuildingCameraIds(arg_27_0, arg_27_1)
	local var_27_0
	local var_27_1 = arg_27_0:getManufactureBuildingCfg(arg_27_1)

	if var_27_1 then
		var_27_0 = var_27_1.cameraIds
	end

	return var_27_0
end

function var_0_0.getBuildingCameraIdByIndex(arg_28_0, arg_28_1, arg_28_2)
	arg_28_2 = arg_28_2 or 1

	local var_28_0 = arg_28_0:getBuildingCameraIds(arg_28_1)
	local var_28_1 = string.splitToNumber(var_28_0, "#")

	return var_28_1 and var_28_1[arg_28_2]
end

function var_0_0.getBuildingSlotCount(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = 0

	if arg_29_2 then
		local var_29_1 = arg_29_0:getBuildingUpgradeGroup(arg_29_1)

		var_29_0 = arg_29_0:getSlotCount(var_29_1, arg_29_2)
	else
		logError("ManufactureConfig:getBuildingSlotCount error, buildingLevel is nil")
	end

	return var_29_0
end

function var_0_0.getBuildingTotalSlotCount(arg_30_0, arg_30_1)
	local var_30_0 = 0
	local var_30_1 = arg_30_0:getBuildingUpgradeGroup(arg_30_1)

	if arg_30_0._levelGroupDict[var_30_1] then
		var_30_0 = arg_30_0._levelGroupDict[var_30_1].maxSlotCount
	end

	return var_30_0
end

function var_0_0.getBuildingMaxLevel(arg_31_0, arg_31_1)
	local var_31_0 = 0
	local var_31_1 = arg_31_0:getBuildingUpgradeGroup(arg_31_1)

	if arg_31_0._levelGroupDict[var_31_1] then
		var_31_0 = arg_31_0._levelGroupDict[var_31_1].maxLevel
	end

	return var_31_0
end

function var_0_0.getBuildingCanPlaceCritterCount(arg_32_0, arg_32_1, arg_32_2)
	local var_32_0 = 0

	if arg_32_2 then
		local var_32_1 = arg_32_0:getBuildingTradeLevelGroup(arg_32_1)

		var_32_0 = arg_32_0:getCritterCount(var_32_1, arg_32_2)
	else
		logError("ManufactureConfig:getBuildingCanPlaceCritterCount error, buildingLevel is nil")
	end

	return var_32_0
end

function var_0_0.getTotalBuildingCritterCount(arg_33_0, arg_33_1)
	local var_33_0 = 0
	local var_33_1 = arg_33_0:getBuildingTradeLevelGroup(arg_33_1)

	if arg_33_0._tradeLevelGroupDict[var_33_1] then
		var_33_0 = arg_33_0._tradeLevelGroupDict[var_33_1].totalCritterCount
	end

	return var_33_0
end

function var_0_0.getRestBuildingSeatSlotCost(arg_34_0, arg_34_1)
	local var_34_0 = {}
	local var_34_1 = arg_34_0:getRestBuildingCfg(arg_34_1, true)

	if var_34_1 then
		local var_34_2 = GameUtil.splitString2(var_34_1.buySlotCost, true)

		if var_34_2 then
			for iter_34_0, iter_34_1 in ipairs(var_34_2) do
				var_34_0[#var_34_0 + 1] = {
					type = iter_34_1[1],
					id = iter_34_1[2],
					quantity = iter_34_1[3]
				}
			end
		end
	end

	return var_34_0
end

function var_0_0.getManufactureBuildingIcon(arg_35_0, arg_35_1)
	local var_35_0
	local var_35_1 = arg_35_0:getManufactureBuildingCfg(arg_35_1)

	if var_35_1 then
		var_35_0 = var_35_1.buildIcon
	end

	return var_35_0
end

function var_0_0.getManufactureBuildingLevelCfg(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	local var_36_0 = lua_manufacture_building_level.configDict[arg_36_1] and lua_manufacture_building_level.configDict[arg_36_1][arg_36_2]

	if not var_36_0 and arg_36_3 then
		logError(string.format("ManufactureConfig:getManufactureBuildingLevelCfg error, cfg is nil, groupId:%s, level:%s", arg_36_1, arg_36_2))
	end

	return var_36_0
end

function var_0_0.getUpgradeCostItemList(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = {}
	local var_37_1 = arg_37_0:getManufactureBuildingLevelCfg(arg_37_1, arg_37_2, true)

	if var_37_1 then
		local var_37_2 = GameUtil.splitString2(var_37_1.cost, true)

		if var_37_2 then
			for iter_37_0, iter_37_1 in ipairs(var_37_2) do
				var_37_0[#var_37_0 + 1] = {
					type = iter_37_1[1],
					id = iter_37_1[2],
					quantity = iter_37_1[3]
				}
			end
		end
	end

	return var_37_0
end

function var_0_0.getNewManufactureItemList(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = {}
	local var_38_1 = arg_38_0:getManufactureBuildingLevelCfg(arg_38_1, arg_38_2, true)

	if var_38_1 then
		var_38_0 = string.splitToNumber(var_38_1.productions, "#")
	end

	return var_38_0
end

function var_0_0.getNeedTradeLevel(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0
	local var_39_1 = arg_39_0:getManufactureBuildingLevelCfg(arg_39_1, arg_39_2, true)

	if var_39_1 then
		var_39_0 = var_39_1.needTradeLevel
	end

	return var_39_0
end

function var_0_0.getSlotCount(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = 0
	local var_40_1 = arg_40_0:getManufactureBuildingLevelCfg(arg_40_1, arg_40_2, true)

	if var_40_1 then
		var_40_0 = var_40_1.slotCount
	end

	return var_40_0
end

function var_0_0.getSlotUnlockNeedLevel(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = 0
	local var_41_1 = lua_manufacture_building_level.configDict[arg_41_1]

	if var_41_1 then
		local var_41_2

		for iter_41_0, iter_41_1 in pairs(var_41_1) do
			if arg_41_2 <= iter_41_1.slotCount and (not var_41_2 or iter_41_0 < var_41_2) then
				var_41_2 = iter_41_0
			end
		end

		var_41_0 = var_41_2 or var_41_0
	end

	return var_41_0
end

function var_0_0.getManufactureBuildingTradeLevelCfg(arg_42_0, arg_42_1, arg_42_2, arg_42_3)
	local var_42_0 = lua_manufacture_building_trade_level.configDict[arg_42_1] and lua_manufacture_building_trade_level.configDict[arg_42_1][arg_42_2]

	if not var_42_0 and arg_42_3 then
		logError(string.format("ManufactureConfig:getManufactureBuildingTradeLevelCfg error, cfg is nil, tradeGroupId:%s, tradeLevel:%s", arg_42_1, arg_42_2))
	end

	return var_42_0
end

function var_0_0.getCritterCount(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = 0

	for iter_43_0 = arg_43_2, 0, -1 do
		local var_43_1 = arg_43_0:getManufactureBuildingTradeLevelCfg(arg_43_1, iter_43_0)

		if var_43_1 then
			var_43_0 = var_43_1.maxCritterCount

			break
		end
	end

	return var_43_0
end

function var_0_0.getManufactureItemCfg(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = lua_manufacture_item.configDict[arg_44_1]

	if not var_44_0 and arg_44_2 then
		logError(string.format("ManufactureConfig:getManufactureItemCfg error, cfg is nil, itemId:%s", arg_44_1))
	end

	return var_44_0
end

function var_0_0.getNeedMatItemList(arg_45_0, arg_45_1)
	local var_45_0 = {}
	local var_45_1 = arg_45_0:getManufactureItemCfg(arg_45_1, true)

	if var_45_1 then
		local var_45_2 = GameUtil.splitString2(var_45_1.needMat, true)

		if var_45_2 then
			for iter_45_0, iter_45_1 in ipairs(var_45_2) do
				var_45_0[#var_45_0 + 1] = {
					id = iter_45_1[1],
					quantity = iter_45_1[2]
				}
			end
		end
	end

	return var_45_0
end

function var_0_0.getItemId(arg_46_0, arg_46_1)
	local var_46_0
	local var_46_1 = arg_46_0:getManufactureItemCfg(arg_46_1, true)

	if var_46_1 then
		var_46_0 = var_46_1.itemId
	end

	return var_46_0
end

function var_0_0.getUnitCount(arg_47_0, arg_47_1)
	local var_47_0 = 0
	local var_47_1 = arg_47_0:getManufactureItemCfg(arg_47_1, true)

	if var_47_1 then
		var_47_0 = var_47_1.unitCount
	end

	return var_47_0
end

function var_0_0.getNeedTime(arg_48_0, arg_48_1)
	local var_48_0 = 0
	local var_48_1 = arg_48_0:getManufactureItemCfg(arg_48_1, true)

	if var_48_1 then
		var_48_0 = var_48_1.needTime
	end

	return var_48_0
end

function var_0_0.getBatchIconPath(arg_49_0, arg_49_1)
	local var_49_0
	local var_49_1 = arg_49_0:getManufactureItemCfg(arg_49_1, true)

	if var_49_1 and not string.nilorempty(var_49_1.batchIcon) then
		var_49_0 = ResUrl.getPropItemIcon(var_49_1.batchIcon)
	end

	return var_49_0
end

function var_0_0.getBatchName(arg_50_0, arg_50_1)
	local var_50_0
	local var_50_1 = arg_50_0:getManufactureItemCfg(arg_50_1, true)

	if var_50_1 then
		var_50_0 = var_50_1.batchName
	end

	return var_50_0
end

function var_0_0.getManufactureItemName(arg_51_0, arg_51_1)
	local var_51_0 = arg_51_0:getBatchName(arg_51_1)

	if string.nilorempty(var_51_0) then
		local var_51_1 = arg_51_0:getItemId(arg_51_1)

		var_51_0 = ItemConfig.instance:getItemNameById(var_51_1)
	end

	return var_51_0
end

function var_0_0.getManufactureItemListByItemId(arg_52_0, arg_52_1)
	return arg_52_0._itemId2ManufactureItemDict and arg_52_0._itemId2ManufactureItemDict[arg_52_1] or {}
end

function var_0_0.getManufactureItemUnitCountRange(arg_53_0, arg_53_1)
	local var_53_0 = arg_53_0:getUnitCount(arg_53_1)
	local var_53_1 = arg_53_0:getUnitCount(arg_53_1)
	local var_53_2 = arg_53_0:getItemId(arg_53_1)
	local var_53_3 = arg_53_0:getManufactureItemListByItemId(var_53_2)

	for iter_53_0, iter_53_1 in ipairs(var_53_3) do
		local var_53_4 = arg_53_0:getUnitCount(iter_53_1)

		var_53_0 = math.max(var_53_0, var_53_4)
		var_53_1 = math.min(var_53_1, var_53_4)
	end

	return var_53_0, var_53_1
end

var_0_0.instance = var_0_0.New()

return var_0_0
