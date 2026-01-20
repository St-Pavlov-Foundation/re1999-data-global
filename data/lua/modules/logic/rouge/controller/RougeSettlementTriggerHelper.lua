-- chunkname: @modules/logic/rouge/controller/RougeSettlementTriggerHelper.lua

module("modules.logic.rouge.controller.RougeSettlementTriggerHelper", package.seeall)

local RougeSettlementTriggerHelper = class("RougeSettlementTriggerHelper")

function RougeSettlementTriggerHelper.isResultTrigger(triggerType, ...)
	local func = RougeSettlementTriggerHelper["triggerType" .. triggerType]

	if not func then
		logError("未处理当前触发类型, 触发类型 = " .. tostring(triggerType))

		return
	end

	return func(...)
end

function RougeSettlementTriggerHelper.triggerType1(collectionCount)
	local resultInfo = RougeModel.instance:getRougeResult()
	local reviewInfo = resultInfo and resultInfo.reviewInfo
	local allCollectionCount = reviewInfo and reviewInfo.collectionNum or 0

	collectionCount = collectionCount or 0

	if collectionCount <= allCollectionCount then
		local rareMap = RougeCollectionModel.instance:getCollectionRareMap()
		local rareCfgList = lua_rouge_quality.configList
		local result = {}

		if rareCfgList then
			for _, rareCfg in ipairs(rareCfgList) do
				local rareName = rareCfg.name
				local rareId = rareCfg.id
				local rareCount = rareMap[rareId] and tabletool.len(rareMap[rareId]) or 0

				table.insert(result, rareCount)
				table.insert(result, rareName)
			end
		end

		return unpack(result)
	end
end

function RougeSettlementTriggerHelper.triggerType2(tagCount)
	local allCollections = RougeCollectionModel.instance:getAllCollections()
	local tagMap = {}

	if allCollections then
		for _, collection in ipairs(allCollections) do
			RougeSettlementTriggerHelper.computeTagCount(collection, tagMap)
		end
	end

	local maxTagId, maxTypeTagCount = 0, -10000

	for tagId, tagCount in pairs(tagMap) do
		if maxTypeTagCount < tagCount then
			maxTagId = tagId
			tagCount = maxTypeTagCount
		end
	end

	local tagCfg = lua_rouge_tag.configDict[maxTagId]
	local tagName = tagCfg and tagCfg.name

	if tagCount <= maxTypeTagCount then
		return maxTypeTagCount, tagName
	end
end

function RougeSettlementTriggerHelper.computeTagCount(collection, tagMap)
	if not collection then
		return 0
	end

	RougeSettlementTriggerHelper.computeTypeTagCount(collection.cfgId, tagMap)

	local enchantCfgs = collection:getAllEnchantCfgId()

	if enchantCfgs then
		for _, cfgId in pairs(enchantCfgs) do
			if cfgId and cfgId > 0 then
				RougeSettlementTriggerHelper.computeTypeTagCount(cfgId, tagMap)
			end
		end
	end
end

function RougeSettlementTriggerHelper.computeTypeTagCount(collectionCfgId, tagMap)
	local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(collectionCfgId)
	local tags = collectionCfg and collectionCfg.tags

	if tags then
		for _, tagId in pairs(tags) do
			local tagCount = tagMap[tagId] or 0

			tagCount = tagCount + 1
			tagMap[tagId] = tagCount
		end
	end
end

function RougeSettlementTriggerHelper.triggerType3(compositeCount)
	local resultInfo = RougeModel.instance:getRougeResult()
	local hasCompositeCount = resultInfo and resultInfo.compositeCount or 0
	local compositeInfos = resultInfo:getCompositeCollectionIdAndCount()
	local composteIds = {}

	if compositeInfos then
		for _, compositeInfo in ipairs(compositeInfos) do
			local compositeId = compositeInfo[1]
			local collectionCfg = RougeCollectionConfig.instance:getCollectionCfg(compositeId)
			local composteName = collectionCfg and collectionCfg.name

			table.insert(composteIds, composteName)
		end
	end

	if compositeCount <= hasCompositeCount then
		local str = table.concat(composteIds, luaLang("room_levelup_init_and1"))

		return str
	end
