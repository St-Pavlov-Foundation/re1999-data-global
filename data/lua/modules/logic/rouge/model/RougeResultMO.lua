module("modules.logic.rouge.model.RougeResultMO", package.seeall)

slot0 = pureTable("RougeResultMO", RougeCollectionMO)

function slot0.init(slot0, slot1)
	slot0.season = tonumber(slot1.season)

	slot0:updateHeroId(slot1.initHeroId)

	slot0.collectionNum = GameUtil.splitString2(slot1.collection2NumStr, true)
	slot0.composeRes = GameUtil.splitString2(slot1.composeRes2NumStr, true)

	slot0:updateFinishEventIds(slot1.finishEventId)
	slot0:updateFinishEntrustIds(slot1.finishEntrustId)

	slot0.consumeCoin = tonumber(slot1.consumeCoin)
	slot0.consumePower = tonumber(slot1.consumePower)
	slot0.maxDamage = tonumber(slot1.maxDamage)
	slot0.deadNum = tonumber(slot1.deadNum)
	slot0.reviveNum = tonumber(slot1.reviveNum)
	slot0.repairShopNum = tonumber(slot1.repairShopNum)
	slot0.displaceNum = tonumber(slot1.displaceNum)
	slot0.stepNum = tonumber(slot1.stepNum)
	slot0.badge2Score = GameUtil.splitString2(slot1.badge2Score, true)
	slot0.normalFight2Score = string.splitToNumber(slot1.normalFight2Score, "#")
	slot0.difficultFight2Score = string.splitToNumber(slot1.difficultFight2Score, "#")
	slot0.dangerousFight2Score = string.splitToNumber(slot1.dangerousFight2Score, "#")
	slot0.collection2Score = string.splitToNumber(slot1.collection2Score, "#")
	slot0.layer2Score = string.splitToNumber(slot1.layer2Score, "#")
	slot0.entrust2Score = string.splitToNumber(slot1.entrust2Score, "#")
	slot0.end2Score = string.splitToNumber(slot1.end2Score, "#")
	slot0.scoreReward = tonumber(slot1.scoreReward)
	slot0.beforeScore = tonumber(slot1.beforeScore)
	slot0.finalScore = tonumber(slot1.finalScore)
	slot0.addPoint = tonumber(slot1.addPoint)
	slot0.remainScore2Point = tonumber(slot1.remainScore2Point)
	slot0.addGeniusPoint = tonumber(slot1.addGeniusPoint)
	slot0.remainScore2GeniusPoint = tonumber(slot1.remainScore2GeniusPoint)

	slot0:updateReviewInfo(slot1.reviewInfo)

	slot0.preRemainScore2Point = tonumber(slot1.preRemainScore2Point)
	slot0.preRemainScore2GeniusPoint = tonumber(slot1.preRemainScore2GeniusPoint)

	slot0:updateLimiterResult(slot1)
end

function slot0.updateReviewInfo(slot0, slot1)
	slot0.reviewInfo = RougeReviewMO.New()

	slot0.reviewInfo:init(slot1)
end

function slot0.getReviewInfo(slot0)
	return slot0.reviewInfo
end

function slot0.updateHeroId(slot0, slot1)
	slot0.initHeroId = {}

	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0.initHeroId, slot6)
	end
end

function slot0.getInitHeroId(slot0)
	return slot0.initHeroId
end

function slot0.updateFinishEventIds(slot0, slot1)
	slot0.finishEventId = {}
	slot0.finishEventMap = {}

	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0.finishEventId, slot6)

		slot0.finishEventMap[slot6] = true
	end
end

function slot0.updateFinishEntrustIds(slot0, slot1)
	slot0.finishEntrustId = {}
	slot0.finishEntrustIdMap = {}

	for slot5, slot6 in ipairs(slot1) do
		table.insert(slot0.finishEntrustId, slot6)

		slot0.finishEntrustIdMap[slot6] = true
	end
end

function slot0.getNormalFightCountAndScore(slot0)
	return slot0.normalFight2Score and slot0.normalFight2Score[1] or 0, slot0.normalFight2Score and slot0.normalFight2Score[2] or 0
end

function slot0.getDifficultFightCountAndScore(slot0)
	return slot0.difficultFight2Score and slot0.difficultFight2Score[1] or 0, slot0.difficultFight2Score and slot0.difficultFight2Score[2] or 0
end

function slot0.getDangerousFightCountAndScore(slot0)
	return slot0.dangerousFight2Score and slot0.dangerousFight2Score[1] or 0, slot0.dangerousFight2Score and slot0.dangerousFight2Score[2] or 0
end

function slot0.getCollectionCountAndScore(slot0)
	return slot0.collection2Score and slot0.collection2Score[1] or 0, slot0.collection2Score and slot0.collection2Score[2] or 0
end

function slot0.getLayerCountAndScore(slot0)
	return slot0.layer2Score and slot0.layer2Score[1] or 0, slot0.layer2Score and slot0.layer2Score[2] or 0
end

function slot0.getEntrustCountAndScore(slot0)
	return slot0.entrust2Score and slot0.entrust2Score[1] or 0, slot0.entrust2Score and slot0.entrust2Score[2] or 0
end

function slot0.getEndCountAndScore(slot0)
	return slot0:isSucceed() and 1 or 0, slot0.end2Score and slot0.end2Score[2] or 0
end

function slot0.getResultSeason(slot0)
	return slot0.season
end

function slot0.getTotalFightCount(slot0)
	return slot0:getNormalFightCountAndScore() + slot0:getDifficultFightCountAndScore() + slot0:getDangerousFightCountAndScore()
end

function slot0.isEntrustFinish(slot0, slot1)
	return slot0.finishEntrustIdMap and slot0.finishEntrustIdMap[slot1] == true
end

function slot0.isEventFinish(slot0, slot1)
	return slot0.finishEventMap and slot0.finishEventMap[slot1] == true
end

function slot0.isSucceed(slot0)
	slot1 = slot0.end2Score and slot0.end2Score[1]

	return slot1 and slot1 ~= 0
end

function slot0.getCompositeCollectionIdAndCount(slot0)
	return slot0.composeRes
end

function slot0.updateLimiterResult(slot0, slot1)
	if not slot1:HasField("limiterResNO") then
		slot0.limiterResultMo = nil

		return
	end

	slot0.limiterResultMo = RougeLimiterResultMO.New()

	slot0.limiterResultMo:init(slot1.limiterResNO)
	slot0.limiterResultMo:setPreEmbleCount(RougeDLCModel101.instance:getTotalEmblemCount())
end

function slot0.getLimiterResultMo(slot0)
	return slot0.limiterResultMo
end

return slot0
