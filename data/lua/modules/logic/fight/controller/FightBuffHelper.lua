module("modules.logic.fight.controller.FightBuffHelper", package.seeall)

slot0 = _M

function slot0.isStoneBuff(slot0)
	return FightConfig.instance:hasBuffFeature(slot0, FightEnum.BuffType_Petrified)
end

function slot0.isDizzyBuff(slot0)
	return FightConfig.instance:hasBuffFeature(slot0, FightEnum.BuffType_Dizzy)
end

function slot0.isSleepBuff(slot0)
	return FightConfig.instance:hasBuffFeature(slot0, FightEnum.BuffType_Sleep)
end

function slot0.isFrozenBuff(slot0)
	return FightConfig.instance:hasBuffFeature(slot0, FightEnum.BuffType_Frozen)
end

function slot0.isDormantBuff(slot0)
	if lua_skill_buff.configDict[slot0] and slot1.typeId == 8241 then
		return true
	end

	return false
end

function slot0.canPlayDormantBuffAni(slot0, slot1)
	if not uv0.isDormantBuff(slot0.buff.buffId) then
		return
	end

	if not FightDataHelper.entityMgr:getById(slot0.targetId) then
		return
	end

	for slot9, slot10 in pairs(slot3:getBuffDic()) do
		if uv0.isDormantBuff(slot10.buffId) then
			slot4 = 0 + 1

			break
		end
	end

	slot6 = slot4

	for slot10, slot11 in ipairs(slot1.actEffectMOs) do
		if slot11.buff and uv0.isDormantBuff(slot11.buff.buffId) then
			if slot11.effectType == FightEnum.EffectType.BUFFADD then
				slot4 = slot4 + 1
			elseif slot11.effectType == FightEnum.EffectType.BUFFDEL then
				slot4 = slot4 - 1
			elseif slot11.effectType == FightEnum.EffectType.BUFFDELNOEFFECT then
				slot4 = slot4 - 1
			end
		end
	end

	if slot6 ~= slot4 then
		return true
	end
end

function slot0.simulateBuffList(slot0, slot1)
	if not slot0 then
		return {}
	end

	slot2 = slot0 and slot0:getBuffList()

	for slot7, slot8 in ipairs(FightCardModel.instance:getCardOps()) do
		if slot8:isPlayCard() then
			if slot1 and slot1 == slot8 then
				break
			end

			if slot8.clientSimulateCanPlayCard then
				slot9 = lua_skill.configDict[slot8.skillId]

				for slot13 = 1, FightEnum.MaxBehavior do
					slot15 = slot9["behavior" .. slot13]
					slot16 = slot9["behaviorTarget" .. slot13]
					slot17 = slot9["conditionTarget" .. slot13]

					if uv0.checkCanAddBuff(slot9["condition" .. slot13]) and not string.nilorempty(slot15) then
						slot18 = slot16

						if slot16 == 0 then
							slot18 = slot9.logicTarget
						elseif slot16 == 999 then
							slot18 = slot17 ~= 0 and slot17 or slot9.logicTarget
						end

						uv0.simulateSkillehavior(slot0, slot8, slot15, slot18, slot2)
					end
				end
			end
		end
	end

	return slot2
end

function slot0.checkCanAddBuff(slot0)
	if string.nilorempty(slot0) then
		return
	end

	if #FightStrUtil.instance:getSplitCache(slot0, "&") > 1 then
		for slot6, slot7 in ipairs(slot1) do
			if uv0.checkSingleConditionCanAddBuff(slot7) then
				slot2 = 0 + 1
			end
		end

		if slot2 == #slot1 then
			return true
		end
	elseif #FightStrUtil.instance:getSplitCache(slot0, "|") > 1 then
		for slot5, slot6 in ipairs(slot1) do
			if uv0.checkSingleConditionCanAddBuff(slot6) then
				return true
			end
		end
	elseif uv0.checkSingleConditionCanAddBuff(slot0) then
		return true
	end
