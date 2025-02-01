module("modules.logic.rouge.dlc.101.model.RougeDLCModel101", package.seeall)

slot0 = class("RougeDLCModel101", BaseModel)

function slot0.clear(slot0)
	slot0._tmpClientMo = nil
	slot0._preFogPosX = 0
	slot0._preFogPosY = 0
end

function slot0.initLimiterInfo(slot0, slot1)
	slot0:clear()

	if not slot1 then
		return
	end

	slot3 = RougeLimiterMO.New()

	slot3:init(slot1.limiterInfo)

	slot0._tmpClientMo = LuaUtil.deepCopy(slot3:getLimiterClientMo())

	slot0:_buildNewUnlockedLimiterGroupMap(slot0._limiterMo, slot3)

	slot0._limiterMo = slot3
end

function slot0.getLimiterMo(slot0)
	return slot0._limiterMo
end

function slot0.getLimiterClientMo(slot0)
	return slot0._tmpClientMo
end

function slot0.getCurLimiterGroupLv(slot0, slot1)
	slot4 = 0

	if slot0:getLimiterClientMo() and slot2:getLimitIdInGroup(slot1) then
		slot4 = RougeDLCConfig101.instance:getLimiterCo(slot3) and slot5.level or 0
	end

	return slot4
end

function slot0.addLimiterGroupLv(slot0, slot1)
	slot0:_changeLimiterGroupLv(slot1, true)
end

function slot0.removeLimiterGroupLv(slot0, slot1)
	slot0:_changeLimiterGroupLv(slot1, false)
end

function slot0._changeLimiterGroupLv(slot0, slot1, slot2)
	slot3 = slot0:getCurLimiterGroupLv(slot1)

	if slot3 == GameUtil.clamp(slot2 and slot3 + 1 or slot3 - 1, 0, RougeDLCConfig101.instance:getLimiterGroupMaxLevel(slot1)) then
		return
	end

	slot0._tmpClientMo:selectLimit(RougeDLCConfig101.instance:getLimiterCoByGroupIdAndLv(slot1, slot3) and slot6.id, false)
	slot0._tmpClientMo:selectLimit(RougeDLCConfig101.instance:getLimiterCoByGroupIdAndLv(slot1, slot5) and slot6.id, true)

	if not slot2 then
		slot0:_tryRemoveBuff2MatchRisk()
	end

	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.UpdateLimitGroup, slot1)
end

function slot0._tryRemoveBuff2MatchRisk(slot0)
	for slot5 = #slot0._tmpClientMo:getLimitBuffIdsAndSortByType(), 1, -1 do
		if slot0:_checkIsLimiterRiskEnough() then
			break
		end

		slot0._tmpClientMo:selectLimitBuff(slot1[slot5], false)
	end
end

function slot0._checkIsLimiterRiskEnough(slot0)
	slot2 = RougeDLCConfig101.instance:getRougeRiskCoByRiskValue(slot0:getTotalRiskValue())

	return (slot0._tmpClientMo:getLimitBuffIds() and #slot3 or 0) <= (slot2 and slot2.buffNum or 0)
end

function slot0.getTotalRiskValue(slot0)
	return slot0:_calcTotalRiskValue()
end

function slot0._calcTotalRiskValue(slot0)
	for slot7, slot8 in ipairs(slot0:getLimiterClientMo() and slot1:getLimitIds() or {}) do
		slot3 = 0 + (RougeDLCConfig101.instance:getLimiterCo(slot8) and slot9.riskValue or 0)
	end

	return slot3
end

function slot0.getCurLimiterGroupState(slot0, slot1)
	return slot0:getLimiterMo() and slot2:getLimiterGroupState(slot1)
end

function slot0.getSelectLimiterGroupIds(slot0)
	slot1 = {}
	slot2 = {}

	for slot8, slot9 in ipairs(slot0:getLimiterClientMo() and slot3:getLimitIds()) do
		if RougeDLCConfig101.instance:getLimiterCo(slot9) and slot10.group and not slot2[slot11] then
			slot2[slot11] = true

			table.insert(slot1, slot11)
		end
	end

	return slot1
end

function slot0.isLimiterGroupSelected(slot0, slot1)
	return (slot0:getLimiterMo() and slot2:getLimiterGroupState()) == RougeDLCEnum101.LimitState.Unlocked and slot0:getCurLimiterGroupLv(slot1) >= 1
end

function slot0.getAllLimiterBuffIds(slot0)
	slot1 = {}

	tabletool.addValues(slot1, slot0:getLimiterClientMo() and slot2:getLimitBuffIds())

	return slot1
end

function slot0.getLimiterStateBuffIds(slot0, slot1)
	slot2 = {}

	for slot7, slot8 in ipairs(RougeDLCConfig101.instance:getAllLimiterBuffCos() or {}) do
		if slot0:getLimiterBuffState(slot8.id) == slot1 then
			table.insert(slot2, slot9)
		end
	end

	return slot2
end

function slot0.getLimiterBuffState(slot0, slot1)
	slot3 = RougeDLCEnum101.BuffState.Locked

	if slot0:getLimiterMo() and slot2:isBuffUnlocked(slot1) then
		slot3 = RougeDLCEnum101.BuffState.Unlocked
		slot5 = slot0:getLimiterClientMo()
		slot7 = slot5 and slot5:isSelectBuff(slot1)

		if slot2 and slot2:isBuffCD(slot1) then
			slot3 = RougeDLCEnum101.BuffState.CD
		elseif slot7 then
			slot3 = RougeDLCEnum101.BuffState.Equiped
		end
	end

	return slot3
end

function slot0.try2EquipBuff(slot0, slot1)
	slot0:getLimiterClientMo():selectLimitBuff(slot1, true)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.UpdateBuffState, slot1)
