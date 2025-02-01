module("modules.logic.character.config.SkillConfig", package.seeall)

slot0 = class("SkillConfig", BaseConfig)

function slot0.fmtTagDescColor(slot0, slot1, slot2, slot3)
	return formatLuaLang("tag_desc_color_overseas", slot3, slot1, slot2)
end

function slot0.fmtTagDesc(slot0, slot1, slot2)
	return string.format(luaLang("fightfoucusview_passiveskill_desc_overseas"), slot1, slot2)
end

function slot0.replaceHeroName(slot0, slot1)
	if string.nilorempty(slot0) then
		return slot0
	end

	return string.gsub(slot0, "{name}", function (slot0)
		if HeroConfig.instance:getHeroCO(uv0) then
			return slot1.name
		end

		return slot0
	end)
end

function slot0.ctor(slot0)
	slot0.passiveskillConfig = nil
	slot0.exskillConfig = nil
	slot0.levelConfig = nil
	slot0.rankConfig = nil
	slot0.cosumeConfig = nil
	slot0.talentConfig = nil
	slot0.growConfig = nil
	slot0.skillBuffDescConfig = nil
	slot0.skillBuffDescConfigByName = nil
	slot0.heroUpgradeBreakLevelConfig = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"character_level",
		"skill_ex_level",
		"character_rank",
		"character_talent",
		"character_grow",
		"skill_passive_level",
		"character_cosume",
		"skill_eff_desc",
		"fight_const",
		"skill_buff_desc",
		"hero_upgrade_breaklevel"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "character_talent" then
		slot0.talentConfig = slot2
	elseif slot1 == "skill_ex_level" then
		slot0.exskillConfig = slot2
	elseif slot1 == "skill_passive_level" then
		slot0.passiveskillConfig = slot2
	elseif slot1 == "character_level" then
		slot0.levelConfig = slot2
	elseif slot1 == "character_rank" then
		slot0.rankConfig = slot2
	elseif slot1 == "character_cosume" then
		slot0.cosumeConfig = slot2
	elseif slot1 == "character_grow" then
		slot0.growConfig = slot2
	elseif slot1 == "skill_eff_desc" then
		slot0.skillEffectDescConfig = slot2
	elseif slot1 == "skill_buff_desc" then
		slot0.skillBuffDescConfig = slot2
	elseif slot1 == "hero_upgrade_breaklevel" then
		slot0.heroUpgradeBreakLevelConfig = slot2
	end
end

function slot0.getGrowCo(slot0)
	return slot0.growConfig.configDict
end

function slot0.getGrowCO(slot0, slot1)
	return slot0.growConfig.configDict[slot1]
end

function slot0.gettalentCO(slot0, slot1, slot2)
	return slot0.talentConfig.configDict[slot1][slot2]
end

function slot0.getherotalentsCo(slot0, slot1)
	return slot0.talentConfig.configDict[slot1]
end

function slot0.getpassiveskillCO(slot0, slot1, slot2)
	return slot0.passiveskillConfig.configDict[slot1][slot2]
end

function slot0.getpassiveskillsCO(slot0, slot1)
	return slot0.passiveskillConfig.configDict[slot1]
end

function slot0.getHeroExSkillLevelByLevel(slot0, slot1, slot2)
	slot3 = 0
	slot4 = 1

	for slot9 = 1, #slot0:getheroranksCO(slot1) do
		slot11 = false

		for slot15, slot16 in pairs(GameUtil.splitString2(slot5[slot9].effect, true)) do
			if slot16[1] == 1 and slot2 <= slot16[2] then
				slot4 = slot9
				slot11 = true

				break
			end
		end

		if slot11 then
			for slot15, slot16 in pairs(slot10) do
				if slot16[1] == 2 then
					slot3 = slot16[2]

					break
				end
			end
		end

		if slot11 then
			break
		end
	end

	return slot3, slot4
end

