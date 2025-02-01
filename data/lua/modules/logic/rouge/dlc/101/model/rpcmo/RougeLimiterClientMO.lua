module("modules.logic.rouge.dlc.101.model.rpcmo.RougeLimiterClientMO", package.seeall)

slot0 = pureTable("RougeLimiterClientMO")

function slot0.init(slot0, slot1)
	slot0:_onGetLimitIds(slot1.limitIds)
	slot0:_onGetLimitBuffIds(slot1.limitBuffIds)
end

function slot0._onGetLimitIds(slot0, slot1)
	slot0._limitIds = {}
	slot0._limitIdMap = {}
	slot0._limitGroupMap = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0:_onGetLimitId(slot6)
	end
end

function slot0._onGetLimitId(slot0, slot1)
	if not slot0._limitIdMap[slot1] then
		slot0._limitIdMap[slot1] = true
		slot0._limitGroupMap[RougeDLCConfig101.instance:getLimiterCo(slot1) and slot2.group] = slot1

		table.insert(slot0._limitIds, slot1)
	end
end

function slot0._onRemoveLimitId(slot0, slot1)
	if slot0._limitIdMap[slot1] then
		slot0._limitIdMap[slot1] = nil
		slot0._limitGroupMap[RougeDLCConfig101.instance:getLimiterCo(slot1) and slot2.group] = nil

		tabletool.removeValue(slot0._limitIds, slot1)
	end
end

function slot0._onGetLimitBuffIds(slot0, slot1)
	slot0._limitBuffIds = {}
	slot0._limitBuffIdMap = {}
	slot0._limitBuffTypeMap = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0:_onGetLimitBuffId(slot6)
	end
end

function slot0._onGetLimitBuffId(slot0, slot1)
	if not slot0._limitBuffIdMap[slot1] then
		slot3 = RougeDLCConfig101.instance:getLimiterBuffCo(slot1).buffType

		slot0:removeLimitBuffByType(slot3)

		slot0._limitBuffIdMap[slot1] = true
		slot0._limitBuffTypeMap[slot3] = slot1

		table.insert(slot0._limitBuffIds, slot1)
	end
end

function slot0._onRemoveLimitBuffId(slot0, slot1)
	if slot0._limitBuffIdMap[slot1] then
		slot0._limitBuffIdMap[slot1] = nil
		slot0._limitBuffTypeMap[RougeDLCConfig101.instance:getLimiterBuffCo(slot1).buffType] = nil

		tabletool.removeValue(slot0._limitBuffIds, slot1)
	end
end

function slot0.removeLimitBuffByType(slot0, slot1)
	slot0:_onRemoveLimitBuffId(slot0:getLimitBuffIdByType(slot1))
end

function slot0.getLimitBuffIdByType(slot0, slot1)
	return slot0._limitBuffTypeMap and slot0._limitBuffTypeMap[slot1]
end

function slot0.getLimitBuffIds(slot0)
	return slot0._limitBuffIds
end

function slot0.getLimitBuffIdsAndSortByType(slot0)
	slot1 = {}

	tabletool.addValues(slot1, slot0._limitBuffIds)
	table.sort(slot1, uv0._sortLimitBuffIdByType)

	return slot1
end

function slot0._sortLimitBuffIdByType(slot0, slot1)
	slot3 = RougeDLCConfig101.instance:getLimiterBuffCo(slot1)

	if RougeDLCConfig101.instance:getLimiterBuffCo(slot0) and slot3 and slot2.buffType ~= slot3.buffType then
		return slot2.buffType < slot3.buffType
	end

	return slot2.id < slot3.id
end

function slot0.getLimitBuffIdMap(slot0)
	return slot0._limitBuffIdMap
end

function slot0.getLimitIds(slot0)
	return slot0._limitIds
end

function slot0.getLimitIdMap(slot0)
	return slot0._limitIdMap
end

function slot0.getLimitIdInGroup(slot0, slot1)
	return slot0._limitGroupMap and slot0._limitGroupMap[slot1]
end

function slot0.isSelectBuff(slot0, slot1)
	return slot0._limitBuffIdMap and slot0._limitBuffIdMap[slot1] ~= nil
end

function slot0.isSelectDebuff(slot0, slot1)
	return slot0._limitIdMap and slot0._limitIdMap[slot1] ~= nil
end

function slot0.selectLimit(slot0, slot1, slot2)
	if not RougeDLCConfig101.instance:getLimiterCo(slot1) then
		return
	end

	if slot2 then
		slot0:_onGetLimitId(slot1)
	else
		slot0:_onRemoveLimitId(slot1)
	end
end

function slot0.selectLimitBuff(slot0, slot1, slot2)
	if not RougeDLCConfig101.instance:getLimiterBuffCo(slot1) then
		return
	end

	if slot2 then
		slot0:_onGetLimitBuffId(slot1)
	else
		slot0:_onRemoveLimitBuffId(slot1)
	end
end

function slot0.clearAllLimitIds(slot0)
	slot0:_onGetLimitIds({})
end

function slot0.clearAllLimitBuffIds(slot0)
	slot0:_onGetLimitBuffIds({})
end

return slot0
