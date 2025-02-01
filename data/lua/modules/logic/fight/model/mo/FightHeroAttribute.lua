module("modules.logic.fight.model.mo.FightHeroAttribute", package.seeall)

slot0 = pureTable("FightHeroAttribute")

function slot0.init(slot0, slot1)
	slot0.hp = slot1.hp
	slot0.attack = slot1.attack
	slot0.defense = slot1.defense
	slot0.crit = slot1.crit
	slot0.crit_damage = slot1.crit_damage
end

return slot0
