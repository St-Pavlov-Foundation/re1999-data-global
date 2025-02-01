module("modules.logic.fight.view.FightViewHandCardItemLock", package.seeall)

slot0 = class("FightViewHandCardItemLock", LuaCompBase)

function slot0.ctor(slot0, slot1)
	slot0._subViewInst = slot1
end

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.tr = slot1.transform
	slot0._lockGO = gohelper.findChild(slot0.go, "foranim/lock")

	slot0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnFightReconnect, slot0._onFightReconnect, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.BeforePlayHandCard, slot0._beforePlayHandCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnPlayCardFlowDone, slot0._afterPlayHandCard, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnFightReconnect, slot0._onFightReconnect, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.BeforePlayHandCard, slot0._beforePlayHandCard, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnPlayCardFlowDone, slot0._afterPlayHandCard, slot0)
	TaskDispatcher.cancelTask(slot0._reconnectSetCardLock, slot0)
end

function slot0.updateItem(slot0, slot1)
	slot0.cardInfoMO = slot1 or slot0.cardInfoMO

	if not lua_skill.configDict[slot1.skillId] then
		logError("skill not exist: " .. slot1.skillId)

		return
	end

	slot0._skillId = slot1.skillId
	slot4 = FightBuffHelper.simulateBuffList(FightEntityModel.instance:getById(slot0.cardInfoMO.uid))
	slot0._canUse = uv0.canUseCardSkill(slot0.cardInfoMO.uid, slot0.cardInfoMO.skillId)

	uv0.setCardLock(slot0.cardInfoMO.uid, slot0.cardInfoMO.skillId, slot0._lockGO, false, slot4)
	slot0:_setCardPreRemove(false, slot4)
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3)
	if slot1 ~= slot0.cardInfoMO.uid then
		return
	end

	if slot2 == FightEnum.EffectType.BUFFADD then
		uv0.setCardLock(slot0.cardInfoMO.uid, slot0.cardInfoMO.skillId, slot0._lockGO, slot0._canUse and not uv0.canUseCardSkill(slot1, slot0.cardInfoMO.skillId))
	elseif slot2 == FightEnum.EffectType.BUFFDEL then
		uv0.setCardLock(slot0.cardInfoMO.uid, slot0.cardInfoMO.skillId, slot0._lockGO, false)
	end

	slot0._canUse = slot4
end

function slot0._onFightReconnect(slot0)
	TaskDispatcher.runDelay(slot0._reconnectSetCardLock, slot0, 1)
end

slot1 = {}
slot2 = {}

function slot0._beforePlayHandCard(slot0)
	slot2 = FightBuffHelper.simulateBuffList(FightEntityModel.instance:getById(slot0.cardInfoMO.uid))
	uv0[slot0.cardInfoMO.skillId] = uv1.canUseCardSkill(slot0.cardInfoMO.uid, slot0.cardInfoMO.skillId, slot2)
	uv2[slot0.cardInfoMO.skillId] = uv1.canPreRemove(slot0.cardInfoMO.uid, slot0.cardInfoMO.skillId, nil, slot2)
end

function slot0._afterPlayHandCard(slot0)
	slot2 = FightBuffHelper.simulateBuffList(FightEntityModel.instance:getById(slot0.cardInfoMO.uid))

	uv0.setCardLock(slot0.cardInfoMO.uid, slot0.cardInfoMO.skillId, slot0._lockGO, false, slot2)

	slot4 = uv2[slot0.cardInfoMO.skillId]

	if uv1[slot0.cardInfoMO.skillId] == false and uv0.canUseCardSkill(slot0.cardInfoMO.uid, slot0.cardInfoMO.skillId, slot2) == false and (slot4 == nil or slot4 == false) and uv0.canPreRemove(slot0.cardInfoMO.uid, slot0.cardInfoMO.skillId, nil, slot2) == true then
		slot0:_setCardPreRemove(true, slot2)
	end

	if slot3 == slot5 and slot4 == slot6 and slot6 and not slot5 then
		slot0:_setCardPreRemove(false, slot2)
	end
