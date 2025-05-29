module("modules.logic.rouge.model.RougeResultMO", package.seeall)

local var_0_0 = pureTable("RougeResultMO", RougeCollectionMO)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.season = tonumber(arg_1_1.season)

	arg_1_0:updateHeroId(arg_1_1.initHeroId)

	arg_1_0.collectionNum = GameUtil.splitString2(arg_1_1.collection2NumStr, true)
	arg_1_0.composeRes = GameUtil.splitString2(arg_1_1.composeRes2NumStr, true)

	arg_1_0:updateFinishEventIds(arg_1_1.finishEventId)
	arg_1_0:updateFinishEntrustIds(arg_1_1.finishEntrustId)

	arg_1_0.consumeCoin = tonumber(arg_1_1.consumeCoin)
	arg_1_0.consumePower = tonumber(arg_1_1.consumePower)
	arg_1_0.maxDamage = tonumber(arg_1_1.maxDamage)
	arg_1_0.deadNum = tonumber(arg_1_1.deadNum)
	arg_1_0.reviveNum = tonumber(arg_1_1.reviveNum)
	arg_1_0.repairShopNum = tonumber(arg_1_1.repairShopNum)
	arg_1_0.displaceNum = tonumber(arg_1_1.displaceNum)
	arg_1_0.stepNum = tonumber(arg_1_1.stepNum)
	arg_1_0.badge2Score = GameUtil.splitString2(arg_1_1.badge2Score, true)
	arg_1_0.normalFight2Score = string.splitToNumber(arg_1_1.normalFight2Score, "#")
	arg_1_0.difficultFight2Score = string.splitToNumber(arg_1_1.difficultFight2Score, "#")
	arg_1_0.dangerousFight2Score = string.splitToNumber(arg_1_1.dangerousFight2Score, "#")
	arg_1_0.collection2Score = string.splitToNumber(arg_1_1.collection2Score, "#")
	arg_1_0.layer2Score = string.splitToNumber(arg_1_1.layer2Score, "#")
	arg_1_0.entrust2Score = string.splitToNumber(arg_1_1.entrust2Score, "#")
	arg_1_0.end2Score = string.splitToNumber(arg_1_1.end2Score, "#")
	arg_1_0.scoreReward = tonumber(arg_1_1.scoreReward)
	arg_1_0.beforeScore = tonumber(arg_1_1.beforeScore)
	arg_1_0.finalScore = tonumber(arg_1_1.finalScore)
	arg_1_0.addPoint = tonumber(arg_1_1.addPoint)
	arg_1_0.remainScore2Point = tonumber(arg_1_1.remainScore2Point)
	arg_1_0.addGeniusPoint = tonumber(arg_1_1.addGeniusPoint)
	arg_1_0.remainScore2GeniusPoint = tonumber(arg_1_1.remainScore2GeniusPoint)

	arg_1_0:updateReviewInfo(arg_1_1.reviewInfo)

	arg_1_0.preRemainScore2Point = tonumber(arg_1_1.preRemainScore2Point)
	arg_1_0.preRemainScore2GeniusPoint = tonumber(arg_1_1.preRemainScore2GeniusPoint)

	arg_1_0:updateLimiterResult(arg_1_1)

	arg_1_0.extraAddPoint = tonumber(arg_1_1.extraAddPoint)
end

function var_0_0.updateReviewInfo(arg_2_0, arg_2_1)
	arg_2_0.reviewInfo = RougeReviewMO.New()

	arg_2_0.reviewInfo:init(arg_2_1)
end

function var_0_0.getReviewInfo(arg_3_0)
	return arg_3_0.reviewInfo
end

function var_0_0.updateHeroId(arg_4_0, arg_4_1)
	arg_4_0.initHeroId = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		table.insert(arg_4_0.initHeroId, iter_4_1)
	end
end

function var_0_0.getInitHeroId(arg_5_0)
	return arg_5_0.initHeroId
end

function var_0_0.updateFinishEventIds(arg_6_0, arg_6_1)
	arg_6_0.finishEventId = {}
	arg_6_0.finishEventMap = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		table.insert(arg_6_0.finishEventId, iter_6_1)

		arg_6_0.finishEventMap[iter_6_1] = true
	end
end

