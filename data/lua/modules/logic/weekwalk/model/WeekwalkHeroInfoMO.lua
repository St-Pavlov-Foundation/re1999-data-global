module("modules.logic.weekwalk.model.WeekwalkHeroInfoMO", package.seeall)

slot0 = pureTable("WeekwalkHeroInfoMO")

function slot0.init(slot0, slot1)
	slot0.heroId = slot1.heroId
	slot0.cd = slot1.cd
end

return slot0
