module("modules.logic.character.model.HeroSpecialAttributeMO", package.seeall)

slot0 = pureTable("HeroSpecialAttributeMO")

function slot0.init(slot0, slot1)
	slot0.revive = slot1.revive
	slot0.heal = slot1.heal
	slot0.absorb = slot1.absorb
	slot0.defenseIgnore = slot1.defenseIgnore
	slot0.clutch = slot1.clutch
	slot0.finalAddDmg = slot1.finalAddDmg
	slot0.finalDropDmg = slot1.finalDropDmg
end

return slot0
