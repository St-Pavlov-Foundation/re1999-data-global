module("modules.logic.fight.model.mo.FightHeroSpAttributeInfoMO", package.seeall)

slot0 = pureTable("FightHeroSpAttributeInfoMO")

function slot0.init(slot0, slot1)
	slot0.uid = slot1.uid
	slot0.attribute = {}

	for slot5, slot6 in ipairs(slot1.attribute) do
		slot7 = HeroSpAttributeMO.New()

		slot7:init(slot6)

		slot0.attribute[slot5] = slot7
	end
end

return slot0
