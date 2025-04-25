module("modules.logic.fight.config.FightASFDConfig", package.seeall)

slot0 = class("FightASFDConfig", BaseConfig)

function slot0.ctor(slot0)
end

function slot0.reqConfigNames(slot0)
	return {
		"fight_asfd",
		"fight_asfd_emitter_position",
		"fight_asfd_const"
	}
end

function slot0.onConfigLoaded(slot0, slot1, slot2)
	if slot1 == "fight_asfd" then
		slot0:buildFightASFDConfig(slot2)
	elseif slot1 == "fight_asfd_const" then
		slot0:buildFightASFDConstConfig(slot2)
	end
end

function slot0.buildFightASFDConfig(slot0, slot1)
	slot2 = slot1.configDict
	slot0.defaultEmitterCo = slot2[1]
	slot0.defaultMissileCo = slot2[2]
	slot0.defaultExplosionCo = slot2[3]
	slot0.defaultBornCo = slot2[7]
	slot0.unitListDict = {
		[FightEnum.ASFDUnit.Emitter] = {},
		[FightEnum.ASFDUnit.Missile] = {},
		[FightEnum.ASFDUnit.Explosion] = {},
		[FightEnum.ASFDUnit.Born] = {}
	}

	for slot6, slot7 in ipairs(slot1.configList) do
		if slot0.unitListDict[slot7.unit] then
			table.insert(slot8, slot7)
		end
	end

	table.sort(slot0.unitListDict[FightEnum.ASFDUnit.Emitter], slot0.sortASFDCo)
	table.sort(slot0.unitListDict[FightEnum.ASFDUnit.Missile], slot0.sortASFDCo)
	table.sort(slot0.unitListDict[FightEnum.ASFDUnit.Explosion], slot0.sortASFDCo)
	table.sort(slot0.unitListDict[FightEnum.ASFDUnit.Born], slot0.sortASFDCo)
end

function slot0.sortASFDCo(slot0, slot1)
	if slot0.priority ~= slot1.priority then
		return slot3 < slot2
	end

	return slot1.id < slot0.id
end

function slot0.buildFightASFDConstConfig(slot0, slot1)
	slot2 = slot1.configDict
	slot0.flyDuration = tonumber(slot2[1].value)
	slot0.missileInterval = tonumber(slot2[2].value)
	slot0.explosionDuration = tonumber(slot2[3].value)
	slot0.randomRadius = tonumber(slot2[4].value)
	slot0.skillId = tonumber(slot2[5].value)
	slot0.hitHangPoint = slot2[11].value
	slot0.maDiErDaCritScale = tonumber(slot2[12].value)
	slot0.fissionScale = tonumber(slot2[13].value)
	slot0.emitterWaitTime = tonumber(slot2[14].value)
	slot0.flyReduceInterval = tonumber(slot2[15].value)
	slot0.missileReduceInterval = tonumber(slot2[16].value)
	slot0.minFlyDuration = tonumber(slot2[17].value)
	slot0.minMissileInterval = tonumber(slot2[18].value)
	slot0.normalSkillIcon = slot2[20].value
	slot0.bigSkillIcon = slot2[21].value
	slot0.headIcon = slot2[22].value
	slot0.sampleXRate = tonumber(slot2[23].value)
	slot0.lineType = tonumber(slot2[24].value)
	slot0.emitterCenterOffset = Vector2(0, 0)
	slot0.myASFDConfig = slot0:buildASFDEmitterConfig("法术飞弹-我方")
	slot0.enemyASFDConfig = slot0:buildASFDEmitterConfig("法术飞弹-敌方")
	slot0.startAnimAbUrl = FightHelper.getCameraAniPath("v2a4_asfd/v2a4_asfd_start")
	slot0.endAnimAbUrl = FightHelper.getCameraAniPath("v2a4_asfd/v2a4_asfd_end")
	slot0.startAnim = ResUrl.getCameraAnim("v2a4_asfd/v2a4_asfd_start")
	slot0.endAnim = ResUrl.getCameraAnim("v2a4_asfd/v2a4_asfd_end")
end

function slot0.buildASFDEmitterConfig(slot0, slot1)
	return {
		uniqueSkill_point = 5,
		name = slot1
	}
end

function slot0.getASFDEmitterConfig(slot0, slot1)
	return slot1 == FightEnum.EntitySide.EnemySide and slot0.enemyASFDConfig or slot0.myASFDConfig
end

function slot0.getUnitList(slot0, slot1)
	return slot0.unitListDict[slot1]
end

function slot0.getMissileInterval(slot0, slot1)
	return math.max(slot0.minMissileInterval, slot0.missileInterval - (slot1 - 1) * slot0.missileReduceInterval)
end

function slot0.getFlyDuration(slot0, slot1)
	return math.max(slot0.minFlyDuration, slot0.flyDuration - (slot1 - 1) * slot0.flyReduceInterval)
end

function slot0.getSkillCo(slot0)
	if not slot0.skillLCo then
		slot0.skillCo = lua_skill.configDict[slot0.skillId]
	end

	return slot0.skillCo
end

slot0.instance = slot0.New()

return slot0