function slot0.getPassiveSKillsCoByExSkillLevel(slot0, slot1, slot2)
	slot3 = tabletool.copy(slot0:getpassiveskillsCO(slot1))
	slot4 = nil

	for slot8 = slot2 or 1, 1, -1 do
		if not string.nilorempty(slot0:getherolevelexskillCO(slot1, slot8).passiveSkill) then
			slot0:_handleReplacePassiveSkill(slot4.passiveSkill, slot3)
		end
	end

	return slot3
end

function slot0._handleReplacePassiveSkill(slot0, slot1, slot2)
	slot4, slot5, slot6 = nil

	for slot10, slot11 in ipairs(string.split(slot1, "|")) do
		slot4 = string.splitToNumber(slot11, "#")

		for slot15, slot16 in pairs(slot2) do
			if slot16.skillPassive == slot4[1] then
				slot2[slot15] = {
					skillPassive = slot4[2]
				}

				break
			end
		end
	end
end

function slot0.getherolevelexskillCO(slot0, slot1, slot2)
	if not slot0.exskillConfig.configDict[slot1] then
		logError(string.format("ex skill not found heroid : %s `s config ", slot1))

		return nil
	end

	if slot3[slot2] == nil then
		logError(string.format("ex skill config gei nil, heroid : %s, skillLevel : %s", slot1, slot2))
	end

	return slot3[slot2]
end

function slot0.getheroexskillco(slot0, slot1)
	return slot0.exskillConfig.configDict[slot1]
end

function slot0.getExSkillLevel(slot0, slot1)
	if not slot0._exSkillLevel then
		slot0._exSkillLevel = {}

		for slot5, slot6 in ipairs(slot0.exskillConfig.configList) do
			slot0._exSkillLevel[slot6.skillEx] = slot6.skillLevel
		end
	end

	return slot0._exSkillLevel[slot1]
end

function slot0.getherolevelCO(slot0, slot1, slot2)
	return slot0.levelConfig.configDict[slot1][slot2]
end

function slot0.getherolevelsCO(slot0, slot1)
	return slot0.levelConfig.configDict[slot1]
end

function slot0.getherorankCO(slot0, slot1, slot2)
	return slot0.rankConfig.configDict[slot1][slot2]
end

function slot0.getheroranksCO(slot0, slot1)
	return slot0.rankConfig.configDict[slot1]
end

function slot0.getHeroRankAttribute(slot0, slot1, slot2)
	slot3 = {
		hp = 0,
		atk = 0,
		def = 0,
		mdef = 0,
		technic = 0
	}

	for slot8, slot9 in pairs(slot0:getheroranksCO(slot1)) do
		if slot9.rank <= slot2 then
			slot10 = slot0:getHeroAttributeByRankConfig(slot9)
			slot3.hp = slot3.hp + slot10.hp
			slot3.atk = slot3.atk + slot10.atk
			slot3.def = slot3.def + slot10.def
			slot3.mdef = slot3.mdef + slot10.mdef
			slot3.technic = slot3.technic + slot10.technic
		end
	end

	return slot3
end

function slot0.getHeroAttributeByRankConfig(slot0, slot1)
	if string.nilorempty(slot1.effect) then
		return {
			hp = 0,
			atk = 0,
			def = 0,
			mdef = 0,
			technic = 0
		}
	end

	for slot8, slot9 in ipairs(string.split(slot3, "|")) do
		if tonumber(string.split(slot9, "#")[1]) == 4 then
			slot12 = tonumber(slot10[2]) / 1000
			slot13 = slot0:getherolevelCO(slot1.heroId, 1)
			slot2.hp = slot2.hp + math.floor(slot13.hp * slot12)
			slot2.atk = slot2.atk + math.floor(slot13.atk * slot12)
			slot2.def = slot2.def + math.floor(slot13.def * slot12)
			slot2.mdef = slot2.mdef + math.floor(slot13.mdef * slot12)
			slot2.technic = slot2.technic + math.floor(slot13.technic * slot12)
		end
	end

	return slot2
end

function slot0.getcosumeCO(slot0, slot1, slot2)
	return slot0.cosumeConfig.configDict[slot1][slot2]
end

function slot0.getSkillEffectDescsCo(slot0)
	return slot0.skillEffectDescConfig.configDict
end

