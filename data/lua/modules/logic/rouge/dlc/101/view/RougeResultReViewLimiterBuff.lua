module("modules.logic.rouge.dlc.101.view.RougeResultReViewLimiterBuff", package.seeall)

slot0 = class("RougeResultReViewLimiterBuff", RougeLimiterBuffEntry)

function slot0.ctor(slot0, slot1)
	slot0._totalRiskValue = slot1
end

function slot0.addEventListeners(slot0)
end

function slot0.removeEventListeners(slot0)
end

function slot0.getTotalRiskValue(slot0)
	return slot0._totalRiskValue
end

return slot0
