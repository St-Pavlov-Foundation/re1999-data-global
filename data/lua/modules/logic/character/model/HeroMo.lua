module("modules.logic.character.model.HeroMo", package.seeall)

local var_0_0 = pureTable("HeroMo")

function var_0_0.ctor(arg_1_0)
	arg_1_0.id = 0
	arg_1_0.uid = 0
	arg_1_0.userId = 0
	arg_1_0.heroId = 0
	arg_1_0.heroName = ""
	arg_1_0.createTime = 0
	arg_1_0.level = 0
	arg_1_0.exp = 0
	arg_1_0.rank = 0
	arg_1_0.breakThrough = 0
	arg_1_0.skin = 0
	arg_1_0.faith = 0
	arg_1_0.activeSkillLevel = 0
	arg_1_0.passiveSkillLevel = 0
	arg_1_0.exSkillLevel = 0
	arg_1_0.voice = nil
	arg_1_0.voiceHeard = nil
	arg_1_0.skinInfoList = nil
	arg_1_0.baseAttr = nil
	arg_1_0.equipAttrList = nil
	arg_1_0.isNew = false
	arg_1_0.itemUnlock = nil
	arg_1_0.talent = 0
	arg_1_0.config = nil
	arg_1_0.talentCubeInfos = nil
	arg_1_0.defaultEquipUid = 0
	arg_1_0.birthdayCount = 0
	arg_1_0.talentStyleUnlock = nil
	arg_1_0.isFavor = false
	arg_1_0.destinyStoneMo = nil
	arg_1_0.trialCo = nil
	arg_1_0.trialAttrCo = nil
	arg_1_0.trialEquipMo = nil
	arg_1_0.isPosLock = false
	arg_1_0.duplicateCount = 0
	arg_1_0.belongOtherPlayer = false
	arg_1_0.otherPlayerEquipMo = nil
	arg_1_0.extraStr = nil
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0:update(arg_2_1)

	arg_2_0.config = arg_2_2
end

function var_0_0.isTrial(arg_3_0)
	return not not arg_3_0.trialCo
end

function var_0_0.setIsBelongOtherPlayer(arg_4_0, arg_4_1)
	arg_4_0.belongOtherPlayer = arg_4_1 and true or false
end

function var_0_0.isOtherPlayerHero(arg_5_0)
	return arg_5_0.belongOtherPlayer
end

function var_0_0.setOtherPlayerEquipMo(arg_6_0, arg_6_1)
	arg_6_0.otherPlayerEquipMo = arg_6_1
end

function var_0_0.getOtherPlayerEquipMo(arg_7_0)
	return arg_7_0.otherPlayerEquipMo
end

function var_0_0.setOtherPlayerIsOpenTalent(arg_8_0, arg_8_1)
	arg_8_0.otherPlayerIsOpenTalent = arg_8_1
end

function var_0_0.getOtherPlayerIsOpenTalent(arg_9_0)
	return arg_9_0.otherPlayerIsOpenTalent
end

function var_0_0.getOtherPlayerTalentStyle(arg_10_0)
	return arg_10_0.style
end

function var_0_0.setOtherPlayerTalentStyle(arg_11_0, arg_11_1)
	arg_11_0.style = arg_11_1
end

function var_0_0.getTrialEquipMo(arg_12_0)
	local var_12_0

	if arg_12_0:isTrial() then
		var_12_0 = arg_12_0.trialEquipMo
	end

	return var_12_0
end

function var_0_0.isOwnHero(arg_13_0)
	local var_13_0 = arg_13_0:isTrial()
	local var_13_1 = arg_13_0:isOtherPlayerHero()

	return not var_13_0 and not var_13_1
end

function var_0_0.fakeTrial(arg_14_0, arg_14_1)
	arg_14_0.trialEquipMo = arg_14_1
	arg_14_0.trialCo = true
end

function var_0_0.getHeroName(arg_15_0)
	if arg_15_0.trialAttrCo then
		return arg_15_0.trialAttrCo.name
	end

	return arg_15_0.config.name
end

function var_0_0.getpassiveskillsCO(arg_16_0)
	if arg_16_0.trialAttrCo then
		local var_16_0 = {}
		local var_16_1 = string.splitToNumber(arg_16_0.trialAttrCo.passiveSkill, "|")

		for iter_16_0, iter_16_1 in ipairs(var_16_1) do
			table.insert(var_16_0, {
				uiFilterSkill = "",
				heroId = arg_16_0.heroId,
				skillLevel = iter_16_0,
				skillPassive = iter_16_1,
				skillGroup = iter_16_0
			})
		end

		return var_16_0
	end

	return SkillConfig.instance:getpassiveskillsCO(arg_16_0.heroId)
end

function var_0_0.isNoShowExSkill(arg_17_0)
	if arg_17_0.trialAttrCo then
		return arg_17_0.trialAttrCo.noShowExSkill == 1
	end

	return false
end