end

function slot0._reconnectSetCardLock(slot0)
	uv0.setCardLock(slot0.cardInfoMO.uid, slot0.cardInfoMO.skillId, slot0._lockGO, false)
end

slot3 = {
	"txtLockName",
	"normal/1/seal/ani/txtLockName",
	"normal/1/unseal/ani/txtLockName",
	"normal/1/sealing/ani/txtLockName",
	"normal/2/seal/ani/txtLockName",
	"normal/2/unseal/ani/txtLockName",
	"normal/2/sealing/ani/txtLockName",
	"normal/3/seal/ani/txtLockName",
	"normal/3/unseal/ani/txtLockName",
	"normal/3/sealing/ani/txtLockName",
	"bigskill/4/seal/ani/txtLockName",
	"bigskill/4/unseal/ani/txtLockName",
	"bigskill/4/sealing/ani/txtLockName",
	"normal/1/seal/notani/txtLockName",
	"normal/1/unseal/notani/txtLockName",
	"normal/1/sealing/notani/txtLockName",
	"normal/2/seal/notani/txtLockName",
	"normal/2/unseal/notani/txtLockName",
	"normal/2/sealing/notani/txtLockName",
	"normal/3/seal/notani/txtLockName",
	"normal/3/unseal/notani/txtLockName",
	"normal/3/sealing/notani/txtLockName",
	"bigskill/4/seal/notani/txtLockName",
	"bigskill/4/unseal/notani/txtLockName",
	"bigskill/4/sealing/notani/txtLockName"
}

function slot0.setCardLock(slot0, slot1, slot2, slot3, slot4)
	gohelper.setActive(slot2, false)

	if gohelper.isNil(slot2) or not slot1 then
		return
	end

	if FightEnum.UniversalCard[slot1] then
		return
	end

	slot5 = uv0.canUseCardSkill(slot0, slot1, slot4)

	gohelper.setActive(slot2, not slot5)

	if not slot5 then
		slot7 = lua_skill.configDict[slot1].isBigSkill == 1 and true or false
		slot8 = FightCardModel.instance:getSkillLv(slot0, slot1)
		slot9 = uv0._getCardLockReason(slot0, slot1, slot4)

		gohelper.setActive(gohelper.findChild(slot2, "normal"), not slot7)
		gohelper.setActive(gohelper.findChild(slot2, "bigskill"), slot7)

		for slot15 = 1, 4 do
			gohelper.setActive(gohelper.findChild(slot15 == FightEnum.UniqueSkillCardLv and slot11 or slot10, tostring(slot15)), slot15 == slot8)

			if slot15 == slot8 then
				slot18 = slot16:GetComponent(typeof(UnityEngine.Animator))

				slot18:Play(slot3 and "fight_lock_seal_all" or "fight_lock_seal_allnot", 0, 0)
				slot18:Update(0)
			end
		end

		slot12 = slot9 and slot9.name or ""

		if LangSettings.instance:isZh() or LangSettings.instance:isTw() then
			slot12 = LuaUtil.getCharNum(slot12) <= 2 and slot12 or LuaUtil.subString(slot12, 1, 2) .. "\n" .. LuaUtil.subString(slot12, 3)
		end

		for slot16, slot17 in ipairs(uv1) do
			if gohelper.findChildText(slot2, slot17) then
				slot18.text = slot12
			end
		end

		return true
	end
end

function slot0._setCardPreRemove(slot0, slot1, slot2)
	if FightEnum.UniversalCard[slot0.cardInfoMO.skillId] then
		return
	end

	if gohelper.isNil(slot0.go) then
		return
	end

	if uv0.canUseCardSkill(slot0.cardInfoMO.uid, slot3, slot2) then
		return
	end

	if not uv0.canPreRemove(slot4, slot3, nil, slot2) then
		return
	end

	uv0.setCardPreRemove(slot4, slot3, slot0._lockGO, slot1)
