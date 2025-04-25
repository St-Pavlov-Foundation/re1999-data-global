module("modules.logic.critter.config.CritterConfig", package.seeall)

slot0 = class("CritterConfig", BaseConfig)

function slot0.reqConfigNames(slot0)
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

function slot0.onInit(slot0)
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot0[string.format("%sConfigLoaded", slot1)] then
		slot4(slot0, slot2)
	end
end

function slot0.critter_interaction_effectConfigLoaded(slot0, slot1)
	slot0._commonInteractionEffDict = {}

	for slot5, slot6 in pairs(slot1.configDict) do
		for slot10, slot11 in pairs(slot6) do
			if string.nilorempty(slot11.animName) then
				if not string.nilorempty(slot11.effectKey) then
					slot0._commonInteractionEffDict[slot10] = slot11
				else
					logError(string.format("CritterConfig:critter_interaction_effectConfigLoaded error, cfg no animName and effectKey, skinId:%s id:%s", slot5, slot10))
				end
			end
		end
	end
end

function slot0.critter_interaction_audioConfigLoaded(slot0, slot1)
	slot0._critterAudioDict = {}

	for slot5, slot6 in pairs(slot1.configDict) do
		for slot10, slot11 in pairs(slot6) do
			if string.splitToNumber(slot11.audioId, "#") and #slot12 > 0 then
				slot13 = slot0._critterAudioDict[slot5] or {}
				slot13[slot10] = slot13[slot10] or {}

				tabletool.addValues(slot13[slot10], slot12)

				slot0._critterAudioDict[slot5] = slot13
			end
		end
	end
end

function slot0.getCritterConstStr(slot0, slot1)
	slot2 = nil

	if lua_critter_const.configDict[slot1] then
		if string.nilorempty(slot3.value) then
			slot2 = slot3.value2
		end
	else
		logError(string.format("CritterConfig:getCritterConstStr error, cfg is nil, id:%s", slot1))
	end

	return slot2
end

function slot0.getCritterCfg(slot0, slot1, slot2)
	if not lua_critter.configDict[slot1] and slot2 then
		logError(string.format("CritterConfig:getCritterCfg error, cfg is nil, critterId:%s", slot1))
	end

	return slot3
end

function slot0.getCritterName(slot0, slot1)
	slot2 = ""

	if slot0:getCritterCfg(slot1, true) then
		slot2 = slot3.name
	end

	return slot2
end

function slot0.getCritterRare(slot0, slot1)
	slot2 = nil

	if slot0:getCritterCfg(slot1, true) then
		slot2 = slot3.rare
	end

	return slot2
end

function slot0.getCritterCatalogue(slot0, slot1)
	slot2 = nil

	if slot0:getCritterCfg(slot1, true) then
		slot2 = slot3.catalogue
	end

	return slot2
end

function slot0.getCritterNormalSkin(slot0, slot1)
	slot2 = nil

	if slot0:getCritterCfg(slot1, true) then
		slot2 = slot3.normalSkin
	end

	return slot2
end

function slot0.getCritterMutateSkin(slot0, slot1)
	slot2 = nil

	if slot0:getCritterCfg(slot1, true) then
		slot2 = slot3.mutateSkin
	end

	return slot2
end

function slot0.getCritterSpecialRate(slot0, slot1)
	slot2 = 0

	if slot0:getCritterCfg(slot1, true) then
		slot2 = slot3.specialRate
	end

	return slot2
end

function slot0.isFavoriteFood(slot0, slot1, slot2)
	slot3 = false

	if not slot0._critterFavoriteFoodDict then
		slot0._critterFavoriteFoodDict = {}
	end

	if slot1 then
		if not slot0._critterFavoriteFoodDict[slot1] then
			slot0._critterFavoriteFoodDict[slot1] = slot0:getFoodLikeDict(slot1)
		end

		slot3 = slot4[slot2] or false
	end

	return slot3
end

function slot0.getFoodLikeDict(slot0, slot1)
	slot2 = {}

	if GameUtil.splitString2(slot0:getCritterCfg(slot1, true) and slot3.foodLike) then
		for slot8, slot9 in ipairs(slot4) do
			slot2[tonumber(slot9[1])] = true
		end
	end

	return slot2
end

function slot0.getCritterCount(slot0)
	return #lua_critter.configList
end

function slot0.getCritterSkinCfg(slot0, slot1, slot2)
	if not lua_critter_skin.configDict[slot1] and slot2 then
		logError(string.format("CritterConfig:getCritterSkinCfg error, cfg is nil, skinId:%s", slot1))
	end

	return slot3
end

