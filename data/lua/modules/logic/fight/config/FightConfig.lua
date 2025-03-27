module("modules.logic.fight.config.FightConfig", package.seeall)

slot0 = class("FightConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._skillCurrCardLvDict = nil
	slot0._skillNextCardLvDict = nil
	slot0._skillPrevCardLvDict = nil
	slot0._skillHeroIdDict = nil
	slot0._skillMonsterIdDict = nil
	slot0._skinSkillTLDict = nil
	slot0._buffFeatureDict = {}
	slot0._buffFeatureDictDict = {}
	slot0._buffId2FeatureIdList = {}
	slot0._restrainDict = nil
	slot0._monsterId2UniqueId = {}
end

function slot0.reqConfigNames(slot0)
	slot1 = {
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
		"simple_polarization"
	}

	if SLFramework.FrameworkSettings.IsEditor then
		table.insert(slot1, "activity174_test_bot")
		table.insert(slot1, "activity174_test_role")
	end

	return slot1
end

function slot0.getSkinCO(slot0, slot1)
	return lua_skin.configDict[slot1] or lua_monster_skin.configDict[slot1]
end

function slot0.getAudioId(slot0, slot1, slot2)
	slot4 = slot0:getSkinCO(slot1) and slot3.showTemplate

	if slot4 and lua_fight_voice.configDict[slot4] then
		return slot5["audio_type" .. slot2]
	end
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "fight_effect" then
		slot0._restrainDict = {}

		for slot6, slot7 in ipairs(slot2.configList) do
			slot0._restrainDict[slot7.id] = {}

			for slot12 = 1, 6 do
				slot8[slot12] = slot7["career" .. slot12]
			end
		end
	elseif slot1 == "skill" then
		slot0._hasLoadSkill = true

		slot0:_rebuildSkillEffect()
	elseif slot1 == "skill_effect" then
		slot0._hasLoadSkillEffect = true

		slot0:_rebuildSkillEffect()
	elseif slot1 == "monster" then
		slot0._hasLoadMonster = true

		slot0:_rebuildMonsterSkin()
	elseif slot1 == "skin" then
		slot0._hasLoadSkin = true

		slot0:_rebuildMonsterSkin()
	elseif slot1 == "skill_buff" then
		-- Nothing
	elseif slot1 == "fight_buff_reject_act" then
		slot0:_dealFightBuffRejectAct()
	elseif slot1 == "monster_group" then
		slot0:_checkMonsterGroupBoss0()
	elseif slot1 == "skin_spine_action" then
		-- Nothing
	end
end

function slot0._rebuildSkillEffect(slot0)
	if not slot0._hasLoadSkill or not slot0._hasLoadSkillEffect then
		return
	end

	for slot6, slot7 in ipairs(lua_skill.configList) do
		setmetatable(slot7, {
			__index = function (slot0, slot1)
				if not uv0.__index(slot0, slot1) then
					if lua_skill_effect.configDict[slot0.skillEffect] then
						if isDebugBuild or SLFramework.FrameworkSettings.IsEditor then
							if slot1 == "desc" and not uv1.instance:isSetDescFlag() then
								logError("获取调用效果 desc 字段， 必须使用 FightConfig.getSkillEffectDesc 函数")
							end

							slot2 = slot4[slot1]
						else
							slot2 = slot4[slot1]
						end
					else
						logError(slot0.id .. " 技能效果模版不存在：" .. slot3)
					end
				end

				return slot2
			end,
			__newindex = getmetatable(lua_skill.configList[1]).__newindex
		})
	end

	slot0:_rebuildSkillEffectTab()
end

slot1 = {
	[10151011.0] = true,
	[10161131.0] = true,
	[10161141.0] = true,
	[10161011.0] = true,
	[10151111.0] = true,
	[10161021.0] = true,
	[10141141.0] = true,
	[10151114.0] = true,
	[10141131.0] = true,
	[81261201.0] = true,
	[81251201.0] = true,
	[10161111.0] = true,
	[10151113.0] = true,
	[10141101.0] = true,
	[10141111.0] = true,
	[10161121.0] = true,
	[10141102.0] = true,
	[10141121.0] = true,
	[10151112.0] = true,
	[10151012.0] = true
}

function slot0._rebuildMonsterSkin(slot0)
	if not slot0._hasLoadMonster or not slot0._hasLoadSkin then
		return
	end

	for slot6, slot7 in ipairs(lua_monster.configList) do
		setmetatable(slot7, {
			__index = function (slot0, slot1)
				slot2 = uv0.__index(slot0, slot1)

				if slot1 == "career" then
					if slot2 and slot2 > 0 then
						return slot2
					end
				elseif slot2 then
					return slot2
				end

				if not lua_monster_skill_template.configDict[slot0.skillTemplate] then
					logError(slot0.id .. " 技能效果模版不存在：" .. slot3)

					return nil
				end

				if slot4[slot1] then
					if slot1 == "uniqueSkill" then
						slot6 = slot0.uniqueSkillLevel

						if not uv1._monsterId2UniqueId[slot0.id] then
							slot7 = {}
							slot8 = nil
							slot9 = FightStrUtil.instance:getSplitCache(slot4.uniqueSkill, "|")

							if lua_fight_monster_unique_index.configDict[slot5] then
								slot6 = slot10.index
							end

							for slot14, slot15 in ipairs(slot9) do
								table.insert(slot7, slot8[slot6 <= #FightStrUtil.instance:getSplitToNumberCache(slot15, "#") and slot6 or #slot8])
							end

							uv1._monsterId2UniqueId[slot5] = slot7
						end

						slot2 = uv1._monsterId2UniqueId[slot5]
					end

					return slot2
				end

				return uv2.instance:getSkinCO(slot0.skinId)[slot1]
			end,
			__newindex = getmetatable(lua_monster.configList[1]).__newindex
		})
	end

	if isDebugBuild then
		slot0:checkMonsterEffectPath()
		slot0:checkSkinEffectPath()
	end
end

function slot0.checkMonsterEffectPath(slot0)
	for slot4, slot5 in ipairs(lua_monster.configList) do
		if not string.nilorempty(slot5.effect) then
			for slot11, slot12 in ipairs(string.split(slot6, "#")) do
				if not string.match(slot12, "^buff/") then
					logError(string.format("怪物表 id ： %s, 特效配置不在buff目录下. effect : %s", slot5.id, slot5.effect))

					break
				end
			end
		end
	end
end

function slot0.checkSkinEffectPath(slot0)
	for slot4, slot5 in ipairs(lua_skin.configList) do
		if not string.nilorempty(slot5.effect) then
			for slot11, slot12 in ipairs(string.split(slot6, "#")) do
				if not string.match(slot12, "^buff/") then
					logError(string.format("皮肤表 id ： %s, 特效配置不在buff目录下. effect : %s", slot5.id, slot5.effect))

					break
				end
			end
		end
	end
end

function slot0.checkSpineBornPath(slot0)
	for slot4, slot5 in ipairs(lua_skin_spine_action.configList) do
		if slot5.actionName == SpineAnimState.born and not string.nilorempty(slot5.effect) then
			for slot11, slot12 in ipairs(FightStrUtil.instance:getSplitCache(slot6, "#")) do
				if not string.match(slot12, "^buff/") then
					logError(string.format("皮肤表, 战斗动作表现表 id ： %s, born 特效 配置不在buff目录下. effect : %s", slot5.id, slot5.effect))

					break
				end
			end
		end
	end
end

function slot0.getSkinSkillTimeline(slot0, slot1, slot2)
	slot0:_checkskinSkill()

	if slot1 and slot0._skinSkillTLDict[slot1] and slot3[slot2] then
		return slot4
	end

	if not lua_skill.configDict[slot2] then
		logError("skill config not exist: " .. slot2)

		return
	end

	return slot4.timeline
end

function slot0._filterSpeicalSkillIds(slot0, slot1, slot2)
	slot3 = {}
	slot4 = {}

	for slot8 = 1, #slot1 do
		if lua_skill_specialbuff.configDict[slot1[slot8]] then
			if lua_skill_specialbuff.configDict[slot9].isSpecial == 1 then
				table.insert(slot3, slot1[slot8])
			else
				table.insert(slot4, slot1[slot8])
			end
		else
			table.insert(slot4, slot1[slot8])
		end
	end

	return slot2 and slot3 or slot4
end

function slot0.getSkillLv(slot0, slot1)
	slot0:_checkSkill()

	if slot0:isUniqueSkill(slot1) then
		return FightEnum.UniqueSkillCardLv
	end

	if slot1 == FightEnum.UniversalCard1 then
		return 1
	elseif slot1 == FightEnum.UniversalCard2 then
		return 2
	end

	if lua_skill.configDict[slot1] then
		if slot2.skillRank ~= 0 then
			return slot2.skillRank
		elseif slot0._skillCurrCardLvDict[slot1] then
			return slot3
		end
	else
		logError("技能表找不到id:" .. tostring(slot1))
	end

	return FightEnum.MaxSkillCardLv
end

function slot0.getSkillNextLvId(slot0, slot1)
	slot0:_checkSkill()

	return slot0._skillNextCardLvDict[slot1]
end

function slot0.getSkillPrevLvId(slot0, slot1)
	slot0:_checkSkill()

	return slot0._skillPrevCardLvDict[slot1]
end

function slot0.isUniqueSkill(slot0, slot1)
	return lua_skill.configDict[slot1] and slot2.isBigSkill and slot2.isBigSkill == 1
end

function slot0.isActiveSkill(slot0, slot1)
	if slot1 <= 0 then
		return false
	end

	slot0:_checkSkill()

	if slot0._skillHeroIdDict[slot1] or slot0._skillMonsterIdDict[slot1] then
		return true
	end

	return false
end

function slot0.getRestrain(slot0, slot1, slot2)
	if slot0._restrainDict[slot1] then
		return slot3[slot2]
	end
end

function slot0.getBuffTag(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in ipairs(lua_skill_buff.configList) do
		if slot7.name == slot1 then
			slot2 = slot7.typeId

			break
		end
	end

	if not slot2 then
		return ""
	end

	if lua_skill_bufftype.configDict[slot2] and lua_skill_buff_desc.configDict[slot3.type] then
		return slot4.name
	end

	return ""
end

function slot0.restrainedBy(slot0, slot1)
	if not slot0._restrainDict then
		return nil
	end

	for slot5, slot6 in pairs(slot0._restrainDict) do
		if slot6[slot1] and slot6[slot1] > 1000 then
			return slot5
		end
	end

	return nil
end

function slot0.restrained(slot0, slot1)
	if not slot0._restrainDict[slot1] then
		return nil
	end

	for slot6, slot7 in pairs(slot2) do
		if slot7 > 1000 then
			return slot6
		end
	end

	return nil
end

function slot0.getSkillHeroId(slot0, slot1)
	slot0:_checkSkill()

	return slot0._skillHeroIdDict[slot1]
end

function slot0.setSkillDict(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0._skillCurrCardLvDict = slot1
	slot0._skillNextCardLvDict = slot2
	slot0._skillPrevCardLvDict = slot3
	slot0._skillHeroIdDict = slot4
	slot0._skillMonsterIdDict = slot5
	slot0.parseSkill = true
end

function slot0.isParsedSkill(slot0)
	return slot0.parseSkill
end

function slot0._checkSkill(slot0)
	if slot0.parseSkill then
		return
	end

	slot0.parseSkill = true
	slot0._skillCurrCardLvDict = {}
	slot0._skillNextCardLvDict = {}
	slot0._skillPrevCardLvDict = {}
	slot0._skillHeroIdDict = {}
	slot0._skillMonsterIdDict = {}

	for slot4, slot5 in ipairs(lua_character.configList) do
		if not string.nilorempty(slot5.skill) then
			for slot10, slot11 in ipairs(FightStrUtil.instance:getSplitString2Cache(slot5.skill, true)) do
				slot12 = slot11[2]
				slot13 = slot11[3]
				slot14 = slot11[4]
				slot0._skillCurrCardLvDict[slot12] = 1
				slot0._skillCurrCardLvDict[slot13] = 2
				slot0._skillCurrCardLvDict[slot14] = 3
				slot0._skillNextCardLvDict[slot12] = slot13
				slot0._skillNextCardLvDict[slot13] = slot14
				slot0._skillPrevCardLvDict[slot13] = slot12
				slot0._skillPrevCardLvDict[slot14] = slot13
				slot15 = slot5.id
				slot0._skillHeroIdDict[slot12] = slot15
				slot0._skillHeroIdDict[slot13] = slot15
				slot0._skillHeroIdDict[slot14] = slot15
			end
		end
	end

	for slot4, slot5 in ipairs(lua_skill_ex_level.configList) do
		slot6 = slot5.heroId

		if not string.nilorempty(slot5.skillGroup1) then
			for slot12, slot13 in ipairs(FightStrUtil.instance:getSplitToNumberCache(slot7, "|")) do
				slot0._skillHeroIdDict[slot13] = slot6
				slot0._skillCurrCardLvDict[slot13] = slot12
			end
		end

		if not string.nilorempty(slot5.skillGroup2) then
			for slot13, slot14 in ipairs(FightStrUtil.instance:getSplitToNumberCache(slot8, "|")) do
				slot0._skillHeroIdDict[slot14] = slot6
				slot0._skillCurrCardLvDict[slot14] = slot13
			end
		end

		slot0._skillHeroIdDict[slot5.skillEx] = slot6
	end

	for slot4, slot5 in ipairs(lua_monster.configList) do
		slot6 = slot5.id

		if FightStrUtil.instance:getSplitString2Cache(slot5.activeSkill, true, "|", "#") then
			for slot11, slot12 in ipairs(slot7) do
				slot13 = 1

				for slot17, slot18 in ipairs(slot12) do
					if lua_skill.configDict[slot18] then
						slot0._skillMonsterIdDict[slot18] = slot6
						slot0._skillCurrCardLvDict[slot18] = slot13
						slot13 = slot13 + 1
					end
				end
			end
		end

		if slot5.uniqueSkill and #slot8 > 0 then
			for slot12, slot13 in ipairs(slot8) do
				slot0._skillMonsterIdDict[slot13] = slot6
			end
		end
	end
end

function slot0._checkskinSkill(slot0)
	if slot0._skinSkillTLDict then
		return
	end

	slot0._skinSkillTLDict = {}

	slot0:_doCheckskinSkill(lua_skin.configList)
	slot0:_doCheckskinSkill(lua_monster_skin.configList)
end

function slot0._doCheckskinSkill(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if not string.nilorempty(slot6.skills) then
			slot12 = "|"
			slot13 = "#"

			for slot12, slot13 in ipairs(FightStrUtil.instance:getSplitString2Cache(slot6.skills, false, slot12, slot13)) do
				if tonumber(slot13[1]) and slot13[2] then
					-- Nothing
				end
			end

			slot0._skinSkillTLDict[slot6.id] = {
				[slot14] = slot15
			}
		end
	end
end

function slot0.getSkillEffectCO(slot0, slot1)
	return lua_skill.configDict[slot1] and lua_skill_effect.configDict[slot2.skillEffect]
end

function slot0.getPassiveSkills(slot0, slot1)
	slot2 = nil

	if lua_monster.configDict[slot1] and slot3.passiveSkill then
		slot4 = "|"

		if string.find(slot3.passiveSkill, "#") then
			slot4 = "#"
		end

		slot8 = slot3.passiveSkill

		for slot8 = #tabletool.copy(FightStrUtil.instance:getSplitToNumberCache(slot8, slot4)), slot3.passiveSkillCount + 1, -1 do
			slot2[slot8] = nil
		end
	end

	if not string.nilorempty(slot3.passiveSkillsEx) then
		slot4 = "|"

		if string.find(slot3.passiveSkillsEx, "#") then
			slot4 = "#"
		end

		for slot9, slot10 in ipairs(FightStrUtil.instance:getSplitToNumberCache(slot3.passiveSkillsEx, slot4)) do
			table.insert(slot2 or {}, slot10)
		end
	end

	return slot2
end

function slot0.getPassiveSkillsAfterUIFilter(slot0, slot1)
	slot3 = uv0.instance:getPassiveSkills(slot1)

	for slot8, slot9 in ipairs(FightStrUtil.instance:getSplitToNumberCache(lua_monster.configDict[slot1].uiFilterSkill, "|")) do
		if tabletool.indexOf(slot3, slot9) then
			table.remove(slot3, slot10)
		end
	end

	return slot3
end

function slot0.getMonsterGuideFocusConfig(slot0, slot1, slot2, slot3, slot4)
	if lua_monster_guide_focus.configDict[slot1] and lua_monster_guide_focus.configDict[slot1][slot2] and lua_monster_guide_focus.configDict[slot1][slot2][slot3] then
		return lua_monster_guide_focus.configDict[slot1][slot2][slot3][slot4]
	end
end

function slot0.getNewMonsterConfig(slot0, slot1)
	return not string.nilorempty(slot1.highPriorityName) or not string.nilorempty(slot1.highPriorityNameEng) or not string.nilorempty(slot1.highPriorityDes)
end

function slot0.getMonsterName(slot0, slot1)
	return slot0:getNewMonsterConfig(slot1) and slot1.highPriorityName or slot1.name
end

function slot0.getBuffFeatures(slot0, slot1)
	if not slot0._buffFeatureDictDict[slot1] then
		slot2 = {}

		if lua_skill_buff.configDict[slot1] and string.split(slot3.features, "|") then
			for slot8, slot9 in ipairs(slot4) do
				if tonumber(string.split(slot9, "#")[1]) and lua_buff_act.configDict[slot11] and slot12.type then
					slot2[slot12.type] = {
						featureType = slot12.type,
						featureStr = slot9
					}
				end
			end
		end

		slot0._buffFeatureDictDict[slot1] = slot2
	end

	return slot2
end

function slot0.hasBuffFeature(slot0, slot1, slot2)
	return slot0:getBuffFeatures(slot1)[slot2]
end

function slot0.getSkinSpineActionDict(slot0, slot1, slot2)
	if not slot0:getSkinCO(slot1) then
		return
	end

	slot5 = lua_skin_spine_action.configDict[slot3.showTemplate]

	if slot2 and slot5 and not slot5[slot2] then
		slot5 = nil
	end

	if not slot5 and lua_skin.configDict[slot4] and uv0.instance:getSkinCO(slot3.id - slot3.id % 10 + 1) then
		slot5 = lua_skin_spine_action.configDict[slot7.showTemplate]
	end

	return slot5
end

function slot0.getSummonedConfig(slot0, slot1, slot2)
	return lua_summoned.configDict[slot1] and lua_summoned.configDict[slot1][slot2]
end

function slot0.getRejectActBuffTypeList(slot0, slot1)
	return slot0._rejectSpineAct and slot0._rejectSpineAct[slot1]
end

function slot0._dealFightBuffRejectAct(slot0)
	slot0._rejectSpineAct = {}

	for slot4, slot5 in ipairs(lua_fight_buff_reject_act.configList) do
		for slot10, slot11 in ipairs(string.split(slot5.rejectAct, "#")) do
			slot0._rejectSpineAct[slot11] = slot0._rejectSpineAct[slot11] or {}

			table.insert(slot0._rejectSpineAct[slot11], slot5.id)
		end
	end
end

function slot0._checkMonsterGroupBoss0(slot0)
	if isDebugBuild then
		slot1 = nil

		for slot5, slot6 in ipairs(lua_monster_group.configList) do
			if slot6.bossId == "0" then
				table.insert(slot1 or {}, slot6.id)
			end
		end

		if slot1 then
			logError("以下怪物组配错了 bossId = 0，请检查是否有误\n" .. table.concat(slot1, ","))
		end
	end
end

slot0.DescNameTag = "{name}"

function slot0.getSkillEffectDesc(slot0, slot1, slot2)
	if not slot2 then
		return ""
	end

	if isDebugBuild or SLFramework.FrameworkSettings.IsEditor then
		slot0:setGetDescFlag(true)
		slot0:setGetDescFlag(false)

		if string.match(slot2.desc, uv0.DescNameTag) and string.nilorempty(slot1) then
			logError("monster name is nil or empty str, please check !!!" .. string.format("effectId : %s, effect desc : %s", slot2.id, slot3))

			return slot3
		end

		if string.nilorempty(slot1) then
			return slot3
		end

		return string.gsub(slot3, uv0.DescNameTag, slot1)
	end

	slot3 = slot2.desc

	if string.nilorempty(slot1) then
		return slot3
	end

	return string.gsub(slot3, uv0.DescNameTag, slot1)
end

function slot0.getEntitySkillDesc(slot0, slot1, slot2, slot3)
	if not (slot2 or lua_skill.configDict[slot3]) then
		if slot3 then
			logError("技能表找不到id : " .. tostring(slot3))
		end

		return ""
	end

	return slot0:getSkillEffectDesc(slot0:getEntityName(slot1), slot2)
end

function slot0.getEntityName(slot0, slot1)
	slot3 = FightDataHelper.entityMgr:getById(slot1) and slot2:getCO()

	return slot3 and slot3.name or ""
end

function slot0._rebuildSkillEffectTab(slot0)
	if isDebugBuild or SLFramework.FrameworkSettings.IsEditor then
		for slot6, slot7 in ipairs(lua_skill_effect.configList) do
			setmetatable(slot7, {
				__index = function (slot0, slot1)
					if slot1 == "desc" and not uv0.instance:isSetDescFlag() then
						logError("获取调用效果 desc 字段， 必须使用 FightConfig.getSkillEffectDesc 函数")
					end

					return uv1.__index(slot0, slot1)
				end,
				__newindex = getmetatable(lua_skill_effect.configList[1]).__newindex
			})
		end
	end
end

function slot0.setGetDescFlag(slot0, slot1)
	slot0.descFlag = slot1
end

function slot0.isSetDescFlag(slot0)
	return slot0.descFlag
end

slot0.instance = slot0.New()

return slot0