function slot0.getSkillEffectDescCo(slot0, slot1)
	return slot0.skillEffectDescConfig.configDict[slot1]
end

function slot0.getSkillEffectDescCoByName(slot0, slot1)
	slot2 = LangSettings.instance:getCurLang() or -1

	if not slot0.skillBuffDescConfigByName then
		slot0.skillBuffDescConfigByName = {}
	end

	if not slot0.skillBuffDescConfigByName[slot2] then
		for slot7, slot8 in ipairs(slot0.skillEffectDescConfig.configList) do
			-- Nothing
		end

		slot0.skillBuffDescConfigByName[slot2] = {
			[slot8.name] = slot8
		}
	end

	if not slot0.skillBuffDescConfigByName[slot2][slot1] then
		logError(string.format("技能概要 '%s' 不存在!!!", tostring(slot1)))
	end

	return slot3
end

function slot0.processSkillDesKeyWords(slot0, slot1)
	return string.gsub(slot1, "<id:(.-)>", "")
end

function slot0.getSkillBuffDescsCo(slot0)
	return slot0.skillBuffDescConfig.configDict
end

function slot0.getSkillBuffDescCo(slot0, slot1)
	return slot0.skillBuffDescConfig.configDict[slot1]
end

function slot0.isGetNewSkin(slot0, slot1, slot2)
	if not slot0:getherorankCO(slot1, slot2) then
		logError("获取角色升级信息失败， heroId : " .. tostring(slot1) .. ", rank : " .. tostring(slot2))

		return false
	end

	for slot8 = 1, #string.split(slot3.effect, "|") do
		if string.splitToNumber(slot4[slot8], "#")[1] == 3 then
			return true
		end
	end

	return false
end

function slot0.getBaseAttr(slot0, slot1, slot2)
	slot3 = {}

	if not slot0:getherolevelCO(slot1, slot2) then
		slot6, slot7 = nil
		slot8 = {}

		for slot12, slot13 in pairs(slot0:getherolevelsCO(slot1)) do
			table.insert(slot8, slot13)
		end

		table.sort(slot8, function (slot0, slot1)
			return slot0.level < slot1.level
		end)

		for slot12, slot13 in ipairs(slot8) do
			if slot13.level < slot2 then
				slot6 = slot13.level
				slot7 = slot8[slot12 + 1].level
			end
		end

		slot9 = slot0:getherolevelCO(slot1, slot6)
		slot10 = slot0:getherolevelCO(slot1, slot7)
		slot3.hp = slot0:_lerpAttr(slot9.hp, slot10.hp, slot6, slot7, slot2)
		slot3.atk = slot0:_lerpAttr(slot9.atk, slot10.atk, slot6, slot7, slot2)
		slot3.def = slot0:_lerpAttr(slot9.def, slot10.def, slot6, slot7, slot2)
		slot3.mdef = slot0:_lerpAttr(slot9.mdef, slot10.mdef, slot6, slot7, slot2)
		slot3.technic = slot0:_lerpAttr(slot9.technic, slot10.technic, slot6, slot7, slot2)
		slot3.cri = slot0:_lerpAttr(slot9.cri, slot10.cri, slot6, slot7, slot2)
		slot3.recri = slot0:_lerpAttr(slot9.recri, slot10.recri, slot6, slot7, slot2)
		slot3.cri_dmg = slot0:_lerpAttr(slot9.cri_dmg, slot10.cri_dmg, slot6, slot7, slot2)
		slot3.cri_def = slot0:_lerpAttr(slot9.cri_def, slot10.cri_def, slot6, slot7, slot2)
		slot3.add_dmg = slot0:_lerpAttr(slot9.add_dmg, slot10.add_dmg, slot6, slot7, slot2)
		slot3.drop_dmg = slot0:_lerpAttr(slot9.drop_dmg, slot10.drop_dmg, slot6, slot7, slot2)
	else
		slot3.hp = slot4.hp
		slot3.atk = slot4.atk
		slot3.def = slot4.def
		slot3.mdef = slot4.mdef
		slot3.technic = slot4.technic
		slot3.cri = slot4.cri
		slot3.recri = slot4.recri
		slot3.cri_dmg = slot4.cri_dmg
		slot3.cri_def = slot4.cri_def
		slot3.add_dmg = slot4.add_dmg
		slot3.drop_dmg = slot4.drop_dmg
	end

	return slot3
