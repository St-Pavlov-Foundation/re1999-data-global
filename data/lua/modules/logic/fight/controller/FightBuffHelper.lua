module("modules.logic.fight.controller.FightBuffHelper", package.seeall)

local var_0_0 = _M

function var_0_0.isStoneBuff(arg_1_0)
	return FightConfig.instance:hasBuffFeature(arg_1_0, FightEnum.BuffType_Petrified)
end

function var_0_0.isDizzyBuff(arg_2_0)
	return FightConfig.instance:hasBuffFeature(arg_2_0, FightEnum.BuffType_Dizzy)
end

function var_0_0.isSleepBuff(arg_3_0)
	return FightConfig.instance:hasBuffFeature(arg_3_0, FightEnum.BuffType_Sleep)
end

function var_0_0.isFrozenBuff(arg_4_0)
	return FightConfig.instance:hasBuffFeature(arg_4_0, FightEnum.BuffType_Frozen)
end

function var_0_0.isDormantBuff(arg_5_0)
	local var_5_0 = lua_skill_buff.configDict[arg_5_0]

	if var_5_0 and var_5_0.typeId == 8241 then
		return true
	end

	return false
end

function var_0_0.canPlayDormantBuffAni(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_0.buff

	if not var_0_0.isDormantBuff(var_6_0.buffId) then
		return
	end

	local var_6_1 = FightDataHelper.entityMgr:getById(arg_6_0.targetId)

	if not var_6_1 then
		return
	end

	local var_6_2 = 0
	local var_6_3 = var_6_1:getBuffDic()

	for iter_6_0, iter_6_1 in pairs(var_6_3) do
		if var_0_0.isDormantBuff(iter_6_1.buffId) then
			var_6_2 = var_6_2 + 1

			break
		end
	end

	local var_6_4 = var_6_2

	for iter_6_2, iter_6_3 in ipairs(arg_6_1.actEffect) do
		if iter_6_3.buff and var_0_0.isDormantBuff(iter_6_3.buff.buffId) then
			if iter_6_3.effectType == FightEnum.EffectType.BUFFADD then
				var_6_2 = var_6_2 + 1
			elseif iter_6_3.effectType == FightEnum.EffectType.BUFFDEL then
				var_6_2 = var_6_2 - 1
			elseif iter_6_3.effectType == FightEnum.EffectType.BUFFDELNOEFFECT then
				var_6_2 = var_6_2 - 1
			end
		end
	end

	if var_6_4 ~= var_6_2 then
		return 2
	end
end

function var_0_0.simulateBuffList(arg_7_0, arg_7_1)
	if not arg_7_0 then
		return {}
	end

	local var_7_0 = arg_7_0 and arg_7_0:getBuffList()
	local var_7_1 = FightDataHelper.operationDataMgr:getOpList()

	for iter_7_0, iter_7_1 in ipairs(var_7_1) do
		if iter_7_1:isPlayCard() then
			if arg_7_1 and arg_7_1 == iter_7_1 then
				break
			end

			if iter_7_1.clientSimulateCanPlayCard then
				local var_7_2 = lua_skill.configDict[iter_7_1.skillId]

				for iter_7_2 = 1, FightEnum.MaxBehavior do
					local var_7_3 = var_7_2["condition" .. iter_7_2]
					local var_7_4 = var_7_2["behavior" .. iter_7_2]
					local var_7_5 = var_7_2["behaviorTarget" .. iter_7_2]
					local var_7_6 = var_7_2["conditionTarget" .. iter_7_2]

					if var_0_0.checkCanAddBuff(var_7_3) and not string.nilorempty(var_7_4) then
						local var_7_7 = var_7_5

						if var_7_5 == 0 then
							var_7_7 = var_7_2.logicTarget
						elseif var_7_5 == 999 then
							var_7_7 = var_7_6 ~= 0 and var_7_6 or var_7_2.logicTarget
						end

						var_0_0.simulateSkillehavior(arg_7_0, iter_7_1, var_7_4, var_7_7, var_7_0)
					end
				end
			end
		end
	end

	return var_7_0
end

function var_0_0.checkCanAddBuff(arg_8_0)
	if string.nilorempty(arg_8_0) then
		return
	end

	local var_8_0 = FightStrUtil.instance:getSplitCache(arg_8_0, "&")

	if #var_8_0 > 1 then
		local var_8_1 = 0

		for iter_8_0, iter_8_1 in ipairs(var_8_0) do
			if var_0_0.checkSingleConditionCanAddBuff(iter_8_1) then
				var_8_1 = var_8_1 + 1
			end
		end

		if var_8_1 == #var_8_0 then
			return true
		end
	else
		local var_8_2 = FightStrUtil.instance:getSplitCache(arg_8_0, "|")

		if #var_8_2 > 1 then
			for iter_8_2, iter_8_3 in ipairs(var_8_2) do
				if var_0_0.checkSingleConditionCanAddBuff(iter_8_3) then
					return true
				end
			end
		elseif var_0_0.checkSingleConditionCanAddBuff(arg_8_0) then
			return true
		end
	end
end

function var_0_0.checkSingleConditionCanAddBuff(arg_9_0)
	local var_9_0 = FightStrUtil.instance:getSplitCache(arg_9_0, "#")
	local var_9_1 = tonumber(var_9_0[1])
	local var_9_2 = lua_skill_behavior_condition.configDict[var_9_1]

	if not var_9_2 or string.nilorempty(var_9_2.type) then
		return false
	end

	if var_9_2.type == "None" then
		return true
	end
end

function var_0_0.simulateSkillehavior(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	local var_10_0 = FightStrUtil.instance:getSplitToNumberCache(arg_10_2, "#")
	local var_10_1 = var_10_0[1]
	local var_10_2 = lua_skill_behavior.configDict[var_10_1]
	local var_10_3 = false

	if FightEnum.LogicTargetClassify.Special[arg_10_3] then
		-- block empty
	elseif FightEnum.LogicTargetClassify.Single[arg_10_3] then
		if arg_10_1.toId == arg_10_0.id then
			var_10_3 = true
		end
	elseif FightEnum.LogicTargetClassify.SingleAndRandom[arg_10_3] then
		if arg_10_1.toId == arg_10_0.id then
			var_10_3 = true
		end
	elseif FightEnum.LogicTargetClassify.EnemySideAll[arg_10_3] then
		if arg_10_0.side == FightEnum.EntitySide.EnemySide then
			var_10_3 = true
		end
	elseif FightEnum.LogicTargetClassify.MySideAll[arg_10_3] then
		if arg_10_0.side == FightEnum.EntitySide.MySide then
			var_10_3 = true
		end
	elseif FightEnum.LogicTargetClassify.Me[arg_10_3] and arg_10_1.belongToEntityId == arg_10_0.id then
		var_10_3 = true
	end

	if var_10_3 and var_10_2 and var_10_2.type == "AddBuff" then
		local var_10_4 = FightBuffMO.New()

		var_10_4.uid = "9999"
		var_10_4.id = "9999"
		var_10_4.entityId = arg_10_0.id
		var_10_4.buffId = var_10_0[2]

		table.insert(arg_10_4, var_10_4)
	end
end

function var_0_0.checkCurEntityIsBeContractAndHasChannel(arg_11_0)
	if FightModel.instance:isBeContractEntity(arg_11_0) then
		return false
	end

	local var_11_0 = FightModel.instance.contractEntityUid
	local var_11_1 = var_11_0 and FightDataHelper.entityMgr:getById(var_11_0)

	return var_11_1 and var_11_1:hasBuffFeature(FightEnum.BuffType_ContractCastChannel)
end

function var_0_0.hasCastChannel(arg_12_0, arg_12_1)
	local var_12_0

	var_12_0 = arg_12_0 and arg_12_0:getEntityName()

	local var_12_1 = arg_12_1 or var_0_0.simulateBuffList(arg_12_0)

	for iter_12_0, iter_12_1 in ipairs(var_12_1) do
		local var_12_2 = lua_skill_buff.configDict[iter_12_1.buffId]

		if var_12_2 then
			if FightConfig.instance:hasBuffFeature(var_12_2.id, FightEnum.BuffType_CastChannel) then
				return true
			end

			if FightConfig.instance:hasBuffFeature(var_12_2.id, FightEnum.BuffType_NoneCastChannel) then
				return true
			end

			if FightConfig.instance:hasBuffFeature(var_12_2.id, FightEnum.BuffType_ContractCastChannel) then
				return true
			end
		end
	end

	if FightModel.instance:isBeContractEntity(arg_12_0 and arg_12_0.uid) then
		if arg_12_1 then
			local var_12_3 = FightModel.instance.contractEntityUid
			local var_12_4 = var_12_3 and FightDataHelper.entityMgr:getById(var_12_3)

			arg_12_1 = var_0_0.simulateBuffList(var_12_4)

			if var_0_0.hasFeature(nil, arg_12_1, FightEnum.BuffType_ContractCastChannel) then
				return true
			end
		elseif var_0_0.checkCurEntityIsBeContractAndHasChannel(arg_12_0 and arg_12_0.uid) then
			return true
		end
	end

	return false
end

function var_0_0.hasFeature(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1 or var_0_0.simulateBuffList(arg_13_0)

	for iter_13_0, iter_13_1 in ipairs(var_13_0) do
		local var_13_1 = lua_skill_buff.configDict[iter_13_1.buffId]

		if var_13_1 and FightConfig.instance:hasBuffFeature(var_13_1.id, arg_13_2) then
			return true
		end
	end
end

function var_0_0.initPurifyHandle()
	if not var_0_0.PurifyHandle then
		var_0_0.PurifyHandle = {
			[FightEnum.PurifyId.Purify1] = var_0_0.checkCanPurify1,
			[FightEnum.PurifyId.Purify2] = var_0_0.checkCanPurify2,
			[FightEnum.PurifyId.PurifyX] = var_0_0.checkCanPurifyX
		}
	end
end

function var_0_0.checkSkillCanPurifyBySkill(arg_15_0, arg_15_1, arg_15_2, arg_15_3, arg_15_4)
	local var_15_0 = lua_skill.configDict[arg_15_2]

	if not var_15_0 then
		return false
	end

	local var_15_1 = FightDataHelper.entityMgr:getById(arg_15_0)

	arg_15_3 = arg_15_3 or var_0_0.simulateBuffList(var_15_1)

	if var_0_0.hasCastChannel(var_15_1, arg_15_3) then
		return false
	end

	if var_0_0.hasFeature(var_15_1, arg_15_3, FightEnum.BuffFeature.Dream) and not FightCardDataHelper.isBigSkill(arg_15_1) then
		return false
	end

	for iter_15_0 = 1, FightEnum.MaxBehavior do
		local var_15_2 = var_15_0["condition" .. iter_15_0]
		local var_15_3 = var_15_0["conditionTarget" .. iter_15_0]

		if FightConditionHelper.checkCondition(var_15_2, var_15_3, arg_15_4, arg_15_0) then
			local var_15_4 = var_15_0["behavior" .. iter_15_0]

			if var_0_0.checkSkillCanPurifyByBehaviour(arg_15_0, arg_15_1, var_15_4, arg_15_3) then
				return true
			end
		end
	end

	return false
end

function var_0_0.checkSkillCanPurifyByBehaviour(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if string.nilorempty(arg_16_2) then
		return false
	end

	var_0_0.initPurifyHandle()

	local var_16_0 = FightDataHelper.entityMgr:getById(arg_16_0)

	arg_16_3 = arg_16_3 or var_0_0.simulateBuffList(var_16_0)

	if var_0_0.hasCastChannel(var_16_0, arg_16_3) then
		return false
	end

	if var_0_0.hasFeature(var_16_0, arg_16_3, FightEnum.BuffFeature.Dream) and not FightCardDataHelper.isBigSkill(arg_16_1) then
		return false
	end

	local var_16_1 = tabletool.copy(FightStrUtil.instance:getSplitToNumberCache(arg_16_2, "#"))
	local var_16_2 = table.remove(var_16_1, 1)
	local var_16_3 = var_0_0.PurifyHandle[var_16_2]

	if var_16_3 and var_16_3(var_16_1, arg_16_3, arg_16_0, arg_16_1) then
		return true
	end

	return false
end

function var_0_0.checkCanPurify1(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(arg_17_1) do
		local var_17_1 = lua_skill_buff.configDict[iter_17_1.buffId]

		if var_17_1 then
			local var_17_2 = var_17_1.typeId
			local var_17_3 = lua_skill_bufftype.configDict[var_17_2].type

			if not tabletool.indexOf(arg_17_0, var_17_3) then
				table.insert(var_17_0, iter_17_1)
			end
		end
	end

	return FightViewHandCardItemLock.canUseCardSkill(arg_17_2, arg_17_3, var_17_0)
end

function var_0_0.checkCanPurify2(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		local var_18_1 = lua_skill_buff.configDict[iter_18_1.buffId]

		if var_18_1 and not tabletool.indexOf(arg_18_0, var_18_1.typeId) then
			table.insert(var_18_0, iter_18_1)
		end
	end

	return FightViewHandCardItemLock.canUseCardSkill(arg_18_2, arg_18_3, var_18_0)
end

function var_0_0.checkCanPurifyX(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	local var_19_0 = table.remove(arg_19_0, 1)
	local var_19_1 = {}
	local var_19_2 = 0

	for iter_19_0, iter_19_1 in ipairs(arg_19_1) do
		local var_19_3 = lua_skill_buff.configDict[iter_19_1.buffId]

		if var_19_3 then
			if var_19_0 <= var_19_2 then
				table.insert(var_19_1, iter_19_1)
			else
				local var_19_4 = var_19_3.typeId
				local var_19_5 = lua_skill_bufftype.configDict[var_19_4].type

				if not tabletool.indexOf(arg_19_0, var_19_5) then
					table.insert(var_19_1, iter_19_1)
				else
					var_19_2 = var_19_2 + 1
				end
			end
		end
	end

	return FightViewHandCardItemLock.canUseCardSkill(arg_19_2, arg_19_3, var_19_1)
end

local var_0_1 = "CareerRestraint"

function var_0_0.restrainAll(arg_20_0)
	local var_20_0 = FightHelper.getEntity(arg_20_0)
	local var_20_1 = var_20_0 and var_20_0:getMO()

	if var_20_1 then
		local var_20_2 = var_20_1:getBuffDic()

		for iter_20_0, iter_20_1 in pairs(var_20_2) do
			if FightConfig.instance:hasBuffFeature(iter_20_1.buffId, var_0_1) then
				return true
			end
		end
	end
end

function var_0_0.isIncludeType(arg_21_0, arg_21_1)
	local var_21_0 = lua_skill_buff.configDict[arg_21_0]

	if var_21_0 then
		local var_21_1 = lua_skill_bufftype.configDict[var_21_0.typeId]

		if var_21_1 and arg_21_1 == FightStrUtil.instance:getSplitCache(var_21_1.includeTypes, "#")[1] then
			return true
		end
	end
end

function var_0_0.filterHuanZhuangShuiXingBuff(arg_22_0, arg_22_1)
	if not arg_22_1 then
		return {}
	end

	local var_22_0 = FightHelper.getEntity(arg_22_0)

	if var_22_0 then
		local var_22_1 = var_22_0:getMO()

		if var_22_1 and var_22_1.modelId ~= 3095 then
			for iter_22_0 = #arg_22_1, 1, -1 do
				local var_22_2 = arg_22_1[iter_22_0]

				if var_22_2 and (var_22_2.buffId == 30950111 or var_22_2.buffId == 30950112 or var_22_2.buffId == 30950113) then
					table.remove(arg_22_1, iter_22_0)
				end
			end
		end
	end

	return arg_22_1
end

function var_0_0.filterBuffType(arg_23_0, arg_23_1)
	for iter_23_0 = #arg_23_0, 1, -1 do
		local var_23_0 = arg_23_0[iter_23_0]

		if var_23_0 and arg_23_1[var_23_0.type] then
			table.remove(arg_23_0, iter_23_0)
		end
	end

	return arg_23_0
end

function var_0_0.getTransferExPointUid(arg_24_0)
	if not arg_24_0 then
		return
	end

	local var_24_0 = arg_24_0:getBuffDic()

	if not var_24_0 then
		return
	end

	for iter_24_0, iter_24_1 in pairs(var_24_0) do
		local var_24_1 = iter_24_1.buffId
		local var_24_2 = arg_24_0:getFeaturesSplitInfoByBuffId(var_24_1)

		if var_24_2 then
			for iter_24_2, iter_24_3 in ipairs(var_24_2) do
				local var_24_3 = lua_buff_act.configDict[iter_24_3[1]]

				if var_24_3 and var_24_3.type == FightEnum.BuffType_TransferAddExPoint then
					return iter_24_1.fromUid
				end
			end
		end
	end
end

function var_0_0.isCountContinueChanelBuff(arg_25_0)
	if not arg_25_0 then
		return false
	end

	return FightConfig.instance:hasBuffFeature(arg_25_0.buffId, FightEnum.BuffType_CountContinueChannel)
end

function var_0_0.hasCantAddExPointFeature(arg_26_0)
	if FightConfig.instance:hasBuffFeature(arg_26_0, FightEnum.ExPointCantAdd) then
		return true
	end

	if FightConfig.instance:hasBuffFeature(arg_26_0, FightEnum.BuffType_TransferAddExPoint) then
		return true
	end

	return false
end

function var_0_0.isDuduBoneContinueChannelBuff(arg_27_0)
	if not arg_27_0 then
		return false
	end

	return FightConfig.instance:hasBuffFeature(arg_27_0.buffId, FightEnum.BuffType_DuduBoneContinueChannel)
end

function var_0_0.isDeadlyPoisonBuff(arg_28_0)
	if not arg_28_0 then
		return false
	end

	return FightConfig.instance:hasBuffFeature(arg_28_0.buffId, FightEnum.BuffType_DeadlyPoison)
end

function var_0_0.getDeadlyPoisonSignKey(arg_29_0)
	local var_29_0 = lua_skill_buff.configDict[arg_29_0.buffId]
	local var_29_1 = FightStrUtil.instance:getSplitCache(var_29_0.features, "#")

	return (string.format("%s_%s_%s", var_29_1[1], arg_29_0.duration, var_29_1[2]))
end

var_0_0.KSDL_BUFF_MO_SIGN_KEY = "KSDL_BUFF_MO_SIGN_KEY"

function var_0_0.getBuffMoSignKey(arg_30_0)
	if not arg_30_0 then
		return ""
	end

	local var_30_0 = arg_30_0.buffId
	local var_30_1 = lua_skill_buff.configDict[var_30_0]

	if not var_30_1 then
		return ""
	end

	if FightHeroSpEffectConfig.instance:isKSDLSpecialBuff(var_30_0) then
		return var_0_0.KSDL_BUFF_MO_SIGN_KEY
	end

	if not lua_skill_bufftype.configDict[var_30_1.typeId] then
		return ""
	end

	if var_0_0.isDeadlyPoisonBuff(arg_30_0) then
		return var_0_0.getDeadlyPoisonSignKey(arg_30_0)
	end

	return var_30_1.features .. "__" .. var_30_1.typeId
end

function var_0_0.checkPlayDuDuGuAddExPointEffect(arg_31_0)
	if not arg_31_0 then
		return false
	end

	local var_31_0 = FightDataHelper.entityMgr:getById(arg_31_0.id)

	if not var_31_0 then
		return false
	end

	if not var_31_0:hasBuffTypeId(31040003) then
		return false
	end

	return var_31_0:hasBuffFeature(FightEnum.BuffType_UseCardFixExPoint) or var_31_0:hasBuffFeature(FightEnum.BuffType_ExPointCardMove)
end

function var_0_0.getFeatureList(arg_32_0, arg_32_1)
	if not arg_32_0 then
		return
	end

	local var_32_0 = arg_32_0.features
	local var_32_1 = FightStrUtil.instance:getSplitCache(var_32_0, "|")

	for iter_32_0, iter_32_1 in ipairs(var_32_1) do
		local var_32_2 = FightStrUtil.instance:getSplitCache(iter_32_1, "#")
		local var_32_3 = tonumber(var_32_2[1])
		local var_32_4 = var_32_3 and lua_buff_act.configDict[var_32_3]

		if var_32_4 and var_32_4.type == arg_32_1 then
			return var_32_2
		end
	end
end

var_0_0.TempKSDLBuffList = {}

function var_0_0.getKSDLSpecialBuffList(arg_33_0)
	local var_33_0 = var_0_0.TempKSDLBuffList

	tabletool.clear(var_33_0)

	local var_33_1 = arg_33_0.entityId
	local var_33_2 = var_33_1 and FightDataHelper.entityMgr:getById(var_33_1)

	if not var_33_2 then
		return var_33_0
	end

	local var_33_3 = var_33_2:getBuffList(var_33_0)

	for iter_33_0 = #var_33_3, 1, -1 do
		arg_33_0 = var_33_3[iter_33_0]

		if not FightHeroSpEffectConfig.instance:isKSDLSpecialBuff(arg_33_0.buffId) then
			table.remove(var_33_3, iter_33_0)
		end
	end

	table.sort(var_33_3, var_0_0.sortKSDLBuffList)

	return var_33_3
end

function var_0_0.sortKSDLBuffList(arg_34_0, arg_34_1)
	return FightHeroSpEffectConfig.instance:getKSDLSpecialBuffRank(arg_34_0.buffId) < FightHeroSpEffectConfig.instance:getKSDLSpecialBuffRank(arg_34_1.buffId)
end

return var_0_0
