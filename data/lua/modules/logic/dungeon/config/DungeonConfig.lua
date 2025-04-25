module("modules.logic.dungeon.config.DungeonConfig", package.seeall)

slot0 = class("DungeonConfig", BaseConfig)

function slot0.ctor(slot0)
	slot0._chapterConfig = nil
	slot0._episodeConfig = nil
	slot0._bonusConfig = nil
	slot0._chapterEpisodeDict = nil
	slot0._chpaterNonSpEpisodeDict = nil
	slot0._episodeIndex = {}
	slot0._chapterListByType = {}
	slot0._lvConfig = nil
	slot0._interactConfig = nil
	slot0._colorConfig = nil
	slot0._dispatchConfig = nil
	slot0._rewardConfigDict = nil
end

function slot0.reqConfigNames(slot0)
	return {
		"chapter_map_element",
		"chapter_map",
		"chapter",
		"episode",
		"bonus",
		"battle",
		"condition",
		"rule",
		"chapter_divide",
		"chapter_point_reward",
		"chapter_map_fragment",
		"chapter_map_element_dispatch",
		"chapter_map_element_dialog",
		"equip_chapter",
		"chapter_puzzle_question",
		"chapter_puzzle_square",
		"chapter_map_hole",
		"reward",
		"reward_group",
		"chapter_puzzle_changecolor",
		"chapter_puzzle_changecolor_interact",
		"chapter_puzzle_changecolor_color"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "chapter" then
		slot0._chapterConfig = slot2

		slot0:_initChapterList()
	elseif slot1 == "episode" then
		slot0._episodeConfig = slot2

		slot0:_rebuildEpisodeConfigs()
		slot0:_initEpisodeList()
	elseif slot1 == "bonus" then
		slot0._bonusConfig = slot2
	elseif slot1 == "reward_group" then
		slot0._rewardConfigDict = {}

		for slot6, slot7 in ipairs(slot2.configList) do
			if not slot0._rewardConfigDict[slot7.group] then
				slot0._rewardConfigDict[slot7.group] = {}
			end

			table.insert(slot0._rewardConfigDict[slot7.group], slot7)
		end
	elseif slot1 == "chapter_divide" then
		slot0:_initChapterDivide()
	elseif slot1 == "chapter_point_reward" then
		slot0:_initChapterPointReward()
	elseif slot1 == "chapter_map_element" then
		slot0:_initElement()
	elseif slot1 == "chapter_map_element_dialog" then
		slot0:_initDialog()
	elseif slot1 == "chapter_map" then
		slot0:_initChapterMap()
	elseif slot1 == "chapter_puzzle_square" then
		slot0:_initPuzzleSquare(slot2)
	elseif slot1 == "chapter_puzzle_changecolor" then
		slot0._lvConfig = slot2
	elseif slot1 == "chapter_puzzle_changecolor_interact" then
		slot0._interactConfig = slot2
	elseif slot1 == "chapter_puzzle_changecolor_color" then
		slot0._colorConfig = slot2
	end
end

function slot0._initElement(slot0)
	if slot0._elementFightList then
		return
	end

	slot0._elementFightList = {}
	slot0._mapGuidepostDict = {}
	slot0._mapIdToElements = {}

	for slot4, slot5 in ipairs(lua_chapter_map_element.configList) do
		if slot5.type == DungeonEnum.ElementType.Fight then
			if slot0._elementFightList[tonumber(slot5.param)] then
				logError(string.format("chapter_map_element.json element fight id:%s 参数：%s 重复配置了", slot5.id, slot6))
			end

			if slot6 then
				slot0._elementFightList[slot6] = slot5
			else
				logError(string.format("战斗元件id：%s,没有配参数：%s", slot5.id, slot5.param))
			end
		elseif slot5.type == DungeonEnum.ElementType.Guidepost then
			slot0._mapGuidepostDict[slot5.mapId] = slot5.id
		end

		if not slot0._mapIdToElements[slot5.mapId] then
			slot0._mapIdToElements[slot5.mapId] = {}
		end

		table.insert(slot6, slot5)
	end
end

function slot0.getMapElements(slot0, slot1)
	return slot0._mapIdToElements and slot0._mapIdToElements[slot1]
end

function slot0.getMapGuidepost(slot0, slot1)
	return slot0._mapGuidepostDict[slot1]
end

function slot0.getElementEpisode(slot0, slot1)
	if not slot0._elementFightList[slot1] then
		return nil
	end

	return slot0._chapterMapEpisodeDic[slot2.mapId]
end

function slot0.getEpisodeIdByMapId(slot0, slot1)
	return slot0._chapterMapEpisodeDic[slot1]
end

function slot0.getDispatchCfg(slot0, slot1)
	slot2 = nil

	if slot1 then
		slot2 = lua_chapter_map_element_dispatch.configDict[slot1]
	end

	if not slot2 then
		logError(string.format("DungeonConfig:getDispatchCfg error, cfg is nil, dispatchId: %s", slot1))
	end

	return slot2
end

function slot0._initDialog(slot0)
	if slot0._dialogList then
		return
	end

	slot0._dialogList = {}
	slot1 = nil

	for slot6, slot7 in ipairs(lua_chapter_map_element_dialog.configList) do
		if not slot0._dialogList[slot7.id] then
			slot1 = 0
			slot0._dialogList[slot7.id] = {}
		end

		if slot7.type == "selector" then
			slot1 = slot7.param
		elseif slot7.type == "selectorend" then
			slot1 = slot2
		else
			slot8[slot1] = slot8[slot1] or {}

			table.insert(slot8[slot1], slot7)
		end
	end
end

function slot0.getDialog(slot0, slot1, slot2)
	return slot0._dialogList[slot1] and slot3[slot2]
end

function slot0._initChapterDivide(slot0)
	slot0._chapterDivide = {}

	for slot4, slot5 in ipairs(lua_chapter_divide.configList) do
		for slot9, slot10 in ipairs(slot5.chapterId) do
			slot0._chapterDivide[slot10] = slot5.sectionId
		end
	end
end

function slot0.getChapterDivideSectionId(slot0, slot1)
	return slot0._chapterDivide[slot1]
end

function slot0._initChapterPointReward(slot0)
	if slot0._chapterPointReward then
		return
	end

	slot0._chapterPointReward = {}

	for slot4, slot5 in ipairs(lua_chapter_point_reward.configList) do
		slot0._chapterPointReward[slot5.chapterId] = slot0._chapterPointReward[slot5.chapterId] or {}

		table.insert(slot0._chapterPointReward[slot5.chapterId], slot5)
	end
end

function slot0.getChapterPointReward(slot0, slot1)
	return slot0._chapterPointReward[slot1]
end

function slot0._initChapterMap(slot0)
	if slot0._chapterMapList then
		return
	end

	slot0._chapterMapList = {}
	slot0._chapterMapEpisodeDic = {}

	for slot4, slot5 in ipairs(lua_chapter_map.configList) do
		slot0._chapterMapList[slot5.chapterId] = slot0._chapterMapList[slot5.chapterId] or {}

		if string.nilorempty(slot5.unlockCondition) then
			slot0._chapterMapList[slot5.chapterId][0] = slot5
		else
			slot0._chapterMapList[slot5.chapterId][tonumber(string.gsub(slot5.unlockCondition, "EpisodeFinish=", ""))] = slot5
		end
	end
end

function slot0._mapConnectEpisode(slot0, slot1)
	if not slot0._chapterMapList[slot1.chapterId] then
		return
	end

	if not slot2[(slot1.preEpisode <= 0 or slot0:getEpisodeCO(slot1.preEpisode).chapterId ~= slot1.chapterId) and 0 or slot1.preEpisode2] then
		return
	end

	slot0._chapterMapEpisodeDic[slot5.id] = slot1.id
end

function slot0.getChapterMapCfg(slot0, slot1, slot2)
	if slot0._chapterMapList[slot1] and slot3[slot2] then
		return slot4
	end

	return slot3 and slot3[slot0._backwardChainDict[slot2]]
end

function slot0.getEpisodeIdByMapCo(slot0, slot1)
	if not slot0._chapterMapList then
		return
	end

	if not slot0._chapterMapList[slot1.chapterId] then
		return
	end

	for slot7, slot8 in pairs(slot3) do
		if slot0:getChapterMapCfg(slot2, slot7) and slot9.id == slot1.id then
			for slot14, slot15 in ipairs(slot0:getChapterEpisodeCOList(slot2)) do
				if slot15.preEpisode == slot7 then
					return slot15.id
				end
			end
		end
	end
end

function slot0.getChapterMapElement(slot0, slot1)
	return lua_chapter_map_element.configDict[slot1]
end

function slot0.isDispatchElement(slot0, slot1)
	slot2 = false

	if slot1 and slot0:getChapterMapElement(slot1) then
		slot2 = slot3.type == DungeonEnum.ElementType.Dispatch
	end

	return slot2
end

function slot0.getElementDispatchId(slot0, slot1)
	slot2 = nil

	if slot0:isDispatchElement(slot1) then
		slot2 = slot0:getChapterMapElement(slot1) and slot4.param or nil
	end

	return tonumber(slot2)
end

function slot0.getHardEpisode(slot0, slot1)
	if not slot0._normalHardMap then
		slot0._normalHardMap = {}

		for slot5, slot6 in ipairs(lua_episode.configList) do
			if slot0:getChapterCO(slot6.chapterId) and slot7.type == DungeonEnum.ChapterType.Hard then
				slot0._normalHardMap[slot6.preEpisode] = slot6
			end
		end
	end

	return slot0._normalHardMap[slot1]
end

function slot0.getNormalEpisodeId(slot0, slot1)
	if slot0:getChapterCO(slot0:getEpisodeCO(slot1).chapterId).type == DungeonEnum.ChapterType.Simple then
		return slot2.normalEpisodeId
	else
		slot0:getHardEpisode(slot1)

		for slot7, slot8 in pairs(slot0._normalHardMap) do
			if slot8.id == slot1 then
				return slot7
			end
		end
	end

	return slot1
end

function slot0.getChapterCOList(slot0)
	return slot0._chapterConfig.configList
end

function slot0.getFirstChapterCO(slot0)
	return slot0:getChapterCOList()[1]
end

function slot0.getChapterCOListByType(slot0, slot1)
	if slot0._chapterListByType[slot1] then
		return slot0._chapterListByType[slot1]
	end

	slot2 = {}

	for slot6, slot7 in ipairs(slot0:getChapterCOList()) do
		if slot7.type == slot1 then
			table.insert(slot2, slot7)
		end
	end

	slot0._chapterListByType[slot1] = slot2

	return slot2
end

function slot0.getChapterIndex(slot0, slot1, slot2)
	if slot0:getChapterCOListByType(slot1) then
		for slot7, slot8 in ipairs(slot3) do
			if slot8.id == slot2 then
				if slot1 == DungeonEnum.ChapterType.Simple then
					return slot7 + 3, #slot3
				end

				return slot7, #slot3
			end
		end
	end

	return nil, 
end

function slot0.episodeSortFunction(slot0, slot1)
	if not slot0 and slot1 then
		return true
	end

	if not slot1 then
		return false
	end

	if not uv0.instance:getEpisodeCO(slot0) or not uv0.instance:getEpisodeCO(slot1) then
		return false
	end

	if (uv0.instance:getChapterCO(slot2.chapterId).type == DungeonEnum.ChapterType.Normal or slot8 == DungeonEnum.ChapterType.Hard) and (slot8 == DungeonEnum.ChapterType.Normal or slot8 == DungeonEnum.ChapterType.Hard) then
		if uv0.instance:getChapterIndex(slot8, slot4) ~= uv0.instance:getChapterIndex(uv0.instance:getChapterCO(slot3.chapterId).type, slot5) then
			return slot10 < slot11
		elseif slot8 ~= slot9 then
			return slot8 == DungeonEnum.ChapterType.Normal
		else
			slot12, slot13 = uv0.instance:getChapterEpisodeIndexWithSP(slot4, slot0)
			slot14, slot15 = uv0.instance:getChapterEpisodeIndexWithSP(slot5, slot1)

			if slot13 ~= DungeonEnum.EpisodeType.Sp and slot15 == DungeonEnum.EpisodeType.Sp then
				return true
			else
				return slot12 < slot14
			end
		end
	elseif slot8 ~= slot9 then
		return slot8 < slot9
	else
		slot10, slot11 = uv0.instance:getChapterEpisodeIndexWithSP(slot4, slot0)
		slot12, slot13 = uv0.instance:getChapterEpisodeIndexWithSP(slot5, slot1)

		if slot11 ~= DungeonEnum.EpisodeType.Sp and slot13 == DungeonEnum.EpisodeType.Sp then
			return true
		else
			return slot10 < slot12
		end
	end
end

function slot0.getChapterFrontSpNum(slot0, slot1)
	if slot0:getChapterCO(slot1) and slot2.preChapter > 0 then
		slot3 = 0 + slot0:getChapterFrontSpNum(slot2.preChapter) + slot0:getChapterSpNum(slot2.preChapter)
	end

	return slot3
end

function slot0.getChapterEpisodeIndexWithSP(slot0, slot1, slot2)
	slot6, slot7 = nil

	for slot11, slot12 in ipairs(slot0:getChapterEpisodeCOList(slot1)) do
		slot7 = slot12.type
		slot6 = slot12.type == DungeonEnum.EpisodeType.Sp and 0 + 1 or 0 + 1

		if slot12.id == slot2 then
			break
		end
	end

	if slot7 == DungeonEnum.EpisodeType.Sp then
		slot6 = slot6 + slot0:getChapterFrontSpNum(slot1)
	end

	return slot6, slot7
end

function slot0.getEpisodeIndex(slot0, slot1)
	for slot8, slot9 in ipairs(slot0:getChapterEpisodeCOList(slot0:getEpisodeCO(slot1).chapterId)) do
		slot4 = 0 + 1

		if slot9.id == slot1 then
			break
		end
	end

	return slot4
end

function slot0.getEpisodeDisplay(slot0, slot1)
	if not slot1 or slot1 == 0 then
		return nil
	end

	slot3 = slot0:getEpisodeCO(slot1) and slot0:getChapterCO(slot2.chapterId)

	if not slot2 or not slot3 then
		return nil
	end

	slot4 = slot3.chapterIndex
	slot5, slot6 = slot0:getChapterEpisodeIndexWithSP(slot3.id, slot2.id)

	if slot6 == DungeonEnum.EpisodeType.Sp then
		slot4 = "SP"
	end

	return string.format("%s-%s", slot4, slot5)
end

function slot0.getChapterCO(slot0, slot1)
	return slot0._chapterConfig.configDict[slot1]
end

function slot0.getEpisodeCO(slot0, slot1)
	if not slot0._episodeConfig.configDict[slot1] then
		logNormal("dungeon no episode:" .. tostring(slot1))
	end

	return slot2
end

function slot0.getEpisodeAdditionRule(slot0, slot1)
	slot3 = slot0:getEpisodeBattleId(slot1) and lua_battle.configDict[slot2]

	return slot3 and slot3.additionRule
end

function slot0.getBattleAdditionRule(slot0, slot1)
	slot2 = slot1 and lua_battle.configDict[slot1]

	return slot2 and slot2.additionRule
end

function slot0.getEpisodeAdvancedCondition(slot0, slot1, slot2)
	slot3 = slot2 or slot0:getEpisodeBattleId(slot1)
	slot4 = slot3 and lua_battle.configDict[slot3]

	return slot4 and slot4.advancedCondition
end

function slot0.getEpisodeAdvancedCondition2(slot0, slot1, slot2, slot3)
	slot4 = slot3 or slot0:getEpisodeBattleId(slot1)
	slot5 = slot4 and lua_battle.configDict[slot4]

	if not (slot5 and slot5.advancedCondition) then
		return slot6
	end

	return string.splitToNumber(slot6, "|")[slot2]
end

function slot0.getEpisodeCondition(slot0, slot1, slot2)
	if not lua_battle.configDict[slot2 or slot0:getEpisodeBattleId(slot1)] then
		return ""
	else
		return slot4.winCondition
	end
end

function slot0.getBattleCo(slot0, slot1, slot2)
	return lua_battle.configDict[slot2 or slot0:getEpisodeBattleId(slot1)]
end

function slot0.getEpisodeBattleId(slot0, slot1)
	if not slot0:getEpisodeCO(slot1) then
		return nil
	end

	if slot2.firstBattleId and slot3 > 0 then
		if DungeonModel.instance:getEpisodeInfo(slot1) and slot4.star <= DungeonEnum.StarType.None then
			return slot3
		end

		if HeroGroupBalanceHelper.isClickBalance() and FightModel.instance:getFightParam() and slot5.battleId == slot3 then
			return slot3
		end
	end

	if FightModel.instance:getFightParam() then
		if slot2.type == DungeonEnum.EpisodeType.WeekWalk then
			return FightModel.instance:getFightParam().battleId
		elseif slot2.type == DungeonEnum.EpisodeType.Meilanni then
			return FightModel.instance:getFightParam().battleId
		elseif slot2.type == DungeonEnum.EpisodeType.Dog then
			return FightModel.instance:getFightParam().battleId
		elseif slot2.type == DungeonEnum.EpisodeType.Jiexika then
			return FightModel.instance:getFightParam().battleId
		elseif slot2.type == DungeonEnum.EpisodeType.YaXian then
			return FightModel.instance:getFightParam().battleId
		elseif slot2.type == DungeonEnum.EpisodeType.Explore then
			return FightModel.instance:getFightParam().battleId
		elseif slot2.type == DungeonEnum.EpisodeType.Act1_3Role2Chess then
			return FightModel.instance:getFightParam().battleId
		end
	end

	return slot2.battleId
end

function slot0.getBonusCO(slot0, slot1)
	return slot0._bonusConfig.configDict[slot1]
end

function slot0.isNewReward(slot0, slot1, slot2)
	if not lua_episode.configDict[slot1] then
		return
	end

	if not lua_reward.configDict[slot3[slot2]] then
		return
	end

	return true
end

function slot0.getRewardItems(slot0, slot1)
	if not lua_reward.configDict[slot1] then
		return {}
	end

	slot0._cacheRewardResults = slot0._cacheRewardResults or {}

	if slot0._cacheRewardResults[slot1] then
		return slot0._cacheRewardResults[slot1]
	end

	slot3 = {}
	slot4 = {}

	for slot8 = 1, math.huge do
		if not slot2["rewardGroup" .. slot8] then
			break
		end

		if string.match(slot9, "^(.+):") and slot0._rewardConfigDict[slot10] then
			for slot15, slot16 in ipairs(slot11) do
				if slot16.label ~= "none" then
					slot4[slot16.materialType] = slot4[slot16.materialType] or {}

					if not slot4[slot16.materialType][slot16.materialId] then
						slot4[slot16.materialType][slot16.materialId] = true

						table.insert(slot3, {
							slot16.materialType,
							slot16.materialId,
							slot16.shownum == 1 and tonumber(slot16.count) or 0,
							tagType = DungeonEnum.RewardProbability[slot16.label]
						})
					end
				end
			end
		end
	end

	table.sort(slot3, uv0._rewardSort)

	slot0._cacheRewardResults[slot1] = slot3

	return slot3
end

function slot0._rewardSort(slot0, slot1)
	if ItemModel.instance:getItemConfig(slot0[1], slot0[2]).rare ~= ItemModel.instance:getItemConfig(slot1[1], slot1[2]).rare then
		return slot3.rare < slot2.rare
	else
		return slot3.id < slot2.id
	end
end

function slot0.getMaterialSource(slot0, slot1, slot2)
	if not slot0._materialSourceDict then
		slot0._materialSourceDict = {}

		for slot6, slot7 in ipairs(lua_episode.configList) do
			if lua_chapter.configDict[slot7.chapterId] and (slot8.type == DungeonEnum.ChapterType.Normal or slot8.type == DungeonEnum.ChapterType.Hard or slot8.type == DungeonEnum.ChapterType.Simple) and lua_reward.configDict[slot7.reward] then
				for slot14 = 1, math.huge do
					if not slot10["rewardGroup" .. slot14] then
						break
					end

					if string.match(slot15, "^(.+):") and slot0._rewardConfigDict[slot16] then
						for slot21, slot22 in ipairs(slot17) do
							if slot22.label ~= "none" then
								if not slot0._materialSourceDict[slot22.materialType] then
									slot0._materialSourceDict[slot22.materialType] = {}
								end

								if not slot0._materialSourceDict[slot22.materialType][slot22.materialId] then
									slot0._materialSourceDict[slot22.materialType][slot22.materialId] = {}
								end

								if not tabletool.indexOf(slot0._materialSourceDict[slot22.materialType][slot22.materialId], slot7.id) then
									table.insert(slot0._materialSourceDict[slot22.materialType][slot22.materialId], {
										episodeId = slot7.id,
										probability = DungeonEnum.RewardProbabilityToMaterialProbability[slot22.label]
									})
								end
							end
						end
					end
				end
			end
		end
	end

	if not slot0._materialSourceDict[slot1] then
		return
	end

	return slot0._materialSourceDict[slot1][slot2]
end

function slot0._initChapterList(slot0)
	slot0._normalChapterList = {}
	slot0._exploreChapterList = {}
	slot0._chapterUnlockMap = {}

	for slot5, slot6 in ipairs(slot0._chapterConfig.configList) do
		if slot6.type == DungeonEnum.ChapterType.Normal then
			table.insert(slot0._normalChapterList, slot6)

			slot0._chapterUnlockMap[slot6.preChapter] = slot6
		elseif slot6.type == DungeonEnum.ChapterType.Explore then
			table.insert(slot0._exploreChapterList, slot6)
		end
	end
end

function slot0.getUnlockChapterConfig(slot0, slot1)
	return slot0._chapterUnlockMap[slot1]
end

function slot0.getNormalChapterList(slot0)
	return slot0._normalChapterList
end

function slot0.getExploreChapterList(slot0)
	return slot0._exploreChapterList
end

function slot0._rebuildEpisodeConfigs(slot0)
	slot1 = {
		preEpisode2 = "preEpisode",
		normalEpisodeId = "id"
	}
	slot2 = {
		"beforeStory",
		"story",
		"afterStory"
	}

	for slot10, slot11 in ipairs(lua_episode.configList) do
		setmetatable(slot11, {
			__index = function (slot0, slot1)
				slot3 = uv1.__index(slot0, uv0[slot1] or slot1)

				if slot1 == "preEpisode" and slot3 > 0 or slot1 == "normalEpisodeId" then
					return uv2[slot3] or slot3
				end

				if tabletool.indexOf(uv3, slot1) and uv1.__index(slot0, "chainEpisode") > 0 and lua_episode.configDict[slot4] then
					return lua_episode.configDict[slot4][slot1]
				end

				return slot3
			end,
			__newindex = getmetatable(lua_episode.configList[1]).__newindex
		})

		if slot11.chainEpisode > 0 then
			-- Nothing
		end
	end

	slot0._chainEpisodeDict = {
		[slot11.chainEpisode] = slot11.id
	}
	slot0._backwardChainDict = {
		[slot11.id] = slot11.chainEpisode
	}
end

function slot0._initEpisodeList(slot0)
	slot0._unlockEpisodeList = {}
	slot0._chapterSpStats = {}
	slot0._chapterEpisodeDict = {}
	slot0._chpaterNonSpEpisodeDict = {}
	slot0._episodeElementListDict = {}
	slot0._episodeUnlockDict = {}

	for slot5, slot6 in ipairs(slot0._episodeConfig.configList) do
		if not slot0._chapterEpisodeDict[slot6.chapterId] then
			slot0._chapterEpisodeDict[slot6.chapterId] = {}
		end

		table.insert(slot7, slot6)
		slot0:_setEpisodeIndex(slot6)

		if slot6.preEpisode > 0 then
			if not string.nilorempty(slot6.elementList) then
				slot0._episodeElementListDict[slot6.preEpisode] = slot6.elementList
			end

			if slot0:getChapterCO(slot6.chapterId) and slot8.type ~= DungeonEnum.ChapterType.Hard then
				slot0._episodeUnlockDict[slot6.preEpisode] = slot6.id
			end
		end

		if slot6.unlockEpisode > 0 then
			slot8 = slot0._unlockEpisodeList[slot6.unlockEpisode] or {}
			slot0._unlockEpisodeList[slot6.unlockEpisode] = slot8

			table.insert(slot8, slot6.id)
		end

		if slot6.type == DungeonEnum.EpisodeType.Sp then
			slot0._chapterSpStats[slot6.chapterId] = (slot0._chapterSpStats[slot6.chapterId] or 0) + 1
		end

		slot0:_mapConnectEpisode(slot6)
	end
end

function slot0._initVersionActivityEpisodeList(slot0)
	slot0.versionActivityPreEpisodeDict = {}
	slot2 = nil

	for slot6, slot7 in ipairs({
		VersionActivityEnum.DungeonChapterId.LeiMiTeBei3,
		VersionActivityEnum.DungeonChapterId.LeiMiTeBei4,
		VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal2,
		VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal3,
		VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei3,
		VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei4,
		VersionActivity1_5DungeonEnum.DungeonChapterId.Story2,
		VersionActivity1_5DungeonEnum.DungeonChapterId.Story3,
		VersionActivity1_6DungeonEnum.DungeonChapterId.Story2,
		VersionActivity1_6DungeonEnum.DungeonChapterId.Story3,
		VersionActivity1_8DungeonEnum.DungeonChapterId.Story2,
		VersionActivity1_8DungeonEnum.DungeonChapterId.Story3,
		VersionActivity2_0DungeonEnum.DungeonChapterId.Story2,
		VersionActivity2_0DungeonEnum.DungeonChapterId.Story3,
		VersionActivity2_1DungeonEnum.DungeonChapterId.Story2,
		VersionActivity2_1DungeonEnum.DungeonChapterId.Story3,
		VersionActivity2_3DungeonEnum.DungeonChapterId.Story2,
		VersionActivity2_3DungeonEnum.DungeonChapterId.Story3,
		VersionActivity2_4DungeonEnum.DungeonChapterId.Story2,
		VersionActivity2_4DungeonEnum.DungeonChapterId.Story3,
		VersionActivity2_5DungeonEnum.DungeonChapterId.Story2,
		VersionActivity2_5DungeonEnum.DungeonChapterId.Story3
	}) do
		for slot11, slot12 in ipairs(slot0._chapterEpisodeDict[slot7]) do
			slot0.versionActivityPreEpisodeDict[slot12.preEpisode] = slot12
		end
	end
end

function slot0.getVersionActivityEpisodeCoByPreEpisodeId(slot0, slot1)
	if not slot0.versionActivityPreEpisodeDict then
		slot0:_initVersionActivityEpisodeList()
	end

	return slot0.versionActivityPreEpisodeDict[slot1]
end

function slot0.getVersionActivityBrotherEpisodeByEpisodeCo(slot0, slot1)
	if not ActivityConfig.instance:getActIdByChapterId(slot1.chapterId) then
		return {
			slot1
		}
	end

	slot3 = {}

	while slot1.chapterId ~= ActivityConfig.instance:getActivityDungeonConfig(slot2).story1ChapterId do
		slot1 = slot0:getEpisodeCO(slot1.preEpisode)
	end

	while slot1 do
		table.insert(slot3, slot1)

		slot1 = slot0:getVersionActivityEpisodeCoByPreEpisodeId(slot1.id)
	end

	return slot3
end

function slot0._initVersionActivityEpisodeLevelList(slot0, slot1, slot2)
	if not slot0._versionActivityEpisodeLevelList then
		slot0._versionActivityEpisodeLevelList = {}
	end

	slot3 = {}

	while slot2 ~= slot1 do
		for slot8, slot9 in ipairs(slot0:getChapterEpisodeCOList(slot2)) do
			slot3[slot9.preEpisode] = slot9.id
			slot2 = slot0:getEpisodeCO(slot9.preEpisode).chapterId
		end
	end

	for slot8, slot9 in ipairs(slot0:getChapterEpisodeCOList(slot1)) do
		slot0._versionActivityEpisodeLevelList[slot9.id] = {
			slot9.id
		}

		if slot3[slot9.id] then
			slot10 = slot9.id

			while slot3[slot10] do
				table.insert(slot0._versionActivityEpisodeLevelList[slot9.id], slot3[slot10])

				slot10 = slot3[slot10]
			end
		end
	end

	for slot8, slot9 in pairs(slot0._versionActivityEpisodeLevelList) do
		if #slot9 > 0 then
			for slot13, slot14 in ipairs(slot9) do
				if slot14 ~= slot8 then
					slot0._versionActivityEpisodeLevelList[slot14] = slot9
				end
			end
		end
	end
end

function slot0.get1_2VersionActivityEpisodeCoList(slot0, slot1)
	if slot0._versionActivityEpisodeLevelList and slot0._versionActivityEpisodeLevelList[slot1] then
		return slot0._versionActivityEpisodeLevelList[slot1]
	end

	slot0:_initVersionActivityEpisodeLevelList(VersionActivity1_2DungeonEnum.DungeonChapterId2StartChapterId[slot0:getEpisodeCO(slot1).chapterId] or slot2.chapterId, VersionActivity1_2DungeonEnum.DungeonChapterId2EndChapterId[slot2.chapterId] or slot2.chapterId)

	return slot0._versionActivityEpisodeLevelList[slot1]
end

function slot0.get1_2VersionActivityFirstLevelEpisodeId(slot0, slot1)
	if VersionActivity1_2DungeonEnum.DungeonChapterId2ViewShowId[slot0:getEpisodeCO(slot1).chapterId] then
		while VersionActivity1_2DungeonEnum.DungeonChapterId2ViewShowId[slot3] ~= slot3 do
			slot3 = uv0.instance:getEpisodeCO(slot2.preEpisode).chapterId
		end
	end

	return slot2.id
end

function slot0.getElementList(slot0, slot1)
	return slot0._episodeElementListDict[slot1] or ""
end

function slot0.getUnlockEpisodeId(slot0, slot1)
	return slot0._episodeUnlockDict[slot1]
end

function slot0.getChapterSpNum(slot0, slot1)
	return slot0._chapterSpStats[slot1] or 0
end

function slot0.getUnlockEpisodeList(slot0, slot1)
	return slot0._unlockEpisodeList[slot1]
end

function slot0.getChapterEpisodeCOList(slot0, slot1)
	if slot0._chapterEpisodeDict[slot1] and not slot2._sort then
		slot2._sort = true

		table.sort(slot2, function (slot0, slot1)
			return uv0:_getEpisodeIndex(slot0, SLFramework.FrameworkSettings.IsEditor and {}) < uv0:_getEpisodeIndex(slot1, SLFramework.FrameworkSettings.IsEditor and {})
		end)
	end

	return slot2
end

function slot0.getChapterNonSpEpisodeCOList(slot0, slot1)
	if not slot0._chpaterNonSpEpisodeDict[slot1] then
		slot0._chpaterNonSpEpisodeDict[slot1] = {}

		for slot7, slot8 in ipairs(slot0:getChapterEpisodeCOList(slot1)) do
			if slot8.type ~= DungeonEnum.EpisodeType.Sp then
				table.insert(slot2, slot8)
			end
		end
	end

	return slot2
end

function slot0.getChapterLastNonSpEpisode(slot0, slot1)
	return slot0:getChapterNonSpEpisodeCOList(slot1) and slot2[#slot2]
end

function slot0._setEpisodeIndex(slot0, slot1)
	if slot1.preEpisode > 0 then
		if slot0._episodeIndex[slot1.preEpisode] then
			slot0._episodeIndex[slot1.id] = slot2 + 1
		end
	else
		slot0._episodeIndex[slot1.id] = 0
	end
end

function slot0._getEpisodeIndex(slot0, slot1, slot2)
	if slot2 then
		slot2[slot1] = true
	end

	if slot0._episodeIndex[slot1.id] then
		return slot3
	end

	slot4 = slot0:getEpisodeCO(slot1.preEpisode)

	if slot2 and slot2[slot4] then
		logError(string.format("_getEpisodeIndex: %s前置互相依赖了", slot4.id))

		return 0
	end

	slot5 = slot0:_getEpisodeIndex(slot4, slot2) + 1
	slot0._episodeIndex[slot1.id] = slot5

	return slot5
end

function slot0.isPreChapterList(slot0, slot1, slot2)
	if slot1 == slot2 then
		return false
	end

	slot3 = slot0:getChapterCO(slot2)
	slot4 = {}

	while slot3 and slot3.preChapter ~= 0 do
		if slot3.preChapter == slot1 then
			return true
		end

		if slot4[slot3.preChapter] then
			break
		end

		slot4[slot3.preChapter] = true
		slot3 = slot0:getChapterCO(slot3.preChapter)
	end

	return false
end

function slot0.isPreEpisodeList(slot0, slot1, slot2)
	if slot1 == slot2 then
		return false
	end

	if slot1 == 0 or slot2 == 0 then
		return false
	end

	slot4 = slot0:getEpisodeCO(slot2)

	if not slot0:getEpisodeCO(slot1) or not slot4 then
		return false
	end

	if slot0:isPreChapterList(slot3.chapterId, slot4.chapterId) then
		return true
	end

	slot5 = slot4
	slot6 = {}

	while slot5 and slot5.preEpisode ~= 0 do
		if slot5.preEpisode == slot1 then
			return true
		end

		if slot6[slot5.preEpisode] then
			break
		end

		slot6[slot5.preEpisode] = true
		slot5 = slot0:getEpisodeCO(slot5.preEpisode)
	end

	return false
end

function slot0.getMonsterListFromGroupID(slot0, slot1)
	slot2 = {}
	slot3 = {}
	slot4 = {}

	for slot9, slot10 in ipairs(string.splitToNumber(slot1, "#")) do
		slot11 = lua_monster_group.configDict[slot10]

		for slot17, slot18 in ipairs(string.splitToNumber(slot11.monster, "#")) do
			if slot18 and lua_monster.configDict[slot18] and lua_monster.configDict[slot18] then
				table.insert(slot2, slot19)

				if FightHelper.isBossId(slot11.bossId, slot18) then
					table.insert(slot4, slot19)
				else
					table.insert(slot3, slot19)
				end
			end
		end
	end

	return slot2, slot3, slot4
end

function slot0.getCareersFromBattle(slot0, slot1)
	slot2 = {}
	slot3 = 0

	if lua_battle.configDict[slot1] then
		slot5 = {}
		slot6, slot7, slot8 = slot0:getMonsterListFromGroupID(slot4.monsterGroupIds)

		table.sort(slot7, function (slot0, slot1)
			return slot0.level < slot1.level
		end)
		table.sort(slot8, function (slot0, slot1)
			return slot0.level < slot1.level
		end)

		for slot12, slot13 in ipairs(slot7) do
			slot3 = slot3 + 1

			if not slot5[slot13.career] then
				slot5[slot13.career] = {}
			end

			slot5[slot13.career].score = slot3
			slot5[slot13.career].isBoss = false
		end

		for slot12, slot13 in ipairs(slot8) do
			slot3 = slot3 + 1

			if not slot5[slot13.career] then
				slot5[slot13.career] = {}
			end

			slot5[slot13.career].score = slot3
			slot5[slot13.career].isBoss = true
		end

		for slot12, slot13 in pairs(slot5) do
			table.insert(slot2, {
				career = slot12,
				score = slot13.score,
				isBoss = slot13.isBoss
			})
		end

		table.sort(slot2, function (slot0, slot1)
			return slot0.score < slot1.score
		end)
	end

	return slot2
end

function slot0.getBossMonsterIdDict(slot0, slot1)
	slot2 = {}

	if slot1 then
		slot3, slot4, slot5 = slot0:getMonsterListFromGroupID(slot1.monsterGroupIds)

		if slot5 then
			for slot9 = 1, #slot5 do
				slot2[slot5[slot9].id] = true
			end
		end
	end

	return slot2
end

function slot0.getBattleDisplayMonsterIds(slot0, slot1)
	slot2 = {}
	slot3 = {}

	for slot8 = #string.splitToNumber(slot1.monsterGroupIds, "#"), 1, -1 do
		slot10 = lua_monster_group.configDict[slot4[slot8]]
		slot13 = 100
		slot14 = {}

		for slot18, slot19 in ipairs(string.splitToNumber(slot10.monster, "#")) do
			if FightHelper.isBossId(slot10.bossId, slot19) then
				slot13 = slot18
			end
		end

		for slot18, slot19 in ipairs(slot11) do
			if slot19 and lua_monster.configDict[slot19] then
				table.insert(slot14, {
					id = slot19,
					distance = math.abs(slot18 - slot13)
				})
			end
		end

		table.sort(slot14, function (slot0, slot1)
			return slot0.distance < slot1.distance
		end)

		for slot18, slot19 in ipairs(slot14) do
			if not slot3[slot19.id] then
				slot3[slot19.id] = true

				table.insert(slot2, slot19.id)
			end
		end
	end

	for slot8, slot9 in ipairs(slot4) do
		for slot16, slot17 in ipairs(string.nilorempty(lua_monster_group.configDict[slot9].spMonster) and {} or string.split(slot10.spMonster, "#")) do
			if not slot3[slot17] then
				slot3[slot17] = true

				table.insert(slot2, tonumber(slot17))
			end
		end
	end

	return slot2
end

function slot0.getNormalChapterId(slot0, slot1)
	if slot0:getChapterCO(slot0:getEpisodeCO(slot1).chapterId).type == DungeonEnum.ChapterType.Hard then
		slot3 = slot0:getChapterCO(slot0:getEpisodeCO(slot2.preEpisode).chapterId)
	end

	return slot3.id
end

function slot0.getChapterTypeByEpisodeId(slot0, slot1)
	return slot0:getChapterCO(slot0:getEpisodeCO(slot1).chapterId).type
end

function slot0.getFirstEpisodeWinConditionText(slot0, slot1, slot2)
	if string.nilorempty(slot0:getEpisodeCondition(slot1, slot2)) then
		return ""
	end

	return slot0:getWinConditionText(GameUtil.splitString2(slot3, false, "|", "#")[1]) or "winCondition error:" .. slot3
end

function slot0.getEpisodeWinConditionTextList(slot0, slot1)
	if string.nilorempty(slot0:getEpisodeCondition(slot1)) then
		return {
			""
		}
	end

	slot3 = {}
	slot8 = "#"

	for slot8, slot9 in ipairs(GameUtil.splitString2(slot2, false, "|", slot8)) do
		table.insert(slot3, slot0:getWinConditionText(slot9) or "winCondition error:" .. slot2)
	end

	return slot3
end

function slot0.getWinConditionText(slot0, slot1)
	if not slot1 then
		return nil
	end

	if tonumber(slot1[1]) == 1 or slot2 == 10 then
		return luaLang("dungeon_beat_all")
	elseif slot2 == 2 then
		if lua_monster.configDict[tonumber(slot1[2])] then
			return formatLuaLang("dungeon_win_protect", string.format("<color=#ff0000>%s</color>", slot4.name))
		end
	elseif slot2 == 3 or slot2 == 9 then
		slot4 = {}

		for slot8, slot9 in ipairs(string.split(slot1[2], "&")) do
			if lua_monster.configDict[tonumber(slot9)] then
				table.insert(slot4, string.format("<color=#ff0000>%s</color>", FightConfig.instance:getNewMonsterConfig(slot11) and slot11.highPriorityName or slot11.name))
			end
		end

		if #slot4 > 0 then
			return formatLuaLang("dungeon_win_3", table.concat(slot4, luaLang("else")))
		end
	elseif slot2 == 4 then
		-- Nothing
	elseif slot2 == 5 then
		if lua_monster.configDict[tonumber(slot1[2])] then
			return GameUtil.getSubPlaceholderLuaLang(luaLang("dungeon_win_5"), {
				string.format("<color=#ff0000>%s</color>", slot4.name),
				tonumber(slot1[3]) / 10 .. "%"
			})
		end
	elseif slot2 == 6 then
		return formatLuaLang("dungeon_win_6", slot1[2])
	elseif slot2 == 7 then
		return luaLang("dungeon_beat_all_without_die")
	elseif slot2 == 8 then
		return formatLuaLang("dungeon_win_8", slot1[3])
	elseif slot2 == 13 and lua_monster.configDict[tonumber(slot1[2])] then
		return formatLuaLang("fight_charge_monster_energy", slot4.name)
	end

	return nil
end

function slot0.getEpisodeAdvancedConditionText(slot0, slot1, slot2)
	if LuaUtil.isEmptyStr(slot0:getEpisodeAdvancedCondition(slot1, slot2)) == false then
		return lua_condition.configDict[string.splitToNumber(slot3, "|")[1]].desc
	else
		return ""
	end
end

function slot0.getEpisodeAdvancedCondition2Text(slot0, slot1, slot2)
	if LuaUtil.isEmptyStr(slot0:getEpisodeAdvancedCondition(slot1, slot2)) == false then
		if not string.splitToNumber(slot3, "|")[2] then
			return ""
		end

		return lua_condition.configDict[slot5].desc
	else
		return ""
	end
end

function slot0.getEpisodeFailedReturnCost(slot0, slot1, slot2)
	slot2 = slot2 or 1

	if not slot0:getEpisodeCO(slot1) then
		return 0
	end

	if string.split(slot3.cost, "#")[2] == string.split(slot3.failCost, "#")[2] and slot4[3] and slot5[3] then
		return slot2 * slot4[3] - slot5[3]
	else
		return 0
	end
end

function slot0.getEndBattleCost(slot0, slot1, slot2)
	if not slot0:getEpisodeCO(slot1) then
		return 0
	end

	if slot2 then
		return string.split(slot3.failCost, "#")[3]
	else
		return string.split(slot3.cost, "#")[3]
	end
end

function slot0.getDungeonEveryDayCount(slot0, slot1)
	slot4 = 0

	for slot8, slot9 in ipairs(GameUtil.splitString2(CommonConfig.instance:getConstStr(ConstEnum.DungeonMaxCount), true, "|", "#")) do
		if slot9[1] == slot1 then
			slot4 = slot9[2]

			break
		end
	end

	return slot4
end

function slot0.getDungeonEveryDayItem(slot0, slot1)
	slot4 = 0

	for slot8, slot9 in ipairs(GameUtil.splitString2(CommonConfig.instance:getConstStr(ConstEnum.DungeonItem), true, "|", "#")) do
		if slot9[1] == slot1 then
			slot4 = slot9[2]

			break
		end
	end

	return slot4
end

function slot0.getPuzzleQuestionCo(slot0, slot1)
	return lua_chapter_puzzle_question.configDict[slot1]
end

function slot0._initPuzzleSquare(slot0, slot1)
	slot0._puzzle_square_data = {}

	for slot5, slot6 in pairs(slot1.configDict) do
		if not slot0._puzzle_square_data[slot6.group] then
			slot0._puzzle_square_data[slot6.group] = {}
		end

		table.insert(slot0._puzzle_square_data[slot6.group], slot6)
	end
end

function slot0.getPuzzleSquareDebrisGroupList(slot0, slot1)
	return slot0._puzzle_square_data[slot1]
end

function slot0.getPuzzleSquareData(slot0, slot1)
	return lua_chapter_puzzle_square.configDict[slot1]
end

function slot0.getDecryptCo(slot0, slot1)
	return slot0._decryptConfig.configDict[slot1]
end

function slot0.getDecryptChangeColorCo(slot0, slot1)
	return slot0._lvConfig.configDict[slot1]
end

function slot0.getDecryptChangeColorInteractCos(slot0)
	return slot0._interactConfig.configDict
end

function slot0.getDecryptChangeColorInteractCo(slot0, slot1)
	return slot0._interactConfig.configDict[slot1]
end

function slot0.getDecryptChangeColorColorCos(slot0)
	return slot0._colorConfig.configDict
end

function slot0.getDecryptChangeColorColorCo(slot0, slot1)
	return slot0._colorConfig.configDict[slot1]
end

function slot0.isLeiMiTeBeiChapterType(slot0, slot1)
	if not slot1 then
		return false
	end

	return slot1.chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBei or slot1.chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBeiHard or slot1.chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBei3 or slot1.chapterId == VersionActivityEnum.DungeonChapterId.LeiMiTeBei4 or slot1.chapterId == VersionActivityEnum.DungeonChapterId.ElementFight
end

function slot0.getElementFightEpisodeToNormalEpisodeId(slot0, slot1)
	for slot5, slot6 in ipairs(lua_chapter_map_element.configList) do
		if slot6.type == 2 and slot6.param == tostring(slot1.id) then
			for slot12, slot13 in pairs(slot0._chapterMapList[VersionActivityEnum.DungeonChapterId.LeiMiTeBei]) do
				if slot13.id == slot6.mapId then
					for slot18, slot19 in ipairs(uv0.instance:getChapterEpisodeCOList(VersionActivityEnum.DungeonChapterId.LeiMiTeBei)) do
						if slot19.preEpisode == slot12 then
							return slot19.id
						end
					end
				end
			end
		end
	end

	return nil
end

function slot0.getActivityElementFightEpisodeToNormalEpisodeId(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(lua_chapter_map_element.configList) do
		if slot7.type == 2 and tonumber(slot7.param) == slot1.id then
			for slot13, slot14 in pairs(slot0._chapterMapList[slot2]) do
				if slot14.id == slot7.mapId then
					for slot19, slot20 in ipairs(uv0.instance:getChapterEpisodeCOList(slot2)) do
						if slot20.preEpisode == slot13 then
							return slot20.id
						end
					end
				end
			end
		end
	end

	return nil
end

function slot0.isActivity1_2Map(slot0, slot1)
	if uv0.instance:getEpisodeCO(slot1) and lua_chapter.configDict[slot2.chapterId] and (slot4.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal1 or slot4.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal2 or slot4.type == DungeonEnum.ChapterType.Activity1_2DungeonNormal3 or slot4.type == DungeonEnum.ChapterType.Activity1_2DungeonHard) then
		return true
	end
end

function slot0.getEpisodeLevelIndex(slot0, slot1)
	if not slot1 then
		return 0
	end

	return slot0:getEpisodeLevelIndexByEpisodeId(slot1.id)
end

function slot0.getEpisodeLevelIndexByEpisodeId(slot0, slot1)
	if not slot1 or type(slot1) ~= "number" then
		return 0
	end

	return slot1 % 100
end

function slot0.getExtendStory(slot0, slot1)
	if not slot0._episodeExtendStoryDict then
		slot0._episodeExtendStoryDict = {}

		if lua_const.configDict[ConstEnum.EpisodeExtendStory] and not string.nilorempty(slot2.value) then
			for slot7, slot8 in ipairs(GameUtil.splitString2(slot2.value, true)) do
				slot0._episodeExtendStoryDict[slot8[1]] = {
					slot8[2],
					slot8[3]
				}
			end
		end
	end

	if not slot0._episodeExtendStoryDict[slot1] then
		return nil
	end

	slot2, slot3 = unpack(slot0._episodeExtendStoryDict[slot1])

	if not slot2 or not DungeonMapModel.instance:elementIsFinished(slot2) then
		return nil
	end

	return slot3
end

function slot0.getSimpleEpisode(slot0, slot1)
	if slot1.chainEpisode ~= 0 then
		return slot0:getEpisodeCO(slot2)
	end
end

function slot0.getVersionActivityDungeonNormalEpisode(slot0, slot1, slot2, slot3)
	if slot0:getEpisodeCO(slot1).chapterId == slot2 then
		slot4 = slot0:getEpisodeCO(slot1 - 10000)
	else
		while slot4.chapterId ~= slot3 do
			slot4 = slot0:getEpisodeCO(slot4.preEpisode)
		end
	end

	return slot4
end

function slot0.getEpisodeByElement(slot0, slot1)
	if not lua_chapter_map_element.configDict[slot1] then
		return
	end

	return slot0:getEpisodeIdByMapCo(lua_chapter_map.configDict[slot2.mapId])
end

function slot0.getRewardGroupCOList(slot0, slot1)
	return slot0._rewardConfigDict[slot1]
end

function slot0.calcRewardGroupRateInfoList(slot0, slot1)
	slot2 = {}

	slot0:_calcRewardGroupRateInfoList(slot2, slot1)

	return slot2
end

function slot0._calcRewardGroupRateInfoList(slot0, slot1, slot2)
	if not slot0:getRewardGroupCOList(slot2) or #slot3 == 0 then
		return
	end

	slot5 = #slot1

	for slot9, slot10 in ipairs(slot3) do
		slot11 = tonumber(slot10.count) or 0
		slot4 = 0 + slot11

		table.insert(slot1, {
			weight = slot11,
			materialType = slot10.materialType,
			materialId = slot10.materialId
		})
	end

	for slot10 = slot5 + 1, #slot1 do
		slot11 = slot1[slot10]
		slot11.rate = slot4 == 0 and 0 or slot11.weight / slot4
	end
end

slot0.instance = slot0.New()

return slot0
