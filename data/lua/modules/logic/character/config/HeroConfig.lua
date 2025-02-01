module("modules.logic.character.config.HeroConfig", package.seeall)

slot0 = class("HeroConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0.heroConfig = nil
	slot0.attributeConfig = nil
	slot0.battleTagConfig = nil
	slot0.friendLessConfig = nil
	slot0.talent_cube_attr_config = nil
	slot0.maxFaith = 0
end

function slot0.reqConfigNames(slot0)
	return {
		"character",
		"character_attribute",
		"character_battle_tag",
		"friendless",
		"talent_cube_attr",
		"hero_trial",
		"hero_trial_attr",
		"hero_group_type",
		"character_limited"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "character" then
		slot0.heroConfig = slot2
	elseif slot1 == "character_attribute" then
		slot0.attributeConfig = slot2

		slot0:processAttrConfig()
	elseif slot1 == "character_battle_tag" then
		slot0.battleTagConfig = slot2
	elseif slot1 == "friendless" then
		slot0.friendLessConfig = slot2

		for slot6 = 1, #slot0.friendLessConfig.configDict do
			slot0.maxFaith = slot0.maxFaith + slot0.friendLessConfig.configDict[slot6].friendliness
		end
	elseif slot1 == "talent_cube_attr" then
		slot0.talent_cube_attr_config = slot2
	elseif slot1 == "hero_group_type" then
		slot0.heroGroupTypeDict = {}

		for slot6, slot7 in pairs(slot2.configList) do
			for slot12, slot13 in pairs(string.splitToNumber(slot7.chapterIds, "#") or {}) do
				slot0.heroGroupTypeDict[slot13] = slot7
			end
		end
	elseif slot1 == "hero_trial" then
		slot0.heroTrialConfig = slot2.configDict
	end
end

function slot0.getTrial104Equip(slot0, slot1, slot2, slot3)
	if slot0.heroTrialConfig[slot2] and slot0.heroTrialConfig[slot2][slot3 or 0] then
		return slot4["act104EquipId" .. tostring(slot1)]
	end
end

function slot0.getHeroCO(slot0, slot1)
	return slot0.heroConfig.configDict[slot1]
end

function slot0.getHeroGroupTypeCo(slot0, slot1)
	if not slot1 then
		return
	end

	return slot0.heroGroupTypeDict[slot1] or lua_hero_group_type.configDict[ModuleEnum.HeroGroupServerType.Activity]
end

function slot0.getHeroAttributesCO(slot0)
	return slot0.attributeConfig.configDict
end

function slot0.getHeroAttributeCO(slot0, slot1)
	return slot0.attributeConfig.configDict[slot1]
end

function slot0.getBattleTagConfigCO(slot0, slot1)
	return slot0.battleTagConfig.configDict[slot1]
end

function slot0.getTalentCubeAttrConfig(slot0, slot1, slot2)
	return slot0.talent_cube_attr_config.configDict[slot1][slot2]
end

function slot0.getTalentCubeMaxLevel(slot0, slot1)
	if not slot0.max_talent_level_dic then
		slot0.max_talent_level_dic = {}
	end

	if slot0.max_talent_level_dic[slot1] then
		return slot0.max_talent_level_dic[slot1]
	end

	for slot6, slot7 in pairs(slot0.talent_cube_attr_config.configDict[slot1]) do
		if 0 <= slot7.level then
			slot2 = slot7.level
		end
	end

	slot0.max_talent_level_dic[slot1] = slot2

	return slot2
end

function slot0.getAnyRareCharacterCount(slot0, slot1)
	for slot7, slot8 in pairs(slot0.heroConfig.configDict) do
		if slot8.rare == slot1 then
			slot3 = 0 + 1
		end
	end

	return slot3
end

function slot0.getAnyOnlineRareCharacterCount(slot0, slot1)
	for slot6, slot7 in pairs(slot0.heroConfig.configDict) do
		if slot7.rare == slot1 then
			if slot7.isOnline == "1" then
				slot2 = 0 + 1
			elseif slot7.isOnline ~= "0" and TimeUtil.stringToTimestamp(slot7.isOnline) < ServerTime.Now() then
				slot2 = slot2 + 1
			end
		end
	end

	return slot2
end

function slot0.getFaithPercent(slot0, slot1)
	if slot0.maxFaith <= slot1 then
		return {
			1,
			0
		}
	end

	slot2 = 0
	slot3 = 0
	slot4 = 0

	for slot8 = 1, #slot0.friendLessConfig.configDict do
		if slot1 <= slot2 + slot0.friendLessConfig.configDict[slot8].friendliness then
			if slot2 == slot1 then
				slot3 = slot0.friendLessConfig.configDict[slot8].percentage
				slot4 = slot0.friendLessConfig.configDict[slot8 + 1].friendliness

				break
			end

			slot3 = slot0.friendLessConfig.configDict[slot8 - 1].percentage
			slot4 = slot2 - slot1

			break
		end
	end

	return {
		slot3 / 100,
		slot4
	}
end

function slot0.getMaxRank(slot0, slot1)
	if slot1 <= 3 then
		return 2
	else
		return 3
	end
end

function slot0.getLevelUpItems(slot0, slot1, slot2, slot3)
	slot4 = {}
	slot5 = slot0:getHeroCO(slot1)

	for slot9 = slot2 + 1, slot3 do
		for slot16 = 1, #string.split(SkillConfig.instance:getcosumeCO(slot9, slot5.rare).cosume, "|") do
			slot17 = string.split(slot12[slot16], "#")

			if not slot4[slot16] then
				slot4[slot16] = {
					type = tonumber(slot17[1]),
					id = tonumber(slot17[2]),
					quantity = tonumber(slot17[3]),
					name = ""
				}
			else
				slot4[slot16].quantity = slot4[slot16].quantity + tonumber(slot17[3])
			end
		end
	end

	return slot4
end

function slot0.getShowLevel(slot0, slot1)
	if not slot0._rankMaxLevels then
		slot0._rankMaxLevels = string.splitToNumber(CommonConfig.instance:getConstStr(ConstEnum.RankMaxLevel), "#")
	end

	slot2 = nil

	for slot6 = #slot0._rankMaxLevels, 1, -1 do
		if slot0._rankMaxLevels[slot6] < slot1 then
			return slot1 - slot2, slot6 + 1
		end
	end

	return slot1, 1
end

function slot0.getCommonLevelDisplay(slot0, slot1)
	slot2, slot3 = slot0:getShowLevel(slot1)

	if slot3 == 1 then
		return string.format(luaLang("rank_level_display1"), slot2)
	elseif slot3 == 2 then
		return string.format(luaLang("rank_level_display2"), slot2)
	elseif slot3 == 3 then
		return string.format(luaLang("rank_level_display3"), slot2)
	elseif slot3 == 4 then
		return string.format(luaLang("rank_level_display4"), slot2)
	else
		return string.format(luaLang("rank_level_display1"), slot2)
	end
end

function slot0.getLevelDisplayVariant(slot0, slot1)
	if slot1 == 0 then
		return luaLang("hero_display_level0_variant")
	end

	slot2, slot3 = slot0:getShowLevel(slot1)

	if slot3 == 1 then
		return string.format(luaLang("rank_level_display1"), slot2)
	elseif slot3 == 2 then
		return string.format(luaLang("rank_level_display2"), slot2)
	elseif slot3 == 3 then
		return string.format(luaLang("rank_level_display3"), slot2)
	elseif slot3 == 4 then
		return string.format(luaLang("rank_level_display4"), slot2)
	else
		return string.format(luaLang("rank_level_display1"), slot2)
	end
end

function slot0.processAttrConfig(slot0)
	slot0.attrConfigByAttrType = {}

	for slot4, slot5 in pairs(slot0.attributeConfig.configDict) do
		slot0.attrConfigByAttrType[slot5.attrType] = slot5.id
	end

	slot0.attrConfigByAttrType.atk = 102
	slot0.attrConfigByAttrType.def = 103
	slot0.attrConfigByAttrType.mdef = 104
	slot0.attrConfigByAttrType.cri_dmg = 203
	slot0.attrConfigByAttrType.cri_def = 204
	slot0.attrConfigByAttrType.add_dmg = 205
	slot0.attrConfigByAttrType.drop_dmg = 206
end

function slot0.getIDByAttrType(slot0, slot1)
	return slot0.attrConfigByAttrType[slot1]
end

function slot0.getAttrTypeByID(slot0, slot1)
	return slot0.attributeConfig.configDict[slot1] and slot0.attributeConfig.configDict[slot1].attrType
end

function slot0.talentGainTab2IDTab(slot0, slot1)
	slot2 = {
		[slot8] = {}
	}

	for slot6, slot7 in pairs(slot1) do
		slot8 = slot0:getIDByAttrType(slot6)
		slot2[slot8].config_id = slot8
		slot2[slot8].id = slot8
		slot2[slot8].value = slot7.value
	end

	return slot2
end

function slot0.getHeroesList(slot0)
	slot1 = {}

	for slot7, slot8 in ipairs(slot0.heroConfig.configList) do
		if tonumber(slot8.isOnline) == 1 and (VersionValidator.instance:isInReviewing() == false or ResSplitConfig.instance:getAllCharacterIds()[slot8.id]) then
			table.insert(slot1, slot8)
		end
	end

	return slot1
end

function slot0.getHeroesByType(slot0, slot1)
	slot2 = {}

	for slot8, slot9 in ipairs(slot0.heroConfig.configList) do
		if tonumber(slot9.isOnline) == 1 and slot9.heroType == slot1 and (VersionValidator.instance:isInReviewing() == false or ResSplitConfig.instance:getAllCharacterIds()[slot9.id]) then
			table.insert(slot2, slot9)
		end
	end

	return slot2
end

function slot0.sortAttr(slot0, slot1)
	return uv0.instance:getIDByAttrType(slot0.key or slot0.attrType) < uv0.instance:getIDByAttrType(slot1.key or slot1.attrType)
end

slot1 = {
	mdef = 4,
	def = 3,
	hp = 2,
	atk = 1
}

function slot0.sortAttrForEquipView(slot0, slot1)
	return uv0[slot0.attrType] < uv0[slot1.attrType]
end

function slot0.getHeroAttrRate(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(lua_character_grow.configList) do
		if SkillConfig.instance:getherolevelCO(slot1, 1)[slot2] < slot8[slot2] then
			return slot8.id - 1 == 0 and 1 or slot8.id - 1
		end
	end

	return lua_character_grow.configList[#lua_character_grow.configList].id
end

slot0.instance = slot0.New()

return slot0
