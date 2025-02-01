module("modules.logic.weekwalk.model.WeekwalkPrayInfoMO", package.seeall)

slot0 = pureTable("WeekwalkPrayInfoMO")

function slot0.init(slot0, slot1)
	slot0.id = slot1.id
	slot0.sacrificeHeroId = slot1.sacrificeHeroId
	slot0.blessingHeroId = slot1.blessingHeroId
	slot0.heroAttribute = slot1.heroAttribute
	slot0.heroExAttribute = slot1.heroExAttribute
	slot0.passiveSkills = slot1.passiveSkills
end

return slot0
