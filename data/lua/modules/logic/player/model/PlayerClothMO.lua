module("modules.logic.player.model.PlayerClothMO", package.seeall)

slot0 = pureTable("PlayerClothMO")

function slot0.ctor(slot0)
	slot0.id = nil
	slot0.clothId = nil
	slot0.level = nil
	slot0.exp = nil
	slot0.has = nil
end

function slot0.initFromConfig(slot0, slot1)
	slot0.id = slot1.id
	slot0.clothId = slot1.id
	slot0.level = 0
	slot0.exp = 0
end

function slot0.init(slot0, slot1)
	slot0.level = slot1.level
	slot0.exp = slot1.exp
	slot0.has = true
end

return slot0
