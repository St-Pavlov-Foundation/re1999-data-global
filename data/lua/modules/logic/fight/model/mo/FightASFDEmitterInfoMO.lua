module("modules.logic.fight.model.mo.FightASFDEmitterInfoMO", package.seeall)

slot0 = pureTable("FightASFDEmitterInfoMO")

function slot0.init(slot0, slot1)
	slot0.energy = slot1.energy
end

function slot0.changeEnergy(slot0, slot1)
	slot0.energy = slot0.energy or 0
	slot0.energy = slot0.energy + slot1
end

return slot0
