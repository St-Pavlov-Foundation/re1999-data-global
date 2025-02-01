module("modules.logic.rouge.dlc.101.controller.RougeDLCHelper101", package.seeall)

slot0 = class("RougeDLCHelper101")

function slot0.getLimiterBuffSpeedupCost(slot0)
	return uv0._getOrCreateBuffSpeedupCostMap() and slot1[slot0] or 0
end

function slot0._getOrCreateBuffSpeedupCostMap()
	if not uv0._costMap then
		uv0._costMap = {}

		for slot6, slot7 in ipairs(GameUtil.splitString2(lua_rouge_dlc_const.configDict[RougeDLCEnum101.Const.SpeedupCost] and slot0.value, true) or {}) do
			uv0._costMap[slot7[1]] = slot7[2]
		end
	end

	return uv0._costMap
end

function slot0.isLimiterRisker(slot0, slot1)
	slot2 = slot1 ~= nil

	if slot0 and slot1 then
		slot3, slot4 = uv0._getRiskRange(slot0)
		slot2 = slot4 < uv0._getRiskRange(slot1)
	end

	return slot2
end

function slot0._getRiskRange(slot0)
	if not slot0 then
		return
	end

	return string.splitToNumber(slot0.range, "#")[1] or 0, slot1[2] or 0
end

function slot0.isNearLimiter(slot0, slot1)
	slot2 = false

	if slot0 and slot1 then
		slot3, slot4 = uv0._getRiskRange(slot0)
		slot5, slot6 = uv0._getRiskRange(slot1)
		slot2 = math.abs(slot5 - slot4) <= 1 or math.abs(slot3 - slot6) <= 1
	end

	return slot2
end

return slot0
