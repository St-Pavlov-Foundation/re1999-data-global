module("modules.logic.character.config.CharacterDataConfig", package.seeall)

local var_0_0 = class("CharacterDataConfig", BaseConfig)

var_0_0.DefaultSkinDataKey = 0

function var_0_0.ctor(arg_1_0)
	arg_1_0._voiceConfig = nil
	arg_1_0._episodeConfig = nil
	arg_1_0._shopVoiceConfig = nil
	arg_1_0._dataConfig = {}
	arg_1_0._characterDataSkinList = {}
	arg_1_0._characterDrawingStateDict = {}

	local var_1_0 = PlayerPrefsHelper.getString(PlayerPrefsKey.CharacterDrawingState, "")

	if string.nilorempty(var_1_0) then
		return
	end

	local var_1_1 = string.split(var_1_0, "|")

	if not var_1_1 or #var_1_1 < 1 then
		return
	end

	for iter_1_0, iter_1_1 in ipairs(var_1_1) do
		if not string.nilorempty(iter_1_1) then
			local var_1_2 = string.splitToNumber(iter_1_1, "#")

			if var_1_2 and #var_1_2 == 2 then
				arg_1_0._characterDrawingStateDict[var_1_2[1]] = var_1_2[2]
			end
		end
	end
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"character_data",
		"character_voice",
		"episode",
		"character_motion_cut",
		"character_motion_effect",
		"character_motion_effect_layer",
		"character_motion_play_cut",
		"character_shop_voice",
		"character_face_effect",
		"character_motion_special",
		"character_special_interaction_voice",
		"story_hero_to_character"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "character_data" then
		local var_3_0
		local var_3_1
		local var_3_2
		local var_3_3

		for iter_3_0, iter_3_1 in ipairs(arg_3_2.configList) do
			local var_3_4 = arg_3_0._dataConfig[iter_3_1.heroId]

			if not var_3_4 then
				var_3_4 = {}
				arg_3_0._dataConfig[iter_3_1.heroId] = var_3_4
			end

			local var_3_5 = var_3_4[iter_3_1.skinId]

			if not var_3_5 then
				var_3_5 = {}
				var_3_4[iter_3_1.skinId] = var_3_5
			end

			local var_3_6 = var_3_5[iter_3_1.type]

			if not var_3_6 then
				var_3_6 = {}
				var_3_5[iter_3_1.type] = var_3_6
			end

			var_3_6[iter_3_1.number] = iter_3_1

			local var_3_7 = arg_3_0._characterDataSkinList[iter_3_1.heroId]

			if not var_3_7 then
				var_3_7 = {}
				arg_3_0._characterDataSkinList[iter_3_1.heroId] = var_3_7
			end

			if not tabletool.indexOf(var_3_7, iter_3_1.skinId) then
				table.insert(var_3_7, iter_3_1.skinId)
			end
		end

		local var_3_8 = {
			__index = function(arg_4_0, arg_4_1)
				return arg_4_0[var_0_0.DefaultSkinDataKey]
			end
		}

		for iter_3_2, iter_3_3 in pairs(arg_3_0._dataConfig) do
			setmetatable(iter_3_3, var_3_8)
		end
	elseif arg_3_1 == "character_voice" then
		arg_3_0._voiceConfig = arg_3_2

		if SLFramework.FrameworkSettings.IsEditor then
			CharacterVoiceConfigChecker.instance:checkConfig()
		end
	elseif arg_3_1 == "episode" then
		arg_3_0._episodeConfig = arg_3_2
	elseif arg_3_1 == "character_shop_voice" then
		arg_3_0._shopVoiceConfig = arg_3_2
	end
end

function var_0_0.getMotionSpecial(arg_5_0, arg_5_1)
	for iter_5_0, iter_5_1 in ipairs(lua_character_motion_special.configList) do
		if string.find(arg_5_1, iter_5_1.heroResName) then
			return iter_5_1
		end
	end
end

function var_0_0.getCharacterDrawingState(arg_6_0, arg_6_1)
	return arg_6_0._characterDrawingStateDict[arg_6_1] or 0
end

