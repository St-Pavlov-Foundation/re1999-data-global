module("modules.logic.character.model.HeroMo", package.seeall)

slot0 = pureTable("HeroMo")

function slot0.ctor(slot0)
	slot0.id = 0
	slot0.uid = 0
	slot0.userId = 0
	slot0.heroId = 0
	slot0.heroName = ""
	slot0.createTime = 0
	slot0.level = 0
	slot0.exp = 0
	slot0.rank = 0
	slot0.breakThrough = 0
	slot0.skin = 0
	slot0.faith = 0
	slot0.activeSkillLevel = 0
	slot0.passiveSkillLevel = 0
	slot0.exSkillLevel = 0
	slot0.voice = nil
	slot0.voiceHeard = nil
	slot0.skinInfoList = nil
	slot0.baseAttr = nil
	slot0.equipAttrList = nil
	slot0.isNew = false
	slot0.itemUnlock = nil
	slot0.talent = 0
	slot0.config = nil
	slot0.talentCubeInfos = nil
	slot0.defaultEquipUid = 0
	slot0.birthdayCount = 0
	slot0.talentStyleUnlock = nil
	slot0.isFavor = false
	slot0.destinyStoneMo = nil
	slot0.trialCo = nil
	slot0.trialAttrCo = nil
	slot0.trialEquipMo = nil
	slot0.isPosLock = false
	slot0.duplicateCount = 0
	slot0.belongOtherPlayer = false
	slot0.otherPlayerEquipMo = nil
end

function slot0.init(slot0, slot1, slot2)
	slot0:update(slot1)

	slot0.config = slot2
end

function slot0.isTrial(slot0)
	return not not slot0.trialCo
end

function slot0.setIsBelongOtherPlayer(slot0, slot1)
	slot0.belongOtherPlayer = slot1 and true or false
end

function slot0.isOtherPlayerHero(slot0)
	return slot0.belongOtherPlayer
end

function slot0.setOtherPlayerEquipMo(slot0, slot1)
	slot0.otherPlayerEquipMo = slot1
end

function slot0.getOtherPlayerEquipMo(slot0)
	return slot0.otherPlayerEquipMo
end

function slot0.setOtherPlayerIsOpenTalent(slot0, slot1)
	slot0.otherPlayerIsOpenTalent = slot1
end

function slot0.getOtherPlayerIsOpenTalent(slot0)
	return slot0.otherPlayerIsOpenTalent
end

function slot0.getOtherPlayerTalentStyle(slot0)
	return slot0.style
end

function slot0.setOtherPlayerTalentStyle(slot0, slot1)
	slot0.style = slot1
end

function slot0.getTrialEquipMo(slot0)
	slot1 = nil

	if slot0:isTrial() then
		slot1 = slot0.trialEquipMo
	end

	return slot1
end

function slot0.isOwnHero(slot0)
	return not slot0:isTrial() and not slot0:isOtherPlayerHero()
end

function slot0.fakeTrial(slot0, slot1)
	slot0.trialEquipMo = slot1
	slot0.trialCo = true
end

function slot0.getHeroName(slot0)
	if slot0.trialAttrCo then
		return slot0.trialAttrCo.name
	end

	return slot0.config.name
end

function slot0.getpassiveskillsCO(slot0)
	if slot0.trialAttrCo then
		slot1 = {}

		for slot6, slot7 in ipairs(string.splitToNumber(slot0.trialAttrCo.passiveSkill, "|")) do
			table.insert(slot1, {
				uiFilterSkill = "",
				heroId = slot0.heroId,
				skillLevel = slot6,
				skillPassive = slot7,
				skillGroup = slot6
			})
		end

		return slot1
	end

	return SkillConfig.instance:getpassiveskillsCO(slot0.heroId)
end

function slot0.isNoShowExSkill(slot0)
	if slot0.trialAttrCo then
		return slot0.trialAttrCo.noShowExSkill == 1
	end

	return false
end

