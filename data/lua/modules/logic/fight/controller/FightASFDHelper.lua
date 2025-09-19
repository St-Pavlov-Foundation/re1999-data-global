module("modules.logic.fight.controller.FightASFDHelper", package.seeall)

local var_0_0 = _M

function var_0_0.getMissileTargetId(arg_1_0)
	if not arg_1_0 then
		return
	end

	if arg_1_0.actEffect then
		for iter_1_0, iter_1_1 in ipairs(arg_1_0.actEffect) do
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

function var_0_0.mathReplyRule(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.replaceRule

	if string.nilorempty(var_4_0) then
		return true
	end

	local var_4_1 = FightStrUtil.instance:getSplitString2Cache(var_4_0, true)

	for iter_4_0, iter_4_1 in ipairs(var_4_1) do
		local var_4_2 = iter_4_1[1]

		if var_4_2 == FightEnum.ASFDReplyRule.HasSkin then
			if not var_0_0.checkHasSkinRule(iter_4_1, arg_4_0) then
				return false
			end
		elseif var_4_2 == FightEnum.ASFDReplyRule.HasBuffActId and not var_0_0.checkHasBuffActIdRule(iter_4_1, arg_4_0) then
			return false
		end
	end

	return true
end

function var_0_0.checkHasSkinRule(arg_5_0, arg_5_1)
	for iter_5_0 = 2, #arg_5_0 do
		if FightHelper.hasSkinId(arg_5_0[iter_5_0]) then
			return true
		end
	end

	return false
end

function var_0_0.checkHasBuffActIdRule(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1 and FightDataHelper.entityMgr:getById(arg_6_1)

	return var_6_0 and var_6_0:hasBuffActId(arg_6_0[2])
end

function var_0_0.sortASFDCo(arg_7_0, arg_7_1)
	return arg_7_0.priority > arg_7_1.priority
end

var_0_0.tempCoList = {}

function var_0_0.getASFDCo(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = FightASFDConfig.instance:getUnitList(arg_8_1)

	if not var_8_0 then
		return arg_8_2
	end

	tabletool.clear(var_0_0.tempCoList)

	for iter_8_0, iter_8_1 in ipairs(var_8_0) do
		if var_0_0.mathReplyRule(arg_8_0, iter_8_1) then
			table.insert(var_0_0.tempCoList, iter_8_1)
		end
	end

	if #var_0_0.tempCoList < 1 then
		return arg_8_2
	end

	table.sort(var_0_0.tempCoList, var_0_0.sortASFDCo)

	return var_0_0.tempCoList[1]
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

function var_0_0.getEmitterPos(arg_13_0, arg_13_1)
	local var_13_0 = FightModel.instance:getFightParam()
	local var_13_1 = FightModel.instance:getCurWaveId() or 1
	local var_13_2 = var_13_0 and var_13_0:getScene(var_13_1) or 1
	local var_13_3 = lua_fight_asfd_emitter_position.configDict[var_13_2] or lua_fight_asfd_emitter_position.configDict[1]
	local var_13_4 = arg_13_1 and var_13_3[arg_13_1]

	var_13_4 = var_13_4 or var_13_3[1]

	local var_13_5 = arg_13_0 == FightEnum.EntitySide.MySide and var_13_4.mySidePos or var_13_4.enemySidePos

	return var_13_5[1], var_13_5[2], var_13_5[3]
end

function var_0_0.getStartPos(arg_14_0, arg_14_1)
	local var_14_0, var_14_1, var_14_2 = var_0_0.getEmitterPos(arg_14_0, arg_14_1)
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

function var_0_0.getEndPos(arg_15_0, arg_15_1)
	arg_15_1 = arg_15_1 or FightASFDConfig.instance.hitHangPoint

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

	local var_24_0 = arg_24_0.actEffect

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

function var_0_0.getStepContext(arg_25_0, arg_25_1)
	if arg_25_0 then
		for iter_25_0, iter_25_1 in ipairs(arg_25_0.actEffect) do
			if iter_25_1.effectType == FightEnum.EffectType.EMITTERFIGHTNOTIFY then
				local var_25_0

				if not string.nilorempty(iter_25_1.reserveStr) then
					var_25_0 = cjson.decode(iter_25_1.reserveStr)
				end

				if not var_25_0.emitterAttackNum then
					var_25_0.emitterAttackNum = arg_25_1
				end

				if not var_25_0.emitterAttackMaxNum then
					var_25_0.emitterAttackMaxNum = arg_25_1
				end

				return var_25_0
			end
		end
	end
end

function var_0_0.isALFPullOutStep(arg_26_0, arg_26_1)
	local var_26_0 = var_0_0.getStepContext(arg_26_0, arg_26_1)

	if not var_26_0 then
		return false
	end

	if not var_26_0.emitterAttackNum or not var_26_0.emitterAttackMaxNum then
		return false
	end

	if var_26_0.emitterAttackNum < var_26_0.emitterAttackMaxNum then
		return false
	end

	local var_26_1 = arg_26_0.fromId
	local var_26_2 = var_26_1 and FightDataHelper.entityMgr:getById(var_26_1)

	return var_26_2 and var_26_2:hasBuffActId(924)
end

var_0_0.tempVector2_A = Vector2(-1, 0)
var_0_0.tempVector2_B = Vector2()

function var_0_0.getZRotation(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	var_0_0.tempVector2_B:Set(arg_27_2 - arg_27_0, arg_27_3 - arg_27_1)

	local var_27_0 = Mathf.Sign(var_0_0.tempVector2_A.x * var_0_0.tempVector2_B.y - var_0_0.tempVector2_A.y * var_0_0.tempVector2_B.x)

	return Vector2.Angle(var_0_0.tempVector2_A, var_0_0.tempVector2_B) * var_27_0
end

function var_0_0.getLastRoundRecordCardEnergyByEntityMo(arg_28_0)
	if not arg_28_0 then
		return
	end

	local var_28_0 = arg_28_0:getBuffDic()

	if not var_28_0 then
		return
	end

	local var_28_1 = FightModel.instance:getCurRoundId() - 1

	for iter_28_0, iter_28_1 in pairs(var_28_0) do
		for iter_28_2, iter_28_3 in ipairs(iter_28_1.actInfo) do
			if iter_28_3.actId == FightEnum.BuffActId.NoUseCardEnergyRecordByRound then
				local var_28_2 = iter_28_3.strParam
				local var_28_3 = FightStrUtil.instance:getSplitString2Cache(var_28_2, true, "|", "#")

				for iter_28_4, iter_28_5 in ipairs(var_28_3) do
					if iter_28_5[1] == var_28_1 then
						return iter_28_5[2]
					end
				end
			end
		end
	end
end

function var_0_0.getLastRoundRecordCardEnergy()
	local var_29_0 = var_0_0.TempEntityMoList

	tabletool.clear(var_29_0)

	local var_29_1 = FightDataHelper.entityMgr:getMyNormalList(var_29_0)

	for iter_29_0, iter_29_1 in ipairs(var_29_1) do
		local var_29_2 = var_0_0.getLastRoundRecordCardEnergyByEntityMo(iter_29_1)

		if var_29_2 then
			return var_29_2
		end
	end

	return 0
end

return var_0_0
