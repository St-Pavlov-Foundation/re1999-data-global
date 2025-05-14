module("modules.logic.fight.controller.FightASFDHelper", package.seeall)

local var_0_0 = _M

function var_0_0.getMissileTargetId(arg_1_0)
	if not arg_1_0 then
		return
	end

	if arg_1_0.actEffectMOs then
		for iter_1_0, iter_1_1 in ipairs(arg_1_0.actEffectMOs) do
			if var_0_0.isDamageEffect(iter_1_1.effectType) then
				return iter_1_1.targetId
			end
		end
	end

	return arg_1_0.toId
end

var_0_0.DamageEffectTypeDict = {
	[FightEnum.EffectType.MISS] = true,
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.SHIELD] = true,
	[FightEnum.EffectType.SHIELDDEL] = true,
	[FightEnum.EffectType.ADDITIONALDAMAGE] = true,
	[FightEnum.EffectType.ADDITIONALDAMAGECRIT] = true,
	[FightEnum.EffectType.ORIGINDAMAGE] = true,
	[FightEnum.EffectType.ORIGINCRIT] = true
}

function var_0_0.isDamageEffect(arg_2_0)
	return arg_2_0 and var_0_0.DamageEffectTypeDict[arg_2_0]
end

function var_0_0.getASFDType(arg_3_0)
	return FightEnum.ASFDType.Normal
end

function var_0_0.hasASFDFissionEffect(arg_4_0)
	if not arg_4_0 then
		return false
	end

	for iter_4_0, iter_4_1 in ipairs(arg_4_0.actEffectMOs) do
		if iter_4_1.effectType == FightEnum.EffectType.EMITTERSPLITNUM then
			local var_4_0 = iter_4_1.reserveStr

			if not string.nilorempty(var_4_0) then
				local var_4_1 = cjson.decode(var_4_0)

				return var_4_1.splitNum and var_4_1.splitNum > 0
			end
		end
	end

	return false
end

