module("modules.logic.seasonver.act123.model.Season123HeroMO", package.seeall)

slot0 = pureTable("Season123HeroMO")

function slot0.init(slot0, slot1, slot2)
	slot0.heroUid = slot1.heroUid
	slot0.hpRate = slot1.hpRate
	slot0.isAssist = slot1.isAssist
end

function slot0.update(slot0, slot1)
	slot0.hpRate = slot1.hpRate
end

return slot0
