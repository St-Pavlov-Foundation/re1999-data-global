module("modules.logic.rouge.dlc.101.model.rpcmo.RougeLimiterMO", package.seeall)

slot0 = pureTable("RougeLimiterMO")

function slot0.init(slot0, slot1)
	slot0:_buildLimitBuffInfoMap(slot1.unlockLimitBuffs)
	slot0:_buildLimitGroupInfoMap(slot1.unlockLimitGroupIds)
	slot0:updateLimiterClientInfo(slot1.clientNO)

	slot0._totalEmblemCount = slot1.emblem
end

function slot0._buildLimitBuffInfoMap(slot0, slot1)
	slot0._unlockLimitBuff = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0._unlockLimitBuff[slot6.id] = slot6.cd
	end
end

function slot0._buildLimitGroupInfoMap(slot0, slot1)
	slot0._unlockLimitGroupIds = {}
	slot0._unlockLimitGroupIdMap = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0._unlockLimitGroupIdMap[slot6] = true

		table.insert(slot0._unlockLimitGroupIds, slot6)
	end
end

function slot0.isBuffUnlocked(slot0, slot1)
	if RougeDLCConfig101.instance:getLimiterBuffCo(slot1) and slot2.needEmblem <= 0 then
		return true
	end

	return (slot0._unlockLimitBuff and slot0._unlockLimitBuff[slot1]) ~= nil
end

function slot0.isBuffCD(slot0, slot1)
	slot2 = slot0._unlockLimitBuff and slot0._unlockLimitBuff[slot1]

	return slot2 and slot2 > 0
end

function slot0.getBuffCDRound(slot0, slot1)
	return slot0._unlockLimitBuff and slot0._unlockLimitBuff[slot1] or 0
end

function slot0.isLimiterGroupUnlocked(slot0, slot1)
	return slot0._unlockLimitGroupIdMap and slot0._unlockLimitGroupIdMap[slot1] ~= nil
end

function slot0.getAllUnlockLimiterGroupIds(slot0)
	return slot0._unlockLimitGroupIds
end

function slot0.getTotalEmblemCount(slot0)
	return slot0._totalEmblemCount
end

function slot0.updateTotalEmblemCount(slot0, slot1)
	slot0._totalEmblemCount = slot0._totalEmblemCount + slot1
end

function slot0.getLimiterGroupState(slot0, slot1)
	return slot0:isLimiterGroupUnlocked(slot1) and RougeDLCEnum101.LimitState.Unlocked or RougeDLCEnum101.LimitState.Locked
end

function slot0.getLimiterClientMo(slot0)
	return slot0._clientMo
end

function slot0.updateLimiterClientInfo(slot0, slot1)
	if not slot0._clientMo then
		slot0._clientMo = RougeLimiterClientMO.New()
	end

	slot0._clientMo:init(slot1)
	slot0:_checkCDAndRemoveLimitBuff()
end

function slot0.getLimiterBuffCD(slot0, slot1)
	return slot0._unlockLimitBuff and slot0._unlockLimitBuff[slot1] or 0
end

function slot0.unlockLimiterBuff(slot0, slot1)
	if not slot0._unlockLimitBuff[slot1] then
		slot0._unlockLimitBuff[slot1] = 0
	end
end

function slot0.speedupLimiterBuff(slot0, slot1)
	if slot0._unlockLimitBuff[slot1] then
		slot0._unlockLimitBuff[slot1] = 0
	end
end

function slot0._checkCDAndRemoveLimitBuff(slot0)
	if not slot0._clientMo then
		return
	end

	if not slot0._clientMo:getLimitBuffIds() then
		return
	end

	for slot5 = #slot1, 1, -1 do
		if slot0:isBuffCD(slot1[slot5]) then
			slot0._clientMo:selectLimitBuff(slot6, false)
		end
	end
end

return slot0