end

function slot0.checkSingleConditionCanAddBuff(slot0)
	if not lua_skill_behavior_condition.configDict[tonumber(FightStrUtil.instance:getSplitCache(slot0, "#")[1])] or string.nilorempty(slot3.type) then
		return false
	end

	if slot3.type == "None" then
		return true
	end
end

function slot0.simulateSkillehavior(slot0, slot1, slot2, slot3, slot4)
	slot7 = lua_skill_behavior.configDict[FightStrUtil.instance:getSplitToNumberCache(slot2, "#")[1]]
	slot8 = false

	if FightEnum.LogicTargetClassify.Special[slot3] then
		-- Nothing
	elseif FightEnum.LogicTargetClassify.Single[slot3] then
		if slot1.toId == slot0.id then
			slot8 = true
		end
	elseif FightEnum.LogicTargetClassify.SingleAndRandom[slot3] then
		if slot1.toId == slot0.id then
			slot8 = true
		end
	elseif FightEnum.LogicTargetClassify.EnemySideAll[slot3] then
		if slot0.side == FightEnum.EntitySide.EnemySide then
			slot8 = true
		end
	elseif FightEnum.LogicTargetClassify.MySideAll[slot3] then
		if slot0.side == FightEnum.EntitySide.MySide then
			slot8 = true
		end
	elseif FightEnum.LogicTargetClassify.Me[slot3] and slot1.belongToEntityId == slot0.id then
		slot8 = true
	end

	if slot8 and slot7 and slot7.type == "AddBuff" then
		slot9 = FightBuffMO.New()
		slot9.uid = "9999"
		slot9.id = "9999"
		slot9.entityId = slot0.id
		slot9.buffId = slot5[2]

		table.insert(slot4, slot9)
	end
end

function slot0.checkCurEntityIsBeContractAndHasChannel(slot0)
	if FightModel.instance:isBeContractEntity(slot0) then
		return false
	end

	slot2 = FightModel.instance.contractEntityUid and FightDataHelper.entityMgr:getById(slot1)

	return slot2 and slot2:hasBuffFeature(FightEnum.BuffType_ContractCastChannel)
end

function slot0.hasCastChannel(slot0, slot1)
	slot2 = slot0 and slot0:getEntityName()

	for slot7, slot8 in ipairs(slot1 or uv0.simulateBuffList(slot0)) do
		if lua_skill_buff.configDict[slot8.buffId] then
			if FightConfig.instance:hasBuffFeature(slot9.id, FightEnum.BuffType_CastChannel) then
				return true
			end

			if FightConfig.instance:hasBuffFeature(slot9.id, FightEnum.BuffType_NoneCastChannel) then
				return true
			end

			if FightConfig.instance:hasBuffFeature(slot9.id, FightEnum.BuffType_ContractCastChannel) then
				return true
			end
		end
	end

	if FightModel.instance:isBeContractEntity(slot0 and slot0.uid) then
		if slot1 then
			if uv0.hasFeature(nil, uv0.simulateBuffList(FightModel.instance.contractEntityUid and FightDataHelper.entityMgr:getById(slot4)), FightEnum.BuffType_ContractCastChannel) then
				return true
			end
		elseif uv0.checkCurEntityIsBeContractAndHasChannel(slot0 and slot0.uid) then
			return true
		end
	end

	return false
end

function slot0.hasFeature(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot1 or uv0.simulateBuffList(slot0)) do
		if lua_skill_buff.configDict[slot8.buffId] and FightConfig.instance:hasBuffFeature(slot9.id, slot2) then
			return true
		end
	end
end

function slot0.initPurifyHandle()
	if not uv0.PurifyHandle then
		uv0.PurifyHandle = {
			[FightEnum.PurifyId.Purify1] = uv0.checkCanPurify1,
			[FightEnum.PurifyId.Purify2] = uv0.checkCanPurify2,
			[FightEnum.PurifyId.PurifyX] = uv0.checkCanPurifyX
		}
	end
