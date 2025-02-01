module("modules.logic.rouge.model.rpcmo.RougeUnlockSkillMO", package.seeall)

slot0 = pureTable("RougeUnlockSkillMO")

function slot0.init(slot0, slot1)
	slot0.type = slot1.type
	slot0.idMap = slot0:_listToMap(slot1.ids)
end

function slot0._listToMap(slot0, slot1)
	if not slot1 then
		return {}
	end

	for slot6, slot7 in ipairs(slot1) do
		-- Nothing
	end

	return {
		[slot7] = slot7
	}
end

function slot0.isSkillUnlock(slot0, slot1)
	return slot0.idMap and slot0.idMap[slot1] ~= nil
end

function slot0.onNewSkillUnlock(slot0, slot1)
	if not slot1 then
		return
	end

	slot0.idMap[slot1] = true
end

return slot0
