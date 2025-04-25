module("modules.logic.character.model.CharacterModel", package.seeall)

slot0 = class("CharacterModel", BaseModel)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.reInit(slot0)
	slot0._btnTag = {}
	slot0._curCardList = {}
	slot0._curRankIndex = 0
	slot0._rareAscend = false
	slot0._levelAscend = false
	slot0._faithAscend = false
	slot0._exSklAscend = false
	slot0._showHeroDict = {}
	slot0._heroList = nil
	slot0._hideGainHeroView = false
end

function slot0.getBtnTag(slot0, slot1)
	if not slot0._btnTag[slot1] then
		slot0._btnTag[slot1] = 1
	end

	return slot0._btnTag[slot1]
end

function slot0.getRankIndex(slot0)
	return slot0._curRankIndex
end

function slot0.setSortByRankDescOnce(slot0)
	slot0._sortByRankDesc = true
end

function slot0._setCharacterCardList(slot0, slot1)
	CharacterBackpackCardListModel.instance:setCharacterCardList(slot1)
end

function slot0.setHeroList(slot0, slot1)
	slot0._heroList = slot1
end

function slot0._getHeroList(slot0)
	if slot0._heroList then
		return slot0._heroList
	end

	return HeroModel.instance:getList()
end

function slot0.setCharacterList(slot0, slot1, slot2)
	if not slot0._btnTag[slot2] then
		slot0._btnTag[slot2] = 1
	end

	slot0:setCardListByCareerIndex(slot0._curRankIndex, slot1)

	if slot0._btnTag[slot2] == 1 then
		slot0:_sortByLevel(slot1)
	elseif slot0._btnTag[slot2] == 2 then
		slot0:_sortByRare(slot1)
	elseif slot0._btnTag[slot2] == 3 then
		slot0:_sortByFaith(slot1)
	elseif slot0._btnTag[slot2] == 4 then
		slot0:_sortByExSkill(slot1)
	end

	if slot0._sortByRankDesc then
		slot0._sortByRankDesc = false
	end

	slot0:_setCharacterCardList(slot0._curCardList)
end

function slot0.setCardListByLevel(slot0, slot1, slot2)
	if not slot0._btnTag[slot2] then
		slot0._btnTag[slot2] = 1
	end

	slot0._rareAscend = false
	slot0._faithAscend = false
	slot0._exSklAscend = false

	if slot0._btnTag[slot2] == 1 then
		slot0._levelAscend = not slot0._levelAscend
	else
		slot0._btnTag[slot2] = 1
	end

	slot0:_sortByLevel(slot1)
	slot0:_setCharacterCardList(slot0._curCardList)
end

function slot0._updateShowHeroDict(slot0)
	slot0._showHeroDict = {}

	for slot5 = 1, #PlayerModel.instance:getShowHeros() do
		if slot1[slot5] ~= 0 then
			slot0._showHeroDict[slot1[slot5].heroId] = #slot1 - slot5 + 1
		end
	end
end

function slot0._sortByLevel(slot0, slot1)
	if slot1 then
		slot0:_updateShowHeroDict()
	else
		slot0._showHeroDict = {}
	end

	table.sort(slot0._curCardList, function (slot0, slot1)
		slot2 = uv0._fakeLevelDict and uv0._fakeLevelDict[slot0.heroId] or slot0.level
		slot3 = uv0._fakeLevelDict and uv0._fakeLevelDict[slot1.heroId] or slot1.level
		slot4 = uv0._showHeroDict[slot0.heroId] or 0
		slot5 = uv0._showHeroDict[slot1.heroId] or 0

		if uv0._sortByRankDesc and slot0.rank ~= slot1.rank then
			return slot1.rank < slot0.rank
		end

		if slot5 < slot4 then
			return true
		elseif slot4 < slot5 then
			return false
		elseif slot0.isFavor ~= slot1.isFavor then
			return slot0.isFavor
		elseif slot2 ~= slot3 then
			if uv0._levelAscend then
				return slot2 < slot3
			else
				return slot3 < slot2
			end
		elseif slot0.config.rare ~= slot1.config.rare then
			return slot1.config.rare < slot0.config.rare
		elseif slot0.exSkillLevel ~= slot1.exSkillLevel then
			return slot1.exSkillLevel < slot0.exSkillLevel
		elseif slot0.heroId ~= slot1.heroId then
			return slot1.heroId < slot0.heroId
		end
	end)
end

function slot0.setCardListByRareAndSort(slot0, slot1, slot2, slot3)
	if not slot0._btnTag[slot2] then
		slot0._btnTag[slot2] = 1
	end

	slot0._levelAscend = false
	slot0._faithAscend = false
	slot0._exSklAscend = false
	slot0._btnTag[slot2] = 2
	slot0._rareAscend = slot3

	slot0:_sortByRare(slot1)
	slot0:_setCharacterCardList(slot0._curCardList)
end

function slot0.setCardListByRare(slot0, slot1, slot2)
	if not slot0._btnTag[slot2] then
		slot0._btnTag[slot2] = 1
	end

	slot0._levelAscend = false
	slot0._faithAscend = false
	slot0._exSklAscend = false

	if slot0._btnTag[slot2] == 2 then
		slot0._rareAscend = not slot0._rareAscend
	else
		slot0._btnTag[slot2] = 2
	end

	slot0:_sortByRare(slot1)
	slot0:_setCharacterCardList(slot0._curCardList)