function var_0_0.updateFinishEntrustIds(arg_7_0, arg_7_1)
	arg_7_0.finishEntrustId = {}
	arg_7_0.finishEntrustIdMap = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		table.insert(arg_7_0.finishEntrustId, iter_7_1)

		arg_7_0.finishEntrustIdMap[iter_7_1] = true
	end
end

function var_0_0.getNormalFightCountAndScore(arg_8_0)
	local var_8_0 = arg_8_0.normalFight2Score and arg_8_0.normalFight2Score[1] or 0
	local var_8_1 = arg_8_0.normalFight2Score and arg_8_0.normalFight2Score[2] or 0

	return var_8_0, var_8_1
end

function var_0_0.getDifficultFightCountAndScore(arg_9_0)
	local var_9_0 = arg_9_0.difficultFight2Score and arg_9_0.difficultFight2Score[1] or 0
	local var_9_1 = arg_9_0.difficultFight2Score and arg_9_0.difficultFight2Score[2] or 0

	return var_9_0, var_9_1
end

function var_0_0.getDangerousFightCountAndScore(arg_10_0)
	local var_10_0 = arg_10_0.dangerousFight2Score and arg_10_0.dangerousFight2Score[1] or 0
	local var_10_1 = arg_10_0.dangerousFight2Score and arg_10_0.dangerousFight2Score[2] or 0

	return var_10_0, var_10_1
end

function var_0_0.getCollectionCountAndScore(arg_11_0)
	local var_11_0 = arg_11_0.collection2Score and arg_11_0.collection2Score[1] or 0
	local var_11_1 = arg_11_0.collection2Score and arg_11_0.collection2Score[2] or 0

	return var_11_0, var_11_1
end

function var_0_0.getLayerCountAndScore(arg_12_0)
	local var_12_0 = arg_12_0.layer2Score and arg_12_0.layer2Score[1] or 0
	local var_12_1 = arg_12_0.layer2Score and arg_12_0.layer2Score[2] or 0

	return var_12_0, var_12_1
end

function var_0_0.getEntrustCountAndScore(arg_13_0)
	local var_13_0 = arg_13_0.entrust2Score and arg_13_0.entrust2Score[1] or 0
	local var_13_1 = arg_13_0.entrust2Score and arg_13_0.entrust2Score[2] or 0

	return var_13_0, var_13_1
end

function var_0_0.getEndCountAndScore(arg_14_0)
	local var_14_0 = arg_14_0:isSucceed() and 1 or 0
	local var_14_1 = arg_14_0.end2Score and arg_14_0.end2Score[2] or 0

	return var_14_0, var_14_1
end

function var_0_0.getResultSeason(arg_15_0)
	return arg_15_0.season
end

function var_0_0.getTotalFightCount(arg_16_0)
	local var_16_0 = arg_16_0:getNormalFightCountAndScore()
	local var_16_1 = arg_16_0:getDifficultFightCountAndScore()
	local var_16_2 = arg_16_0:getDangerousFightCountAndScore()

	return var_16_0 + var_16_1 + var_16_2
end

function var_0_0.isEntrustFinish(arg_17_0, arg_17_1)
	return arg_17_0.finishEntrustIdMap and arg_17_0.finishEntrustIdMap[arg_17_1] == true
end

function var_0_0.isEventFinish(arg_18_0, arg_18_1)
	return arg_18_0.finishEventMap and arg_18_0.finishEventMap[arg_18_1] == true
end

function var_0_0.isSucceed(arg_19_0)
	local var_19_0 = arg_19_0.end2Score and arg_19_0.end2Score[1]

	return var_19_0 and var_19_0 ~= 0
end

function var_0_0.getCompositeCollectionIdAndCount(arg_20_0)
	return arg_20_0.composeRes
end

function var_0_0.updateLimiterResult(arg_21_0, arg_21_1)
	if not arg_21_1:HasField("limiterResNO") then
		arg_21_0.limiterResultMo = nil

		return
	end

	local var_21_0 = RougeDLCModel101.instance:getTotalEmblemCount()

	arg_21_0.limiterResultMo = RougeLimiterResultMO.New()

	arg_21_0.limiterResultMo:init(arg_21_1.limiterResNO)
	arg_21_0.limiterResultMo:setPreEmbleCount(var_21_0)
end

function var_0_0.getLimiterResultMo(arg_22_0)
	return arg_22_0.limiterResultMo
end

return var_0_0
