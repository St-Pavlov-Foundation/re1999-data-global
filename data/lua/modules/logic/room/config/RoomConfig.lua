module("modules.logic.room.config.RoomConfig", package.seeall)

local var_0_0 = class("RoomConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._taskConfig = nil
	arg_1_0._resourceConfig = nil
	arg_1_0._roomBuildingConfig = nil
	arg_1_0._roomBuildingTypeConfig = nil
	arg_1_0._formulaConfig = nil
	arg_1_0._levelGroupConfig = nil
	arg_1_0._formulaShowTypeConfig = nil
	arg_1_0._blockRandomEventConfig = nil
	arg_1_0._roomLevelConfig = nil
	arg_1_0._roomCharacterConfig = nil
	arg_1_0._blockPackageConfig = nil
	arg_1_0._initBuildingOccupyDict = nil
	arg_1_0._taskFinishRewardDict = nil
	arg_1_0._blockPackageDataConfig = nil
	arg_1_0._productionPartConfig = nil
	arg_1_0._productionLineToPart = nil
	arg_1_0._sceneTaskConfig = nil
	arg_1_0._blockId2PackageIdDict = nil
	arg_1_0._specialBlockConfig = nil
	arg_1_0._heroId2SpecialBlockIdDict = nil
	arg_1_0._roomCharacterInteractionConfig = nil
	arg_1_0._roomCharacterInteractionConfigHeroDict = nil
	arg_1_0._roomCharacterDialogConfig = nil
	arg_1_0._roomThemeConfig = nil
	arg_1_0._roomCharacterDialogSelectConfig = nil
	arg_1_0._roomVehicleConfig = nil
	arg_1_0._roomSourcesTypeConfig = nil
	arg_1_0._roomCharacterAnimConfig = nil
	arg_1_0._roomAudioExtendConfig = nil
	arg_1_0._roomCameraParamsConfig = nil
	arg_1_0._roomCharacterBuildingInteractCameraConfig = nil
	arg_1_0.roomCharacterShadowConfig = nil
	arg_1_0._roomLayoutPlanCoverConfig = nil
	arg_1_0._building2AtmosphereIds = nil
	arg_1_0._roomSceneAmbientConfig = nil
	arg_1_0._roomType2SkinsDict = nil
	arg_1_0._unlockItem2RoomSkinList = nil
	arg_1_0._blockId2WaterReformTypeDict = nil
end

function var_0_0.reqConfigNames(arg_2_0)
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

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "block_task" then
		arg_3_0._taskConfig = arg_3_2
	elseif arg_3_1 == "block_resource" then
		arg_3_0._resourceConfig = arg_3_2

		arg_3_0:_initBlockResource(arg_3_2)
	elseif arg_3_1 == "room_building" then
		arg_3_0._roomBuildingConfig = arg_3_2
	elseif arg_3_1 == "room_building_area" then
		arg_3_0._roomBuildingAreaConfig = arg_3_2
	elseif arg_3_1 == "formula" then
		arg_3_0:initFormulaConfig(arg_3_2)
	elseif arg_3_1 == "room_building_level" then
		arg_3_0._levelGroupConfig = arg_3_2
	elseif arg_3_1 == "room_building_skin" then
		arg_3_0:_initBuildingSkinConfig(arg_3_2)
	elseif arg_3_1 == "room_interact_building" then
		arg_3_0._roomInteractBuildingConfig = arg_3_2
	elseif arg_3_1 == "formula_showtype" then
		arg_3_0._formulaShowTypeConfig = arg_3_2
	elseif arg_3_1 == "block_random_event" then
		arg_3_0._blockRandomEventConfig = arg_3_2
	elseif arg_3_1 == "room_level" then
		arg_3_0._roomLevelConfig = arg_3_2
	elseif arg_3_1 == "room_character" then
		arg_3_0._roomCharacterConfig = arg_3_2
	elseif arg_3_1 == "task_room" then
		arg_3_0._sceneTaskConfig = arg_3_2
	elseif arg_3_1 == "block_package" then
		arg_3_0._blockPackageConfig = arg_3_2
	elseif arg_3_1 == "block_package_data" then
		arg_3_0._blockPackageDataConfig = arg_3_2
	elseif arg_3_1 == "block" then
		arg_3_0._blockDefineConfig = arg_3_2
	elseif arg_3_1 == "block_init" then
		arg_3_0._blockInitConfig = arg_3_2
	elseif arg_3_1 == "production_part" then
		arg_3_0:initProductionPart(arg_3_2)
	elseif arg_3_1 == "production_line" then
		arg_3_0._productionLineConfig = arg_3_2
	elseif arg_3_1 == "production_line_level" then
		arg_3_0._productionLineLevelConfig = arg_3_2
	elseif arg_3_1 == "building_bonus" then
		arg_3_0._buildingBonusConfig = arg_3_2
	elseif arg_3_1 == "special_block" then
		arg_3_0:_initSpecialBlock(arg_3_2)
	elseif arg_3_1 == "room_character_interaction" then
		arg_3_0._roomCharacterInteractionConfig = arg_3_2
	elseif arg_3_1 == "room_character_dialog" then
		arg_3_0._roomCharacterDialogConfig = arg_3_2
	elseif arg_3_1 == "room_character_dialog_select" then
		arg_3_0._roomCharacterDialogSelectConfig = arg_3_2
	elseif arg_3_1 == "room_theme" then
		arg_3_0:_initTheme(arg_3_2)
	elseif arg_3_1 == "room_vehicle" then
		arg_3_0._roomVehicleConfig = arg_3_2
	elseif arg_3_1 == "room_sources_type" then
		arg_3_0._roomSourcesTypeConfig = arg_3_2.configDict
	elseif arg_3_1 == "room_character_anim" then
		arg_3_0._roomCharacterAnimConfig = arg_3_2
	elseif arg_3_1 == "block_place_position" then
		arg_3_0._blockPlacePositionConfig = arg_3_2
	elseif arg_3_1 == "room_audio_extend" then
		arg_3_0._roomAudioExtendConfig = arg_3_2
	elseif arg_3_1 == "room_camera_params" then
		arg_3_0:_initCameraParam(arg_3_2)
	elseif arg_3_1 == "room_character_building_interact_camera" then
		arg_3_0._roomCharacterBuildingInteractCameraConfig = arg_3_2
	elseif arg_3_1 == "room_character_shadow" then
		arg_3_0.roomCharacterShadowConfig = arg_3_2
	elseif arg_3_1 == "room_character_interaction_effect" then
		arg_3_0._roomCharacterEffectConfig = arg_3_2
	elseif arg_3_1 == "room_layout_plan_cover" then
		arg_3_0._roomLayoutPlanCoverConfig = arg_3_2
	elseif arg_3_1 == "room_atmosphere" then
		arg_3_0:_initAtmosphereCfg(arg_3_2)
	elseif arg_3_1 == "room_scene_ambient" then
		arg_3_0._roomSceneAmbientConfig = arg_3_2
	elseif arg_3_1 == "room_skin" then
		arg_3_0:_initRoomSkinCfg(arg_3_2)
	end
end

function var_0_0._toListDictByKeyName(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		local var_4_1 = iter_4_1[arg_4_2]

		if not var_4_0[var_4_1] then
			var_4_0[var_4_1] = {}
		end

		table.insert(var_4_0[var_4_1], iter_4_1)
	end

	return var_4_0
end

function var_0_0.initProductionPart(arg_5_0, arg_5_1)
	arg_5_0._productionPartConfig = arg_5_1
	arg_5_0._productionLineToPart = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_1.configDict) do
		for iter_5_2, iter_5_3 in pairs(iter_5_1.productionLines) do
			arg_5_0._productionLineToPart[iter_5_3] = iter_5_0
		end
	end
end

function var_0_0._initSpecialBlock(arg_6_0, arg_6_1)
	arg_6_0._heroId2SpecialBlockIdDict = {}
	arg_6_0._specialBlockConfig = arg_6_1

	for iter_6_0, iter_6_1 in ipairs(arg_6_1.configList) do
		arg_6_0._heroId2SpecialBlockIdDict[iter_6_1.heroId] = iter_6_1.id
	end
end

function var_0_0.initFormulaConfig(arg_7_0, arg_7_1)
	arg_7_0._formulaConfig = arg_7_1
	arg_7_0.item2FormulaIdDic = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_1.configDict) do
		if iter_7_1.type == 2 then
			local var_7_0 = RoomProductionHelper.getFormulaProduceItem(iter_7_0, iter_7_1)

			if var_7_0 then
				if not arg_7_0.item2FormulaIdDic[var_7_0.type] then
					arg_7_0.item2FormulaIdDic[var_7_0.type] = {}
				end

				arg_7_0.item2FormulaIdDic[var_7_0.type][var_7_0.id] = iter_7_0
			end
		end
	end