end

function slot0._sortByRare(slot0, slot1)
	if slot1 then
		slot0:_updateShowHeroDict()
	else
		slot0._showHeroDict = {}
	end

	table.sort(slot0._curCardList, function (slot0, slot1)
		slot2 = uv0._fakeLevelDict and uv0._fakeLevelDict[slot0.heroId] or slot0.level
		slot3 = uv0._fakeLevelDict and uv0._fakeLevelDict[slot1.heroId] or slot1.level

		if (uv0._showHeroDict[slot0.heroId] or 0) > (uv0._showHeroDict[slot1.heroId] or 0) then
			return true
		elseif slot4 < slot5 then
			return false
		elseif slot0.isFavor ~= slot1.isFavor then
			return slot0.isFavor
		elseif slot0.config.rare ~= slot1.config.rare then
			if uv0._rareAscend then
				return slot0.config.rare < slot1.config.rare
			else
				return slot1.config.rare < slot0.config.rare
			end
		elseif slot2 ~= slot3 then
			return slot3 < slot2
		elseif slot0.exSkillLevel ~= slot1.exSkillLevel then
			return slot1.exSkillLevel < slot0.exSkillLevel
		elseif slot0.heroId ~= slot1.heroId then
			return slot1.heroId < slot0.heroId
		end
	end)
end

function slot0.setCardListByFaith(slot0, slot1, slot2)
	if not slot0._btnTag[slot2] then
		slot0._btnTag[slot2] = 1
	end

	slot0._rareAscend = false
	slot0._levelAscend = false
	slot0._exSklAscend = false

	if slot0._btnTag[slot2] == 3 then
		slot0._faithAscend = not slot0._faithAscend
	else
		slot0._btnTag[slot2] = 3
	end

	slot0:_sortByFaith(slot1)
	slot0:_setCharacterCardList(slot0._curCardList)
end

function slot0._sortByFaith(slot0, slot1)
	if slot1 then
		slot0:_updateShowHeroDict()
	else
		slot0._showHeroDict = {}
	end

	table.sort(slot0._curCardList, function (slot0, slot1)
		slot2 = uv0._fakeLevelDict and uv0._fakeLevelDict[slot0.heroId] or slot0.level
		slot3 = uv0._fakeLevelDict and uv0._fakeLevelDict[slot1.heroId] or slot1.level

		if (uv0._showHeroDict[slot0.heroId] or 0) > (uv0._showHeroDict[slot1.heroId] or 0) then
			return true
		elseif slot4 < slot5 then
			return false
		elseif slot0.isFavor ~= slot1.isFavor then
			return slot0.isFavor
		elseif slot0.faith ~= slot1.faith then
			if uv0._faithAscend then
				return slot0.faith < slot1.faith
			else
				return slot1.faith < slot0.faith
			end
		elseif slot2 ~= slot3 then
			if uv0._faithAscend then
				return slot2 < slot3
			else
				return slot3 < slot2
			end
		elseif slot0.config.rare ~= slot1.config.rare then
			return slot1.config.rare < slot0.config.rare
		elseif slot0.exSkillLevel ~= slot1.exSkillLevel then
			return slot1.exSkillLevel < slot0.exSkillLevel
		elseif slot0.heroId ~= slot1.heroId then
			return slot1.heroId < slot0.heroId
		end
	end)
end

function slot0.setCardListByExSkill(slot0, slot1, slot2)
	if not slot0._btnTag[slot2] then
		slot0._btnTag[slot2] = 1
	end

	slot0._btnTag[slot2] = 4
	slot0._rareAscend = false
	slot0._levelAscend = false
	slot0._faithAscend = false

	if slot0._btnTag[slot2] == 4 then
		slot0._exSklAscend = not slot0._exSklAscend
	else
		slot0._btnTag[slot2] = 4
	end

	slot0:_sortByExSkill(slot1)
	slot0:_setCharacterCardList(slot0._curCardList)
end

function slot0._sortByExSkill(slot0, slot1)
	if slot1 then
		slot0:_updateShowHeroDict()
	else
		slot0._showHeroDict = {}
	end

	table.sort(slot0._curCardList, function (slot0, slot1)
		slot2 = uv0._fakeLevelDict and uv0._fakeLevelDict[slot0.heroId] or slot0.level
		slot3 = uv0._fakeLevelDict and uv0._fakeLevelDict[slot1.heroId] or slot1.level

		if (uv0._showHeroDict[slot0.heroId] or 0) > (uv0._showHeroDict[slot1.heroId] or 0) then
			return true
		elseif slot4 < slot5 then
			return false
		elseif slot0.isFavor ~= slot1.isFavor then
			return slot0.isFavor
		elseif slot0.exSkillLevel ~= slot1.exSkillLevel then
			if uv0._exSklAscend then
				return slot0.exSkillLevel < slot1.exSkillLevel
			else
				return slot1.exSkillLevel < slot0.exSkillLevel
			end
		elseif slot2 ~= slot3 then
			return slot3 < slot2
		elseif slot0.config.rare ~= slot1.config.rare then
			return slot1.config.rare < slot0.config.rare
		elseif slot0.faith ~= slot1.faith then
			return slot1.faith < slot0.faith
		elseif slot0.heroId ~= slot1.heroId then
			return slot1.heroId < slot0.heroId
		end
	end)