function slot0.getCritterHeadIcon(slot0, slot1)
	slot2 = nil

	if slot0:getCritterSkinCfg(slot1, true) then
		slot2 = slot3.headIcon
	end

	return slot2
end

function slot0.getCritterLargeIcon(slot0, slot1)
	slot2 = nil

	if slot0:getCritterSkinCfg(slot1, true) then
		slot2 = slot3.largeIcon
	end

	return slot2
end

function slot0.getCritterAttributeCfg(slot0, slot1, slot2)
	if not lua_critter_attribute.configDict[slot1] and slot2 then
		logError(string.format("CritterConfig:getCritterAttributeCfg error, cfg is nil, attributeId:%s", slot1))
	end

	return slot3
end

function slot0.getCritterAttributeLevelCfg(slot0, slot1, slot2)
	if not lua_critter_attribute_level.configDict[slot1] and slot2 then
		logError(string.format("CritterConfig:getCritterAttributeLevelCfg error, cfg is nil, level:%s", slot1))
	end

	return slot3
end

function slot0.getCritterAttributeLevelCfgByValue(slot0, slot1)
	slot3 = nil

	for slot7 = 1, #lua_critter_attribute_level.configList do
		if slot2[slot7].minValue <= slot1 and (slot3 == nil or slot3.level < slot8.level) then
			slot3 = slot8
		end
	end

	return slot3
end

function slot0.getMaxCritterAttributeLevelCfg(slot0)
	if slot0._critterAttributeLevelMaxCfg == nil then
		slot2 = nil

		for slot6 = 1, #lua_critter_attribute_level.configList do
			slot7 = slot1[slot6]

			if slot2 == nil or slot2.level < slot7.level then
				slot2 = slot7
			end
		end

		slot0._critterAttributeLevelMaxCfg = slot2
	end

	return slot0._critterAttributeLevelMaxCfg
end

function slot0.getCritterAttributeMax(slot0)
	slot0:getMaxCritterAttributeLevelCfg()

	return slot0._critterAttributeLevelMaxCfg.minValue
end

function slot0.getCritterTagCfg(slot0, slot1, slot2)
	if not lua_critter_tag.configDict[slot1] and slot2 then
		logError(string.format("CritterConfig:getCritterTagCfg error, cfg is nil, tagId:%s", slot1))
	end

	return slot3
end

function slot0.getCritterTrainEventCfg(slot0, slot1, slot2)
	if not lua_critter_train_event.configDict[slot1] and slot2 then
		logError(string.format("CritterConfig:getCritterTrainEventCfg error, cfg is nil, eventId:%s", slot1))
	end

	return slot3
end

function slot0.getCritterHeroPreferenceCfg(slot0, slot1, slot2)
	if not lua_critter_hero_preference.configDict[slot1] and slot2 then
		logError(string.format("CritterConfig:getCritterHeroPreferenceCfg error, cfg is nil, heroId:%s", slot1))
	end

	return slot3
end

function slot0.getCritterSummonCfg(slot0, slot1, slot2)
	if not lua_critter_summon.configDict[slot1] and slot2 then
		logError(string.format("CritterConfig:getCritterSummonCfg error, cfg is nil, summonId:%s", slot1))
	end

	return slot3
end

function slot0.getCritterSummonPoolCfg(slot0, slot1, slot2)
	if not lua_critter_summon_pool.configDict[slot1] and slot2 then
		logError(string.format("CritterConfig:getCritterSummonPoolCfg error, cfg is nil, summonId:%s", slot1))
	end

	return slot3
end

function slot0.getCritterFilterTypeCfg(slot0, slot1, slot2)
	if not lua_critter_filter_type.configDict[slot1] and slot2 then
		logError(string.format("CritterConfig:getCritterFilterTypeCfg error, cfg is nil, id:%s", slot1))
	end

	return slot3
end

function slot0.getCritterTabDataList(slot0, slot1)
	slot2 = {}

	if slot0:getCritterFilterTypeCfg(slot1, true) then
		slot4 = string.splitToNumber(slot3.filterTab, "#")
		slot5 = {}

		if slot1 == CritterEnum.FilterType.Race then
			for slot9, slot10 in ipairs(slot4) do
				slot5[slot9] = slot0:getCritterCatalogueCfg(slot10).name
			end
		else
			slot5 = string.split(slot3.tabName, "#")
		end

		for slot10, slot11 in ipairs(slot4) do
			slot2[slot10] = {
				filterTab = slot11,
				name = slot5[slot10],
				icon = string.split(slot3.tabIcon, "#")[slot10]
			}
		end
	end

	return slot2
end

