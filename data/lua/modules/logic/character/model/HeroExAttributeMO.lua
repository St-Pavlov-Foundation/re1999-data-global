module("modules.logic.character.model.HeroExAttributeMO", package.seeall)

slot0 = pureTable("HeroExAttributeMO")

function slot0.init(slot0, slot1)
	slot0.cri = slot1.cri
	slot0.recri = slot1.recri
	slot0.criDmg = slot1.criDmg
	slot0.criDef = slot1.criDef
	slot0.addDmg = slot1.addDmg
	slot0.dropDmg = slot1.dropDmg
end

return slot0
