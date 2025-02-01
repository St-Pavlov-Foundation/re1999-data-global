module("modules.logic.rouge.map.model.rpcmo.RougeFightEventMO", package.seeall)

slot0 = class("RougeFightEventMO", RougeBaseEventMO)

function slot0.init(slot0, slot1, slot2)
	uv0.super.init(slot0, slot1, slot2)
	slot0:updateSurpriseAttackList()
end

function slot0.updateSurpriseAttackList(slot0)
	slot0.surpriseAttackList = {}

	for slot4, slot5 in ipairs(slot0.jsonData.surpriseAttackList or {}) do
		table.insert(slot0.surpriseAttackList, slot5)
	end
end

function slot0.update(slot0, slot1, slot2)
	uv0.super.update(slot0, slot1, slot2)
	slot0:updateSurpriseAttackList()
end

function slot0.getSurpriseAttackList(slot0)
	return slot0.surpriseAttackList
end

function slot0.__tostring(slot0)
	return uv0.super.__tostring(slot0)
end

return slot0
