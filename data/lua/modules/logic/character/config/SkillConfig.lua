module("modules.logic.character.config.SkillConfig", package.seeall)

local var_0_0 = class("SkillConfig", BaseConfig)

function var_0_0.fmtTagDescColor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	return formatLuaLang("tag_desc_color_overseas", arg_1_3, arg_1_1, arg_1_2)
end

function var_0_0.fmtTagDesc(arg_2_0, arg_2_1, arg_2_2)
	return string.format(luaLang("fightfoucusview_passiveskill_desc_overseas"), arg_2_1, arg_2_2)
end

function var_0_0.replaceHeroName(arg_3_0, arg_3_1)
	if string.nilorempty(arg_3_0) then
		return arg_3_0
	end

	arg_3_0 = string.gsub(arg_3_0, "{name}", function(arg_4_0)
		local var_4_0 = HeroConfig.instance:getHeroCO(arg_3_1)

		if var_4_0 then
			return var_4_0.name
		end

		return arg_4_0
	end)

	return arg_3_0
end

function var_0_0.ctor(arg_5_0)
	arg_5_0.passiveskillConfig = nil
	arg_5_0.exskillConfig = nil
	arg_5_0.levelConfig = nil
	arg_5_0.rankConfig = nil
	arg_5_0.cosumeConfig = nil
	arg_5_0.talentConfig = nil
	arg_5_0.growConfig = nil
	arg_5_0.skillBuffDescConfig = nil
	arg_5_0.skillBuffDescConfigByName = nil
	arg_5_0.heroUpgradeBreakLevelConfig = nil
end

function var_0_0.reqConfigNames(arg_6_0)
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

