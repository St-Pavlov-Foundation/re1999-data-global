module("modules.logic.rouge.dlc.101.model.RougeLimiterDebuffOverListModel", package.seeall)

slot0 = class("RougeLimiterDebuffOverListModel", ListScrollModel)

function slot0.onInit(slot0, slot1)
	slot0:initLimiterGroupList(slot1)
end

function slot0.initLimiterGroupList(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1 or {}) do
		table.insert(slot2, RougeDLCConfig101.instance:getLimiterCo(slot7))
	end

	table.sort(slot2, slot0._debuffSortFunc)
	slot0:setList(slot2)
end

function slot0._debuffSortFunc(slot0, slot1)
	return slot0.id < slot1.id
end

slot0.instance = slot0.New()

return slot0
