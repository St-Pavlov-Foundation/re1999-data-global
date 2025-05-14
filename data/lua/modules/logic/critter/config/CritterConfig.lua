module("modules.logic.critter.config.CritterConfig", package.seeall)

local var_0_0 = class("CritterConfig", BaseConfig)

function var_0_0.reqConfigNames(arg_1_0)
	return {
		"critter_const",
		"critter",
		"critter_skin",
		"critter_attribute",
		"critter_attribute_level",
		"critter_tag",
		"critter_train_event",
		"critter_hero_preference",
		"critter_summon",
		"critter_interaction_effect",
		"critter_interaction_audio",
		"critter_summon_pool",
		"critter_rare",
		"critter_catalogue",
		"critter_filter_type",
		"critter_patience_change"
	}
end

function var_0_0.onInit(arg_2_0)
	return
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0[string.format("%sConfigLoaded", arg_3_1)]

	if var_3_0 then
		var_3_0(arg_3_0, arg_3_2)
	end
end

function var_0_0.critter_interaction_effectConfigLoaded(arg_4_0, arg_4_1)
	arg_4_0._commonInteractionEffDict = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_1.configDict) do
		for iter_4_2, iter_4_3 in pairs(iter_4_1) do
			if string.nilorempty(iter_4_3.animName) then
				if not string.nilorempty(iter_4_3.effectKey) then
					arg_4_0._commonInteractionEffDict[iter_4_2] = iter_4_3
				else
					logError(string.format("CritterConfig:critter_interaction_effectConfigLoaded error, cfg no animName and effectKey, skinId:%s id:%s", iter_4_0, iter_4_2))
				end
			end
		end
	end
end

function var_0_0.critter_interaction_audioConfigLoaded(arg_5_0, arg_5_1)
	arg_5_0._critterAudioDict = {}

	for iter_5_0, iter_5_1 in pairs(arg_5_1.configDict) do
		for iter_5_2, iter_5_3 in pairs(iter_5_1) do
			local var_5_0 = string.splitToNumber(iter_5_3.audioId, "#")

			if var_5_0 and #var_5_0 > 0 then
				local var_5_1 = arg_5_0._critterAudioDict[iter_5_0] or {}

				var_5_1[iter_5_2] = var_5_1[iter_5_2] or {}

				tabletool.addValues(var_5_1[iter_5_2], var_5_0)

				arg_5_0._critterAudioDict[iter_5_0] = var_5_1
			end
		end
	end
end

function var_0_0.getCritterConstStr(arg_6_0, arg_6_1)
	local var_6_0
	local var_6_1 = lua_critter_const.configDict[arg_6_1]

	if var_6_1 then
		var_6_0 = var_6_1.value

		if string.nilorempty(var_6_0) then
			var_6_0 = var_6_1.value2
		end
	else
		logError(string.format("CritterConfig:getCritterConstStr error, cfg is nil, id:%s", arg_6_1))
	end

	return var_6_0
end