end

function slot0.checkSkillCanPurifyBySkill(slot0, slot1, slot2, slot3, slot4)
	if not lua_skill.configDict[slot2] then
		return false
	end

	slot6 = FightDataHelper.entityMgr:getById(slot0)

	if uv0.hasCastChannel(slot6, slot3 or uv0.simulateBuffList(slot6)) then
		return false
	end

	if uv0.hasFeature(slot6, slot3, FightEnum.BuffFeature.Dream) and not FightCardModel.instance:isUniqueSkill(slot0, slot1) then
		return false
	end

	for slot10 = 1, FightEnum.MaxBehavior do
		if FightConditionHelper.checkCondition(slot5["condition" .. slot10], slot5["conditionTarget" .. slot10], slot4, slot0) and uv0.checkSkillCanPurifyByBehaviour(slot0, slot1, slot5["behavior" .. slot10], slot3) then
			return true
		end
	end

	return false
end

function slot0.checkSkillCanPurifyByBehaviour(slot0, slot1, slot2, slot3)
	if string.nilorempty(slot2) then
		return false
	end

	uv0.initPurifyHandle()

	slot4 = FightDataHelper.entityMgr:getById(slot0)

	if uv0.hasCastChannel(slot4, slot3 or uv0.simulateBuffList(slot4)) then
		return false
	end

	if uv0.hasFeature(slot4, slot3, FightEnum.BuffFeature.Dream) and not FightCardModel.instance:isUniqueSkill(slot0, slot1) then
		return false
	end

	if uv0.PurifyHandle[table.remove(tabletool.copy(FightStrUtil.instance:getSplitToNumberCache(slot2, "#")), 1)] and slot7(slot5, slot3, slot0, slot1) then
		return true
	end

	return false
end

function slot0.checkCanPurify1(slot0, slot1, slot2, slot3)
	slot4 = {}

	for slot8, slot9 in ipairs(slot1) do
		if lua_skill_buff.configDict[slot9.buffId] and not tabletool.indexOf(slot0, lua_skill_bufftype.configDict[slot10.typeId].type) then
			table.insert(slot4, slot9)
		end
	end

	return FightViewHandCardItemLock.canUseCardSkill(slot2, slot3, slot4)
end

function slot0.checkCanPurify2(slot0, slot1, slot2, slot3)
	slot4 = {}

	for slot8, slot9 in ipairs(slot1) do
		if lua_skill_buff.configDict[slot9.buffId] and not tabletool.indexOf(slot0, slot10.typeId) then
			table.insert(slot4, slot9)
		end
	end

	return FightViewHandCardItemLock.canUseCardSkill(slot2, slot3, slot4)
end

function slot0.checkCanPurifyX(slot0, slot1, slot2, slot3)
	slot5 = {}

	for slot10, slot11 in ipairs(slot1) do
		if lua_skill_buff.configDict[slot11.buffId] then
			if table.remove(slot0, 1) <= 0 then
				table.insert(slot5, slot11)
			elseif not tabletool.indexOf(slot0, lua_skill_bufftype.configDict[slot12.typeId].type) then
				table.insert(slot5, slot11)
			else
				slot6 = slot6 + 1
			end
		end
	end

	return FightViewHandCardItemLock.canUseCardSkill(slot2, slot3, slot5)
end

slot1 = "CareerRestraint"

function slot0.restrainAll(slot0)
	if FightHelper.getEntity(slot0) and slot1:getMO() then
		for slot7, slot8 in pairs(slot2:getBuffDic()) do
			if FightConfig.instance:hasBuffFeature(slot8.buffId, uv0) then
				return true
			end
		end
	end
end

function slot0.isIncludeType(slot0, slot1)
	if lua_skill_buff.configDict[slot0] and lua_skill_bufftype.configDict[slot2.typeId] and slot1 == FightStrUtil.instance:getSplitCache(slot3.includeTypes, "#")[1] then
		return true
	end