end

function slot0.setCardListByLangType(slot0, slot1, slot2, slot3)
	if not slot0._btnTag[slot1] then
		slot0._btnTag[slot1] = 1
	end

	slot0._levelAscend = false
	slot0._exSklAscend = false

	if slot3 then
		if slot0._btnTag[slot1] == 3 then
			slot0._faithAscend = not slot0._faithAscend
		else
			slot0._btnTag[slot1] = 3
		end
	end

	if slot2 then
		if slot0._btnTag[slot1] == 2 then
			slot0._rareAscend = not slot0._rareAscend
		else
			slot0._btnTag[slot1] = 2
		end
	end

	slot0:_sortByLangTypeAndRareOrTrust(slot2, slot3)
	slot0:_setCharacterCardList(slot0._curCardList)
end

function slot0._sortByLangTypeAndRareOrTrust(slot0, slot1, slot2)
	table.sort(slot0._curCardList, function (slot0, slot1)
		if uv0 then
			slot2, slot3 = uv1:_sortByRareFunction(slot0, slot1)

			if slot2 then
				return slot3
			end

			slot4, slot5 = uv1._sortByLangTypeFunction(slot0, slot1)

			if slot4 then
				return slot5
			end
		elseif uv2 then
			slot2, slot3 = uv1:_sortByTrustFunction(slot0, slot1)

			if slot2 then
				return slot3
			end
		end

		if slot0.level ~= slot1.level then
			return slot1.level < slot0.level
		elseif slot0.heroId ~= slot1.heroId then
			return slot1.heroId < slot0.heroId
		end
	end)
end

function slot0._sortByLangTypeFunction(slot0, slot1)
	slot2, slot3 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(slot0.heroId)
	slot4, slot5 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(slot1.heroId)

	if slot2 == slot4 then
		return false, nil
	end

	slot7 = 0
	slot8 = 0

	for slot12, slot13 in ipairs(HotUpdateVoiceMgr.instance:getSupportVoiceLangs()) do
		if slot3 == slot13 then
			slot7 = slot12
		end

		if slot5 == slot13 then
			slot8 = slot12
		end
	end

	if slot7 == slot8 then
		return false, nil
	else
		return true, slot7 < slot8
	end
end

function slot0._sortByRareFunction(slot0, slot1, slot2)
	if slot1.config.rare == slot2.config.rare then
		return false, nil
	end

	if slot0._rareAscend then
		return true, slot1.config.rare < slot2.config.rare
	else
		return true, slot2.config.rare < slot1.config.rare
	end
end

function slot0._sortByTrustFunction(slot0, slot1, slot2)
	if slot1.faith == slot2.faith then
		return false, nil
	end

	if slot0._faithAscend then
		return true, slot1.faith < slot2.faith
	else
		return true, slot2.faith < slot1.faith
	end
end

function slot0.getRankState(slot0)
	return {
		slot0._levelAscend and 1 or -1,
		slot0._rareAscend and 1 or -1,
		slot0._faithAscend and 1 or -1,
		slot0._exSklAscend and 1 or -1
	}
end

function slot0._isHeroInCardList(slot0, slot1)
	for slot5, slot6 in pairs(slot0._curCardList) do
		if slot6.heroId == slot1 then
			return true
		end
	end

	return false
end

function slot0.filterCardListByDmgAndCareer(slot0, slot1, slot2, slot3)
	if not slot0._btnTag[slot3] then
		slot0._btnTag[slot3] = 1
	end

	slot4 = {
		101,
		102,
		103,
		104,
		106,
		107
	}
	slot0._curCardList = {}

	slot0:checkAppendHeroMOs(tabletool.copy(slot0:_getHeroList()))

	slot6 = #slot1.locations >= 6

	for slot10, slot11 in pairs(slot5) do
		slot12 = false

		for slot16, slot17 in pairs(slot1.dmgs) do
			for slot21, slot22 in pairs(slot1.careers) do
				for slot26, slot27 in pairs(slot1.locations) do
					if slot0._showHeroDict[slot11.heroId] then
						table.insert(slot0._curCardList, slot11)
					end

					if slot11.config.career == slot22 and slot11.config.dmgType == slot17 then
						if slot6 then
							if not slot0:_isHeroInCardList(slot11.heroId) then
								table.insert(slot0._curCardList, slot11)
							end
						else
							for slot32, slot33 in pairs(string.splitToNumber(HeroConfig.instance:getHeroCO(slot11.heroId).battleTag, "#")) do
								if slot33 == slot4[slot27] and not slot0:_isHeroInCardList(slot11.heroId) then
									table.insert(slot0._curCardList, slot11)
								end
							end
						end
					end
				end
			end
		end
	end

	if slot0._btnTag[slot3] == 1 then
		slot0:_sortByLevel(slot2)
	elseif slot0._btnTag[slot3] == 2 then
		slot0:_sortByRare(slot2)
	elseif slot0._btnTag[slot3] == 3 then
		slot0:_sortByFaith(slot2)
	elseif slot0._btnTag[slot3] == 4 then
		slot0:_sortByExSkill(slot2)
	end

	slot0:_setCharacterCardList(slot0._curCardList)