function var_0_0.setCharacterDrawingState(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._characterDrawingStateDict[arg_7_1] = arg_7_2

	local var_7_0 = ""
	local var_7_1 = 1

	for iter_7_0, iter_7_1 in pairs(arg_7_0._characterDrawingStateDict) do
		if var_7_1 > 1 then
			var_7_0 = var_7_0 .. "|"
		end

		local var_7_2 = string.format("%d#%d", iter_7_0, iter_7_1)

		var_7_0 = var_7_0 .. var_7_2
		var_7_1 = var_7_1 + 1
	end

	PlayerPrefsHelper.setString(PlayerPrefsKey.CharacterDrawingState, var_7_0)
end

function var_0_0.getCharacterDataCO(arg_8_0, arg_8_1, arg_8_2, arg_8_3, arg_8_4)
	local var_8_0
	local var_8_1
	local var_8_2

	return (arg_8_0._dataConfig[arg_8_1][arg_8_2][arg_8_3] or arg_8_0._dataConfig[arg_8_1][var_0_0.DefaultSkinDataKey][arg_8_3])[arg_8_4] or arg_8_0._dataConfig[arg_8_1][var_0_0.DefaultSkinDataKey][arg_8_3][arg_8_4]
end

function var_0_0.getDataConfig(arg_9_0)
	return arg_9_0._dataConfig
end

function var_0_0.geCharacterSkinIdList(arg_10_0, arg_10_1)
	return arg_10_0._characterDataSkinList[arg_10_1]
end

function var_0_0.getCharacterVoiceCO(arg_11_0, arg_11_1, arg_11_2)
	return arg_11_0._voiceConfig.configDict[arg_11_1] and arg_11_0._voiceConfig.configDict[arg_11_1][arg_11_2]
end

function var_0_0.getCharacterTypeVoicesCO(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = {}
	local var_12_1 = arg_12_0._voiceConfig.configDict[arg_12_1]

	if var_12_1 then
		for iter_12_0, iter_12_1 in pairs(var_12_1) do
			if iter_12_1.type == arg_12_2 and arg_12_0:_checkSkin(iter_12_1, arg_12_3) then
				table.insert(var_12_0, iter_12_1)
			end
		end
	end

	return var_12_0
end

function var_0_0._checkSkin(arg_13_0, arg_13_1, arg_13_2)
	if not arg_13_1 then
		return false
	end

	if string.nilorempty(arg_13_1.skins) or not arg_13_2 then
		return true
	end

	return string.find(arg_13_1.skins, arg_13_2)
end

function var_0_0.getCharacterVoicesCo(arg_14_0, arg_14_1)
	return arg_14_0._voiceConfig.configDict[arg_14_1]
end

function var_0_0.checkVoiceSkin(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = false

	if arg_15_1 then
		var_15_0 = string.nilorempty(arg_15_1.skins) and true or string.find(arg_15_1.skins, arg_15_2)
	end

	return var_15_0
end

function var_0_0.getMonsterHp(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_2 and "templateEasy" or "template"
	local var_16_1 = arg_16_2 and "levelEasy" or "level"
	local var_16_2 = lua_monster.configDict[arg_16_1]

	if var_16_2 then
		local var_16_3 = true

		if arg_16_2 then
			local var_16_4 = var_16_2[var_16_0]

			if var_16_4 and var_16_4 > 0 then
				var_16_3 = false
			end
		end

		if var_16_3 then
			local var_16_5 = arg_16_0:calculateMonsterHpNewFunc(var_16_2)

			if var_16_5 then
				return var_16_5
			end
		end

		local var_16_6 = lua_monster_template.configDict[var_16_2[var_16_0]]

		if var_16_6 then
			return var_16_6.life + var_16_2[var_16_1] * var_16_6.lifeGrow
		end
	end

	return 0
end

function var_0_0.calculateMonsterHpNewFunc(arg_17_0, arg_17_1)
	local var_17_0 = lua_monster_skill_template.configDict[arg_17_1.skillTemplate]

	if var_17_0 and var_17_0.instance > 0 then
		local var_17_1 = lua_monster_instance.configDict[var_17_0.instance]

		if not var_17_1 then
			return
		end

		local var_17_2 = lua_monster_sub.configDict[var_17_1.sub]

		if not var_17_2 then
			return
		end

		local var_17_3 = arg_17_1.level_true

		if var_17_3 <= 0 then
			var_17_3 = var_17_1.level
		end

		local var_17_4 = lua_monster_level.configDict[var_17_3]

		if not var_17_4 then
			return
		end

		local var_17_5 = lua_monster_job.configDict[var_17_2.job]

		if not var_17_5 then
			return
		end

		local var_17_6 = var_17_2.life / 10000 * (var_17_5.life_base * var_17_4.base + var_17_5.life_equip_base * var_17_4.equip_base) / 10000 * var_17_1.life / 10000
		local var_17_7 = math.floor(var_17_6)

		if var_17_1.multiHp > 1 then
			var_17_7 = var_17_7 / var_17_1.multiHp
		end

		return var_17_7
	end
end

function var_0_0.getMonsterAttributeScoreList(arg_18_0, arg_18_1)
	local var_18_0 = lua_monster.configDict[arg_18_1]
	local var_18_1 = lua_monster_skill_template.configDict[var_18_0.skillTemplate]

	if not var_18_1 then
		return {}
	end

	if var_18_1 and var_18_1.instance > 0 then
		local var_18_2 = lua_monster_instance.configDict[var_18_1.instance]

		if var_18_2 then
			local var_18_3 = lua_monster_sub.configDict[var_18_2.sub]

			if var_18_3 then
				return string.splitToNumber(var_18_3.score, "#")
			end
		end
	end

	return string.splitToNumber(var_18_1.template, "#")
end

function var_0_0.getChapterNameFromId(arg_19_0, arg_19_1)
	return arg_19_0._episodeConfig.configDict[arg_19_1].name
end

function var_0_0.getConditionStringName(arg_20_0, arg_20_1)
	local var_20_0 = arg_20_1.unlockCondition
	local var_20_1 = HeroModel.instance:getByHeroId(arg_20_1.heroId)

	if var_20_1 and arg_20_1.type == CharacterEnum.VoiceType.GetSkin and string.nilorempty(var_20_0) and not string.nilorempty(arg_20_1.param) then
		return luaLang("hero_voice_skin_unlock")
	elseif var_20_1 and arg_20_1.type == CharacterEnum.VoiceType.BreakThrough and string.nilorempty(var_20_0) then
		return luaLang("hero_voice_rank_reach_unlock")
	end

	if string.nilorempty(var_20_0) then
		return ""
	end

	local var_20_2 = string.split(var_20_0, "#")
	local var_20_3 = tonumber(var_20_2[1])
	local var_20_4 = tonumber(var_20_2[2])

	if var_20_3 == 1 then
		return string.format(luaLang("hero_hint_reach_unlock"), var_20_4)
	elseif var_20_3 == 2 then
		return string.format(luaLang("hero_rank_reach_unlock"), var_20_4)
	elseif var_20_3 == 3 then
		return string.format(luaLang("hero_lv_reach_unlock"), arg_20_0:getChapterNameFromId(var_20_4))
	elseif var_20_3 == 4 then
		return string.format(luaLang("condition_reach_unlock"), var_20_4)
	else
		logError("未指定的条件类型 " .. var_20_3)

		return ""
	end
end

function var_0_0.checkLockCondition(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1.unlockConditine
	local var_21_1 = false

	if var_21_0 ~= "" then
		local var_21_2 = string.splitToNumber(var_21_0, "#")
		local var_21_3 = HeroModel.instance:getByHeroId(arg_21_1.heroId)
		local var_21_4 = var_21_2[1]
		local var_21_5 = var_21_2[2]

		if var_21_4 == CharacterEnum.CharacterDataUnLockType.Faith then
			var_21_1 = arg_21_0:_checkNum(var_21_5, HeroConfig.instance:getFaithPercent(var_21_3.faith)[1] * 100)
		elseif var_21_4 == CharacterEnum.CharacterDataUnLockType.RankLevel then
			var_21_1 = arg_21_0:_checkNum(var_21_5, var_21_3.rank)
		elseif var_21_4 == CharacterEnum.CharacterDataUnLockType.Level then
			var_21_1 = arg_21_0:_checkNum(var_21_5, var_21_3.level)
		elseif var_21_4 == CharacterEnum.CharacterDataUnLockType.SkillLevel then
			var_21_1 = arg_21_0:_checkNum(var_21_5, var_21_3.exSkillLevel)
		elseif var_21_4 == CharacterEnum.CharacterDataUnLockType.TalentLevel then
			var_21_1 = arg_21_0:_checkNum(var_21_5, var_21_3.talent)
		elseif var_21_4 == CharacterEnum.CharacterDataUnLockType.Episode then
			local var_21_6 = PlayerModel.instance:getPlayinfo()

			var_21_1 = arg_21_0:_checkNum(tonumber(var_21_5), var_21_6.lastEpisodeId)
		else
			logError("未知的解锁条件类型, " .. tostring(var_21_4))

			var_21_1 = false
		end
	end

	return var_21_1
end

function var_0_0._checkNum(arg_22_0, arg_22_1, arg_22_2)
	return arg_22_2 < arg_22_1
end

function var_0_0.getCharacterShopVoicesCo(arg_23_0, arg_23_1)
	return arg_23_0._shopVoiceConfig.configDict[arg_23_1]
end

function var_0_0.getCharacterShopVoiceCO(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = arg_24_0:getCharacterShopVoicesCo(arg_24_1)

	return var_24_0 and var_24_0[arg_24_2]
end

var_0_0.instance = var_0_0.New()

return var_0_0
