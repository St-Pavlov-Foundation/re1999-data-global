module("modules.logic.character.model.CharacterModel", package.seeall)

local var_0_0 = class("CharacterModel", BaseModel)

function var_0_0.onInit(arg_1_0)
	arg_1_0:reInit()
end

function var_0_0.reInit(arg_2_0)
	arg_2_0._btnTag = {}
	arg_2_0._curCardList = {}
	arg_2_0._curRankIndex = 0
	arg_2_0._rareAscend = false
	arg_2_0._levelAscend = false
	arg_2_0._faithAscend = false
	arg_2_0._exSklAscend = false
	arg_2_0._showHeroDict = {}
	arg_2_0._heroList = nil
	arg_2_0._hideGainHeroView = false
end

function var_0_0.getBtnTag(arg_3_0, arg_3_1)
	if not arg_3_0._btnTag[arg_3_1] then
		arg_3_0._btnTag[arg_3_1] = 1
	end

	return arg_3_0._btnTag[arg_3_1]
end

function var_0_0.getRankIndex(arg_4_0)
	return arg_4_0._curRankIndex
end

function var_0_0.setSortByRankDescOnce(arg_5_0)
	arg_5_0._sortByRankDesc = true
end

function var_0_0._setCharacterCardList(arg_6_0, arg_6_1)
	CharacterBackpackCardListModel.instance:setCharacterCardList(arg_6_1)
end

function var_0_0.setHeroList(arg_7_0, arg_7_1)
	arg_7_0._heroList = arg_7_1
end

function var_0_0._getHeroList(arg_8_0)
	if arg_8_0._heroList then
		return arg_8_0._heroList
	end

	return HeroModel.instance:getList()
end

