-- chunkname: @modules/logic/rouge/model/RougeResultMO.lua

module("modules.logic.rouge.model.RougeResultMO", package.seeall)

local RougeResultMO = pureTable("RougeResultMO", RougeCollectionMO)

function RougeResultMO:init(info)
	self.season = tonumber(info.season)

	self:updateHeroId(info.initHeroId)

	self.collectionNum = GameUtil.splitString2(info.collection2NumStr, true)
	self.composeRes = GameUtil.splitString2(info.composeRes2NumStr, true)

	self:updateFinishEventIds(info.finishEventId)
	self:updateFinishEntrustIds(info.finishEntrustId)

	self.consumeCoin = tonumber(info.consumeCoin)
	self.consumePower = tonumber(info.consumePower)
	self.maxDamage = tonumber(info.maxDamage)
	self.deadNum = tonumber(info.deadNum)
	self.reviveNum = tonumber(info.reviveNum)
	self.repairShopNum = tonumber(info.repairShopNum)
	self.displaceNum = tonumber(info.displaceNum)
	self.stepNum = tonumber(info.stepNum)
	self.badge2Score = GameUtil.splitString2(info.badge2Score, true)
	self.normalFight2Score = string.splitToNumber(info.normalFight2Score, "#")
	self.difficultFight2Score = string.splitToNumber(info.difficultFight2Score, "#")
	self.dangerousFight2Score = string.splitToNumber(info.dangerousFight2Score, "#")
	self.collection2Score = string.splitToNumber(info.collection2Score, "#")
	self.layer2Score = string.splitToNumber(info.layer2Score, "#")
	self.entrust2Score = string.splitToNumber(info.entrust2Score, "#")
	self.end2Score = string.splitToNumber(info.end2Score, "#")
	self.scoreReward = tonumber(info.scoreReward)
	self.beforeScore = tonumber(info.beforeScore)
	self.finalScore = tonumber(info.finalScore)
	self.addPoint = tonumber(info.addPoint)
	self.remainScore2Point = tonumber(info.remainScore2Point)
	self.addGeniusPoint = tonumber(info.addGeniusPoint)
	self.remainScore2GeniusPoint = tonumber(info.remainScore2GeniusPoint)

	self:updateReviewInfo(info.reviewInfo)

	self.preRemainScore2Point = tonumber(info.preRemainScore2Point)
	self.preRemainScore2GeniusPoint = tonumber(info.preRemainScore2GeniusPoint)

	self:updateLimiterResult(info)

	self.extraAddPoint = tonumber(info.extraAddPoint)
end

function RougeResultMO:updateReviewInfo(reviewInfo)
	self.reviewInfo = RougeReviewMO.New()

	self.reviewInfo:init(reviewInfo)
end

function RougeResultMO:getReviewInfo()
	return self.reviewInfo
end

function RougeResultMO:updateHeroId(initHeroId)
	self.initHeroId = {}

	for _, heroId in ipairs(initHeroId) do
		table.insert(self.initHeroId, heroId)
	end
end

function RougeResultMO:getInitHeroId()
	return self.initHeroId
end

function RougeResultMO:updateFinishEventIds(finishEventId)
	self.finishEventId = {}
	self.finishEventMap = {}

	for _, eventId in ipairs(finishEventId) do
		table.insert(self.finishEventId, eventId)

		self.finishEventMap[eventId] = true
	end
end

function RougeResultMO:updateFinishEntrustIds(finishEntrustId)
	self.finishEntrustId = {}
	self.finishEntrustIdMap = {}

	for _, entrustId in ipairs(finishEntrustId) do
		table.insert(self.finishEntrustId, entrustId)

		self.finishEntrustIdMap[entrustId] = true
	end
end

function RougeResultMO:getNormalFightCountAndScore()
	local count = self.normalFight2Score and self.normalFight2Score[1] or 0
	local score = self.normalFight2Score and self.normalFight2Score[2] or 0

	return count, score
end

function RougeResultMO:getDifficultFightCountAndScore()
	local count = self.difficultFight2Score and self.difficultFight2Score[1] or 0
	local score = self.difficultFight2Score and self.difficultFight2Score[2] or 0

	return count, score
end

function RougeResultMO:getDangerousFightCountAndScore()
	local count = self.dangerousFight2Score and self.dangerousFight2Score[1] or 0
	local score = self.dangerousFight2Score and self.dangerousFight2Score[2] or 0

	return count, score
end

function RougeResultMO:getCollectionCountAndScore()
	local count = self.collection2Score and self.collection2Score[1] or 0
	local score = self.collection2Score and self.collection2Score[2] or 0

	return count, score
end

function RougeResultMO:getLayerCountAndScore()
	local count = self.layer2Score and self.layer2Score[1] or 0
	local score = self.layer2Score and self.layer2Score[2] or 0

	return count, score
end

function RougeResultMO:getEntrustCountAndScore()
	local count = self.entrust2Score and self.entrust2Score[1] or 0
	local score = self.entrust2Score and self.entrust2Score[2] or 0

	return count, score
end

function RougeResultMO:getEndCountAndScore()
	local isSucc = self:isSucceed()
	local count = isSucc and 1 or 0
	local score = self.end2Score and self.end2Score[2] or 0

	return count, score
end

function RougeResultMO:getResultSeason()
	return self.season
end

function RougeResultMO:getTotalFightCount()
	local normalFightCount = self:getNormalFightCountAndScore()
	local difficlutFightCount = self:getDifficultFightCountAndScore()
	local dangerousFightCount = self:getDangerousFightCountAndScore()
	local totalFightCount = normalFightCount + difficlutFightCount + dangerousFightCount

	return totalFightCount
end

function RougeResultMO:isEntrustFinish(entrustId)
	return self.finishEntrustIdMap and self.finishEntrustIdMap[entrustId] == true
end

function RougeResultMO:isEventFinish(eventId)
	return self.finishEventMap and self.finishEventMap[eventId] == true
end

function RougeResultMO:isSucceed()
	local endId = self.end2Score and self.end2Score[1]

	return endId and endId ~= 0
end

function RougeResultMO:getCompositeCollectionIdAndCount()
	return self.composeRes
end

function RougeResultMO:updateLimiterResult(info)
	if not info:HasField("limiterResNO") then
		self.limiterResultMo = nil

		return
	end

	local preEmblemCount = RougeDLCModel101.instance:getTotalEmblemCount()

	self.limiterResultMo = RougeLimiterResultMO.New()

	self.limiterResultMo:init(info.limiterResNO)
	self.limiterResultMo:setPreEmbleCount(preEmblemCount)
end

function RougeResultMO:getLimiterResultMo()
	return self.limiterResultMo
end

return RougeResultMO
