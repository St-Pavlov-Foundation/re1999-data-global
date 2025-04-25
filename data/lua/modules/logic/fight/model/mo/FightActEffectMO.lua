module("modules.logic.fight.model.mo.FightActEffectMO", package.seeall)

slot0 = pureTable("FightActEffectMO")
slot1 = 1

function slot0.ctor(slot0)
	slot0.clientId = uv0
	uv0 = uv0 + 1
end

function slot0.isDone(slot0)
	return slot0.CUSTOM_ISDONE
end

function slot0.setDone(slot0)
	slot0.CUSTOM_ISDONE = true
end

function slot0.revertDone(slot0)
	slot0.CUSTOM_ISDONE = false
end

function slot0.init(slot0, slot1, slot2)
	slot0.targetId = slot1.targetId
	slot0.effectType = slot1.effectType
	slot0.effectNum = slot1.effectNum
	slot0.effectNum1 = slot1.effectNum1
	slot0.fromSide = slot2
	slot0.configEffect = slot1.configEffect
	slot0.buffActId = slot1.buffActId
	slot0.reserveId = slot1.reserveId
	slot0.reserveStr = slot1.reserveStr
	slot0.summoned = slot1.summoned

	if slot1:HasField("buff") then
		slot0.buff = slot0:_buildBuff(slot1.buff)
	end

	if slot1:HasField("entity") then
		slot0.entityMO = slot0:_buildEntity(slot1.entity, slot2)
	end

	slot0.magicCircle = slot1.magicCircle
	slot0.cardInfo = slot1.cardInfo
	slot0.cardInfoList = slot1.cardInfoList
	slot0.teamType = slot1.teamType
	slot0.fightStep = slot1.fightStep
	slot0.assistBossInfo = slot1.assistBossInfo

	if slot0.effectType == FightEnum.EffectType.FIGHTSTEP then
		slot0.cus_stepMO = FightStepMO.New()

		slot0.cus_stepMO:init(slot0.fightStep)
	end

	if slot1:HasField("emitterInfo") then
		slot0.emitterInfo = FightASFDEmitterInfoMO.New()

		slot0.emitterInfo:init(slot1.emitterInfo)
	else
		slot0.emitterInfo = nil
	end

	slot0.playerFinisherInfo = slot1.playerFinisherInfo
	slot0.powerInfo = slot1.powerInfo
	slot0.cardHeatValue = slot1.cardHeatValue
end

function slot0._buildBuff(slot0, slot1)
	slot2 = FightBuffMO.New()

	slot2:init(slot1, slot0.targetId)

	return slot2
end

function slot0._buildEntity(slot0, slot1, slot2)
	slot3 = FightEntityMO.New()

	slot3:init(slot1, slot2)

	return slot3
end

return slot0
