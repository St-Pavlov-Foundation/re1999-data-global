module("modules.logic.character.config.CharacterDataConfig", package.seeall)

slot0 = class("CharacterDataConfig", BaseConfig)
slot0.DefaultSkinDataKey = 0

function slot0.ctor(slot0)
	slot0._voiceConfig = nil
	slot0._episodeConfig = nil
	slot0._shopVoiceConfig = nil
	slot0._dataConfig = {}
	slot0._characterDataSkinList = {}
	slot0._characterDrawingStateDict = {}

	if string.nilorempty(PlayerPrefsHelper.getString(PlayerPrefsKey.CharacterDrawingState, "")) then
		return
	end

	if not string.split(slot1, "|") or #slot2 < 1 then
		return
	end

	for slot6, slot7 in ipairs(slot2) do
		if not string.nilorempty(slot7) and string.splitToNumber(slot7, "#") and #slot8 == 2 then
			slot0._characterDrawingStateDict[slot8[1]] = slot8[2]
		end
	end
end

function slot0.reqConfigNames(slot0)
	return {
		"character_data",
		"character_voice",
		"episode",
		"character_motion_cut",
		"character_motion_effect",
		"character_motion_play_cut",
		"character_shop_voice",
		"character_face_effect",
		"character_motion_special",
		"character_special_interaction_voice",
		"story_hero_to_character"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "character_data" then
		slot3, slot4, slot5, slot6 = nil

		for slot10, slot11 in ipairs(slot2.configList) do
			if not slot0._dataConfig[slot11.heroId] then
				slot0._dataConfig[slot11.heroId] = {}
			end

			if not slot3[slot11.skinId] then
				slot3[slot11.skinId] = {}
			end

			if not slot4[slot11.type] then
				slot4[slot11.type] = {}
			end

			slot5[slot11.number] = slot11

			if not slot0._characterDataSkinList[slot11.heroId] then
				slot0._characterDataSkinList[slot11.heroId] = {}
			end

			if not tabletool.indexOf(slot6, slot11.skinId) then
				table.insert(slot6, slot11.skinId)
			end
		end

		for slot11, slot12 in pairs(slot0._dataConfig) do
			setmetatable(slot12, {
				__index = function (slot0, slot1)
					return slot0[uv0.DefaultSkinDataKey]
				end
			})
		end
	elseif slot1 == "character_voice" then
		slot0._voiceConfig = slot2
	elseif slot1 == "episode" then
		slot0._episodeConfig = slot2
	elseif slot1 == "character_shop_voice" then
		slot0._shopVoiceConfig = slot2
	end
end

function slot0.getMotionSpecial(slot0, slot1)
	for slot5, slot6 in ipairs(lua_character_motion_special.configList) do
		if string.find(slot1, slot6.heroResName) then
			return slot6
		end
	end
end

function slot0.getCharacterDrawingState(slot0, slot1)
	return slot0._characterDrawingStateDict[slot1] or 0
end

function slot0.setCharacterDrawingState(slot0, slot1, slot2)
	slot0._characterDrawingStateDict[slot1] = slot2
	slot4 = 1

	for slot8, slot9 in pairs(slot0._characterDrawingStateDict) do
		if slot4 > 1 then
			slot3 = "" .. "|"
		end

		slot3 = slot3 .. string.format("%d#%d", slot8, slot9)
		slot4 = slot4 + 1
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.CharacterDrawingState, slot3)
end

