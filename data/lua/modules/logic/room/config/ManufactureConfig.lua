module("modules.logic.room.config.ManufactureConfig", package.seeall)

slot0 = class("ManufactureConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
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

function slot0.onInit(slot0)
	slot0._levelGroupDict = {}
	slot0._tradeLevelGroupDict = {}
	slot0._belongBuildingDict = nil
	slot0._belongBuildingTypeDict = nil
	slot0._itemId2ManufactureItemDict = nil
	slot0._levelUnlockDict = {}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot0[string.format("%sConfigLoaded", slot1)] then
		slot4(slot0, slot2)
	end
end

function slot0.manufacture_itemConfigLoaded(slot0, slot1)
	slot0._itemId2ManufactureItemDict = {}

	for slot5, slot6 in pairs(slot1.configList) do
		if not slot0._itemId2ManufactureItemDict[slot6.itemId] then
			slot0._itemId2ManufactureItemDict[slot7] = {}
		end

		table.insert(slot8, slot5)
	end
end

function slot0.trade_levelConfigLoaded(slot0, slot1)
	if not slot0._systemUnlockLevel then
		slot0._systemUnlockLevel = {}
	end

	for slot5, slot6 in pairs(slot1.configList) do
		if not string.nilorempty(slot6.unlockId) then
			for slot11, slot12 in ipairs(string.splitToNumber(slot6.unlockId, "#")) do
				slot0._systemUnlockLevel[slot12] = slot6.level
			end
		end
	end
end

function slot0.manufacture_buildingConfigLoaded(slot0, slot1)
	for slot5, slot6 in pairs(slot1.configList) do
		if not slot0._levelUnlockDict[slot6.placeTradeLevel] then
			slot0._levelUnlockDict[slot7] = {}
		end

		if not slot8[RoomTradeEnum.LevelUnlock.NewBuilding] then
			slot8[RoomTradeEnum.LevelUnlock.NewBuilding] = {}
		end

		table.insert(slot9, slot6.id)
	end
end

function slot0.manufacture_building_levelConfigLoaded(slot0, slot1)
	slot0._levelGroupDict = {}

	for slot5, slot6 in pairs(slot1.configDict) do
		slot7 = {
			maxLevel = 0,
			maxSlotCount = 0,
			manufactureItem2LevelDict = {}
		}

		for slot11, slot12 in pairs(slot6) do
			if slot7.maxLevel < slot11 then
				slot7.maxLevel = slot11
			end

			if slot7.maxSlotCount < slot12.slotCount then
				slot7.maxSlotCount = slot13
			end

			for slot18, slot19 in ipairs(string.splitToNumber(slot12.productions, "#")) do
				slot7.manufactureItem2LevelDict[slot19] = slot11
			end

			if not slot0._levelUnlockDict[slot12.needTradeLevel] then
				slot0._levelUnlockDict[slot15] = {}
			end

			if not slot16[RoomTradeEnum.LevelUnlock.BuildingMaxLevel] then
				slot16[RoomTradeEnum.LevelUnlock.BuildingMaxLevel] = {}
			end

			if slot11 > 1 then
				table.insert(slot17, {
					groupId = slot5,
					Level = slot11
				})
			end
		end

		slot0._levelGroupDict[slot5] = slot7
	end
end

function slot0.manufacture_building_trade_levelConfigLoaded(slot0, slot1)
	slot0._tradeLevelGroupDict = {}

	for slot5, slot6 in pairs(slot1.configDict) do
		slot7 = {
			totalCritterCount = 0
		}

		for slot11, slot12 in pairs(slot6) do
			if slot7.totalCritterCount < slot12.maxCritterCount then
				slot7.totalCritterCount = slot13
			end
		end

		slot0._tradeLevelGroupDict[slot5] = slot7
	end
end

function slot0.getManufactureConstCfg(slot0, slot1, slot2)
	slot3 = nil

	if slot1 then
		slot3 = lua_manufacture_const.configDict[slot1]
	end

	if not slot3 and slot2 then
		logError(string.format("ManufactureConfig:getManufactureConstCfg error, cfg is nil, constId:%s", slot1))
	end

	return slot3
end

function slot0.getManufactureConst(slot0, slot1)
	slot2 = nil

	if slot0:getManufactureConstCfg(slot1, true) then
		slot2 = slot3.value
	end

	return slot2
end

function slot0.getTradeLevelCfg(slot0, slot1, slot2)
	if not lua_trade_level.configDict[slot1] and slot2 then
		logError(string.format("ManufactureConfig:getTradeLevelCfg error, cfg is nil, level:%s", slot1))
	end

	return slot3
end

function slot0.getUnlockSystemTradeLevel(slot0, slot1, slot2)
	return slot0._systemUnlockLevel[slot1]
end

function slot0.getManufactureBuildingCfg(slot0, slot1, slot2)
	if not lua_manufacture_building.configDict[slot1] and slot2 then
		logError(string.format("ManufactureConfig:getManufactureBuildingCfg error, cfg is nil, buildingId:%s", slot1))
	end

	return slot3
end

function slot0.getRestBuildingCfg(slot0, slot1, slot2)
	if not lua_rest_building.configDict[slot1] and slot2 then
		logError(string.format("ManufactureConfig:getRestBuildingCfg error, cfg is nil, buildingId:%s", slot1))
	end

	return slot3
end

function slot0.isManufactureBuilding(slot0, slot1)
	slot2 = false

	if RoomConfig.instance:getBuildingType(slot1) == RoomBuildingEnum.BuildingType.Collect or slot3 == RoomBuildingEnum.BuildingType.Process or slot3 == RoomBuildingEnum.BuildingType.Manufacture then
		slot2 = true
	end

	return slot2
end

function slot0.isManufactureItemBelongBuilding(slot0, slot1, slot2)
	slot3 = false

	if (slot0._levelGroupDict[slot0:getBuildingUpgradeGroup(slot1)] and slot0._levelGroupDict[slot4].manufactureItem2LevelDict)[slot2] then
		slot3 = true
	end

	return slot3
end

function slot0.getManufactureItemBelongBuildingList(slot0, slot1)
	slot0:_initManufactureItemBelongBuildingDict()

	return slot0._belongBuildingDict[slot1] or {}
end

function slot0.getManufactureItemBelongBuildingType(slot0, slot1)
	slot0:_initManufactureItemBelongBuildingDict()

	return slot0._belongBuildingTypeDict[slot1]
end

function slot0._initManufactureItemBelongBuildingDict(slot0)
	if slot0._belongBuildingDict or slot0._belongBuildingTypeDict then
		return
	end

	slot0._belongBuildingDict = {}
	slot0._belongBuildingTypeDict = {}

	for slot4, slot5 in ipairs(lua_manufacture_building.configList) do
		if slot5.upgradeGroupId and slot6 ~= 0 then
			if slot0._levelGroupDict[slot6] and slot0._levelGroupDict[slot6].manufactureItem2LevelDict then
				slot9 = RoomConfig.instance:getBuildingType(slot5.id)

				for slot13, slot14 in pairs(slot8) do
					if not slot0._belongBuildingDict[slot13] then
						slot0._belongBuildingDict[slot13] = {}
					end

					slot15[#slot15 + 1] = slot7

					if not slot0._belongBuildingTypeDict[slot13] then
						slot0._belongBuildingTypeDict[slot13] = slot9
					elseif slot16 ~= slot9 then
						logError(string.format("ManufactureConfig:_initManufactureItemBelongBuildingDict error, buildingType repeated manufactureItemId:%s hasBuildingType:%s newBuildingType:%s", slot13, slot16, slot9))
					end
				end
			else
				logError(string.format("ManufactureConfig:_initManufactureItemBelongBuildingDict error, no manu2LevelDict, groupId:%s", slot6))
			end
		end
	end
end

function slot0.getManufactureItemNeedLevel(slot0, slot1, slot2)
	slot3 = nil

	if slot0:isManufactureItemBelongBuilding(slot1, slot2) then
		slot3 = (slot0._levelGroupDict[slot0:getBuildingUpgradeGroup(slot1)] and slot0._levelGroupDict[slot5].manufactureItem2LevelDict)[slot2]
	else
		logError(string.format("ManufactureConfig:getManufactureItemNeedLevel error, can't product, buildingId:%s manufactureItemId:%s", slot1, slot2))
	end

	return slot3
end

function slot0.getAllManufactureItems(slot0, slot1)
	slot2 = {}
	slot3 = slot0:getBuildingUpgradeGroup(slot1)

	if slot0._levelGroupDict and slot0._levelGroupDict[slot3] then
		for slot7, slot8 in pairs(slot0._levelGroupDict[slot3].manufactureItem2LevelDict) do
			slot2[#slot2 + 1] = slot7
		end
	end

	return slot2
end

function slot0.getAllLevelUnlockInfo(slot0, slot1)
	return slot0._levelUnlockDict[slot1]
end

function slot0.getBuildingUpgradeGroup(slot0, slot1)
	slot2 = 0

	if slot0:getManufactureBuildingCfg(slot1) then
		slot2 = slot3.upgradeGroupId
	end

	return slot2
end

function slot0.getBuildingIdsByGroup(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(lua_manufacture_building.configList) do
		if slot7.upgradeGroupId == slot1 then
			table.insert(slot2, slot7.id)
		end
	end

	return slot2
end

function slot0.getTrainsBuildingCos(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(lua_manufacture_building.configList) do
		if slot0:isManufactureBuilding(slot6.id) then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.getBuildingTradeLevelGroup(slot0, slot1)
	slot2 = 0

	if slot0:getManufactureBuildingCfg(slot1) then
		slot2 = slot3.tradeGroupId
	end

	return slot2
end

function slot0.getBuildingCameraIds(slot0, slot1)
	slot2 = nil

	if slot0:getManufactureBuildingCfg(slot1) then
		slot2 = slot3.cameraIds
	end

	return slot2
end

function slot0.getBuildingCameraIdByIndex(slot0, slot1, slot2)
	return string.splitToNumber(slot0:getBuildingCameraIds(slot1), "#") and slot4[slot2 or 1]
end

function slot0.getBuildingSlotCount(slot0, slot1, slot2)
	slot3 = 0

	if slot2 then
		slot3 = slot0:getSlotCount(slot0:getBuildingUpgradeGroup(slot1), slot2)
	else
		logError("ManufactureConfig:getBuildingSlotCount error, buildingLevel is nil")
	end

	return slot3
end

function slot0.getBuildingTotalSlotCount(slot0, slot1)
	slot2 = 0

	if slot0._levelGroupDict[slot0:getBuildingUpgradeGroup(slot1)] then
		slot2 = slot0._levelGroupDict[slot3].maxSlotCount
	end

	return slot2
end

function slot0.getBuildingMaxLevel(slot0, slot1)
	slot2 = 0

	if slot0._levelGroupDict[slot0:getBuildingUpgradeGroup(slot1)] then
		slot2 = slot0._levelGroupDict[slot3].maxLevel
	end

	return slot2
end

function slot0.getBuildingCanPlaceCritterCount(slot0, slot1, slot2)
	slot3 = 0

	if slot2 then
		slot3 = slot0:getCritterCount(slot0:getBuildingTradeLevelGroup(slot1), slot2)
	else
		logError("ManufactureConfig:getBuildingCanPlaceCritterCount error, buildingLevel is nil")
	end

	return slot3
end

function slot0.getTotalBuildingCritterCount(slot0, slot1)
	slot2 = 0

	if slot0._tradeLevelGroupDict[slot0:getBuildingTradeLevelGroup(slot1)] then
		slot2 = slot0._tradeLevelGroupDict[slot3].totalCritterCount
	end

	return slot2
end

function slot0.getRestBuildingSeatSlotCost(slot0, slot1)
	slot2 = {}

	if slot0:getRestBuildingCfg(slot1, true) and GameUtil.splitString2(slot3.buySlotCost, true) then
		for slot8, slot9 in ipairs(slot4) do
			slot2[#slot2 + 1] = {
				type = slot9[1],
				id = slot9[2],
				quantity = slot9[3]
			}
		end
	end

	return slot2
end

function slot0.getManufactureBuildingIcon(slot0, slot1)
	slot2 = nil

	if slot0:getManufactureBuildingCfg(slot1) then
		slot2 = slot3.buildIcon
	end

	return slot2
end

function slot0.getManufactureBuildingLevelCfg(slot0, slot1, slot2, slot3)
	if not (lua_manufacture_building_level.configDict[slot1] and lua_manufacture_building_level.configDict[slot1][slot2]) and slot3 then
		logError(string.format("ManufactureConfig:getManufactureBuildingLevelCfg error, cfg is nil, groupId:%s, level:%s", slot1, slot2))
	end

	return slot4
end

function slot0.getUpgradeCostItemList(slot0, slot1, slot2)
	slot3 = {}

	if slot0:getManufactureBuildingLevelCfg(slot1, slot2, true) and GameUtil.splitString2(slot4.cost, true) then
		for slot9, slot10 in ipairs(slot5) do
			slot3[#slot3 + 1] = {
				type = slot10[1],
				id = slot10[2],
				quantity = slot10[3]
			}
		end
	end

	return slot3
end

function slot0.getNewManufactureItemList(slot0, slot1, slot2)
	slot3 = {}

	if slot0:getManufactureBuildingLevelCfg(slot1, slot2, true) then
		slot3 = string.splitToNumber(slot4.productions, "#")
	end

	return slot3
end

function slot0.getNeedTradeLevel(slot0, slot1, slot2)
	slot3 = nil

	if slot0:getManufactureBuildingLevelCfg(slot1, slot2, true) then
		slot3 = slot4.needTradeLevel
	end

	return slot3
end

function slot0.getSlotCount(slot0, slot1, slot2)
	slot3 = 0

	if slot0:getManufactureBuildingLevelCfg(slot1, slot2, true) then
		slot3 = slot4.slotCount
	end

	return slot3
end

function slot0.getSlotUnlockNeedLevel(slot0, slot1, slot2)
	slot3 = 0

	if lua_manufacture_building_level.configDict[slot1] then
		slot5 = nil

		for slot9, slot10 in pairs(slot4) do
			if slot2 <= slot10.slotCount and (not slot5 or slot9 < slot5) then
				slot5 = slot9
			end
		end

		slot3 = slot5 or slot3
	end

	return slot3
end

function slot0.getManufactureBuildingTradeLevelCfg(slot0, slot1, slot2, slot3)
	if not (lua_manufacture_building_trade_level.configDict[slot1] and lua_manufacture_building_trade_level.configDict[slot1][slot2]) and slot3 then
		logError(string.format("ManufactureConfig:getManufactureBuildingTradeLevelCfg error, cfg is nil, tradeGroupId:%s, tradeLevel:%s", slot1, slot2))
	end

	return slot4
end

function slot0.getCritterCount(slot0, slot1, slot2)
	slot3 = 0

	for slot7 = slot2, 0, -1 do
		if slot0:getManufactureBuildingTradeLevelCfg(slot1, slot7) then
			slot3 = slot8.maxCritterCount

			break
		end
	end

	return slot3
end

function slot0.getManufactureItemCfg(slot0, slot1, slot2)
	if not lua_manufacture_item.configDict[slot1] and slot2 then
		logError(string.format("ManufactureConfig:getManufactureItemCfg error, cfg is nil, itemId:%s", slot1))
	end

	return slot3
end

function slot0.getNeedMatItemList(slot0, slot1)
	slot2 = {}

	if slot0:getManufactureItemCfg(slot1, true) and GameUtil.splitString2(slot3.needMat, true) then
		for slot8, slot9 in ipairs(slot4) do
			slot2[#slot2 + 1] = {
				id = slot9[1],
				quantity = slot9[2]
			}
		end
	end

	return slot2
end

function slot0.getItemId(slot0, slot1)
	slot2 = nil

	if slot0:getManufactureItemCfg(slot1, true) then
		slot2 = slot3.itemId
	end

	return slot2
end

function slot0.getUnitCount(slot0, slot1)
	slot2 = 0

	if slot0:getManufactureItemCfg(slot1, true) then
		slot2 = slot3.unitCount
	end

	return slot2
end

function slot0.getNeedTime(slot0, slot1)
	slot2 = 0

	if slot0:getManufactureItemCfg(slot1, true) then
		slot2 = slot3.needTime
	end

	return slot2
end

function slot0.getBatchIconPath(slot0, slot1)
	slot2 = nil

	if slot0:getManufactureItemCfg(slot1, true) and not string.nilorempty(slot3.batchIcon) then
		slot2 = ResUrl.getPropItemIcon(slot3.batchIcon)
	end

	return slot2
end

function slot0.getBatchName(slot0, slot1)
	slot2 = nil

	if slot0:getManufactureItemCfg(slot1, true) then
		slot2 = slot3.batchName
	end

	return slot2
end

function slot0.getManufactureItemName(slot0, slot1)
	if string.nilorempty(slot0:getBatchName(slot1)) then
		slot2 = ItemConfig.instance:getItemNameById(slot0:getItemId(slot1))
	end

	return slot2
end

function slot0.getManufactureItemListByItemId(slot0, slot1)
	return slot0._itemId2ManufactureItemDict and slot0._itemId2ManufactureItemDict[slot1] or {}
end

function slot0.getManufactureItemUnitCountRange(slot0, slot1)
	for slot9, slot10 in ipairs(slot0:getManufactureItemListByItemId(slot0:getItemId(slot1))) do
		slot11 = slot0:getUnitCount(slot10)
		slot2 = math.max(slot0:getUnitCount(slot1), slot11)
		slot3 = math.min(slot0:getUnitCount(slot1), slot11)
	end

	return slot2, slot3
end

slot0.instance = slot0.New()

return slot0
