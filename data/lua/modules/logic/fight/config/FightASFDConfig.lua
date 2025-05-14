﻿module("modules.logic.fight.config.FightASFDConfig", package.seeall)

local var_0_0 = class("FightASFDConfig", BaseConfig)

function var_0_0.ctor(arg_1_0)
	return
end

function var_0_0.reqConfigNames(arg_2_0)
	return {
		"fight_asfd",
		"fight_asfd_emitter_position",
		"fight_asfd_const"
	}
end

function var_0_0.onConfigLoaded(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == "fight_asfd" then
		arg_3_0:buildFightASFDConfig(arg_3_2)
	elseif arg_3_1 == "fight_asfd_const" then
		arg_3_0:buildFightASFDConstConfig(arg_3_2)
	end
end

function var_0_0.buildFightASFDConfig(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.configDict

	arg_4_0.defaultEmitterCo = var_4_0[1]
	arg_4_0.defaultMissileCo = var_4_0[2]
	arg_4_0.defaultExplosionCo = var_4_0[3]
	arg_4_0.defaultBornCo = var_4_0[7]
	arg_4_0.unitListDict = {
		[FightEnum.ASFDUnit.Emitter] = {},
		[FightEnum.ASFDUnit.Missile] = {},
		[FightEnum.ASFDUnit.Explosion] = {},
		[FightEnum.ASFDUnit.Born] = {}
	}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.configList) do
		local var_4_1 = arg_4_0.unitListDict[iter_4_1.unit]

		if var_4_1 then
			table.insert(var_4_1, iter_4_1)
		end
	end

	table.sort(arg_4_0.unitListDict[FightEnum.ASFDUnit.Emitter], arg_4_0.sortASFDCo)
	table.sort(arg_4_0.unitListDict[FightEnum.ASFDUnit.Missile], arg_4_0.sortASFDCo)
	table.sort(arg_4_0.unitListDict[FightEnum.ASFDUnit.Explosion], arg_4_0.sortASFDCo)
	table.sort(arg_4_0.unitListDict[FightEnum.ASFDUnit.Born], arg_4_0.sortASFDCo)
end

function var_0_0.sortASFDCo(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0.priority
	local var_5_1 = arg_5_1.priority

	if var_5_0 ~= var_5_1 then
		return var_5_1 < var_5_0
	end

	return arg_5_0.id > arg_5_1.id
end

function var_0_0.buildFightASFDConstConfig(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1.configDict

	arg_6_0.flyDuration = tonumber(var_6_0[1].value)
	arg_6_0.missileInterval = tonumber(var_6_0[2].value)
	arg_6_0.explosionDuration = tonumber(var_6_0[3].value)
	arg_6_0.randomRadius = tonumber(var_6_0[4].value)
	arg_6_0.skillId = tonumber(var_6_0[5].value)
	arg_6_0.hitHangPoint = var_6_0[11].value
	arg_6_0.maDiErDaCritScale = tonumber(var_6_0[12].value)
	arg_6_0.fissionScale = tonumber(var_6_0[13].value)
	arg_6_0.emitterWaitTime = tonumber(var_6_0[14].value)
	arg_6_0.flyReduceInterval = tonumber(var_6_0[15].value)
	arg_6_0.missileReduceInterval = tonumber(var_6_0[16].value)
	arg_6_0.minFlyDuration = tonumber(var_6_0[17].value)
	arg_6_0.minMissileInterval = tonumber(var_6_0[18].value)
	arg_6_0.normalSkillIcon = var_6_0[20].value
	arg_6_0.bigSkillIcon = var_6_0[21].value
	arg_6_0.headIcon = var_6_0[22].value
	arg_6_0.sampleXRate = tonumber(var_6_0[23].value)
	arg_6_0.lineType = tonumber(var_6_0[24].value)
	arg_6_0.emitterCenterOffset = Vector2(0, 0)
	arg_6_0.myASFDConfig = arg_6_0:buildASFDEmitterConfig("法术飞弹-我方")
	arg_6_0.enemyASFDConfig = arg_6_0:buildASFDEmitterConfig("法术飞弹-敌方")
	arg_6_0.startAnimAbUrl = FightHelper.getCameraAniPath("v2a4_asfd/v2a4_asfd_start")
	arg_6_0.endAnimAbUrl = FightHelper.getCameraAniPath("v2a4_asfd/v2a4_asfd_end")
	arg_6_0.startAnim = ResUrl.getCameraAnim("v2a4_asfd/v2a4_asfd_start")
	arg_6_0.endAnim = ResUrl.getCameraAnim("v2a4_asfd/v2a4_asfd_end")
end

function var_0_0.buildASFDEmitterConfig(arg_7_0, arg_7_1)
	return {
		uniqueSkill_point = 5,
		name = arg_7_1
	}
end

function var_0_0.getASFDEmitterConfig(arg_8_0, arg_8_1)
	return arg_8_1 == FightEnum.EntitySide.EnemySide and arg_8_0.enemyASFDConfig or arg_8_0.myASFDConfig
end

function var_0_0.getUnitList(arg_9_0, arg_9_1)
	return arg_9_0.unitListDict[arg_9_1]
end

function var_0_0.getMissileInterval(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_0.missileInterval - (arg_10_1 - 1) * arg_10_0.missileReduceInterval

	return math.max(arg_10_0.minMissileInterval, var_10_0)
end

function var_0_0.getFlyDuration(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0.flyDuration - (arg_11_1 - 1) * arg_11_0.flyReduceInterval

	return math.max(arg_11_0.minFlyDuration, var_11_0)
end

function var_0_0.getSkillCo(arg_12_0)
	if not arg_12_0.skillLCo then
		arg_12_0.skillCo = lua_skill.configDict[arg_12_0.skillId]
	end

	return arg_12_0.skillCo
end

var_0_0.instance = var_0_0.New()

return var_0_0
