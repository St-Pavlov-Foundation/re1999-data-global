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
		"fight_buff_type_id_2_scene_effect"
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
	end
end

function var_0_0._rebuildSkillEffect(arg_6_0)
	if not arg_6_0._hasLoadSkill or not arg_6_0._hasLoadSkillEffect then
		return
	end

	local var_6_0 = getmetatable(lua_skill.configList[1])
	local var_6_1 = {
		__index = function(arg_7_0, arg_7_1)
			local var_7_0 = var_6_0.__index(arg_7_0, arg_7_1)

			if not var_7_0 then
				local var_7_1 = arg_7_0.skillEffect
				local var_7_2 = lua_skill_effect.configDict[var_7_1]

				if var_7_2 then
					if isDebugBuild or SLFramework.FrameworkSettings.IsEditor then
						if arg_7_1 == "desc" and not var_0_0.instance:isSetDescFlag() then
							logError("获取调用效果 desc 字段， 必须使用 FightConfig.getSkillEffectDesc 函数")
						end

						var_7_0 = var_7_2[arg_7_1]
					else
						var_7_0 = var_7_2[arg_7_1]
					end
				else
					logError(arg_7_0.id .. " 技能效果模版不存在：" .. var_7_1)
				end
			end

			return var_7_0
		end,
		__newindex = var_6_0.__newindex
	}

	for iter_6_0, iter_6_1 in ipairs(lua_skill.configList) do
		setmetatable(iter_6_1, var_6_1)
	end

	arg_6_0:_rebuildSkillEffectTab()
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

