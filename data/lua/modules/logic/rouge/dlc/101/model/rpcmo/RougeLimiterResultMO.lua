module("modules.logic.rouge.dlc.101.model.rpcmo.RougeLimiterResultMO", package.seeall)

slot0 = pureTable("RougeLimiterResultMO")

function slot0.init(slot0, slot1)
	slot0.addEmblem = tonumber(slot1.addEmblem)
	slot0.useLimitBuffIds = {}

	tabletool.addValues(slot0.useLimitBuffIds, slot1.useLimitBuffIds)
end

function slot0.getLimiterAddEmblem(slot0)
	return slot0.addEmblem or 0
end

function slot0.getLimiterUseBuffIds(slot0)
	return slot0.useLimitBuffIds
end

function slot0.setPreEmbleCount(slot0, slot1)
	slot0.preEmbleCount = slot1 or 0
end

function slot0.getPreEmbleCount(slot0)
	return slot0.preEmbleCount or 0
end

return slot0