function var_0_0.setCharacterList(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_0._btnTag[arg_9_2] then
		arg_9_0._btnTag[arg_9_2] = 1
	end

	arg_9_0:setCardListByCareerIndex(arg_9_0._curRankIndex, arg_9_1)

	if arg_9_0._btnTag[arg_9_2] == 1 then
		arg_9_0:_sortByLevel(arg_9_1)
	elseif arg_9_0._btnTag[arg_9_2] == 2 then
		arg_9_0:_sortByRare(arg_9_1)
	elseif arg_9_0._btnTag[arg_9_2] == 3 then
		arg_9_0:_sortByFaith(arg_9_1)
	elseif arg_9_0._btnTag[arg_9_2] == 4 then
		arg_9_0:_sortByExSkill(arg_9_1)
	end

	if arg_9_0._sortByRankDesc then
		arg_9_0._sortByRankDesc = false
	end

	arg_9_0:_setCharacterCardList(arg_9_0._curCardList)
end

function var_0_0.setCardListByLevel(arg_10_0, arg_10_1, arg_10_2)
	if not arg_10_0._btnTag[arg_10_2] then
		arg_10_0._btnTag[arg_10_2] = 1
	end

	arg_10_0._rareAscend = false
	arg_10_0._faithAscend = false
	arg_10_0._exSklAscend = false

	if arg_10_0._btnTag[arg_10_2] == 1 then
		arg_10_0._levelAscend = not arg_10_0._levelAscend
	else
		arg_10_0._btnTag[arg_10_2] = 1
	end

	arg_10_0:_sortByLevel(arg_10_1)
	arg_10_0:_setCharacterCardList(arg_10_0._curCardList)
end

function var_0_0._updateShowHeroDict(arg_11_0)
	local var_11_0 = PlayerModel.instance:getShowHeros()

	arg_11_0._showHeroDict = {}

	for iter_11_0 = 1, #var_11_0 do
		if var_11_0[iter_11_0] ~= 0 then
			arg_11_0._showHeroDict[var_11_0[iter_11_0].heroId] = #var_11_0 - iter_11_0 + 1
		end
	end
end

function var_0_0._sortByLevel(arg_12_0, arg_12_1)
	if arg_12_1 then
		arg_12_0:_updateShowHeroDict()
	else
		arg_12_0._showHeroDict = {}
	end

	table.sort(arg_12_0._curCardList, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_12_0._fakeLevelDict and arg_12_0._fakeLevelDict[arg_13_0.heroId] or arg_13_0.level
		local var_13_1 = arg_12_0._fakeLevelDict and arg_12_0._fakeLevelDict[arg_13_1.heroId] or arg_13_1.level
		local var_13_2 = arg_12_0._showHeroDict[arg_13_0.heroId] or 0
		local var_13_3 = arg_12_0._showHeroDict[arg_13_1.heroId] or 0

		if arg_12_0._sortByRankDesc and arg_13_0.rank ~= arg_13_1.rank then
			return arg_13_0.rank > arg_13_1.rank
		end

		if var_13_3 < var_13_2 then
			return true
		elseif var_13_2 < var_13_3 then
			return false
		elseif arg_13_0.isFavor ~= arg_13_1.isFavor then
			return arg_13_0.isFavor
		elseif var_13_0 ~= var_13_1 then
			if arg_12_0._levelAscend then
				return var_13_0 < var_13_1
			else
				return var_13_1 < var_13_0
			end
		elseif arg_13_0.config.rare ~= arg_13_1.config.rare then
			return arg_13_0.config.rare > arg_13_1.config.rare
		elseif arg_13_0.exSkillLevel ~= arg_13_1.exSkillLevel then
			return arg_13_0.exSkillLevel > arg_13_1.exSkillLevel
		elseif arg_13_0.heroId ~= arg_13_1.heroId then
			return arg_13_0.heroId > arg_13_1.heroId
		end
	end)
end

function var_0_0.setCardListByRareAndSort(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if not arg_14_0._btnTag[arg_14_2] then
		arg_14_0._btnTag[arg_14_2] = 1
	end

	arg_14_0._levelAscend = false
	arg_14_0._faithAscend = false
	arg_14_0._exSklAscend = false
	arg_14_0._btnTag[arg_14_2] = 2
	arg_14_0._rareAscend = arg_14_3

	arg_14_0:_sortByRare(arg_14_1)
	arg_14_0:_setCharacterCardList(arg_14_0._curCardList)
end

function var_0_0.setCardListByRare(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_0._btnTag[arg_15_2] then
		arg_15_0._btnTag[arg_15_2] = 1
	end

	arg_15_0._levelAscend = false
	arg_15_0._faithAscend = false
	arg_15_0._exSklAscend = false

	if arg_15_0._btnTag[arg_15_2] == 2 then
		arg_15_0._rareAscend = not arg_15_0._rareAscend
	else
		arg_15_0._btnTag[arg_15_2] = 2
	end

	arg_15_0:_sortByRare(arg_15_1)
	arg_15_0:_setCharacterCardList(arg_15_0._curCardList)
end

function var_0_0._sortByRare(arg_16_0, arg_16_1)
	if arg_16_1 then
		arg_16_0:_updateShowHeroDict()
	else
		arg_16_0._showHeroDict = {}
	end

	table.sort(arg_16_0._curCardList, function(arg_17_0, arg_17_1)
		local var_17_0 = arg_16_0._fakeLevelDict and arg_16_0._fakeLevelDict[arg_17_0.heroId] or arg_17_0.level
		local var_17_1 = arg_16_0._fakeLevelDict and arg_16_0._fakeLevelDict[arg_17_1.heroId] or arg_17_1.level
		local var_17_2 = arg_16_0._showHeroDict[arg_17_0.heroId] or 0
		local var_17_3 = arg_16_0._showHeroDict[arg_17_1.heroId] or 0

		if var_17_3 < var_17_2 then
			return true
		elseif var_17_2 < var_17_3 then
			return false
		elseif arg_17_0.isFavor ~= arg_17_1.isFavor then
			return arg_17_0.isFavor
		elseif arg_17_0.config.rare ~= arg_17_1.config.rare then
			if arg_16_0._rareAscend then
				return arg_17_0.config.rare < arg_17_1.config.rare
			else
				return arg_17_0.config.rare > arg_17_1.config.rare
			end
		elseif var_17_0 ~= var_17_1 then
			return var_17_1 < var_17_0
		elseif arg_17_0.exSkillLevel ~= arg_17_1.exSkillLevel then
			return arg_17_0.exSkillLevel > arg_17_1.exSkillLevel
		elseif arg_17_0.heroId ~= arg_17_1.heroId then
			return arg_17_0.heroId > arg_17_1.heroId
		end
	end)
end

function var_0_0.setCardListByFaith(arg_18_0, arg_18_1, arg_18_2)
	if not arg_18_0._btnTag[arg_18_2] then
		arg_18_0._btnTag[arg_18_2] = 1
	end

	arg_18_0._rareAscend = false
	arg_18_0._levelAscend = false
	arg_18_0._exSklAscend = false

	if arg_18_0._btnTag[arg_18_2] == 3 then
		arg_18_0._faithAscend = not arg_18_0._faithAscend
	else
		arg_18_0._btnTag[arg_18_2] = 3
	end

	arg_18_0:_sortByFaith(arg_18_1)
	arg_18_0:_setCharacterCardList(arg_18_0._curCardList)
end

function var_0_0._sortByFaith(arg_19_0, arg_19_1)
	if arg_19_1 then
		arg_19_0:_updateShowHeroDict()
	else
		arg_19_0._showHeroDict = {}
	end

	table.sort(arg_19_0._curCardList, function(arg_20_0, arg_20_1)
		local var_20_0 = arg_19_0._fakeLevelDict and arg_19_0._fakeLevelDict[arg_20_0.heroId] or arg_20_0.level
		local var_20_1 = arg_19_0._fakeLevelDict and arg_19_0._fakeLevelDict[arg_20_1.heroId] or arg_20_1.level
		local var_20_2 = arg_19_0._showHeroDict[arg_20_0.heroId] or 0
		local var_20_3 = arg_19_0._showHeroDict[arg_20_1.heroId] or 0

		if var_20_3 < var_20_2 then
			return true
		elseif var_20_2 < var_20_3 then
			return false
		elseif arg_20_0.isFavor ~= arg_20_1.isFavor then
			return arg_20_0.isFavor
		elseif arg_20_0.faith ~= arg_20_1.faith then
			if arg_19_0._faithAscend then
				return arg_20_0.faith < arg_20_1.faith
			else
				return arg_20_0.faith > arg_20_1.faith
			end
		elseif var_20_0 ~= var_20_1 then
			if arg_19_0._faithAscend then
				return var_20_0 < var_20_1
			else
				return var_20_1 < var_20_0
			end
		elseif arg_20_0.config.rare ~= arg_20_1.config.rare then
			return arg_20_0.config.rare > arg_20_1.config.rare
		elseif arg_20_0.exSkillLevel ~= arg_20_1.exSkillLevel then
			return arg_20_0.exSkillLevel > arg_20_1.exSkillLevel
		elseif arg_20_0.heroId ~= arg_20_1.heroId then
			return arg_20_0.heroId > arg_20_1.heroId
		end
	end)
end

function var_0_0.setCardListByExSkill(arg_21_0, arg_21_1, arg_21_2)
	if not arg_21_0._btnTag[arg_21_2] then
		arg_21_0._btnTag[arg_21_2] = 1
	end

	arg_21_0._btnTag[arg_21_2] = 4
	arg_21_0._rareAscend = false
	arg_21_0._levelAscend = false
	arg_21_0._faithAscend = false

	if arg_21_0._btnTag[arg_21_2] == 4 then
		arg_21_0._exSklAscend = not arg_21_0._exSklAscend
	else
		arg_21_0._btnTag[arg_21_2] = 4
	end

	arg_21_0:_sortByExSkill(arg_21_1)
	arg_21_0:_setCharacterCardList(arg_21_0._curCardList)
end

function var_0_0._sortByExSkill(arg_22_0, arg_22_1)
	if arg_22_1 then
		arg_22_0:_updateShowHeroDict()
	else
		arg_22_0._showHeroDict = {}
	end

	table.sort(arg_22_0._curCardList, function(arg_23_0, arg_23_1)
		local var_23_0 = arg_22_0._fakeLevelDict and arg_22_0._fakeLevelDict[arg_23_0.heroId] or arg_23_0.level
		local var_23_1 = arg_22_0._fakeLevelDict and arg_22_0._fakeLevelDict[arg_23_1.heroId] or arg_23_1.level
		local var_23_2 = arg_22_0._showHeroDict[arg_23_0.heroId] or 0
		local var_23_3 = arg_22_0._showHeroDict[arg_23_1.heroId] or 0

		if var_23_3 < var_23_2 then
			return true
		elseif var_23_2 < var_23_3 then
			return false
		elseif arg_23_0.isFavor ~= arg_23_1.isFavor then
			return arg_23_0.isFavor
		elseif arg_23_0.exSkillLevel ~= arg_23_1.exSkillLevel then
			if arg_22_0._exSklAscend then
				return arg_23_0.exSkillLevel < arg_23_1.exSkillLevel
			else
				return arg_23_0.exSkillLevel > arg_23_1.exSkillLevel
			end
		elseif var_23_0 ~= var_23_1 then
			return var_23_1 < var_23_0
		elseif arg_23_0.config.rare ~= arg_23_1.config.rare then
			return arg_23_0.config.rare > arg_23_1.config.rare
		elseif arg_23_0.faith ~= arg_23_1.faith then
			return arg_23_0.faith > arg_23_1.faith
		elseif arg_23_0.heroId ~= arg_23_1.heroId then
			return arg_23_0.heroId > arg_23_1.heroId
		end
	end)
end

function var_0_0.setCardListByLangType(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	if not arg_24_0._btnTag[arg_24_1] then
		arg_24_0._btnTag[arg_24_1] = 1
	end

	arg_24_0._levelAscend = false
	arg_24_0._exSklAscend = false

	if arg_24_3 then
		if arg_24_0._btnTag[arg_24_1] == 3 then
			arg_24_0._faithAscend = not arg_24_0._faithAscend
		else
			arg_24_0._btnTag[arg_24_1] = 3
		end
	end

	if arg_24_2 then
		if arg_24_0._btnTag[arg_24_1] == 2 then
			arg_24_0._rareAscend = not arg_24_0._rareAscend
		else
			arg_24_0._btnTag[arg_24_1] = 2
		end
	end

	arg_24_0:_sortByLangTypeAndRareOrTrust(arg_24_2, arg_24_3)
	arg_24_0:_setCharacterCardList(arg_24_0._curCardList)
end

function var_0_0._sortByLangTypeAndRareOrTrust(arg_25_0, arg_25_1, arg_25_2)
	table.sort(arg_25_0._curCardList, function(arg_26_0, arg_26_1)
		if arg_25_1 then
			local var_26_0, var_26_1 = arg_25_0:_sortByRareFunction(arg_26_0, arg_26_1)

			if var_26_0 then
				return var_26_1
			end

			local var_26_2, var_26_3 = arg_25_0._sortByLangTypeFunction(arg_26_0, arg_26_1)

			if var_26_2 then
				return var_26_3
			end
		elseif arg_25_2 then
			local var_26_4, var_26_5 = arg_25_0:_sortByTrustFunction(arg_26_0, arg_26_1)

			if var_26_4 then
				return var_26_5
			end
		end

		if arg_26_0.level ~= arg_26_1.level then
			return arg_26_0.level > arg_26_1.level
		elseif arg_26_0.heroId ~= arg_26_1.heroId then
			return arg_26_0.heroId > arg_26_1.heroId
		end
	end)
end

function var_0_0._sortByLangTypeFunction(arg_27_0, arg_27_1)
	local var_27_0, var_27_1 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(arg_27_0.heroId)
	local var_27_2, var_27_3 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(arg_27_1.heroId)

	if var_27_0 == var_27_2 then
		return false, nil
	end

	local var_27_4 = HotUpdateVoiceMgr.instance:getSupportVoiceLangs()
	local var_27_5 = 0
	local var_27_6 = 0

	for iter_27_0, iter_27_1 in ipairs(var_27_4) do
		if var_27_1 == iter_27_1 then
			var_27_5 = iter_27_0
		end

		if var_27_3 == iter_27_1 then
			var_27_6 = iter_27_0
		end
	end

	if var_27_5 == var_27_6 then
		return false, nil
	else
		return true, var_27_5 < var_27_6
	end
end

function var_0_0._sortByRareFunction(arg_28_0, arg_28_1, arg_28_2)
	if arg_28_1.config.rare == arg_28_2.config.rare then
		return false, nil
	end

	if arg_28_0._rareAscend then
		return true, arg_28_1.config.rare < arg_28_2.config.rare
	else
		return true, arg_28_1.config.rare > arg_28_2.config.rare
	end
end

function var_0_0._sortByTrustFunction(arg_29_0, arg_29_1, arg_29_2)
	if arg_29_1.faith == arg_29_2.faith then
		return false, nil
	end

	if arg_29_0._faithAscend then
		return true, arg_29_1.faith < arg_29_2.faith
	else
		return true, arg_29_1.faith > arg_29_2.faith
	end
end

function var_0_0.getRankState(arg_30_0)
	return {
		arg_30_0._levelAscend and 1 or -1,
		arg_30_0._rareAscend and 1 or -1,
		arg_30_0._faithAscend and 1 or -1,
		arg_30_0._exSklAscend and 1 or -1
	}
end

function var_0_0._isHeroInCardList(arg_31_0, arg_31_1)
	for iter_31_0, iter_31_1 in pairs(arg_31_0._curCardList) do
		if iter_31_1.heroId == arg_31_1 then
			return true
		end
	end

	return false
end

function var_0_0.filterCardListByDmgAndCareer(arg_32_0, arg_32_1, arg_32_2, arg_32_3)
	if not arg_32_0._btnTag[arg_32_3] then
		arg_32_0._btnTag[arg_32_3] = 1
	end

	local var_32_0 = {
		101,
		102,
		103,
		104,
		106,
		107
	}

	arg_32_0._curCardList = {}

	local var_32_1 = tabletool.copy(arg_32_0:_getHeroList())

	arg_32_0:checkAppendHeroMOs(var_32_1)

	local var_32_2 = #arg_32_1.locations >= 6

	for iter_32_0, iter_32_1 in pairs(var_32_1) do
		local var_32_3 = false

		for iter_32_2, iter_32_3 in pairs(arg_32_1.dmgs) do
			for iter_32_4, iter_32_5 in pairs(arg_32_1.careers) do
				for iter_32_6, iter_32_7 in pairs(arg_32_1.locations) do
					if arg_32_0._showHeroDict[iter_32_1.heroId] then
						table.insert(arg_32_0._curCardList, iter_32_1)
					end

					if iter_32_1.config.career == iter_32_5 and iter_32_1.config.dmgType == iter_32_3 then
						if var_32_2 then
							if not arg_32_0:_isHeroInCardList(iter_32_1.heroId) then
								table.insert(arg_32_0._curCardList, iter_32_1)
							end
						else
							local var_32_4 = string.splitToNumber(HeroConfig.instance:getHeroCO(iter_32_1.heroId).battleTag, "#")

							for iter_32_8, iter_32_9 in pairs(var_32_4) do
								if iter_32_9 == var_32_0[iter_32_7] and not arg_32_0:_isHeroInCardList(iter_32_1.heroId) then
									table.insert(arg_32_0._curCardList, iter_32_1)
								end
							end
						end
					end
				end
			end
		end
	end

	if arg_32_0._btnTag[arg_32_3] == 1 then
		arg_32_0:_sortByLevel(arg_32_2)
	elseif arg_32_0._btnTag[arg_32_3] == 2 then
		arg_32_0:_sortByRare(arg_32_2)
	elseif arg_32_0._btnTag[arg_32_3] == 3 then
		arg_32_0:_sortByFaith(arg_32_2)
	elseif arg_32_0._btnTag[arg_32_3] == 4 then
		arg_32_0:_sortByExSkill(arg_32_2)
	end

	arg_32_0:_setCharacterCardList(arg_32_0._curCardList)
end

function var_0_0.filterCardListByCareerAndCharType(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	if not arg_33_0._btnTag[arg_33_3] then
		arg_33_0._btnTag[arg_33_3] = 2
	end

	arg_33_0._curCardList = {}

	local var_33_0 = tabletool.copy(arg_33_0:_getHeroList())

	arg_33_0:checkAppendHeroMOs(var_33_0)

	local var_33_1 = #arg_33_1.careers >= 6
	local var_33_2 = #arg_33_1.charTypes >= 6
	local var_33_3 = arg_33_1.charLang == 0

	for iter_33_0, iter_33_1 in pairs(var_33_0) do
		if var_33_1 and var_33_2 and var_33_3 then
			arg_33_0._curCardList[#arg_33_0._curCardList + 1] = iter_33_1
		else
			for iter_33_2, iter_33_3 in pairs(arg_33_1.careers) do
				for iter_33_4, iter_33_5 in pairs(arg_33_1.charTypes) do
					local var_33_4 = iter_33_1.config.career == iter_33_3
					local var_33_5 = iter_33_1.config.heroType == iter_33_5
					local var_33_6 = iter_33_1.heroId
					local var_33_7, var_33_8 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(var_33_6)
					local var_33_9 = arg_33_1.charLang == 0 or arg_33_1.charLang == var_33_7

					if var_33_4 and var_33_5 and var_33_9 then
						arg_33_0._curCardList[#arg_33_0._curCardList + 1] = iter_33_1
					end
				end
			end
		end
	end

	arg_33_0:_sortByLangTypeAndRareOrTrust(arg_33_0._btnTag[arg_33_3] == 2, arg_33_0._btnTag[arg_33_3] == 3)
	arg_33_0:_setCharacterCardList(arg_33_0._curCardList)
end

function var_0_0.setCardListByCareerIndex(arg_34_0, arg_34_1, arg_34_2)
	if arg_34_2 then
		arg_34_0:_updateShowHeroDict()
	else
		arg_34_0._showHeroDict = {}
	end

	arg_34_0._curCardList = {}
	arg_34_0._curRankIndex = arg_34_1

	local var_34_0 = tabletool.copy(arg_34_0:_getHeroList())

	arg_34_0:checkAppendHeroMOs(var_34_0)

	if arg_34_0._curRankIndex == 0 then
		for iter_34_0, iter_34_1 in pairs(var_34_0) do
			table.insert(arg_34_0._curCardList, iter_34_1)
		end
	else
		for iter_34_2, iter_34_3 in pairs(var_34_0) do
			if iter_34_3.config.career == arg_34_1 or arg_34_0._showHeroDict[iter_34_3.heroId] then
				table.insert(arg_34_0._curCardList, iter_34_3)
			end
		end
	end

	arg_34_0:_setCharacterCardList(arg_34_0._curCardList)
end

function var_0_0.updateCardList(arg_35_0, arg_35_1)
	arg_35_0:setCardListByCareerIndex(arg_35_0._curRankIndex)

	if arg_35_0._rareAscend then
		arg_35_0:_sortByRare(arg_35_1)
	elseif arg_35_0._levelAscend then
		arg_35_0:_sortByLevel(arg_35_1)
	elseif arg_35_0._faithAscend then
		arg_35_0:_sortByFaith(arg_35_1)
	elseif arg_35_0._exSklAscend then
		arg_35_0:_sortByExSkill(arg_35_1)
	end

	arg_35_0:_setCharacterCardList(arg_35_0._curCardList)
end

function var_0_0.getpassiveskills(arg_36_0, arg_36_1)
	local var_36_0 = SkillConfig.instance:getpassiveskillsCO(arg_36_1)

	if not var_36_0 then
		return {}
	end

	local var_36_1 = {}

	for iter_36_0, iter_36_1 in pairs(var_36_0) do
		if not var_36_1[iter_36_1.skillGroup] then
			var_36_1[iter_36_1.skillGroup] = {}
		end

		if not var_36_1[iter_36_1.skillGroup].unlockId then
			var_36_1[iter_36_1.skillGroup].unlockId = {}
		end

		if not var_36_1[iter_36_1.skillGroup].lockId then
			var_36_1[iter_36_1.skillGroup].lockId = {}
		end

		if arg_36_0:isPassiveUnlock(arg_36_1, iter_36_0) then
			var_36_1[iter_36_1.skillGroup].unlock = true

			table.insert(var_36_1[iter_36_1.skillGroup].unlockId, iter_36_1.skillLevel)
		else
			table.insert(var_36_1[iter_36_1.skillGroup].lockId, iter_36_1.skillLevel)
		end
	end

	local var_36_2 = {}

	for iter_36_2, iter_36_3 in pairs(var_36_1) do
		table.sort(iter_36_3.unlockId)
		table.sort(iter_36_3.lockId)

		local var_36_3 = {
			unlockId = iter_36_3.unlockId,
			lockId = iter_36_3.lockId,
			unlock = iter_36_3.unlock
		}

		table.insert(var_36_2, var_36_3)
	end

	table.sort(var_36_2, function(arg_37_0, arg_37_1)
		local var_37_0 = arg_37_0.unlock and 1 or 0
		local var_37_1 = arg_37_1.unlock and 1 or 0

		if var_37_0 ~= var_37_1 then
			return var_37_1 < var_37_0
		end
	end)

	return var_36_2
end

function var_0_0.isPassiveUnlockByHeroMo(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = arg_38_3 or arg_38_1.passiveSkillLevel

	for iter_38_0, iter_38_1 in ipairs(var_38_0) do
		if iter_38_1 == arg_38_2 then
			return true
		end
	end

	return false
end

function var_0_0.isPassiveUnlock(arg_39_0, arg_39_1, arg_39_2)
	return arg_39_0:isPassiveUnlockByHeroMo(HeroModel.instance:getByHeroId(arg_39_1), arg_39_2)
end

function var_0_0.getMaxUnlockPassiveLevel(arg_40_0, arg_40_1)
	local var_40_0 = 0
	local var_40_1 = HeroModel.instance:getByHeroId(arg_40_1).passiveSkillLevel

	for iter_40_0, iter_40_1 in ipairs(var_40_1) do
		var_40_0 = var_40_0 < iter_40_1 and iter_40_1 or var_40_0
	end

	return var_40_0
end

function var_0_0.isHeroLevelReachCeil(arg_41_0, arg_41_1, arg_41_2)
	local var_41_0 = HeroModel.instance:getByHeroId(arg_41_1)

	arg_41_2 = arg_41_2 or var_41_0.level

	return arg_41_2 >= arg_41_0:getrankEffects(arg_41_1, var_41_0.rank)[1]
end

function var_0_0.isHeroRankReachCeil(arg_42_0, arg_42_1)
	return HeroModel.instance:getByHeroId(arg_42_1).rank == arg_42_0:getMaxRank(arg_42_1)
end

function var_0_0.isHeroTalentReachCeil(arg_43_0, arg_43_1)
	return HeroModel.instance:getByHeroId(arg_43_1).talent == arg_43_0:getMaxTalent(arg_43_1)
end

function var_0_0.isHeroTalentLevelUnlock(arg_44_0, arg_44_1, arg_44_2)
	return arg_44_2 <= HeroModel.instance:getByHeroId(arg_44_1).talent
end

function var_0_0.getrankEffects(arg_45_0, arg_45_1, arg_45_2)
	local var_45_0 = SkillConfig.instance:getherorankCO(arg_45_1, arg_45_2)
	local var_45_1 = {
		0,
		0,
		0
	}

	if not var_45_0 then
		return var_45_1
	end

	for iter_45_0, iter_45_1 in pairs(string.split(var_45_0.effect, "|")) do
		local var_45_2 = string.split(iter_45_1, "#")

		if var_45_2[1] == "1" then
			var_45_1[1] = tonumber(var_45_2[2])
		elseif var_45_2[1] == "2" then
			var_45_1[2] = tonumber(var_45_2[2])
		elseif var_45_2[1] == "3" then
			var_45_1[3] = tonumber(var_45_2[2])
		end
	end

	return var_45_1
end

function var_0_0.getMaxexskill(arg_46_0, arg_46_1)
	local var_46_0 = SkillConfig.instance:getheroexskillco(arg_46_1)
	local var_46_1 = 0

	for iter_46_0, iter_46_1 in pairs(var_46_0) do
		if var_46_1 < iter_46_1.skillLevel then
			var_46_1 = iter_46_1.skillLevel
		end
	end

	return var_46_1
end

function var_0_0.getMaxLevel(arg_47_0, arg_47_1)
	local var_47_0 = SkillConfig.instance:getherolevelsCO(arg_47_1)
	local var_47_1 = 0

	for iter_47_0, iter_47_1 in pairs(var_47_0) do
		if var_47_1 < iter_47_1.level then
			var_47_1 = iter_47_1.level
		end
	end

	return var_47_1
end

function var_0_0.getCurCharacterStage(arg_48_0, arg_48_1)
	local var_48_0 = HeroModel.instance:getByHeroId(arg_48_1).level
	local var_48_1 = SkillConfig.instance:getherolevelsCO(arg_48_1)
	local var_48_2 = 0

	for iter_48_0, iter_48_1 in pairs(var_48_1) do
		if var_48_0 >= iter_48_1.level and var_48_2 < iter_48_1.level then
			var_48_2 = iter_48_1.level
		end
	end

	return var_48_2
end

function var_0_0.getMaxRank(arg_49_0, arg_49_1)
	local var_49_0 = SkillConfig.instance:getheroranksCO(arg_49_1)
	local var_49_1 = 0

	for iter_49_0, iter_49_1 in pairs(var_49_0) do
		if var_49_1 < iter_49_1.rank then
			var_49_1 = iter_49_1.rank
		end
	end

	return var_49_1
end

function var_0_0.getMaxTalent(arg_50_0, arg_50_1)
	local var_50_0 = SkillConfig.instance:getherotalentsCo(arg_50_1)
	local var_50_1 = 0

	for iter_50_0, iter_50_1 in pairs(var_50_0) do
		if var_50_1 < iter_50_1.talentId then
			var_50_1 = iter_50_1.talentId
		end
	end

	return var_50_1
end

function var_0_0.getAttributeCE(arg_51_0, arg_51_1, arg_51_2, arg_51_3)
	local var_51_0 = arg_51_1.hp
	local var_51_1 = arg_51_1.atk
	local var_51_2 = arg_51_1.def
	local var_51_3 = arg_51_1.mdef
	local var_51_4 = arg_51_1.technic
	local var_51_5 = arg_51_1.cri
	local var_51_6 = arg_51_1.recri
	local var_51_7 = arg_51_1.cri_dmg
	local var_51_8 = arg_51_1.cri_def
	local var_51_9 = arg_51_1.add_dmg
	local var_51_10 = arg_51_1.drop_dmg
	local var_51_11 = arg_51_1.revive
	local var_51_12 = arg_51_1.absorb
	local var_51_13 = arg_51_1.clutch
	local var_51_14 = arg_51_1.heal
	local var_51_15 = arg_51_1.defense_ignore
	local var_51_16 = SkillConfig.instance:getConstNum(FightEnum.FightConstId.TechnicCriticalRatio)
	local var_51_17 = SkillConfig.instance:getConstNum(FightEnum.FightConstId.TechnicCriticalDamageRatio)
	local var_51_18 = SkillConfig.instance:getConstNum(FightEnum.FightConstId.TechnicCorrectConst)
	local var_51_19 = SkillConfig.instance:getConstNum(FightEnum.FightConstId.TechnicTargetLevelRatio)
	local var_51_20 = math.floor(var_51_4 * var_51_16 / (var_51_18 + arg_51_2 * var_51_19)) / 1000
	local var_51_21 = math.floor(var_51_4 * var_51_17 / (var_51_18 + arg_51_2 * var_51_19)) / 1000
	local var_51_22 = var_51_5 + var_51_20
	local var_51_23 = var_51_7 + var_51_21

	if arg_51_3 then
		logNormal(string.format("技巧折算%s = 暴击率%s + 暴击创伤%s", var_51_4, var_51_20, var_51_21))
	end

	local var_51_24 = var_51_1 * 1
	local var_51_25 = var_51_2 * 0.5
	local var_51_26 = var_51_3 * 0.5
	local var_51_27 = var_51_0 * 0.0833
	local var_51_28 = var_51_1 * 0.5 * var_51_22 * 0.5
	local var_51_29 = math.max(0, var_51_1 * 0.5 * (var_51_23 - 1) * 0.5)
	local var_51_30 = var_51_1 * 0.5 * var_51_9
	local var_51_31 = var_51_1 * 0.5 * var_51_15
	local var_51_32 = var_51_1 * 0.5 * var_51_12 * 0.66
	local var_51_33 = var_51_1 * 0.5 * var_51_13 * 0.5
	local var_51_34 = (var_51_2 + var_51_3) * 0.5 * var_51_6 * 0.5
	local var_51_35 = (var_51_2 + var_51_3) * 0.5 * var_51_8 * 0.5
	local var_51_36 = (var_51_2 + var_51_3) * 0.5 * var_51_10
	local var_51_37 = (var_51_2 + var_51_3) * 0.5 * var_51_11 * 0.66
	local var_51_38 = (var_51_2 + var_51_3) * 0.5 * var_51_14 * 0.5
	local var_51_39 = var_51_27 + var_51_24 + var_51_25 + var_51_26 + var_51_28 + var_51_29 + var_51_30 + var_51_31 + var_51_32 + var_51_33 + var_51_34 + var_51_35 + var_51_36 + var_51_37 + var_51_38

	if arg_51_3 then
		logNormal(string.format("基础 %s   %s   %s   %s", var_51_24, var_51_25, var_51_26, var_51_27))
		logNormal(string.format("攻击附加 %s   %s   %s   %s   %s   %s", var_51_28, var_51_29, var_51_30, var_51_31, var_51_32, var_51_33))
		logNormal(string.format("双防附加 %s   %s   %s   %s   %s", var_51_34, var_51_35, var_51_36, var_51_37, var_51_38))
	end

	return var_51_39
end

function var_0_0.getCorrectCE(arg_52_0, arg_52_1, arg_52_2, arg_52_3, arg_52_4, arg_52_5, arg_52_6, arg_52_7)
	local var_52_0 = math.pow(arg_52_1, 2.5) / math.pow(arg_52_7, 2.5)
	local var_52_1 = arg_52_2 and 0.7 or 1
	local var_52_2 = 0

	for iter_52_0, iter_52_1 in ipairs(arg_52_4) do
		local var_52_3 = FightConfig.instance:getRestrain(arg_52_3, iter_52_1)

		if var_52_3 > 1000 then
			var_52_2 = var_52_2 + 1
		elseif var_52_3 < 1000 then
			var_52_2 = var_52_2 - 1
		end
	end

	local var_52_4 = 1 + 0.2 * Mathf.Clamp(var_52_2, -1, 1)
	local var_52_5 = 1

	if not arg_52_0._exSkillCorrectDict then
		arg_52_0._exSkillCorrectDict = {}
		arg_52_0._exSkillCorrectDict[5] = {
			1.33,
			1.55,
			1.66,
			1.77,
			1.88,
			2
		}
		arg_52_0._exSkillCorrectDict[4] = {
			1.17,
			1.39,
			1.5,
			1.61,
			1.72,
			1.83
		}
		arg_52_0._exSkillCorrectDict[3] = {
			1,
			1.22,
			1.33,
			1.44,
			1.55,
			1.66
		}
	end

	if arg_52_0._exSkillCorrectDict[arg_52_5] and arg_52_0._exSkillCorrectDict[arg_52_5][arg_52_6] then
		var_52_5 = arg_52_0._exSkillCorrectDict[arg_52_5][arg_52_6]
	end

	local var_52_6 = 1 + (var_52_5 - 1) * 0.5

	return var_52_0 * var_52_1 * var_52_4 * var_52_6, var_52_0, var_52_1, var_52_4, var_52_6
end

function var_0_0.getMonsterAttribute(arg_53_0, arg_53_1)
	local var_53_0 = {}
	local var_53_1 = lua_monster.configDict[arg_53_1]
	local var_53_2 = lua_monster_template.configDict[var_53_1.template]
	local var_53_3 = var_53_1.level

	var_53_0.hp = var_53_2.life + var_53_3 * var_53_2.lifeGrow
	var_53_0.atk = var_53_2.attack + var_53_3 * var_53_2.attackGrow
	var_53_0.def = var_53_2.defense + var_53_3 * var_53_2.defenseGrow
	var_53_0.mdef = var_53_2.mdefense + var_53_3 * var_53_2.mdefenseGrow
	var_53_0.technic = var_53_2.technic + var_53_3 * var_53_2.technicGrow
	var_53_0.cri = var_53_2.cri + var_53_3 * var_53_2.criGrow
	var_53_0.recri = var_53_2.recri + var_53_3 * var_53_2.recriGrow
	var_53_0.cri_dmg = var_53_2.criDmg + var_53_3 * var_53_2.criDmgGrow
	var_53_0.cri_def = var_53_2.criDef + var_53_3 * var_53_2.criDefGrow
	var_53_0.add_dmg = var_53_2.addDmg + var_53_3 * var_53_2.addDmgGrow
	var_53_0.drop_dmg = var_53_2.dropDmg + var_53_3 * var_53_2.dropDmgGrow
	var_53_0.cri = var_53_0.cri / 1000
	var_53_0.recri = var_53_0.recri / 1000
	var_53_0.cri_dmg = var_53_0.cri_dmg / 1000
	var_53_0.cri_def = var_53_0.cri_def / 1000
	var_53_0.add_dmg = var_53_0.add_dmg / 1000
	var_53_0.drop_dmg = var_53_0.drop_dmg / 1000
	var_53_0.revive = 0
	var_53_0.absorb = 0
	var_53_0.clutch = 0
	var_53_0.heal = 0
	var_53_0.defense_ignore = 0

	return var_53_0
end

function var_0_0.getCharacterAttributeWithEquip(arg_54_0, arg_54_1, arg_54_2)
	local var_54_0 = {}
	local var_54_1 = HeroModel.instance:getByHeroId(arg_54_1)

	var_54_0.hp = var_54_1.baseAttr.hp
	var_54_0.atk = var_54_1.baseAttr.attack
	var_54_0.def = var_54_1.baseAttr.defense
	var_54_0.mdef = var_54_1.baseAttr.mdefense
	var_54_0.technic = var_54_1.baseAttr.technic
	var_54_0.cri = var_54_1.exAttr.cri
	var_54_0.recri = var_54_1.exAttr.recri
	var_54_0.cri_dmg = var_54_1.exAttr.criDmg
	var_54_0.cri_def = var_54_1.exAttr.criDef
	var_54_0.add_dmg = var_54_1.exAttr.addDmg
	var_54_0.drop_dmg = var_54_1.exAttr.dropDmg
	var_54_0.revive = var_54_1.spAttr.revive
	var_54_0.absorb = var_54_1.spAttr.absorb
	var_54_0.clutch = var_54_1.spAttr.clutch
	var_54_0.heal = var_54_1.spAttr.heal
	var_54_0.defense_ignore = var_54_1.spAttr.defenseIgnore

	if arg_54_2 and #arg_54_2 > 0 then
		for iter_54_0 = 1, #arg_54_2 do
			local var_54_2 = EquipModel.instance:getEquip(arg_54_2[iter_54_0])

			if var_54_2 then
				local var_54_3, var_54_4, var_54_5, var_54_6, var_54_7 = EquipConfig.instance:getEquipStrengthenAttrMax0(var_54_2)

				var_54_0.hp = var_54_0.hp + var_54_3
				var_54_0.atk = var_54_0.atk + var_54_4
				var_54_0.def = var_54_0.def + var_54_5
				var_54_0.mdef = var_54_0.mdef + var_54_6
				var_54_0.cri = var_54_0.cri + var_54_7.cri
				var_54_0.recri = var_54_0.recri + var_54_7.recri
				var_54_0.cri_dmg = var_54_0.cri_dmg + var_54_7.criDmg
				var_54_0.cri_def = var_54_0.cri_def + var_54_7.criDef
				var_54_0.add_dmg = var_54_0.add_dmg + var_54_7.addDmg
				var_54_0.drop_dmg = var_54_0.drop_dmg + var_54_7.dropDmg
				var_54_0.revive = var_54_0.revive + var_54_7.revive
				var_54_0.absorb = var_54_0.absorb + var_54_7.absorb
				var_54_0.clutch = var_54_0.clutch + var_54_7.clutch
				var_54_0.heal = var_54_0.heal + var_54_7.heal
				var_54_0.defense_ignore = var_54_0.defense_ignore + var_54_7.defenseIgnore
			end
		end
	end

	var_54_0.cri = var_54_0.cri / 1000
	var_54_0.recri = var_54_0.recri / 1000
	var_54_0.cri_dmg = var_54_0.cri_dmg / 1000
	var_54_0.cri_def = var_54_0.cri_def / 1000
	var_54_0.add_dmg = var_54_0.add_dmg / 1000
	var_54_0.drop_dmg = var_54_0.drop_dmg / 1000
	var_54_0.revive = var_54_0.revive / 1000
	var_54_0.absorb = var_54_0.absorb / 1000
	var_54_0.clutch = var_54_0.clutch / 1000
	var_54_0.heal = var_54_0.heal / 1000
	var_54_0.defense_ignore = var_54_0.defense_ignore / 1000

	return var_54_0
end

function var_0_0.getSumCE(arg_55_0, arg_55_1, arg_55_2, arg_55_3, arg_55_4, arg_55_5)
	local var_55_0 = lua_battle.configDict[arg_55_4]
	local var_55_1 = var_55_0.battleEffectiveness

	if var_55_1 <= 0 then
		return 1
	end

	local var_55_2 = 0
	local var_55_3 = {}
	local var_55_4 = DungeonConfig.instance:getMonsterListFromGroupID(var_55_0.monsterGroupIds)

	for iter_55_0, iter_55_1 in ipairs(var_55_4) do
		table.insert(var_55_3, iter_55_1.career)

		var_55_2 = var_55_2 + iter_55_1.level
	end

	if #var_55_4 > 0 then
		var_55_2 = var_55_2 / #var_55_4
	end

	local var_55_5 = 0
	local var_55_6 = var_55_0.playerMax
	local var_55_7 = 0

	for iter_55_2, iter_55_3 in ipairs(arg_55_1) do
		local var_55_8 = var_55_6 <= var_55_7
		local var_55_9, var_55_10 = arg_55_0:getCharacterCE(iter_55_3, var_55_0, var_55_3, var_55_1, arg_55_3, var_55_8, var_55_2, arg_55_5)

		if var_55_10 then
			var_55_7 = var_55_7 + 1
		end

		var_55_5 = var_55_5 + var_55_9
	end

	for iter_55_4, iter_55_5 in ipairs(arg_55_2) do
		local var_55_11 = var_55_6 <= var_55_7
		local var_55_12, var_55_13 = arg_55_0:getCharacterCE(iter_55_5, var_55_0, var_55_3, var_55_1, arg_55_3, var_55_11, var_55_2, arg_55_5)

		if var_55_13 then
			var_55_7 = var_55_7 + 1
		end

		var_55_5 = var_55_5 + var_55_12
	end

	local var_55_14 = var_55_5 / var_55_1 / 4

	if arg_55_5 then
		logNormal(string.format("最终战力allCE = %s", var_55_5))
		logNormal(string.format("均值比例sumCE = %s", var_55_14))
	end

	return var_55_14
end

function var_0_0.getCharacterCE(arg_56_0, arg_56_1, arg_56_2, arg_56_3, arg_56_4, arg_56_5, arg_56_6, arg_56_7, arg_56_8)
	arg_56_1 = tonumber(arg_56_1)

	if arg_56_1 < 0 then
		local var_56_0 = math.abs(arg_56_1)
		local var_56_1 = {}

		if not string.nilorempty(arg_56_2.aid) then
			var_56_1 = string.splitToNumber(arg_56_2.aid, "#")
		end

		local var_56_2 = var_56_1[var_56_0]
		local var_56_3 = var_56_2 and lua_monster.configDict[var_56_2]

		if not var_56_3 then
			return 0, false
		end

		local var_56_4 = var_0_0.instance:getMonsterAttribute(var_56_2)

		if arg_56_8 then
			logNormal(string.format("助战角色monsterId = %s", var_56_2))
		end

		local var_56_5 = var_0_0.instance:getAttributeCE(var_56_4, arg_56_7, arg_56_8)

		if arg_56_8 then
			logNormal(string.format("属性战力attributeCE = %s", var_56_5))
		end

		local var_56_6 = var_56_3.career
		local var_56_7 = 1
		local var_56_8 = var_56_3.uniqueSkillLevel
		local var_56_9, var_56_10, var_56_11, var_56_12, var_56_13 = var_0_0.instance:getCorrectCE(var_56_5, arg_56_6, var_56_6, arg_56_3, var_56_7, var_56_8, arg_56_4)
		local var_56_14 = var_56_5 * var_56_9

		if arg_56_8 then
			logNormal(string.format("战力修正correctCE = %s = 碾压修正%s x 替补修正%s x 克制修正%s x 仪式修正%s", var_56_9, var_56_10, var_56_11, var_56_12, var_56_13))
			logNormal(string.format("角色战力ce = %s", var_56_14))
		end

		return var_56_14, true
	elseif arg_56_1 > 0 then
		local var_56_15 = HeroModel.instance:getById(tostring(arg_56_1))

		if not var_56_15 then
			return 0, false
		end

		local var_56_16 = var_56_15.heroId
		local var_56_17 = {}

		for iter_56_0, iter_56_1 in ipairs(arg_56_5) do
			if tonumber(iter_56_1.heroUid) == arg_56_1 then
				var_56_17 = iter_56_1.equipUid
			end
		end

		local var_56_18 = var_0_0.instance:getCharacterAttributeWithEquip(var_56_16, var_56_17)

		if arg_56_8 then
			logNormal(string.format("玩家角色heroId = %s", var_56_16))
		end

		local var_56_19 = var_0_0.instance:getAttributeCE(var_56_18, arg_56_7, arg_56_8)

		if arg_56_8 then
			logNormal(string.format("属性战力attributeCE = %s", var_56_19))
		end

		local var_56_20 = var_56_15.config
		local var_56_21 = var_56_20.career
		local var_56_22 = var_56_20.rare
		local var_56_23 = var_56_15.exSkillLevel
		local var_56_24, var_56_25, var_56_26, var_56_27, var_56_28 = var_0_0.instance:getCorrectCE(var_56_19, arg_56_6, var_56_21, arg_56_3, var_56_22, var_56_23, arg_56_4)
		local var_56_29 = var_56_19 * var_56_24

		if arg_56_8 then
			logNormal(string.format("战力修正correctCE = %s = 碾压修正%s x 替补修正%s x 克制修正%s x 仪式修正%s", var_56_24, var_56_25, var_56_26, var_56_27, var_56_28))
			logNormal(string.format("角色战力ce = %s", var_56_29))
		end

		return var_56_29, true
	end

	return 0, false
end

function var_0_0.isHeroCouldRankUp(arg_57_0, arg_57_1)
	if arg_57_0:isHeroRankReachCeil(arg_57_1) then
		return false
	end

	local var_57_0 = HeroModel.instance:getByHeroId(arg_57_1)
	local var_57_1 = SkillConfig.instance:getherorankCO(arg_57_1, var_57_0.rank + 1)
	local var_57_2 = string.split(var_57_1.requirement, "|")
	local var_57_3 = string.split(var_57_1.consume, "|")
	local var_57_4 = true

	for iter_57_0, iter_57_1 in pairs(var_57_2) do
		local var_57_5 = string.splitToNumber(iter_57_1, "#")

		if var_57_5[1] == 1 and var_57_0.level < var_57_5[2] then
			var_57_4 = false
		end
	end

	for iter_57_2 = 1, #var_57_3 do
		local var_57_6 = string.splitToNumber(var_57_3[iter_57_2], "#")

		if ItemModel.instance:getItemQuantity(var_57_6[1], var_57_6[2]) < var_57_6[3] then
			var_57_4 = false
		end
	end

	return var_57_4
end

function var_0_0.isHeroFullDuplicateCount(arg_58_0, arg_58_1)
	local var_58_0 = HeroModel.instance:getByHeroId(arg_58_1)

	return var_58_0 and CharacterEnum.MaxSkillExLevel <= var_58_0.duplicateCount
end

function var_0_0.isHeroCouldExskillUp(arg_59_0, arg_59_1)
	local var_59_0 = HeroModel.instance:getByHeroId(arg_59_1)

	if CharacterEnum.MaxSkillExLevel <= var_59_0.exSkillLevel then
		return false
	end

	local var_59_1 = SkillConfig.instance:getherolevelexskillCO(arg_59_1, var_59_0.exSkillLevel + 1)

	if not var_59_1 then
		logError(string.format("not found ExConfig, heroId : %s, exSkillLevel : %s", arg_59_1, var_59_0.exSkillLevel + 1))

		return false
	end

	local var_59_2 = string.split(var_59_1.consume, "|")
	local var_59_3 = true

	for iter_59_0 = 1, #var_59_2 do
		local var_59_4 = string.splitToNumber(var_59_2[iter_59_0], "#")

		if ItemModel.instance:getItemQuantity(var_59_4[1], var_59_4[2]) < var_59_4[3] then
			var_59_3 = false
		end
	end

	return var_59_3
end

function var_0_0.hasRoleCouldUp(arg_60_0)
	local var_60_0 = false
	local var_60_1 = tabletool.copy(arg_60_0:_getHeroList())

	arg_60_0:checkAppendHeroMOs(var_60_1)

	for iter_60_0, iter_60_1 in pairs(var_60_1) do
		if arg_60_0:isHeroCouldExskillUp(iter_60_1.heroId) and not HeroModel.instance:getByHeroId(iter_60_1.heroId).isNew then
			var_60_0 = true
		end
	end

	return var_60_0
end

function var_0_0.hasRewardGet(arg_61_0)
	local var_61_0 = tabletool.copy(arg_61_0:_getHeroList())

	arg_61_0:checkAppendHeroMOs(var_61_0)

	for iter_61_0, iter_61_1 in pairs(var_61_0) do
		if arg_61_0:hasCultureRewardGet(iter_61_1.heroId) or arg_61_0:hasItemRewardGet(iter_61_1.heroId) then
			return true
		end
	end

	return false
end

function var_0_0.hasCultureRewardGet(arg_62_0, arg_62_1)
	for iter_62_0 = 1, 3 do
		local var_62_0 = CharacterDataConfig.instance:getCharacterDataCO(arg_62_1, CharacterDataConfig.DefaultSkinDataKey, CharacterEnum.CharacterDataItemType.Culture, iter_62_0)

		if var_62_0 and not string.nilorempty(var_62_0.unlockConditine) and not CharacterDataConfig.instance:checkLockCondition(var_62_0) and not HeroModel.instance:checkGetRewards(arg_62_1, 4 + iter_62_0) then
			return true
		end
	end

	return false
end

function var_0_0.hasItemRewardGet(arg_63_0, arg_63_1)
	for iter_63_0 = 1, 3 do
		local var_63_0 = CharacterDataConfig.instance:getCharacterDataCO(arg_63_1, CharacterDataConfig.DefaultSkinDataKey, CharacterEnum.CharacterDataItemType.Item, iter_63_0)

		if var_63_0 and not string.nilorempty(var_63_0.unlockConditine) and not CharacterDataConfig.instance:checkLockCondition(var_63_0) and not HeroModel.instance:checkGetRewards(arg_63_1, iter_63_0 + 1) then
			return true
		end
	end

	return false
end

function var_0_0.setFakeList(arg_64_0, arg_64_1)
	arg_64_0._fakeLevelDict = arg_64_1
end

function var_0_0.clearFakeList(arg_65_0)
	arg_65_0._fakeLevelDict = nil
end

function var_0_0.setFakeLevel(arg_66_0, arg_66_1, arg_66_2)
	arg_66_0._fakeLevelDict = {}

	if arg_66_1 and arg_66_2 then
		arg_66_0._fakeLevelDict[arg_66_1] = arg_66_2
	end
end

function var_0_0.getFakeLevel(arg_67_0, arg_67_1)
	return arg_67_0._fakeLevelDict and arg_67_0._fakeLevelDict[arg_67_1]
end

function var_0_0.heroTalentRedPoint(arg_68_0, arg_68_1)
	if not OpenModel.instance:isFunctionUnlock(OpenEnum.UnlockFunc.Talent) then
		return false
	end

	local var_68_0 = HeroModel.instance:getByHeroId(arg_68_1)

	if not HeroResonanceConfig.instance:getTalentConfig(var_68_0.heroId, var_68_0.talent) then
		logError("共鸣表找不到,英雄id：", var_68_0.heroId, "共鸣等级：", var_68_0.talent)
	end

	local var_68_1 = HeroResonanceConfig.instance:getTalentConfig(var_68_0.heroId, var_68_0.talent + 1)

	if not var_68_1 then
		return false
	else
		if var_68_1.requirement > var_68_0.rank then
			return false
		end

		if string.nilorempty(var_68_1.consume) then
			logError("共鸣消耗配置为空，英雄id：" .. arg_68_1 .. "      共鸣等级:" .. var_68_1.talentId)

			return true
		end

		local var_68_2 = ItemModel.instance:getItemDataListByConfigStr(var_68_1.consume, true, true)

		for iter_68_0, iter_68_1 in ipairs(var_68_2) do
			if not ItemModel.instance:goodsIsEnough(iter_68_1.materilType, iter_68_1.materilId, iter_68_1.quantity) then
				return false
			end
		end
	end

	return true
end

function var_0_0.setAppendHeroMOs(arg_69_0, arg_69_1)
	arg_69_0._appendHeroMOs = arg_69_1
end

function var_0_0.checkAppendHeroMOs(arg_70_0, arg_70_1)
	if arg_70_0._appendHeroMOs then
		tabletool.addValues(arg_70_1, arg_70_0._appendHeroMOs)
	end
end

function var_0_0.setGainHeroViewShowState(arg_71_0, arg_71_1)
	arg_71_0._hideGainHeroView = arg_71_1
end

function var_0_0.getGainHeroViewShowState(arg_72_0)
	return arg_72_0._hideGainHeroView
end

function var_0_0.setGainHeroViewNewShowState(arg_73_0, arg_73_1)
	arg_73_0._hideOldGainHeroView = arg_73_1
end

function var_0_0.getGainHeroViewShowNewState(arg_74_0)
	return arg_74_0._hideOldGainHeroView
end

function var_0_0.getSpecialEffectDesc(arg_75_0, arg_75_1, arg_75_2)
	local var_75_0 = lua_character_limited.configDict[arg_75_1]
	local var_75_1

	if var_75_0 and not string.nilorempty(var_75_0.specialInsightDesc) then
		local var_75_2 = string.split(var_75_0.specialInsightDesc, "#")

		if arg_75_2 == tonumber(var_75_2[1]) - 1 then
			var_75_1 = {}

			for iter_75_0 = 2, #var_75_2 do
				table.insert(var_75_1, var_75_2[iter_75_0])
			end
		end
	end

	return var_75_1
end

function var_0_0.isNeedShowNewSkillReddot(arg_76_0, arg_76_1)
	if not arg_76_1 or not arg_76_1:isOwnHero() then
		return
	end

	local var_76_0 = lua_character_limited.configDict[arg_76_1.skin]

	if var_76_0 and not string.nilorempty(var_76_0.specialLive2d) then
		local var_76_1 = string.split(var_76_0.specialLive2d, "#")

		if tonumber(var_76_1[1]) == 1 then
			local var_76_2 = var_76_1[2] and tonumber(var_76_1[2]) or 3
			local var_76_3 = arg_76_1.rank > var_76_2 - 1
			local var_76_4 = PlayerModel.instance:getPropKeyValue(PlayerEnum.SimpleProperty.NuoDiKaNewSkill, arg_76_1.heroId, 0) == 0

			return var_76_3, var_76_4, var_76_0
		end
	end
end

var_0_0.AnimKey_ReplaceSkillPlay = "CharacterSkillContainer_ReplaceSkill_"

function var_0_0.isCanPlayReplaceSkillAnim(arg_77_0, arg_77_1)
	local var_77_0, var_77_1, var_77_2 = arg_77_0:isNeedShowNewSkillReddot(arg_77_1)

	if var_77_0 then
		local var_77_3 = var_0_0.AnimKey_ReplaceSkillPlay .. arg_77_1.heroId

		return GameUtil.playerPrefsGetNumberByUserId(var_77_3, 0) == 0, var_77_1, var_77_2
	end
end

function var_0_0.setPlayReplaceSkillAnim(arg_78_0, arg_78_1)
	GameUtil.playerPrefsSetNumberByUserId(var_0_0.AnimKey_ReplaceSkillPlay .. arg_78_1.heroId, 1)
end

function var_0_0.getReplaceSkillRank(arg_79_0, arg_79_1)
	if not arg_79_1 then
		return 0
	end

	return arg_79_0:getReplaceSkillRankBySkinId(arg_79_1.skin)
end

function var_0_0.getReplaceSkillRankBySkinId(arg_80_0, arg_80_1)
	if not arg_80_1 then
		return 0
	end

	local var_80_0 = arg_80_1

	if not arg_80_0._heroReplaceSkillRankDict then
		arg_80_0._heroReplaceSkillRankDict = {}
	end

	if not arg_80_0._heroReplaceSkillRankDict[var_80_0] then
		local var_80_1 = lua_character_limited.configDict[var_80_0]

		if var_80_1 then
			local var_80_2 = string.split(var_80_1.specialInsightDesc, "#")

			arg_80_0._heroReplaceSkillRankDict[var_80_0] = tonumber(var_80_2[1])
		end
	end

	return arg_80_0._heroReplaceSkillRankDict[var_80_0] or 1
end

var_0_0.instance = var_0_0.New()

return var_0_0