function slot0.getCritterEffectList(slot0, slot1)
	if not slot0._critterSkinEffectDict then
		slot0._critterSkinEffectDict = {}
		slot0._critterSkinAnimEffectDict = {}
		slot2 = slot0._critterSkinEffectDict

		for slot6, slot7 in ipairs(lua_critter_interaction_effect.configList) do
			if not slot2[slot7.skinId] then
				slot2[slot7.skinId] = {}
				slot0._critterSkinAnimEffectDict[slot7.skinId] = {}
			end

			table.insert(slot2[slot7.skinId], slot7)

			if not slot0._critterSkinAnimEffectDict[slot7.skinId][slot7.animName] then
				slot8[slot7.animName] = {}
			end

			table.insert(slot8[slot7.animName], slot7)
		end
	end

	return slot0._critterSkinEffectDict[slot1]
end

function slot0.getCritterCommonInteractionEffCfg(slot0, slot1)
	slot2 = nil

	if slot0._commonInteractionEffDict then
		slot2 = slot0._commonInteractionEffDict[slot1]
	end

	return slot2
end

function slot0.getAllCritterCommonInteractionEffKeyList(slot0)
	slot1 = {}

	if slot0._commonInteractionEffDict then
		for slot5, slot6 in pairs(slot0._commonInteractionEffDict) do
			slot1[#slot1 + 1] = slot6.effectKey
		end
	end

	return slot1
end

function slot0.getCritterEffectListByAnimName(slot0, slot1, slot2)
	if not slot0._critterSkinAnimEffectDict then
		slot0:getCritterEffectList(slot1)
	end

	return slot0._critterSkinAnimEffectDict[slot1] and slot0._critterSkinAnimEffectDict[slot1][slot2]
end

function slot0.getCritterRareCfg(slot0, slot1, slot2)
	if not lua_critter_rare.configDict[slot1] and slot2 then
		logError(string.format("CritterConfig:getCritterRareCfg error, cfg is nil, summonId:%s", slot1))
	end

	return slot3
end

function slot0.getCritterInteractionAudioList(slot0, slot1, slot2)
	slot3 = {}

	if slot0._critterAudioDict and slot0._critterAudioDict[slot1] then
		slot3 = slot0._critterAudioDict[slot1][slot2] or {}
	end

	return slot3
end

function slot0.getCritterCatalogueCfg(slot0, slot1, slot2)
	if not lua_critter_catalogue.configDict[slot1] and slot2 then
		logError(string.format("CritterConfig:getCritterCatalogueCfg error, cfg is nil, id:%s", slot1))
	end

	return slot3
end

function slot0.getBaseCard(slot0, slot1)
	return slot0:getCritterCatalogueCfg(slot1) and slot2.baseCard
end

function slot0.isHasCatalogueChildId(slot0, slot1, slot2)
	if not slot0._catalogueChildIdMapDict then
		slot0:_initCatalogueChildIdList_()
	end

	return slot0._catalogueChildIdMapDict[slot1] and slot0._catalogueChildIdMapDict[slot1][slot2]
end

function slot0.getCatalogueChildIdMap(slot0, slot1)
	if not slot0._catalogueChildIdMapDict then
		slot0:_initCatalogueChildIdList_()
	end

	return slot0._catalogueChildIdMapDict[slot1]
end

function slot0.getCatalogueChildIdList(slot0, slot1)
	if not slot0._catalogueChildIdsDict then
		slot0:_initCatalogueChildIdList_()
	end

	return slot0._catalogueChildIdsDict[slot1]
end

function slot0._initCatalogueChildIdList_(slot0)
	if not slot0._catalogueChildIdsDict then
		slot0._catalogueChildIdsDict = {}
		slot0._catalogueChildIdMapDict = {}

		for slot5 = 1, #lua_critter_catalogue.configList do
			slot7 = slot1[slot5].id
			slot0._catalogueChildIdsDict[slot7], slot0._catalogueChildIdMapDict[slot7] = slot0:_findCatalogueChildIdList_(slot7, slot1)
		end
	end
end

function slot0._findCatalogueChildIdList_(slot0, slot1, slot2)
	slot3 = {}
	slot4 = {}
	slot5 = 0

	while slot1 do
		for slot9 = 1, #slot2 do
			if slot2[slot9].parentId == slot1 and not slot4[slot10.id] then
				slot4[slot10.id] = true

				table.insert(slot3, slot10.id)
			end
		end

		slot1 = slot3[slot5 + 1]
	end

	return slot3, slot4
end

function slot0.getPatienceChangeCfg(slot0, slot1)
	return lua_critter_patience_change.configDict[slot1]
end

slot0.instance = slot0.New()

return slot0