end

function RougeSettlementTriggerHelper.triggerType4(count)
	local slotCollections = RougeCollectionModel.instance:getSlotAreaCollection()
	local hasEnchantCount = 0

	if slotCollections then
		for _, collection in pairs(slotCollections) do
			local enchantCount = collection:getEnchantCount()

			if enchantCount and enchantCount > 0 then
				hasEnchantCount = hasEnchantCount + 1
			end
		end
	end

	if count <= hasEnchantCount then
		return hasEnchantCount
	end
end

function RougeSettlementTriggerHelper.triggerType5(count)
	local resultInfo = RougeModel.instance:getRougeResult()
	local totalFightCount = 0

	if resultInfo then
		totalFightCount = resultInfo:getTotalFightCount()
	end

	if count <= totalFightCount then
		return totalFightCount
	end
end

function RougeSettlementTriggerHelper.triggerType6(count)
	local resultInfo = RougeModel.instance:getRougeResult()
	local costPower = resultInfo and resultInfo.costPower or 0

	if count <= costPower then
		return costPower
	end
end

function RougeSettlementTriggerHelper.triggerType7(value)
	local resultInfo = RougeModel.instance:getRougeResult()
	local maxDamage = resultInfo and resultInfo.maxDamage or 0

	if value <= maxDamage then
		return maxDamage
	end
end

function RougeSettlementTriggerHelper.triggerType8(eventId)
	local resultInfo = RougeModel.instance:getRougeResult()
	local isEventFinish = false

	if resultInfo then
		isEventFinish = resultInfo:isEventFinish(eventId)
	end

	if isEventFinish then
		local eventCfg = RougeMapConfig.instance:getRougeEvent(eventId)
		local eventName = eventCfg and eventCfg.name

		return eventName
	end
end

function RougeSettlementTriggerHelper.triggerType9(entrustId)
	local resultInfo = RougeModel.instance:getRougeResult()
	local isEntrustFinish = false

	if resultInfo then
		isEntrustFinish = resultInfo:isEntrustFinish(entrustId)
	end

	if isEntrustFinish then
		return entrustId
	end
end

function RougeSettlementTriggerHelper.triggerType10(count)
	local resultInfo = RougeModel.instance:getRougeResult()
	local consumeCoin = resultInfo and resultInfo.consumeCoin or 0

	if count <= consumeCoin then
		return consumeCoin
	end
end

function RougeSettlementTriggerHelper.triggerType11(count)
	local resultInfo = RougeModel.instance:getRougeResult()
	local displaceNum = resultInfo and resultInfo.displaceNum or 0

	if count <= displaceNum then
		return displaceNum
	end
end

function RougeSettlementTriggerHelper.triggerType12(count)
	local resultInfo = RougeModel.instance:getRougeResult()
	local repairShopNum = resultInfo and resultInfo.repairShopNum or 0

	if count <= repairShopNum then
		return repairShopNum
	end
end

function RougeSettlementTriggerHelper.triggerType13(endId)
	local resultInfo = RougeModel.instance:getRougeResult()
	local reviewInfo = resultInfo and resultInfo.reviewInfo
	local finishEndId = reviewInfo and reviewInfo.endId

	if finishEndId == endId then
		return finishEndId
	end
end

function RougeSettlementTriggerHelper.triggerType14(endId)
	local failEndId = RougeMapModel.instance:getEndId()
	local resultInfo = RougeModel.instance:getRougeResult()
	local isSucc = resultInfo:isSucceed()

	if not isSucc and failEndId == endId then
		return failEndId
	end
end

