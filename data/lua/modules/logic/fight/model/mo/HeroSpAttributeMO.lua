module("modules.logic.fight.model.mo.HeroSpAttributeMO", package.seeall)

slot0 = pureTable("HeroSpAttributeMO")

function slot0.init(slot0, slot1, slot2)
	slot0.uid = slot1
	slot0.revive = slot2.revive
	slot0.heal = slot2.heal
	slot0.absorb = slot2.absorb
	slot0.defenseIgnore = slot2.defenseIgnore
	slot0.clutch = slot2.clutch
	slot0.finalAddDmg = slot2.finalAddDmg
	slot0.finalDropDmg = slot2.finalDropDmg
	slot0.normalSkillRate = slot2.normalSkillRate
	slot0.playAddRate = slot2.playAddRate
	slot0.playDropRate = slot2.playDropRate
	slot0.dizzyResistances = slot2.dizzyResistances
	slot0.sleepResistances = slot2.sleepResistances
	slot0.petrifiedResistances = slot2.petrifiedResistances
	slot0.frozenResistances = slot2.frozenResistances
	slot0.disarmResistances = slot2.disarmResistances
	slot0.forbidResistances = slot2.forbidResistances
	slot0.sealResistances = slot2.sealResistances
	slot0.cantGetExskillResistances = slot2.cantGetExskillResistances
	slot0.delExPointResistances = slot2.delExPointResistances
	slot0.stressUpResistances = slot2.stressUpResistances
	slot0.controlResilience = slot2.controlResilience
	slot0.delExPointResilience = slot2.delExPointResilience
	slot0.stressUpResilience = slot2.stressUpResilience
	slot0.charmResistances = slot2.charmResistances
end

return slot0