function var_0_0.initFromTrial(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_2 = arg_18_2 or 0
	arg_18_0.isPosLock = arg_18_3 ~= nil

	local var_18_0 = lua_hero_trial.configDict[arg_18_1][arg_18_2]

	arg_18_0.trialCo = var_18_0

	if var_18_0.attrId > 0 then
		arg_18_0.trialAttrCo = lua_hero_trial_attr.configDict[var_18_0.attrId]
	end

	local var_18_1 = HeroConfig.instance:getHeroCO(var_18_0.heroId)
	local var_18_2 = HeroDef_pb.HeroInfo()

	var_18_2.uid = tostring(tonumber(var_18_0.id .. "." .. var_18_0.trialTemplate) - 1099511627776)
	var_18_2.level = var_18_0.level
	var_18_2.heroId = var_18_0.heroId
	var_18_2.defaultEquipUid = tostring(-var_18_0.equipId)

	local var_18_3, var_18_4 = SkillConfig.instance:getHeroExSkillLevelByLevel(var_18_0.heroId, var_18_0.level)

	var_18_2.rank = var_18_4

	local var_18_5 = 1

	for iter_18_0 = var_18_0.talent, 1, -1 do
		local var_18_6 = lua_character_talent.configDict[var_18_2.heroId][iter_18_0]

		if var_18_6 and var_18_6.requirement <= var_18_2.rank then
			var_18_5 = iter_18_0

			break
		end
	end

	var_18_2.talent = var_18_5
	var_18_2.exSkillLevel = var_18_0.exSkillLv

	for iter_18_1 = 1, var_18_3 do
		table.insert(var_18_2.passiveSkillLevel, iter_18_1)
	end

	if var_18_0.skin > 0 then
		var_18_2.skin = var_18_0.skin
	else
		var_18_2.skin = var_18_1.skinId
	end

	local var_18_7 = SkillConfig.instance:getBaseAttr(var_18_0.heroId, var_18_0.level)

	var_18_2.baseAttr.attack = var_18_7.atk
	var_18_2.baseAttr.defense = var_18_7.def
	var_18_2.baseAttr.hp = var_18_7.hp
	var_18_2.baseAttr.mdefense = var_18_7.mdef
	var_18_2.baseAttr.technic = var_18_7.technic
	var_18_2.exAttr.addDmg = var_18_7.add_dmg
	var_18_2.exAttr.cri = var_18_7.cri
	var_18_2.exAttr.criDef = var_18_7.cri_def
	var_18_2.exAttr.dropDmg = var_18_7.drop_dmg
	var_18_2.exAttr.recri = var_18_7.recri
	var_18_2.exAttr.criDmg = var_18_7.cri_dmg

	if arg_18_0.trialAttrCo then
		var_18_2.baseAttr.hp = var_18_2.baseAttr.hp + arg_18_0.trialAttrCo.life
		var_18_2.baseAttr.attack = var_18_2.baseAttr.attack + arg_18_0.trialAttrCo.attack
		var_18_2.baseAttr.defense = var_18_2.baseAttr.defense + arg_18_0.trialAttrCo.defense
		var_18_2.baseAttr.mdefense = var_18_2.baseAttr.mdefense + arg_18_0.trialAttrCo.mdefense
		var_18_2.baseAttr.technic = var_18_2.baseAttr.technic + arg_18_0.trialAttrCo.technic
		var_18_2.exAttr.cri = var_18_2.exAttr.cri + arg_18_0.trialAttrCo.cri
		var_18_2.exAttr.recri = var_18_2.exAttr.recri + arg_18_0.trialAttrCo.recri
		var_18_2.exAttr.dropDmg = var_18_2.exAttr.dropDmg + arg_18_0.trialAttrCo.dropDmg
		var_18_2.exAttr.criDef = var_18_2.exAttr.criDef + arg_18_0.trialAttrCo.criDef
		var_18_2.exAttr.addDmg = var_18_2.exAttr.addDmg + arg_18_0.trialAttrCo.addDmg
		var_18_2.exAttr.dropDmg = var_18_2.exAttr.dropDmg + arg_18_0.trialAttrCo.dropDmg
	end

	if var_18_0.equipId > 0 then
		local var_18_8 = EquipMO.New()

		var_18_8:initByTrialCO(var_18_0)

		arg_18_0.trialEquipMo = var_18_8
	end

	if var_18_2.rank >= CharacterEnum.TalentRank and var_18_2.talent > 0 then
		local var_18_9 = lua_character_talent.configDict[var_18_2.heroId][var_18_2.talent]
		local var_18_10 = var_18_9.talentMould
		local var_18_11 = string.splitToNumber(var_18_9.exclusive, "#")[1]
		local var_18_12 = lua_talent_scheme.configDict[var_18_2.talent][var_18_10][var_18_11].talenScheme
		local var_18_13 = GameUtil.splitString2(var_18_12, true, "#", ",")
		local var_18_14 = HeroDef_pb.TalentTemplateInfo()

		var_18_14.id = 1

		for iter_18_2, iter_18_3 in ipairs(var_18_13) do
			local var_18_15 = HeroDef_pb.TalentCubeInfo()

			var_18_15.cubeId = iter_18_3[1]
			var_18_15.direction = iter_18_3[2] or 0
			var_18_15.posX = iter_18_3[3] or 0
			var_18_15.posY = iter_18_3[4] or 0

			table.insert(var_18_14.talentCubeInfos, var_18_15)
		end

		table.insert(var_18_2.talentTemplates, var_18_14)
	end

	arg_18_0:init(var_18_2, var_18_1)

	arg_18_0.destinyStoneMo = arg_18_0.destinyStoneMo or HeroDestinyStoneMO.New(arg_18_0.heroId)

	arg_18_0.destinyStoneMo:refreshMo(var_18_0.facetslevel, 1, var_18_0.facetsId)
	arg_18_0.destinyStoneMo:setTrial()

	arg_18_0.extraMo = arg_18_0.extraMo or CharacterExtraMO.New(arg_18_0)

	arg_18_0.extraMo:refreshMo(var_18_0.special)
end

function var_0_0.initFromConfig(arg_19_0, arg_19_1)
	arg_19_0.heroId = arg_19_1.id
	arg_19_0.heroName = arg_19_1.name
	arg_19_0.level = 1
	arg_19_0.exp = 0
	arg_19_0.rank = 0
	arg_19_0.breakthrough = 0
	arg_19_0.skin = arg_19_1.skinId
	arg_19_0.config = arg_19_1
end

function var_0_0.update(arg_20_0, arg_20_1)
	arg_20_0.heroId = arg_20_1.heroId
	arg_20_0.skin = arg_20_1.skin

	if not arg_20_1.uid then
		return
	end

	arg_20_0.id = arg_20_1.uid
	arg_20_0.uid = arg_20_1.uid
	arg_20_0.userId = arg_20_1.userId
	arg_20_0.heroName = arg_20_1.heroName
	arg_20_0.createTime = arg_20_1.createTime
	arg_20_0.level = arg_20_1.level
	arg_20_0.exp = arg_20_1.exp
	arg_20_0.rank = arg_20_1.rank
	arg_20_0.breakthrough = arg_20_1.breakthrough
	arg_20_0.faith = arg_20_1.faith
	arg_20_0.activeSkillLevel = arg_20_1.activeSkillLevel
	arg_20_0.passiveSkillLevel = arg_20_1.passiveSkillLevel
	arg_20_0.exSkillLevel = arg_20_1.exSkillLevel
	arg_20_0.voice = arg_20_0:_getListInfo(arg_20_1.voice)
	arg_20_0.voiceHeard = arg_20_0:_getListInfo(arg_20_1.voiceHeard)
	arg_20_0.skinInfoList = arg_20_0:_getListInfo(arg_20_1.skinInfoList, SkinInfoMO)
	arg_20_0.baseAttr = arg_20_0:_getAttrlist(arg_20_1.baseAttr, HeroAttributeMO)
	arg_20_0.exAttr = arg_20_0:_getAttrlist(arg_20_1.exAttr, HeroExAttributeMO)
	arg_20_0.spAttr = arg_20_0:_getAttrlist(arg_20_1.spAttr, HeroSpecialAttributeMO)
	arg_20_0.equipAttrList = arg_20_0:_getListInfo(arg_20_1.equipAttrList, HeroEquipAttributeMO)
	arg_20_0.itemUnlock = arg_20_0:_getListInfo(arg_20_1.itemUnlock)
	arg_20_0.isNew = arg_20_1.isNew
	arg_20_0.talent = arg_20_1.talent
	arg_20_0.defaultEquipUid = arg_20_1.defaultEquipUid
	arg_20_0.birthdayCount = arg_20_1.birthdayCount
	arg_20_0.duplicateCount = arg_20_1.duplicateCount
	arg_20_0.talentTemplates = arg_20_1.talentTemplates
	arg_20_0.useTalentTemplateId = arg_20_1.useTalentTemplateId == 0 and 1 or arg_20_1.useTalentTemplateId
	arg_20_0.talentCubeInfos = arg_20_0:setTalentCubeInfos(arg_20_0.talentTemplates)
	arg_20_0.talentStyleUnlock = arg_20_1.talentStyleUnlock
	arg_20_0.isShowTalentStyleRed = arg_20_1.talentStyleRed == 1
	arg_20_0.isFavor = arg_20_1.isFavor
	arg_20_0.destinyStoneMo = arg_20_0.destinyStoneMo or HeroDestinyStoneMO.New(arg_20_0.heroId)

	arg_20_0.destinyStoneMo:refreshMo(arg_20_1.destinyRank, arg_20_1.destinyLevel, arg_20_1.destinyStone, arg_20_1.destinyStoneUnlock)
	arg_20_0.destinyStoneMo:setRedDot(arg_20_1.redDot)
	arg_20_0:setIsBelongOtherPlayer(arg_20_1.belongOtherPlayer)

	arg_20_0.extraMo = arg_20_0.extraMo or CharacterExtraMO.New(arg_20_0)

	arg_20_0.extraMo:refreshMo(arg_20_1.extraStr)
end

function var_0_0._getListInfo(arg_21_0, arg_21_1, arg_21_2)
	local var_21_0 = {}
	local var_21_1 = arg_21_1 and #arg_21_1 or 0

	for iter_21_0 = 1, var_21_1 do
		local var_21_2 = arg_21_1[iter_21_0]

		if arg_21_2 then
			var_21_2 = arg_21_2.New()

			var_21_2:init(arg_21_1[iter_21_0])
		end

		table.insert(var_21_0, var_21_2)
	end

	return var_21_0
end

function var_0_0._getAttrlist(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = {}

	if arg_22_2 then
		arg_22_2.New():init(arg_22_1)
	end

	return arg_22_1
end

function var_0_0.levelUp(arg_23_0, arg_23_1)
	arg_23_0.level = arg_23_1.level
	arg_23_0.heroId = arg_23_1.heroId
end

function var_0_0.rankUp(arg_24_0, arg_24_1)
	arg_24_0.rank = arg_24_1.rank
	arg_24_0.heroId = arg_24_1.heroId
end

function var_0_0.talentUp(arg_25_0, arg_25_1)
	arg_25_0.talent = arg_25_1.talent
	arg_25_0.heroId = arg_25_1.heroId

	arg_25_0.talentCubeInfos:setOwnData(arg_25_0.heroId, arg_25_0.talent)
end

function var_0_0.addVoice(arg_26_0, arg_26_1, arg_26_2)
	if arg_26_1 == arg_26_0.heroId then
		table.insert(arg_26_0.voice, arg_26_2)
	end
end

function var_0_0.setItemUnlock(arg_27_0, arg_27_1)
	if arg_27_1.heroId == arg_27_0.heroId then
		table.insert(arg_27_0.itemUnlock, arg_27_1.itemId)
	end
end

function var_0_0.setTalentCubeInfos(arg_28_0, arg_28_1)
	local var_28_0

	for iter_28_0, iter_28_1 in ipairs(arg_28_1) do
		if iter_28_1.id == arg_28_0.useTalentTemplateId then
			var_28_0 = iter_28_1.talentCubeInfos

			break
		end
	end

	arg_28_0.talentCubeInfos = arg_28_0.talentCubeInfos or HeroTalentCubeInfosMO.New()

	arg_28_0.talentCubeInfos:init(var_28_0 or {})
	arg_28_0.talentCubeInfos:setOwnData(arg_28_0.heroId, arg_28_0.talent)

	return arg_28_0.talentCubeInfos
end

function var_0_0.getTalentGain(arg_29_0, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
	local var_29_0 = {}

	if arg_29_0:isOtherPlayerHero() and not arg_29_0:getOtherPlayerIsOpenTalent() then
		return var_29_0
	end

	arg_29_4 = arg_29_4 or arg_29_0.talentCubeInfos

	if not arg_29_4 then
		logError("英雄数据找不到共鸣数据")
	end

	local var_29_1 = arg_29_4.data_list
	local var_29_2 = {}

	for iter_29_0, iter_29_1 in ipairs(var_29_1) do
		if not var_29_2[iter_29_1.cubeId] then
			var_29_2[iter_29_1.cubeId] = {}
		end

		table.insert(var_29_2[iter_29_1.cubeId], iter_29_1)
	end

	local var_29_3 = SkillConfig.instance:getTalentDamping()

	for iter_29_2, iter_29_3 in pairs(var_29_2) do
		local var_29_4 = #iter_29_3 >= var_29_3[1][1] and (#iter_29_3 >= var_29_3[2][1] and var_29_3[2][2] or var_29_3[1][2]) or nil
		local var_29_5 = {}

		for iter_29_4, iter_29_5 in ipairs(iter_29_3) do
			arg_29_0:getTalentStyleCubeAttr(iter_29_5.cubeId, var_29_5, arg_29_1, arg_29_2, arg_29_3, arg_29_4)
		end

		for iter_29_6, iter_29_7 in pairs(var_29_5) do
			if var_29_4 then
				var_29_5[iter_29_6] = iter_29_7 * (var_29_4 / 1000)
			end

			if var_29_5[iter_29_6] > 0 then
				if not var_29_0[iter_29_6] then
					var_29_0[iter_29_6] = {}
				end

				var_29_0[iter_29_6].key = iter_29_6
				var_29_0[iter_29_6].value = (var_29_0[iter_29_6].value or 0) + var_29_5[iter_29_6]
			end
		end
	end

	return var_29_0
end

function var_0_0.getTalentStyleCubeAttr(arg_30_0, arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5, arg_30_6)
	if arg_30_1 == arg_30_0.talentCubeInfos.own_main_cube_id then
		arg_30_1 = arg_30_0:getHeroUseStyleCubeId()
	end

	arg_30_0:getTalentAttrGainSingle(arg_30_1, arg_30_2, arg_30_3, arg_30_4, arg_30_5, arg_30_6)
end

function var_0_0.getTalentAttrGainSingle(arg_31_0, arg_31_1, arg_31_2, arg_31_3, arg_31_4, arg_31_5, arg_31_6)
	local var_31_0 = arg_31_5 and HeroConfig.instance:getTalentCubeAttrConfig(arg_31_1, arg_31_5) or arg_31_0:getCurTalentLevelConfig(arg_31_1, arg_31_6)
	local var_31_1 = var_31_0.calculateType == 1 and CharacterModel.instance:getMaxLevel(arg_31_0.heroId) or arg_31_3 or arg_31_0.level
	local var_31_2 = SkillConfig.instance:getBaseAttr(arg_31_0.heroId, var_31_1)
	local var_31_3 = SkillConfig.instance:getHeroRankAttribute(arg_31_0.heroId, var_31_0.calculateType == 1 and CharacterModel.instance:getMaxRank(arg_31_0.heroId) or arg_31_4 or arg_31_0.rank)

	arg_31_2.hp = (arg_31_2.hp or 0) + (var_31_3.hp + var_31_2.hp) * var_31_0.hp / 1000
	arg_31_2.atk = (arg_31_2.atk or 0) + (var_31_3.atk + var_31_2.atk) * var_31_0.atk / 1000
	arg_31_2.def = (arg_31_2.def or 0) + (var_31_3.def + var_31_2.def) * var_31_0.def / 1000
	arg_31_2.mdef = (arg_31_2.mdef or 0) + (var_31_3.mdef + var_31_2.mdef) * var_31_0.mdef / 1000
	arg_31_2.cri = (arg_31_2.cri or 0) + var_31_0.cri
	arg_31_2.recri = (arg_31_2.recri or 0) + var_31_0.recri
	arg_31_2.cri_dmg = (arg_31_2.cri_dmg or 0) + var_31_0.cri_dmg
	arg_31_2.cri_def = (arg_31_2.cri_def or 0) + var_31_0.cri_def
	arg_31_2.add_dmg = (arg_31_2.add_dmg or 0) + var_31_0.add_dmg
	arg_31_2.drop_dmg = (arg_31_2.drop_dmg or 0) + var_31_0.drop_dmg
	arg_31_2.revive = (arg_31_2.revive or 0) + var_31_0.revive
	arg_31_2.absorb = (arg_31_2.absorb or 0) + var_31_0.absorb
	arg_31_2.clutch = (arg_31_2.clutch or 0) + var_31_0.clutch
	arg_31_2.heal = (arg_31_2.heal or 0) + var_31_0.heal
	arg_31_2.defenseIgnore = (arg_31_2.defenseIgnore or 0) + var_31_0.defenseIgnore
	arg_31_2.normalSkillRate = (arg_31_2.normalSkillRate or 0) + var_31_0.normalSkillRate

	for iter_31_0, iter_31_1 in pairs(arg_31_2) do
		if arg_31_2[iter_31_0] == 0 then
			arg_31_2[iter_31_0] = nil
		elseif var_31_0.calculateType == 1 then
			arg_31_2[iter_31_0] = math.floor(arg_31_2[iter_31_0])
		end
	end
end

function var_0_0.getCurTalentLevelConfig(arg_32_0, arg_32_1, arg_32_2)
	arg_32_2 = arg_32_2 or arg_32_0.talentCubeInfos

	local var_32_0 = arg_32_2.own_cube_dic[arg_32_1] or arg_32_2:getMainCubeMo()

	return HeroConfig.instance:getTalentCubeAttrConfig(arg_32_1, var_32_0.level)
end

function var_0_0.clearCubeData(arg_33_0)
	arg_33_0.talentCubeInfos:clearData()
	arg_33_0.talentCubeInfos:setOwnData(arg_33_0.heroId, arg_33_0.talent)
end

function var_0_0.getAttrValueWithoutTalentByID(arg_34_0, arg_34_1)
	local var_34_0 = HeroConfig.instance:talentGainTab2IDTab(arg_34_0:getTalentGain())
	local var_34_1 = HeroConfig.instance:getHeroAttributeCO(arg_34_1)

	if var_34_1.type == 1 then
		return arg_34_0.baseAttr[var_34_1.attrType] - (var_34_0[var_34_1.id] and math.floor(var_34_0[var_34_1.id].value) or 0)
	elseif var_34_1.type == 2 then
		return arg_34_0.exAttr[var_34_1.attrType] - (var_34_0[var_34_1.id] and math.floor(var_34_0[var_34_1.id].value) or 0)
	elseif var_34_1.type == 3 then
		return arg_34_0.spAttr[var_34_1.attrType] - (var_34_0[var_34_1.id] and math.floor(var_34_0[var_34_1.id].value) or 0)
	end
end

function var_0_0.getAttrValueWithoutTalentByAttrType(arg_35_0, arg_35_1)
	return arg_35_0:getAttrValueWithoutTalentByID(HeroConfig.instance:getIDByAttrType(arg_35_1))
end

function var_0_0.hasDefaultEquip(arg_36_0)
	if arg_36_0:isTrial() and arg_36_0.defaultEquipUid ~= "0" then
		return arg_36_0.trialEquipMo
	end

	if arg_36_0:isOtherPlayerHero() then
		return arg_36_0:getOtherPlayerEquipMo()
	end

	return arg_36_0.defaultEquipUid ~= "0" and EquipModel.instance:getEquip(arg_36_0.defaultEquipUid)
end

function var_0_0.getHeroLevelConfig(arg_37_0, arg_37_1)
	arg_37_1 = arg_37_1 or arg_37_0.level

	local var_37_0 = SkillConfig.instance:getherolevelCO(arg_37_0.heroId, arg_37_1)

	if not var_37_0 then
		local var_37_1 = SkillConfig.instance:getherolevelsCO(arg_37_0.heroId)
		local var_37_2 = {}

		for iter_37_0, iter_37_1 in pairs(var_37_1) do
			table.insert(var_37_2, iter_37_1.level)
		end

		table.sort(var_37_2, function(arg_38_0, arg_38_1)
			return arg_38_0 < arg_38_1
		end)

		local var_37_3 = var_37_2[1]
		local var_37_4 = var_37_2[#var_37_2]

		for iter_37_2 = 1, #var_37_2 - 1 do
			if arg_37_1 > var_37_2[iter_37_2] and arg_37_1 < var_37_2[iter_37_2 + 1] then
				var_37_3 = var_37_2[iter_37_2]
				var_37_4 = var_37_2[iter_37_2 + 1]

				break
			end
		end

		local var_37_5 = SkillConfig.instance:getherolevelCO(arg_37_0.heroId, var_37_3)
		local var_37_6 = SkillConfig.instance:getherolevelCO(arg_37_0.heroId, var_37_4)

		var_37_0 = {}

		for iter_37_3, iter_37_4 in pairs(CharacterEnum.AttrIdToAttrName) do
			var_37_0[iter_37_4] = arg_37_0:lerpAttr(var_37_5[iter_37_4], var_37_6[iter_37_4], var_37_3, var_37_4, arg_37_1)
		end
	end

	return (arg_37_0:addTrialUpAttr(var_37_0))
end

function var_0_0.addTrialUpAttr(arg_39_0, arg_39_1)
	if not arg_39_0.trialAttrCo then
		return arg_39_1
	end

	local var_39_0 = {}

	for iter_39_0, iter_39_1 in pairs(CharacterEnum.AttrIdToAttrName) do
		var_39_0[iter_39_1] = arg_39_1[iter_39_1]
	end

	var_39_0.cri = var_39_0.cri + arg_39_0.trialAttrCo.cri
	var_39_0.recri = var_39_0.recri + arg_39_0.trialAttrCo.recri
	var_39_0.cri_dmg = var_39_0.cri_dmg + arg_39_0.trialAttrCo.dropDmg
	var_39_0.cri_def = var_39_0.cri_def + arg_39_0.trialAttrCo.criDef
	var_39_0.add_dmg = var_39_0.add_dmg + arg_39_0.trialAttrCo.addDmg
	var_39_0.drop_dmg = var_39_0.drop_dmg + arg_39_0.trialAttrCo.dropDmg

	return var_39_0
end

function var_0_0.getHeroBaseAttrDict(arg_40_0, arg_40_1, arg_40_2)
	arg_40_1 = arg_40_1 or arg_40_0.level
	arg_40_2 = arg_40_2 or arg_40_0.rank

	local var_40_0 = arg_40_0:getHeroLevelConfig(arg_40_1)
	local var_40_1 = {}
	local var_40_2 = SkillConfig.instance:getHeroRankAttribute(arg_40_0.heroId, arg_40_2)

	for iter_40_0, iter_40_1 in pairs(CharacterEnum.BaseAttrIdList) do
		local var_40_3 = CharacterEnum.AttrIdToAttrName[iter_40_1]

		var_40_1[iter_40_1] = var_40_0[var_40_3] + var_40_2[var_40_3]
	end

	arg_40_0:addTrialBaseAttr(var_40_1)

	return var_40_1
end

function var_0_0.lerpAttr(arg_41_0, arg_41_1, arg_41_2, arg_41_3, arg_41_4, arg_41_5)
	return math.floor((arg_41_2 - arg_41_1) * (arg_41_5 - arg_41_3) / (arg_41_4 - arg_41_3)) + arg_41_1
end

function var_0_0.getTotalBaseAttrDict(arg_42_0, arg_42_1, arg_42_2, arg_42_3, arg_42_4, arg_42_5, arg_42_6)
	arg_42_2 = arg_42_2 or arg_42_0.level
	arg_42_3 = arg_42_3 or arg_42_0.rank

	local var_42_0
	local var_42_1

	if arg_42_4 then
		arg_42_6 = arg_42_6 or HeroGroupBalanceHelper.getHeroBalanceInfo

		local var_42_2, var_42_3, var_42_4, var_42_5, var_42_6 = arg_42_6(arg_42_0.heroId)

		arg_42_2 = var_42_2
		arg_42_3 = var_42_3
		var_42_0 = var_42_5
		var_42_1 = var_42_6
	end

	local var_42_7 = arg_42_0:getHeroBaseAttrDict(arg_42_2, arg_42_3)
	local var_42_8 = {}
	local var_42_9 = {}

	for iter_42_0, iter_42_1 in ipairs(CharacterEnum.BaseAttrIdList) do
		var_42_8[iter_42_1] = 0
		var_42_9[iter_42_1] = 0
	end

	if arg_42_1 and arg_42_5 then
		arg_42_0:_calcEquipAttr(arg_42_5, var_42_8, var_42_9)
	end

	if arg_42_1 and #arg_42_1 > 0 then
		for iter_42_2, iter_42_3 in ipairs(arg_42_1) do
			if tonumber(iter_42_3) < 0 then
				local var_42_10 = HeroGroupTrialModel.instance:getEquipMo(iter_42_3)

				arg_42_0:_calcEquipAttr(var_42_10, var_42_8, var_42_9)
			else
				local var_42_11 = EquipModel.instance:getEquip(iter_42_3)

				arg_42_0:_calcEquipAttr(var_42_11, var_42_8, var_42_9, var_42_1)
			end
		end

		for iter_42_4, iter_42_5 in ipairs(CharacterEnum.BaseAttrIdList) do
			var_42_8[iter_42_5] = var_42_8[iter_42_5] + math.floor(var_42_9[iter_42_5] / 1000 * var_42_7[iter_42_5])
		end
	end

	local var_42_12 = {}
	local var_42_13 = arg_42_0:isOtherPlayerHero()
	local var_42_14 = true

	if var_42_13 then
		var_42_14 = arg_42_0:getOtherPlayerIsOpenTalent()
	end

	if arg_42_3 > 1 and var_42_14 then
		var_42_12 = arg_42_0:getTalentGain(arg_42_2, arg_42_3, nil, var_42_0)
		var_42_12 = HeroConfig.instance:talentGainTab2IDTab(var_42_12)

		for iter_42_6, iter_42_7 in pairs(var_42_12) do
			if HeroConfig.instance:getHeroAttributeCO(iter_42_6).type ~= 1 then
				var_42_12[iter_42_6].value = var_42_12[iter_42_6].value / 10
			else
				var_42_12[iter_42_6].value = math.floor(var_42_12[iter_42_6].value)
			end
		end
	end

	local var_42_15 = arg_42_0.destinyStoneMo:getAddAttrValues()
	local var_42_16 = {}

	for iter_42_8, iter_42_9 in ipairs(CharacterEnum.BaseAttrIdList) do
		local var_42_17 = arg_42_0.destinyStoneMo and arg_42_0.destinyStoneMo:getAddValueByAttrId(var_42_15, iter_42_9, arg_42_0) or 0

		var_42_16[iter_42_9] = var_42_7[iter_42_9] + var_42_8[iter_42_9] + (var_42_12[iter_42_9] and var_42_12[iter_42_9].value or 0) + var_42_17
	end

	return var_42_16
end

function var_0_0.addTrialBaseAttr(arg_43_0, arg_43_1)
	if not arg_43_0.trialAttrCo then
		return
	end

	arg_43_1[CharacterEnum.AttrId.Hp] = arg_43_1[CharacterEnum.AttrId.Hp] + arg_43_0.trialAttrCo.life
	arg_43_1[CharacterEnum.AttrId.Attack] = arg_43_1[CharacterEnum.AttrId.Attack] + arg_43_0.trialAttrCo.attack
	arg_43_1[CharacterEnum.AttrId.Defense] = arg_43_1[CharacterEnum.AttrId.Defense] + arg_43_0.trialAttrCo.defense
	arg_43_1[CharacterEnum.AttrId.Mdefense] = arg_43_1[CharacterEnum.AttrId.Mdefense] + arg_43_0.trialAttrCo.mdefense
	arg_43_1[CharacterEnum.AttrId.Technic] = arg_43_1[CharacterEnum.AttrId.Technic] + arg_43_0.trialAttrCo.technic
end

function var_0_0.getTalentCubeInfos(arg_44_0, arg_44_1)
	local var_44_0 = {}
	local var_44_1 = lua_character_talent.configDict[arg_44_0][arg_44_1]
	local var_44_2 = var_44_1.talentMould
	local var_44_3 = string.splitToNumber(var_44_1.exclusive, "#")[1]
	local var_44_4 = lua_talent_scheme.configDict[arg_44_1][var_44_2][var_44_3].talenScheme
	local var_44_5 = GameUtil.splitString2(var_44_4, true, "#", ",")

	for iter_44_0, iter_44_1 in ipairs(var_44_5) do
		local var_44_6 = HeroDef_pb.TalentCubeInfo()

		var_44_6.cubeId = iter_44_1[1]
		var_44_6.direction = iter_44_1[2] or 0
		var_44_6.posX = iter_44_1[3] or 0
		var_44_6.posY = iter_44_1[4] or 0

		table.insert(var_44_0, var_44_6)
	end

	local var_44_7 = HeroTalentCubeInfosMO.New()

	var_44_7:init(var_44_0)
	var_44_7:setOwnData(arg_44_0, arg_44_1)

	return var_44_7
end

function var_0_0.getCachotTotalBaseAttrDict(arg_45_0, arg_45_1, arg_45_2, arg_45_3, arg_45_4, arg_45_5, arg_45_6, arg_45_7)
	arg_45_2 = arg_45_2 or arg_45_0.level
	arg_45_3 = arg_45_3 or arg_45_0.rank

	local var_45_0
	local var_45_1 = arg_45_0:getHeroBaseAttrDict(arg_45_2, arg_45_3)
	local var_45_2 = {}
	local var_45_3 = {}

	for iter_45_0, iter_45_1 in ipairs(CharacterEnum.BaseAttrIdList) do
		var_45_2[iter_45_1] = 0
		var_45_3[iter_45_1] = 0
	end

	if arg_45_1 and #arg_45_1 > 0 then
		for iter_45_2, iter_45_3 in ipairs(arg_45_1) do
			if tonumber(iter_45_3) < 0 then
				local var_45_4 = HeroGroupTrialModel.instance:getEquipMo(iter_45_3)

				arg_45_0:_calcEquipAttr(var_45_4, var_45_2, var_45_3)
			else
				local var_45_5 = EquipModel.instance:getEquip(iter_45_3)

				var_45_5 = var_45_5 and arg_45_6(arg_45_7, var_45_5)

				arg_45_0:_calcEquipAttr(var_45_5, var_45_2, var_45_3, var_45_0)
			end
		end

		for iter_45_4, iter_45_5 in ipairs(CharacterEnum.BaseAttrIdList) do
			var_45_2[iter_45_5] = var_45_2[iter_45_5] + math.floor(var_45_3[iter_45_5] / 1000 * var_45_1[iter_45_5])
		end
	end

	local var_45_6 = {}

	if arg_45_3 > 1 then
		var_45_6 = arg_45_0:getTalentGain(arg_45_2, arg_45_3, arg_45_4, arg_45_5)
		var_45_6 = HeroConfig.instance:talentGainTab2IDTab(var_45_6)

		for iter_45_6, iter_45_7 in pairs(var_45_6) do
			if HeroConfig.instance:getHeroAttributeCO(iter_45_6).type ~= 1 then
				var_45_6[iter_45_6].value = var_45_6[iter_45_6].value / 10
			else
				var_45_6[iter_45_6].value = math.floor(var_45_6[iter_45_6].value)
			end
		end
	end

	local var_45_7 = {}

	for iter_45_8, iter_45_9 in ipairs(CharacterEnum.BaseAttrIdList) do
		var_45_7[iter_45_9] = var_45_1[iter_45_9] + var_45_2[iter_45_9] + (var_45_6[iter_45_9] and var_45_6[iter_45_9].value or 0)
	end

	return var_45_7
end

function var_0_0._calcEquipAttr(arg_46_0, arg_46_1, arg_46_2, arg_46_3, arg_46_4)
	if not arg_46_1 then
		return
	end

	if arg_46_4 and arg_46_4 > arg_46_1.level then
		local var_46_0 = EquipMO.New()

		var_46_0:initByConfig(nil, arg_46_1.equipId, arg_46_4, arg_46_1.refineLv)

		arg_46_1 = var_46_0
	end

	local var_46_1, var_46_2, var_46_3, var_46_4 = EquipConfig.instance:getEquipAddBaseAttr(arg_46_1)

	arg_46_2[CharacterEnum.AttrId.Attack] = arg_46_2[CharacterEnum.AttrId.Attack] + var_46_2
	arg_46_2[CharacterEnum.AttrId.Hp] = arg_46_2[CharacterEnum.AttrId.Hp] + var_46_1
	arg_46_2[CharacterEnum.AttrId.Defense] = arg_46_2[CharacterEnum.AttrId.Defense] + var_46_3
	arg_46_2[CharacterEnum.AttrId.Mdefense] = arg_46_2[CharacterEnum.AttrId.Mdefense] + var_46_4

	local var_46_5, var_46_6 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(arg_46_1.config, arg_46_1.breakLv)

	if var_46_5 then
		arg_46_3[var_46_5] = (arg_46_3[var_46_5] or 0) + var_46_6
	end
end

function var_0_0.getTotalBaseAttrList(arg_47_0, arg_47_1, arg_47_2, arg_47_3)
	local var_47_0 = arg_47_0:getTotalBaseAttrDict(arg_47_1, arg_47_2, arg_47_3)
	local var_47_1 = {}

	for iter_47_0, iter_47_1 in ipairs(CharacterEnum.BaseAttrIdList) do
		table.insert(var_47_1, var_47_0[iter_47_1])
	end

	return var_47_1
end

function var_0_0.setIsBalance(arg_48_0, arg_48_1)
	arg_48_0._isBalance = arg_48_1
end

function var_0_0.getIsBalance(arg_49_0)
	return arg_49_0._isBalance or false
end

function var_0_0.getMeetingYear(arg_50_0)
	local var_50_0

	if arg_50_0.config and not string.nilorempty(arg_50_0.config.roleBirthday) then
		var_50_0 = string.splitToNumber(arg_50_0.config.roleBirthday, "/")
	end

	if not var_50_0 then
		return
	end

	local var_50_1 = arg_50_0.createTime / 1000
	local var_50_2 = os.date("!*t", var_50_1 + ServerTime.serverUtcOffset()).year
	local var_50_3 = {
		hour = 5,
		min = 0,
		sec = 0,
		year = var_50_2,
		month = var_50_0[1],
		day = var_50_0[2]
	}
	local var_50_4 = os.time(var_50_3) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset()
	local var_50_5 = 0

	if var_50_1 < var_50_4 then
		var_50_5 = 1
	end

	return os.date("*t", ServerTime.nowInLocal()).year - var_50_2 + var_50_5
end

function var_0_0.getHeroUseCubeStyleId(arg_51_0)
	if arg_51_0:isOtherPlayerHero() then
		return arg_51_0:getOtherPlayerTalentStyle()
	end

	if arg_51_0.talentTemplates and arg_51_0.useTalentTemplateId and arg_51_0.talentTemplates[arg_51_0.useTalentTemplateId] then
		return arg_51_0.talentTemplates[arg_51_0.useTalentTemplateId].style or 0
	end

	return 0
end

function var_0_0.getHeroUseStyleCubeId(arg_52_0)
	local var_52_0 = arg_52_0:getHeroUseCubeStyleId()
	local var_52_1 = HeroResonanceConfig.instance:getTalentStyle(arg_52_0.talentCubeInfos.own_main_cube_id)

	if var_52_1 and var_52_1[var_52_0] then
		return var_52_1[var_52_0]._replaceId
	end

	return arg_52_0.talentCubeInfos.own_main_cube_id
end

function var_0_0.isCanOpenDestinySystem(arg_53_0, arg_53_1)
	if not arg_53_0:isTrial() and not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DestinyStone) then
		local var_53_0 = lua_open.configDict[OpenEnum.UnlockFunc.DestinyStone].episodeId

		if arg_53_1 and not DungeonModel.instance:hasPassLevel(var_53_0) then
			local var_53_1 = DungeonConfig.instance:getEpisodeDisplay(var_53_0)

			GameFacade.showToast(ToastEnum.DungeonMapLevel, var_53_1)
		end

		return false
	end

	if not arg_53_0:isHasDestinySystem() then
		return false
	end

	local var_53_2 = arg_53_0.config.rare or 5
	local var_53_3 = CharacterDestinyEnum.DestinyStoneOpenLevelConstId[var_53_2]
	local var_53_4 = CommonConfig.instance:getConstStr(var_53_3)

	if arg_53_0.level >= tonumber(var_53_4) then
		return true
	elseif arg_53_1 then
		local var_53_5, var_53_6 = HeroConfig.instance:getShowLevel(tonumber(var_53_4))

		GameFacade.showToast(ToastEnum.CharacterDestinyUnlockLevel, GameUtil.getNum2Chinese(var_53_6 - 1), var_53_5)
	end
end

function var_0_0.isHasDestinySystem(arg_54_0)
	return CharacterDestinyConfig.instance:hasDestinyHero(arg_54_0.heroId)
end

function var_0_0.checkReplaceSkill(arg_55_0, arg_55_1)
	if arg_55_0.destinyStoneMo then
		arg_55_1 = arg_55_0.destinyStoneMo:_replaceSkill(arg_55_1)
	end

	if arg_55_0.extraMo then
		arg_55_1 = arg_55_0.extraMo:getReplaceSkills(arg_55_1)
	end

	return arg_55_1
end

function var_0_0.getRecommendEquip(arg_56_0)
	if arg_56_0.recommendEquips then
		return arg_56_0.recommendEquips
	end

	arg_56_0.recommendEquips = {}

	if not arg_56_0.config or string.nilorempty(arg_56_0.config.equipRec) then
		return arg_56_0.recommendEquips
	end

	arg_56_0.recommendEquips = string.splitToNumber(arg_56_0.config.equipRec, "#")

	return arg_56_0.recommendEquips
end

function var_0_0.getHeroType(arg_57_0)
	local var_57_0 = lua_character_rank_replace.configDict[arg_57_0.heroId]

	if var_57_0 then
		local var_57_1 = lua_character_limited.configDict[arg_57_0.skin]

		if var_57_1 and not string.nilorempty(var_57_1.specialLive2d) then
			local var_57_2 = string.split(var_57_1.specialLive2d, "#")

			if tonumber(var_57_2[1]) == 1 then
				local var_57_3 = var_57_2[2] and tonumber(var_57_2[2]) or 3

				if arg_57_0.rank > var_57_3 - 1 then
					return var_57_0.heroType
				end
			end
		end
	end

	return arg_57_0.config.heroType
end

function var_0_0.getTalentTxtByHeroType(arg_58_0)
	local var_58_0 = arg_58_0:getHeroType()

	return CharacterEnum.TalentTxtByHeroType[var_58_0]
end

return var_0_0
