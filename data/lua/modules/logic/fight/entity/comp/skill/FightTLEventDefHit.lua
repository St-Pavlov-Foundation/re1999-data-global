module("modules.logic.fight.entity.comp.skill.FightTLEventDefHit", package.seeall)

local var_0_0 = class("FightTLEventDefHit", FightTimelineTrackItem)
local var_0_1 = {}

var_0_0.directCharacterHitEffectType = {
	[-666] = true,
	[FightEnum.EffectType.MISS] = true,
	[FightEnum.EffectType.DAMAGE] = true,
	[FightEnum.EffectType.CRIT] = true,
	[FightEnum.EffectType.SHIELD] = true,
	[FightEnum.EffectType.SHIELDDEL] = true
}

local var_0_2 = {
	[FightEnum.EffectType.ORIGINDAMAGE] = true,
	[FightEnum.EffectType.ORIGINCRIT] = true
}

var_0_0.originHitEffectType = var_0_2

local var_0_3 = {
	[FightEnum.EffectType.ADDITIONALDAMAGE] = true,
	[FightEnum.EffectType.ADDITIONALDAMAGECRIT] = true
}

function var_0_0.setContext(arg_1_0, arg_1_1)
	arg_1_0._context = arg_1_1
end

function var_0_0.onTrackStart(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	arg_2_0._paramsArr = arg_2_3
	arg_2_0.fightStepData = arg_2_1
	arg_2_0._duration = arg_2_2
	arg_2_0._attacker = FightHelper.getEntity(arg_2_1.fromId)
	arg_2_0._defeAction = arg_2_3[1]
	arg_2_0._critAction = not string.nilorempty(arg_2_3[2]) and arg_2_3[2] or arg_2_3[1]
	arg_2_0._missAction = arg_2_3[3]
	arg_2_0._hasRatio = not string.nilorempty(arg_2_3[4])
	arg_2_0._ratio = tonumber(arg_2_3[4]) or 0
	arg_2_0._audioId = tonumber(arg_2_3[5]) or 0
	arg_2_0._isLastHit = arg_2_3[6] == "1"

	local var_2_0 = FightStrUtil.instance:getSplitToNumberCache(arg_2_3[7], "#")
	local var_2_1 = FightStrUtil.instance:getSplitToNumberCache(arg_2_3[8], "#")
	local var_2_2 = arg_2_3[9]

	if not string.nilorempty(arg_2_3[10]) then
		local var_2_3 = FightStrUtil.instance:getSplitToNumberCache(arg_2_3[10], "#")

		arg_2_0._act_on_index_entity = var_2_3[2]
		arg_2_0._act_on_entity_count = var_2_3[1]
	else
		arg_2_0._act_on_index_entity = nil
		arg_2_0._act_on_entity_count = nil
	end

	local var_2_4 = arg_2_3[11]

	arg_2_0._floatTotalIndex = nil
	arg_2_0._floatFixedPosArr = nil

	if not string.nilorempty(arg_2_0._paramsArr[12]) then
		arg_2_0._floatFixedPosArr = FightStrUtil.instance:getSplitString2Cache(arg_2_0._paramsArr[12], true)
	end

	arg_2_0._skinId2OffetPos = nil

	if not string.nilorempty(arg_2_0._paramsArr[13]) then
		arg_2_0._skinId2OffetPos = {}

		local var_2_5 = FightStrUtil.instance:getSplitCache(arg_2_0._paramsArr[13], "|")

		for iter_2_0, iter_2_1 in ipairs(var_2_5) do
			local var_2_6 = FightStrUtil.instance:getSplitCache(iter_2_1, "#")
			local var_2_7 = tonumber(var_2_6[1])
			local var_2_8 = FightStrUtil.instance:getSplitToNumberCache(var_2_6[2], ",")

			arg_2_0._skinId2OffetPos[var_2_7] = {
				var_2_8[1],
				var_2_8[2]
			}
		end
	end

	arg_2_0._forcePlayHitForOrigin = arg_2_0._paramsArr[14] == "1"

	arg_2_0:_buildSkillEffect(var_2_0, var_2_1, var_2_2)

	arg_2_0._floatParams = {}
	arg_2_0._defenders = {}
	arg_2_0._hitActionDefenders = {}

	local var_2_9 = {}

	if arg_2_0._act_on_index_entity then
		var_2_9 = arg_2_0:_directCharacterDataFilter()
	else
		var_2_9 = arg_2_0.fightStepData.actEffect
	end

	arg_2_0:_preProcessShieldData(arg_2_1, arg_2_0.fightStepData.actEffect)

	for iter_2_2, iter_2_3 in ipairs(var_2_9) do
		if not arg_2_0:needFilter(iter_2_3) then
			local var_2_10 = iter_2_3.effectType
			local var_2_11 = FightHelper.getEntity(iter_2_3.targetId)

			if var_0_0.directCharacterHitEffectType[iter_2_3.effectType] then
				if var_2_11 then
					table.insert(arg_2_0._defenders, var_2_11)

					if iter_2_3.effectType == FightEnum.EffectType.SHIELDDEL then
						FightWorkEffectShieldDel.New(arg_2_1, iter_2_3):start()
					elseif iter_2_3.configEffect == FightEnum.DirectDamageType then
						arg_2_0:_playDefHit(var_2_11, iter_2_3)
					elseif var_2_4 == tostring(iter_2_3.configEffect) then
						-- block empty
					else
						arg_2_0:_playDefHit(var_2_11, iter_2_3)
					end
				else
					logNormal("defender hit fail, entity not exist: " .. iter_2_3.targetId)
				end
			end

			if arg_2_0._isLastHit and var_0_2[iter_2_3.effectType] and var_2_11 then
				arg_2_0:_playDefHit(var_2_11, iter_2_3)
			end

			if arg_2_0._isLastHit and (var_2_10 == FightEnum.EffectType.GUARDCHANGE or var_2_10 == FightEnum.EffectType.GUARDBREAK) then
				arg_2_0._guardEffectList = arg_2_0._guardEffectList or {}

				local var_2_12 = FightStepBuilder.ActEffectWorkCls[var_2_10].New(arg_2_0.fightStepData, iter_2_3)

				var_2_12:start()
				table.insert(arg_2_0._guardEffectList, var_2_12)
			end

			if arg_2_0._isLastHit and var_0_3[iter_2_3.effectType] and var_2_11 then
				arg_2_0:_playDefHit(var_2_11, iter_2_3)
			end
		end
	end

	if arg_2_0._ratio > 0 then
		arg_2_0:_statisticAndFloat()
	end

	arg_2_0:_playSkillBuff(var_2_9)
	arg_2_0:_playSkillBehavior()
	arg_2_0:_trySetKillTimeScale(arg_2_1, arg_2_3)
end

local var_0_4 = {
	[FightEnum.EffectType.DEADLYPOISONORIGINDAMAGE] = true,
	[FightEnum.EffectType.DEADLYPOISONORIGINCRIT] = true
}

function var_0_0.needFilter(arg_3_0, arg_3_1)
	if not arg_3_1 then
		return false
	end

	if arg_3_1.effectType == FightEnum.EffectType.SHIELD and var_0_4[arg_3_1.configEffect] then
		return true
	end
end

function var_0_0.onTrackEnd(arg_4_0)
	if arg_4_0._defenders and #arg_4_0._defenders > 0 then
		arg_4_0:_onDelayActionFinish()
	end
end

function var_0_0._preProcessShieldData(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_1.hasProcessShield then
		return
	end

	arg_5_1.hasProcessShield = true

	local var_5_0 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_2) do
		if iter_5_1.effectType == FightEnum.EffectType.SHIELD then
			local var_5_1 = FightHelper.getEntity(iter_5_1.targetId)

			if var_5_1 then
				local var_5_2 = var_5_0[iter_5_1.targetId]

				if not var_5_2 then
					local var_5_3 = var_5_1:getMO()

					var_5_2 = var_5_3 and var_5_3.shieldValue or 0
					var_5_0[iter_5_1.targetId] = var_5_2
				end

				iter_5_1.diffValue = math.abs(iter_5_1.effectNum - var_5_2)
				iter_5_1.sign = var_5_2 < iter_5_1.effectNum and 1 or -1

				local var_5_4 = arg_5_2[iter_5_0 + 1]

				if var_5_4 and var_5_4.effectType == FightEnum.EffectType.SHIELDBROCKEN then
					var_5_4 = arg_5_2[iter_5_0 + 2]
				end

				if var_5_4 and var_5_4.targetId == iter_5_1.targetId and var_0_2[var_5_4.effectType] then
					iter_5_1.isShieldOriginDamage = true
					var_5_4.shieldOriginEffectNum = var_5_4.effectNum + iter_5_1.diffValue
				end

				if iter_5_1.configEffect == FightEnum.EffectType.ADDITIONALDAMAGE or iter_5_1.configEffect == FightEnum.EffectType.ADDITIONALDAMAGECRIT then
					iter_5_1.isShieldAdditionalDamage = true
					var_5_4.shieldAdditionalEffectNum = var_5_4.effectNum + iter_5_1.diffValue
				end

				var_5_0[iter_5_1.targetId] = iter_5_1.effectNum
			end
		end

		if iter_5_1.effectType == FightEnum.EffectType.SHIELDDEL then
			var_5_0[iter_5_1.targetId] = 0
		end

		if iter_5_1.effectType == FightEnum.EffectType.SHIELDVALUECHANGE then
			var_5_0[iter_5_1.targetId] = iter_5_1.effectNum
		end
	end
end

function var_0_0._buildSkillEffect(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0._buffIdDict = {}
	arg_6_0._behaviorTypeDict = {}

	if string.nilorempty(arg_6_3) then
		for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
			arg_6_0._buffIdDict[iter_6_1] = true
		end

		for iter_6_2, iter_6_3 in ipairs(arg_6_2) do
			arg_6_0._behaviorTypeDict[iter_6_3] = true
		end
	else
		local var_6_0 = FightStrUtil.instance:getSplitToNumberCache(arg_6_3, "#")

		for iter_6_4, iter_6_5 in ipairs(var_6_0) do
			local var_6_1 = lua_skill_effect.configDict[iter_6_5]

			if var_6_1 then
				for iter_6_6 = 1, FightEnum.MaxBehavior do
					local var_6_2 = var_6_1["behavior" .. iter_6_6]
					local var_6_3 = FightStrUtil.instance:getSplitToNumberCache(var_6_2, "#")
					local var_6_4 = var_6_3[1]

					if var_6_3 and #var_6_3 > 0 and var_6_4 == 1 then
						local var_6_5 = var_6_3[2]

						arg_6_0._buffIdDict[var_6_5] = true
					end

					if var_6_3 and #var_6_3 > 0 then
						arg_6_0._behaviorTypeDict[var_6_4] = true
					end
				end
			else
				logError("技能调用效果不存在" .. iter_6_5)
			end
		end
	end
end

function var_0_0._playDefHit(arg_7_0, arg_7_1, arg_7_2)
	FightDataHelper.playEffectData(arg_7_2)

	local var_7_0 = arg_7_0._attacker:getMO()
	local var_7_1 = arg_7_1:getMO()

	arg_7_0:com_sendFightEvent(FightEvent.PlayTimelineHit, arg_7_0.fightStepData, var_7_1, var_7_0)

	local var_7_2 = var_7_0 and var_7_0:getCO()
	local var_7_3 = var_7_1 and var_7_1:getCO()
	local var_7_4 = var_7_2 and var_7_2.career or 0
	local var_7_5 = var_7_3 and var_7_3.career or 0

	if FightModel.instance:getVersion() >= 2 and var_7_0 and var_7_1 then
		var_7_4 = var_7_0.career
		var_7_5 = var_7_1.career
	end

	local var_7_6 = FightConfig.instance:getRestrain(var_7_4, var_7_5) or 1000

	if var_7_0 and FightBuffHelper.restrainAll(var_7_0.id) then
		var_7_6 = 1100
	end

	local var_7_7 = arg_7_0._attacker.buff

	if var_7_7 and var_7_7:haveBuffId(72540006) then
		var_7_6 = (var_7_5 == 1 or var_7_5 == 2 or var_7_5 == 3 or var_7_5 == 4) and 1100 or 1000
	end

	local var_7_8

	if arg_7_0._floatFixedPosArr then
		arg_7_0._floatTotalIndex = arg_7_0._floatTotalIndex and arg_7_0._floatTotalIndex + 1 or 1
		var_7_8 = arg_7_0._floatFixedPosArr[arg_7_0._floatTotalIndex] or arg_7_0._floatFixedPosArr[#arg_7_0._floatFixedPosArr]
	end

	if arg_7_2.effectType == FightEnum.EffectType.DAMAGE or arg_7_2.effectType == -666 then
		local var_7_9 = arg_7_0:_calcNum(arg_7_2.clientId, arg_7_2.targetId, arg_7_2.effectNum, arg_7_0._ratio)

		if arg_7_1.nameUI then
			arg_7_1.nameUI:addHp(-var_7_9)
		end

		local var_7_10 = var_7_6 == 1000 and FightEnum.FloatType.damage or var_7_6 > 1000 and FightEnum.FloatType.restrain or FightEnum.FloatType.berestrain
		local var_7_11 = arg_7_1:isMySide() and -var_7_9 or var_7_9

		table.insert(arg_7_0._floatParams, {
			arg_7_2.targetId,
			var_7_10,
			var_7_11
		})

		if var_7_9 ~= 0 then
			arg_7_0:_checkPlayAction(arg_7_1, arg_7_0._defeAction, arg_7_2)
		end

		arg_7_0:_playHitAudio(arg_7_1, false)
		arg_7_0:_playHitVoice(arg_7_1)
		arg_7_0:_playDefRestrain(arg_7_1, var_7_6)
		FightController.instance:dispatchEvent(FightEvent.OnHpChange, arg_7_1, -var_7_9)
		FightController.instance:dispatchEvent(FightEvent.OnSkillDamage, arg_7_0.fightStepData, arg_7_2, arg_7_1, var_7_11, arg_7_0._isLastHit, var_7_8)
	elseif arg_7_2.effectType == FightEnum.EffectType.CRIT then
		local var_7_12 = arg_7_0:_calcNum(arg_7_2.clientId, arg_7_2.targetId, arg_7_2.effectNum, arg_7_0._ratio)

		if arg_7_1.nameUI then
			arg_7_1.nameUI:addHp(-var_7_12)
		end

		local var_7_13 = var_7_6 == 1000 and FightEnum.FloatType.crit_damage or var_7_6 > 1000 and FightEnum.FloatType.crit_restrain or FightEnum.FloatType.crit_berestrain
		local var_7_14 = arg_7_1:isMySide() and -var_7_12 or var_7_12

		table.insert(arg_7_0._floatParams, {
			arg_7_2.targetId,
			var_7_13,
			var_7_14
		})

		if var_7_12 ~= 0 then
			arg_7_0:_checkPlayAction(arg_7_1, arg_7_0._critAction, arg_7_2)
		end

		arg_7_0:_playHitAudio(arg_7_1, true)
		arg_7_0:_playHitVoice(arg_7_1)
		arg_7_0:_playDefRestrain(arg_7_1, var_7_6)
		FightController.instance:dispatchEvent(FightEvent.OnHpChange, arg_7_1, -var_7_12)
		FightController.instance:dispatchEvent(FightEvent.OnSkillDamage, arg_7_0.fightStepData, arg_7_2, arg_7_1, var_7_14, arg_7_0._isLastHit, var_7_8)
	elseif arg_7_2.effectType == FightEnum.EffectType.MISS then
		if arg_7_0._ratio > 0 then
			arg_7_0:_checkPlayAction(arg_7_1, arg_7_0._missAction, arg_7_2)
			FightFloatMgr.instance:float(arg_7_2.targetId, FightEnum.FloatType.buff, luaLang("fight_float_miss"), FightEnum.BuffFloatEffectType.Good)
		end
	elseif arg_7_2.effectType == FightEnum.EffectType.SHIELD then
		local var_7_15 = var_7_1.shieldValue
		local var_7_16 = arg_7_0:_calcNum(arg_7_2.clientId, arg_7_2.targetId, arg_7_2.diffValue or 0, arg_7_0._ratio)
		local var_7_17 = arg_7_1:isMySide() and -var_7_16 or var_7_16

		if arg_7_1.nameUI then
			arg_7_1.nameUI:setShield(arg_7_1.nameUI._curShield + var_7_16 * arg_7_2.sign)
		end

		if arg_7_2.sign == -1 then
			if not arg_7_2.isShieldOriginDamage and not arg_7_2.isShieldAdditionalDamage then
				local var_7_18 = var_7_6 == 1000 and FightEnum.FloatType.shield_damage or var_7_6 > 1000 and FightEnum.FloatType.shield_restrain or FightEnum.FloatType.shield_berestrain

				table.insert(arg_7_0._floatParams, {
					arg_7_2.targetId,
					var_7_18,
					var_7_17
				})
			end

			local var_7_19 = true

			if not FightHelper.checkShieldHit(arg_7_2) then
				var_7_19 = false
			end

			if arg_7_2.effectNum1 == FightEnum.EffectType.ORIGINDAMAGE and not arg_7_0._forcePlayHitForOrigin then
				var_7_19 = false
			end

			if arg_7_2.effectNum1 == FightEnum.EffectType.ORIGINCRIT and not arg_7_0._forcePlayHitForOrigin then
				var_7_19 = false
			end

			if var_7_16 ~= 0 and var_7_19 then
				arg_7_0:_checkPlayAction(arg_7_1, arg_7_0._defeAction, arg_7_2)
			end

			if var_7_19 then
				arg_7_0:_playHitAudio(arg_7_1, false)
				arg_7_0:_playHitVoice(arg_7_1)
				arg_7_0:_playDefRestrain(arg_7_1, var_7_6)
			end
		end

		FightController.instance:dispatchEvent(FightEvent.OnShieldChange, arg_7_1, var_7_16 * arg_7_2.sign)
		FightController.instance:dispatchEvent(FightEvent.OnSkillDamage, arg_7_0.fightStepData, arg_7_2, arg_7_1, var_7_17, arg_7_0._isLastHit, var_7_8)
	elseif var_0_2[arg_7_2.effectType] then
		local var_7_20 = arg_7_2.effectNum
		local var_7_21 = arg_7_2.effectType == FightEnum.EffectType.ORIGINCRIT

		if var_7_20 > 0 and arg_7_1.nameUI then
			arg_7_1.nameUI:addHp(-var_7_20)
		end

		local var_7_22 = var_7_21 and FightEnum.FloatType.crit_damage_origin or FightEnum.FloatType.damage_origin
		local var_7_23 = arg_7_1:isMySide() and -var_7_20 or var_7_20

		if not arg_7_2.shieldOriginEffectNum then
			if var_7_20 > 0 then
				table.insert(arg_7_0._floatParams, {
					arg_7_2.targetId,
					var_7_22,
					var_7_23
				})
			end
		else
			local var_7_24 = arg_7_1:isMySide() and -arg_7_2.shieldOriginEffectNum or arg_7_2.shieldOriginEffectNum

			table.insert(arg_7_0._floatParams, {
				arg_7_2.targetId,
				var_7_22,
				var_7_24
			})
		end

		if var_7_20 > 0 then
			FightController.instance:dispatchEvent(FightEvent.OnHpChange, arg_7_1, -var_7_20)
			FightController.instance:dispatchEvent(FightEvent.OnSkillDamage, arg_7_0.fightStepData, arg_7_2, arg_7_1, var_7_23, arg_7_0._isLastHit, var_7_8)
		end

		if arg_7_0._forcePlayHitForOrigin then
			arg_7_0:_checkPlayAction(arg_7_1, arg_7_0._defeAction, arg_7_2)
			arg_7_0:_playHitAudio(arg_7_1, false)
			arg_7_0:_playHitVoice(arg_7_1)
			arg_7_0:_playDefRestrain(arg_7_1, var_7_6)
		end
	elseif var_0_3[arg_7_2.effectType] then
		local var_7_25 = arg_7_2.effectNum
		local var_7_26 = arg_7_2.effectType == FightEnum.EffectType.ADDITIONALDAMAGECRIT

		if var_7_25 > 0 and arg_7_1.nameUI then
			arg_7_1.nameUI:addHp(-var_7_25)
		end

		local var_7_27 = var_7_26 and FightEnum.FloatType.crit_additional_damage or FightEnum.FloatType.additional_damage
		local var_7_28 = arg_7_1:isMySide() and -var_7_25 or var_7_25

		if not arg_7_2.shieldAdditionalEffectNum then
			if var_7_25 > 0 then
				table.insert(arg_7_0._floatParams, {
					arg_7_2.targetId,
					var_7_27,
					var_7_28
				})
			end
		else
			local var_7_29 = arg_7_1:isMySide() and -arg_7_2.shieldAdditionalEffectNum or arg_7_2.shieldAdditionalEffectNum

			table.insert(arg_7_0._floatParams, {
				arg_7_2.targetId,
				var_7_27,
				var_7_29
			})
		end

		if var_7_25 > 0 then
			FightController.instance:dispatchEvent(FightEvent.OnHpChange, arg_7_1, -var_7_25)
			FightController.instance:dispatchEvent(FightEvent.OnSkillDamage, arg_7_0.fightStepData, arg_7_2, arg_7_1, var_7_28, arg_7_0._isLastHit, var_7_8)
		end
	end

	FightDataHelper.playEffectData(arg_7_2)
end

function var_0_0._statisticAndFloat(arg_8_0)
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_0._floatParams) do
		local var_8_1 = iter_8_1[1]
		local var_8_2 = iter_8_1[2]
		local var_8_3 = iter_8_1[3]
		local var_8_4 = var_8_0[var_8_1]

		if not var_8_4 then
			var_8_4 = {
				list = {}
			}
			var_8_0[var_8_1] = var_8_4
		end

		if not var_8_4[var_8_2] then
			local var_8_5 = {
				floatType = var_8_2,
				num = var_8_3
			}

			table.insert(var_8_4.list, var_8_5)

			var_8_4[var_8_2] = var_8_5
		else
			local var_8_6 = var_8_4[var_8_2]

			var_8_6.num = var_8_6.num + var_8_3
		end
	end

	local var_8_7 = 1

	for iter_8_2, iter_8_3 in pairs(var_8_0) do
		local var_8_8 = {}

		for iter_8_4, iter_8_5 in pairs(iter_8_3) do
			local var_8_9 = iter_8_5.num

			if var_8_9 and var_8_9 ~= 0 then
				local var_8_10 = iter_8_4

				if iter_8_4 == FightEnum.FloatType.shield_damage then
					var_8_10 = iter_8_3[FightEnum.FloatType.damage] and FightEnum.FloatType.damage or FightEnum.FloatType.crit_damage
				elseif iter_8_4 == FightEnum.FloatType.shield_restrain then
					var_8_10 = iter_8_3[FightEnum.FloatType.restrain] and FightEnum.FloatType.restrain or FightEnum.FloatType.crit_restrain
				elseif iter_8_4 == FightEnum.FloatType.shield_berestrain then
					var_8_10 = iter_8_3[FightEnum.FloatType.berestrain] and FightEnum.FloatType.berestrain or FightEnum.FloatType.crit_berestrain
				end

				if var_8_10 ~= iter_8_4 then
					iter_8_3[iter_8_4] = 0
					iter_8_5.num = 0

					if iter_8_3[var_8_10] then
						local var_8_11 = iter_8_3[var_8_10]

						var_8_11.num = var_8_11.num + var_8_9
					elseif not var_8_8[var_8_10] then
						local var_8_12 = {
							floatType = var_8_10,
							num = var_8_9
						}

						table.insert(iter_8_3.list, var_8_12)

						var_8_8[var_8_10] = var_8_12
					else
						local var_8_13 = var_8_8[var_8_10]

						var_8_13.num = var_8_13.num + var_8_9
					end
				end
			end
		end

		table.sort(iter_8_3.list, var_0_0._sortByFloatType)

		for iter_8_6, iter_8_7 in pairs(iter_8_3.list) do
			local var_8_14 = iter_8_7.floatType
			local var_8_15 = iter_8_7.num

			if var_8_15 ~= 0 then
				local var_8_16

				if arg_8_0._floatFixedPosArr then
					var_8_16 = {}

					if var_8_7 >= #arg_8_0._floatFixedPosArr then
						var_8_7 = #arg_8_0._floatFixedPosArr
					end

					var_8_16.pos_x = arg_8_0._floatFixedPosArr[var_8_7][1]
					var_8_16.pos_y = arg_8_0._floatFixedPosArr[var_8_7][2]
					var_8_7 = var_8_7 + 1
				end

				local var_8_17 = FightHelper.getEntity(iter_8_2)

				if arg_8_0._skinId2OffetPos then
					local var_8_18 = var_8_17:getMO()

					if var_8_18 then
						local var_8_19 = arg_8_0._skinId2OffetPos[var_8_18.skin]

						if var_8_19 then
							var_8_16 = var_8_16 or {}
							var_8_16.offset_x = var_8_19[1]
							var_8_16.offset_y = var_8_19[2]
						end
					end
				end

				FightFloatMgr.instance:float(iter_8_2, var_8_14, var_8_15, var_8_16)
				FightController.instance:dispatchEvent(FightEvent.OnDamageTotal, arg_8_0.fightStepData, var_8_17, var_8_15, arg_8_0._isLastHit)
			end
		end
	end
end

local var_0_5 = {
	[FightEnum.FloatType.additional_damage] = 10,
	[FightEnum.FloatType.crit_additional_damage] = 11,
	[FightEnum.FloatType.damage_origin] = 12,
	[FightEnum.FloatType.crit_damage_origin] = 13
}

function var_0_0._sortByFloatType(arg_9_0, arg_9_1)
	local var_9_0 = var_0_5[arg_9_0.floatType] or 100
	local var_9_1 = var_0_5[arg_9_1.floatType] or 100

	if var_9_0 ~= var_9_1 then
		return var_9_1 < var_9_0
	end

	return arg_9_0.num > arg_9_1.num
end

function var_0_0._playHitAudio(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0._audioId > 0 then
		FightAudioMgr.instance:playHit(arg_10_0._audioId, arg_10_1:getMO().skin, arg_10_2)
	elseif arg_10_0._ratio > 0 and arg_10_0.fightStepData.atkAudioId and arg_10_0.fightStepData.atkAudioId > 0 then
		FightAudioMgr.instance:playHitByAtkAudioId(arg_10_0.fightStepData.atkAudioId, arg_10_1:getMO().skin, arg_10_2)
	end
end

function var_0_0._playHitVoice(arg_11_0, arg_11_1)
	if arg_11_0._isLastHit then
		local var_11_0 = arg_11_1:isMySide()
		local var_11_1 = GameConfig:GetCurVoiceShortcut()
		local var_11_2 = arg_11_1:getMO()
		local var_11_3 = var_11_2 and var_11_2.modelId

		if var_11_0 and var_11_3 then
			local var_11_4, var_11_5, var_11_6 = SettingsRoleVoiceModel.instance:getCharVoiceLangPrefValue(var_11_3)
			local var_11_7 = LangSettings.shortcutTab[var_11_4]

			if not string.nilorempty(var_11_7) and not var_11_6 then
				var_11_1 = var_11_7
			end
		end

		FightAudioMgr.instance:playHitVoice(var_11_3, var_11_1)
	end
end

function var_0_0._playDefRestrain(arg_12_0, arg_12_1, arg_12_2)
	return
end

function var_0_0._calcNum(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if arg_13_0._hasRatio then
		arg_13_0._context.floatNum = arg_13_0._context.floatNum or {}
		arg_13_0._context.floatNum[arg_13_2] = arg_13_0._context.floatNum[arg_13_2] or {}
		arg_13_0._context.floatNum[arg_13_2][arg_13_1] = arg_13_0._context.floatNum[arg_13_2][arg_13_1] or {}

		local var_13_0 = arg_13_0._context.floatNum[arg_13_2][arg_13_1]
		local var_13_1 = var_13_0.ratio or 0
		local var_13_2 = var_13_0.total or 0
		local var_13_3 = arg_13_4 + var_13_1

		var_13_3 = var_13_3 < 1 and var_13_3 or 1

		local var_13_4 = math.floor(var_13_3 * arg_13_3 + 0.5) - var_13_2

		var_13_0.ratio = arg_13_4 + var_13_1
		var_13_0.total = var_13_2 + var_13_4

		return var_13_4
	else
		return 0
	end
end

function var_0_0._checkPlayAction(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	if string.nilorempty(arg_14_2) then
		return
	end

	local var_14_0 = arg_14_1.spine:getAnimState()
	local var_14_1

	for iter_14_0, iter_14_1 in ipairs(arg_14_0.fightStepData.actEffect) do
		if iter_14_1.effectType == FightEnum.EffectType.DEAD and iter_14_1.targetId == arg_14_1.id then
			var_14_1 = true
		end
	end

	if arg_14_0._isLastHit then
		if var_14_1 and arg_14_0.fightStepData.actId == arg_14_1.deadBySkillId and arg_14_0:_canPlayDead(arg_14_3) then
			if arg_14_1:getSide() ~= arg_14_0._attacker:getSide() then
				FightController.instance:dispatchEvent(FightEvent.OnSkillLastHit, arg_14_1.id, arg_14_0.fightStepData)
			end
		elseif var_14_0 ~= SpineAnimState.freeze then
			arg_14_0:_playAction(arg_14_1, arg_14_2)
		end
	elseif var_14_1 and arg_14_0.fightStepData.actId == arg_14_1.deadBySkillId then
		if var_14_0 ~= SpineAnimState.freeze and var_14_0 ~= SpineAnimState.die then
			arg_14_0:_playAction(arg_14_1, arg_14_2)
		end
	elseif var_14_0 ~= SpineAnimState.freeze then
		arg_14_0:_playAction(arg_14_1, arg_14_2)
	end
end

function var_0_0._playAction(arg_15_0, arg_15_1, arg_15_2)
	if arg_15_1.buff:haveBuffId(2112031) then
		return
	end

	arg_15_2 = FightHelper.processEntityActionName(arg_15_1, arg_15_2, arg_15_0.fightStepData)

	arg_15_1.spine:play(arg_15_2, false, true, true)
	arg_15_1.spine:addAnimEventCallback(arg_15_0._onAnimEvent, arg_15_0, {
		arg_15_1,
		arg_15_2
	})
	table.insert(arg_15_0._hitActionDefenders, arg_15_1)

	local var_15_0 = var_0_1[arg_15_1.id] or 0

	var_0_1[arg_15_1.id] = var_15_0 + 1
end

function var_0_0._onAnimEvent(arg_16_0, arg_16_1, arg_16_2, arg_16_3, arg_16_4)
	local var_16_0 = arg_16_4[1]
	local var_16_1 = arg_16_4[2]

	if arg_16_2 == SpineAnimEvent.ActionComplete and arg_16_1 == var_16_1 then
		var_16_0.spine:removeAnimEventCallback(arg_16_0._onAnimEvent, arg_16_0)
		var_16_0:resetAnimState()
	end
end

function var_0_0._onDelayActionFinish(arg_17_0)
	if arg_17_0._hitActionDefenders then
		for iter_17_0, iter_17_1 in ipairs(arg_17_0._hitActionDefenders) do
			iter_17_1.spine:removeAnimEventCallback(arg_17_0._onAnimEvent, arg_17_0)

			local var_17_0 = var_0_1[iter_17_1.id] or 1

			var_0_1[iter_17_1.id] = var_17_0 - 1

			if var_0_1[iter_17_1.id] == 0 then
				iter_17_1:resetAnimState()
			end
		end

		arg_17_0._hitActionDefenders = nil
	end
end

function var_0_0._playSkillBuff(arg_18_0, arg_18_1)
	if GameUtil.tabletool_dictIsEmpty(arg_18_0._buffIdDict) then
		return
	end

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		if FightHelper.getEntity(iter_18_1.targetId) and FightEnum.BuffEffectType[iter_18_1.effectType] and arg_18_0._buffIdDict and arg_18_0._buffIdDict[iter_18_1.buff.buffId] then
			FightSkillBuffMgr.instance:playSkillBuff(arg_18_0.fightStepData, iter_18_1)
		end
	end
end

function var_0_0._playSkillBehavior(arg_19_0)
	if not arg_19_0._behaviorTypeDict then
		return
	end

	FightSkillBehaviorMgr.instance:playSkillBehavior(arg_19_0.fightStepData, arg_19_0._behaviorTypeDict, true)
end

function var_0_0._trySetKillTimeScale(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0._context.hitCount = (arg_20_0._context.hitCount or 0) + 1

	if not (arg_20_2[7] == "1") then
		return
	end

	local var_20_0 = FightHelper.getEntity(arg_20_1.fromId):getMO()

	if not var_20_0 then
		return
	end

	if var_20_0.side ~= FightEnum.EntitySide.MySide or not var_20_0:isCharacter() then
		return
	end

	local var_20_1 = arg_20_1.actId

	if not FightCardDataHelper.isBigSkill(var_20_1) then
		return
	end

	local var_20_2 = false

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.fightStepData.actEffect) do
		if iter_20_1.effectType == FightEnum.EffectType.DEAD then
			var_20_2 = true

			break
		end
	end

	if not var_20_2 then
		return
	end

	if arg_20_0._context.hitCount and arg_20_0._context.hitCount > 1 then
		TaskDispatcher.runDelay(arg_20_0._revertKillTimeScale, arg_20_0, 0.2)
	else
		TaskDispatcher.runDelay(arg_20_0._revertKillTimeScale, arg_20_0, 0.2)
	end
end

function var_0_0._directCharacterDataFilter(arg_21_0)
	local var_21_0 = {}
	local var_21_1 = {}

	for iter_21_0, iter_21_1 in pairs(var_0_0.directCharacterHitEffectType) do
		var_21_1[iter_21_0] = iter_21_1
	end

	for iter_21_2, iter_21_3 in pairs(var_0_2) do
		var_21_1[iter_21_2] = iter_21_3
	end

	for iter_21_4, iter_21_5 in pairs(var_0_3) do
		var_21_1[iter_21_4] = iter_21_5
	end

	local var_21_2 = FightHelper.filterActEffect(arg_21_0.fightStepData.actEffect, var_21_1)
	local var_21_3, var_21_4 = LuaUtil.float2Fraction(arg_21_0._ratio)
	local var_21_5 = #var_21_2
	local var_21_6
	local var_21_7

	if var_21_2[arg_21_0._act_on_index_entity] then
		var_21_7 = var_21_2[arg_21_0._act_on_index_entity][1].targetId
		var_21_6 = arg_21_0._act_on_index_entity
	elseif var_21_5 > 0 then
		var_21_7 = var_21_2[var_21_5][1].targetId
		var_21_6 = var_21_5
	end

	if arg_21_0._act_on_entity_count ~= var_21_5 and var_21_6 == var_21_5 then
		var_21_3, var_21_4 = LuaUtil.divisionOperation2Fraction(arg_21_0._ratio, arg_21_0._act_on_entity_count - var_21_5 + 1)
		arg_21_0._ratio = arg_21_0._ratio / (arg_21_0._act_on_entity_count - var_21_5 + 1)
	end

	for iter_21_6, iter_21_7 in ipairs(arg_21_0.fightStepData.actEffect) do
		if iter_21_7.targetId == var_21_7 then
			table.insert(var_21_0, iter_21_7)
		end
	end

	for iter_21_8 = #var_21_0, 1, -1 do
		local var_21_8 = var_21_0[iter_21_8]

		if not var_21_8 then
			logError("找不到数据")
		end

		if arg_21_0:_detectInvokeActEffect(var_21_8.clientId, var_21_8.targetId, var_21_3, var_21_4) then
			-- block empty
		elseif not var_0_0.directCharacterHitEffectType[var_21_8.effectType] then
			table.remove(var_21_0, iter_21_8)
		end
	end

	return var_21_0
end

function var_0_0._detectInvokeActEffect(arg_22_0, arg_22_1, arg_22_2, arg_22_3, arg_22_4)
	if arg_22_0._hasRatio then
		if not arg_22_0._context.ratio_fraction then
			arg_22_0._context.ratio_fraction = {}
		end

		if not arg_22_0._context.ratio_fraction[arg_22_2] then
			arg_22_0._context.ratio_fraction[arg_22_2] = arg_22_0._context.ratio_fraction[arg_22_2] or {}
		end

		if not arg_22_0._context.ratio_fraction[arg_22_2][arg_22_1] then
			arg_22_0._context.ratio_fraction[arg_22_2][arg_22_1] = arg_22_0._context.ratio_fraction[arg_22_2][arg_22_1] or {}
			arg_22_0._context.ratio_fraction[arg_22_2][arg_22_1].numerator = 0
			arg_22_0._context.ratio_fraction[arg_22_2][arg_22_1].denominator = 1
		end

		local var_22_0, var_22_1 = LuaUtil.fractionAddition(arg_22_0._context.ratio_fraction[arg_22_2][arg_22_1].numerator, arg_22_0._context.ratio_fraction[arg_22_2][arg_22_1].denominator, arg_22_3, arg_22_4)

		arg_22_0._context.ratio_fraction[arg_22_2][arg_22_1].numerator = var_22_0
		arg_22_0._context.ratio_fraction[arg_22_2][arg_22_1].denominator = var_22_1

		return var_22_1 <= var_22_0
	end

	return true
end

function var_0_0._canPlayDead(arg_23_0, arg_23_1)
	if arg_23_0._context.ratio_fraction and arg_23_0._context.ratio_fraction[arg_23_1.targetId] and arg_23_0._context.ratio_fraction[arg_23_1.targetId][arg_23_1.clientId] then
		return arg_23_0._context.ratio_fraction[arg_23_1.targetId][arg_23_1.clientId].numerator >= arg_23_0._context.ratio_fraction[arg_23_1.targetId][arg_23_1.clientId].denominator
	end

	return true
end

function var_0_0._revertKillTimeScale(arg_24_0)
	GameTimeMgr.instance:setTimeScale(GameTimeMgr.TimeScaleType.FightKillEnemy, 1)
end

function var_0_0.onDestructor(arg_25_0)
	arg_25_0:_onDelayActionFinish()

	if arg_25_0._guardEffectList then
		for iter_25_0, iter_25_1 in ipairs(arg_25_0._guardEffectList) do
			iter_25_1:disposeSelf()
		end

		arg_25_0._guardEffectList = nil
	end

	arg_25_0:_revertKillTimeScale()
	TaskDispatcher.cancelTask(arg_25_0._revertKillTimeScale, arg_25_0)

	arg_25_0._defenders = nil
	arg_25_0._attacker = nil
end

return var_0_0