function slot0.getCharacterDataCO(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6, slot7 = nil

	return (slot0._dataConfig[slot1][slot2][slot3] or slot0._dataConfig[slot1][uv0.DefaultSkinDataKey][slot3])[slot4] or slot0._dataConfig[slot1][uv0.DefaultSkinDataKey][slot3][slot4]
end

function slot0.getDataConfig(slot0)
	return slot0._dataConfig
end

function slot0.geCharacterSkinIdList(slot0, slot1)
	return slot0._characterDataSkinList[slot1]
end

function slot0.getCharacterVoiceCO(slot0, slot1, slot2)
	return slot0._voiceConfig.configDict[slot1] and slot0._voiceConfig.configDict[slot1][slot2]
end

function slot0.getCharacterTypeVoicesCO(slot0, slot1, slot2, slot3)
	slot4 = {}

	if slot0._voiceConfig.configDict[slot1] then
		for slot9, slot10 in pairs(slot5) do
			if slot10.type == slot2 and slot0:_checkSkin(slot10, slot3) then
				table.insert(slot4, slot10)
			end
		end
	end

	return slot4
end

function slot0._checkSkin(slot0, slot1, slot2)
	if not slot1 then
		return false
	end

	if string.nilorempty(slot1.skins) or not slot2 then
		return true
	end

	return string.find(slot1.skins, slot2)
end

function slot0.getCharacterVoicesCo(slot0, slot1)
	return slot0._voiceConfig.configDict[slot1]
end

function slot0.checkVoiceSkin(slot0, slot1, slot2)
	slot3 = false

	if slot1 then
		slot3 = string.nilorempty(slot1.skins) and true or string.find(slot1.skins, slot2)
	end

	return slot3
end

function slot0.getMonsterHp(slot0, slot1, slot2)
	slot3 = slot2 and "templateEasy" or "template"
	slot4 = slot2 and "levelEasy" or "level"

	if lua_monster.configDict[slot1] then
		if not slot2 and slot0:calculateMonsterHpNewFunc(slot5) then
			return slot6
		end

		if lua_monster_template.configDict[slot5[slot3]] then
			return slot6.life + slot5[slot4] * slot6.lifeGrow
		end
	end

	return 0
end

function slot0.calculateMonsterHpNewFunc(slot0, slot1)
	if lua_monster_skill_template.configDict[slot1.skillTemplate] and slot2.instance > 0 then
		if not lua_monster_instance.configDict[slot2.instance] then
			return
		end

		if not lua_monster_sub.configDict[slot3.sub] then
			return
		end

		if not lua_monster_level.configDict[slot3.level] then
			return
		end

		if not lua_monster_job.configDict[slot3[slot4.job]] then
			return
		end

		if slot3.multiHp > 1 then
			slot7 = math.floor(slot4.life * (slot6.life_base * slot5.base + slot6.life_equip_base * slot5.equip_base) * slot3.life / 100000000) / slot3.multiHp
		end

		return slot7
	end
end

function slot0.getMonsterAttributeScoreList(slot0, slot1)
	if not lua_monster_skill_template.configDict[lua_monster.configDict[slot1].skillTemplate] then
		return {}
	end

	if slot3 and slot3.instance > 0 and lua_monster_instance.configDict[slot3.instance] and lua_monster_sub.configDict[slot4.sub] then
		return string.splitToNumber(slot5.score, "#")
	end

	return string.splitToNumber(slot3.template, "#")
end

function slot0.getChapterNameFromId(slot0, slot1)
	return slot0._episodeConfig.configDict[slot1].name
end

function slot0.getConditionStringName(slot0, slot1)
	if HeroModel.instance:getByHeroId(slot1.heroId) and slot1.type == CharacterEnum.VoiceType.GetSkin and string.nilorempty(slot1.unlockCondition) and not string.nilorempty(slot1.param) then
		return luaLang("hero_voice_skin_unlock")
	elseif slot3 and slot1.type == CharacterEnum.VoiceType.BreakThrough and string.nilorempty(slot2) then
		return luaLang("hero_voice_rank_reach_unlock")
	end

	if string.nilorempty(slot2) then
		return ""
	end

	slot4 = string.split(slot2, "#")

	if tonumber(slot4[1]) == 1 then
		return string.format(luaLang("hero_hint_reach_unlock"), tonumber(slot4[2]))
	elseif slot5 == 2 then
		return string.format(luaLang("hero_rank_reach_unlock"), slot6)
	elseif slot5 == 3 then
		return string.format(luaLang("hero_lv_reach_unlock"), slot0:getChapterNameFromId(slot6))
	elseif slot5 == 4 then
		return string.format(luaLang("condition_reach_unlock"), slot6)
	else
		logError("未指定的条件类型 " .. slot5)

		return ""
	end
end

function slot0.checkLockCondition(slot0, slot1)
	slot3 = false

	if slot1.unlockConditine ~= "" then
		slot4 = string.splitToNumber(slot2, "#")

		if slot4[1] == CharacterEnum.CharacterDataUnLockType.Faith then
			slot3 = slot0:_checkNum(slot4[2], HeroConfig.instance:getFaithPercent(HeroModel.instance:getByHeroId(slot1.heroId).faith)[1] * 100)
		elseif slot6 == CharacterEnum.CharacterDataUnLockType.RankLevel then
			slot3 = slot0:_checkNum(slot7, slot5.rank)
		elseif slot6 == CharacterEnum.CharacterDataUnLockType.Level then
			slot3 = slot0:_checkNum(slot7, slot5.level)
		elseif slot6 == CharacterEnum.CharacterDataUnLockType.SkillLevel then
			slot3 = slot0:_checkNum(slot7, slot5.exSkillLevel)
		elseif slot6 == CharacterEnum.CharacterDataUnLockType.TalentLevel then
			slot3 = slot0:_checkNum(slot7, slot5.talent)
		elseif slot6 == CharacterEnum.CharacterDataUnLockType.Episode then
			slot3 = slot0:_checkNum(tonumber(slot7), PlayerModel.instance:getPlayinfo().lastEpisodeId)
		else
			logError("未知的解锁条件类型, " .. tostring(slot6))

			slot3 = false
		end
	end

	return slot3
end

function slot0._checkNum(slot0, slot1, slot2)
	return slot2 < slot1
end

function slot0.getCharacterShopVoicesCo(slot0, slot1)
	return slot0._shopVoiceConfig.configDict[slot1]
end

function slot0.getCharacterShopVoiceCO(slot0, slot1, slot2)
	return slot0:getCharacterShopVoicesCo(slot1) and slot3[slot2]
end

slot0.instance = slot0.New()

return slot0
