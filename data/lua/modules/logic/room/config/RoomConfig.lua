module("modules.logic.room.config.RoomConfig", package.seeall)

slot0 = class("RoomConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._taskConfig = nil
	slot0._resourceConfig = nil
	slot0._roomBuildingConfig = nil
	slot0._roomBuildingTypeConfig = nil
	slot0._formulaConfig = nil
	slot0._levelGroupConfig = nil
	slot0._formulaShowTypeConfig = nil
	slot0._blockRandomEventConfig = nil
	slot0._roomLevelConfig = nil
	slot0._roomCharacterConfig = nil
	slot0._blockPackageConfig = nil
	slot0._initBuildingOccupyDict = nil
	slot0._taskFinishRewardDict = nil
	slot0._blockPackageDataConfig = nil
	slot0._productionPartConfig = nil
	slot0._productionLineToPart = nil
	slot0._sceneTaskConfig = nil
	slot0._blockId2PackageIdDict = nil
	slot0._specialBlockConfig = nil
	slot0._heroId2SpecialBlockIdDict = nil
	slot0._roomCharacterInteractionConfig = nil
	slot0._roomCharacterInteractionConfigHeroDict = nil
	slot0._roomCharacterDialogConfig = nil
	slot0._roomThemeConfig = nil
	slot0._roomCharacterDialogSelectConfig = nil
	slot0._roomVehicleConfig = nil
	slot0._roomSourcesTypeConfig = nil
	slot0._roomCharacterAnimConfig = nil
	slot0._roomAudioExtendConfig = nil
	slot0._roomCameraParamsConfig = nil
	slot0._roomCharacterBuildingInteractCameraConfig = nil
	slot0.roomCharacterShadowConfig = nil
	slot0._roomLayoutPlanCoverConfig = nil
	slot0._building2AtmosphereIds = nil
	slot0._roomSceneAmbientConfig = nil
	slot0._roomType2SkinsDict = nil
	slot0._unlockItem2RoomSkinList = nil
	slot0._blockId2WaterReformTypeDict = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"block_task",
		"block_resource",
		"room_building",
		"room_building_area",
		"formula",
		"room_building_level",
		"room_building_skin",
		"room_interact_building",
		"formula_showtype",
		"block_random_event",
		"room_level",
		"room_character",
		"task_room",
		"block_package",
		"block_package_data",
		"block",
		"block_init",
		"production_part",
		"production_line",
		"production_line_level",
		"building_bonus",
		"special_block",
		"room_character_interaction",
		"room_character_dialog",
		"room_character_dialog_select",
		"room_theme",
		"room_vehicle",
		"room_sources_type",
		"room_character_anim",
		"block_place_position",
		"room_audio_extend",
		"room_camera_params",
		"room_character_building_interact_camera",
		"room_character_shadow",
		"room_character_interaction_effect",
		"room_layout_plan_cover",
		"room_atmosphere",
		"room_effect",
		"room_scene_ambient",
		"room_water_reform",
		"room_skin",
		"room_building_occupy",
		"room_building_type"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "block_task" then
		slot0._taskConfig = slot2
	elseif slot1 == "block_resource" then
		slot0._resourceConfig = slot2

		slot0:_initBlockResource(slot2)
	elseif slot1 == "room_building" then
		slot0._roomBuildingConfig = slot2
	elseif slot1 == "room_building_area" then
		slot0._roomBuildingAreaConfig = slot2
	elseif slot1 == "formula" then
		slot0:initFormulaConfig(slot2)
	elseif slot1 == "room_building_level" then
		slot0._levelGroupConfig = slot2
	elseif slot1 == "room_building_skin" then
		slot0:_initBuildingSkinConfig(slot2)
	elseif slot1 == "room_interact_building" then
		slot0._roomInteractBuildingConfig = slot2
	elseif slot1 == "formula_showtype" then
		slot0._formulaShowTypeConfig = slot2
	elseif slot1 == "block_random_event" then
		slot0._blockRandomEventConfig = slot2
	elseif slot1 == "room_level" then
		slot0._roomLevelConfig = slot2
	elseif slot1 == "room_character" then
		slot0._roomCharacterConfig = slot2
	elseif slot1 == "task_room" then
		slot0._sceneTaskConfig = slot2
	elseif slot1 == "block_package" then
		slot0._blockPackageConfig = slot2
	elseif slot1 == "block_package_data" then
		slot0._blockPackageDataConfig = slot2
	elseif slot1 == "block" then
		slot0._blockDefineConfig = slot2
	elseif slot1 == "block_init" then
		slot0._blockInitConfig = slot2
	elseif slot1 == "production_part" then
		slot0:initProductionPart(slot2)
	elseif slot1 == "production_line" then
		slot0._productionLineConfig = slot2
	elseif slot1 == "production_line_level" then
		slot0._productionLineLevelConfig = slot2
	elseif slot1 == "building_bonus" then
		slot0._buildingBonusConfig = slot2
	elseif slot1 == "special_block" then
		slot0:_initSpecialBlock(slot2)
	elseif slot1 == "room_character_interaction" then
		slot0._roomCharacterInteractionConfig = slot2
	elseif slot1 == "room_character_dialog" then
		slot0._roomCharacterDialogConfig = slot2
	elseif slot1 == "room_character_dialog_select" then
		slot0._roomCharacterDialogSelectConfig = slot2
	elseif slot1 == "room_theme" then
		slot0:_initTheme(slot2)
	elseif slot1 == "room_vehicle" then
		slot0._roomVehicleConfig = slot2
	elseif slot1 == "room_sources_type" then
		slot0._roomSourcesTypeConfig = slot2.configDict
	elseif slot1 == "room_character_anim" then
		slot0._roomCharacterAnimConfig = slot2
	elseif slot1 == "block_place_position" then
		slot0._blockPlacePositionConfig = slot2
	elseif slot1 == "room_audio_extend" then
		slot0._roomAudioExtendConfig = slot2
	elseif slot1 == "room_camera_params" then
		slot0:_initCameraParam(slot2)
	elseif slot1 == "room_character_building_interact_camera" then
		slot0._roomCharacterBuildingInteractCameraConfig = slot2
	elseif slot1 == "room_character_shadow" then
		slot0.roomCharacterShadowConfig = slot2
	elseif slot1 == "room_character_interaction_effect" then
		slot0._roomCharacterEffectConfig = slot2
	elseif slot1 == "room_layout_plan_cover" then
		slot0._roomLayoutPlanCoverConfig = slot2
	elseif slot1 == "room_atmosphere" then
		slot0:_initAtmosphereCfg(slot2)
	elseif slot1 == "room_scene_ambient" then
		slot0._roomSceneAmbientConfig = slot2
	elseif slot1 == "room_skin" then
		slot0:_initRoomSkinCfg(slot2)
	end
end

function slot0._toListDictByKeyName(slot0, slot1, slot2)
	slot3 = {}

	for slot7, slot8 in ipairs(slot1) do
		if not slot3[slot8[slot2]] then
			slot3[slot9] = {}
		end

		table.insert(slot3[slot9], slot8)
	end

	return slot3
end

function slot0.initProductionPart(slot0, slot1)
	slot0._productionPartConfig = slot1
	slot0._productionLineToPart = {}

	for slot5, slot6 in pairs(slot1.configDict) do
		for slot10, slot11 in pairs(slot6.productionLines) do
			slot0._productionLineToPart[slot11] = slot5
		end
	end
end

function slot0._initSpecialBlock(slot0, slot1)
	slot0._heroId2SpecialBlockIdDict = {}
	slot0._specialBlockConfig = slot1

	for slot5, slot6 in ipairs(slot1.configList) do
		slot0._heroId2SpecialBlockIdDict[slot6.heroId] = slot6.id
	end
end

function slot0.initFormulaConfig(slot0, slot1)
	slot0._formulaConfig = slot1
	slot0.item2FormulaIdDic = {}

	for slot5, slot6 in pairs(slot1.configDict) do
		if slot6.type == 2 and RoomProductionHelper.getFormulaProduceItem(slot5, slot6) then
			if not slot0.item2FormulaIdDic[slot7.type] then
				slot0.item2FormulaIdDic[slot7.type] = {}
			end

			slot0.item2FormulaIdDic[slot7.type][slot7.id] = slot5
		end
	end
end

function slot0.getItemFormulaId(slot0, slot1, slot2)
	slot3 = 0

	if slot0.item2FormulaIdDic[slot1] then
		slot3 = slot0.item2FormulaIdDic[slot1][slot2] or 0
	end

	return slot3
end

function slot0._initTheme(slot0, slot1)
	slot0._roomThemeConfig = slot1
	slot0._itemIdToRoomThemeId = {}
	slot0._roomThemeToItemList = {}
	slot0._roomThemeCollectionBonusDic = {}

	for slot6, slot7 in pairs({
		building = MaterialEnum.MaterialType.Building,
		package = MaterialEnum.MaterialType.BlockPackage,
		extraShowBuilding = MaterialEnum.MaterialType.Building
	}) do
		slot0._itemIdToRoomThemeId[slot7] = {}
	end

	slot0._itemIdToRoomThemeId[MaterialEnum.MaterialType.RoomTheme] = {}

	for slot7, slot8 in pairs(slot1.configDict) do
		slot0._roomThemeToItemList[slot7] = {
			building = GameUtil.splitString2(slot8.building, true) or {},
			package = GameUtil.splitString2(slot8.packages, true) or {},
			extraShowBuilding = GameUtil.splitString2(slot8.extraShowBuilding, true) or {}
		}
		slot3[slot7] = slot7

		for slot13, slot14 in pairs(slot2) do
			for slot19, slot20 in ipairs(slot9[slot13]) do
				slot0._itemIdToRoomThemeId[slot14][slot20[1]] = slot7
			end
		end

		if not string.nilorempty(slot8.collectionBonus) then
			slot0._roomThemeCollectionBonusDic[slot8.id] = GameUtil.splitString2(slot8.collectionBonus, true)
		end
	end
end

function slot0._initBlockResource(slot0, slot1)
	slot0._resourceParamCofig = {}
	slot0._resourceLightDict = {}

	for slot6, slot7 in ipairs(slot1.configList) do
		if slot7.placeBuilding then
			slot0._resourceParamCofig[slot7.id] = {
				placeBuilding = string.splitToNumber(slot7.placeBuilding, "#")
			}
		end

		slot0._resourceLightDict[slot7.id] = slot7.blockLight == 1
	end
end

function slot0._initCameraParam(slot0, slot1)
	slot0._roomCameraParamsConfig = slot1
	slot0._cameraParamsConfigDefauleDict = {}

	for slot6, slot7 in ipairs(slot1.configList) do
		if not slot0._cameraParamsConfigDefauleDict[slot7.state] or slot7.gameMode == 0 then
			slot0._cameraParamsConfigDefauleDict[slot7.state] = slot7
		end
	end
end

function slot0._initAtmosphereCfg(slot0, slot1)
	slot0._building2AtmosphereIds = {}

	for slot6, slot7 in ipairs(slot1.configList) do
		if not slot0._building2AtmosphereIds[slot7.buildingId] then
			slot0._building2AtmosphereIds[slot8] = {}
		end

		slot9[#slot9 + 1] = slot7.id
	end
end

function slot0._initRoomSkinCfg(slot0, slot1)
	slot0._roomType2SkinsDict = {}
	slot0._unlockItem2RoomSkinList = {}

	for slot6, slot7 in ipairs(slot1.configList) do
		if not slot0._roomType2SkinsDict[slot7.type] then
			slot0._roomType2SkinsDict[slot8] = {}
		end

		slot9[#slot9 + 1] = slot7.id

		if not slot0._unlockItem2RoomSkinList[slot7.itemId] then
			slot0._unlockItem2RoomSkinList[slot10] = {}
		end

		slot11[#slot11 + 1] = slot7.id
	end
end

function slot0.getCameraParamByStateId(slot0, slot1, slot2)
	if slot2 and slot2 ~= 0 then
		for slot7 = 1, #slot0._roomCameraParamsConfig.configList do
			if slot3[slot7].state == slot1 and slot8.gameMode == slot2 then
				return slot8
			end
		end
	end

	return slot0._cameraParamsConfigDefauleDict[slot1]
end

function slot0.getCharacterBuildingInteractCameraConfig(slot0, slot1)
	return slot0._roomCharacterBuildingInteractCameraConfig.configDict[slot1]
end

function slot0.getCharacterEffectList(slot0, slot1)
	if not slot0._roomCharacterSkinEffectDict then
		slot0._roomCharacterSkinEffectDict = {}
		slot0._roomCharacterSkinAnimEffectDict = {}
		slot2 = slot0._roomCharacterSkinEffectDict

		for slot6, slot7 in ipairs(slot0._roomCharacterEffectConfig.configList) do
			if not slot2[slot7.skinId] then
				slot2[slot7.skinId] = {}
				slot0._roomCharacterSkinAnimEffectDict[slot7.skinId] = {}
			end

			table.insert(slot2[slot7.skinId], slot7)

			if not slot0._roomCharacterSkinAnimEffectDict[slot7.skinId][slot7.animName] then
				slot8[slot7.animName] = {}
			end

			table.insert(slot8[slot7.animName], slot7)
		end
	end

	return slot0._roomCharacterSkinEffectDict[slot1]
end

function slot0.getCharacterEffectListByAnimName(slot0, slot1, slot2)
	if not slot0._roomCharacterSkinAnimEffectDict then
		slot0:getCharacterEffectList(slot1)
	end

	return slot0._roomCharacterSkinAnimEffectDict[slot1] and slot0._roomCharacterSkinAnimEffectDict[slot1][slot2]
end

function slot0.getTaskConfig(slot0, slot1)
	return slot0._taskConfig.configDict[slot1]
end

function slot0.getResourceConfig(slot0, slot1)
	return slot0._resourceConfig.configDict[slot1]
end

function slot0.getResourceParam(slot0, slot1)
	return slot0._resourceParamCofig[slot1]
end

function slot0.isLightByResourceId(slot0, slot1)
	return slot0._resourceLightDict[slot1]
end

function slot0.getBuildingConfig(slot0, slot1)
	return slot0._roomBuildingConfig.configDict[slot1]
end

function slot0.getBuildingType(slot0, slot1)
	slot2 = nil

	if slot0:getBuildingConfig(slot1) then
		slot2 = slot3.buildingType
	end

	return slot2
end

function slot0.getBuildingAreaConfig(slot0, slot1)
	return slot0._roomBuildingAreaConfig.configDict[slot1]
end

function slot1(slot0, slot1)
	slot2 = nil

	if not lua_room_building_occupy.configDict[slot0] and slot1 then
		logError(string.format("RoomConfig.GetOccupyCfg Error,cfg is nil, id%s", slot0))
	end

	return slot2
end

function slot0.getBuildingOccupyList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(lua_room_building_occupy.configList) do
		slot1[#slot1 + 1] = slot6.id
	end

	return slot1
end

function slot0.getBuildingOccupyIcon(slot0, slot1)
	slot2 = nil

	if uv0(slot1, true) then
		slot2 = slot3.icon
	end

	return slot2
end

function slot0.getBuildingOccupyNum(slot0, slot1)
	slot2 = nil

	if uv0(slot1, true) then
		slot2 = slot3.occupyNum
	end

	return slot2
end

function slot0.getFormulaConfig(slot0, slot1)
	return slot0._formulaConfig.configDict[slot1]
end

function slot0.getBlockPackageConfig(slot0, slot1)
	return slot0._blockPackageConfig.configDict[slot1]
end

function slot0.getBlockPackageFullDegree(slot0, slot1)
	return slot0:getBlockPackageConfig(slot1).blockBuildDegree * #slot0:getBlockListByPackageId(slot1)
end

function slot0.getLevelGroupConfig(slot0, slot1, slot2)
	return slot0._levelGroupConfig.configDict[slot1] and slot0._levelGroupConfig.configDict[slot1][slot2]
end

function slot0.getLevelGroupInfo(slot0, slot1, slot2)
	if slot0._levelGroupConfig.configDict[slot1] and slot0._levelGroupConfig.configDict[slot1][slot2] then
		-- Nothing
	end

	if slot4 or slot0._levelGroupConfig.configDict[slot1] and slot0._levelGroupConfig.configDict[slot1][1] then
		slot3.name = slot4.name
		slot3.nameEn = slot4.nameEn
		slot3.icon = slot4.icon
	end

	return {
		desc = slot4.desc
	}
end

function slot0.getLevelGroupLevelDict(slot0, slot1)
	return slot0._levelGroupConfig.configDict[slot1] and slot0._levelGroupConfig.configDict[slot1]
end

function slot0.getLevelGroupMaxLevel(slot0, slot1)
	slot3 = 0

	if slot0._levelGroupConfig.configDict[slot1] then
		for slot7, slot8 in pairs(slot2) do
			if slot3 < slot7 then
				slot3 = slot7
			end
		end
	end

	return slot3
end

function slot0._initBuildingSkinConfig(slot0, slot1)
	slot0._buildingSkinCongfig = slot1
	slot0._buildingSkinListDict = {}

	for slot6, slot7 in ipairs(slot1.configList) do
		if not slot0._buildingSkinListDict[slot7.buildingId] then
			slot0._buildingSkinListDict[slot7.buildingId] = {}
		end

		table.insert(slot0._buildingSkinListDict[slot7.buildingId], slot7)
	end
end

function slot0.getBuildingSkinConfig(slot0, slot1)
	return slot0._buildingSkinCongfig and slot0._buildingSkinCongfig.configDict[slot1]
end

function slot0.getAllBuildingSkinList(slot0)
	return slot0._buildingSkinCongfig and slot0._buildingSkinCongfig.configList
end

function slot0.getBuildingSkinList(slot0, slot1)
	return slot0._buildingSkinListDict and slot0._buildingSkinListDict[slot1]
end

function slot0.getInteractBuildingConfig(slot0, slot1)
	return slot0._roomInteractBuildingConfig and slot0._roomInteractBuildingConfig.configDict[slot1]
end

function slot0.getBuildingSkinCoByItemId(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._buildingSkinCongfig.configList) do
		if slot6.itemId == slot1 then
			return slot6
		end
	end
end

function slot0.getFormulaShowTypeConfig(slot0, slot1)
	return slot0._formulaShowTypeConfig.configDict[slot1]
end

function slot0.getRoomCharacterConfig(slot0, slot1)
	return slot0._roomCharacterConfig.configDict[slot1]
end

function slot0.getAccelerateConfig(slot0)
	slot1 = GameUtil.splitString2(CommonConfig.instance:getConstStr(ConstEnum.RoomAccelerateParam), true)

	return {
		item = {
			type = slot1[1][1],
			id = slot1[1][2],
			quantity = slot1[1][3]
		},
		second = slot1[2][1]
	}
end

function slot0.getInitBuildingOccupyDict(slot0)
	if not slot0._initBuildingOccupyDict then
		slot0._initBuildingOccupyDict = {}

		if not string.nilorempty(CommonConfig.instance:getConstStr(ConstEnum.RoomInitBuildingOccupy)) then
			for slot6, slot7 in ipairs(GameUtil.splitString2(slot1, true)) do
				slot8 = HexPoint(slot7[1], slot7[2])
				slot0._initBuildingOccupyDict[slot8.x] = slot0._initBuildingOccupyDict[slot8.x] or {}
				slot0._initBuildingOccupyDict[slot8.x][slot8.y] = true
			end
		end
	end

	return slot0._initBuildingOccupyDict
end

function slot0.getTaskReward(slot0, slot1)
	if not slot0._taskFinishRewardDict then
		slot0._taskFinishRewardDict = {}

		for slot5, slot6 in ipairs(slot0._blockRandomEventConfig.configList) do
			slot8, slot9, slot10 = string.find(slot6.event, "TaskFinishCount=(%d+)")

			if slot10 and tonumber(slot10) then
				slot0._taskFinishRewardDict[slot10] = slot6.blockCount
			end
		end
	end

	return slot0._taskFinishRewardDict[slot1] or 0
end

function slot0.getRoomLevelConfig(slot0, slot1)
	return slot0._roomLevelConfig.configDict[slot1]
end

function slot0.getMaxRoomLevel(slot0)
	for slot5, slot6 in ipairs(slot0._roomLevelConfig.configList) do
		if 1 < slot6.level then
			slot1 = slot6.level
		end
	end

	return slot1
end

function slot0.getBlockDefineConfig(slot0, slot1)
	return slot0._blockDefineConfig.configDict[slot1]
end

function slot0.getBlockDefineConfigDict(slot0)
	return slot0._blockDefineConfig.configDict
end

function slot0.getBlock(slot0, slot1)
	return slot0._blockPackageDataConfig and slot0._blockPackageDataConfig.configDict[slot1] or slot0._blockInitConfig and slot0._blockInitConfig.configDict[slot1]
end

function slot0.getSpecialBlockConfig(slot0, slot1)
	return slot0._specialBlockConfig and slot0._specialBlockConfig.configDict[slot1]
end

function slot0.getHeroSpecialBlockId(slot0, slot1)
	if not slot1 then
		return
	end

	return slot0._heroId2SpecialBlockIdDict[slot1]
end

function slot0.getBlockListByPackageId(slot0, slot1)
	return slot0._blockPackageDataConfig and slot0._blockPackageDataConfig.packageDict[slot1]
end

function slot0.getPackageConfigByBlockId(slot0, slot1)
	if not slot1 or slot1 <= 0 then
		return nil
	end

	if not slot0._blockId2PackageIdDict then
		slot0._blockId2PackageIdDict = {}

		for slot5, slot6 in pairs(slot0._blockPackageDataConfig.packageDict) do
			for slot10, slot11 in ipairs(slot6) do
				slot0._blockId2PackageIdDict[slot11.blockId] = slot5
			end
		end
	end

	if not slot0._blockId2PackageIdDict then
		return nil
	end

	return slot0._blockId2PackageIdDict[slot1] and slot0:getBlockPackageConfig(slot2)
end

function slot0.getInitBlockList(slot0)
	return slot0._blockInitConfig and slot0._blockInitConfig.configList
end

function slot0.getInitBlock(slot0, slot1)
	return slot0._blockInitConfig and slot0._blockInitConfig.configDict[slot1]
end

function slot0.getInitBlockByXY(slot0, slot1, slot2)
	slot3 = slot0._blockInitConfig and slot0._blockInitConfig.poscfgDict

	return slot3 and slot3[slot1] and slot3[slot1][slot2]
end

function slot0.getSceneTaskList(slot0)
	for slot5, slot6 in ipairs(slot0._sceneTaskConfig.configList) do
		if slot6.isOnline then
			table.insert({}, slot6)
		end
	end

	return slot0._sceneTaskConfig.configList
end

function slot0.getBuildingConfigList(slot0)
	return slot0._roomBuildingConfig.configList
end

function slot0.getProductionPartConfig(slot0, slot1)
	return slot0._productionPartConfig.configDict[slot1]
end

function slot0.getProductionPartConfigList(slot0)
	return slot0._productionPartConfig.configList
end

function slot0.getProductionPartByLineId(slot0, slot1)
	return slot0._productionLineToPart[slot1]
end

function slot0.getProductionLineConfig(slot0, slot1)
	return slot0._productionLineConfig.configDict[slot1]
end

function slot0.getProductionLineLevelGroupIdConfig(slot0, slot1)
	return slot0._productionLineLevelConfig.configDict[slot1]
end

function slot0.getProductionLineLevelGroupMaxLevel(slot0, slot1)
	slot3 = 1

	if slot0._productionLineLevelConfig.configDict[slot1] then
		slot3 = tabletool.len(slot2)
	end

	return slot3
end

function slot0.getProductionLineLevelConfig(slot0, slot1, slot2)
	return (slot0._productionLineLevelConfig.configDict[slot1] or {})[slot2]
end

function slot0.getProductionLineLevelConfigList(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in pairs(slot0._productionLineLevelConfig.configDict[slot1]) do
		table.insert(slot3, slot8)
	end

	table.sort(slot3, function (slot0, slot1)
		return slot0.id < slot1.id
	end)

	return slot3
end

function slot0.getCharacterLimitAddByBuildDegree(slot0, slot1)
	slot2 = 0

	for slot6, slot7 in ipairs(slot0._buildingBonusConfig.configList) do
		if slot1 < slot7.buildDegree then
			break
		end

		slot2 = slot7.characterLimitAdd
	end

	return slot2
end

function slot0.getBuildBonusByBuildDegree(slot0, slot1)
	slot2 = 0
	slot3 = 0
	slot4 = 1

	for slot8, slot9 in ipairs(slot0._buildingBonusConfig.configList) do
		if slot1 < slot9.buildDegree then
			slot3 = slot9.buildDegree - slot1

			break
		end

		slot4 = slot8 + 1
		slot2 = slot9.bonus
	end

	return slot2, slot3, slot4
end

function slot0.getCharacterInteractionConfig(slot0, slot1)
	return slot0._roomCharacterInteractionConfig.configDict[slot1]
end

function slot0.getCharacterInteractionConfigList(slot0)
	return slot0._roomCharacterInteractionConfig.configList
end

function slot0.getCharacterInteractionConfigListByHeroId(slot0, slot1)
	if not slot0._roomCharacterInteractionConfigHeroDict then
		slot0._roomCharacterInteractionConfigHeroDict = slot0:_toListDictByKeyName(slot0._roomCharacterInteractionConfig.configList, "heroId")
	end

	return slot0._roomCharacterInteractionConfigHeroDict[slot1]
end

function slot0.getCharacterDialogConfig(slot0, slot1, slot2)
	return slot0._roomCharacterDialogConfig.configDict[slot1] and slot0._roomCharacterDialogConfig.configDict[slot1][slot2]
end

function slot0.getCharacterDialogSelectConfig(slot0, slot1)
	return slot0._roomCharacterDialogSelectConfig.configDict[slot1]
end

function slot0.getThemeConfig(slot0, slot1)
	return slot0._roomThemeConfig and slot0._roomThemeConfig.configDict[slot1]
end

function slot0.getThemeConfigList(slot0)
	return slot0._roomThemeConfig and slot0._roomThemeConfig.configList
end

function slot0.getThemeIdByItem(slot0, slot1, slot2)
	if slot2 == nil or slot1 == nil then
		return nil
	end

	if slot2 == MaterialEnum.MaterialType.SpecialBlock and slot0:getBlock(slot1) then
		slot1 = slot3.packageId
		slot2 = MaterialEnum.MaterialType.BlockPackage
	end

	return slot0._itemIdToRoomThemeId and slot0._itemIdToRoomThemeId[slot2] and slot0._itemIdToRoomThemeId[slot2][slot1]
end

function slot0.getThemeCollectionRewards(slot0, slot1)
	return slot0._roomThemeCollectionBonusDic and slot0._roomThemeCollectionBonusDic[slot1]
end

function slot0.getVehicleConfig(slot0, slot1)
	return slot0._roomVehicleConfig and slot0._roomVehicleConfig.configDict[slot1]
end

function slot0.getVehicleConfigList(slot0)
	return slot0._roomVehicleConfig and slot0._roomVehicleConfig.configList
end

function slot0.getSourcesTypeConfig(slot0, slot1)
	return slot0._roomSourcesTypeConfig and slot0._roomSourcesTypeConfig[slot1]
end

function slot0.getCharacterAnimConfig(slot0, slot1, slot2)
	return slot0._roomCharacterAnimConfig.configDict[slot1] and slot0._roomCharacterAnimConfig.configDict[slot1][slot2]
end

function slot0.getCharacterShadowConfig(slot0, slot1, slot2)
	return slot0.roomCharacterShadowConfig and slot0.roomCharacterShadowConfig.configDict[slot1] and slot0.roomCharacterShadowConfig.configDict[slot1][slot2]
end

function slot0.getBlockPlacePositionCfgList(slot0)
	return slot0._blockPlacePositionConfig and slot0._blockPlacePositionConfig.configList
end

function slot0.getAudioExtendConfig(slot0, slot1)
	return slot0._roomAudioExtendConfig and slot0._roomAudioExtendConfig.configDict[slot1]
end

function slot0.getPlanCoverConfig(slot0, slot1)
	return slot0._roomLayoutPlanCoverConfig and slot0._roomLayoutPlanCoverConfig.configDict[slot1]
end

function slot0.getPlanCoverConfigList(slot0)
	return slot0._roomLayoutPlanCoverConfig and slot0._roomLayoutPlanCoverConfig.configList
end

function slot0.getSceneAmbientConfigList(slot0)
	return slot0._roomSceneAmbientConfig and slot0._roomSceneAmbientConfig.configList
end

function slot0.getSceneAmbientConfig(slot0, slot1)
	return slot0._roomSceneAmbientConfig and slot0._roomSceneAmbientConfig.configDict[slot1]
end

function slot0.getBuildingTypeCfg(slot0, slot1, slot2)
	if not lua_room_building_type.configDict[slot1] and slot2 then
		logError(string.format("RoomConfig.getBuildingTypeCfg error, cfg is nil, buildingType:%s", slot1))
	end

	return slot3
end

function slot0.getBuildingTypeIcon(slot0, slot1)
	slot2 = nil

	if slot0:getBuildingTypeCfg(slot1, true) then
		slot2 = slot3.icon
	end

	return slot2
end

function slot2(slot0, slot1)
	if not lua_room_atmosphere.configDict[slot0] and slot1 then
		logError(string.format("RoomConfig.getRoomAtmosphereCfg error, cfg is nil, id:%s", slot0))
	end

	return slot2
end

function slot0.getAtmosphereCfg(slot0, slot1)
	return uv0(slot1, true)
end

function slot0.getAtmosphereRelatedBuilding(slot0, slot1)
	slot2 = 0

	if uv0(slot1, true) then
		slot2 = slot3.buildingId
	end

	return slot2
end

function slot0.getAtmosphereEffectIdList(slot0, slot1)
	slot2 = {}

	if uv0(slot1, true) then
		slot2 = string.splitToNumber(slot3.effectSequence, "#")
	end

	return slot2
end

function slot0.getAtmosphereAllEffectPathList(slot0, slot1)
	slot2 = {}
	slot3 = slot0:getAtmosphereEffectIdList(slot1)

	if slot0:getAtmosphereResidentEffect(slot1) and slot4 ~= 0 then
		slot3[#slot3 + 1] = slot4
	end

	for slot8, slot9 in ipairs(slot3) do
		if not GameResMgr.IsFromEditorDir then
			slot10 = FightHelper.getEffectAbPath(slot0:getRoomEffectPath(slot9))
		end

		if not string.nilorempty(slot10) then
			slot2[#slot2 + 1] = slot10
		end
	end

	return slot2
end

function slot0.getAtmosphereResidentEffect(slot0, slot1)
	slot2 = 0

	if uv0(slot1, true) then
		slot2 = slot3.residentEffect
	end

	return slot2
end

function slot0.getAtmosphereCyclesTimes(slot0, slot1)
	slot2 = 0

	if uv0(slot1, true) then
		slot2 = slot3.cyclesTimes
	end

	return slot2
end

function slot0.getAtmosphereOpenTime(slot0, slot1)
	slot2 = 0

	if uv0(slot1, true) then
		slot2 = TimeUtil.stringToTimestamp(slot3.openTime)
	end

	return slot2
end

function slot0.getAtmosphereDurationDay(slot0, slot1)
	slot2 = 0

	if uv0(slot1, true) then
		slot2 = slot3.durationDay
	end

	return slot2
end

function slot0.getAtmosphereTriggerType(slot0, slot1)
	slot2 = 0

	if uv0(slot1, true) then
		slot2 = slot3.triggerType
	end

	return slot2
end

function slot0.getBuildingAtmospheres(slot0, slot1)
	if slot0._building2AtmosphereIds then
		slot2 = slot0._building2AtmosphereIds[slot1] or {}
	end

	return slot2
end

function slot3(slot0, slot1)
	if not lua_room_effect.configDict[slot0] and slot1 then
		logError(string.format("RoomConfig.getRoomEffectCfg error, cfg is nil, id:%s", slot0))
	end

	return slot2
end

function slot0.getRoomEffectPath(slot0, slot1)
	slot2 = nil

	if uv0(slot1, true) then
		slot2 = slot3.resPath
	end

	return slot2
end

function slot0.getRoomEffectDuration(slot0, slot1)
	slot2 = 0

	if uv0(slot1, true) then
		slot2 = slot3.duration
	end

	return slot2
end

function slot0.getRoomEffectAudioId(slot0, slot1)
	slot2 = nil

	if uv0(slot1, true) then
		slot2 = slot3.audioId
	end

	return slot2
end

function slot4(slot0, slot1)
	if not lua_room_water_reform.configDict[slot0] and slot1 then
		logError(string.format("RoomConfig.getRoomWaterReformCfg error, cfg is nil, id:%s", slot0))
	end

	return slot2
end

function slot0.getWaterReformTypeList(slot0)
	slot1 = {}

	if lua_room_water_reform and lua_room_water_reform.configList then
		for slot5, slot6 in ipairs(lua_room_water_reform.configList) do
			slot1[#slot1 + 1] = slot6.blockType
		end
	end

	return slot1
end

function slot0.getWaterReformTypeBlockId(slot0, slot1)
	slot2 = nil

	if uv0(slot1, true) then
		slot2 = slot3.blockId
	end

	return slot2
end

function slot0.getWaterReformTypeBlockCfg(slot0, slot1)
	slot2 = nil

	if slot0:getWaterReformTypeBlockId(slot1) then
		slot2 = slot0:getBlock(slot3) or {
			mainRes = 0,
			blockId = slot3,
			defineWaterType = slot1,
			defineId = RoomBlockEnum.WaterReformCommonDefineId
		}
	end

	return slot2
end

function slot0.getWaterReformItemId(slot0, slot1)
	return uv0(slot1, true) and slot2.itemId or 0
end

function slot0.getWaterTypeByBlockId(slot0, slot1)
	if not slot0._blockId2WaterReformTypeDict then
		slot0:_initBlockId2WaterReformTypeDict()
	end

	return slot0._blockId2WaterReformTypeDict[slot1]
end

function slot0._initBlockId2WaterReformTypeDict(slot0)
	slot0._blockId2WaterReformTypeDict = {}

	for slot4, slot5 in ipairs(lua_room_water_reform.configList) do
		slot0._blockId2WaterReformTypeDict[slot5.blockId] = slot5.blockType
	end
end

function slot5(slot0, slot1)
	if not lua_room_skin.configDict[slot0] and slot1 then
		logError(string.format("RoomConfig.getRoomSkinCfg error, cfg is nil, id:%s", slot0))
	end

	return slot2
end

function slot0.getAllSkinIdList(slot0)
	slot1 = {}

	if lua_room_skin and lua_room_skin.configList then
		for slot5, slot6 in ipairs(lua_room_skin.configList) do
			slot1[#slot1 + 1] = slot6.id
		end
	end

	return slot1
end

function slot0.getSkinIdList(slot0, slot1)
	slot2 = {}

	if slot1 and slot0._roomType2SkinsDict and slot0._roomType2SkinsDict[slot1] then
		slot2 = tabletool.copy(slot3)
	end

	return slot2
end

function slot0.getBelongPart(slot0, slot1)
	slot2 = nil

	if uv0(slot1, true) then
		slot2 = slot3.type
	end

	return slot2
end

function slot0.getRoomSkinUnlockItemId(slot0, slot1)
	slot2 = nil

	if uv0(slot1, true) then
		slot2 = slot3.itemId
	end

	return slot2
end

function slot0.getRoomSkinName(slot0, slot1)
	slot2 = ""

	if uv0(slot1, true) then
		slot2 = slot3.name
	end

	return slot2
end

function slot0.getRoomSkinActId(slot0, slot1)
	slot2 = nil

	if uv0(slot1, true) then
		slot2 = slot3.activity
	end

	return slot2
end

function slot0.getRoomSkinIcon(slot0, slot1)
	slot2 = nil

	if uv0(slot1, true) then
		slot2 = slot3.icon
	end

	return slot2
end

function slot0.getRoomSkinDesc(slot0, slot1)
	slot2 = ""

	if uv0(slot1, true) then
		slot2 = slot3.desc
	end

	return slot2
end

function slot0.getRoomSkinBannerIcon(slot0, slot1)
	slot2 = ""

	if uv0(slot1, true) then
		slot2 = slot3.bannerIcon
	end

	return slot2
end

function slot0.getRoomSkinRare(slot0, slot1)
	slot2 = nil

	if uv0(slot1, true) then
		slot2 = slot3.rare
	end

	return slot2
end

function slot0.getRoomSkinPriority(slot0, slot1)
	slot2 = nil

	if uv0(slot1, true) then
		slot2 = slot3.priority
	end

	return slot2
end

function slot0.getRoomSkinModelPath(slot0, slot1)
	slot2 = nil

	if uv0(slot1, true) then
		slot2 = slot3.model
	end

	return slot2
end

function slot0.getRoomSkinEquipEffPos(slot0, slot1)
	slot2 = nil

	if uv0(slot1, true) then
		slot2 = slot3.equipEffPos
	end

	return slot2
end

function slot0.getRoomSkinEquipEffSize(slot0, slot1)
	slot2 = nil

	if uv0(slot1, true) then
		slot2 = slot3.equipEffSize
	end

	return slot2
end

function slot0.getRoomSkinSources(slot0, slot1)
	slot2 = nil

	if uv0(slot1, true) then
		slot2 = slot3.sources
	end

	return slot2
end

slot0.instance = slot0.New()

return slot0
