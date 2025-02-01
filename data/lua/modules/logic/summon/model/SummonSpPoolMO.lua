module("modules.logic.summon.model.SummonSpPoolMO", package.seeall)

slot0 = pureTable("SummonSpPoolMO", SummonCustomPickMO)

function slot0.ctor(slot0)
	slot0.type = 0
	slot0.openTime = 0

	SummonCustomPickMO.ctor(slot0)
end

function slot0.isValid(slot0)
	return slot0.type ~= 0
end

function slot0.update(slot0, slot1)
	SummonCustomPickMO.update(slot0, slot1)

	slot0.type = slot1.type
	slot0.openTime = tonumber(slot1.openTime) or 0
end

function slot0.isOpening(slot0)
	if not slot0:isValid() then
		return nil
	end

	return slot0:onlineTs() <= ServerTime.now() and slot1 <= slot0:offlineTs()
end

function slot0.onlineTs(slot0)
	return slot0.openTime / 1000
end

function slot0.offlineTs(slot0)
	if slot0:onlineTs() <= 0 then
		return 0
	end

	if SummonConfig.instance:getDurationByPoolType(slot0.type) <= 0 then
		return 0
	end

	return slot0:onlineTs() + slot1
end

function slot0.onOffTimestamp(slot0)
	return slot0:onlineTs(), slot0:offlineTs()
end

return slot0