end

function slot0.filterCardListByCareerAndCharType(slot0, slot1, slot2, slot3)
	if not slot0._btnTag[slot3] then
		slot0._btnTag[slot3] = 2
	end

	slot0._curCardList = {}

	slot0:checkAppendHeroMOs(tabletool.copy(slot0:_getHeroList()))

	for slot11, slot12 in pairs(slot4) do
		if #slot1.careers >= 6 and #slot1.charTypes >= 6 and slot1.charLang == 0 then
			slot0._curCardList[#slot0._curCardList + 1] = slot12
		else
			for slot16, slot17 in pairs(slot1.careers) do
				for slot21, slot22 in pairs(slot1.charTypes) do
					slot26, slot27 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(slot12.heroId)

					if slot12.config.career == slot17 and slot12.config.heroType == slot22 and (slot1.charLang == 0 or slot1.charLang == slot26) then
						slot0._curCardList[#slot0._curCardList + 1] = slot12
					end
				end
			end
		end
	end

	slot0:_sortByLangTypeAndRareOrTrust(slot0._btnTag[slot3] == 2, slot0._btnTag[slot3] == 3)
	slot0:_setCharacterCardList(slot0._curCardList)
end

function slot0.setCardListByCareerIndex(slot0, slot1, slot2)
	if slot2 then
		slot0:_updateShowHeroDict()
	else
		slot0._showHeroDict = {}
	end

	slot0._curCardList = {}
	slot0._curRankIndex = slot1

	slot0:checkAppendHeroMOs(tabletool.copy(slot0:_getHeroList()))

	if slot0._curRankIndex == 0 then
		for slot7, slot8 in pairs(slot3) do
			table.insert(slot0._curCardList, slot8)
		end
	else
		for slot7, slot8 in pairs(slot3) do
			if slot8.config.career == slot1 or slot0._showHeroDict[slot8.heroId] then
				table.insert(slot0._curCardList, slot8)
			end
		end
	end

	slot0:_setCharacterCardList(slot0._curCardList)
end

function slot0.updateCardList(slot0, slot1)
	slot0:setCardListByCareerIndex(slot0._curRankIndex)

	if slot0._rareAscend then
		slot0:_sortByRare(slot1)
	elseif slot0._levelAscend then
		slot0:_sortByLevel(slot1)
	elseif slot0._faithAscend then
		slot0:_sortByFaith(slot1)
	elseif slot0._exSklAscend then
		slot0:_sortByExSkill(slot1)
	end

	slot0:_setCharacterCardList(slot0._curCardList)
end

function slot0.getpassiveskills(slot0, slot1)
	if not SkillConfig.instance:getpassiveskillsCO(slot1) then
		return {}
	end

	slot3 = {}

	for slot7, slot8 in pairs(slot2) do
		if not slot3[slot8.skillGroup] then
			slot3[slot8.skillGroup] = {}
		end

		if not slot3[slot8.skillGroup].unlockId then
			slot3[slot8.skillGroup].unlockId = {}
		end

		if not slot3[slot8.skillGroup].lockId then
			slot3[slot8.skillGroup].lockId = {}
		end

		if slot0:isPassiveUnlock(slot1, slot7) then
			slot3[slot8.skillGroup].unlock = true

			table.insert(slot3[slot8.skillGroup].unlockId, slot8.skillLevel)
		else
			table.insert(slot3[slot8.skillGroup].lockId, slot8.skillLevel)
		end
	end

	slot4 = {}

	for slot8, slot9 in pairs(slot3) do
		table.sort(slot9.unlockId)
		table.sort(slot9.lockId)
		table.insert(slot4, {
			unlockId = slot9.unlockId,
			lockId = slot9.lockId,
			unlock = slot9.unlock
		})
	end

	table.sort(slot4, function (slot0, slot1)
		if (slot0.unlock and 1 or 0) ~= (slot1.unlock and 1 or 0) then
			return slot3 < slot2
		end
	end)

	return slot4
end

function slot0.isPassiveUnlockByHeroMo(slot0, slot1, slot2, slot3)
	for slot8, slot9 in ipairs(slot3 or slot1.passiveSkillLevel) do
		if slot9 == slot2 then
			return true
		end
	end

	return false
end

function slot0.isPassiveUnlock(slot0, slot1, slot2)
	return slot0:isPassiveUnlockByHeroMo(HeroModel.instance:getByHeroId(slot1), slot2)
end

function slot0.getMaxUnlockPassiveLevel(slot0, slot1)
	slot2 = 0

	for slot7, slot8 in ipairs(HeroModel.instance:getByHeroId(slot1).passiveSkillLevel) do
		if slot2 < slot8 then
			slot2 = slot8 or slot2
		end
	end

	return slot2
end

function slot0.isHeroLevelReachCeil(slot0, slot1, slot2)
	slot3 = HeroModel.instance:getByHeroId(slot1)

	return slot0:getrankEffects(slot1, slot3.rank)[1] <= (slot2 or slot3.level)
end

function slot0.isHeroRankReachCeil(slot0, slot1)
	return HeroModel.instance:getByHeroId(slot1).rank == slot0:getMaxRank(slot1)
end

function slot0.isHeroTalentReachCeil(slot0, slot1)
	return HeroModel.instance:getByHeroId(slot1).talent == slot0:getMaxTalent(slot1)
end

function slot0.isHeroTalentLevelUnlock(slot0, slot1, slot2)
	return slot2 <= HeroModel.instance:getByHeroId(slot1).talent
end

function slot0.getrankEffects(slot0, slot1, slot2)
	if not SkillConfig.instance:getherorankCO(slot1, slot2) then
		return {
			0,
			0,
			0
		}
	end

	slot8 = "|"

	for slot8, slot9 in pairs(string.split(slot3.effect, slot8)) do
		if string.split(slot9, "#")[1] == "1" then
			slot4[1] = tonumber(slot10[2])
		elseif slot10[1] == "2" then
			slot4[2] = tonumber(slot10[2])
		elseif slot10[1] == "3" then
			slot4[3] = tonumber(slot10[2])
		end
	end

	return slot4
end

function slot0.getMaxexskill(slot0, slot1)
	for slot7, slot8 in pairs(SkillConfig.instance:getheroexskillco(slot1)) do
		if 0 < slot8.skillLevel then
			slot3 = slot8.skillLevel
		end
	end

	return slot3
end

function slot0.getMaxLevel(slot0, slot1)
	for slot7, slot8 in pairs(SkillConfig.instance:getherolevelsCO(slot1)) do
		if 0 < slot8.level then
			slot3 = slot8.level
		end
	end

	return slot3
end

function slot0.getCurCharacterStage(slot0, slot1)
	for slot8, slot9 in pairs(SkillConfig.instance:getherolevelsCO(slot1)) do
		if slot9.level <= HeroModel.instance:getByHeroId(slot1).level and 0 < slot9.level then
			slot4 = slot9.level
		end
	end

	return slot4
end

function slot0.getMaxRank(slot0, slot1)
	for slot7, slot8 in pairs(SkillConfig.instance:getheroranksCO(slot1)) do
		if 0 < slot8.rank then
			slot3 = slot8.rank
		end
	end

	return slot3
end

function slot0.getMaxTalent(slot0, slot1)
	for slot7, slot8 in pairs(SkillConfig.instance:getherotalentsCo(slot1)) do
		if 0 < slot8.talentId then
			slot3 = slot8.talentId
		end
	end

	return slot3
end

function slot0.getAttributeCE(slot0, slot1, slot2, slot3)
	slot4 = slot1.hp
	slot5 = slot1.atk
	slot6 = slot1.def
	slot7 = slot1.mdef
	slot8 = slot1.technic
	slot10 = slot1.recri
	slot12 = slot1.cri_def
	slot13 = slot1.add_dmg
	slot14 = slot1.drop_dmg
	slot15 = slot1.revive
	slot16 = slot1.absorb
	slot17 = slot1.clutch
	slot18 = slot1.heal
	slot19 = slot1.defense_ignore
	slot22 = SkillConfig.instance:getConstNum(FightEnum.FightConstId.TechnicCorrectConst)
	slot23 = SkillConfig.instance:getConstNum(FightEnum.FightConstId.TechnicTargetLevelRatio)
	slot9 = slot1.cri + math.floor(slot8 * SkillConfig.instance:getConstNum(FightEnum.FightConstId.TechnicCriticalRatio) / (slot22 + slot2 * slot23)) / 1000
	slot11 = slot1.cri_dmg + math.floor(slot8 * SkillConfig.instance:getConstNum(FightEnum.FightConstId.TechnicCriticalDamageRatio) / (slot22 + slot2 * slot23)) / 1000

	if slot3 then
		logNormal(string.format("技巧折算%s = 暴击率%s + 暴击创伤%s", slot8, slot24, slot25))
	end

	slot41 = slot4 * 0.0833 + slot5 * 1 + slot6 * 0.5 + slot7 * 0.5 + slot5 * 0.5 * slot9 * 0.5 + math.max(0, slot5 * 0.5 * (slot11 - 1) * 0.5) + slot5 * 0.5 * slot13 + slot5 * 0.5 * slot19 + slot5 * 0.5 * slot16 * 0.66 + slot5 * 0.5 * slot17 * 0.5 + (slot6 + slot7) * 0.5 * slot10 * 0.5 + (slot6 + slot7) * 0.5 * slot12 * 0.5 + (slot6 + slot7) * 0.5 * slot14 + (slot6 + slot7) * 0.5 * slot15 * 0.66 + (slot6 + slot7) * 0.5 * slot18 * 0.5

	if slot3 then
		logNormal(string.format("基础 %s   %s   %s   %s", slot26, slot27, slot28, slot29))
		logNormal(string.format("攻击附加 %s   %s   %s   %s   %s   %s", slot30, slot31, slot32, slot33, slot34, slot35))
		logNormal(string.format("双防附加 %s   %s   %s   %s   %s", slot36, slot37, slot38, slot39, slot40))
	end

	return slot41
end

function slot0.getCorrectCE(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7)
	slot8 = math.pow(slot1, 2.5) / math.pow(slot7, 2.5)
	slot9 = slot2 and 0.7 or 1

	for slot14, slot15 in ipairs(slot4) do
		if FightConfig.instance:getRestrain(slot3, slot15) > 1000 then
			slot10 = 0 + 1
		elseif slot16 < 1000 then
			slot10 = slot10 - 1
		end
	end

	slot10 = 1 + 0.2 * Mathf.Clamp(slot10, -1, 1)
	slot11 = 1

	if not slot0._exSkillCorrectDict then
		slot0._exSkillCorrectDict = {
			[5] = {
				1.33,
				1.55,
				1.66,
				1.77,
				1.88,
				2
			},
			[4] = {
				1.17,
				1.39,
				1.5,
				1.61,
				1.72,
				1.83
			},
			[3] = {
				1,
				1.22,
				1.33,
				1.44,
				1.55,
				1.66
			}
		}
	end

	if slot0._exSkillCorrectDict[slot5] and slot0._exSkillCorrectDict[slot5][slot6] then
		slot11 = slot0._exSkillCorrectDict[slot5][slot6]
	end

	slot11 = 1 + (slot11 - 1) * 0.5

	return slot8 * slot9 * slot10 * slot11, slot8, slot9, slot10, slot11
end

function slot0.getMonsterAttribute(slot0, slot1)
	slot2 = {
		hp = slot4.life + slot5 * slot4.lifeGrow,
		atk = slot4.attack + slot5 * slot4.attackGrow,
		def = slot4.defense + slot5 * slot4.defenseGrow,
		mdef = slot4.mdefense + slot5 * slot4.mdefenseGrow,
		technic = slot4.technic + slot5 * slot4.technicGrow,
		cri = slot4.cri + slot5 * slot4.criGrow,
		recri = slot4.recri + slot5 * slot4.recriGrow,
		cri_dmg = slot4.criDmg + slot5 * slot4.criDmgGrow,
		cri_def = slot4.criDef + slot5 * slot4.criDefGrow,
		add_dmg = slot4.addDmg + slot5 * slot4.addDmgGrow,
		drop_dmg = slot4.dropDmg + slot5 * slot4.dropDmgGrow
	}
	slot3 = lua_monster.configDict[slot1]
	slot4 = lua_monster_template.configDict[slot3.template]
	slot5 = slot3.level
	slot2.cri = slot2.cri / 1000
	slot2.recri = slot2.recri / 1000
	slot2.cri_dmg = slot2.cri_dmg / 1000
	slot2.cri_def = slot2.cri_def / 1000
	slot2.add_dmg = slot2.add_dmg / 1000
	slot2.drop_dmg = slot2.drop_dmg / 1000
	slot2.revive = 0
	slot2.absorb = 0
	slot2.clutch = 0
	slot2.heal = 0
	slot2.defense_ignore = 0

	return slot2
end

function slot0.getCharacterAttributeWithEquip(slot0, slot1, slot2)
	slot3 = {
		hp = slot4.baseAttr.hp,
		atk = slot4.baseAttr.attack,
		def = slot4.baseAttr.defense,
		mdef = slot4.baseAttr.mdefense,
		technic = slot4.baseAttr.technic,
		cri = slot4.exAttr.cri,
		recri = slot4.exAttr.recri,
		cri_dmg = slot4.exAttr.criDmg,
		cri_def = slot4.exAttr.criDef,
		add_dmg = slot4.exAttr.addDmg,
		drop_dmg = slot4.exAttr.dropDmg,
		revive = slot4.spAttr.revive,
		absorb = slot4.spAttr.absorb,
		clutch = slot4.spAttr.clutch,
		heal = slot4.spAttr.heal,
		defense_ignore = slot4.spAttr.defenseIgnore
	}
	slot4 = HeroModel.instance:getByHeroId(slot1)

	if slot2 and #slot2 > 0 then
		for slot8 = 1, #slot2 do
			if EquipModel.instance:getEquip(slot2[slot8]) then
				slot10, slot11, slot12, slot13, slot14 = EquipConfig.instance:getEquipStrengthenAttrMax0(slot9)
				slot3.hp = slot3.hp + slot10
				slot3.atk = slot3.atk + slot11
				slot3.def = slot3.def + slot12
				slot3.mdef = slot3.mdef + slot13
				slot3.cri = slot3.cri + slot14.cri
				slot3.recri = slot3.recri + slot14.recri
				slot3.cri_dmg = slot3.cri_dmg + slot14.criDmg
				slot3.cri_def = slot3.cri_def + slot14.criDef
				slot3.add_dmg = slot3.add_dmg + slot14.addDmg
				slot3.drop_dmg = slot3.drop_dmg + slot14.dropDmg
				slot3.revive = slot3.revive + slot14.revive
				slot3.absorb = slot3.absorb + slot14.absorb
				slot3.clutch = slot3.clutch + slot14.clutch
				slot3.heal = slot3.heal + slot14.heal
				slot3.defense_ignore = slot3.defense_ignore + slot14.defenseIgnore
			end
		end
	end

	slot3.cri = slot3.cri / 1000
	slot3.recri = slot3.recri / 1000
	slot3.cri_dmg = slot3.cri_dmg / 1000
	slot3.cri_def = slot3.cri_def / 1000
	slot3.add_dmg = slot3.add_dmg / 1000
	slot3.drop_dmg = slot3.drop_dmg / 1000
	slot3.revive = slot3.revive / 1000
	slot3.absorb = slot3.absorb / 1000
	slot3.clutch = slot3.clutch / 1000
	slot3.heal = slot3.heal / 1000
	slot3.defense_ignore = slot3.defense_ignore / 1000

	return slot3
end

function slot0.getSumCE(slot0, slot1, slot2, slot3, slot4, slot5)
	if lua_battle.configDict[slot4].battleEffectiveness <= 0 then
		return 1
	end

	for slot14, slot15 in ipairs(DungeonConfig.instance:getMonsterListFromGroupID(slot6.monsterGroupIds)) do
		table.insert({}, slot15.career)

		slot8 = 0 + slot15.level
	end

	if #slot10 > 0 then
		slot8 = slot8 / #slot10
	end

	slot11 = 0
	slot13 = 0

	for slot17, slot18 in ipairs(slot1) do
		slot20, slot21 = slot0:getCharacterCE(slot18, slot6, slot9, slot7, slot3, slot6.playerMax <= slot13, slot8, slot5)

		if slot21 then
			slot13 = slot13 + 1
		end

		slot11 = slot11 + slot20
	end

	for slot17, slot18 in ipairs(slot2) do
		slot20, slot21 = slot0:getCharacterCE(slot18, slot6, slot9, slot7, slot3, slot12 <= slot13, slot8, slot5)

		if slot21 then
			slot13 = slot13 + 1
		end

		slot11 = slot11 + slot20
	end

	slot14 = slot11 / slot7 / 4

	if slot5 then
		logNormal(string.format("最终战力allCE = %s", slot11))
		logNormal(string.format("均值比例sumCE = %s", slot14))
	end

	return slot14
end

function slot0.getCharacterCE(slot0, slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8)
	if tonumber(slot1) < 0 then
		slot9 = math.abs(slot1)
		slot10 = {}

		if not string.nilorempty(slot2.aid) then
			slot10 = string.splitToNumber(slot2.aid, "#")
		end

		if not (slot10[slot9] and lua_monster.configDict[slot11]) then
			return 0, false
		end

		slot13 = uv0.instance:getMonsterAttribute(slot11)

		if slot8 then
			logNormal(string.format("助战角色monsterId = %s", slot11))
		end

		slot14 = uv0.instance:getAttributeCE(slot13, slot7, slot8)

		if slot8 then
			logNormal(string.format("属性战力attributeCE = %s", slot14))
		end

		slot18, slot19, slot20, slot21, slot22 = uv0.instance:getCorrectCE(slot14, slot6, slot12.career, slot3, 1, slot12.uniqueSkillLevel, slot4)
		slot23 = slot14 * slot18

		if slot8 then
			logNormal(string.format("战力修正correctCE = %s = 碾压修正%s x 替补修正%s x 克制修正%s x 仪式修正%s", slot18, slot19, slot20, slot21, slot22))
			logNormal(string.format("角色战力ce = %s", slot23))
		end

		return slot23, true
	elseif slot1 > 0 then
		if not HeroModel.instance:getById(tostring(slot1)) then
			return 0, false
		end

		slot10 = slot9.heroId
		slot11 = {}

		for slot15, slot16 in ipairs(slot5) do
			if tonumber(slot16.heroUid) == slot1 then
				slot11 = slot16.equipUid
			end
		end

		slot12 = uv0.instance:getCharacterAttributeWithEquip(slot10, slot11)

		if slot8 then
			logNormal(string.format("玩家角色heroId = %s", slot10))
		end

		slot13 = uv0.instance:getAttributeCE(slot12, slot7, slot8)

		if slot8 then
			logNormal(string.format("属性战力attributeCE = %s", slot13))
		end

		slot14 = slot9.config
		slot18, slot19, slot20, slot21, slot22 = uv0.instance:getCorrectCE(slot13, slot6, slot14.career, slot3, slot14.rare, slot9.exSkillLevel, slot4)
		slot23 = slot13 * slot18

		if slot8 then
			logNormal(string.format("战力修正correctCE = %s = 碾压修正%s x 替补修正%s x 克制修正%s x 仪式修正%s", slot18, slot19, slot20, slot21, slot22))
			logNormal(string.format("角色战力ce = %s", slot23))
		end

		return slot23, true
	end

	return 0, false
end

function slot0.isHeroCouldRankUp(slot0, slot1)
	if slot0:isHeroRankReachCeil(slot1) then
		return false
	end

	slot3 = SkillConfig.instance:getherorankCO(slot1, HeroModel.instance:getByHeroId(slot1).rank + 1)
	slot5 = string.split(slot3.consume, "|")
	slot6 = true

	for slot10, slot11 in pairs(string.split(slot3.requirement, "|")) do
		if string.splitToNumber(slot11, "#")[1] == 1 and slot2.level < slot12[2] then
			slot6 = false
		end
	end

	for slot10 = 1, #slot5 do
		slot11 = string.splitToNumber(slot5[slot10], "#")

		if ItemModel.instance:getItemQuantity(slot11[1], slot11[2]) < slot11[3] then
			slot6 = false
		end
	end

	return slot6
end

function slot0.isHeroFullDuplicateCount(slot0, slot1)
	return HeroModel.instance:getByHeroId(slot1) and CharacterEnum.MaxSkillExLevel <= slot2.duplicateCount
end

function slot0.isHeroCouldExskillUp(slot0, slot1)
	if CharacterEnum.MaxSkillExLevel <= HeroModel.instance:getByHeroId(slot1).exSkillLevel then
		return false
	end

	if not SkillConfig.instance:getherolevelexskillCO(slot1, slot2.exSkillLevel + 1) then
		logError(string.format("not found ExConfig, heroId : %s, exSkillLevel : %s", slot1, slot2.exSkillLevel + 1))

		return false
	end

	slot5 = true

	for slot9 = 1, #string.split(slot3.consume, "|") do
		slot10 = string.splitToNumber(slot4[slot9], "#")

		if ItemModel.instance:getItemQuantity(slot10[1], slot10[2]) < slot10[3] then
			slot5 = false
		end
	end

	return slot5
end

function slot0.hasRoleCouldUp(slot0)
	slot1 = false
	slot2 = tabletool.copy(slot0:_getHeroList())

	slot0:checkAppendHeroMOs(slot2)

	for slot6, slot7 in pairs(slot2) do
		if slot0:isHeroCouldExskillUp(slot7.heroId) and not HeroModel.instance:getByHeroId(slot7.heroId).isNew then
			slot1 = true
		end
	end

	return slot1
end

function slot0.hasRewardGet(slot0)
	slot1 = tabletool.copy(slot0:_getHeroList())

	slot0:checkAppendHeroMOs(slot1)

	for slot5, slot6 in pairs(slot1) do
		if slot0:hasCultureRewardGet(slot6.heroId) or slot0:hasItemRewardGet(slot6.heroId) then
			return true
		end
	end

	return false
end

function slot0.hasCultureRewardGet(slot0, slot1)
	for slot5 = 1, 3 do
		if CharacterDataConfig.instance:getCharacterDataCO(slot1, CharacterDataConfig.DefaultSkinDataKey, CharacterEnum.CharacterDataItemType.Culture, slot5) and not string.nilorempty(slot6.unlockConditine) and not CharacterDataConfig.instance:checkLockCondition(slot6) and not HeroModel.instance:checkGetRewards(slot1, 4 + slot5) then
			return true
		end
	end

	return false
end

function slot0.hasItemRewardGet(slot0, slot1)
	for slot5 = 1, 3 do
		if CharacterDataConfig.instance:getCharacterDataCO(slot1, CharacterDataConfig.DefaultSkinDataKey, CharacterEnum.CharacterDataItemType.Item, slot5) and not string.nilorempty(slot6.unlockConditine) and not CharacterDataConfig.instance:checkLockCondition(slot6) and not HeroModel.instance:checkGetRewards(slot1, slot5 + 1) then
			return true
		end
	end

	return false
end

function slot0.setFakeList(slot0, slot1)
	slot0._fakeLevelDict = slot1
end

function slot0.clearFakeList(slot0)
	slot0._fakeLevelDict = nil
end

function slot0.setFakeLevel(slot0, slot1, slot2)
	slot0._fakeLevelDict = {}

	if slot1 and slot2 then
		slot0._fakeLevelDict[slot1] = slot2
	end
end

function slot0.getFakeLevel(slot0, slot1)
	return slot0._fakeLevelDict and slot0._fakeLevelDict[slot1]
end

function slot0.heroTalentRedPoint(slot0, slot1)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
		return false
	end

	slot2 = HeroModel.instance:getByHeroId(slot1)

	if not HeroResonanceConfig.instance:getTalentConfig(slot2.heroId, slot2.talent) then
		logError("共鸣表找不到,英雄id：", slot2.heroId, "共鸣等级：", slot2.talent)
	end

	if not HeroResonanceConfig.instance:getTalentConfig(slot2.heroId, slot2.talent + 1) then
		return false
	else
		if slot2.rank < slot4.requirement then
			return false
		end

		if string.nilorempty(slot4.consume) then
			logError("共鸣消耗配置为空，英雄id：" .. slot1 .. "      共鸣等级:" .. slot4.talentId)

			return true
		end

		slot9 = true

		for slot9, slot10 in ipairs(ItemModel.instance:getItemDataListByConfigStr(slot4.consume, true, slot9)) do
			if not ItemModel.instance:goodsIsEnough(slot10.materilType, slot10.materilId, slot10.quantity) then
				return false
			end
		end
	end

	return true
end

function slot0.setAppendHeroMOs(slot0, slot1)
	slot0._appendHeroMOs = slot1
end

function slot0.checkAppendHeroMOs(slot0, slot1)
	if slot0._appendHeroMOs then
		tabletool.addValues(slot1, slot0._appendHeroMOs)
	end
end

function slot0.setGainHeroViewShowState(slot0, slot1)
	slot0._hideGainHeroView = slot1
end

function slot0.getGainHeroViewShowState(slot0)
	return slot0._hideGainHeroView
end

function slot0.setGainHeroViewNewShowState(slot0, slot1)
	slot0._hideOldGainHeroView = slot1
end

function slot0.getGainHeroViewShowNewState(slot0)
	return slot0._hideOldGainHeroView
end

slot0.instance = slot0.New()

return slot0
