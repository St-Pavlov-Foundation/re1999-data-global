module("modules.logic.fight.model.data.FightASFDDataMgr", package.seeall)

slot0 = FightDataClass("FightASFDDataMgr")

function slot0.onConstructor(slot0)
end

function slot0.updateData(slot0, slot1)
	if slot1.attacker:HasField("emitterInfo") then
		slot0.attackerEmitterInfo = FightASFDEmitterInfoMO.New()

		slot0.attackerEmitterInfo:init(slot1.attacker.emitterInfo)
	end

	if slot1.defender:HasField("emitterInfo") then
		slot0.defenderEmitterInfo = FightASFDEmitterInfoMO.New()

		slot0.defenderEmitterInfo:init(slot1.defender.emitterInfo)
	end

	slot0.mySideEnergy = slot1.attacker.energy or 0
	slot0.enemySideEnergy = slot1.defender.energy or 0
end

function slot0.getEmitterInfo(slot0, slot1)
	if slot1 == FightEnum.EntitySide.MySide then
		return slot0.attackerEmitterInfo
	end

	if slot1 == FightEnum.EntitySide.EnemySide then
		return slot0.defenderEmitterInfo
	end
end

function slot0.getMySideEmitterInfo(slot0)
	return slot0.attackerEmitterInfo
end

function slot0.getEnemySideEmitterInfo(slot0)
	return slot0.defenderEmitterInfo
end

function slot0.changeEnergy(slot0, slot1, slot2)
	if slot1 == FightEnum.EntitySide.MySide then
		slot0.mySideEnergy = slot0.mySideEnergy or 0
		slot0.mySideEnergy = slot0.mySideEnergy + slot2

		return
	end

	if slot1 == FightEnum.EntitySide.EnemySide then
		slot0.enemySideEnergy = slot0.enemySideEnergy or 0
		slot0.enemySideEnergy = slot0.enemySideEnergy + slot2

		return
	end
end

function slot0.getEnergy(slot0, slot1)
	if slot1 == FightEnum.EntitySide.MySide then
		return slot0.mySideEnergy
	else
		return slot0.enemySideEnergy
	end
end

function slot0.getEmitterEnergy(slot0, slot1)
	if slot1 == FightEnum.EntitySide.MySide then
		return slot0.attackerEmitterInfo and slot0.attackerEmitterInfo.energy or 0
	else
		return slot0.defenderEmitterInfo and slot0.defenderEmitterInfo.energy or 0
	end
end

function slot0.changeEmitterEnergy(slot0, slot1, slot2)
	if slot1 == FightEnum.EntitySide.MySide then
		if slot0.attackerEmitterInfo then
			slot0.attackerEmitterInfo:changeEnergy(slot2)
		end

		return
	end

	if slot1 == FightEnum.EntitySide.EnemySide then
		if slot0.defenderEmitterInfo then
			slot0.defenderEmitterInfo:changeEnergy(slot2)
		end

		return
	end
end

function slot0.setEmitterInfo(slot0, slot1, slot2)
	if slot1 == FightEnum.EntitySide.MySide then
		slot0.attackerEmitterInfo = slot2

		return
	end

	if slot1 == FightEnum.EntitySide.EnemySide then
		slot0.defenderEmitterInfo = slot2

		return
	end
end

return slot0