end

function slot0.setCardPreRemove(slot0, slot1, slot2, slot3)
	slot4 = FightCardModel.instance:isUniqueSkill(slot0, slot1)
	slot5 = FightCardModel.instance:getSkillLv(slot0, slot1)

	gohelper.setActive(gohelper.findChild(slot2, "normal"), not slot4)
	gohelper.setActive(gohelper.findChild(slot2, "bigskill"), slot4)

	for slot11 = 1, 4 do
		gohelper.setActive(gohelper.findChild(slot11 == FightEnum.UniqueSkillCardLv and slot7 or slot6, tostring(slot11)), slot11 == slot5)

		if slot11 == slot5 then
			if slot12:GetComponent(typeof(UnityEngine.Animator)) then
				slot14:Play(slot3 and "fight_lock_sealing_all" or "fight_lock_sealing_allnot", 0, 0)
				slot14:Update(0)
			end
		end
	end
end

function slot0.setCardUnLock(slot0, slot1, slot2)
	slot4 = lua_skill.configDict[slot1].isBigSkill == 1 and true or false
	slot5 = FightCardModel.instance:getSkillLv(slot0, slot1)

	gohelper.setActive(gohelper.findChild(slot2, "normal"), not slot4)
	gohelper.setActive(gohelper.findChild(slot2, "bigskill"), slot4)

	for slot11 = 1, 4 do
		gohelper.setActive(gohelper.findChild(slot11 == FightEnum.UniqueSkillCardLv and slot7 or slot6, tostring(slot11)), slot11 == slot5)

		if slot11 == slot5 then
			if slot12:GetComponent(typeof(UnityEngine.Animator)) then
				slot14:Play("fight_lock_unseal_all", 0, 0)
				slot14:Update(0)
			end
		end
	end
end

slot4 = {
	[102.0] = true,
	[101.0] = true
}
slot5 = {
	true,
	[107.0] = true,
	[106.0] = true,
	[108.0] = true,
	[112.0] = true,
	[111.0] = true,
	[109.0] = true
}

function slot0.canPreRemove(slot0, slot1, slot2, slot3)
	if FightBuffHelper.hasCastChannel(FightEntityModel.instance:getById(slot0), slot3) then
		return false
	end

	if FightBuffHelper.hasFeature(slot4, slot3, FightEnum.BuffFeature.Dream) and not FightCardModel.instance:isUniqueSkill(slot0, slot1) then
		return false
	end

	for slot9, slot10 in ipairs(FightCardModel.instance:getCardOps()) do
		if slot10 == slot2 then
			return false
		end

		if slot10:isPlayCard() and slot10.clientSimulateCanPlayCard and (uv0[lua_skill.configDict[slot10.skillId].logicTarget] or uv1[slot12] and slot0 == slot10.toId and slot0 ~= slot10.belongToEntityId) and FightBuffHelper.checkSkillCanPurifyBySkill(slot0, slot1, slot10.skillId, slot3) then
			return true
		end
	end
end

slot6 = {
	[FightEnum.BuffType_Dizzy] = true,
	[FightEnum.BuffType_Charm] = true,
	[FightEnum.BuffType_Petrified] = true,
	[FightEnum.BuffType_Sleep] = true,
	[FightEnum.BuffType_Frozen] = true,
	[FightEnum.BuffType_Freeze] = true,
	[FightEnum.BuffType_Disarm] = {
		true,
		true,
		bigSkill = false
	},
	[FightEnum.BuffType_Forbid] = {
		nil,
		nil,
		true,
		true,
		true,
		true,
		bigSkill = false
	},
	[FightEnum.BuffType_Seal] = {
		true,
		true,
		true,
		true,
		true,
		true,
		nil,
		nil,
		true,
		bigSkill = true
	},
	[FightEnum.BuffType_CastChannel] = true,
	[FightEnum.BuffFeature.Dream] = {
		bigSkill = true,
		reverse = true
	},
	[FightEnum.BuffType_NoneCastChannel] = true,
	[FightEnum.BuffType_ContractCastChannel] = true,
	[FightEnum.BuffFeature.UseSkillHasBuffCond] = {
		UseSkillHasBuffCond = true
	}
}

