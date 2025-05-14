module("modules.logic.rouge.model.RougeReviewMO", package.seeall)

local var_0_0 = pureTable("RougeReviewMO")

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.season = arg_1_1.season
	arg_1_0.playerName = arg_1_1.playerName
	arg_1_0.playerLevel = arg_1_1.playerLevel
	arg_1_0.portrait = arg_1_1.portrait
	arg_1_0.finishTime = arg_1_1.finishTime
	arg_1_0.difficulty = arg_1_1.difficulty
	arg_1_0.style = arg_1_1.style
	arg_1_0.teamLevel = arg_1_1.teamLevel
	arg_1_0.collectionNum = arg_1_1.collectionNum
	arg_1_0.gainCoin = arg_1_1.gainCoin
	arg_1_0.endId = arg_1_1.endId
	arg_1_0.layerId = arg_1_1.layerId
	arg_1_0.middleLayerId = arg_1_1.middleLayerId

	arg_1_0:updateTeamInfo(arg_1_1.teamInfo)
	arg_1_0:updateSlotCollections(arg_1_1.layouts)
	arg_1_0:updateVersions(arg_1_1.version)
	arg_1_0:updateLimiterInfo(arg_1_1)
end

function var_0_0.updateTeamInfo(arg_2_0, arg_2_1)
	arg_2_0.teamInfo = RougeTeamInfoMO.New()

	arg_2_0.teamInfo:init(arg_2_1)
end

function var_0_0.getTeamInfo(arg_3_0)
	return arg_3_0.teamInfo
end

function var_0_0.updateSlotCollections(arg_4_0, arg_4_1)
	arg_4_0.slotCollections = RougeCollectionHelper.buildCollectionSlotMOs(arg_4_1)
end

function var_0_0.getSlotCollections(arg_5_0)
	return arg_5_0.slotCollections
end

function var_0_0.isSucceed(arg_6_0)
	return arg_6_0.endId and arg_6_0.endId ~= 0
end

function var_0_0.isInMiddleLayer(arg_7_0)
	return arg_7_0.middleLayerId ~= 0
end

function var_0_0.updateVersions(arg_8_0, arg_8_1)
	arg_8_0._versions = {}

	tabletool.addValues(arg_8_0._versions, arg_8_1)
end

function var_0_0.getVersions(arg_9_0)
	return arg_9_0._versions
end

function var_0_0.updateLimiterInfo(arg_10_0, arg_10_1)
	if arg_10_1:HasField("riskValue") then
		arg_10_0._riskValue = arg_10_1.riskValue
	end
end

function var_0_0.getLimiterRiskValue(arg_11_0)
	return arg_11_0._riskValue
end

return var_0_0