end

function slot0.try2UnEquipBuff(slot0, slot1)
	slot0:getLimiterClientMo():selectLimitBuff(slot1, false)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.UpdateBuffState, slot1)
end

function slot0.getTotalEmblemCount(slot0)
	return slot0:getLimiterMo() and slot1:getTotalEmblemCount()
end

function slot0.getLimiterBuffCD(slot0, slot1)
	return slot0:getLimiterMo() and slot2:getLimiterBuffCD(slot1) or 0
end

function slot0.isModifySelectLimiterGroup(slot0)
	slot2 = slot0:getLimiterMo() and slot1:getLimiterClientMo()
	slot3 = slot0:getLimiterClientMo()

	return not slot0:_is2MapSame(slot2:getLimitBuffIdMap(), slot3:getLimitBuffIdMap()) or not slot0:_is2MapSame(slot2:getLimitIdMap(), slot3:getLimitIdMap())
end

function slot0._is2MapSame(slot0, slot1, slot2)
	if tabletool.len(slot1) ~= tabletool.len(slot2) then
		return false
	end

	for slot8, slot9 in pairs(slot1) do
		if slot2[slot8] ~= slot9 then
			return false
		end
	end

	return true
end

function slot0.onGetLimiterClientMo(slot0, slot1)
	slot0:getLimiterMo():updateLimiterClientInfo(slot1)

	slot0._tmpClientMo = LuaUtil.deepCopy(slot0._limiterMo:getLimiterClientMo())
end

function slot0.getFogPrePos(slot0)
	return slot0._preFogPosX or 0, slot0._preFogPosY or 0
end

function slot0.setFogPrePos(slot0, slot1, slot2)
	slot0._preFogPosX = slot1
	slot0._preFogPosY = slot2
end

function slot0._buildNewUnlockedLimiterGroupMap(slot0, slot1, slot2)
	slot0._newUnlockedGroupMap = slot0._newUnlockedGroupMap or {}

	if slot1 and slot2 and slot2:getAllUnlockLimiterGroupIds() then
		for slot7, slot8 in ipairs(slot3) do
			if not slot1:isLimiterGroupUnlocked(slot8) then
				slot0._newUnlockedGroupMap[slot8] = true
			end
		end
	end
end

function slot0.isLimiterGroupNewUnlocked(slot0, slot1)
	return slot0._newUnlockedGroupMap and slot0._newUnlockedGroupMap[slot1]
end

function slot0.resetLimiterGroupNewUnlockInfo(slot0)
	slot0._newUnlockedGroupMap = {}
end

function slot0.resetAllSelectLimitIds(slot0)
	if not slot0:getLimiterClientMo() then
		return
	end

	slot1:clearAllLimitIds()
	slot1:clearAllLimitBuffIds()
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.UpdateLimitGroup)
	RougeDLCController101.instance:dispatchEvent(RougeDLCEvent101.RefreshLimiterDebuffTips)
end

slot0.instance = slot0.New()

return slot0
