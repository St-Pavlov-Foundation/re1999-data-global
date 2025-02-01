module("modules.logic.rouge.model.rpcmo.RougeTalentMO", package.seeall)

slot0 = pureTable("RougeTalentMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.isActive = slot1.isActive
end

return slot0
