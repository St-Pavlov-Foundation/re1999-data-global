module("modules.logic.fight.config.FightConfig", package.seeall)

local var_0_0 = class("FightConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	arg_1_0._skillCurrCardLvDict = nil
	arg_1_0._skillNextCardLvDict = nil
	arg_1_0._skillPrevCardLvDict = nil
	arg_1_0._skillHeroIdDict = nil
	arg_1_0._skillMonsterIdDict = nil
	arg_1_0._skinSkillTLDict = nil
	arg_1_0._buffFeatureDict = {}
	arg_1_0._buffFeatureDictDict = {}
	arg_1_0._buffId2FeatureIdList = {}
	arg_1_0._restrainDict = nil
	arg_1_0._monsterId2UniqueId = {}
end

function var_0_0.reqConfigNames(arg_2_0)
	local var_2_0 = {
		"fight_6_buff_effect",
		"fight_buff_layer_effect_enemy_skin",
		"card_description",
		"stance",
		"character",
		"monster",
		"monster_group",
		"monster_template",
		"skin",
		"monster_skin",
		"skill",
		"skill_effect",
		"skill_buff",
		"skill_bufftype",
		"buff_act",
		"skin_spine_action",
		"fight_effect",
		"fight_voice",
		"skill_behavior",
		"fight_technique",
		"skill_behavior_condition",
		"battle_dialog",
		"monster_skill_template",
		"fight_music",
		"monster_guide_focus",
		"fight_timeline_speed",
		"fight_transition_act",
		"fight_stacked_buff_combine",
		"fight_die_act_enemyus",
		"skill_specialbuff",
		"fight_skill_delay",
		"fight_prompt",
		"trigger_action",
		"fight_summon_show",
		"fight_assembled_monster",
		"fight_monster_display_condition",
		"fight_effect_buff_skin",
		"fight_buff_effect_to_skin",
		"fight_debut_show",
		"stance_hp_offset",
		"bossrush_skin_effect",
		"fight_monster_use_character_effect",
		"fight_buff_use_poison_ui_effect",
		"summoned",
		"fight_summoned_stance",
		"fight_next_round_get_card",
		"fight_skin_special_behaviour",
		"fight_replace_timeline",
		"magic_circle",
		"fight_dead_entity_mgr",
		"fight_buff_reject_act",
		"boss_action",
		"boss_action_list",
		"fight_monster_unique_index",
		"fight_boss_evolution_client",
		"fight_replay_enter_scene_root_active",
		"fight_buff_replace_spine_act",
		"hero_upgrade",
		"hero_upgrade_options",
		"fight_upgrade_show_skillid",
		"card_enchant",
		"fight_camera_player_turn_offset",
		"resonance",
		"polarization",
		"fight_buff_layer_effect",
		"fight_buff_layer_effect_nana",
		"fight_skin_replay_lasthit",
		"resistances_attribute",
		"fight_skin_dead_performance",
		"ai_monster_target",
		"ai_monster_card_tag",
		"assist_boss_stance",
		"fight_skin_replace_magic_effect",
		"simple_polarization",
		"fight_card_pre_delete",
		"ai_mark_skill",
		"monster_instance",
		"monster_sub",
		"monster_level",
		"monster_job",
		"card_heat",
		"fight_float_effect",
		"fight_task",
		"fight_monster_skin_idle_map",
		"fight_replace_buff_act_effect",
		"fight_replace_skill_behavior_effect",
		"skill_next",
		"fight_xcjl_const",
		"fight_she_fa_ignite",
		"fight_dnsz",
		"fight_6_buff_effect",
		"fight_lzl_buff_float",
		"fight_buff_layer_effect_enemy_skin",
		"fight_buff_type_id_2_scene_effect",
		"fight_card_choice",
		"buff_mat_variant",
		"character_rank_replace",
		"fight_skin_scale_by_z",
		"fight_luxi_upgrade_effect"
	}

	if SLFramework.FrameworkSettings.IsEditor then
		table.insert(var_2_0, "activity174_test_bot")
		table.insert(var_2_0, "activity174_test_role")
	end

	return var_2_0
end

function var_0_0.getSkinCO(arg_3_0, arg_3_1)
	return lua_skin.configDict[arg_3_1] or lua_monster_skin.configDict[arg_3_1]
end

function var_0_0.getAudioId(arg_4_0, arg_4_1, arg_4_2)
	local var_4_0 = arg_4_0:getSkinCO(arg_4_1)
	local var_4_1 = var_4_0 and var_4_0.showTemplate
	local var_4_2 = var_4_1 and lua_fight_voice.configDict[var_4_1]

	if var_4_2 then
		return var_4_2["audio_type" .. arg_4_2]
	end
end

function var_0_0.onConfigLoaded(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1 == "fight_effect" then
		arg_5_0._restrainDict = {}

		for iter_5_0, iter_5_1 in ipairs(arg_5_2.configList) do
			local var_5_0 = {}

			arg_5_0._restrainDict[iter_5_1.id] = var_5_0

			for iter_5_2 = 1, 6 do
				var_5_0[iter_5_2] = iter_5_1["career" .. iter_5_2]
			end
		end
	elseif arg_5_1 == "skill" then
		arg_5_0._hasLoadSkill = true

		arg_5_0:_rebuildSkillEffect()
	elseif arg_5_1 == "skill_effect" then
		arg_5_0._hasLoadSkillEffect = true

		arg_5_0:_rebuildSkillEffect()
	elseif arg_5_1 == "monster" then
		arg_5_0._hasLoadMonster = true

		arg_5_0:_rebuildMonsterSkin()
	elseif arg_5_1 == "skin" then
		arg_5_0._hasLoadSkin = true

		arg_5_0:_rebuildMonsterSkin()
	elseif arg_5_1 == "skill_buff" then
		-- block empty
	elseif arg_5_1 == "fight_buff_reject_act" then
		arg_5_0:_dealFightBuffRejectAct()
	elseif arg_5_1 == "monster_group" then
		arg_5_0:_checkMonsterGroupBoss0()
	elseif arg_5_1 == "skin_spine_action" then
		-- block empty
	elseif arg_5_1 == "character" then
		local function var_5_1(arg_6_0, arg_6_1, arg_6_2)
			logError("Can't modify config field: " .. arg_6_1)
		end

		for iter_5_3, iter_5_4 in ipairs(arg_5_2.configList) do
			local var_5_2 = getmetatable(iter_5_4)

			var_5_2.__newindex = nil
			iter_5_4.skill = string.split(iter_5_4.skill, ",")[1]
			var_5_2.__newindex = var_5_1
		end
	end
end

function var_0_0._rebuildSkillEffect(arg_7_0)
	if not arg_7_0._hasLoadSkill or not arg_7_0._hasLoadSkillEffect then
		return
	end

	local var_7_0 = getmetatable(lua_skill.configList[1])
	local var_7_1 = {
		__index = function(arg_8_0, arg_8_1)
			local var_8_0 = var_7_0.__index(arg_8_0, arg_8_1)

			if not var_8_0 then
				local var_8_1 = arg_8_0.skillEffect
				local var_8_2 = lua_skill_effect.configDict[var_8_1]

				if var_8_2 then
					if isDebugBuild or SLFramework.FrameworkSettings.IsEditor then
						if arg_8_1 == "desc" and not var_0_0.instance:isSetDescFlag() then
							logError("获取调用效果 desc 字段， 必须使用 FightConfig.getSkillEffectDesc 函数")
						end

						var_8_0 = var_8_2[arg_8_1]
					else
						var_8_0 = var_8_2[arg_8_1]
					end
				else
					logError(arg_8_0.id .. " 技能效果模版不存在：" .. var_8_1)
				end
			end

			return var_8_0
		end,
		__newindex = var_7_0.__newindex
	}

	for iter_7_0, iter_7_1 in ipairs(lua_skill.configList) do
		setmetatable(iter_7_1, var_7_1)
	end

	arg_7_0:_rebuildSkillEffectTab()
end

local var_0_1 = {
	[10151011] = true,
	[10161131] = true,
	[10161141] = true,
	[10161011] = true,
	[10151111] = true,
	[10161021] = true,
	[10141141] = true,
	[10151114] = true,
	[10141131] = true,
	[81261201] = true,
	[81251201] = true,
	[10161111] = true,
	[10151113] = true,
	[10141101] = true,
	[10141111] = true,
	[10161121] = true,
	[10141102] = true,
	[10141121] = true,
	[10151112] = true,
	[10151012] = true
}

function var_0_0._rebuildMonsterSkin(arg_9_0)
	if not arg_9_0._hasLoadMonster or not arg_9_0._hasLoadSkin then
		return
	end

	local var_9_0 = getmetatable(lua_monster.configList[1])
	local var_9_1 = {
		__index = function(arg_10_0, arg_10_1)
			local var_10_0 = var_9_0.__index(arg_10_0, arg_10_1)

			if arg_10_1 == "career" then
				if var_10_0 and var_10_0 > 0 then
					return var_10_0
				end
			elseif var_10_0 then
				return var_10_0
			end

			local var_10_1 = arg_10_0.skillTemplate
			local var_10_2 = lua_monster_skill_template.configDict[var_10_1]

			if not var_10_2 then
				logError(arg_10_0.id .. " 技能效果模版不存在：" .. var_10_1)

				return nil
			end

			local var_10_3 = var_10_2[arg_10_1]

			if var_10_3 then
				if arg_10_1 == "uniqueSkill" then
					local var_10_4 = arg_10_0.id
					local var_10_5 = arg_10_0.uniqueSkillLevel

					if not arg_9_0._monsterId2UniqueId[var_10_4] then
						local var_10_6 = {}
						local var_10_7
						local var_10_8 = FightStrUtil.instance:getSplitCache(var_10_2.uniqueSkill, "|")
						local var_10_9 = lua_fight_monster_unique_index.configDict[var_10_4]

						if var_10_9 then
							var_10_5 = var_10_9.index
						end

						for iter_10_0, iter_10_1 in ipairs(var_10_8) do
							local var_10_10 = FightStrUtil.instance:getSplitToNumberCache(iter_10_1, "#")

							table.insert(var_10_6, var_10_10[var_10_5 <= #var_10_10 and var_10_5 or #var_10_10])
						end

						arg_9_0._monsterId2UniqueId[var_10_4] = var_10_6
					end

					var_10_3 = arg_9_0._monsterId2UniqueId[var_10_4]
				end

				return var_10_3
			end

			local var_10_11 = arg_10_0.skinId

			return var_0_0.instance:getSkinCO(var_10_11)[arg_10_1]
		end,
		__newindex = var_9_0.__newindex
	}

	for iter_9_0, iter_9_1 in ipairs(lua_monster.configList) do
		setmetatable(iter_9_1, var_9_1)
	end

	if isDebugBuild then
		arg_9_0:checkMonsterEffectPath()
		arg_9_0:checkSkinEffectPath()
	end
end

function var_0_0.checkMonsterEffectPath(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(lua_monster.configList) do
		local var_11_0 = iter_11_1.effect

		if not string.nilorempty(var_11_0) then
			local var_11_1 = string.split(var_11_0, "#")

			for iter_11_2, iter_11_3 in ipairs(var_11_1) do
				if not string.match(iter_11_3, "^buff/") then
					logError(string.format("怪物表 id ： %s, 特效配置不在buff目录下. effect : %s", iter_11_1.id, iter_11_1.effect))

					break
				end
			end
		end
	end
end

function var_0_0.checkSkinEffectPath(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(lua_skin.configList) do
		local var_12_0 = iter_12_1.effect

		if not string.nilorempty(var_12_0) then
			local var_12_1 = string.split(var_12_0, "#")

			for iter_12_2, iter_12_3 in ipairs(var_12_1) do
				if not string.match(iter_12_3, "^buff/") then
					logError(string.format("皮肤表 id ： %s, 特效配置不在buff目录下. effect : %s", iter_12_1.id, iter_12_1.effect))

					break
				end
			end
		end
	end
end

function var_0_0.checkSpineBornPath(arg_13_0)
	for iter_13_0, iter_13_1 in ipairs(lua_skin_spine_action.configList) do
		if iter_13_1.actionName == SpineAnimState.born then
			local var_13_0 = iter_13_1.effect

			if not string.nilorempty(var_13_0) then
				local var_13_1 = FightStrUtil.instance:getSplitCache(var_13_0, "#")

				for iter_13_2, iter_13_3 in ipairs(var_13_1) do
					if not string.match(iter_13_3, "^buff/") then
						logError(string.format("皮肤表, 战斗动作表现表 id ： %s, born 特效 配置不在buff目录下. effect : %s", iter_13_1.id, iter_13_1.effect))

						break
					end
				end
			end
		end
	end
end

function var_0_0.getSkinSkillTimeline(arg_14_0, arg_14_1, arg_14_2)
	arg_14_0:_checkskinSkill()

	local var_14_0 = arg_14_1 and arg_14_0._skinSkillTLDict[arg_14_1]

	if var_14_0 then
		local var_14_1 = var_14_0[arg_14_2]

		if var_14_1 then
			return var_14_1
		end
	end

	local var_14_2 = lua_skill.configDict[arg_14_2]

	if not var_14_2 then
		logError("skill config not exist: " .. arg_14_2)

		return
	end

	return var_14_2.timeline
end

function var_0_0._filterSpeicalSkillIds(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = {}
	local var_15_1 = {}

	for iter_15_0 = 1, #arg_15_1 do
		local var_15_2 = arg_15_1[iter_15_0]

		if lua_skill_specialbuff.configDict[var_15_2] then
			if lua_skill_specialbuff.configDict[var_15_2].isSpecial == 1 then
				table.insert(var_15_0, arg_15_1[iter_15_0])
			else
				table.insert(var_15_1, arg_15_1[iter_15_0])
			end
		else
			table.insert(var_15_1, arg_15_1[iter_15_0])
		end
	end

	return arg_15_2 and var_15_0 or var_15_1
end

function var_0_0.getSkillLv(arg_16_0, arg_16_1)
	arg_16_0:_checkSkill()

	local var_16_0 = lua_skill.configDict[arg_16_1]

	if not var_16_0 then
		logError("技能表找不到id:" .. tostring(arg_16_1))

		return 1
	end

	if lua_skill_next.configDict[arg_16_1] then
		return var_16_0.skillRank
	end

	if FightCardDataHelper.isBigSkill(arg_16_1) then
		return FightEnum.UniqueSkillCardLv
	end

	if arg_16_1 == FightEnum.UniversalCard1 then
		return 1
	elseif arg_16_1 == FightEnum.UniversalCard2 then
		return 2
	end

	return var_16_0.skillRank
end

function var_0_0.getSkillNextLvId(arg_17_0, arg_17_1)
	arg_17_0:_checkSkill()

	return arg_17_0._skillNextCardLvDict[arg_17_1]
end

function var_0_0.getSkillPrevLvId(arg_18_0, arg_18_1)
	arg_18_0:_checkSkill()

	return arg_18_0._skillPrevCardLvDict[arg_18_1]
end

function var_0_0.isActiveSkill(arg_19_0, arg_19_1)
	if arg_19_1 <= 0 then
		return false
	end

	arg_19_0:_checkSkill()

	if arg_19_0._skillHeroIdDict[arg_19_1] or arg_19_0._skillMonsterIdDict[arg_19_1] then
		return true
	end

	return false
end

function var_0_0.getRestrain(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0._restrainDict[arg_20_1]

	if var_20_0 then
		return var_20_0[arg_20_2]
	end
end

function var_0_0.getBuffTag(arg_21_0, arg_21_1)
	local var_21_0

	for iter_21_0, iter_21_1 in ipairs(lua_skill_buff.configList) do
		if iter_21_1.name == arg_21_1 then
			var_21_0 = iter_21_1.typeId

			break
		end
	end

	if not var_21_0 then
		return ""
	end

	local var_21_1 = lua_skill_bufftype.configDict[var_21_0]
	local var_21_2 = var_21_1 and lua_skill_buff_desc.configDict[var_21_1.type]

	if var_21_2 then
		return var_21_2.name
	end

	return ""
end

function var_0_0.restrainedBy(arg_22_0, arg_22_1)
	if not arg_22_0._restrainDict then
		return nil
	end

	for iter_22_0, iter_22_1 in pairs(arg_22_0._restrainDict) do
		if iter_22_1[arg_22_1] and iter_22_1[arg_22_1] > 1000 then
			return iter_22_0
		end
	end

	return nil
end

function var_0_0.restrained(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_0._restrainDict[arg_23_1]

	if not var_23_0 then
		return nil
	end

	for iter_23_0, iter_23_1 in pairs(var_23_0) do
		if iter_23_1 > 1000 then
			return iter_23_0
		end
	end

	return nil
end

function var_0_0.getSkillHeroId(arg_24_0, arg_24_1)
	arg_24_0:_checkSkill()

	return arg_24_0._skillHeroIdDict[arg_24_1]
end

function var_0_0.setSkillDict(arg_25_0, arg_25_1, arg_25_2, arg_25_3, arg_25_4, arg_25_5)
	arg_25_0._skillCurrCardLvDict = arg_25_1
	arg_25_0._skillNextCardLvDict = arg_25_2
	arg_25_0._skillPrevCardLvDict = arg_25_3
	arg_25_0._skillHeroIdDict = arg_25_4
	arg_25_0._skillMonsterIdDict = arg_25_5
	arg_25_0.parseSkill = true
end

function var_0_0.isParsedSkill(arg_26_0)
	return arg_26_0.parseSkill
end

function var_0_0._checkSkill(arg_27_0)
	if arg_27_0.parseSkill then
		return
	end

	arg_27_0.parseSkill = true
	arg_27_0._skillCurrCardLvDict = {}
	arg_27_0._skillNextCardLvDict = {}
	arg_27_0._skillPrevCardLvDict = {}
	arg_27_0._skillHeroIdDict = {}
	arg_27_0._skillMonsterIdDict = {}

	for iter_27_0, iter_27_1 in ipairs(lua_character.configList) do
		if not string.nilorempty(iter_27_1.skill) then
			local var_27_0 = FightStrUtil.instance:getSplitString2Cache(iter_27_1.skill, true)

			for iter_27_2, iter_27_3 in ipairs(var_27_0) do
				local var_27_1 = iter_27_3[2]
				local var_27_2 = iter_27_3[3]
				local var_27_3 = iter_27_3[4]

				arg_27_0._skillCurrCardLvDict[var_27_1] = 1
				arg_27_0._skillCurrCardLvDict[var_27_2] = 2
				arg_27_0._skillCurrCardLvDict[var_27_3] = 3
				arg_27_0._skillNextCardLvDict[var_27_1] = var_27_2
				arg_27_0._skillNextCardLvDict[var_27_2] = var_27_3
				arg_27_0._skillPrevCardLvDict[var_27_2] = var_27_1
				arg_27_0._skillPrevCardLvDict[var_27_3] = var_27_2

				local var_27_4 = iter_27_1.id

				arg_27_0._skillHeroIdDict[var_27_1] = var_27_4
				arg_27_0._skillHeroIdDict[var_27_2] = var_27_4
				arg_27_0._skillHeroIdDict[var_27_3] = var_27_4
			end
		end
	end

	for iter_27_4, iter_27_5 in ipairs(lua_skill_ex_level.configList) do
		local var_27_5 = iter_27_5.heroId
		local var_27_6 = iter_27_5.skillGroup1

		if not string.nilorempty(var_27_6) then
			local var_27_7 = FightStrUtil.instance:getSplitToNumberCache(var_27_6, "|")

			for iter_27_6, iter_27_7 in ipairs(var_27_7) do
				arg_27_0._skillHeroIdDict[iter_27_7] = var_27_5
				arg_27_0._skillCurrCardLvDict[iter_27_7] = iter_27_6
			end
		end

		local var_27_8 = iter_27_5.skillGroup2

		if not string.nilorempty(var_27_8) then
			local var_27_9 = FightStrUtil.instance:getSplitToNumberCache(var_27_8, "|")

			for iter_27_8, iter_27_9 in ipairs(var_27_9) do
				arg_27_0._skillHeroIdDict[iter_27_9] = var_27_5
				arg_27_0._skillCurrCardLvDict[iter_27_9] = iter_27_8
			end
		end

		local var_27_10 = iter_27_5.skillEx

		arg_27_0._skillHeroIdDict[var_27_10] = var_27_5
	end

	for iter_27_10, iter_27_11 in ipairs(lua_monster.configList) do
		local var_27_11 = iter_27_11.id
		local var_27_12 = FightStrUtil.instance:getSplitString2Cache(iter_27_11.activeSkill, true, "|", "#")

		if var_27_12 then
			for iter_27_12, iter_27_13 in ipairs(var_27_12) do
				local var_27_13 = 1

				for iter_27_14, iter_27_15 in ipairs(iter_27_13) do
					if lua_skill.configDict[iter_27_15] then
						arg_27_0._skillMonsterIdDict[iter_27_15] = var_27_11
						arg_27_0._skillCurrCardLvDict[iter_27_15] = var_27_13
						var_27_13 = var_27_13 + 1
					end
				end
			end
		end

		local var_27_14 = iter_27_11.uniqueSkill

		if var_27_14 and #var_27_14 > 0 then
			for iter_27_16, iter_27_17 in ipairs(var_27_14) do
				arg_27_0._skillMonsterIdDict[iter_27_17] = var_27_11
			end
		end
	end
end

function var_0_0._checkskinSkill(arg_28_0)
	if arg_28_0._skinSkillTLDict then
		return
	end

	arg_28_0._skinSkillTLDict = {}

	arg_28_0:_doCheckskinSkill(lua_skin.configList)
	arg_28_0:_doCheckskinSkill(lua_monster_skin.configList)
end

function var_0_0._doCheckskinSkill(arg_29_0, arg_29_1)
	for iter_29_0, iter_29_1 in ipairs(arg_29_1) do
		if not string.nilorempty(iter_29_1.skills) then
			local var_29_0 = {}
			local var_29_1 = FightStrUtil.instance:getSplitString2Cache(iter_29_1.skills, false, "|", "#")

			for iter_29_2, iter_29_3 in ipairs(var_29_1) do
				local var_29_2 = tonumber(iter_29_3[1])
				local var_29_3 = iter_29_3[2]

				if var_29_2 and var_29_3 then
					var_29_0[var_29_2] = var_29_3
				end
			end

			arg_29_0._skinSkillTLDict[iter_29_1.id] = var_29_0
		end
	end
end

function var_0_0.getSkillEffectCO(arg_30_0, arg_30_1)
	local var_30_0 = lua_skill.configDict[arg_30_1]

	return var_30_0 and lua_skill_effect.configDict[var_30_0.skillEffect]
end

function var_0_0.getPassiveSkills(arg_31_0, arg_31_1)
	local var_31_0
	local var_31_1 = lua_monster.configDict[arg_31_1]

	if var_31_1 and var_31_1.passiveSkill then
		local var_31_2 = "|"

		if string.find(var_31_1.passiveSkill, "#") then
			var_31_2 = "#"
		end

		var_31_0 = tabletool.copy(FightStrUtil.instance:getSplitToNumberCache(var_31_1.passiveSkill, var_31_2))

		for iter_31_0 = #var_31_0, var_31_1.passiveSkillCount + 1, -1 do
			var_31_0[iter_31_0] = nil
		end
	end

	if not string.nilorempty(var_31_1.passiveSkillsEx) then
		local var_31_3 = "|"

		if string.find(var_31_1.passiveSkillsEx, "#") then
			var_31_3 = "#"
		end

		local var_31_4 = FightStrUtil.instance:getSplitToNumberCache(var_31_1.passiveSkillsEx, var_31_3)

		for iter_31_1, iter_31_2 in ipairs(var_31_4) do
			var_31_0 = var_31_0 or {}

			table.insert(var_31_0, iter_31_2)
		end
	end

	return var_31_0
end

function var_0_0.getPassiveSkillsAfterUIFilter(arg_32_0, arg_32_1)
	local var_32_0 = lua_monster.configDict[arg_32_1]
	local var_32_1 = var_0_0.instance:getPassiveSkills(arg_32_1)
	local var_32_2 = FightStrUtil.instance:getSplitToNumberCache(var_32_0.uiFilterSkill, "|")

	for iter_32_0, iter_32_1 in ipairs(var_32_2) do
		local var_32_3 = tabletool.indexOf(var_32_1, iter_32_1)

		if var_32_3 then
			table.remove(var_32_1, var_32_3)
		end
	end

	return var_32_1
end

function var_0_0.getMonsterGuideFocusConfig(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	if lua_monster_guide_focus.configDict[arg_33_1] and lua_monster_guide_focus.configDict[arg_33_1][arg_33_2] and lua_monster_guide_focus.configDict[arg_33_1][arg_33_2][arg_33_3] then
		return lua_monster_guide_focus.configDict[arg_33_1][arg_33_2][arg_33_3][arg_33_4]
	end
end

function var_0_0.getNewMonsterConfig(arg_34_0, arg_34_1)
	return not string.nilorempty(arg_34_1.highPriorityName) or not string.nilorempty(arg_34_1.highPriorityNameEng) or not string.nilorempty(arg_34_1.highPriorityDes)
end

function var_0_0.getMonsterName(arg_35_0, arg_35_1)
	return arg_35_0:getNewMonsterConfig(arg_35_1) and arg_35_1.highPriorityName or arg_35_1.name
end

function var_0_0.getBuffFeatures(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0._buffFeatureDictDict[arg_36_1]

	if not var_36_0 then
		var_36_0 = {}

		local var_36_1 = lua_skill_buff.configDict[arg_36_1]

		if var_36_1 then
			local var_36_2 = string.split(var_36_1.features, "|")

			if var_36_2 then
				for iter_36_0, iter_36_1 in ipairs(var_36_2) do
					local var_36_3 = string.split(iter_36_1, "#")
					local var_36_4 = tonumber(var_36_3[1])
					local var_36_5 = var_36_4 and lua_buff_act.configDict[var_36_4]

					if var_36_5 and var_36_5.type then
						var_36_0[var_36_5.type] = {
							featureType = var_36_5.type,
							featureStr = iter_36_1
						}
					end
				end
			end
		end

		arg_36_0._buffFeatureDictDict[arg_36_1] = var_36_0
	end

	return var_36_0
end

function var_0_0.hasBuffFeature(arg_37_0, arg_37_1, arg_37_2)
	return arg_37_0:getBuffFeatures(arg_37_1)[arg_37_2]
end

function var_0_0.getSkinSpineActionDict(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_0:getSkinCO(arg_38_1)

	if not var_38_0 then
		return
	end

	local var_38_1 = var_38_0.showTemplate
	local var_38_2 = lua_skin_spine_action.configDict[var_38_1]

	if arg_38_2 and var_38_2 and not var_38_2[arg_38_2] then
		var_38_2 = nil
	end

	if not var_38_2 and lua_skin.configDict[var_38_1] then
		local var_38_3 = var_38_0.id - var_38_0.id % 10 + 1
		local var_38_4 = var_0_0.instance:getSkinCO(var_38_3)

		if var_38_4 then
			var_38_2 = lua_skin_spine_action.configDict[var_38_4.showTemplate]
		end
	end

	return var_38_2
end

function var_0_0.getSummonedConfig(arg_39_0, arg_39_1, arg_39_2)
	return lua_summoned.configDict[arg_39_1] and lua_summoned.configDict[arg_39_1][arg_39_2]
end

function var_0_0.getRejectActBuffTypeList(arg_40_0, arg_40_1)
	return arg_40_0._rejectSpineAct and arg_40_0._rejectSpineAct[arg_40_1]
end

function var_0_0._dealFightBuffRejectAct(arg_41_0)
	arg_41_0._rejectSpineAct = {}

	for iter_41_0, iter_41_1 in ipairs(lua_fight_buff_reject_act.configList) do
		local var_41_0 = string.split(iter_41_1.rejectAct, "#")

		for iter_41_2, iter_41_3 in ipairs(var_41_0) do
			arg_41_0._rejectSpineAct[iter_41_3] = arg_41_0._rejectSpineAct[iter_41_3] or {}

			table.insert(arg_41_0._rejectSpineAct[iter_41_3], iter_41_1.id)
		end
	end
end

function var_0_0._checkMonsterGroupBoss0(arg_42_0)
	if isDebugBuild then
		local var_42_0

		for iter_42_0, iter_42_1 in ipairs(lua_monster_group.configList) do
			if iter_42_1.bossId == "0" then
				var_42_0 = var_42_0 or {}

				table.insert(var_42_0, iter_42_1.id)
			end
		end

		if var_42_0 then
			logError("以下怪物组配错了 bossId = 0，请检查是否有误\n" .. table.concat(var_42_0, ","))
		end
	end
end

var_0_0.DescNameTag = "{name}"

function var_0_0.getSkillEffectDesc(arg_43_0, arg_43_1, arg_43_2)
	if not arg_43_2 then
		return ""
	end

	if isDebugBuild or SLFramework.FrameworkSettings.IsEditor then
		arg_43_0:setGetDescFlag(true)

		local var_43_0 = arg_43_2.desc

		arg_43_0:setGetDescFlag(false)

		if string.match(var_43_0, var_0_0.DescNameTag) and string.nilorempty(arg_43_1) then
			local var_43_1 = "monster name is nil or empty str, please check !!!" .. string.format("effectId : %s, effect desc : %s", arg_43_2.id, var_43_0)

			logError(var_43_1)

			return var_43_0
		end

		if string.nilorempty(arg_43_1) then
			return var_43_0
		end

		return string.gsub(var_43_0, var_0_0.DescNameTag, arg_43_1)
	end

	local var_43_2 = arg_43_2.desc

	if string.nilorempty(arg_43_1) then
		return var_43_2
	end

	return string.gsub(var_43_2, var_0_0.DescNameTag, arg_43_1)
end

function var_0_0.getEntitySkillDesc(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	arg_44_2 = arg_44_2 or lua_skill.configDict[arg_44_3]

	if not arg_44_2 then
		if arg_44_3 then
			logError("技能表找不到id : " .. tostring(arg_44_3))
		end

		return ""
	end

	local var_44_0 = arg_44_0:getEntityName(arg_44_1)

	return arg_44_0:getSkillEffectDesc(var_44_0, arg_44_2)
end

function var_0_0.getEntityName(arg_45_0, arg_45_1)
	local var_45_0 = FightDataHelper.entityMgr:getById(arg_45_1)
	local var_45_1 = var_45_0 and var_45_0:getCO()

	return var_45_1 and var_45_1.name or ""
end

function var_0_0._rebuildSkillEffectTab(arg_46_0)
	if isDebugBuild or SLFramework.FrameworkSettings.IsEditor then
		local var_46_0 = getmetatable(lua_skill_effect.configList[1])
		local var_46_1 = {
			__index = function(arg_47_0, arg_47_1)
				if arg_47_1 == "desc" and not var_0_0.instance:isSetDescFlag() then
					logError("获取调用效果 desc 字段， 必须使用 FightConfig.getSkillEffectDesc 函数")
				end

				return var_46_0.__index(arg_47_0, arg_47_1)
			end,
			__newindex = var_46_0.__newindex
		}

		for iter_46_0, iter_46_1 in ipairs(lua_skill_effect.configList) do
			setmetatable(iter_46_1, var_46_1)
		end
	end
end

function var_0_0.setGetDescFlag(arg_48_0, arg_48_1)
	arg_48_0.descFlag = arg_48_1
end

function var_0_0.isSetDescFlag(arg_49_0)
	return arg_49_0.descFlag
end

function var_0_0.getMultiHpListByMonsterId(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = lua_monster.configDict[arg_50_1]

	if not var_50_0 then
		return nil
	end

	local var_50_1 = CharacterDataConfig.instance:getMonsterHp(arg_50_1, arg_50_2)
	local var_50_2 = lua_monster_skill_template.configDict[var_50_0.skillTemplate]

	if var_50_2 and var_50_2.instance > 0 then
		local var_50_3 = lua_monster_instance.configDict[var_50_2.instance]

		if var_50_3 and var_50_3.multiHp > 1 then
			local var_50_4 = {}

			for iter_50_0 = 1, var_50_3.multiHp do
				table.insert(var_50_4, var_50_1)
			end

			return var_50_4
		end
	end

	local var_50_5 = lua_monster_template.configDict[var_50_0.template]
	local var_50_6 = var_50_5 and var_50_5.multiHp

	if string.nilorempty(var_50_6) then
		return nil
	end

	local var_50_7 = #string.split(var_50_6, "#")
	local var_50_8 = {}

	for iter_50_1 = 1, var_50_7 do
		table.insert(var_50_8, var_50_1)
	end

	return var_50_8
end

var_0_0.instance = var_0_0.New()

return var_0_0
