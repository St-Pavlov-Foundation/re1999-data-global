slot0 = class("Season123Config", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"activity123_const",
		"activity123_stage",
		"activity123_episode",
		"task_activity123",
		"activity123_equip",
		"activity123_equip_attr",
		"activity123_equip_tag",
		"activity123_story",
		"activity123_retail",
		"activity123_trial"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "activity123_const" then
		slot0._constConfig = slot2
	elseif slot1 == "activity123_stage" then
		slot0._stageConfig = slot2
		slot0._actId2StageList = {}
	elseif slot1 == "activity123_episode" then
		slot0._episodeConfig = slot2
	elseif slot1 == "activity123_equip" then
		slot0._equipConfig = slot2

		slot0:preprocessEquip()
	elseif slot1 == "activity123_equip_attr" then
		slot0._equipAttrConfig = slot2
	elseif slot1 == "activity123_equip_tag" then
		slot0._equipTagConfig = slot2
	elseif slot1 == "activity123_story" then
		slot0._storyConfig = slot2
	elseif slot1 == "task_activity123" then
		slot0._taskConfig = slot2
	elseif slot1 == "activity123_retail" then
		slot0._retailConfig = slot2
	elseif slot1 == "activity123_trial" then
		slot0._trialConfig = slot2
	end
end

function slot0.preprocessEquip(slot0)
	slot0._equipIsOptionalDict = {}

	for slot4, slot5 in pairs(slot0._equipConfig.configList) do
		if slot5.isOptional == 1 then
			slot0._equipIsOptionalDict[slot5.equipId] = true
		end
	end
end

function slot0.getStageCos(slot0, slot1)
	if not slot0._actId2StageList[slot1] then
		slot0._actId2StageList[slot1] = {}

		if slot0._stageConfig.configDict[slot1] then
			for slot7, slot8 in pairs(slot3) do
				table.insert(slot2, slot8)
			end

			table.sort(slot2, function (slot0, slot1)
				return slot0.stage < slot1.stage
			end)
		end
	end

	return slot2
end

function slot0.getStageCo(slot0, slot1, slot2)
	return slot0._stageConfig.configDict[slot1] and slot0._stageConfig.configDict[slot1][slot2]
end

function slot0.getSeasonEpisodeStageCos(slot0, slot1, slot2)
	return slot0._episodeConfig.configDict[slot1] and slot0._episodeConfig.configDict[slot1][slot2]
end

function slot0.getSeasonEpisodeCo(slot0, slot1, slot2, slot3)
	if slot0._episodeConfig.configDict[slot1] and slot0._episodeConfig.configDict[slot1][slot2] then
		return slot0._episodeConfig.configDict[slot1][slot2][slot3]
	end
end

function slot0.getAllSeasonEpisodeCO(slot0, slot1)
	if not slot0._allEpisodeCOList or not slot0._allEpisodeCOList[slot1] then
		slot0._allEpisodeCOList = slot0._allEpisodeCOList or {}
		slot2 = {}

		if slot0._episodeConfig.configDict[slot1] then
			for slot6, slot7 in pairs(slot0._episodeConfig.configDict[slot1]) do
				for slot11, slot12 in pairs(slot7) do
					table.insert(slot2, slot12)
				end
			end

			table.sort(slot2, function (slot0, slot1)
				if slot0.stage ~= slot1.stage then
					return slot0.stage < slot1.stage
				else
					return slot0.layer < slot1.layer
				end
			end)
		end

		slot0._allEpisodeCOList[slot1] = slot2
	end

	return slot0._allEpisodeCOList[slot1]
end

function slot0.getSeasonEpisodeByStage(slot0, slot1, slot2)
	slot3 = {}

	if slot0:getSeasonEpisodeStageCos(slot1, slot2) then
		for slot8, slot9 in pairs(slot4) do
			if slot2 == slot9.stage then
				table.insert(slot3, slot9)
			end
		end

		table.sort(slot3, function (slot0, slot1)
			return slot0.layer < slot1.layer
		end)
	else
		logNormal(string.format("cfgList is nil, actId = %s, stage = %s", slot1, slot2))
	end

	return slot3
end

function slot0.getSeasonConstCo(slot0, slot1)
	return slot0._constConfig.configDict[slot1]
end

function slot0.getSeasonEquipCos(slot0)
	return slot0._equipConfig.configDict
end

function slot0.getSeasonEquipCo(slot0, slot1)
	return slot0._equipConfig.configDict[slot1]
end

function slot0.getSeasonOptionalEquipCos(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0._equipConfig.configDict) do
		if slot6.isOptional == 1 then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.getSeasonTagList(slot0)
	return slot0._equipTagConfig.configList
end

function slot0.getSeasonTagDesc(slot0, slot1)
	return slot0._equipTagConfig.configDict[slot1]
end

function slot0.getEquipIsOptional(slot0, slot1)
	return slot0._equipIsOptionalDict[slot1]
end

function slot0.getEquipCoByCondition(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot0._equipConfig.configList) do
		if slot1(slot7) then
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.getSeasonEquipAttrCo(slot0, slot1)
	return slot0._equipAttrConfig.configDict[slot1]
end

function slot0.getConfigByEpisodeId(slot0, slot1)
	slot0:_initEpisodeId2Config()

	return slot0._episodeId2Config and slot0._episodeId2Config[slot1]
end

function slot0.getRetailCOByEpisodeId(slot0, slot1)
	slot0:_initEpisodeId2RetailCO()

	return slot0._episodeId2RetailCO and slot0._episodeId2RetailCO[slot1]
end

function slot0.getTrailCOByEpisodeId(slot0, slot1)
	slot0:_initEpisodeId2TrailCO()

	return slot0._episodeId2TrailCO and slot0._episodeId2TrailCO[slot1]
end

function slot0._initEpisodeId2Config(slot0)
	if slot0._episodeId2Config then
		return
	end

	slot0._episodeId2Config = {}

	for slot4, slot5 in pairs(slot0._episodeConfig.configDict) do
		for slot9, slot10 in pairs(slot5) do
			for slot14, slot15 in pairs(slot10) do
				slot0._episodeId2Config[slot15.episodeId] = slot15
			end
		end
	end
end

function slot0._initEpisodeId2RetailCO(slot0)
	if slot0._episodeId2RetailCO then
		return
	end

	slot0._episodeId2RetailCO = {}

	for slot4, slot5 in pairs(slot0._retailConfig.configDict) do
		for slot9, slot10 in pairs(slot5) do
			slot0._episodeId2RetailCO[slot10.episodeId] = slot10
		end
	end
end

function slot0._initEpisodeId2TrailCO(slot0)
	if slot0._episodeId2TrailCO then
		return
	end

	slot0._episodeId2TrailCO = {}

	for slot4, slot5 in pairs(slot0._trialConfig.configDict) do
		for slot9, slot10 in pairs(slot5) do
			slot0._episodeId2TrailCO[slot10.episodeId] = slot10
		end
	end
end

function slot0.getEquipItemCoin(slot0, slot1, slot2)
	return slot0:getSeasonConstNum(slot1, slot2)
end

function slot0.getSeasonConstNum(slot0, slot1, slot2)
	if not slot0._constConfig.configDict[slot1] or not slot0._constConfig.configDict[slot1][slot2] then
		return nil
	end

	return slot0._constConfig.configDict[slot1][slot2].value1
end

function slot0.getSeasonConstStr(slot0, slot1, slot2)
	if not slot0._constConfig.configDict[slot1] or not slot0._constConfig.configDict[slot1][slot2] then
		return nil
	end

	return slot0._constConfig.configDict[slot1][slot2].value2
end

function slot0.getAllStoryCo(slot0, slot1)
	return slot0._storyConfig.configDict[slot1]
end

function slot0.getStoryConfig(slot0, slot1, slot2)
	return slot0._storyConfig.configDict[slot1][slot2]
end

function slot0.getSeason123TaskCo(slot0, slot1)
	return slot0._taskConfig.configDict[slot1]
end

function slot0.getSeason123AllTaskList(slot0)
	return slot0._taskConfig.configList
end

function slot0.getRetailCO(slot0, slot1, slot2)
	if slot0._retailConfig.configDict[slot1] then
		return slot0._retailConfig.configDict[slot1][slot2]
	end
end

function slot0.getRecommendCareers(slot0, slot1, slot2)
	if slot0:getStageCo(slot1, slot2) and not string.nilorempty(slot3.recommend) then
		return string.split(slot3.recommend, "#")
	end
end

function slot0.getRecommendTagCoList(slot0, slot1, slot2)
	slot4 = {}

	if slot0:getStageCo(slot1, slot2) and not string.nilorempty(slot3.recommendSchool) then
		slot6 = slot0:getSeasonTagDesc(slot1)

		for slot10, slot11 in ipairs(string.splitToNumber(slot3.recommendSchool, "#")) do
			if slot6[slot11] then
				table.insert(slot4, slot6[slot11])
			end
		end
	end

	return slot4
end

function slot0.filterRule(slot0, slot1, slot2)
	slot3 = {}

	if slot1 then
		if not Season123Model.instance:getCurSeasonId() then
			return
		end

		for slot8, slot9 in pairs(slot1) do
			if not slot0:isExistInRuleTips(slot4, slot2, slot9[2]) then
				table.insert(slot3, slot9)
			end
		end
	end

	return slot3
end

function slot0.isExistInRuleTips(slot0, slot1, slot2, slot3)
	if not slot0.ruleDict then
		slot0.ruleDict = {}
	end

	slot0.ruleDict[slot1] = slot0.ruleDict[slot1] or {}

	if not slot0.ruleDict[slot1][slot2] then
		slot0.ruleDict[slot1][slot2] = slot0:getRuleTips(slot1, slot2)
	end

	return slot0.ruleDict[slot1][slot2][slot3] ~= nil
end

function slot0.getRuleTips(slot0, slot1, slot2)
	slot4 = slot0:getStageCos(slot1)[slot2]
	slot5 = {}

	if slot2 then
		if not slot4 then
			slot0.emptyTips = slot0.emptyTips or {}

			return slot0.emptyTips
		end

		slot5 = string.splitToNumber(slot4.stageCondition, "#")
	else
		slot5 = string.splitToNumber(slot0:getSeasonConstStr(slot1, Activity123Enum.Const.HideRule), "#")
	end

	for slot10, slot11 in ipairs(slot5) do
		-- Nothing
	end

	return {
		[slot11] = true
	}
end

function slot0.getTrialCO(slot0, slot1, slot2)
	if slot0._trialConfig.configDict[slot1] then
		return slot3[slot2]
	end

	return nil
end

function slot0.getTaskListenerParamCache(slot0, slot1)
	slot0.taskListenerParamCache = slot0.taskListenerParamCache or {}

	if not slot0.taskListenerParamCache[slot1] then
		slot0.taskListenerParamCache[slot1] = string.split(slot1.listenerParam, "#")
	end

	return slot2
end

function slot0.getRewardTaskCount(slot0, slot1, slot2)
	slot0:checkInitRewardTaskCount()

	if slot0._taskCountDict[slot1] then
		return slot0._taskCountDict[slot1][slot2] or 0
	end

	return 0
end

function slot0.checkInitRewardTaskCount(slot0)
	if not slot0._taskCountDict then
		slot0._taskCountDict = {}

		for slot5, slot6 in ipairs(slot0:getSeason123AllTaskList()) do
			if slot6.isRewardView == 1 then
				slot0._taskCountDict[slot6.seasonId] = slot0._taskCountDict[slot6.seasonId] or {}

				if #slot0:getTaskListenerParamCache(slot6) > 0 then
					slot0._taskCountDict[slot6.seasonId][slot8] = (slot0._taskCountDict[slot6.seasonId][tonumber(slot7[1])] or 0) + 1
				end
			end
		end
	end
end

function slot0.getCardLimitPosDict(slot0, slot1)
	if not slot0:getSeasonEquipCo(slot1) or string.nilorempty(slot2.indexLimit) then
		return nil
	else
		slot0._indexLimitDict = slot0._indexLimitDict or {}
		slot0._indexLimitStrDict = slot0._indexLimitStrDict or {}
		slot4 = slot0._indexLimitStrDict[slot1]

		if not slot0._indexLimitDict[slot1] then
			slot4 = ""

			for slot9, slot10 in ipairs(string.splitToNumber(slot2.indexLimit, "#")) do
				slot4 = not string.nilorempty(slot4) and slot4 .. "," .. tostring(slot10) or tostring(slot10)
			end

			slot0._indexLimitDict[slot1] = {
				[slot10] = true
			}
			slot0._indexLimitStrDict[slot1] = slot4
		end

		return slot3, slot4
	end
end

function slot0.isLastStage(slot0, slot1, slot2)
	return slot2 == tabletool.len(slot0._stageConfig.configDict[slot1])
end

function slot0.getCardSpecialEffectCache(slot0, slot1)
	slot0.cardEffectCache = slot0.cardEffectCache or {}

	if not slot0.cardEffectCache[slot1] then
		slot2 = {}
		slot5 = {}

		for slot9, slot10 in ipairs(GameUtil.splitString2(slot0:getSeasonEquipCo(slot1).specialEffect, true) or {}) do
			slot11 = slot10[1]

			for slot15 = 2, #slot10 do
				table.insert(slot5, slot10[slot15])
			end

			slot2[slot11] = slot5
		end

		slot0.cardEffectCache[slot1] = slot2
	end

	return slot2
end

function slot0.getCardSpecialEffectMap(slot0, slot1)
	slot3 = {}

	if slot0:getSeasonEquipCo(slot1) then
		return slot0:getCardSpecialEffectCache(slot2.equipId) or {}
	end
end

slot0.instance = slot0.New()

return slot0