function var_0_0._rebuildMonsterSkin(arg_8_0)
	if not arg_8_0._hasLoadMonster or not arg_8_0._hasLoadSkin then
		return
	end

	local var_8_0 = getmetatable(lua_monster.configList[1])
	local var_8_1 = {
		__index = function(arg_9_0, arg_9_1)
			local var_9_0 = var_8_0.__index(arg_9_0, arg_9_1)

			if arg_9_1 == "career" then
				if var_9_0 and var_9_0 > 0 then
					return var_9_0
				end
			elseif var_9_0 then
				return var_9_0
			end

			local var_9_1 = arg_9_0.skillTemplate
			local var_9_2 = lua_monster_skill_template.configDict[var_9_1]

			if not var_9_2 then
				logError(arg_9_0.id .. " 技能效果模版不存在：" .. var_9_1)

				return nil
			end

			local var_9_3 = var_9_2[arg_9_1]

			if var_9_3 then
				if arg_9_1 == "uniqueSkill" then
					local var_9_4 = arg_9_0.id
					local var_9_5 = arg_9_0.uniqueSkillLevel

					if not arg_8_0._monsterId2UniqueId[var_9_4] then
						local var_9_6 = {}
						local var_9_7
						local var_9_8 = FightStrUtil.instance:getSplitCache(var_9_2.uniqueSkill, "|")
						local var_9_9 = lua_fight_monster_unique_index.configDict[var_9_4]

						if var_9_9 then
							var_9_5 = var_9_9.index
						end

						for iter_9_0, iter_9_1 in ipairs(var_9_8) do
							local var_9_10 = FightStrUtil.instance:getSplitToNumberCache(iter_9_1, "#")

							table.insert(var_9_6, var_9_10[var_9_5 <= #var_9_10 and var_9_5 or #var_9_10])
						end

						arg_8_0._monsterId2UniqueId[var_9_4] = var_9_6
					end

					var_9_3 = arg_8_0._monsterId2UniqueId[var_9_4]
				end

				return var_9_3
			end

			local var_9_11 = arg_9_0.skinId

			return var_0_0.instance:getSkinCO(var_9_11)[arg_9_1]
		end,
		__newindex = var_8_0.__newindex
	}

	for iter_8_0, iter_8_1 in ipairs(lua_monster.configList) do
		setmetatable(iter_8_1, var_8_1)
	end

	if isDebugBuild then
		arg_8_0:checkMonsterEffectPath()
		arg_8_0:checkSkinEffectPath()
	end
end

function var_0_0.checkMonsterEffectPath(arg_10_0)
	for iter_10_0, iter_10_1 in ipairs(lua_monster.configList) do
		local var_10_0 = iter_10_1.effect

		if not string.nilorempty(var_10_0) then
			local var_10_1 = string.split(var_10_0, "#")

			for iter_10_2, iter_10_3 in ipairs(var_10_1) do
				if not string.match(iter_10_3, "^buff/") then
					logError(string.format("怪物表 id ： %s, 特效配置不在buff目录下. effect : %s", iter_10_1.id, iter_10_1.effect))

					break
				end
			end
		end
	end
end

function var_0_0.checkSkinEffectPath(arg_11_0)
	for iter_11_0, iter_11_1 in ipairs(lua_skin.configList) do
		local var_11_0 = iter_11_1.effect

		if not string.nilorempty(var_11_0) then
			local var_11_1 = string.split(var_11_0, "#")

			for iter_11_2, iter_11_3 in ipairs(var_11_1) do
				if not string.match(iter_11_3, "^buff/") then
					logError(string.format("皮肤表 id ： %s, 特效配置不在buff目录下. effect : %s", iter_11_1.id, iter_11_1.effect))

					break
				end
			end
		end
	end
end

function var_0_0.checkSpineBornPath(arg_12_0)
	for iter_12_0, iter_12_1 in ipairs(lua_skin_spine_action.configList) do
		if iter_12_1.actionName == SpineAnimState.born then
			local var_12_0 = iter_12_1.effect

			if not string.nilorempty(var_12_0) then
				local var_12_1 = FightStrUtil.instance:getSplitCache(var_12_0, "#")

				for iter_12_2, iter_12_3 in ipairs(var_12_1) do
					if not string.match(iter_12_3, "^buff/") then
						logError(string.format("皮肤表, 战斗动作表现表 id ： %s, born 特效 配置不在buff目录下. effect : %s", iter_12_1.id, iter_12_1.effect))

						break
					end
				end
			end
		end
	end
end

function var_0_0.getSkinSkillTimeline(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:_checkskinSkill()

	local var_13_0 = arg_13_1 and arg_13_0._skinSkillTLDict[arg_13_1]

	if var_13_0 then
		local var_13_1 = var_13_0[arg_13_2]

		if var_13_1 then
			return var_13_1
		end
	end

	local var_13_2 = lua_skill.configDict[arg_13_2]

	if not var_13_2 then
		logError("skill config not exist: " .. arg_13_2)

		return
	end

	return var_13_2.timeline
end

function var_0_0._filterSpeicalSkillIds(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = {}
	local var_14_1 = {}

	for iter_14_0 = 1, #arg_14_1 do
		local var_14_2 = arg_14_1[iter_14_0]

		if lua_skill_specialbuff.configDict[var_14_2] then
			if lua_skill_specialbuff.configDict[var_14_2].isSpecial == 1 then
				table.insert(var_14_0, arg_14_1[iter_14_0])
			else
				table.insert(var_14_1, arg_14_1[iter_14_0])
			end
		else
			table.insert(var_14_1, arg_14_1[iter_14_0])
		end
	end

	return arg_14_2 and var_14_0 or var_14_1
end

function var_0_0.getSkillLv(arg_15_0, arg_15_1)
	arg_15_0:_checkSkill()

	local var_15_0 = lua_skill.configDict[arg_15_1]

	if not var_15_0 then
		logError("技能表找不到id:" .. tostring(arg_15_1))

		return 1
	end

	if lua_skill_next.configDict[arg_15_1] then
		return var_15_0.skillRank
	end

	if FightCardDataHelper.isBigSkill(arg_15_1) then
		return FightEnum.UniqueSkillCardLv
	end

	if arg_15_1 == FightEnum.UniversalCard1 then
		return 1
	elseif arg_15_1 == FightEnum.UniversalCard2 then
		return 2
	end

	return var_15_0.skillRank
end

function var_0_0.getSkillNextLvId(arg_16_0, arg_16_1)
	arg_16_0:_checkSkill()

	return arg_16_0._skillNextCardLvDict[arg_16_1]
end

function var_0_0.getSkillPrevLvId(arg_17_0, arg_17_1)
	arg_17_0:_checkSkill()

	return arg_17_0._skillPrevCardLvDict[arg_17_1]
end

function var_0_0.isActiveSkill(arg_18_0, arg_18_1)
	if arg_18_1 <= 0 then
		return false
	end

	arg_18_0:_checkSkill()

	if arg_18_0._skillHeroIdDict[arg_18_1] or arg_18_0._skillMonsterIdDict[arg_18_1] then
		return true
	end

	return false
end

function var_0_0.getRestrain(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0._restrainDict[arg_19_1]

	if var_19_0 then
		return var_19_0[arg_19_2]
	end
end

function var_0_0.getBuffTag(arg_20_0, arg_20_1)
	local var_20_0

	for iter_20_0, iter_20_1 in ipairs(lua_skill_buff.configList) do
		if iter_20_1.name == arg_20_1 then
			var_20_0 = iter_20_1.typeId

			break
		end
	end

	if not var_20_0 then
		return ""
	end

	local var_20_1 = lua_skill_bufftype.configDict[var_20_0]
	local var_20_2 = var_20_1 and lua_skill_buff_desc.configDict[var_20_1.type]

	if var_20_2 then
		return var_20_2.name
	end

	return ""
end

function var_0_0.restrainedBy(arg_21_0, arg_21_1)
	if not arg_21_0._restrainDict then
		return nil
	end

	for iter_21_0, iter_21_1 in pairs(arg_21_0._restrainDict) do
		if iter_21_1[arg_21_1] and iter_21_1[arg_21_1] > 1000 then
			return iter_21_0
		end
	end

	return nil
end

function var_0_0.restrained(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0._restrainDict[arg_22_1]

	if not var_22_0 then
		return nil
	end

	for iter_22_0, iter_22_1 in pairs(var_22_0) do
		if iter_22_1 > 1000 then
			return iter_22_0
		end
	end

	return nil
end

function var_0_0.getSkillHeroId(arg_23_0, arg_23_1)
	arg_23_0:_checkSkill()

	return arg_23_0._skillHeroIdDict[arg_23_1]
end

function var_0_0.setSkillDict(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4, arg_24_5)
	arg_24_0._skillCurrCardLvDict = arg_24_1
	arg_24_0._skillNextCardLvDict = arg_24_2
	arg_24_0._skillPrevCardLvDict = arg_24_3
	arg_24_0._skillHeroIdDict = arg_24_4
	arg_24_0._skillMonsterIdDict = arg_24_5
	arg_24_0.parseSkill = true
end

function var_0_0.isParsedSkill(arg_25_0)
	return arg_25_0.parseSkill
end

function var_0_0._checkSkill(arg_26_0)
	if arg_26_0.parseSkill then
		return
	end

	arg_26_0.parseSkill = true
	arg_26_0._skillCurrCardLvDict = {}
	arg_26_0._skillNextCardLvDict = {}
	arg_26_0._skillPrevCardLvDict = {}
	arg_26_0._skillHeroIdDict = {}
	arg_26_0._skillMonsterIdDict = {}

	for iter_26_0, iter_26_1 in ipairs(lua_character.configList) do
		if not string.nilorempty(iter_26_1.skill) then
			local var_26_0 = FightStrUtil.instance:getSplitString2Cache(iter_26_1.skill, true)

			for iter_26_2, iter_26_3 in ipairs(var_26_0) do
				local var_26_1 = iter_26_3[2]
				local var_26_2 = iter_26_3[3]
				local var_26_3 = iter_26_3[4]

				arg_26_0._skillCurrCardLvDict[var_26_1] = 1
				arg_26_0._skillCurrCardLvDict[var_26_2] = 2
				arg_26_0._skillCurrCardLvDict[var_26_3] = 3
				arg_26_0._skillNextCardLvDict[var_26_1] = var_26_2
				arg_26_0._skillNextCardLvDict[var_26_2] = var_26_3
				arg_26_0._skillPrevCardLvDict[var_26_2] = var_26_1
				arg_26_0._skillPrevCardLvDict[var_26_3] = var_26_2

				local var_26_4 = iter_26_1.id

				arg_26_0._skillHeroIdDict[var_26_1] = var_26_4
				arg_26_0._skillHeroIdDict[var_26_2] = var_26_4
				arg_26_0._skillHeroIdDict[var_26_3] = var_26_4
			end
		end
	end

	for iter_26_4, iter_26_5 in ipairs(lua_skill_ex_level.configList) do
		local var_26_5 = iter_26_5.heroId
		local var_26_6 = iter_26_5.skillGroup1

		if not string.nilorempty(var_26_6) then
			local var_26_7 = FightStrUtil.instance:getSplitToNumberCache(var_26_6, "|")

			for iter_26_6, iter_26_7 in ipairs(var_26_7) do
				arg_26_0._skillHeroIdDict[iter_26_7] = var_26_5
				arg_26_0._skillCurrCardLvDict[iter_26_7] = iter_26_6
			end
		end

		local var_26_8 = iter_26_5.skillGroup2

		if not string.nilorempty(var_26_8) then
			local var_26_9 = FightStrUtil.instance:getSplitToNumberCache(var_26_8, "|")

			for iter_26_8, iter_26_9 in ipairs(var_26_9) do
				arg_26_0._skillHeroIdDict[iter_26_9] = var_26_5
				arg_26_0._skillCurrCardLvDict[iter_26_9] = iter_26_8
			end
		end

		local var_26_10 = iter_26_5.skillEx

		arg_26_0._skillHeroIdDict[var_26_10] = var_26_5
	end

	for iter_26_10, iter_26_11 in ipairs(lua_monster.configList) do
		local var_26_11 = iter_26_11.id
		local var_26_12 = FightStrUtil.instance:getSplitString2Cache(iter_26_11.activeSkill, true, "|", "#")

		if var_26_12 then
			for iter_26_12, iter_26_13 in ipairs(var_26_12) do
				local var_26_13 = 1

				for iter_26_14, iter_26_15 in ipairs(iter_26_13) do
					if lua_skill.configDict[iter_26_15] then
						arg_26_0._skillMonsterIdDict[iter_26_15] = var_26_11
						arg_26_0._skillCurrCardLvDict[iter_26_15] = var_26_13
						var_26_13 = var_26_13 + 1
					end
				end
			end
		end

		local var_26_14 = iter_26_11.uniqueSkill

		if var_26_14 and #var_26_14 > 0 then
			for iter_26_16, iter_26_17 in ipairs(var_26_14) do
				arg_26_0._skillMonsterIdDict[iter_26_17] = var_26_11
			end
		end
	end
end

function var_0_0._checkskinSkill(arg_27_0)
	if arg_27_0._skinSkillTLDict then
		return
	end

	arg_27_0._skinSkillTLDict = {}

	arg_27_0:_doCheckskinSkill(lua_skin.configList)
	arg_27_0:_doCheckskinSkill(lua_monster_skin.configList)
end

function var_0_0._doCheckskinSkill(arg_28_0, arg_28_1)
	for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
		if not string.nilorempty(iter_28_1.skills) then
			local var_28_0 = {}
			local var_28_1 = FightStrUtil.instance:getSplitString2Cache(iter_28_1.skills, false, "|", "#")

			for iter_28_2, iter_28_3 in ipairs(var_28_1) do
				local var_28_2 = tonumber(iter_28_3[1])
				local var_28_3 = iter_28_3[2]

				if var_28_2 and var_28_3 then
					var_28_0[var_28_2] = var_28_3
				end
			end

			arg_28_0._skinSkillTLDict[iter_28_1.id] = var_28_0
		end
	end
end

function var_0_0.getSkillEffectCO(arg_29_0, arg_29_1)
	local var_29_0 = lua_skill.configDict[arg_29_1]

	return var_29_0 and lua_skill_effect.configDict[var_29_0.skillEffect]
end

function var_0_0.getPassiveSkills(arg_30_0, arg_30_1)
	local var_30_0
	local var_30_1 = lua_monster.configDict[arg_30_1]

	if var_30_1 and var_30_1.passiveSkill then
		local var_30_2 = "|"

		if string.find(var_30_1.passiveSkill, "#") then
			var_30_2 = "#"
		end

		var_30_0 = tabletool.copy(FightStrUtil.instance:getSplitToNumberCache(var_30_1.passiveSkill, var_30_2))

		for iter_30_0 = #var_30_0, var_30_1.passiveSkillCount + 1, -1 do
			var_30_0[iter_30_0] = nil
		end
	end

	if not string.nilorempty(var_30_1.passiveSkillsEx) then
		local var_30_3 = "|"

		if string.find(var_30_1.passiveSkillsEx, "#") then
			var_30_3 = "#"
		end

		local var_30_4 = FightStrUtil.instance:getSplitToNumberCache(var_30_1.passiveSkillsEx, var_30_3)

		for iter_30_1, iter_30_2 in ipairs(var_30_4) do
			var_30_0 = var_30_0 or {}

			table.insert(var_30_0, iter_30_2)
		end
	end

	return var_30_0
end

function var_0_0.getPassiveSkillsAfterUIFilter(arg_31_0, arg_31_1)
	local var_31_0 = lua_monster.configDict[arg_31_1]
	local var_31_1 = var_0_0.instance:getPassiveSkills(arg_31_1)
	local var_31_2 = FightStrUtil.instance:getSplitToNumberCache(var_31_0.uiFilterSkill, "|")

	for iter_31_0, iter_31_1 in ipairs(var_31_2) do
		local var_31_3 = tabletool.indexOf(var_31_1, iter_31_1)

		if var_31_3 then
			table.remove(var_31_1, var_31_3)
		end
	end

	return var_31_1
end

function var_0_0.getMonsterGuideFocusConfig(arg_32_0, arg_32_1, arg_32_2, arg_32_3, arg_32_4)
	if lua_monster_guide_focus.configDict[arg_32_1] and lua_monster_guide_focus.configDict[arg_32_1][arg_32_2] and lua_monster_guide_focus.configDict[arg_32_1][arg_32_2][arg_32_3] then
		return lua_monster_guide_focus.configDict[arg_32_1][arg_32_2][arg_32_3][arg_32_4]
	end
end

function var_0_0.getNewMonsterConfig(arg_33_0, arg_33_1)
	return not string.nilorempty(arg_33_1.highPriorityName) or not string.nilorempty(arg_33_1.highPriorityNameEng) or not string.nilorempty(arg_33_1.highPriorityDes)
end

function var_0_0.getMonsterName(arg_34_0, arg_34_1)
	return arg_34_0:getNewMonsterConfig(arg_34_1) and arg_34_1.highPriorityName or arg_34_1.name
end

function var_0_0.getBuffFeatures(arg_35_0, arg_35_1)
	local var_35_0 = arg_35_0._buffFeatureDictDict[arg_35_1]

	if not var_35_0 then
		var_35_0 = {}

		local var_35_1 = lua_skill_buff.configDict[arg_35_1]

		if var_35_1 then
			local var_35_2 = string.split(var_35_1.features, "|")

			if var_35_2 then
				for iter_35_0, iter_35_1 in ipairs(var_35_2) do
					local var_35_3 = string.split(iter_35_1, "#")
					local var_35_4 = tonumber(var_35_3[1])
					local var_35_5 = var_35_4 and lua_buff_act.configDict[var_35_4]

					if var_35_5 and var_35_5.type then
						var_35_0[var_35_5.type] = {
							featureType = var_35_5.type,
							featureStr = iter_35_1
						}
					end
				end
			end
		end

		arg_35_0._buffFeatureDictDict[arg_35_1] = var_35_0
	end

	return var_35_0
end

function var_0_0.hasBuffFeature(arg_36_0, arg_36_1, arg_36_2)
	return arg_36_0:getBuffFeatures(arg_36_1)[arg_36_2]
end

function var_0_0.getSkinSpineActionDict(arg_37_0, arg_37_1, arg_37_2)
	local var_37_0 = arg_37_0:getSkinCO(arg_37_1)

	if not var_37_0 then
		return
	end

	local var_37_1 = var_37_0.showTemplate
	local var_37_2 = lua_skin_spine_action.configDict[var_37_1]

	if arg_37_2 and var_37_2 and not var_37_2[arg_37_2] then
		var_37_2 = nil
	end

	if not var_37_2 and lua_skin.configDict[var_37_1] then
		local var_37_3 = var_37_0.id - var_37_0.id % 10 + 1
		local var_37_4 = var_0_0.instance:getSkinCO(var_37_3)

		if var_37_4 then
			var_37_2 = lua_skin_spine_action.configDict[var_37_4.showTemplate]
		end
	end

	return var_37_2
end

function var_0_0.getSummonedConfig(arg_38_0, arg_38_1, arg_38_2)
	return lua_summoned.configDict[arg_38_1] and lua_summoned.configDict[arg_38_1][arg_38_2]
end

function var_0_0.getRejectActBuffTypeList(arg_39_0, arg_39_1)
	return arg_39_0._rejectSpineAct and arg_39_0._rejectSpineAct[arg_39_1]
end

function var_0_0._dealFightBuffRejectAct(arg_40_0)
	arg_40_0._rejectSpineAct = {}

	for iter_40_0, iter_40_1 in ipairs(lua_fight_buff_reject_act.configList) do
		local var_40_0 = string.split(iter_40_1.rejectAct, "#")

		for iter_40_2, iter_40_3 in ipairs(var_40_0) do
			arg_40_0._rejectSpineAct[iter_40_3] = arg_40_0._rejectSpineAct[iter_40_3] or {}

			table.insert(arg_40_0._rejectSpineAct[iter_40_3], iter_40_1.id)
		end
	end
end

function var_0_0._checkMonsterGroupBoss0(arg_41_0)
	if isDebugBuild then
		local var_41_0

		for iter_41_0, iter_41_1 in ipairs(lua_monster_group.configList) do
			if iter_41_1.bossId == "0" then
				var_41_0 = var_41_0 or {}

				table.insert(var_41_0, iter_41_1.id)
			end
		end

		if var_41_0 then
			logError("以下怪物组配错了 bossId = 0，请检查是否有误\n" .. table.concat(var_41_0, ","))
		end
	end
end

var_0_0.DescNameTag = "{name}"

function var_0_0.getSkillEffectDesc(arg_42_0, arg_42_1, arg_42_2)
	if not arg_42_2 then
		return ""
	end

	if isDebugBuild or SLFramework.FrameworkSettings.IsEditor then
		arg_42_0:setGetDescFlag(true)

		local var_42_0 = arg_42_2.desc

		arg_42_0:setGetDescFlag(false)

		if string.match(var_42_0, var_0_0.DescNameTag) and string.nilorempty(arg_42_1) then
			local var_42_1 = "monster name is nil or empty str, please check !!!" .. string.format("effectId : %s, effect desc : %s", arg_42_2.id, var_42_0)

			logError(var_42_1)

			return var_42_0
		end

		if string.nilorempty(arg_42_1) then
			return var_42_0
		end

		return string.gsub(var_42_0, var_0_0.DescNameTag, arg_42_1)
	end

	local var_42_2 = arg_42_2.desc

	if string.nilorempty(arg_42_1) then
		return var_42_2
	end

	return string.gsub(var_42_2, var_0_0.DescNameTag, arg_42_1)
end

function var_0_0.getEntitySkillDesc(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	arg_43_2 = arg_43_2 or lua_skill.configDict[arg_43_3]

	if not arg_43_2 then
		if arg_43_3 then
			logError("技能表找不到id : " .. tostring(arg_43_3))
		end

		return ""
	end

	local var_43_0 = arg_43_0:getEntityName(arg_43_1)

	return arg_43_0:getSkillEffectDesc(var_43_0, arg_43_2)
end

function var_0_0.getEntityName(arg_44_0, arg_44_1)
	local var_44_0 = FightDataHelper.entityMgr:getById(arg_44_1)
	local var_44_1 = var_44_0 and var_44_0:getCO()

	return var_44_1 and var_44_1.name or ""
end

function var_0_0._rebuildSkillEffectTab(arg_45_0)
	if isDebugBuild or SLFramework.FrameworkSettings.IsEditor then
		local var_45_0 = getmetatable(lua_skill_effect.configList[1])
		local var_45_1 = {
			__index = function(arg_46_0, arg_46_1)
				if arg_46_1 == "desc" and not var_0_0.instance:isSetDescFlag() then
					logError("获取调用效果 desc 字段， 必须使用 FightConfig.getSkillEffectDesc 函数")
				end

				return var_45_0.__index(arg_46_0, arg_46_1)
			end,
			__newindex = var_45_0.__newindex
		}

		for iter_45_0, iter_45_1 in ipairs(lua_skill_effect.configList) do
			setmetatable(iter_45_1, var_45_1)
		end
	end
end

function var_0_0.setGetDescFlag(arg_47_0, arg_47_1)
	arg_47_0.descFlag = arg_47_1
end

function var_0_0.isSetDescFlag(arg_48_0)
	return arg_48_0.descFlag
end

function var_0_0.getMultiHpListByMonsterId(arg_49_0, arg_49_1, arg_49_2)
	local var_49_0 = lua_monster.configDict[arg_49_1]

	if not var_49_0 then
		return nil
	end

	local var_49_1 = CharacterDataConfig.instance:getMonsterHp(arg_49_1, arg_49_2)
	local var_49_2 = lua_monster_skill_template.configDict[var_49_0.skillTemplate]

	if var_49_2 and var_49_2.instance > 0 then
		local var_49_3 = lua_monster_instance.configDict[var_49_2.instance]

		if var_49_3 and var_49_3.multiHp > 1 then
			local var_49_4 = {}

			for iter_49_0 = 1, var_49_3.multiHp do
				table.insert(var_49_4, var_49_1)
			end

			return var_49_4
		end
	end

	local var_49_5 = lua_monster_template.configDict[var_49_0.template]
	local var_49_6 = var_49_5 and var_49_5.multiHp

	if string.nilorempty(var_49_6) then
		return nil
	end

	local var_49_7 = #string.split(var_49_6, "#")
	local var_49_8 = {}

	for iter_49_1 = 1, var_49_7 do
		table.insert(var_49_8, var_49_1)
	end

	return var_49_8
end

var_0_0.instance = var_0_0.New()

return var_0_0