function slot0.canUseCardSkill(slot0, slot1, slot2)
	if not slot0 or not slot1 then
		return false
	end

	if not FightEntityModel.instance:getById(slot0) then
		return true
	end

	slot4 = lua_skill.configDict[slot1]

	for slot8, slot9 in ipairs(slot2 or slot3:getBuffList()) do
		for slot14, slot15 in pairs(FightConfig.instance:getBuffFeatures(slot9.buffId)) do
			if uv0.isLockByLockBuffType(slot15, slot4, slot0) then
				return false
			end
		end
	end

	if FightModel.instance:isBeContractEntity(slot0) then
		if slot2 then
			if FightBuffHelper.hasFeature(nil, FightBuffHelper.simulateBuffList(FightModel.instance.contractEntityUid and FightEntityModel.instance:getById(slot5)), FightEnum.BuffType_ContractCastChannel) then
				return false
			end
		elseif FightBuffHelper.checkCurEntityIsBeContractAndHasChannel(slot0) then
			return false
		end
	end

	return true
end

function slot0.isLockByLockBuffType(slot0, slot1, slot2)
	slot3 = slot1.isBigSkill == 1 and true or false

	if uv0[slot0.featureType] == true then
		return true
	end

	if slot5 then
		if slot5.reverse then
			if slot3 then
				if not slot5.bigSkill then
					return true
				end
			elseif not slot5[slot1.effectTag] then
				return true
			end
		elseif slot5.UseSkillHasBuffCond then
			for slot10 = 3, #FightStrUtil.instance:getSplitToNumberCache(slot0.featureStr, "#") do
				if slot6[slot10] == slot1.id and FightHelper.getEntity(slot2) and slot11.buff and not slot11.buff:haveBuffTypeId(slot6[2]) then
					return true
				end
			end
		elseif slot5[slot1.effectTag] == true and slot5.bigSkill == slot3 then
			return true
		end
	end
end

function slot0._getCardLockReason(slot0, slot1, slot2)
	if not slot0 or not slot1 then
		return
	end

	if not FightEntityModel.instance:getById(slot0) then
		return
	end

	slot5, slot6 = uv0.getLockBuffMo(slot3, slot2, lua_skill.configDict[slot1])

	if FightModel.instance:isBeContractEntity(slot0) then
		slot8 = FightModel.instance.contractEntityUid and FightEntityModel.instance:getById(slot7)
		slot5, slot6 = uv0.getLockBuffMo(slot8, FightBuffHelper.simulateBuffList(slot8), slot4, slot5, slot6)
	end

	return slot5 and lua_skill_buff.configDict[slot5.buffId]
end

function slot0.getLockBuffMo(slot0, slot1, slot2, slot3, slot4)
	if not slot0 then
		return
	end

	slot4 = slot4 or -1

	for slot8, slot9 in ipairs(slot1 or slot0:getBuffList()) do
		for slot14, slot15 in pairs(FightConfig.instance:getBuffFeatures(slot9.buffId)) do
			if uv0.isLockByLockBuffType(slot15, slot2, slot0.id) then
				if not slot3 then
					slot3 = slot9
					slot4 = FightEnum.CardLockPriorityDict[slot14] or -1
				elseif slot4 < slot16 or slot16 == slot4 and tonumber(slot3.uid) < tonumber(slot9.uid) then
					slot3 = slot9
					slot4 = slot16
				end
			end
		end
	end

	return slot3, slot4
end

function slot0.logSkill(slot0, slot1)
	logError(string.format("%s : %s", lua_skill.configDict[slot0].name, slot1))
end

return slot0
