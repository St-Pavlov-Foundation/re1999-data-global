module("modules.logic.weekwalk.model.WeekwalkHeroHpMO", package.seeall)

slot0 = pureTable("WeekwalkHeroHpMO")

function slot0.init(slot0, slot1)
	slot0.heroId = slot1.heroId
	slot0.hp = slot1.hp
	slot0.buff = slot1.buff
end

function slot0.setValue(slot0, slot1, slot2, slot3)
	slot0.heroId = slot1
	slot0.buff = slot2
	slot0.hp = slot3
end

return slot0
