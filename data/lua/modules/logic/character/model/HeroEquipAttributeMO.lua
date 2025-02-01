module("modules.logic.character.model.HeroEquipAttributeMO", package.seeall)

slot0 = pureTable("HeroEquipAttributeMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.equipAttr = HeroAttributeMO.New()

	slot0.equipAttr:init(slot1.equipAttr)
end

return slot0