function var_0_0.mathReplyRule(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1.replaceRule

	if string.nilorempty(var_5_0) then
		return true
	end

	local var_5_1 = FightStrUtil.instance:getSplitString2Cache(var_5_0, true)

	for iter_5_0, iter_5_1 in ipairs(var_5_1) do
		local var_5_2 = iter_5_1[1]

		if var_5_2 == FightEnum.ASFDReplyRule.HasSkin then
			if not var_0_0.checkHasSkinRule(iter_5_1, arg_5_0) then
				return false
			end
		elseif var_5_2 == FightEnum.ASFDReplyRule.HasBuffActId and not var_0_0.checkHasBuffActIdRule(iter_5_1, arg_5_0) then
			return false
		end
	end

	return true
end

function var_0_0.checkHasSkinRule(arg_6_0, arg_6_1)
	for iter_6_0 = 2, #arg_6_0 do
		if FightHelper.hasSkinId(arg_6_0[iter_6_0]) then
			return true
		end
	end

	return false
end

function var_0_0.checkHasBuffActIdRule(arg_7_0, arg_7_1)
	local var_7_0 = arg_7_1 and FightDataHelper.entityMgr:getById(arg_7_1)

	return var_7_0 and var_7_0:hasBuffActId(arg_7_0[2])
end

function var_0_0.getASFDCo(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = FightASFDConfig.instance:getUnitList(arg_8_1)

	if not var_8_0 then
		return arg_8_2
	end

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if var_0_0.mathReplyRule(arg_8_0, iter_8_1) then
			return iter_8_1
		end
	end

	return arg_8_2
end

function var_0_0.getBornCo(arg_9_0)
	return var_0_0.getASFDCo(arg_9_0, FightEnum.ASFDUnit.Born, FightASFDConfig.instance.defaultBornCo)
end

function var_0_0.getEmitterCo(arg_10_0)
	return var_0_0.getASFDCo(arg_10_0, FightEnum.ASFDUnit.Emitter, FightASFDConfig.instance.defaultEmitterCo)
end

function var_0_0.getMissileCo(arg_11_0)
	return var_0_0.getASFDCo(arg_11_0, FightEnum.ASFDUnit.Missile, FightASFDConfig.instance.defaultMissileCo)
end

function var_0_0.getExplosionCo(arg_12_0)
	return var_0_0.getASFDCo(arg_12_0, FightEnum.ASFDUnit.Explosion, FightASFDConfig.instance.defaultExplosionCo)
end

function var_0_0.getEmitterPos(arg_13_0)
	local var_13_0 = FightModel.instance:getFightParam()
	local var_13_1 = FightModel.instance:getCurWaveId() or 1
	local var_13_2 = var_13_0 and var_13_0:getScene(var_13_1) or 1
	local var_13_3 = lua_fight_asfd_emitter_position.configDict[var_13_2] or lua_fight_asfd_emitter_position.configDict[1]
	local var_13_4 = arg_13_0 == FightEnum.EntitySide.MySide and var_13_3.mySidePos or var_13_3.enemySidePos

	return var_13_4[1], var_13_4[2], var_13_4[3]
end

function var_0_0.getStartPos(arg_14_0)
	local var_14_0, var_14_1, var_14_2 = var_0_0.getEmitterPos(arg_14_0)
	local var_14_3, var_14_4 = GameUtil.getRandomPosInCircle(var_14_0, var_14_1, FightASFDConfig.instance.randomRadius)
	local var_14_5 = FightASFDConfig.instance.emitterCenterOffset

	if arg_14_0 == FightEnum.EntitySide.MySide then
		var_14_3 = var_14_3 - var_14_5.x
	else
		var_14_3 = var_14_3 + var_14_5.x
	end

	local var_14_6 = var_14_4 + var_14_5.y

	return Vector3(var_14_3, var_14_6, var_14_2)
end

function var_0_0.getEndPos(arg_15_0)
	local var_15_0 = FightHelper.getEntity(arg_15_0):getHangPoint(FightASFDConfig.instance.hitHangPoint)

	if not var_15_0 then
		return Vector3(0, 0, 0)
	end

	return var_15_0.transform.position
end

function var_0_0.getRandomValue()
	return math.random(0, 1000) / 1000
end

local var_0_1 = {
	Down = 2,
	Up = 1
}

function var_0_0.changeRandomArea()
	var_0_0.randomAreaY = var_0_0.randomAreaY == var_0_1.Up and var_0_1.Down or var_0_1.Up
end

var_0_0.forbidSampleYRate = 0.1

function var_0_0.getRandomPos(arg_18_0, arg_18_1, arg_18_2)
	local var_18_0 = Vector3()
	local var_18_1 = var_0_0.getRandomValue()
	local var_18_2, var_18_3 = var_0_0.getFormatPos(arg_18_0.x, arg_18_1.x, FightASFDConfig.instance.sampleXRate)

	var_18_0.x = LuaTween.linear(var_18_1, var_18_2, var_18_3 - var_18_2, 1)

	local var_18_4 = var_0_0.getRandomValue()

	var_18_0.z = LuaTween.linear(var_18_4, arg_18_0.z, arg_18_1.z - arg_18_0.z, 1)

	local var_18_5 = var_0_0.getRandomValue()
	local var_18_6 = math.abs(arg_18_1.y - arg_18_0.y)
	local var_18_7 = arg_18_2.sampleMinHeight
	local var_18_8 = arg_18_0.y
	local var_18_9 = arg_18_1.y

	if var_18_7 > 0 and var_18_6 < var_18_7 then
		local var_18_10 = (var_18_7 - var_18_6) / 2

		if var_18_9 < var_18_8 then
			var_18_8 = var_18_8 + var_18_10
			var_18_9 = var_18_9 - var_18_10
		else
			var_18_8 = var_18_8 - var_18_10
			var_18_9 = var_18_9 + var_18_10
		end
	end

	local var_18_11, var_18_12 = var_0_0.getFormatPos(var_18_8, var_18_9, var_0_0.forbidSampleYRate)

	if var_0_0.randomAreaY == var_0_1.Up then
		var_18_9 = var_18_11
	else
		var_18_8 = var_18_12
	end

	var_18_0.y = LuaTween.linear(var_18_5, var_18_8, var_18_9 - var_18_8, 1)

	return var_18_0
end

function var_0_0.getFormatPos(arg_19_0, arg_19_1, arg_19_2)
	arg_19_2 = math.min(1, math.max(0, arg_19_2))

	local var_19_0 = arg_19_2 / 2
	local var_19_1 = 0.5 - var_19_0
	local var_19_2 = 0.5 + var_19_0
	local var_19_3 = arg_19_1 - arg_19_0
	local var_19_4 = LuaTween.linear(var_19_1, arg_19_0, var_19_3, 1)
	local var_19_5 = LuaTween.linear(var_19_2, arg_19_0, var_19_3, 1)

	return var_19_4, var_19_5
end

function var_0_0.getASFDBornRemoveRes(arg_20_0)
	return arg_20_0.res .. "_end"
end

function var_0_0.getASFDEmitterRemoveRes(arg_21_0)
	return arg_21_0.res .. "_end"
end

function var_0_0.getASFDExplosionScale(arg_22_0, arg_22_1, arg_22_2)
	local var_22_0 = arg_22_1.scale

	if var_22_0 == 0 then
		var_22_0 = 1
	end

	if var_0_0._checkTriggerMustCrit(arg_22_0, arg_22_2) and var_0_0._checkHasHeroId() then
		return FightASFDConfig.instance.maDiErDaCritScale * var_22_0
	end

	return var_22_0
end

var_0_0.TempEntityMoList = {}

function var_0_0._checkHasHeroId()
	local var_23_0 = 3041
	local var_23_1 = var_0_0.TempEntityMoList

	tabletool.clear(var_23_1)

	local var_23_2 = FightDataHelper.entityMgr:getMyNormalList(var_23_1)

	for iter_23_0, iter_23_1 in ipairs(var_23_2) do
		if iter_23_1:isCharacter() and iter_23_1.modelId == var_23_0 then
			return true
		end
	end

	return false
end

function var_0_0._checkTriggerMustCrit(arg_24_0, arg_24_1)
	if not arg_24_0 then
		return false
	end

	local var_24_0 = arg_24_0.actEffectMOs

	if not var_24_0 then
		return false
	end

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		if iter_24_1.effectType == FightEnum.EffectType.MUSTCRIT and iter_24_1.reserveId == arg_24_1 then
			return true
		end
	end

	return false
end

return var_0_0