function var_0_0.onConfigLoaded(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == "character_talent" then
		arg_7_0.talentConfig = arg_7_2
	elseif arg_7_1 == "skill_ex_level" then
		arg_7_0.exskillConfig = arg_7_2
	elseif arg_7_1 == "skill_passive_level" then
		arg_7_0.passiveskillConfig = arg_7_2
	elseif arg_7_1 == "character_level" then
		arg_7_0.levelConfig = arg_7_2
	elseif arg_7_1 == "character_rank" then
		arg_7_0.rankConfig = arg_7_2
	elseif arg_7_1 == "character_cosume" then
		arg_7_0.cosumeConfig = arg_7_2
	elseif arg_7_1 == "character_grow" then
		arg_7_0.growConfig = arg_7_2
	elseif arg_7_1 == "skill_eff_desc" then
		arg_7_0.skillEffectDescConfig = arg_7_2
	elseif arg_7_1 == "skill_buff_desc" then
		arg_7_0.skillBuffDescConfig = arg_7_2
	elseif arg_7_1 == "hero_upgrade_breaklevel" then
		arg_7_0.heroUpgradeBreakLevelConfig = arg_7_2
	end
end

function var_0_0.getGrowCo(arg_8_0)
	return arg_8_0.growConfig.configDict
end

function var_0_0.getGrowCO(arg_9_0, arg_9_1)
	return arg_9_0.growConfig.configDict[arg_9_1]
end

function var_0_0.gettalentCO(arg_10_0, arg_10_1, arg_10_2)
	return arg_10_0.talentConfig.configDict[arg_10_1][arg_10_2]
end

function var_0_0.getherotalentsCo(arg_11_0, arg_11_1)
	return arg_11_0.talentConfig.configDict[arg_11_1]
end

function var_0_0.getpassiveskillCO(arg_12_0, arg_12_1, arg_12_2)
	return arg_12_0.passiveskillConfig.configDict[arg_12_1][arg_12_2]
end

function var_0_0.getpassiveskillsCO(arg_13_0, arg_13_1)
	return arg_13_0.passiveskillConfig.configDict[arg_13_1]
end

function var_0_0.getHeroExSkillLevelByLevel(arg_14_0, arg_14_1, arg_14_2)
	local var_14_0 = 0
	local var_14_1 = 1
	local var_14_2 = arg_14_0:getheroranksCO(arg_14_1)

	for iter_14_0 = 1, #var_14_2 do
		local var_14_3 = GameUtil.splitString2(var_14_2[iter_14_0].effect, true)
		local var_14_4 = false

		for iter_14_1, iter_14_2 in pairs(var_14_3) do
			if iter_14_2[1] == 1 and arg_14_2 <= iter_14_2[2] then
				var_14_1 = iter_14_0
				var_14_4 = true

				break
			end
		end

		if var_14_4 then
			for iter_14_3, iter_14_4 in pairs(var_14_3) do
				if iter_14_4[1] == 2 then
					var_14_0 = iter_14_4[2]

					break
				end
			end
		end

		if var_14_4 then
			break
		end
	end

	return var_14_0, var_14_1
end

function var_0_0.getPassiveSKillsCoByExSkillLevel(arg_15_0, arg_15_1, arg_15_2)
	arg_15_2 = arg_15_2 or 1

	local var_15_0 = arg_15_0:getpassiveskillsCO(arg_15_1)
	local var_15_1 = tabletool.copy(var_15_0)
	local var_15_2

	for iter_15_0 = arg_15_2, 1, -1 do
		local var_15_3 = arg_15_0:getherolevelexskillCO(arg_15_1, iter_15_0)

		if not string.nilorempty(var_15_3.passiveSkill) then
			arg_15_0:_handleReplacePassiveSkill(var_15_3.passiveSkill, var_15_1)
		end
	end

	return var_15_1
end

function var_0_0._handleReplacePassiveSkill(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = string.split(arg_16_1, "|")
	local var_16_1
	local var_16_2
	local var_16_3

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		local var_16_4 = string.splitToNumber(iter_16_1, "#")
		local var_16_5 = var_16_4[1]
		local var_16_6 = var_16_4[2]

		for iter_16_2, iter_16_3 in pairs(arg_16_2) do
			if iter_16_3.skillPassive == var_16_5 then
				arg_16_2[iter_16_2] = {
					skillPassive = var_16_6
				}

				break
			end
		end
	end
end

function var_0_0.getherolevelexskillCO(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0.exskillConfig.configDict[arg_17_1]

	if not var_17_0 then
		logError(string.format("ex skill not found heroid : %s `s config ", arg_17_1))

		return nil
	end

	if var_17_0[arg_17_2] == nil then
		logError(string.format("ex skill config gei nil, heroid : %s, skillLevel : %s", arg_17_1, arg_17_2))
	end

	return var_17_0[arg_17_2]
end

function var_0_0.getheroexskillco(arg_18_0, arg_18_1)
	return arg_18_0.exskillConfig.configDict[arg_18_1]
end

function var_0_0.getExSkillLevel(arg_19_0, arg_19_1)
	if not arg_19_0._exSkillLevel then
		arg_19_0._exSkillLevel = {}

		for iter_19_0, iter_19_1 in ipairs(arg_19_0.exskillConfig.configList) do
			arg_19_0._exSkillLevel[iter_19_1.skillEx] = iter_19_1.skillLevel
		end
	end

	return arg_19_0._exSkillLevel[arg_19_1]
end

function var_0_0.getherolevelCO(arg_20_0, arg_20_1, arg_20_2)
	return arg_20_0.levelConfig.configDict[arg_20_1][arg_20_2]
end

function var_0_0.getherolevelsCO(arg_21_0, arg_21_1)
	return arg_21_0.levelConfig.configDict[arg_21_1]
end

function var_0_0.getherorankCO(arg_22_0, arg_22_1, arg_22_2)
	return arg_22_0.rankConfig.configDict[arg_22_1][arg_22_2]
end

function var_0_0.getheroranksCO(arg_23_0, arg_23_1)
	return arg_23_0.rankConfig.configDict[arg_23_1]
end

function var_0_0.getHeroRankAttribute(arg_24_0, arg_24_1, arg_24_2)
	local var_24_0 = {}

	var_24_0.hp = 0
	var_24_0.atk = 0
	var_24_0.def = 0
	var_24_0.mdef = 0
	var_24_0.technic = 0

	local var_24_1 = arg_24_0:getheroranksCO(arg_24_1)

	for iter_24_0, iter_24_1 in pairs(var_24_1) do
		if arg_24_2 >= iter_24_1.rank then
			local var_24_2 = arg_24_0:getHeroAttributeByRankConfig(iter_24_1)

			var_24_0.hp = var_24_0.hp + var_24_2.hp
			var_24_0.atk = var_24_0.atk + var_24_2.atk
			var_24_0.def = var_24_0.def + var_24_2.def
			var_24_0.mdef = var_24_0.mdef + var_24_2.mdef
			var_24_0.technic = var_24_0.technic + var_24_2.technic
		end
	end

	return var_24_0
end

function var_0_0.getHeroAttributeByRankConfig(arg_25_0, arg_25_1)
	local var_25_0 = {}

	var_25_0.hp = 0
	var_25_0.atk = 0
	var_25_0.def = 0
	var_25_0.mdef = 0
	var_25_0.technic = 0

	local var_25_1 = arg_25_1.effect

	if string.nilorempty(var_25_1) then
		return var_25_0
	end

	local var_25_2 = string.split(var_25_1, "|")

	for iter_25_0, iter_25_1 in ipairs(var_25_2) do
		local var_25_3 = string.split(iter_25_1, "#")

		if tonumber(var_25_3[1]) == 4 then
			local var_25_4 = tonumber(var_25_3[2]) / 1000
			local var_25_5 = arg_25_0:getherolevelCO(arg_25_1.heroId, 1)

			var_25_0.hp = var_25_0.hp + math.floor(var_25_5.hp * var_25_4)
			var_25_0.atk = var_25_0.atk + math.floor(var_25_5.atk * var_25_4)
			var_25_0.def = var_25_0.def + math.floor(var_25_5.def * var_25_4)
			var_25_0.mdef = var_25_0.mdef + math.floor(var_25_5.mdef * var_25_4)
			var_25_0.technic = var_25_0.technic + math.floor(var_25_5.technic * var_25_4)
		end
	end

	return var_25_0
end

function var_0_0.getcosumeCO(arg_26_0, arg_26_1, arg_26_2)
	return arg_26_0.cosumeConfig.configDict[arg_26_1][arg_26_2]
end

function var_0_0.getSkillEffectDescsCo(arg_27_0)
	return arg_27_0.skillEffectDescConfig.configDict
end

function var_0_0.getSkillEffectDescCo(arg_28_0, arg_28_1)
	return arg_28_0.skillEffectDescConfig.configDict[arg_28_1]
end

function var_0_0.getSkillEffectDescCoByName(arg_29_0, arg_29_1)
	local var_29_0 = LangSettings.instance:getCurLang() or -1

	if not arg_29_0.skillBuffDescConfigByName then
		arg_29_0.skillBuffDescConfigByName = {}
	end

	if not arg_29_0.skillBuffDescConfigByName[var_29_0] then
		local var_29_1 = {}

		for iter_29_0, iter_29_1 in ipairs(arg_29_0.skillEffectDescConfig.configList) do
			var_29_1[iter_29_1.name] = iter_29_1
		end

		arg_29_0.skillBuffDescConfigByName[var_29_0] = var_29_1
	end

	local var_29_2 = arg_29_0.skillBuffDescConfigByName[var_29_0][arg_29_1]

	if not var_29_2 then
		logError(string.format("技能概要 '%s' 不存在!!!", tostring(arg_29_1)))
	end

	return var_29_2
end

function var_0_0.processSkillDesKeyWords(arg_30_0, arg_30_1)
	return string.gsub(arg_30_1, "<id:(.-)>", "")
end

function var_0_0.getSkillBuffDescsCo(arg_31_0)
	return arg_31_0.skillBuffDescConfig.configDict
end

function var_0_0.getSkillBuffDescCo(arg_32_0, arg_32_1)
	return arg_32_0.skillBuffDescConfig.configDict[arg_32_1]
end

function var_0_0.isGetNewSkin(arg_33_0, arg_33_1, arg_33_2)
	local var_33_0 = arg_33_0:getherorankCO(arg_33_1, arg_33_2)

	if not var_33_0 then
		logError("获取角色升级信息失败， heroId : " .. tostring(arg_33_1) .. ", rank : " .. tostring(arg_33_2))

		return false
	end

	local var_33_1 = string.split(var_33_0.effect, "|")

	for iter_33_0 = 1, #var_33_1 do
		if string.splitToNumber(var_33_1[iter_33_0], "#")[1] == 3 then
			return true
		end
	end

	return false
end

function var_0_0.getBaseAttr(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = {}
	local var_34_1 = arg_34_0:getherolevelCO(arg_34_1, arg_34_2)

	if not var_34_1 then
		local var_34_2 = arg_34_0:getherolevelsCO(arg_34_1)
		local var_34_3
		local var_34_4
		local var_34_5 = {}

		for iter_34_0, iter_34_1 in pairs(var_34_2) do
			table.insert(var_34_5, iter_34_1)
		end

		table.sort(var_34_5, function(arg_35_0, arg_35_1)
			return arg_35_0.level < arg_35_1.level
		end)

		for iter_34_2, iter_34_3 in ipairs(var_34_5) do
			if arg_34_2 > iter_34_3.level then
				var_34_3 = iter_34_3.level
				var_34_4 = var_34_5[iter_34_2 + 1].level
			end
		end

		local var_34_6 = arg_34_0:getherolevelCO(arg_34_1, var_34_3)
		local var_34_7 = arg_34_0:getherolevelCO(arg_34_1, var_34_4)

		var_34_0.hp = arg_34_0:_lerpAttr(var_34_6.hp, var_34_7.hp, var_34_3, var_34_4, arg_34_2)
		var_34_0.atk = arg_34_0:_lerpAttr(var_34_6.atk, var_34_7.atk, var_34_3, var_34_4, arg_34_2)
		var_34_0.def = arg_34_0:_lerpAttr(var_34_6.def, var_34_7.def, var_34_3, var_34_4, arg_34_2)
		var_34_0.mdef = arg_34_0:_lerpAttr(var_34_6.mdef, var_34_7.mdef, var_34_3, var_34_4, arg_34_2)
		var_34_0.technic = arg_34_0:_lerpAttr(var_34_6.technic, var_34_7.technic, var_34_3, var_34_4, arg_34_2)
		var_34_0.cri = arg_34_0:_lerpAttr(var_34_6.cri, var_34_7.cri, var_34_3, var_34_4, arg_34_2)
		var_34_0.recri = arg_34_0:_lerpAttr(var_34_6.recri, var_34_7.recri, var_34_3, var_34_4, arg_34_2)
		var_34_0.cri_dmg = arg_34_0:_lerpAttr(var_34_6.cri_dmg, var_34_7.cri_dmg, var_34_3, var_34_4, arg_34_2)
		var_34_0.cri_def = arg_34_0:_lerpAttr(var_34_6.cri_def, var_34_7.cri_def, var_34_3, var_34_4, arg_34_2)
		var_34_0.add_dmg = arg_34_0:_lerpAttr(var_34_6.add_dmg, var_34_7.add_dmg, var_34_3, var_34_4, arg_34_2)
		var_34_0.drop_dmg = arg_34_0:_lerpAttr(var_34_6.drop_dmg, var_34_7.drop_dmg, var_34_3, var_34_4, arg_34_2)
	else
		var_34_0.hp = var_34_1.hp
		var_34_0.atk = var_34_1.atk
		var_34_0.def = var_34_1.def
		var_34_0.mdef = var_34_1.mdef
		var_34_0.technic = var_34_1.technic
		var_34_0.cri = var_34_1.cri
		var_34_0.recri = var_34_1.recri
		var_34_0.cri_dmg = var_34_1.cri_dmg
		var_34_0.cri_def = var_34_1.cri_def
		var_34_0.add_dmg = var_34_1.add_dmg
		var_34_0.drop_dmg = var_34_1.drop_dmg
	end

	return var_34_0
end

function var_0_0._lerpAttr(arg_36_0, arg_36_1, arg_36_2, arg_36_3, arg_36_4, arg_36_5)
	return math.floor((arg_36_2 - arg_36_1) * (arg_36_5 - arg_36_3) / (arg_36_4 - arg_36_3)) + arg_36_1
end

function var_0_0.getTalentDamping(arg_37_0)
	if arg_37_0.talent_damping then
		return arg_37_0.talent_damping
	end

	arg_37_0.talent_damping = {}

	local var_37_0 = string.split(lua_fight_const.configDict[10][2], "|")

	for iter_37_0, iter_37_1 in ipairs(var_37_0) do
		local var_37_1 = string.splitToNumber(iter_37_1, "#")

		table.insert(arg_37_0.talent_damping, var_37_1)
	end

	return arg_37_0.talent_damping
end

function var_0_0.getExSkillDesc(arg_38_0, arg_38_1, arg_38_2)
	if arg_38_1 == nil then
		return ""
	end

	local var_38_0 = arg_38_1.desc

	arg_38_2 = arg_38_2 or arg_38_1.heroId

	if LangSettings.instance:isEn() then
		var_38_0 = var_0_0.replaceHeroName(var_38_0, arg_38_2)
	end

	local var_38_1, var_38_2, var_38_3 = string.find(var_38_0, "▩(%d)%%s")

	if not var_38_3 then
		logError("not fount skillIndex in desc : " .. var_38_0)

		return var_38_0
	end

	local var_38_4 = tonumber(var_38_3)
	local var_38_5

	if var_38_4 == 0 then
		var_38_5 = var_0_0.instance:getpassiveskillsCO(arg_38_2)[1].skillPassive
	else
		var_38_5 = var_0_0.instance:getHeroBaseSkillIdDict(arg_38_2)[var_38_4]
	end

	if not var_38_5 then
		logError("not fount skillId, skillIndex : " .. var_38_4)

		return var_38_0
	end

	return var_38_0, lua_skill.configDict[var_38_5].name, var_38_4
end

function var_0_0.getHeroBaseSkillIdDict(arg_39_0, arg_39_1)
	local var_39_0 = HeroConfig.instance:getHeroCO(arg_39_1)

	return arg_39_0:getHeroBaseSkillIdDictByStr(var_39_0.skill, var_39_0.exSkill)
end

function var_0_0.getHeroBaseSkillIdDictByStr(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = {}
	local var_40_1 = string.split(arg_40_1, "|")
	local var_40_2
	local var_40_3
	local var_40_4

	for iter_40_0 = 1, #var_40_1 do
		local var_40_5 = string.splitToNumber(var_40_1[iter_40_0], "#")

		var_40_0[var_40_5[1]] = var_40_5[2]
	end

	var_40_0[3] = arg_40_2

	return var_40_0
end

function var_0_0.getHeroAllSkillIdDict(arg_41_0, arg_41_1)
	local var_41_0 = HeroConfig.instance:getHeroCO(arg_41_1)

	return arg_41_0:getHeroAllSkillIdDictByStr(var_41_0.skill, var_41_0.exSkill)
end

function var_0_0.getHeroAllSkillIdDictByStr(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0 = {}
	local var_42_1 = string.split(arg_42_1, "|")
	local var_42_2
	local var_42_3

	for iter_42_0 = 1, #var_42_1 do
		local var_42_4 = string.splitToNumber(var_42_1[iter_42_0], "#")

		var_42_0[table.remove(var_42_4, 1)] = var_42_4
	end

	var_42_0[3] = {
		arg_42_2
	}

	return var_42_0
end

function var_0_0.getHeroBaseSkillIdDictByExSkillLevel(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	if arg_43_3 and arg_43_3.trialAttrCo then
		return arg_43_0:getHeroBaseSkillIdDictByStr(arg_43_3.trialAttrCo.activeSkill, arg_43_3.trialAttrCo.uniqueSkill)
	end

	local var_43_0 = arg_43_0:getHeroBaseSkillIdDict(arg_43_1)

	arg_43_3 = arg_43_3 or HeroModel.instance:getByHeroId(arg_43_1)
	arg_43_2 = arg_43_2 or CharacterEnum.showAttributeOption.ShowCurrent

	local var_43_1 = 0

	if arg_43_2 == CharacterEnum.showAttributeOption.ShowMax then
		var_43_1 = CharacterModel.instance:getMaxexskill(arg_43_1)
	else
		var_43_1 = arg_43_2 == CharacterEnum.showAttributeOption.ShowMin and 0 or arg_43_3.exSkillLevel
	end

	if var_43_1 < 1 then
		return var_43_0
	end

	local var_43_2 = math.min(var_43_1, CharacterEnum.MaxSkillExLevel)
	local var_43_3

	for iter_43_0 = 1, var_43_2 do
		local var_43_4 = arg_43_0:getherolevelexskillCO(arg_43_1, iter_43_0)

		if not string.nilorempty(var_43_4.skillGroup1) then
			var_43_0[1] = string.splitToNumber(var_43_4.skillGroup1, "|")[1]
		end

		if not string.nilorempty(var_43_4.skillGroup2) then
			var_43_0[2] = string.splitToNumber(var_43_4.skillGroup2, "|")[1]
		end

		if var_43_4.skillEx ~= 0 then
			var_43_0[3] = var_43_4.skillEx
		end
	end

	return var_43_0
end

function var_0_0.getHeroAllSkillIdDictByExSkillLevel(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4)
	if arg_44_3 and arg_44_3.trialAttrCo then
		return arg_44_0:getHeroAllSkillIdDictByStr(arg_44_3.trialAttrCo.activeSkill, arg_44_3.trialAttrCo.uniqueSkill)
	end

	local var_44_0 = arg_44_0:getHeroAllSkillIdDict(arg_44_1)

	arg_44_3 = arg_44_3 or HeroModel.instance:getByHeroId(arg_44_1)
	arg_44_2 = arg_44_2 or CharacterEnum.showAttributeOption.ShowCurrent

	local var_44_1 = 0

	if arg_44_2 == CharacterEnum.showAttributeOption.ShowMax then
		var_44_1 = CharacterModel.instance:getMaxexskill(arg_44_1)
	elseif arg_44_2 == CharacterEnum.showAttributeOption.ShowMin then
		var_44_1 = 0
	elseif arg_44_4 then
		var_44_1 = arg_44_4
	elseif arg_44_3 then
		var_44_1 = arg_44_3.exSkillLevel
	end

	if var_44_1 < 1 then
		return var_44_0
	end

	local var_44_2

	for iter_44_0 = 1, var_44_1 do
		local var_44_3 = arg_44_0:getherolevelexskillCO(arg_44_1, iter_44_0)

		if not string.nilorempty(var_44_3.skillGroup1) then
			var_44_0[1] = string.splitToNumber(var_44_3.skillGroup1, "|")
		end

		if not string.nilorempty(var_44_3.skillGroup2) then
			var_44_0[2] = string.splitToNumber(var_44_3.skillGroup2, "|")
		end

		if var_44_3.skillEx ~= 0 then
			var_44_0[3] = {
				var_44_3.skillEx
			}
		end
	end

	return var_44_0
end

function var_0_0.getRankLevelByLevel(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = arg_45_0.rankConfig.configDict[arg_45_1]

	if not var_45_0 then
		return 0
	end

	local var_45_1 = {}

	for iter_45_0, iter_45_1 in pairs(var_45_0) do
		table.insert(var_45_1, iter_45_1)
	end

	table.sort(var_45_1, function(arg_46_0, arg_46_1)
		return arg_46_0.rank < arg_46_1.rank
	end)

	local var_45_2 = 1

	for iter_45_2, iter_45_3 in ipairs(var_45_1) do
		local var_45_3 = 0

		for iter_45_4, iter_45_5 in pairs(GameUtil.splitString2(iter_45_3.effect, true, "|", "#")) do
			if iter_45_5[1] == 1 then
				var_45_3 = iter_45_5[2]

				break
			end
		end

		if arg_45_2 <= var_45_3 then
			return iter_45_3.rank
		end
	end

	return var_45_2
end

function var_0_0.getConstNum(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_0:getConstStr(arg_47_1)

	if string.nilorempty(var_47_0) then
		return 0
	else
		return tonumber(var_47_0)
	end
end

function var_0_0.getConstStr(arg_48_0, arg_48_1)
	local var_48_0 = lua_fight_const.configDict[arg_48_1]

	if not var_48_0 then
		printError("fight const not exist: ", arg_48_1)

		return nil
	end

	local var_48_1 = var_48_0.value

	if not string.nilorempty(var_48_1) then
		return var_48_1
	end

	return var_48_0.value2
end

function var_0_0.getHeroUpgradeSkill(arg_49_0, arg_49_1, arg_49_2, arg_49_3)
	local var_49_0 = arg_49_0.heroUpgradeBreakLevelConfig.configDict[arg_49_1]

	if not var_49_0 then
		return false, nil
	end

	local var_49_1 = var_49_0[arg_49_2]
	local var_49_2

	if arg_49_3 == CharacterEnum.skillIndex.Skill1 and not string.nilorempty(var_49_1.skillGroup1) then
		var_49_2 = string.splitToNumber(var_49_1.skillGroup1, "|")
	end

	if arg_49_3 == CharacterEnum.skillIndex.Skill2 and not string.nilorempty(var_49_1.skillGroup2) then
		var_49_2 = string.splitToNumber(var_49_1.skillGroup2, "|")
	end

	if arg_49_3 == CharacterEnum.skillIndex.SkillEx and var_49_1.skillEx ~= 0 then
		var_49_2 = {
			var_49_1.skillEx
		}
	end

	return var_49_2 ~= nil, var_49_2
end

var_0_0.instance = var_0_0.New()

return var_0_0