function var_0_0.getCritterCfg(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = lua_critter.configDict[arg_7_1]

	if not var_7_0 and arg_7_2 then
		logError(string.format("CritterConfig:getCritterCfg error, cfg is nil, critterId:%s", arg_7_1))
	end

	return var_7_0
end

function var_0_0.getCritterName(arg_8_0, arg_8_1)
	local var_8_0 = ""
	local var_8_1 = arg_8_0:getCritterCfg(arg_8_1, true)

	if var_8_1 then
		var_8_0 = var_8_1.name
	end

	return var_8_0
end

function var_0_0.getCritterRare(arg_9_0, arg_9_1)
	local var_9_0
	local var_9_1 = arg_9_0:getCritterCfg(arg_9_1, true)

	if var_9_1 then
		var_9_0 = var_9_1.rare
	end

	return var_9_0
end

function var_0_0.getCritterCatalogue(arg_10_0, arg_10_1)
	local var_10_0
	local var_10_1 = arg_10_0:getCritterCfg(arg_10_1, true)

	if var_10_1 then
		var_10_0 = var_10_1.catalogue
	end

	return var_10_0
end

function var_0_0.getCritterNormalSkin(arg_11_0, arg_11_1)
	local var_11_0
	local var_11_1 = arg_11_0:getCritterCfg(arg_11_1, true)

	if var_11_1 then
		var_11_0 = var_11_1.normalSkin
	end

	return var_11_0
end

function var_0_0.getCritterMutateSkin(arg_12_0, arg_12_1)
	local var_12_0
	local var_12_1 = arg_12_0:getCritterCfg(arg_12_1, true)

	if var_12_1 then
		var_12_0 = var_12_1.mutateSkin
	end

	return var_12_0
end

function var_0_0.getCritterSpecialRate(arg_13_0, arg_13_1)
	local var_13_0 = 0
	local var_13_1 = arg_13_0:getCritterCfg(arg_13_1, true)

	if var_13_1 then
		var_13_0 = var_13_1.specialRate
	end

	return var_13_0
end

function var_0_0.isFavoriteFood(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = false

	if not arg_14_0._critterFavoriteFoodDict then
		arg_14_0._critterFavoriteFoodDict = {}
	end

	if arg_14_1 then
		local var_14_1 = arg_14_0._critterFavoriteFoodDict[arg_14_1]

		if not var_14_1 then
			var_14_1 = arg_14_0:getFoodLikeDict(arg_14_1)
			arg_14_0._critterFavoriteFoodDict[arg_14_1] = var_14_1
		end

		var_14_0 = var_14_1[arg_14_2] or false
	end

	return var_14_0
end

function var_0_0.getFoodLikeDict(arg_15_0, arg_15_1)
	local var_15_0 = {}
	local var_15_1 = arg_15_0:getCritterCfg(arg_15_1, true)
	local var_15_2 = GameUtil.splitString2(var_15_1 and var_15_1.foodLike)

	if var_15_2 then
		for iter_15_0, iter_15_1 in ipairs(var_15_2) do
			var_15_0[tonumber(iter_15_1[1])] = true
		end
	end

	return var_15_0
end

function var_0_0.getCritterCount(arg_16_0)
	return #lua_critter.configList
end

function var_0_0.getCritterSkinCfg(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = lua_critter_skin.configDict[arg_17_1]

	if not var_17_0 and arg_17_2 then
		logError(string.format("CritterConfig:getCritterSkinCfg error, cfg is nil, skinId:%s", arg_17_1))
	end

	return var_17_0
end

function var_0_0.getCritterHeadIcon(arg_18_0, arg_18_1)
	local var_18_0
	local var_18_1 = arg_18_0:getCritterSkinCfg(arg_18_1, true)

	if var_18_1 then
		var_18_0 = var_18_1.headIcon
	end

	return var_18_0
end

function var_0_0.getCritterLargeIcon(arg_19_0, arg_19_1)
	local var_19_0
	local var_19_1 = arg_19_0:getCritterSkinCfg(arg_19_1, true)

	if var_19_1 then
		var_19_0 = var_19_1.largeIcon
	end

	return var_19_0
end

function var_0_0.getCritterAttributeCfg(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = lua_critter_attribute.configDict[arg_20_1]

	if not var_20_0 and arg_20_2 then
		logError(string.format("CritterConfig:getCritterAttributeCfg error, cfg is nil, attributeId:%s", arg_20_1))
	end

	return var_20_0
end

function var_0_0.getCritterAttributeLevelCfg(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = lua_critter_attribute_level.configDict[arg_21_1]

	if not var_21_0 and arg_21_2 then
		logError(string.format("CritterConfig:getCritterAttributeLevelCfg error, cfg is nil, level:%s", arg_21_1))
	end

	return var_21_0
end

function var_0_0.getCritterAttributeLevelCfgByValue(arg_22_0, arg_22_1)
	local var_22_0 = lua_critter_attribute_level.configList
	local var_22_1

	for iter_22_0 = 1, #var_22_0 do
		local var_22_2 = var_22_0[iter_22_0]

		if arg_22_1 >= var_22_2.minValue and (var_22_1 == nil or var_22_1.level < var_22_2.level) then
			var_22_1 = var_22_2
		end
	end

	return var_22_1
end

function var_0_0.getMaxCritterAttributeLevelCfg(arg_23_0)
	if arg_23_0._critterAttributeLevelMaxCfg == nil then
		local var_23_0 = lua_critter_attribute_level.configList
		local var_23_1

		for iter_23_0 = 1, #var_23_0 do
			local var_23_2 = var_23_0[iter_23_0]

			if var_23_1 == nil or var_23_1.level < var_23_2.level then
				var_23_1 = var_23_2
			end
		end

		arg_23_0._critterAttributeLevelMaxCfg = var_23_1
	end

	return arg_23_0._critterAttributeLevelMaxCfg
end

function var_0_0.getCritterAttributeMax(arg_24_0)
	arg_24_0:getMaxCritterAttributeLevelCfg()

	return arg_24_0._critterAttributeLevelMaxCfg.minValue
end

function var_0_0.getCritterTagCfg(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = lua_critter_tag.configDict[arg_25_1]

	if not var_25_0 and arg_25_2 then
		logError(string.format("CritterConfig:getCritterTagCfg error, cfg is nil, tagId:%s", arg_25_1))
	end

	return var_25_0
end

function var_0_0.getCritterTrainEventCfg(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = lua_critter_train_event.configDict[arg_26_1]

	if not var_26_0 and arg_26_2 then
		logError(string.format("CritterConfig:getCritterTrainEventCfg error, cfg is nil, eventId:%s", arg_26_1))
	end

	return var_26_0
end

function var_0_0.getCritterHeroPreferenceCfg(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = lua_critter_hero_preference.configDict[arg_27_1]

	if not var_27_0 and arg_27_2 then
		logError(string.format("CritterConfig:getCritterHeroPreferenceCfg error, cfg is nil, heroId:%s", arg_27_1))
	end

	return var_27_0
end

function var_0_0.getCritterSummonCfg(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = lua_critter_summon.configDict[arg_28_1]

	if not var_28_0 and arg_28_2 then
		logError(string.format("CritterConfig:getCritterSummonCfg error, cfg is nil, summonId:%s", arg_28_1))
	end

	return var_28_0
end

function var_0_0.getCritterSummonPoolCfg(arg_29_0, arg_29_1, arg_29_2)
	local var_29_0 = lua_critter_summon_pool.configDict[arg_29_1]

	if not var_29_0 and arg_29_2 then
		logError(string.format("CritterConfig:getCritterSummonPoolCfg error, cfg is nil, summonId:%s", arg_29_1))
	end

	return var_29_0
end

function var_0_0.getCritterFilterTypeCfg(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = lua_critter_filter_type.configDict[arg_30_1]

	if not var_30_0 and arg_30_2 then
		logError(string.format("CritterConfig:getCritterFilterTypeCfg error, cfg is nil, id:%s", arg_30_1))
	end

	return var_30_0
end

function var_0_0.getCritterTabDataList(arg_31_0, arg_31_1)
	local var_31_0 = {}
	local var_31_1 = arg_31_0:getCritterFilterTypeCfg(arg_31_1, true)

	if var_31_1 then
		local var_31_2 = string.splitToNumber(var_31_1.filterTab, "#")
		local var_31_3 = {}

		if arg_31_1 == CritterEnum.FilterType.Race then
			for iter_31_0, iter_31_1 in ipairs(var_31_2) do
				var_31_3[iter_31_0] = arg_31_0:getCritterCatalogueCfg(iter_31_1).name
			end
		else
			var_31_3 = string.split(var_31_1.tabName, "#")
		end

		local var_31_4 = string.split(var_31_1.tabIcon, "#")

		for iter_31_2, iter_31_3 in ipairs(var_31_2) do
			var_31_0[iter_31_2] = {
				filterTab = iter_31_3,
				name = var_31_3[iter_31_2],
				icon = var_31_4[iter_31_2]
			}
		end
	end

	return var_31_0
end

function var_0_0.getCritterEffectList(arg_32_0, arg_32_1)
	if not arg_32_0._critterSkinEffectDict then
		arg_32_0._critterSkinEffectDict = {}
		arg_32_0._critterSkinAnimEffectDict = {}

		local var_32_0 = arg_32_0._critterSkinEffectDict

		for iter_32_0, iter_32_1 in ipairs(lua_critter_interaction_effect.configList) do
			if not var_32_0[iter_32_1.skinId] then
				var_32_0[iter_32_1.skinId] = {}
				arg_32_0._critterSkinAnimEffectDict[iter_32_1.skinId] = {}
			end

			table.insert(var_32_0[iter_32_1.skinId], iter_32_1)

			local var_32_1 = arg_32_0._critterSkinAnimEffectDict[iter_32_1.skinId]

			if not var_32_1[iter_32_1.animName] then
				var_32_1[iter_32_1.animName] = {}
			end

			table.insert(var_32_1[iter_32_1.animName], iter_32_1)
		end
	end

	return arg_32_0._critterSkinEffectDict[arg_32_1]
end

function var_0_0.getCritterCommonInteractionEffCfg(arg_33_0, arg_33_1)
	local var_33_0

	if arg_33_0._commonInteractionEffDict then
		var_33_0 = arg_33_0._commonInteractionEffDict[arg_33_1]
	end

	return var_33_0
end

function var_0_0.getAllCritterCommonInteractionEffKeyList(arg_34_0)
	local var_34_0 = {}

	if arg_34_0._commonInteractionEffDict then
		for iter_34_0, iter_34_1 in pairs(arg_34_0._commonInteractionEffDict) do
			var_34_0[#var_34_0 + 1] = iter_34_1.effectKey
		end
	end

	return var_34_0
end

function var_0_0.getCritterEffectListByAnimName(arg_35_0, arg_35_1, arg_35_2)
	if not arg_35_0._critterSkinAnimEffectDict then
		arg_35_0:getCritterEffectList(arg_35_1)
	end

	return arg_35_0._critterSkinAnimEffectDict[arg_35_1] and arg_35_0._critterSkinAnimEffectDict[arg_35_1][arg_35_2]
end

function var_0_0.getCritterRareCfg(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = lua_critter_rare.configDict[arg_36_1]

	if not var_36_0 and arg_36_2 then
		logError(string.format("CritterConfig:getCritterRareCfg error, cfg is nil, summonId:%s", arg_36_1))
	end

	return var_36_0
end

function var_0_0.getCritterInteractionAudioList(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = {}

	if arg_37_0._critterAudioDict and arg_37_0._critterAudioDict[arg_37_1] then
		var_37_0 = arg_37_0._critterAudioDict[arg_37_1][arg_37_2] or {}
	end

	return var_37_0
end

function var_0_0.getCritterCatalogueCfg(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = lua_critter_catalogue.configDict[arg_38_1]

	if not var_38_0 and arg_38_2 then
		logError(string.format("CritterConfig:getCritterCatalogueCfg error, cfg is nil, id:%s", arg_38_1))
	end

	return var_38_0
end

function var_0_0.getBaseCard(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0:getCritterCatalogueCfg(arg_39_1)

	return var_39_0 and var_39_0.baseCard
end

function var_0_0.isHasCatalogueChildId(arg_40_0, arg_40_1, arg_40_2)
	if not arg_40_0._catalogueChildIdMapDict then
		arg_40_0:_initCatalogueChildIdList_()
	end

	return arg_40_0._catalogueChildIdMapDict[arg_40_1] and arg_40_0._catalogueChildIdMapDict[arg_40_1][arg_40_2]
end

function var_0_0.getCatalogueChildIdMap(arg_41_0, arg_41_1)
	if not arg_41_0._catalogueChildIdMapDict then
		arg_41_0:_initCatalogueChildIdList_()
	end

	return arg_41_0._catalogueChildIdMapDict[arg_41_1]
end

function var_0_0.getCatalogueChildIdList(arg_42_0, arg_42_1)
	if not arg_42_0._catalogueChildIdsDict then
		arg_42_0:_initCatalogueChildIdList_()
	end

	return arg_42_0._catalogueChildIdsDict[arg_42_1]
end

function var_0_0._initCatalogueChildIdList_(arg_43_0)
	if not arg_43_0._catalogueChildIdsDict then
		arg_43_0._catalogueChildIdsDict = {}
		arg_43_0._catalogueChildIdMapDict = {}

		local var_43_0 = lua_critter_catalogue.configList

		for iter_43_0 = 1, #var_43_0 do
			local var_43_1 = var_43_0[iter_43_0].id
			local var_43_2, var_43_3 = arg_43_0:_findCatalogueChildIdList_(var_43_1, var_43_0)

			arg_43_0._catalogueChildIdsDict[var_43_1] = var_43_2
			arg_43_0._catalogueChildIdMapDict[var_43_1] = var_43_3
		end
	end
end

function var_0_0._findCatalogueChildIdList_(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = {}
	local var_44_1 = {}
	local var_44_2 = 0

	while arg_44_1 do
		for iter_44_0 = 1, #arg_44_2 do
			local var_44_3 = arg_44_2[iter_44_0]

			if var_44_3.parentId == arg_44_1 and not var_44_1[var_44_3.id] then
				var_44_1[var_44_3.id] = true

				table.insert(var_44_0, var_44_3.id)
			end
		end

		var_44_2 = var_44_2 + 1
		arg_44_1 = var_44_0[var_44_2]
	end

	return var_44_0, var_44_1
end

function var_0_0.getPatienceChangeCfg(arg_45_0, arg_45_1)
	return lua_critter_patience_change.configDict[arg_45_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