end

function slot0.filterHuanZhuangShuiXingBuff(slot0, slot1)
	if not slot1 then
		return {}
	end

	if FightHelper.getEntity(slot0) and slot2:getMO() and slot3.modelId ~= 3095 then
		for slot7 = #slot1, 1, -1 do
			if slot1[slot7] and (slot8.buffId == 30950111 or slot8.buffId == 30950112 or slot8.buffId == 30950113) then
				table.remove(slot1, slot7)
			end
		end
	end

	return slot1
end

function slot0.filterBuffType(slot0, slot1)
	for slot5 = #slot0, 1, -1 do
		if slot0[slot5] and slot1[slot6.type] then
			table.remove(slot0, slot5)
		end
	end

	return slot0
end

function slot0.getTransferExPointUid(slot0)
	if not slot0 then
		return
	end

	if not slot0:getBuffDic() then
		return
	end

	for slot5, slot6 in pairs(slot1) do
		if slot0:getFeaturesSplitInfoByBuffId(slot6.buffId) then
			for slot12, slot13 in ipairs(slot8) do
				if lua_buff_act.configDict[slot13[1]] and slot14.type == FightEnum.BuffType_TransferAddExPoint then
					return slot6.fromUid
				end
			end
		end
	end
end

function slot0.isCountContinueChanelBuff(slot0)
	if not slot0 then
		return false
	end

	return FightConfig.instance:hasBuffFeature(slot0.buffId, FightEnum.BuffType_CountContinueChannel)
end

function slot0.hasCantAddExPointFeature(slot0)
	if FightConfig.instance:hasBuffFeature(slot0, FightEnum.ExPointCantAdd) then
		return true
	end

	if FightConfig.instance:hasBuffFeature(slot0, FightEnum.BuffType_TransferAddExPoint) then
		return true
	end

	return false
end

function slot0.isDuduBoneContinueChannelBuff(slot0)
	if not slot0 then
		return false
	end

	return FightConfig.instance:hasBuffFeature(slot0.buffId, FightEnum.BuffType_DuduBoneContinueChannel)
end

function slot0.isDeadlyPoisonBuff(slot0)
	if not slot0 then
		return false
	end

	return FightConfig.instance:hasBuffFeature(slot0.buffId, FightEnum.BuffType_DeadlyPoison)
end

function slot0.getDeadlyPoisonSignKey(slot0)
	slot2 = FightStrUtil.instance:getSplitCache(lua_skill_buff.configDict[slot0.buffId].features, "#")

	return string.format("%s_%s_%s", slot2[1], slot0.duration, slot2[2])
end

function slot0.getBuffMoSignKey(slot0)
	if not slot0 then
		return ""
	end

	if not lua_skill_buff.configDict[slot0.buffId] then
		return ""
	end

	if not lua_skill_bufftype.configDict[slot1.typeId] then
		return ""
	end

	if uv0.isDeadlyPoisonBuff(slot0) then
		return uv0.getDeadlyPoisonSignKey(slot0)
	end

	return slot1.features .. "__" .. slot1.typeId
end

function slot0.checkPlayDuDuGuAddExPointEffect(slot0)
	if not slot0 then
		return false
	end

	if not FightDataHelper.entityMgr:getById(slot0.id) then
		return false
	end

	if not slot1:hasBuffTypeId(31040003) then
		return false
	end

	return slot1:hasBuffFeature(FightEnum.BuffType_UseCardFixExPoint) or slot1:hasBuffFeature(FightEnum.BuffType_ExPointCardMove)
end

function slot0.getFeatureList(slot0, slot1)
	if not slot0 then
		return
	end

	for slot7, slot8 in ipairs(FightStrUtil.instance:getSplitCache(slot0.features, "|")) do
		if tonumber(FightStrUtil.instance:getSplitCache(slot8, "#")[1]) and lua_buff_act.configDict[slot10] and slot11.type == slot1 then
			return slot9
		end
	end
end

return slot0