function slot0.initFromTrial(slot0, slot1, slot2, slot3)
	slot0.isPosLock = slot3 ~= nil
	slot4 = lua_hero_trial.configDict[slot1][slot2 or 0]
	slot0.trialCo = slot4

	if slot4.attrId > 0 then
		slot0.trialAttrCo = lua_hero_trial_attr.configDict[slot4.attrId]
	end

	slot5 = HeroConfig.instance:getHeroCO(slot4.heroId)
	slot6 = HeroDef_pb.HeroInfo()
	slot6.uid = tostring(slot4.heroId - 1099511627776.0)
	slot6.level = slot4.level
	slot6.heroId = slot4.heroId
	slot6.defaultEquipUid = tostring(-slot4.equipId)
	slot7, slot6.rank = SkillConfig.instance:getHeroExSkillLevelByLevel(slot4.heroId, slot4.level)
	slot9 = 1

	for slot13 = slot4.talent, 1, -1 do
		if lua_character_talent.configDict[slot6.heroId][slot13] and slot14.requirement <= slot6.rank then
			slot9 = slot13

			break
		end
	end

	slot6.talent = slot9
	slot6.exSkillLevel = slot4.exSkillLv

	for slot13 = 1, slot7 do
		table.insert(slot6.passiveSkillLevel, slot13)
	end

	if slot4.skin > 0 then
		slot6.skin = slot4.skin
	else
		slot6.skin = slot5.skinId
	end

	slot10 = SkillConfig.instance:getBaseAttr(slot4.heroId, slot4.level)
	slot6.baseAttr.attack = slot10.atk
	slot6.baseAttr.defense = slot10.def
	slot6.baseAttr.hp = slot10.hp
	slot6.baseAttr.mdefense = slot10.mdef
	slot6.baseAttr.technic = slot10.technic
	slot6.exAttr.addDmg = slot10.add_dmg
	slot6.exAttr.cri = slot10.cri
	slot6.exAttr.criDef = slot10.cri_def
	slot6.exAttr.dropDmg = slot10.drop_dmg
	slot6.exAttr.recri = slot10.recri
	slot6.exAttr.criDmg = slot10.cri_dmg

	if slot0.trialAttrCo then
		slot6.baseAttr.hp = slot6.baseAttr.hp + slot0.trialAttrCo.life
		slot6.baseAttr.attack = slot6.baseAttr.attack + slot0.trialAttrCo.attack
		slot6.baseAttr.defense = slot6.baseAttr.defense + slot0.trialAttrCo.defense
		slot6.baseAttr.mdefense = slot6.baseAttr.mdefense + slot0.trialAttrCo.mdefense
		slot6.baseAttr.technic = slot6.baseAttr.technic + slot0.trialAttrCo.technic
		slot6.exAttr.cri = slot6.exAttr.cri + slot0.trialAttrCo.cri
		slot6.exAttr.recri = slot6.exAttr.recri + slot0.trialAttrCo.recri
		slot6.exAttr.dropDmg = slot6.exAttr.dropDmg + slot0.trialAttrCo.dropDmg
		slot6.exAttr.criDef = slot6.exAttr.criDef + slot0.trialAttrCo.criDef
		slot6.exAttr.addDmg = slot6.exAttr.addDmg + slot0.trialAttrCo.addDmg
		slot6.exAttr.dropDmg = slot6.exAttr.dropDmg + slot0.trialAttrCo.dropDmg
	end

	if slot4.equipId > 0 then
		slot11 = EquipMO.New()

		slot11:initByTrialCO(slot4)

		slot0.trialEquipMo = slot11
	end

	if CharacterEnum.TalentRank <= slot6.rank and slot6.talent > 0 then
		slot11 = lua_character_talent.configDict[slot6.heroId][slot6.talent]
		HeroDef_pb.TalentTemplateInfo().id = 1

		for slot20, slot21 in ipairs(GameUtil.splitString2(lua_talent_scheme.configDict[slot6.talent][slot11.talentMould][string.splitToNumber(slot11.exclusive, "#")[1]].talenScheme, true, "#", ",")) do
			HeroDef_pb.TalentCubeInfo().cubeId = slot21[1]
			slot22.direction = slot21[2] or 0
			slot22.posX = slot21[3] or 0
			slot22.posY = slot21[4] or 0

			table.insert(slot16.talentCubeInfos, slot22)
		end

		table.insert(slot6.talentTemplates, slot16)
	end

	slot0:init(slot6, slot5)

	slot0.destinyStoneMo = slot0.destinyStoneMo or HeroDestinyStoneMO.New(slot0.heroId)

	slot0.destinyStoneMo:refreshMo(slot4.facetslevel, 1, slot4.facetsId)
	slot0.destinyStoneMo:setTrial()