end

function slot0._lerpAttr(slot0, slot1, slot2, slot3, slot4, slot5)
	return math.floor((slot2 - slot1) * (slot5 - slot3) / (slot4 - slot3)) + slot1
end

function slot0.getTalentDamping(slot0)
	if slot0.talent_damping then
		return slot0.talent_damping
	end

	slot0.talent_damping = {}

	for slot5, slot6 in ipairs(string.split(lua_fight_const.configDict[10][2], "|")) do
		table.insert(slot0.talent_damping, string.splitToNumber(slot6, "#"))
	end

	return slot0.talent_damping
end

function slot0.getExSkillDesc(slot0, slot1, slot2)
	if slot1 == nil then
		return ""
	end

	if LangSettings.instance:isEn() then
		slot3 = uv0.replaceHeroName(slot1.desc, slot2 or slot1.heroId)
	end

	slot4, slot5, slot6 = string.find(slot3, "▩(%d)%%s")

	if not slot6 then
		logError("not fount skillIndex in desc : " .. slot3)

		return slot3
	end

	slot7 = nil

	if not ((tonumber(slot6) ~= 0 or uv0.instance:getpassiveskillsCO(slot2)[1].skillPassive) and uv0.instance:getHeroBaseSkillIdDict(slot2)[slot6]) then
		logError("not fount skillId, skillIndex : " .. slot6)

		return slot3
	end

	return slot3, lua_skill.configDict[slot7].name, slot6
end

function slot0.getHeroBaseSkillIdDict(slot0, slot1)
	slot2 = HeroConfig.instance:getHeroCO(slot1)

	return slot0:getHeroBaseSkillIdDictByStr(slot2.skill, slot2.exSkill)
end

function slot0.getHeroBaseSkillIdDictByStr(slot0, slot1, slot2)
	slot5, slot6, slot7 = nil

	for slot11 = 1, #string.split(slot1, "|") do
		slot7 = string.splitToNumber(slot4[slot11], "#")
	end

	return {
		[slot7[1]] = slot7[2],
		[3] = slot2
	}
end

function slot0.getHeroAllSkillIdDict(slot0, slot1)
	slot2 = HeroConfig.instance:getHeroCO(slot1)

	return slot0:getHeroAllSkillIdDictByStr(slot2.skill, slot2.exSkill)
end

function slot0.getHeroAllSkillIdDictByStr(slot0, slot1, slot2)
	slot5, slot6 = nil

	for slot10 = 1, #string.split(slot1, "|") do
		slot6 = string.splitToNumber(slot4[slot10], "#")
	end

	return {
		[table.remove(slot6, 1)] = slot6,
		[3] = {
			slot2
		}
	}
end

function slot0.getHeroBaseSkillIdDictByExSkillLevel(slot0, slot1, slot2, slot3)
	if slot3 and slot3.trialAttrCo then
		return slot0:getHeroBaseSkillIdDictByStr(slot3.trialAttrCo.activeSkill, slot3.trialAttrCo.uniqueSkill)
	end

	slot2 = slot2 or CharacterEnum.showAttributeOption.ShowCurrent
	slot5 = 0

	if ((slot2 ~= CharacterEnum.showAttributeOption.ShowMax or CharacterModel.instance:getMaxexskill(slot1)) and (slot2 == CharacterEnum.showAttributeOption.ShowMin and 0 or (slot3 or HeroModel.instance:getByHeroId(slot1)).exSkillLevel)) < 1 then
		return slot0:getHeroBaseSkillIdDict(slot1)
	end

	slot6 = nil

	for slot10 = 1, math.min(slot5, CharacterEnum.MaxSkillExLevel) do
		if not string.nilorempty(slot0:getherolevelexskillCO(slot1, slot10).skillGroup1) then
			slot4[1] = string.splitToNumber(slot6.skillGroup1, "|")[1]
		end

		if not string.nilorempty(slot6.skillGroup2) then
			slot4[2] = string.splitToNumber(slot6.skillGroup2, "|")[1]
		end

		if slot6.skillEx ~= 0 then
			slot4[3] = slot6.skillEx
		end
	end

	return slot4
