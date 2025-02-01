module("modules.logic.rouge.dlc.101.model.rpcmo.RougeGameLimiterMO", package.seeall)

slot0 = pureTable("RougeGameLimiterMO")

function slot0.init(slot0, slot1)
	slot0.riskId = slot1.riskId
	slot0.riskValue = slot1.riskValue
	slot0.limitIds = tabletool.copy(slot1.limitIds)
	slot0.limitBuffIds = tabletool.copy(slot1.limitBuffIds)
end

function slot0.getLimiterIds(slot0)
	return slot0.limitIds
end

function slot0.getLimiterBuffIds(slot0)
	return slot0.limitBuffIds
end

function slot0.getRiskValue(slot0)
	return slot0.riskValue
end

return slot0