end

function slot0.initFromConfig(slot0, slot1)
	slot0.heroId = slot1.id
	slot0.heroName = slot1.name
	slot0.level = 1
	slot0.exp = 0
	slot0.rank = 0
	slot0.breakthrough = 0
	slot0.skin = slot1.skinId
	slot0.config = slot1
end

function slot0.update(slot0, slot1)
	slot0.heroId = slot1.heroId
	slot0.skin = slot1.skin

	if not slot1.uid then
		return
	end

	slot0.id = slot1.uid
	slot0.uid = slot1.uid
	slot0.userId = slot1.userId
	slot0.heroName = slot1.heroName
	slot0.createTime = slot1.createTime
	slot0.level = slot1.level
	slot0.exp = slot1.exp
	slot0.rank = slot1.rank
	slot0.breakthrough = slot1.breakthrough
	slot0.faith = slot1.faith
	slot0.activeSkillLevel = slot1.activeSkillLevel
	slot0.passiveSkillLevel = slot1.passiveSkillLevel
	slot0.exSkillLevel = slot1.exSkillLevel
	slot0.voice = slot0:_getListInfo(slot1.voice)
	slot0.voiceHeard = slot0:_getListInfo(slot1.voiceHeard)
	slot0.skinInfoList = slot0:_getListInfo(slot1.skinInfoList, SkinInfoMO)
	slot0.baseAttr = slot0:_getAttrlist(slot1.baseAttr, HeroAttributeMO)
	slot0.exAttr = slot0:_getAttrlist(slot1.exAttr, HeroExAttributeMO)
	slot0.spAttr = slot0:_getAttrlist(slot1.spAttr, HeroSpecialAttributeMO)
	slot0.equipAttrList = slot0:_getListInfo(slot1.equipAttrList, HeroEquipAttributeMO)
	slot0.itemUnlock = slot0:_getListInfo(slot1.itemUnlock)
	slot0.isNew = slot1.isNew
	slot0.talent = slot1.talent
	slot0.defaultEquipUid = slot1.defaultEquipUid
	slot0.birthdayCount = slot1.birthdayCount
	slot0.duplicateCount = slot1.duplicateCount
	slot0.talentTemplates = slot1.talentTemplates
	slot0.useTalentTemplateId = slot1.useTalentTemplateId == 0 and 1 or slot1.useTalentTemplateId
	slot0.talentCubeInfos = slot0:setTalentCubeInfos(slot0.talentTemplates)
	slot0.talentStyleUnlock = slot1.talentStyleUnlock
	slot0.isShowTalentStyleRed = slot1.talentStyleRed == 1
	slot0.isFavor = slot1.isFavor
	slot0.destinyStoneMo = slot0.destinyStoneMo or HeroDestinyStoneMO.New(slot0.heroId)

	slot0.destinyStoneMo:refreshMo(slot1.destinyRank, slot1.destinyLevel, slot1.destinyStone, slot1.destinyStoneUnlock)
	slot0.destinyStoneMo:setRedDot(slot1.redDot)
	slot0:setIsBelongOtherPlayer(slot1.belongOtherPlayer)
end

function slot0._getListInfo(slot0, slot1, slot2)
	slot3 = {}

	for slot8 = 1, slot1 and #slot1 or 0 do
		slot9 = slot1[slot8]

		if slot2 then
			slot2.New():init(slot1[slot8])
		end

		table.insert(slot3, slot9)
	end

	return slot3
end

function slot0._getAttrlist(slot0, slot1, slot2)
	slot3 = {}

	if slot2 then
		slot2.New():init(slot1)
	end

	return slot1
end

function slot0.levelUp(slot0, slot1)
	slot0.level = slot1.level
	slot0.heroId = slot1.heroId
end

function slot0.rankUp(slot0, slot1)
	slot0.rank = slot1.rank
	slot0.heroId = slot1.heroId
end

