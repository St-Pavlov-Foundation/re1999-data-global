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
		"hero_upgrade_breaklevel",
		"fight_card_footnote"
	}
end

function var_0_0.onConfigLoaded(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_1 == "character_talent" then
		arg_7_0.talentConfig = arg_7_2
	elseif arg_7_1 == "skill_ex_level" then
		local function var_7_0(arg_8_0, arg_8_1, arg_8_2)
			logError("Can't modify config field: " .. arg_8_1)
		end

		for iter_7_0, iter_7_1 in ipairs(arg_7_2.configList) do
			local var_7_1 = getmetatable(iter_7_1)

			var_7_1.__newindex = nil
			iter_7_1.skillGroup1 = string.split(iter_7_1.skillGroup1, ",")[1]
			iter_7_1.skillGroup2 = string.split(iter_7_1.skillGroup2, ",")[1]
			var_7_1.__newindex = var_7_0
		end

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
	elseif arg_7_1 == "fight_card_footnote" then
		arg_7_0.fightCardFootnoteConfig = arg_7_2
	end
end

function var_0_0.getGrowCo(arg_9_0)
	return arg_9_0.growConfig.configDict
end

function var_0_0.getGrowCO(arg_10_0, arg_10_1)
	return arg_10_0.growConfig.configDict[arg_10_1]
end

function var_0_0.gettalentCO(arg_11_0, arg_11_1, arg_11_2)
	return arg_11_0.talentConfig.configDict[arg_11_1][arg_11_2]
end

function var_0_0.getherotalentsCo(arg_12_0, arg_12_1)
	return arg_12_0.talentConfig.configDict[arg_12_1]
end

function var_0_0.getpassiveskillCO(arg_13_0, arg_13_1, arg_13_2)
	return arg_13_0.passiveskillConfig.configDict[arg_13_1][arg_13_2]
end

function var_0_0.getpassiveskillsCO(arg_14_0, arg_14_1)
	return arg_14_0.passiveskillConfig.configDict[arg_14_1]
end

function var_0_0.getHeroExSkillLevelByLevel(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = 0
	local var_15_1 = 1
	local var_15_2 = arg_15_0:getheroranksCO(arg_15_1)

	for iter_15_0 = 1, #var_15_2 do
		local var_15_3 = GameUtil.splitString2(var_15_2[iter_15_0].effect, true)
		local var_15_4 = false

		for iter_15_1, iter_15_2 in pairs(var_15_3) do
			if iter_15_2[1] == 1 and arg_15_2 <= iter_15_2[2] then
				var_15_1 = iter_15_0
				var_15_4 = true

				break
			end
		end

		if var_15_4 then
			for iter_15_3, iter_15_4 in pairs(var_15_3) do
				if iter_15_4[1] == 2 then
					var_15_0 = iter_15_4[2]

					break
				end
			end
		end

		if var_15_4 then
			break
		end
	end

	return var_15_0, var_15_1
end

function var_0_0.getPassiveSKillsCoByExSkillLevel(arg_16_0, arg_16_1, arg_16_2)
	arg_16_2 = arg_16_2 or 1

	local var_16_0 = arg_16_0:getpassiveskillsCO(arg_16_1)
	local var_16_1 = tabletool.copy(var_16_0)
	local var_16_2

	for iter_16_0 = arg_16_2, 1, -1 do
		local var_16_3 = arg_16_0:getherolevelexskillCO(arg_16_1, iter_16_0)

		if not string.nilorempty(var_16_3.passiveSkill) then
			arg_16_0:_handleReplacePassiveSkill(var_16_3.passiveSkill, var_16_1)
		end
	end

	return var_16_1
end

function var_0_0._handleReplacePassiveSkill(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = string.split(arg_17_1, "|")
	local var_17_1
	local var_17_2
	local var_17_3

	for iter_17_0, iter_17_1 in ipairs(var_17_0) do
		local var_17_4 = string.splitToNumber(iter_17_1, "#")
		local var_17_5 = var_17_4[1]
		local var_17_6 = var_17_4[2]

		for iter_17_2, iter_17_3 in pairs(arg_17_2) do
			if iter_17_3.skillPassive == var_17_5 then
				arg_17_2[iter_17_2] = {
					skillPassive = var_17_6
				}

				break
			end
		end
	end
end

function var_0_0.getherolevelexskillCO(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = arg_18_0.exskillConfig.configDict[arg_18_1]

	if not var_18_0 then
		logError(string.format("ex skill not found heroid : %s `s config ", arg_18_1))

		return nil
	end

	if var_18_0[arg_18_2] == nil then
		logError(string.format("ex skill config gei nil, heroid : %s, skillLevel : %s", arg_18_1, arg_18_2))
	end

	return var_18_0[arg_18_2]
end

function var_0_0.getheroexskillco(arg_19_0, arg_19_1)
	return arg_19_0.exskillConfig.configDict[arg_19_1]
end

function var_0_0.getExSkillLevel(arg_20_0, arg_20_1)
	if not arg_20_0._exSkillLevel then
		arg_20_0._exSkillLevel = {}

		for iter_20_0, iter_20_1 in ipairs(arg_20_0.exskillConfig.configList) do
			arg_20_0._exSkillLevel[iter_20_1.skillEx] = iter_20_1.skillLevel
		end
	end

	return arg_20_0._exSkillLevel[arg_20_1]
end

function var_0_0.getherolevelCO(arg_21_0, arg_21_1, arg_21_2)
	return arg_21_0.levelConfig.configDict[arg_21_1][arg_21_2]
end

function var_0_0.getherolevelsCO(arg_22_0, arg_22_1)
	return arg_22_0.levelConfig.configDict[arg_22_1]
end

function var_0_0.getherorankCO(arg_23_0, arg_23_1, arg_23_2)
	return arg_23_0.rankConfig.configDict[arg_23_1][arg_23_2]
end

function var_0_0.getheroranksCO(arg_24_0, arg_24_1)
	return arg_24_0.rankConfig.configDict[arg_24_1]
end

function var_0_0.getHeroRankAttribute(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = {}

	var_25_0.hp = 0
	var_25_0.atk = 0
	var_25_0.def = 0
	var_25_0.mdef = 0
	var_25_0.technic = 0

	local var_25_1 = arg_25_0:getheroranksCO(arg_25_1)

	for iter_25_0, iter_25_1 in pairs(var_25_1) do
		if arg_25_2 >= iter_25_1.rank then
			local var_25_2 = arg_25_0:getHeroAttributeByRankConfig(iter_25_1)

			var_25_0.hp = var_25_0.hp + var_25_2.hp
			var_25_0.atk = var_25_0.atk + var_25_2.atk
			var_25_0.def = var_25_0.def + var_25_2.def
			var_25_0.mdef = var_25_0.mdef + var_25_2.mdef
			var_25_0.technic = var_25_0.technic + var_25_2.technic
		end
	end

	return var_25_0
end

function var_0_0.getHeroAttributeByRankConfig(arg_26_0, arg_26_1)
	local var_26_0 = {}

	var_26_0.hp = 0
	var_26_0.atk = 0
	var_26_0.def = 0
	var_26_0.mdef = 0
	var_26_0.technic = 0

	local var_26_1 = arg_26_1.effect

	if string.nilorempty(var_26_1) then
		return var_26_0
	end

	local var_26_2 = string.split(var_26_1, "|")

	for iter_26_0, iter_26_1 in ipairs(var_26_2) do
		local var_26_3 = string.split(iter_26_1, "#")

		if tonumber(var_26_3[1]) == 4 then
			local var_26_4 = tonumber(var_26_3[2]) / 1000
			local var_26_5 = arg_26_0:getherolevelCO(arg_26_1.heroId, 1)

			var_26_0.hp = var_26_0.hp + math.floor(var_26_5.hp * var_26_4)
			var_26_0.atk = var_26_0.atk + math.floor(var_26_5.atk * var_26_4)
			var_26_0.def = var_26_0.def + math.floor(var_26_5.def * var_26_4)
			var_26_0.mdef = var_26_0.mdef + math.floor(var_26_5.mdef * var_26_4)
			var_26_0.technic = var_26_0.technic + math.floor(var_26_5.technic * var_26_4)
		end
	end

	return var_26_0
end

function var_0_0.getcosumeCO(arg_27_0, arg_27_1, arg_27_2)
	return arg_27_0.cosumeConfig.configDict[arg_27_1][arg_27_2]
end

function var_0_0.getSkillEffectDescsCo(arg_28_0)
	return arg_28_0.skillEffectDescConfig.configDict
end

function var_0_0.getSkillEffectDescCo(arg_29_0, arg_29_1)
	return arg_29_0.skillEffectDescConfig.configDict[arg_29_1]
end

function var_0_0.getSkillEffectDescCoByName(arg_30_0, arg_30_1)
	local var_30_0 = LangSettings.instance:getCurLang() or -1

	if not arg_30_0.skillBuffDescConfigByName then
		arg_30_0.skillBuffDescConfigByName = {}
	end

	if not arg_30_0.skillBuffDescConfigByName[var_30_0] then
		local var_30_1 = {}

		for iter_30_0, iter_30_1 in ipairs(arg_30_0.skillEffectDescConfig.configList) do
			var_30_1[iter_30_1.name] = iter_30_1
		end

		arg_30_0.skillBuffDescConfigByName[var_30_0] = var_30_1
	end

	local var_30_2 = arg_30_0.skillBuffDescConfigByName[var_30_0][arg_30_1]

	if not var_30_2 then
		logError(string.format("技能概要 '%s' 不存在!!!", tostring(arg_30_1)))
	end

	return var_30_2
end

function var_0_0.processSkillDesKeyWords(arg_31_0, arg_31_1)
	return string.gsub(arg_31_1, "<id:(.-)>", "")
end

function var_0_0.getSkillBuffDescsCo(arg_32_0)
	return arg_32_0.skillBuffDescConfig.configDict
end

function var_0_0.getSkillBuffDescCo(arg_33_0, arg_33_1)
	return arg_33_0.skillBuffDescConfig.configDict[arg_33_1]
end

function var_0_0.isGetNewSkin(arg_34_0, arg_34_1, arg_34_2)
	local var_34_0 = arg_34_0:getherorankCO(arg_34_1, arg_34_2)

	if not var_34_0 then
		logError("获取角色升级信息失败， heroId : " .. tostring(arg_34_1) .. ", rank : " .. tostring(arg_34_2))

		return false
	end

	local var_34_1 = string.split(var_34_0.effect, "|")

	for iter_34_0 = 1, #var_34_1 do
		if string.splitToNumber(var_34_1[iter_34_0], "#")[1] == 3 then
			return true
		end
	end

	return false
end

function var_0_0.getBaseAttr(arg_35_0, arg_35_1, arg_35_2)
	local var_35_0 = {}
	local var_35_1 = arg_35_0:getherolevelCO(arg_35_1, arg_35_2)

	if not var_35_1 then
		local var_35_2 = arg_35_0:getherolevelsCO(arg_35_1)
		local var_35_3
		local var_35_4
		local var_35_5 = {}

		for iter_35_0, iter_35_1 in pairs(var_35_2) do
			table.insert(var_35_5, iter_35_1)
		end

		table.sort(var_35_5, function(arg_36_0, arg_36_1)
			return arg_36_0.level < arg_36_1.level
		end)

		for iter_35_2, iter_35_3 in ipairs(var_35_5) do
			if arg_35_2 > iter_35_3.level then
				var_35_3 = iter_35_3.level
				var_35_4 = var_35_5[iter_35_2 + 1].level
			end
		end

		local var_35_6 = arg_35_0:getherolevelCO(arg_35_1, var_35_3)
		local var_35_7 = arg_35_0:getherolevelCO(arg_35_1, var_35_4)

		var_35_0.hp = arg_35_0:_lerpAttr(var_35_6.hp, var_35_7.hp, var_35_3, var_35_4, arg_35_2)
		var_35_0.atk = arg_35_0:_lerpAttr(var_35_6.atk, var_35_7.atk, var_35_3, var_35_4, arg_35_2)
		var_35_0.def = arg_35_0:_lerpAttr(var_35_6.def, var_35_7.def, var_35_3, var_35_4, arg_35_2)
		var_35_0.mdef = arg_35_0:_lerpAttr(var_35_6.mdef, var_35_7.mdef, var_35_3, var_35_4, arg_35_2)
		var_35_0.technic = arg_35_0:_lerpAttr(var_35_6.technic, var_35_7.technic, var_35_3, var_35_4, arg_35_2)
		var_35_0.cri = arg_35_0:_lerpAttr(var_35_6.cri, var_35_7.cri, var_35_3, var_35_4, arg_35_2)
		var_35_0.recri = arg_35_0:_lerpAttr(var_35_6.recri, var_35_7.recri, var_35_3, var_35_4, arg_35_2)
		var_35_0.cri_dmg = arg_35_0:_lerpAttr(var_35_6.cri_dmg, var_35_7.cri_dmg, var_35_3, var_35_4, arg_35_2)
		var_35_0.cri_def = arg_35_0:_lerpAttr(var_35_6.cri_def, var_35_7.cri_def, var_35_3, var_35_4, arg_35_2)
		var_35_0.add_dmg = arg_35_0:_lerpAttr(var_35_6.add_dmg, var_35_7.add_dmg, var_35_3, var_35_4, arg_35_2)
		var_35_0.drop_dmg = arg_35_0:_lerpAttr(var_35_6.drop_dmg, var_35_7.drop_dmg, var_35_3, var_35_4, arg_35_2)
	else
		var_35_0.hp = var_35_1.hp
		var_35_0.atk = var_35_1.atk
		var_35_0.def = var_35_1.def
		var_35_0.mdef = var_35_1.mdef
		var_35_0.technic = var_35_1.technic
		var_35_0.cri = var_35_1.cri
		var_35_0.recri = var_35_1.recri
		var_35_0.cri_dmg = var_35_1.cri_dmg
		var_35_0.cri_def = var_35_1.cri_def
		var_35_0.add_dmg = var_35_1.add_dmg
		var_35_0.drop_dmg = var_35_1.drop_dmg
	end

	return var_35_0
end

function var_0_0._lerpAttr(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4, arg_37_5)
	return math.floor((arg_37_2 - arg_37_1) * (arg_37_5 - arg_37_3) / (arg_37_4 - arg_37_3)) + arg_37_1
end

function var_0_0.getTalentDamping(arg_38_0)
	if arg_38_0.talent_damping then
		return arg_38_0.talent_damping
	end

	arg_38_0.talent_damping = {}

	local var_38_0 = string.split(lua_fight_const.configDict[10][2], "|")

	for iter_38_0, iter_38_1 in ipairs(var_38_0) do
		local var_38_1 = string.splitToNumber(iter_38_1, "#")

		table.insert(arg_38_0.talent_damping, var_38_1)
	end

	return arg_38_0.talent_damping
end

function var_0_0.getExSkillDesc(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_1 == nil then
		return ""
	end

	local var_39_0 = arg_39_1.desc

	arg_39_2 = arg_39_2 or arg_39_1.heroId

	if LangSettings.instance:isEn() then
		var_39_0 = var_0_0.replaceHeroName(var_39_0, arg_39_2)
	end

	local var_39_1 = {}

	for iter_39_0, iter_39_1 in string.gmatch(var_39_0, "▩(%d)%%s<(%d)>") do
		local var_39_2 = arg_39_0:_matchChioceSkill(iter_39_0, iter_39_1, arg_39_2)

		if var_39_2 then
			table.insert(var_39_1, var_39_2)
		end
	end

	local var_39_3, var_39_4 = next(var_39_1)

	if var_39_4 then
		return var_39_0, var_39_4.skillName, var_39_4.skillIndex, var_39_1
	end

	local var_39_5, var_39_6, var_39_7 = string.find(var_39_0, "▩(%d)%%s")

	if not var_39_7 then
		logError("not fount skillIndex in desc : " .. var_39_0)

		return var_39_0
	end

	local var_39_8 = tonumber(var_39_7)
	local var_39_9

	if var_39_8 == 0 then
		var_39_9 = var_0_0.instance:getpassiveskillsCO(arg_39_2)[1].skillPassive
	else
		local var_39_10 = var_0_0.instance:getHeroBaseSkillIdDict(arg_39_2, true)

		var_39_9 = var_39_10 and var_39_10[var_39_8]
	end

	if not var_39_9 then
		logError("not fount skillId, skillIndex : " .. var_39_8)

		return var_39_0
	end

	return var_39_0, lua_skill.configDict[var_39_9].name, var_39_8
end

function var_0_0._getHeroWeaponReplaceSkill(arg_40_0, arg_40_1)
	local var_40_0 = HeroModel.instance:getByHeroId(arg_40_1)

	if var_40_0 and var_40_0.extraMo then
		local var_40_1 = var_40_0.extraMo:getWeaponMo()

		if var_40_1 then
			return var_40_1:getReplaceSkill()
		end
	end
end

function var_0_0._matchChioceSkill(arg_41_0, arg_41_1, arg_41_2, arg_41_3)
	if arg_41_2 and arg_41_1 then
		arg_41_1 = tonumber(arg_41_1)
		arg_41_2 = tonumber(arg_41_2)

		local var_41_0

		if arg_41_1 == 0 then
			var_41_0 = arg_41_0:getpassiveskillsCO(arg_41_3)[1].skillPassive
		else
			local var_41_1 = arg_41_0:getHeroBaseSkillIdDict(arg_41_3, true)

			var_41_0 = var_41_1 and var_41_1[arg_41_1]
		end

		local var_41_2 = arg_41_0:getFightCardChoiceSkillIdByIndex(var_41_0, arg_41_2)

		if var_41_2 then
			local var_41_3 = lua_skill.configDict[var_41_2].name

			return {
				skillId = var_41_0,
				skillName = var_41_3,
				skillIndex = arg_41_1,
				choiceSkillIndex = arg_41_2
			}
		end
	end
end

function var_0_0.getHeroBaseSkillIdDict(arg_42_0, arg_42_1, arg_42_2)
	local var_42_0, var_42_1, var_42_2 = arg_42_0:_getHeroSkillAndExSkill(arg_42_1, arg_42_2)

	return arg_42_0:getHeroBaseSkillIdDictByStr(var_42_0, var_42_1), var_42_2
end

function var_0_0._getHeroSkillAndExSkill(arg_43_0, arg_43_1, arg_43_2)
	local var_43_0 = HeroConfig.instance:getHeroCO(arg_43_1)
	local var_43_1 = var_43_0.skill
	local var_43_2 = var_43_0.exSkill

	if arg_43_2 then
		local var_43_3 = HeroConfig.instance:getHeroRankReplaceConfig(arg_43_1)

		if var_43_3 then
			var_43_1 = var_43_3.skill
			var_43_2 = var_43_3.exSkill

			return var_43_1, var_43_2
		end
	end

	local var_43_4, var_43_5 = arg_43_0:_getHeroWeaponReplaceSkill(arg_43_1)

	if var_43_4 or var_43_5 then
		var_43_1 = var_43_4 or var_43_1
		var_43_2 = var_43_5 or var_43_2

		return var_43_1, var_43_2, true
	end

	return var_43_1, var_43_2
end

function var_0_0.getHeroBaseSkillIdDictByStr(arg_44_0, arg_44_1, arg_44_2)
	local var_44_0 = {}
	local var_44_1 = string.split(arg_44_1, "|")
	local var_44_2
	local var_44_3
	local var_44_4

	for iter_44_0 = 1, #var_44_1 do
		local var_44_5 = string.split(var_44_1[iter_44_0], ",")
		local var_44_6 = string.splitToNumber(var_44_5[1], "#")

		var_44_0[var_44_6[1]] = var_44_6[2]
	end

	var_44_0[3] = arg_44_2

	return var_44_0
end

function var_0_0.getHeroAllSkillIdDict(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0, var_45_1, var_45_2 = arg_45_0:_getHeroSkillAndExSkill(arg_45_1, arg_45_2)

	return arg_45_0:getHeroAllSkillIdDictByStr(var_45_0, var_45_1), var_45_2
end

function var_0_0.getHeroAllSkillIdDictByStr(arg_46_0, arg_46_1, arg_46_2)
	local var_46_0 = {}
	local var_46_1 = string.split(arg_46_1, "|")
	local var_46_2
	local var_46_3

	for iter_46_0 = 1, #var_46_1 do
		local var_46_4 = string.split(var_46_1[iter_46_0], ",")
		local var_46_5 = string.splitToNumber(var_46_4[1], "#")

		var_46_0[table.remove(var_46_5, 1)] = var_46_5
	end

	var_46_0[3] = {
		arg_46_2
	}

	return var_46_0
end

function var_0_0._isNeedReplaceExSkill(arg_47_0, arg_47_1)
	if arg_47_1 and lua_character_rank_replace.configDict[arg_47_1.heroId] then
		local var_47_0 = arg_47_1.rank or 0
		local var_47_1 = lua_character_limited.configDict[arg_47_1.skin]
		local var_47_2 = string.split(var_47_1.specialLive2d, "#")

		return var_47_0 > (var_47_2[2] and tonumber(var_47_2[2]) or 3) - 1
	end

	return true
end

function var_0_0.getHeroBaseSkillIdDictByExSkillLevel(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	if arg_48_3 and arg_48_3.trialAttrCo then
		local var_48_0 = arg_48_0:getHeroBaseSkillIdDictByStr(arg_48_3.trialAttrCo.activeSkill, arg_48_3.trialAttrCo.uniqueSkill)

		return (arg_48_0:_checkReplaceSkill(var_48_0, arg_48_3))
	end

	local var_48_1 = arg_48_3 and arg_48_3.rank > CharacterModel.instance:getReplaceSkillRank(arg_48_3) - 1
	local var_48_2 = arg_48_0:getHeroBaseSkillIdDict(arg_48_1, var_48_1)

	arg_48_3 = arg_48_3 or HeroModel.instance:getByHeroId(arg_48_1)

	if arg_48_0:_isNeedReplaceExSkill(arg_48_3) then
		var_48_2 = arg_48_0:getHeroExBaseSkillIdDict(arg_48_1, arg_48_3, var_48_2, arg_48_2)
	end

	return (arg_48_0:_checkDestinyEffect(var_48_2, arg_48_3))
end

function var_0_0.getHeroExBaseSkillIdDict(arg_49_0, arg_49_1, arg_49_2, arg_49_3, arg_49_4)
	arg_49_4 = arg_49_4 or CharacterEnum.showAttributeOption.ShowCurrent

	local var_49_0 = 0

	if arg_49_4 == CharacterEnum.showAttributeOption.ShowMax then
		var_49_0 = CharacterModel.instance:getMaxexskill(arg_49_1)
	else
		var_49_0 = arg_49_4 == CharacterEnum.showAttributeOption.ShowMin and 0 or arg_49_2.exSkillLevel
	end

	if var_49_0 < 1 then
		arg_49_3 = arg_49_0:_checkReplaceSkill(arg_49_3, arg_49_2)

		return arg_49_3
	end

	local var_49_1 = math.min(var_49_0, CharacterEnum.MaxSkillExLevel)
	local var_49_2

	for iter_49_0 = 1, var_49_1 do
		local var_49_3 = arg_49_0:getherolevelexskillCO(arg_49_1, iter_49_0)

		if not string.nilorempty(var_49_3.skillGroup1) then
			arg_49_3[1] = string.splitToNumber(var_49_3.skillGroup1, "|")[1]
		end

		if not string.nilorempty(var_49_3.skillGroup2) then
			arg_49_3[2] = string.splitToNumber(var_49_3.skillGroup2, "|")[1]
		end

		if var_49_3.skillEx ~= 0 then
			arg_49_3[3] = var_49_3.skillEx
		end
	end

	arg_49_3 = arg_49_0:_checkReplaceSkill(arg_49_3, arg_49_2)

	return arg_49_3
end

function var_0_0._checkReplaceSkill(arg_50_0, arg_50_1, arg_50_2)
	if arg_50_1 and arg_50_2 then
		arg_50_1 = arg_50_2:checkReplaceSkill(arg_50_1)
	end

	return arg_50_1
end

function var_0_0._checkDestinyEffect(arg_51_0, arg_51_1, arg_51_2)
	if arg_51_1 and arg_51_2 and arg_51_2.destinyStoneMo then
		arg_51_1 = arg_51_2.destinyStoneMo:_replaceSkill(arg_51_1)
	end

	return arg_51_1
end

function var_0_0.getHeroAllSkillIdDictByExSkillLevel(arg_52_0, arg_52_1, arg_52_2, arg_52_3, arg_52_4, arg_52_5)
	if arg_52_3 and arg_52_3.trialAttrCo then
		return arg_52_0:getHeroAllSkillIdDictByStr(arg_52_3.trialAttrCo.activeSkill, arg_52_3.trialAttrCo.uniqueSkill)
	end

	local var_52_0 = arg_52_5 or arg_52_3 and arg_52_3.rank > CharacterModel.instance:getReplaceSkillRank(arg_52_3) - 1
	local var_52_1, var_52_2 = arg_52_0:getHeroAllSkillIdDict(arg_52_1, var_52_0)

	if var_52_2 then
		return var_52_1
	end

	arg_52_3 = arg_52_3 or HeroModel.instance:getByHeroId(arg_52_1)

	if not arg_52_0:_isNeedReplaceExSkill(arg_52_3) then
		return var_52_1
	end

	arg_52_2 = arg_52_2 or CharacterEnum.showAttributeOption.ShowCurrent

	local var_52_3 = 0

	if arg_52_2 == CharacterEnum.showAttributeOption.ShowMax then
		var_52_3 = CharacterModel.instance:getMaxexskill(arg_52_1)
	elseif arg_52_2 == CharacterEnum.showAttributeOption.ShowMin then
		var_52_3 = 0
	elseif arg_52_4 then
		var_52_3 = arg_52_4
	elseif arg_52_3 then
		var_52_3 = arg_52_3.exSkillLevel
	end

	if var_52_3 < 1 then
		return var_52_1
	end

	local var_52_4

	for iter_52_0 = 1, var_52_3 do
		local var_52_5 = arg_52_0:getherolevelexskillCO(arg_52_1, iter_52_0)

		if not string.nilorempty(var_52_5.skillGroup1) then
			var_52_1[1] = string.splitToNumber(var_52_5.skillGroup1, "|")
		end

		if not string.nilorempty(var_52_5.skillGroup2) then
			var_52_1[2] = string.splitToNumber(var_52_5.skillGroup2, "|")
		end

		if var_52_5.skillEx ~= 0 then
			var_52_1[3] = {
				var_52_5.skillEx
			}
		end
	end

	return (arg_52_0:_checkReplaceSkill(var_52_1, arg_52_3))
end

function var_0_0.getRankLevelByLevel(arg_53_0, arg_53_1, arg_53_2)
	local var_53_0 = arg_53_0.rankConfig.configDict[arg_53_1]

	if not var_53_0 then
		return 0
	end

	local var_53_1 = {}

	for iter_53_0, iter_53_1 in pairs(var_53_0) do
		table.insert(var_53_1, iter_53_1)
	end

	table.sort(var_53_1, function(arg_54_0, arg_54_1)
		return arg_54_0.rank < arg_54_1.rank
	end)

	local var_53_2 = 1

	for iter_53_2, iter_53_3 in ipairs(var_53_1) do
		local var_53_3 = 0

		for iter_53_4, iter_53_5 in pairs(GameUtil.splitString2(iter_53_3.effect, true, "|", "#")) do
			if iter_53_5[1] == 1 then
				var_53_3 = iter_53_5[2]

				break
			end
		end

		if arg_53_2 <= var_53_3 then
			return iter_53_3.rank
		end
	end

	return var_53_2
end

function var_0_0.getConstNum(arg_55_0, arg_55_1)
	local var_55_0 = arg_55_0:getConstStr(arg_55_1)

	if string.nilorempty(var_55_0) then
		return 0
	else
		return tonumber(var_55_0)
	end
end

function var_0_0.getConstStr(arg_56_0, arg_56_1)
	local var_56_0 = lua_fight_const.configDict[arg_56_1]

	if not var_56_0 then
		printError("fight const not exist: ", arg_56_1)

		return nil
	end

	local var_56_1 = var_56_0.value

	if not string.nilorempty(var_56_1) then
		return var_56_1
	end

	return var_56_0.value2
end

function var_0_0.getHeroUpgradeSkill(arg_57_0, arg_57_1)
	if not arg_57_1 then
		return false, {}
	end

	local var_57_0 = {}

	for iter_57_0, iter_57_1 in ipairs(arg_57_1) do
		local var_57_1 = arg_57_0.heroUpgradeBreakLevelConfig.configDict[iter_57_1]

		if var_57_1 then
			var_57_0[#var_57_0 + 1] = var_57_1.upgradeSkillId
		end
	end

	return #var_57_0 > 0, var_57_0
end

function var_0_0.getFightCardChoice(arg_58_0, arg_58_1)
	if not arg_58_1 then
		return
	end

	local var_58_0 = {}

	for iter_58_0, iter_58_1 in ipairs(arg_58_1) do
		local var_58_1 = lua_fight_card_choice.configDict[iter_58_1]

		if not var_58_1 then
			return
		end

		local var_58_2 = string.splitToNumber(var_58_1.choiceSkIlls, "#")

		for iter_58_2, iter_58_3 in ipairs(var_58_2) do
			if not var_58_0[iter_58_2] then
				var_58_0[iter_58_2] = {}
			end

			table.insert(var_58_0[iter_58_2], iter_58_3)
		end
	end

	return var_58_0
end

function var_0_0.getFightCardChoiceSkillIdByIndex(arg_59_0, arg_59_1, arg_59_2)
	local var_59_0 = lua_fight_card_choice.configDict[arg_59_1]

	if var_59_0 then
		return string.splitToNumber(var_59_0.choiceSkIlls, "#")[arg_59_2]
	end
end

function var_0_0.getFightCardFootnoteConfig(arg_60_0, arg_60_1)
	return arg_60_0.fightCardFootnoteConfig.configDict[arg_60_1]
end

var_0_0.instance = var_0_0.New()

return var_0_0
