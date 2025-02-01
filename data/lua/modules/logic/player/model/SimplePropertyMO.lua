module("modules.logic.player.model.SimplePropertyMO", package.seeall)

slot0 = pureTable("SimplePropertyMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.property = slot1.property
end

return slot0