function RougeSettlementTriggerHelper.triggerType15()
	local isAbort = RougeModel.instance:isAbortRouge()

	if isAbort then
		return
	end

	local resultInfo = RougeModel.instance:getRougeResult()
	local failEndId = RougeMapModel.instance:getEndId()
	local isSucc = resultInfo:isSucceed()
	local isNormalFight = not isSucc and (not failEndId or failEndId <= 0)
	local eventCo = RougeMapModel.instance:getCurEvent()

	if not eventCo then
		return
	end

	local eventName = eventCo.name

	if isNormalFight then
		return eventName
	end
end

function RougeSettlementTriggerHelper.triggerType16()
	local isAbort = RougeModel.instance:isAbortRouge()

	if isAbort then
		return "abort"
	end
end

function RougeSettlementTriggerHelper.triggerType17()
	local rougeInfo = RougeModel.instance:getRougeInfo()
	local resultInfo = RougeModel.instance:getRougeResult()
	local season = resultInfo and resultInfo.season
	local difficultyCfg = lua_rouge_difficulty.configDict[season][rougeInfo.difficulty]
	local difficultyTitle = difficultyCfg and difficultyCfg.title
	local styleCfg = RougeController.instance:getStyleConfig()
	local styleName = styleCfg and styleCfg.name
	local initHeroNames = RougeSettlementTriggerHelper.getAllInitHeroNames(resultInfo.initHeroId)

	return difficultyTitle, styleName, initHeroNames
end

function RougeSettlementTriggerHelper.getAllInitHeroNames(initHeroId)
	local heroNameList = {}

	if initHeroId then
		for _, heroId in ipairs(initHeroId) do
			local heroCfg = HeroConfig.instance:getHeroCO(heroId)
			local heroName = heroCfg and heroCfg.name

			if heroName then
				table.insert(heroNameList, heroName)
			end
		end
	end

	local heroNameStr = table.concat(heroNameList, luaLang("room_levelup_init_and1"))

	return heroNameStr
end

function RougeSettlementTriggerHelper.triggerType18()
	local resultInfo = RougeModel.instance:getRougeResult()
	local reviewInfo = resultInfo and resultInfo.reviewInfo
	local teamInfo = reviewInfo and reviewInfo:getTeamInfo()
	local heroCount = teamInfo and teamInfo:getAllHeroCount() or 0
	local rougeInfo = RougeModel.instance:getRougeInfo()
	local teamSize = rougeInfo and rougeInfo.teamSize or 0

	return heroCount, teamSize
end

function RougeSettlementTriggerHelper.triggerType19()
	local rougeResult = RougeModel.instance:getRougeResult()
	local reviewInfo = rougeResult and rougeResult.reviewInfo
	local gainCoin = reviewInfo and reviewInfo.gainCoin or 0
	local stepNum = rougeResult and rougeResult.stepNum

	return stepNum, gainCoin
end

function RougeSettlementTriggerHelper.triggerType20()
	local rougeInfo = RougeModel.instance:getRougeInfo()
	local teamExp = rougeInfo and rougeInfo.teamExp or 0
	local teamLevel = rougeInfo and rougeInfo.teamLevel or 0
	local season = rougeInfo.season
	local totalTeamExp = RougeSettlementTriggerHelper._getTotalTeamExp(season, teamLevel, teamExp)

	return totalTeamExp, teamLevel
end

function RougeSettlementTriggerHelper._getTotalTeamExp(season, curTeamLv, curTeamExp)
	if not season then
		return 0
	end

	curTeamLv = curTeamLv or 0
	curTeamExp = curTeamExp or 0

	local seasonTeamCfgs = lua_rouge_level.configDict[season]
	local totalTeamExp = 0

	for i = 1, curTeamLv do
		local lvCfg = seasonTeamCfgs and seasonTeamCfgs[i]
		local teamExp = lvCfg and lvCfg.exp or 0

		totalTeamExp = totalTeamExp + teamExp
	end

	totalTeamExp = totalTeamExp + curTeamExp

	return totalTeamExp
end

return RougeSettlementTriggerHelper
