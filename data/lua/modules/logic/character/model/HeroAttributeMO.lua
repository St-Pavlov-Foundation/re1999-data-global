module("modules.logic.character.model.HeroAttributeMO", package.seeall)

slot0 = pureTable("HeroAttributeMO")

function slot0.init(slot0, slot1)
	slot0.original_max_hp = slot1.hp
	slot0.hp = slot1.hp
	slot0.attack = slot1.attack
	slot0.defense = slot1.defense
	slot0.mdefense = slot1.mdefense
	slot0.technic = slot1.technic
	slot0.multiHpIdx = slot1.multiHpIdx
	slot0.multiHpNum = slot1.multiHpNum
end

function slot0.getCurMultiHpIndex(slot0)
	return slot0.multiHpIdx
end

return slot0