end

function slot0.getHeroAllSkillIdDictByExSkillLevel(slot0, slot1, slot2, slot3, slot4)
	if slot3 and slot3.trialAttrCo then
		return slot0:getHeroAllSkillIdDictByStr(slot3.trialAttrCo.activeSkill, slot3.trialAttrCo.uniqueSkill)
	end

	slot5 = slot0:getHeroAllSkillIdDict(slot1)
	slot3 = slot3 or HeroModel.instance:getByHeroId(slot1)
	slot6 = 0

	if (slot2 or CharacterEnum.showAttributeOption.ShowCurrent) == CharacterEnum.showAttributeOption.ShowMax then
		slot6 = CharacterModel.instance:getMaxexskill(slot1)
	elseif slot2 == CharacterEnum.showAttributeOption.ShowMin then
		slot6 = 0
	elseif slot4 then
		slot6 = slot4
	elseif slot3 then
		slot6 = slot3.exSkillLevel
	end

	if slot6 < 1 then
		return slot5
	end

	slot7 = nil

	for slot11 = 1, slot6 do
		if not string.nilorempty(slot0:getherolevelexskillCO(slot1, slot11).skillGroup1) then
			slot5[1] = string.splitToNumber(slot7.skillGroup1, "|")
		end

		if not string.nilorempty(slot7.skillGroup2) then
			slot5[2] = string.splitToNumber(slot7.skillGroup2, "|")
		end

		if slot7.skillEx ~= 0 then
			slot5[3] = {
				slot7.skillEx
			}
		end
	end

	return slot5
end

function slot0.getRankLevelByLevel(slot0, slot1, slot2)
	if not slot0.rankConfig.configDict[slot1] then
		return 0
	end

	slot4 = {}

	for slot8, slot9 in pairs(slot3) do
		table.insert(slot4, slot9)
	end

	table.sort(slot4, function (slot0, slot1)
		return slot0.rank < slot1.rank
	end)

	slot5 = 1

	for slot9, slot10 in ipairs(slot4) do
		slot11 = 0
		slot15 = true
		slot16 = "|"

		for slot15, slot16 in pairs(GameUtil.splitString2(slot10.effect, slot15, slot16, "#")) do
			if slot16[1] == 1 then
				slot11 = slot16[2]

				break
			end
		end

		if slot2 <= slot11 then
			return slot10.rank
		end
	end

	return slot5
end

function slot0.getConstNum(slot0, slot1)
	if string.nilorempty(slot0:getConstStr(slot1)) then
		return 0
	else
		return tonumber(slot2)
	end
end

function slot0.getConstStr(slot0, slot1)
	if not lua_fight_const.configDict[slot1] then
		printError("fight const not exist: ", slot1)

		return nil
	end

	if not string.nilorempty(slot2.value) then
		return slot3
	end

	return slot2.value2
end

function slot0.getHeroUpgradeSkill(slot0, slot1, slot2, slot3)
	if not slot0.heroUpgradeBreakLevelConfig.configDict[slot1] then
		return false, nil
	end

	slot5 = slot4[slot2]
	slot6 = nil

	if slot3 == CharacterEnum.skillIndex.Skill1 and not string.nilorempty(slot5.skillGroup1) then
		slot6 = string.splitToNumber(slot5.skillGroup1, "|")
	end

	if slot3 == CharacterEnum.skillIndex.Skill2 and not string.nilorempty(slot5.skillGroup2) then
		slot6 = string.splitToNumber(slot5.skillGroup2, "|")
	end

	if slot3 == CharacterEnum.skillIndex.SkillEx and slot5.skillEx ~= 0 then
		slot6 = {
			slot5.skillEx
		}
	end

	return slot6 ~= nil, slot6
end

slot0.instance = slot0.New()

return slot0
