module("modules.logic.rouge.model.RougeReviewMO", package.seeall)

slot0 = pureTable("RougeReviewMO")

function slot0.init(slot0, slot1)
	slot0.season = slot1.season
	slot0.playerName = slot1.playerName
	slot0.playerLevel = slot1.playerLevel
	slot0.portrait = slot1.portrait
	slot0.finishTime = slot1.finishTime
	slot0.difficulty = slot1.difficulty
	slot0.style = slot1.style
	slot0.teamLevel = slot1.teamLevel
	slot0.collectionNum = slot1.collectionNum
	slot0.gainCoin = slot1.gainCoin
	slot0.endId = slot1.endId
	slot0.layerId = slot1.layerId
	slot0.middleLayerId = slot1.middleLayerId

	slot0:updateTeamInfo(slot1.teamInfo)
	slot0:updateSlotCollections(slot1.layouts)
	slot0:updateVersions(slot1.version)
	slot0:updateLimiterInfo(slot1)
end

function slot0.updateTeamInfo(slot0, slot1)
	slot0.teamInfo = RougeTeamInfoMO.New()

	slot0.teamInfo:init(slot1)
end

function slot0.getTeamInfo(slot0)
	return slot0.teamInfo
end

function slot0.updateSlotCollections(slot0, slot1)
	slot0.slotCollections = RougeCollectionHelper.buildCollectionSlotMOs(slot1)
end

function slot0.getSlotCollections(slot0)
	return slot0.slotCollections
end

function slot0.isSucceed(slot0)
	return slot0.endId and slot0.endId ~= 0
end

function slot0.isInMiddleLayer(slot0)
	return slot0.middleLayerId ~= 0
end

function slot0.updateVersions(slot0, slot1)
	slot0._versions = {}

	tabletool.addValues(slot0._versions, slot1)
end

function slot0.getVersions(slot0)
	return slot0._versions
end

function slot0.updateLimiterInfo(slot0, slot1)
	if slot1:HasField("riskValue") then
		slot0._riskValue = slot1.riskValue
	end
end

function slot0.getLimiterRiskValue(slot0)
	return slot0._riskValue
end

return slot0