end

function var_0_0.getItemFormulaId(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = 0

	if arg_8_0.item2FormulaIdDic[arg_8_1] then
		var_8_0 = arg_8_0.item2FormulaIdDic[arg_8_1][arg_8_2] or 0
	end

	return var_8_0
end

function var_0_0._initTheme(arg_9_0, arg_9_1)
	arg_9_0._roomThemeConfig = arg_9_1
	arg_9_0._itemIdToRoomThemeId = {}
	arg_9_0._roomThemeToItemList = {}
	arg_9_0._roomThemeCollectionBonusDic = {}

	local var_9_0 = {
		building = MaterialEnum.MaterialType.Building,
		package = MaterialEnum.MaterialType.BlockPackage,
		extraShowBuilding = MaterialEnum.MaterialType.Building
	}

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		arg_9_0._itemIdToRoomThemeId[iter_9_1] = {}
	end

	local var_9_1 = {}

	arg_9_0._itemIdToRoomThemeId[MaterialEnum.MaterialType.RoomTheme] = var_9_1

	for iter_9_2, iter_9_3 in pairs(arg_9_1.configDict) do
		local var_9_2 = {
			building = GameUtil.splitString2(iter_9_3.building, true) or {},
			package = GameUtil.splitString2(iter_9_3.packages, true) or {},
			extraShowBuilding = GameUtil.splitString2(iter_9_3.extraShowBuilding, true) or {}
		}

		arg_9_0._roomThemeToItemList[iter_9_2] = var_9_2
		var_9_1[iter_9_2] = iter_9_2

		for iter_9_4, iter_9_5 in pairs(var_9_0) do
			local var_9_3 = arg_9_0._itemIdToRoomThemeId[iter_9_5]

			for iter_9_6, iter_9_7 in ipairs(var_9_2[iter_9_4]) do
				var_9_3[iter_9_7[1]] = iter_9_2
			end
		end

		if not string.nilorempty(iter_9_3.collectionBonus) then
			arg_9_0._roomThemeCollectionBonusDic[iter_9_3.id] = GameUtil.splitString2(iter_9_3.collectionBonus, true)
		end
	end
end

function var_0_0._initBlockResource(arg_10_0, arg_10_1)
	arg_10_0._resourceParamCofig = {}
	arg_10_0._resourceLightDict = {}

	local var_10_0 = arg_10_1.configList

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		if iter_10_1.placeBuilding then
			arg_10_0._resourceParamCofig[iter_10_1.id] = {
				placeBuilding = string.splitToNumber(iter_10_1.placeBuilding, "#")
			}
		end

		arg_10_0._resourceLightDict[iter_10_1.id] = iter_10_1.blockLight == 1
	end
end

function var_0_0._initCameraParam(arg_11_0, arg_11_1)
	arg_11_0._roomCameraParamsConfig = arg_11_1
	arg_11_0._cameraParamsConfigDefauleDict = {}

	local var_11_0 = arg_11_1.configList

	for iter_11_0, iter_11_1 in ipairs(var_11_0) do
		if not arg_11_0._cameraParamsConfigDefauleDict[iter_11_1.state] or iter_11_1.gameMode == 0 then
			arg_11_0._cameraParamsConfigDefauleDict[iter_11_1.state] = iter_11_1
		end
	end
end

function var_0_0._initAtmosphereCfg(arg_12_0, arg_12_1)
	arg_12_0._building2AtmosphereIds = {}

	local var_12_0 = arg_12_1.configList

	for iter_12_0, iter_12_1 in ipairs(var_12_0) do
		local var_12_1 = iter_12_1.buildingId
		local var_12_2 = arg_12_0._building2AtmosphereIds[var_12_1]

		if not var_12_2 then
			var_12_2 = {}
			arg_12_0._building2AtmosphereIds[var_12_1] = var_12_2
		end

		var_12_2[#var_12_2 + 1] = iter_12_1.id
	end
end

function var_0_0._initRoomSkinCfg(arg_13_0, arg_13_1)
	arg_13_0._roomType2SkinsDict = {}
	arg_13_0._unlockItem2RoomSkinList = {}

	local var_13_0 = arg_13_1.configList

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_1 = iter_13_1.type
		local var_13_2 = arg_13_0._roomType2SkinsDict[var_13_1]

		if not var_13_2 then
			var_13_2 = {}
			arg_13_0._roomType2SkinsDict[var_13_1] = var_13_2
		end

		var_13_2[#var_13_2 + 1] = iter_13_1.id

		local var_13_3 = iter_13_1.itemId
		local var_13_4 = arg_13_0._unlockItem2RoomSkinList[var_13_3]

		if not var_13_4 then
			var_13_4 = {}
			arg_13_0._unlockItem2RoomSkinList[var_13_3] = var_13_4
		end

		var_13_4[#var_13_4 + 1] = iter_13_1.id
	end
end

function var_0_0.getCameraParamByStateId(arg_14_0, arg_14_1, arg_14_2)
	if arg_14_2 and arg_14_2 ~= 0 then
		local var_14_0 = arg_14_0._roomCameraParamsConfig.configList

		for iter_14_0 = 1, #var_14_0 do
			local var_14_1 = var_14_0[iter_14_0]

			if var_14_1.state == arg_14_1 and var_14_1.gameMode == arg_14_2 then
				return var_14_1
			end
		end
	end

	return arg_14_0._cameraParamsConfigDefauleDict[arg_14_1]
end

function var_0_0.getCharacterBuildingInteractCameraConfig(arg_15_0, arg_15_1)
	return arg_15_0._roomCharacterBuildingInteractCameraConfig.configDict[arg_15_1]
end

function var_0_0.getCharacterEffectList(arg_16_0, arg_16_1)
	if not arg_16_0._roomCharacterSkinEffectDict then
		arg_16_0._roomCharacterSkinEffectDict = {}
		arg_16_0._roomCharacterSkinAnimEffectDict = {}

		local var_16_0 = arg_16_0._roomCharacterSkinEffectDict

		for iter_16_0, iter_16_1 in ipairs(arg_16_0._roomCharacterEffectConfig.configList) do
			if not var_16_0[iter_16_1.skinId] then
				var_16_0[iter_16_1.skinId] = {}
				arg_16_0._roomCharacterSkinAnimEffectDict[iter_16_1.skinId] = {}
			end

			table.insert(var_16_0[iter_16_1.skinId], iter_16_1)

			local var_16_1 = arg_16_0._roomCharacterSkinAnimEffectDict[iter_16_1.skinId]

			if not var_16_1[iter_16_1.animName] then
				var_16_1[iter_16_1.animName] = {}
			end

			table.insert(var_16_1[iter_16_1.animName], iter_16_1)
		end
	end

	return arg_16_0._roomCharacterSkinEffectDict[arg_16_1]
end

function var_0_0.getCharacterEffectListByAnimName(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_0._roomCharacterSkinAnimEffectDict then
		arg_17_0:getCharacterEffectList(arg_17_1)
	end

	return arg_17_0._roomCharacterSkinAnimEffectDict[arg_17_1] and arg_17_0._roomCharacterSkinAnimEffectDict[arg_17_1][arg_17_2]
end

function var_0_0.getTaskConfig(arg_18_0, arg_18_1)
	return arg_18_0._taskConfig.configDict[arg_18_1]
end

function var_0_0.getResourceConfig(arg_19_0, arg_19_1)
	return arg_19_0._resourceConfig.configDict[arg_19_1]
end

function var_0_0.getResourceParam(arg_20_0, arg_20_1)
	return arg_20_0._resourceParamCofig[arg_20_1]
end

function var_0_0.isLightByResourceId(arg_21_0, arg_21_1)
	return arg_21_0._resourceLightDict[arg_21_1]
end

function var_0_0.getBuildingConfig(arg_22_0, arg_22_1)
	return arg_22_0._roomBuildingConfig.configDict[arg_22_1]
end

function var_0_0.getBuildingType(arg_23_0, arg_23_1)
	local var_23_0
	local var_23_1 = arg_23_0:getBuildingConfig(arg_23_1)

	if var_23_1 then
		var_23_0 = var_23_1.buildingType
	end

	return var_23_0
end

function var_0_0.getBuildingAreaConfig(arg_24_0, arg_24_1)
	return arg_24_0._roomBuildingAreaConfig.configDict[arg_24_1]
end

local function var_0_1(arg_25_0, arg_25_1)
	local var_25_0
	local var_25_1 = lua_room_building_occupy.configDict[arg_25_0]

	if not var_25_1 and arg_25_1 then
		logError(string.format("RoomConfig.GetOccupyCfg Error,cfg is nil, id%s", arg_25_0))
	end

	return var_25_1
end

function var_0_0.getBuildingOccupyList(arg_26_0)
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in ipairs(lua_room_building_occupy.configList) do
		var_26_0[#var_26_0 + 1] = iter_26_1.id
	end

	return var_26_0
end

function var_0_0.getBuildingOccupyIcon(arg_27_0, arg_27_1)
	local var_27_0
	local var_27_1 = var_0_1(arg_27_1, true)

	if var_27_1 then
		var_27_0 = var_27_1.icon
	end

	return var_27_0
end

function var_0_0.getBuildingOccupyNum(arg_28_0, arg_28_1)
	local var_28_0
	local var_28_1 = var_0_1(arg_28_1, true)

	if var_28_1 then
		var_28_0 = var_28_1.occupyNum
	end

	return var_28_0
end

function var_0_0.getFormulaConfig(arg_29_0, arg_29_1)
	return arg_29_0._formulaConfig.configDict[arg_29_1]
end

function var_0_0.getBlockPackageConfig(arg_30_0, arg_30_1)
	return arg_30_0._blockPackageConfig.configDict[arg_30_1]
end

function var_0_0.getBlockPackageFullDegree(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0:getBlockPackageConfig(arg_31_1)
	local var_31_1 = arg_31_0:getBlockListByPackageId(arg_31_1)

	return var_31_0.blockBuildDegree * #var_31_1
end

function var_0_0.getLevelGroupConfig(arg_32_0, arg_32_1, arg_32_2)
	return arg_32_0._levelGroupConfig.configDict[arg_32_1] and arg_32_0._levelGroupConfig.configDict[arg_32_1][arg_32_2]
end

function var_0_0.getLevelGroupInfo(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = {}
	local var_33_1 = arg_33_0._levelGroupConfig.configDict[arg_33_1] and arg_33_0._levelGroupConfig.configDict[arg_33_1][arg_33_2]

	if var_33_1 then
		var_33_0.desc = var_33_1.desc
	end

	var_33_1 = var_33_1 or arg_33_0._levelGroupConfig.configDict[arg_33_1] and arg_33_0._levelGroupConfig.configDict[arg_33_1][1]

	if var_33_1 then
		var_33_0.name = var_33_1.name
		var_33_0.nameEn = var_33_1.nameEn
		var_33_0.icon = var_33_1.icon
	end

	return var_33_0
end

function var_0_0.getLevelGroupLevelDict(arg_34_0, arg_34_1)
	return arg_34_0._levelGroupConfig.configDict[arg_34_1] and arg_34_0._levelGroupConfig.configDict[arg_34_1]
end

function var_0_0.getLevelGroupMaxLevel(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0._levelGroupConfig.configDict[arg_35_1]
	local var_35_1 = 0

	if var_35_0 then
		for iter_35_0, iter_35_1 in pairs(var_35_0) do
			if var_35_1 < iter_35_0 then
				var_35_1 = iter_35_0
			end
		end
	end

	return var_35_1
end

function var_0_0._initBuildingSkinConfig(arg_36_0, arg_36_1)
	arg_36_0._buildingSkinCongfig = arg_36_1
	arg_36_0._buildingSkinListDict = {}

	local var_36_0 = arg_36_1.configList

	for iter_36_0, iter_36_1 in ipairs(var_36_0) do
		if not arg_36_0._buildingSkinListDict[iter_36_1.buildingId] then
			arg_36_0._buildingSkinListDict[iter_36_1.buildingId] = {}
		end

		table.insert(arg_36_0._buildingSkinListDict[iter_36_1.buildingId], iter_36_1)
	end
end

function var_0_0.getBuildingSkinConfig(arg_37_0, arg_37_1)
	return arg_37_0._buildingSkinCongfig and arg_37_0._buildingSkinCongfig.configDict[arg_37_1]
end

function var_0_0.getAllBuildingSkinList(arg_38_0)
	return arg_38_0._buildingSkinCongfig and arg_38_0._buildingSkinCongfig.configList
end

function var_0_0.getBuildingSkinList(arg_39_0, arg_39_1)
	return arg_39_0._buildingSkinListDict and arg_39_0._buildingSkinListDict[arg_39_1]
end

function var_0_0.getInteractBuildingConfig(arg_40_0, arg_40_1)
	return arg_40_0._roomInteractBuildingConfig and arg_40_0._roomInteractBuildingConfig.configDict[arg_40_1]
end

function var_0_0.getBuildingSkinCoByItemId(arg_41_0, arg_41_1)
	for iter_41_0, iter_41_1 in ipairs(arg_41_0._buildingSkinCongfig.configList) do
		if iter_41_1.itemId == arg_41_1 then
			return iter_41_1
		end
	end
end

function var_0_0.getFormulaShowTypeConfig(arg_42_0, arg_42_1)
	return arg_42_0._formulaShowTypeConfig.configDict[arg_42_1]
end

function var_0_0.getRoomCharacterConfig(arg_43_0, arg_43_1)
	return arg_43_0._roomCharacterConfig.configDict[arg_43_1]
end

function var_0_0.getAccelerateConfig(arg_44_0)
	local var_44_0 = CommonConfig.instance:getConstStr(ConstEnum.RoomAccelerateParam)
	local var_44_1 = GameUtil.splitString2(var_44_0, true)

	return {
		item = {
			type = var_44_1[1][1],
			id = var_44_1[1][2],
			quantity = var_44_1[1][3]
		},
		second = var_44_1[2][1]
	}
end

function var_0_0.getInitBuildingOccupyDict(arg_45_0)
	if not arg_45_0._initBuildingOccupyDict then
		arg_45_0._initBuildingOccupyDict = {}

		local var_45_0 = CommonConfig.instance:getConstStr(ConstEnum.RoomInitBuildingOccupy)

		if not string.nilorempty(var_45_0) then
			local var_45_1 = GameUtil.splitString2(var_45_0, true)

			for iter_45_0, iter_45_1 in ipairs(var_45_1) do
				local var_45_2 = HexPoint(iter_45_1[1], iter_45_1[2])

				arg_45_0._initBuildingOccupyDict[var_45_2.x] = arg_45_0._initBuildingOccupyDict[var_45_2.x] or {}
				arg_45_0._initBuildingOccupyDict[var_45_2.x][var_45_2.y] = true
			end
		end
	end

	return arg_45_0._initBuildingOccupyDict
end

function var_0_0.getTaskReward(arg_46_0, arg_46_1)
	if not arg_46_0._taskFinishRewardDict then
		arg_46_0._taskFinishRewardDict = {}

		for iter_46_0, iter_46_1 in ipairs(arg_46_0._blockRandomEventConfig.configList) do
			local var_46_0 = iter_46_1.event
			local var_46_1, var_46_2, var_46_3 = string.find(var_46_0, "TaskFinishCount=(%d+)")

			var_46_3 = var_46_3 and tonumber(var_46_3)

			if var_46_3 then
				arg_46_0._taskFinishRewardDict[var_46_3] = iter_46_1.blockCount
			end
		end
	end

	return arg_46_0._taskFinishRewardDict[arg_46_1] or 0
end

function var_0_0.getRoomLevelConfig(arg_47_0, arg_47_1)
	return arg_47_0._roomLevelConfig.configDict[arg_47_1]
end

function var_0_0.getMaxRoomLevel(arg_48_0)
	local var_48_0 = 1

	for iter_48_0, iter_48_1 in ipairs(arg_48_0._roomLevelConfig.configList) do
		if var_48_0 < iter_48_1.level then
			var_48_0 = iter_48_1.level
		end
	end

	return var_48_0
end

function var_0_0.getBlockDefineConfig(arg_49_0, arg_49_1)
	return arg_49_0._blockDefineConfig.configDict[arg_49_1]
end

function var_0_0.getBlockDefineConfigDict(arg_50_0)
	return arg_50_0._blockDefineConfig.configDict
end

function var_0_0.getBlock(arg_51_0, arg_51_1)
	return arg_51_0._blockPackageDataConfig and arg_51_0._blockPackageDataConfig.configDict[arg_51_1] or arg_51_0._blockInitConfig and arg_51_0._blockInitConfig.configDict[arg_51_1]
end

function var_0_0.getSpecialBlockConfig(arg_52_0, arg_52_1)
	return arg_52_0._specialBlockConfig and arg_52_0._specialBlockConfig.configDict[arg_52_1]
end

function var_0_0.getHeroSpecialBlockId(arg_53_0, arg_53_1)
	if not arg_53_1 then
		return
	end

	return arg_53_0._heroId2SpecialBlockIdDict[arg_53_1]
end

function var_0_0.getBlockListByPackageId(arg_54_0, arg_54_1)
	return arg_54_0._blockPackageDataConfig and arg_54_0._blockPackageDataConfig.packageDict[arg_54_1]
end

function var_0_0.getPackageConfigByBlockId(arg_55_0, arg_55_1)
	if not arg_55_1 or arg_55_1 <= 0 then
		return nil
	end

	if not arg_55_0._blockId2PackageIdDict then
		arg_55_0._blockId2PackageIdDict = {}

		for iter_55_0, iter_55_1 in pairs(arg_55_0._blockPackageDataConfig.packageDict) do
			for iter_55_2, iter_55_3 in ipairs(iter_55_1) do
				arg_55_0._blockId2PackageIdDict[iter_55_3.blockId] = iter_55_0
			end
		end
	end

	if not arg_55_0._blockId2PackageIdDict then
		return nil
	end

	local var_55_0 = arg_55_0._blockId2PackageIdDict[arg_55_1]

	return var_55_0 and arg_55_0:getBlockPackageConfig(var_55_0)
end

function var_0_0.getInitBlockList(arg_56_0)
	return arg_56_0._blockInitConfig and arg_56_0._blockInitConfig.configList
end

function var_0_0.getInitBlock(arg_57_0, arg_57_1)
	return arg_57_0._blockInitConfig and arg_57_0._blockInitConfig.configDict[arg_57_1]
end

function var_0_0.getInitBlockByXY(arg_58_0, arg_58_1, arg_58_2)
	local var_58_0 = arg_58_0._blockInitConfig and arg_58_0._blockInitConfig.poscfgDict

	return var_58_0 and var_58_0[arg_58_1] and var_58_0[arg_58_1][arg_58_2]
end

function var_0_0.getSceneTaskList(arg_59_0)
	local var_59_0 = {}

	for iter_59_0, iter_59_1 in ipairs(arg_59_0._sceneTaskConfig.configList) do
		if iter_59_1.isOnline then
			table.insert(var_59_0, iter_59_1)
		end
	end

	return arg_59_0._sceneTaskConfig.configList
end

function var_0_0.getBuildingConfigList(arg_60_0)
	return arg_60_0._roomBuildingConfig.configList
end

function var_0_0.getProductionPartConfig(arg_61_0, arg_61_1)
	return arg_61_0._productionPartConfig.configDict[arg_61_1]
end

function var_0_0.getProductionPartConfigList(arg_62_0)
	return arg_62_0._productionPartConfig.configList
end

function var_0_0.getProductionPartByLineId(arg_63_0, arg_63_1)
	return arg_63_0._productionLineToPart[arg_63_1]
end

function var_0_0.getProductionLineConfig(arg_64_0, arg_64_1)
	return arg_64_0._productionLineConfig.configDict[arg_64_1]
end

function var_0_0.getProductionLineLevelGroupIdConfig(arg_65_0, arg_65_1)
	return arg_65_0._productionLineLevelConfig.configDict[arg_65_1]
end

function var_0_0.getProductionLineLevelGroupMaxLevel(arg_66_0, arg_66_1)
	local var_66_0 = arg_66_0._productionLineLevelConfig.configDict[arg_66_1]
	local var_66_1 = 1

	if var_66_0 then
		var_66_1 = tabletool.len(var_66_0)
	end

	return var_66_1
end

function var_0_0.getProductionLineLevelConfig(arg_67_0, arg_67_1, arg_67_2)
	return (arg_67_0._productionLineLevelConfig.configDict[arg_67_1] or {})[arg_67_2]
end

function var_0_0.getProductionLineLevelConfigList(arg_68_0, arg_68_1)
	local var_68_0 = arg_68_0._productionLineLevelConfig.configDict[arg_68_1]
	local var_68_1 = {}

	for iter_68_0, iter_68_1 in pairs(var_68_0) do
		table.insert(var_68_1, iter_68_1)
	end

	table.sort(var_68_1, function(arg_69_0, arg_69_1)
		return arg_69_0.id < arg_69_1.id
	end)

	return var_68_1
end

function var_0_0.getCharacterLimitAddByBuildDegree(arg_70_0, arg_70_1)
	local var_70_0 = 0

	for iter_70_0, iter_70_1 in ipairs(arg_70_0._buildingBonusConfig.configList) do
		if arg_70_1 < iter_70_1.buildDegree then
			break
		end

		var_70_0 = iter_70_1.characterLimitAdd
	end

	return var_70_0
end

function var_0_0.getBuildBonusByBuildDegree(arg_71_0, arg_71_1)
	local var_71_0 = 0
	local var_71_1 = 0
	local var_71_2 = 1

	for iter_71_0, iter_71_1 in ipairs(arg_71_0._buildingBonusConfig.configList) do
		if arg_71_1 < iter_71_1.buildDegree then
			var_71_1 = iter_71_1.buildDegree - arg_71_1

			break
		end

		var_71_2 = iter_71_0 + 1
		var_71_0 = iter_71_1.bonus
	end

	return var_71_0, var_71_1, var_71_2
end

function var_0_0.getCharacterInteractionConfig(arg_72_0, arg_72_1)
	return arg_72_0._roomCharacterInteractionConfig.configDict[arg_72_1]
end

function var_0_0.getCharacterInteractionConfigList(arg_73_0)
	return arg_73_0._roomCharacterInteractionConfig.configList
end

function var_0_0.getCharacterInteractionConfigListByHeroId(arg_74_0, arg_74_1)
	if not arg_74_0._roomCharacterInteractionConfigHeroDict then
		arg_74_0._roomCharacterInteractionConfigHeroDict = arg_74_0:_toListDictByKeyName(arg_74_0._roomCharacterInteractionConfig.configList, "heroId")
	end

	return arg_74_0._roomCharacterInteractionConfigHeroDict[arg_74_1]
end

function var_0_0.getCharacterDialogConfig(arg_75_0, arg_75_1, arg_75_2)
	return arg_75_0._roomCharacterDialogConfig.configDict[arg_75_1] and arg_75_0._roomCharacterDialogConfig.configDict[arg_75_1][arg_75_2]
end

function var_0_0.getCharacterDialogSelectConfig(arg_76_0, arg_76_1)
	return arg_76_0._roomCharacterDialogSelectConfig.configDict[arg_76_1]
end

function var_0_0.getThemeConfig(arg_77_0, arg_77_1)
	return arg_77_0._roomThemeConfig and arg_77_0._roomThemeConfig.configDict[arg_77_1]
end

function var_0_0.getThemeConfigList(arg_78_0)
	return arg_78_0._roomThemeConfig and arg_78_0._roomThemeConfig.configList
end

function var_0_0.getThemeIdByItem(arg_79_0, arg_79_1, arg_79_2)
	if arg_79_2 == nil or arg_79_1 == nil then
		return nil
	end

	if arg_79_2 == MaterialEnum.MaterialType.SpecialBlock then
		local var_79_0 = arg_79_0:getBlock(arg_79_1)

		if var_79_0 then
			arg_79_1 = var_79_0.packageId
			arg_79_2 = MaterialEnum.MaterialType.BlockPackage
		end
	end

	return arg_79_0._itemIdToRoomThemeId and arg_79_0._itemIdToRoomThemeId[arg_79_2] and arg_79_0._itemIdToRoomThemeId[arg_79_2][arg_79_1]
end

function var_0_0.getThemeCollectionRewards(arg_80_0, arg_80_1)
	return arg_80_0._roomThemeCollectionBonusDic and arg_80_0._roomThemeCollectionBonusDic[arg_80_1]
end

function var_0_0.getVehicleConfig(arg_81_0, arg_81_1)
	return arg_81_0._roomVehicleConfig and arg_81_0._roomVehicleConfig.configDict[arg_81_1]
end

function var_0_0.getVehicleConfigList(arg_82_0)
	return arg_82_0._roomVehicleConfig and arg_82_0._roomVehicleConfig.configList
end

function var_0_0.getSourcesTypeConfig(arg_83_0, arg_83_1)
	return arg_83_0._roomSourcesTypeConfig and arg_83_0._roomSourcesTypeConfig[arg_83_1]
end

function var_0_0.getCharacterAnimConfig(arg_84_0, arg_84_1, arg_84_2)
	return arg_84_0._roomCharacterAnimConfig.configDict[arg_84_1] and arg_84_0._roomCharacterAnimConfig.configDict[arg_84_1][arg_84_2]
end

function var_0_0.getCharacterShadowConfig(arg_85_0, arg_85_1, arg_85_2)
	return arg_85_0.roomCharacterShadowConfig and arg_85_0.roomCharacterShadowConfig.configDict[arg_85_1] and arg_85_0.roomCharacterShadowConfig.configDict[arg_85_1][arg_85_2]
end

function var_0_0.getBlockPlacePositionCfgList(arg_86_0)
	return arg_86_0._blockPlacePositionConfig and arg_86_0._blockPlacePositionConfig.configList
end

function var_0_0.getAudioExtendConfig(arg_87_0, arg_87_1)
	return arg_87_0._roomAudioExtendConfig and arg_87_0._roomAudioExtendConfig.configDict[arg_87_1]
end

function var_0_0.getPlanCoverConfig(arg_88_0, arg_88_1)
	return arg_88_0._roomLayoutPlanCoverConfig and arg_88_0._roomLayoutPlanCoverConfig.configDict[arg_88_1]
end

function var_0_0.getPlanCoverConfigList(arg_89_0)
	return arg_89_0._roomLayoutPlanCoverConfig and arg_89_0._roomLayoutPlanCoverConfig.configList
end

function var_0_0.getSceneAmbientConfigList(arg_90_0)
	return arg_90_0._roomSceneAmbientConfig and arg_90_0._roomSceneAmbientConfig.configList
end

function var_0_0.getSceneAmbientConfig(arg_91_0, arg_91_1)
	return arg_91_0._roomSceneAmbientConfig and arg_91_0._roomSceneAmbientConfig.configDict[arg_91_1]
end

function var_0_0.getBuildingTypeCfg(arg_92_0, arg_92_1, arg_92_2)
	local var_92_0 = lua_room_building_type.configDict[arg_92_1]

	if not var_92_0 and arg_92_2 then
		logError(string.format("RoomConfig.getBuildingTypeCfg error, cfg is nil, buildingType:%s", arg_92_1))
	end

	return var_92_0
end

function var_0_0.getBuildingTypeIcon(arg_93_0, arg_93_1)
	local var_93_0
	local var_93_1 = arg_93_0:getBuildingTypeCfg(arg_93_1, true)

	if var_93_1 then
		var_93_0 = var_93_1.icon
	end

	return var_93_0
end

local function var_0_2(arg_94_0, arg_94_1)
	local var_94_0 = lua_room_atmosphere.configDict[arg_94_0]

	if not var_94_0 and arg_94_1 then
		logError(string.format("RoomConfig.getRoomAtmosphereCfg error, cfg is nil, id:%s", arg_94_0))
	end

	return var_94_0
end

function var_0_0.getAtmosphereCfg(arg_95_0, arg_95_1)
	return var_0_2(arg_95_1, true)
end

function var_0_0.getAtmosphereRelatedBuilding(arg_96_0, arg_96_1)
	local var_96_0 = 0
	local var_96_1 = var_0_2(arg_96_1, true)

	if var_96_1 then
		var_96_0 = var_96_1.buildingId
	end

	return var_96_0
end

function var_0_0.getAtmosphereEffectIdList(arg_97_0, arg_97_1)
	local var_97_0 = {}
	local var_97_1 = var_0_2(arg_97_1, true)

	if var_97_1 then
		var_97_0 = string.splitToNumber(var_97_1.effectSequence, "#")
	end

	return var_97_0
end

function var_0_0.getAtmosphereAllEffectPathList(arg_98_0, arg_98_1)
	local var_98_0 = {}
	local var_98_1 = arg_98_0:getAtmosphereEffectIdList(arg_98_1)
	local var_98_2 = arg_98_0:getAtmosphereResidentEffect(arg_98_1)

	if var_98_2 and var_98_2 ~= 0 then
		var_98_1[#var_98_1 + 1] = var_98_2
	end

	for iter_98_0, iter_98_1 in ipairs(var_98_1) do
		local var_98_3 = arg_98_0:getRoomEffectPath(iter_98_1)

		if not GameResMgr.IsFromEditorDir then
			var_98_3 = FightHelper.getEffectAbPath(var_98_3)
		end

		if not string.nilorempty(var_98_3) then
			var_98_0[#var_98_0 + 1] = var_98_3
		end
	end

	return var_98_0
end

function var_0_0.getAtmosphereResidentEffect(arg_99_0, arg_99_1)
	local var_99_0 = 0
	local var_99_1 = var_0_2(arg_99_1, true)

	if var_99_1 then
		var_99_0 = var_99_1.residentEffect
	end

	return var_99_0
end

function var_0_0.getAtmosphereCyclesTimes(arg_100_0, arg_100_1)
	local var_100_0 = 0
	local var_100_1 = var_0_2(arg_100_1, true)

	if var_100_1 then
		var_100_0 = var_100_1.cyclesTimes
	end

	return var_100_0
end

function var_0_0.getAtmosphereOpenTime(arg_101_0, arg_101_1)
	local var_101_0 = 0
	local var_101_1 = var_0_2(arg_101_1, true)

	if var_101_1 then
		local var_101_2 = var_101_1.openTime

		var_101_0 = TimeUtil.stringToTimestamp(var_101_2)
	end

	return var_101_0
end

function var_0_0.getAtmosphereDurationDay(arg_102_0, arg_102_1)
	local var_102_0 = 0
	local var_102_1 = var_0_2(arg_102_1, true)

	if var_102_1 then
		var_102_0 = var_102_1.durationDay
	end

	return var_102_0
end

function var_0_0.getAtmosphereTriggerType(arg_103_0, arg_103_1)
	local var_103_0 = 0
	local var_103_1 = var_0_2(arg_103_1, true)

	if var_103_1 then
		var_103_0 = var_103_1.triggerType
	end

	return var_103_0
end

function var_0_0.getBuildingAtmospheres(arg_104_0, arg_104_1)
	local var_104_0 = {}

	var_104_0 = arg_104_0._building2AtmosphereIds and arg_104_0._building2AtmosphereIds[arg_104_1] or var_104_0

	return var_104_0
end

local function var_0_3(arg_105_0, arg_105_1)
	local var_105_0 = lua_room_effect.configDict[arg_105_0]

	if not var_105_0 and arg_105_1 then
		logError(string.format("RoomConfig.getRoomEffectCfg error, cfg is nil, id:%s", arg_105_0))
	end

	return var_105_0
end

function var_0_0.getRoomEffectPath(arg_106_0, arg_106_1)
	local var_106_0
	local var_106_1 = var_0_3(arg_106_1, true)

	if var_106_1 then
		var_106_0 = var_106_1.resPath
	end

	return var_106_0
end

function var_0_0.getRoomEffectDuration(arg_107_0, arg_107_1)
	local var_107_0 = 0
	local var_107_1 = var_0_3(arg_107_1, true)

	if var_107_1 then
		var_107_0 = var_107_1.duration
	end

	return var_107_0
end

function var_0_0.getRoomEffectAudioId(arg_108_0, arg_108_1)
	local var_108_0
	local var_108_1 = var_0_3(arg_108_1, true)

	if var_108_1 then
		var_108_0 = var_108_1.audioId
	end

	return var_108_0
end

local function var_0_4(arg_109_0, arg_109_1)
	local var_109_0 = lua_room_water_reform.configDict[arg_109_0]

	if not var_109_0 and arg_109_1 then
		logError(string.format("RoomConfig.getRoomWaterReformCfg error, cfg is nil, id:%s", arg_109_0))
	end

	return var_109_0
end

function var_0_0.getWaterReformTypeList(arg_110_0)
	local var_110_0 = {}

	if lua_room_water_reform and lua_room_water_reform.configList then
		for iter_110_0, iter_110_1 in ipairs(lua_room_water_reform.configList) do
			var_110_0[#var_110_0 + 1] = iter_110_1.blockType
		end
	end

	return var_110_0
end

function var_0_0.getWaterReformTypeBlockId(arg_111_0, arg_111_1)
	local var_111_0
	local var_111_1 = var_0_4(arg_111_1, true)

	if var_111_1 then
		var_111_0 = var_111_1.blockId
	end

	return var_111_0
end

function var_0_0.getWaterReformTypeBlockCfg(arg_112_0, arg_112_1)
	local var_112_0
	local var_112_1 = arg_112_0:getWaterReformTypeBlockId(arg_112_1)

	if var_112_1 then
		var_112_0 = arg_112_0:getBlock(var_112_1)
		var_112_0 = var_112_0 or {
			mainRes = 0,
			blockId = var_112_1,
			defineWaterType = arg_112_1,
			defineId = RoomBlockEnum.WaterReformCommonDefineId
		}
	end

	return var_112_0
end

function var_0_0.getWaterReformItemId(arg_113_0, arg_113_1)
	local var_113_0 = var_0_4(arg_113_1, true)

	return var_113_0 and var_113_0.itemId or 0
end

function var_0_0.getWaterTypeByBlockId(arg_114_0, arg_114_1)
	if not arg_114_0._blockId2WaterReformTypeDict then
		arg_114_0:_initBlockId2WaterReformTypeDict()
	end

	return arg_114_0._blockId2WaterReformTypeDict[arg_114_1]
end

function var_0_0._initBlockId2WaterReformTypeDict(arg_115_0)
	arg_115_0._blockId2WaterReformTypeDict = {}

	for iter_115_0, iter_115_1 in ipairs(lua_room_water_reform.configList) do
		arg_115_0._blockId2WaterReformTypeDict[iter_115_1.blockId] = iter_115_1.blockType
	end
end

local function var_0_5(arg_116_0, arg_116_1)
	local var_116_0 = lua_room_skin.configDict[arg_116_0]

	if not var_116_0 and arg_116_1 then
		logError(string.format("RoomConfig.getRoomSkinCfg error, cfg is nil, id:%s", arg_116_0))
	end

	return var_116_0
end

function var_0_0.getAllSkinIdList(arg_117_0)
	local var_117_0 = {}

	if lua_room_skin and lua_room_skin.configList then
		for iter_117_0, iter_117_1 in ipairs(lua_room_skin.configList) do
			var_117_0[#var_117_0 + 1] = iter_117_1.id
		end
	end

	return var_117_0
end

function var_0_0.getSkinIdList(arg_118_0, arg_118_1)
	local var_118_0 = {}
	local var_118_1 = arg_118_1 and arg_118_0._roomType2SkinsDict and arg_118_0._roomType2SkinsDict[arg_118_1]

	if var_118_1 then
		var_118_0 = tabletool.copy(var_118_1)
	end

	return var_118_0
end

function var_0_0.getBelongPart(arg_119_0, arg_119_1)
	local var_119_0
	local var_119_1 = var_0_5(arg_119_1, true)

	if var_119_1 then
		var_119_0 = var_119_1.type
	end

	return var_119_0
end

function var_0_0.getRoomSkinUnlockItemId(arg_120_0, arg_120_1)
	local var_120_0
	local var_120_1 = var_0_5(arg_120_1, true)

	if var_120_1 then
		var_120_0 = var_120_1.itemId
	end

	return var_120_0
end

function var_0_0.getRoomSkinName(arg_121_0, arg_121_1)
	local var_121_0 = ""
	local var_121_1 = var_0_5(arg_121_1, true)

	if var_121_1 then
		var_121_0 = var_121_1.name
	end

	return var_121_0
end

function var_0_0.getRoomSkinActId(arg_122_0, arg_122_1)
	local var_122_0
	local var_122_1 = var_0_5(arg_122_1, true)

	if var_122_1 then
		var_122_0 = var_122_1.activity
	end

	return var_122_0
end

function var_0_0.getRoomSkinIcon(arg_123_0, arg_123_1)
	local var_123_0
	local var_123_1 = var_0_5(arg_123_1, true)

	if var_123_1 then
		var_123_0 = var_123_1.icon
	end

	return var_123_0
end

function var_0_0.getRoomSkinDesc(arg_124_0, arg_124_1)
	local var_124_0 = ""
	local var_124_1 = var_0_5(arg_124_1, true)

	if var_124_1 then
		var_124_0 = var_124_1.desc
	end

	return var_124_0
end

function var_0_0.getRoomSkinBannerIcon(arg_125_0, arg_125_1)
	local var_125_0 = ""
	local var_125_1 = var_0_5(arg_125_1, true)

	if var_125_1 then
		var_125_0 = var_125_1.bannerIcon
	end

	return var_125_0
end

function var_0_0.getRoomSkinRare(arg_126_0, arg_126_1)
	local var_126_0
	local var_126_1 = var_0_5(arg_126_1, true)

	if var_126_1 then
		var_126_0 = var_126_1.rare
	end

	return var_126_0
end

function var_0_0.getRoomSkinPriority(arg_127_0, arg_127_1)
	local var_127_0
	local var_127_1 = var_0_5(arg_127_1, true)

	if var_127_1 then
		var_127_0 = var_127_1.priority
	end

	return var_127_0
end

function var_0_0.getRoomSkinModelPath(arg_128_0, arg_128_1)
	local var_128_0
	local var_128_1 = var_0_5(arg_128_1, true)

	if var_128_1 then
		var_128_0 = var_128_1.model
	end

	return var_128_0
end

function var_0_0.getRoomSkinEquipEffPos(arg_129_0, arg_129_1)
	local var_129_0
	local var_129_1 = var_0_5(arg_129_1, true)

	if var_129_1 then
		var_129_0 = var_129_1.equipEffPos
	end

	return var_129_0
end

function var_0_0.getRoomSkinEquipEffSize(arg_130_0, arg_130_1)
	local var_130_0
	local var_130_1 = var_0_5(arg_130_1, true)

	if var_130_1 then
		var_130_0 = var_130_1.equipEffSize
	end

	return var_130_0
end

function var_0_0.getRoomSkinSources(arg_131_0, arg_131_1)
	local var_131_0
	local var_131_1 = var_0_5(arg_131_1, true)

	if var_131_1 then
		var_131_0 = var_131_1.sources
	end

	return var_131_0
end

var_0_0.instance = var_0_0.New()

return var_0_0