function slot0.talentUp(slot0, slot1)
	slot0.talent = slot1.talent
	slot0.heroId = slot1.heroId

	slot0.talentCubeInfos:setOwnData(slot0.heroId, slot0.talent)
end

function slot0.addVoice(slot0, slot1, slot2)
	if slot1 == slot0.heroId then
		table.insert(slot0.voice, slot2)
	end
end

function slot0.setItemUnlock(slot0, slot1)
	if slot1.heroId == slot0.heroId then
		table.insert(slot0.itemUnlock, slot1.itemId)
	end
end

function slot0.setTalentCubeInfos(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in ipairs(slot1) do
		if slot7.id == slot0.useTalentTemplateId then
			slot2 = slot7.talentCubeInfos

			break
		end
	end

	slot0.talentCubeInfos = slot0.talentCubeInfos or HeroTalentCubeInfosMO.New()

	slot0.talentCubeInfos:init(slot2 or {})
	slot0.talentCubeInfos:setOwnData(slot0.heroId, slot0.talent)

	return slot0.talentCubeInfos
end

function slot0.getTalentGain(slot0, slot1, slot2, slot3, slot4)
	if slot0:isOtherPlayerHero() and not slot0:getOtherPlayerIsOpenTalent() then
		return {}
	end

	if not (slot4 or slot0.talentCubeInfos) then
		logError("英雄数据找不到共鸣数据")
	end

	slot8 = {}

	for slot12, slot13 in ipairs(slot4.data_list) do
		if not slot8[slot13.cubeId] then
			slot8[slot13.cubeId] = {}
		end

		table.insert(slot8[slot13.cubeId], slot13)
	end

	slot9 = SkillConfig.instance:getTalentDamping()

	for slot13, slot14 in pairs(slot8) do
		slot15 = slot9[1][1] <= #slot14 and (slot9[2][1] <= #slot14 and slot9[2][2] or slot9[1][2]) or nil
		slot16 = {}

		for slot20, slot21 in ipairs(slot14) do
			slot0:getTalentStyleCubeAttr(slot21.cubeId, slot16, slot1, slot2, slot3, slot4)
		end

		for slot20, slot21 in pairs(slot16) do
			if slot15 then
				slot16[slot20] = slot21 * slot15 / 1000
			end

			if slot16[slot20] > 0 then
				if not slot5[slot20] then
					slot5[slot20] = {}
				end

				slot5[slot20].key = slot20
				slot5[slot20].value = (slot5[slot20].value or 0) + slot16[slot20]
			end
		end
	end

	return slot5
end

function slot0.getTalentStyleCubeAttr(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	if slot1 == slot0.talentCubeInfos.own_main_cube_id then
		slot1 = slot0:getHeroUseStyleCubeId()
	end

	slot0:getTalentAttrGainSingle(slot1, slot2, slot3, slot4, slot5, slot6)
end

function slot0.getTalentAttrGainSingle(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot7 = slot5 and HeroConfig.instance:getTalentCubeAttrConfig(slot1, slot5) or slot0:getCurTalentLevelConfig(slot1, slot6)
	slot9 = SkillConfig.instance:getBaseAttr(slot0.heroId, slot7.calculateType == 1 and CharacterModel.instance:getMaxLevel(slot0.heroId) or slot3 or slot0.level)
	slot10 = SkillConfig.instance:getHeroRankAttribute(slot0.heroId, slot7.calculateType == 1 and CharacterModel.instance:getMaxRank(slot0.heroId) or slot4 or slot0.rank)
	slot2.hp = (slot2.hp or 0) + (slot10.hp + slot9.hp) * slot7.hp / 1000
	slot2.atk = (slot2.atk or 0) + (slot10.atk + slot9.atk) * slot7.atk / 1000
	slot2.def = (slot2.def or 0) + (slot10.def + slot9.def) * slot7.def / 1000
	slot2.mdef = (slot2.mdef or 0) + (slot10.mdef + slot9.mdef) * slot7.mdef / 1000
	slot2.cri = (slot2.cri or 0) + slot7.cri
	slot2.recri = (slot2.recri or 0) + slot7.recri
	slot2.cri_dmg = (slot2.cri_dmg or 0) + slot7.cri_dmg
	slot2.cri_def = (slot2.cri_def or 0) + slot7.cri_def
	slot2.add_dmg = (slot2.add_dmg or 0) + slot7.add_dmg
	slot2.drop_dmg = (slot2.drop_dmg or 0) + slot7.drop_dmg
	slot2.revive = (slot2.revive or 0) + slot7.revive
	slot2.absorb = (slot2.absorb or 0) + slot7.absorb
	slot2.clutch = (slot2.clutch or 0) + slot7.clutch
	slot2.heal = (slot2.heal or 0) + slot7.heal
	slot2.defenseIgnore = (slot2.defenseIgnore or 0) + slot7.defenseIgnore
	slot2.normalSkillRate = (slot2.normalSkillRate or 0) + slot7.normalSkillRate

	for slot14, slot15 in pairs(slot2) do
		if slot2[slot14] == 0 then
			slot2[slot14] = nil
		elseif slot7.calculateType == 1 then
			slot2[slot14] = math.floor(slot2[slot14])
		end
	end
end

function slot0.getCurTalentLevelConfig(slot0, slot1, slot2)
	slot2 = slot2 or slot0.talentCubeInfos

	return HeroConfig.instance:getTalentCubeAttrConfig(slot1, (slot2.own_cube_dic[slot1] or slot2:getMainCubeMo()).level)
end

function slot0.clearCubeData(slot0)
	slot0.talentCubeInfos:clearData()
	slot0.talentCubeInfos:setOwnData(slot0.heroId, slot0.talent)
end

function slot0.getAttrValueWithoutTalentByID(slot0, slot1)
	slot2 = HeroConfig.instance:talentGainTab2IDTab(slot0:getTalentGain())

	if HeroConfig.instance:getHeroAttributeCO(slot1).type == 1 then
		return slot0.baseAttr[slot3.attrType] - (slot2[slot3.id] and math.floor(slot2[slot3.id].value) or 0)
	elseif slot3.type == 2 then
		return slot0.exAttr[slot3.attrType] - (slot2[slot3.id] and math.floor(slot2[slot3.id].value) or 0)
	elseif slot3.type == 3 then
		return slot0.spAttr[slot3.attrType] - (slot2[slot3.id] and math.floor(slot2[slot3.id].value) or 0)
	end
end

function slot0.getAttrValueWithoutTalentByAttrType(slot0, slot1)
	return slot0:getAttrValueWithoutTalentByID(HeroConfig.instance:getIDByAttrType(slot1))
end

function slot0.hasDefaultEquip(slot0)
	if slot0:isTrial() and slot0.defaultEquipUid ~= "0" then
		return slot0.trialEquipMo
	end

	if slot0:isOtherPlayerHero() then
		return slot0:getOtherPlayerEquipMo()
	end

	return slot0.defaultEquipUid ~= "0" and EquipModel.instance:getEquip(slot0.defaultEquipUid)
end

function slot0.getHeroLevelConfig(slot0, slot1)
	if not SkillConfig.instance:getherolevelCO(slot0.heroId, slot1 or slot0.level) then
		slot4 = {}

		for slot8, slot9 in pairs(SkillConfig.instance:getherolevelsCO(slot0.heroId)) do
			table.insert(slot4, slot9.level)
		end

		table.sort(slot4, function (slot0, slot1)
			return slot0 < slot1
		end)

		slot5 = slot4[1]
		slot6 = slot4[#slot4]

		for slot10 = 1, #slot4 - 1 do
			if slot4[slot10] < slot1 and slot1 < slot4[slot10 + 1] then
				slot5 = slot4[slot10]
				slot6 = slot4[slot10 + 1]

				break
			end
		end

		slot2 = {
			[slot13] = slot0:lerpAttr(SkillConfig.instance:getherolevelCO(slot0.heroId, slot5)[slot13], SkillConfig.instance:getherolevelCO(slot0.heroId, slot6)[slot13], slot5, slot6, slot1)
		}

		for slot12, slot13 in pairs(CharacterEnum.AttrIdToAttrName) do
			-- Nothing
		end
	end

	return slot0:addTrialUpAttr(slot2)
end

function slot0.addTrialUpAttr(slot0, slot1)
	if not slot0.trialAttrCo then
		return slot1
	end

	slot2 = {
		[slot7] = slot1[slot7]
	}

	for slot6, slot7 in pairs(CharacterEnum.AttrIdToAttrName) do
		-- Nothing
	end

	slot2.cri = slot2.cri + slot0.trialAttrCo.cri
	slot2.recri = slot2.recri + slot0.trialAttrCo.recri
	slot2.cri_dmg = slot2.cri_dmg + slot0.trialAttrCo.dropDmg
	slot2.cri_def = slot2.cri_def + slot0.trialAttrCo.criDef
	slot2.add_dmg = slot2.add_dmg + slot0.trialAttrCo.addDmg
	slot2.drop_dmg = slot2.drop_dmg + slot0.trialAttrCo.dropDmg

	return slot2
end

function slot0.getHeroBaseAttrDict(slot0, slot1, slot2)
	slot4 = {
		[slot10] = slot0:getHeroLevelConfig(slot1 or slot0.level)[slot11] + SkillConfig.instance:getHeroRankAttribute(slot0.heroId, slot2 or slot0.rank)[slot11]
	}

	for slot9, slot10 in pairs(CharacterEnum.BaseAttrIdList) do
		slot11 = CharacterEnum.AttrIdToAttrName[slot10]
	end

	slot0:addTrialBaseAttr(slot4)

	return slot4
end

function slot0.lerpAttr(slot0, slot1, slot2, slot3, slot4, slot5)
	return math.floor((slot2 - slot1) * (slot5 - slot3) / (slot4 - slot3)) + slot1
end

function slot0.getTotalBaseAttrDict(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot2 = slot2 or slot0.level
	slot3 = slot3 or slot0.rank
	slot7, slot8 = nil

	if slot4 then
		slot2, slot3, slot11, slot7, slot8 = slot6 or HeroGroupBalanceHelper.getHeroBalanceInfo(slot0.heroId)
	end

	slot9 = slot0:getHeroBaseAttrDict(slot2, slot3)
	slot10 = {
		[slot16] = 0
	}
	slot11 = {
		[slot16] = 0
	}

	for slot15, slot16 in ipairs(CharacterEnum.BaseAttrIdList) do
		-- Nothing
	end

	if slot1 and slot5 then
		slot0:_calcEquipAttr(slot5, slot10, slot11)
	end

	if slot1 and #slot1 > 0 then
		for slot15, slot16 in ipairs(slot1) do
			if tonumber(slot16) < 0 then
				slot0:_calcEquipAttr(HeroGroupTrialModel.instance:getEquipMo(slot16), slot10, slot11)
			else
				slot0:_calcEquipAttr(EquipModel.instance:getEquip(slot16), slot10, slot11, slot8)
			end
		end

		for slot15, slot16 in ipairs(CharacterEnum.BaseAttrIdList) do
			slot10[slot16] = slot10[slot16] + math.floor(slot11[slot16] / 1000 * slot9[slot16])
		end
	end

	slot12 = {}
	slot14 = true

	if slot0:isOtherPlayerHero() then
		slot14 = slot0:getOtherPlayerIsOpenTalent()
	end

	if slot3 > 1 and slot14 then
		slot18 = slot3
		slot19 = nil

		for slot18, slot19 in pairs(HeroConfig.instance:talentGainTab2IDTab(slot0:getTalentGain(slot2, slot18, slot19, slot7))) do
			if HeroConfig.instance:getHeroAttributeCO(slot18).type ~= 1 then
				slot12[slot18].value = slot12[slot18].value / 10
			else
				slot12[slot18].value = math.floor(slot12[slot18].value)
			end
		end
	end

	for slot20, slot21 in ipairs(CharacterEnum.BaseAttrIdList) do
		-- Nothing
	end

	return {
		[slot21] = slot9[slot21] + slot10[slot21] + (slot12[slot21] and slot12[slot21].value or 0) + (slot0.destinyStoneMo and slot0.destinyStoneMo:getAddValueByAttrId(slot0.destinyStoneMo:getAddAttrValues(), slot21) or 0)
	}
end

function slot0.addTrialBaseAttr(slot0, slot1)
	if not slot0.trialAttrCo then
		return
	end

	slot1[CharacterEnum.AttrId.Hp] = slot1[CharacterEnum.AttrId.Hp] + slot0.trialAttrCo.life
	slot1[CharacterEnum.AttrId.Attack] = slot1[CharacterEnum.AttrId.Attack] + slot0.trialAttrCo.attack
	slot1[CharacterEnum.AttrId.Defense] = slot1[CharacterEnum.AttrId.Defense] + slot0.trialAttrCo.defense
	slot1[CharacterEnum.AttrId.Mdefense] = slot1[CharacterEnum.AttrId.Mdefense] + slot0.trialAttrCo.mdefense
	slot1[CharacterEnum.AttrId.Technic] = slot1[CharacterEnum.AttrId.Technic] + slot0.trialAttrCo.technic
end

function slot0.getTalentCubeInfos(slot0, slot1)
	slot2 = {}
	slot3 = lua_character_talent.configDict[slot0][slot1]
	slot11 = ","

	for slot11, slot12 in ipairs(GameUtil.splitString2(lua_talent_scheme.configDict[slot1][slot3.talentMould][string.splitToNumber(slot3.exclusive, "#")[1]].talenScheme, true, "#", slot11)) do
		HeroDef_pb.TalentCubeInfo().cubeId = slot12[1]
		slot13.direction = slot12[2] or 0
		slot13.posX = slot12[3] or 0
		slot13.posY = slot12[4] or 0

		table.insert(slot2, slot13)
	end

	slot8 = HeroTalentCubeInfosMO.New()

	slot8:init(slot2)
	slot8:setOwnData(slot0, slot1)

	return slot8
end

function slot0.getCachotTotalBaseAttrDict(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot8 = nil
	slot9 = slot0:getHeroBaseAttrDict(slot2 or slot0.level, slot3 or slot0.rank)
	slot10 = {
		[slot16] = 0
	}
	slot11 = {
		[slot16] = 0
	}

	for slot15, slot16 in ipairs(CharacterEnum.BaseAttrIdList) do
		-- Nothing
	end

	if slot1 and #slot1 > 0 then
		for slot15, slot16 in ipairs(slot1) do
			if tonumber(slot16) < 0 then
				slot0:_calcEquipAttr(HeroGroupTrialModel.instance:getEquipMo(slot16), slot10, slot11)
			else
				slot0:_calcEquipAttr(EquipModel.instance:getEquip(slot16) and slot6(slot7, slot17), slot10, slot11, slot8)
			end
		end

		for slot15, slot16 in ipairs(CharacterEnum.BaseAttrIdList) do
			slot10[slot16] = slot10[slot16] + math.floor(slot11[slot16] / 1000 * slot9[slot16])
		end
	end

	slot12 = {}

	if slot3 > 1 then
		slot16 = slot3
		slot17 = slot4

		for slot16, slot17 in pairs(HeroConfig.instance:talentGainTab2IDTab(slot0:getTalentGain(slot2, slot16, slot17, slot5))) do
			if HeroConfig.instance:getHeroAttributeCO(slot16).type ~= 1 then
				slot12[slot16].value = slot12[slot16].value / 10
			else
				slot12[slot16].value = math.floor(slot12[slot16].value)
			end
		end
	end

	for slot17, slot18 in ipairs(CharacterEnum.BaseAttrIdList) do
		-- Nothing
	end

	return {
		[slot18] = slot9[slot18] + slot10[slot18] + (slot12[slot18] and slot12[slot18].value or 0)
	}
end

function slot0._calcEquipAttr(slot0, slot1, slot2, slot3, slot4)
	if not slot1 then
		return
	end

	if slot4 and slot1.level < slot4 then
		slot5 = EquipMO.New()

		slot5:initByConfig(nil, slot1.equipId, slot4, slot1.refineLv)

		slot1 = slot5
	end

	slot5, slot6, slot7, slot8 = EquipConfig.instance:getEquipAddBaseAttr(slot1)
	slot2[CharacterEnum.AttrId.Attack] = slot2[CharacterEnum.AttrId.Attack] + slot6
	slot2[CharacterEnum.AttrId.Hp] = slot2[CharacterEnum.AttrId.Hp] + slot5
	slot2[CharacterEnum.AttrId.Defense] = slot2[CharacterEnum.AttrId.Defense] + slot7
	slot2[CharacterEnum.AttrId.Mdefense] = slot2[CharacterEnum.AttrId.Mdefense] + slot8
	slot9, slot10 = EquipConfig.instance:getEquipCurrentBreakLvAttrEffect(slot1.config, slot1.breakLv)

	if slot9 then
		slot3[slot9] = (slot3[slot9] or 0) + slot10
	end
end

function slot0.getTotalBaseAttrList(slot0, slot1, slot2, slot3)
	slot5 = {}

	for slot9, slot10 in ipairs(CharacterEnum.BaseAttrIdList) do
		table.insert(slot5, slot0:getTotalBaseAttrDict(slot1, slot2, slot3)[slot10])
	end

	return slot5
end

function slot0.setIsBalance(slot0, slot1)
	slot0._isBalance = slot1
end

function slot0.getIsBalance(slot0)
	return slot0._isBalance or false
end

function slot0.getMeetingYear(slot0)
	slot1 = nil

	if slot0.config and not string.nilorempty(slot0.config.roleBirthday) then
		slot1 = string.splitToNumber(slot0.config.roleBirthday, "/")
	end

	if not slot1 then
		return
	end

	slot2 = slot0.createTime / 1000
	slot8 = 0

	if slot2 < os.time({
		hour = 5,
		min = 0,
		sec = 0,
		year = os.date("!*t", slot2 + ServerTime.serverUtcOffset()).year,
		month = slot1[1],
		day = slot1[2]
	}) - ServerTime.clientToServerOffset() - ServerTime.getDstOffset() then
		slot8 = 1
	end

	return os.date("*t", ServerTime.nowInLocal()).year - slot4 + slot8
end

function slot0.getHeroUseCubeStyleId(slot0)
	if slot0:isOtherPlayerHero() then
		return slot0:getOtherPlayerTalentStyle()
	end

	if slot0.talentTemplates and slot0.useTalentTemplateId and slot0.talentTemplates[slot0.useTalentTemplateId] then
		return slot0.talentTemplates[slot0.useTalentTemplateId].style or 0
	end

	return 0
end

function slot0.getHeroUseStyleCubeId(slot0)
	slot1 = slot0:getHeroUseCubeStyleId()

	if HeroResonanceConfig.instance:getTalentStyle(slot0.talentCubeInfos.own_main_cube_id) and slot2[slot1] then
		return slot2[slot1]._replaceId
	end

	return slot0.talentCubeInfos.own_main_cube_id
end

function slot0.isCanOpenDestinySystem(slot0, slot1)
	if not slot0:isTrial() and not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.DestinyStone) then
		slot2 = lua_open.configDict[OpenEnum.UnlockFunc.DestinyStone].episodeId

		if slot1 and not DungeonModel.instance:hasPassLevel(slot2) then
			GameFacade.showToast(ToastEnum.DungeonMapLevel, DungeonConfig.instance:getEpisodeDisplay(slot2))
		end

		return false
	end

	if not slot0:isHasDestinySystem() then
		return false
	end

	if tonumber(CommonConfig.instance:getConstStr(CharacterDestinyEnum.DestinyStoneOpenLevelConstId[slot0.config.rare or 5])) <= slot0.level then
		return true
	elseif slot1 then
		slot5, slot6 = HeroConfig.instance:getShowLevel(tonumber(slot4))

		GameFacade.showToast(ToastEnum.CharacterDestinyUnlockLevel, GameUtil.getNum2Chinese(slot6 - 1), slot5)
	end
end

function slot0.isHasDestinySystem(slot0)
	return CharacterDestinyConfig.instance:hasDestinyHero(slot0.heroId)
end

function slot0.getRecommendEquip(slot0)
	if slot0.recommendEquips then
		return slot0.recommendEquips
	end

	slot0.recommendEquips = {}

	if not slot0.config or string.nilorempty(slot0.config.equipRec) then
		return slot0.recommendEquips
	end

	slot0.recommendEquips = string.splitToNumber(slot0.config.equipRec, "#")

	return slot0.recommendEquips
end

return slot0
