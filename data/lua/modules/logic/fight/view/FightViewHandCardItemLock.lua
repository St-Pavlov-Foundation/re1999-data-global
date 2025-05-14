module("modules.logic.fight.view.FightViewHandCardItemLock", package.seeall)

local var_0_0 = class("FightViewHandCardItemLock", LuaCompBase)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0._subViewInst = arg_1_1
end

function var_0_0.init(arg_2_0, arg_2_1)
	arg_2_0.go = arg_2_1
	arg_2_0.tr = arg_2_1.transform
	arg_2_0._lockGO = gohelper.findChild(arg_2_0.go, "foranim/lock")

	arg_2_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_2_0._onBuffUpdate, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnFightReconnect, arg_2_0._onFightReconnect, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.BeforePlayHandCard, arg_2_0._beforePlayHandCard, arg_2_0)
	arg_2_0:addEventCb(FightController.instance, FightEvent.OnPlayCardFlowDone, arg_2_0._afterPlayHandCard, arg_2_0)
end

function var_0_0.removeEventListeners(arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_3_0._onBuffUpdate, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnFightReconnect, arg_3_0._onFightReconnect, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.BeforePlayHandCard, arg_3_0._beforePlayHandCard, arg_3_0)
	arg_3_0:removeEventCb(FightController.instance, FightEvent.OnPlayCardFlowDone, arg_3_0._afterPlayHandCard, arg_3_0)
	TaskDispatcher.cancelTask(arg_3_0._reconnectSetCardLock, arg_3_0)
end

function var_0_0.updateItem(arg_4_0, arg_4_1)
	arg_4_0.cardInfoMO = arg_4_1 or arg_4_0.cardInfoMO

	if not lua_skill.configDict[arg_4_1.skillId] then
		logError("skill not exist: " .. arg_4_1.skillId)

		return
	end

	arg_4_0._skillId = arg_4_1.skillId

	local var_4_0 = FightDataHelper.entityMgr:getById(arg_4_0.cardInfoMO.uid)
	local var_4_1 = FightBuffHelper.simulateBuffList(var_4_0)

	arg_4_0._canUse = var_0_0.canUseCardSkill(arg_4_0.cardInfoMO.uid, arg_4_0.cardInfoMO.skillId)

	var_0_0.setCardLock(arg_4_0.cardInfoMO.uid, arg_4_0.cardInfoMO.skillId, arg_4_0._lockGO, false, var_4_1)
	arg_4_0:_setCardPreRemove(false, var_4_1)
end

function var_0_0._onBuffUpdate(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	if not arg_5_0.cardInfoMO then
		return
	end

	if arg_5_1 ~= arg_5_0.cardInfoMO.uid then
		return
	end

	local var_5_0 = var_0_0.canUseCardSkill(arg_5_1, arg_5_0.cardInfoMO.skillId)

	if arg_5_2 == FightEnum.EffectType.BUFFADD then
		local var_5_1 = arg_5_0._canUse and not var_5_0

		var_0_0.setCardLock(arg_5_0.cardInfoMO.uid, arg_5_0.cardInfoMO.skillId, arg_5_0._lockGO, var_5_1)
	elseif arg_5_2 == FightEnum.EffectType.BUFFDEL then
		var_0_0.setCardLock(arg_5_0.cardInfoMO.uid, arg_5_0.cardInfoMO.skillId, arg_5_0._lockGO, false)
	end

	arg_5_0._canUse = var_5_0
end

function var_0_0._onFightReconnect(arg_6_0)
	TaskDispatcher.runDelay(arg_6_0._reconnectSetCardLock, arg_6_0, 1)
end

local var_0_1 = {}
local var_0_2 = {}

function var_0_0._beforePlayHandCard(arg_7_0)
	local var_7_0 = FightDataHelper.entityMgr:getById(arg_7_0.cardInfoMO.uid)
	local var_7_1 = FightBuffHelper.simulateBuffList(var_7_0)

	var_0_1[arg_7_0.cardInfoMO.skillId] = var_0_0.canUseCardSkill(arg_7_0.cardInfoMO.uid, arg_7_0.cardInfoMO.skillId, var_7_1)
	var_0_2[arg_7_0.cardInfoMO.skillId] = var_0_0.canPreRemove(arg_7_0.cardInfoMO.uid, arg_7_0.cardInfoMO.skillId, nil, var_7_1)
end

function var_0_0._afterPlayHandCard(arg_8_0)
	local var_8_0 = FightDataHelper.entityMgr:getById(arg_8_0.cardInfoMO.uid)
	local var_8_1 = FightBuffHelper.simulateBuffList(var_8_0)

	var_0_0.setCardLock(arg_8_0.cardInfoMO.uid, arg_8_0.cardInfoMO.skillId, arg_8_0._lockGO, false, var_8_1)

	local var_8_2 = var_0_1[arg_8_0.cardInfoMO.skillId]
	local var_8_3 = var_0_2[arg_8_0.cardInfoMO.skillId]
	local var_8_4 = var_0_0.canUseCardSkill(arg_8_0.cardInfoMO.uid, arg_8_0.cardInfoMO.skillId, var_8_1)
	local var_8_5 = var_0_0.canPreRemove(arg_8_0.cardInfoMO.uid, arg_8_0.cardInfoMO.skillId, nil, var_8_1)

	if var_8_2 == false and var_8_4 == false and (var_8_3 == nil or var_8_3 == false) and var_8_5 == true then
		arg_8_0:_setCardPreRemove(true, var_8_1)
	end

	if var_8_2 == var_8_4 and var_8_3 == var_8_5 and var_8_5 and not var_8_4 then
		arg_8_0:_setCardPreRemove(false, var_8_1)
	end
end

function var_0_0._reconnectSetCardLock(arg_9_0)
	var_0_0.setCardLock(arg_9_0.cardInfoMO.uid, arg_9_0.cardInfoMO.skillId, arg_9_0._lockGO, false)
end

local var_0_3 = {
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

function var_0_0.setCardLock(arg_10_0, arg_10_1, arg_10_2, arg_10_3, arg_10_4)
	gohelper.setActive(arg_10_2, false)

	if gohelper.isNil(arg_10_2) or not arg_10_1 then
		return
	end

	if FightEnum.UniversalCard[arg_10_1] then
		return
	end

	local var_10_0 = var_0_0.canUseCardSkill(arg_10_0, arg_10_1, arg_10_4)

	gohelper.setActive(arg_10_2, not var_10_0)

	if not var_10_0 then
		local var_10_1 = lua_skill.configDict[arg_10_1].isBigSkill == 1 and true or false
		local var_10_2 = FightCardModel.instance:getSkillLv(arg_10_0, arg_10_1)
		local var_10_3 = var_0_0._getCardLockReason(arg_10_0, arg_10_1, arg_10_4)
		local var_10_4 = gohelper.findChild(arg_10_2, "normal")
		local var_10_5 = gohelper.findChild(arg_10_2, "bigskill")

		gohelper.setActive(var_10_4, not var_10_1)
		gohelper.setActive(var_10_5, var_10_1)

		for iter_10_0 = 1, 4 do
			local var_10_6 = gohelper.findChild(iter_10_0 == FightEnum.UniqueSkillCardLv and var_10_5 or var_10_4, tostring(iter_10_0))

			gohelper.setActive(var_10_6, iter_10_0 == var_10_2)

			if iter_10_0 == var_10_2 then
				local var_10_7 = arg_10_3 and "fight_lock_seal_all" or "fight_lock_seal_allnot"
				local var_10_8 = var_10_6:GetComponent(typeof(UnityEngine.Animator))

				var_10_8:Play(var_10_7, 0, 0)
				var_10_8:Update(0)
			end
		end

		local var_10_9 = var_10_3 and var_10_3.name or ""

		if LangSettings.instance:isZh() or LangSettings.instance:isTw() then
			var_10_9 = LuaUtil.getCharNum(var_10_9) <= 2 and var_10_9 or LuaUtil.subString(var_10_9, 1, 2) .. "\n" .. LuaUtil.subString(var_10_9, 3)
		end

		for iter_10_1, iter_10_2 in ipairs(var_0_3) do
			local var_10_10 = gohelper.findChildText(arg_10_2, iter_10_2)

			if var_10_10 then
				var_10_10.text = var_10_9
			end
		end

		return true
	end
end

function var_0_0._setCardPreRemove(arg_11_0, arg_11_1, arg_11_2)
	local var_11_0 = arg_11_0.cardInfoMO.skillId

	if FightEnum.UniversalCard[var_11_0] then
		return
	end

	if gohelper.isNil(arg_11_0.go) then
		return
	end

	local var_11_1 = arg_11_0.cardInfoMO.uid

	if var_0_0.canUseCardSkill(var_11_1, var_11_0, arg_11_2) then
		return
	end

	if not var_0_0.canPreRemove(var_11_1, var_11_0, nil, arg_11_2) then
		return
	end

	var_0_0.setCardPreRemove(var_11_1, var_11_0, arg_11_0._lockGO, arg_11_1)
end

function var_0_0.setCardPreRemove(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	local var_12_0 = FightCardModel.instance:isUniqueSkill(arg_12_0, arg_12_1)
	local var_12_1 = FightCardModel.instance:getSkillLv(arg_12_0, arg_12_1)
	local var_12_2 = gohelper.findChild(arg_12_2, "normal")
	local var_12_3 = gohelper.findChild(arg_12_2, "bigskill")

	gohelper.setActive(var_12_2, not var_12_0)
	gohelper.setActive(var_12_3, var_12_0)

	for iter_12_0 = 1, 4 do
		local var_12_4 = gohelper.findChild(iter_12_0 == FightEnum.UniqueSkillCardLv and var_12_3 or var_12_2, tostring(iter_12_0))

		gohelper.setActive(var_12_4, iter_12_0 == var_12_1)

		if iter_12_0 == var_12_1 then
			local var_12_5 = arg_12_3 and "fight_lock_sealing_all" or "fight_lock_sealing_allnot"
			local var_12_6 = var_12_4:GetComponent(typeof(UnityEngine.Animator))

			if var_12_6 then
				var_12_6:Play(var_12_5, 0, 0)
				var_12_6:Update(0)
			end
		end
	end
end

function var_0_0.setCardUnLock(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = lua_skill.configDict[arg_13_1].isBigSkill == 1 and true or false
	local var_13_1 = FightCardModel.instance:getSkillLv(arg_13_0, arg_13_1)
	local var_13_2 = gohelper.findChild(arg_13_2, "normal")
	local var_13_3 = gohelper.findChild(arg_13_2, "bigskill")

	gohelper.setActive(var_13_2, not var_13_0)
	gohelper.setActive(var_13_3, var_13_0)

	for iter_13_0 = 1, 4 do
		local var_13_4 = gohelper.findChild(iter_13_0 == FightEnum.UniqueSkillCardLv and var_13_3 or var_13_2, tostring(iter_13_0))

		gohelper.setActive(var_13_4, iter_13_0 == var_13_1)

		if iter_13_0 == var_13_1 then
			local var_13_5 = "fight_lock_unseal_all"
			local var_13_6 = var_13_4:GetComponent(typeof(UnityEngine.Animator))

			if var_13_6 then
				var_13_6:Play(var_13_5, 0, 0)
				var_13_6:Update(0)
			end
		end
	end
end

local var_0_4 = {
	[102] = true,
	[101] = true
}
local var_0_5 = {
	true,
	[107] = true,
	[106] = true,
	[108] = true,
	[112] = true,
	[111] = true,
	[109] = true
}

function var_0_0.canPreRemove(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = FightDataHelper.entityMgr:getById(arg_14_0)

	if FightBuffHelper.hasCastChannel(var_14_0, arg_14_3) then
		return false
	end

	if FightBuffHelper.hasFeature(var_14_0, arg_14_3, FightEnum.BuffFeature.Dream) and not FightCardModel.instance:isUniqueSkill(arg_14_0, arg_14_1) then
		return false
	end

	local var_14_1 = FightCardModel.instance:getCardOps()

	for iter_14_0, iter_14_1 in ipairs(var_14_1) do
		if iter_14_1 == arg_14_2 then
			return false
		end

		if iter_14_1:isPlayCard() and iter_14_1.clientSimulateCanPlayCard then
			local var_14_2 = lua_skill.configDict[iter_14_1.skillId].logicTarget

			if (var_0_4[var_14_2] or var_0_5[var_14_2] and arg_14_0 == iter_14_1.toId and arg_14_0 ~= iter_14_1.belongToEntityId) and FightBuffHelper.checkSkillCanPurifyBySkill(arg_14_0, arg_14_1, iter_14_1.skillId, arg_14_3, iter_14_1.belongToEntityId) then
				return true
			end
		end
	end
end

local var_0_6 = {
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

function var_0_0.canUseCardSkill(arg_15_0, arg_15_1, arg_15_2)
	if not arg_15_0 or not arg_15_1 then
		return false
	end

	local var_15_0 = FightDataHelper.entityMgr:getById(arg_15_0)

	if not var_15_0 then
		return true
	end

	local var_15_1 = lua_skill.configDict[arg_15_1]

	for iter_15_0, iter_15_1 in ipairs(arg_15_2 or var_15_0:getBuffList()) do
		local var_15_2 = FightConfig.instance:getBuffFeatures(iter_15_1.buffId)

		for iter_15_2, iter_15_3 in pairs(var_15_2) do
			if var_0_0.isLockByLockBuffType(iter_15_3, var_15_1, arg_15_0) then
				return false
			end
		end
	end

	if FightModel.instance:isBeContractEntity(arg_15_0) then
		if arg_15_2 then
			local var_15_3 = FightModel.instance.contractEntityUid
			local var_15_4 = var_15_3 and FightDataHelper.entityMgr:getById(var_15_3)

			arg_15_2 = FightBuffHelper.simulateBuffList(var_15_4)

			if FightBuffHelper.hasFeature(nil, arg_15_2, FightEnum.BuffType_ContractCastChannel) then
				return false
			end
		elseif FightBuffHelper.checkCurEntityIsBeContractAndHasChannel(arg_15_0) then
			return false
		end
	end

	return true
end

function var_0_0.isLockByLockBuffType(arg_16_0, arg_16_1, arg_16_2)
	local var_16_0 = arg_16_1.isBigSkill == 1 and true or false
	local var_16_1 = arg_16_0.featureType
	local var_16_2 = var_0_6[var_16_1]

	if var_16_2 == true then
		return true
	end

	if var_16_2 then
		if var_16_2.reverse then
			if var_16_0 then
				if not var_16_2.bigSkill then
					return true
				end
			elseif not var_16_2[arg_16_1.effectTag] then
				return true
			end
		elseif var_16_2.UseSkillHasBuffCond then
			local var_16_3 = FightStrUtil.instance:getSplitToNumberCache(arg_16_0.featureStr, "#")

			for iter_16_0 = 3, #var_16_3 do
				if var_16_3[iter_16_0] == arg_16_1.id then
					local var_16_4 = FightHelper.getEntity(arg_16_2)

					if var_16_4 and var_16_4.buff and not var_16_4.buff:haveBuffTypeId(var_16_3[2]) then
						return true
					end
				end
			end
		elseif var_16_2[arg_16_1.effectTag] == true and var_16_2.bigSkill == var_16_0 then
			return true
		end
	end
end

function var_0_0._getCardLockReason(arg_17_0, arg_17_1, arg_17_2)
	if not arg_17_0 or not arg_17_1 then
		return
	end

	local var_17_0 = FightDataHelper.entityMgr:getById(arg_17_0)

	if not var_17_0 then
		return
	end

	local var_17_1 = lua_skill.configDict[arg_17_1]
	local var_17_2, var_17_3 = var_0_0.getLockBuffMo(var_17_0, arg_17_2, var_17_1)

	if FightModel.instance:isBeContractEntity(arg_17_0) then
		local var_17_4 = FightModel.instance.contractEntityUid
		local var_17_5 = var_17_4 and FightDataHelper.entityMgr:getById(var_17_4)

		arg_17_2 = FightBuffHelper.simulateBuffList(var_17_5)

		local var_17_6

		var_17_2, var_17_6 = var_0_0.getLockBuffMo(var_17_5, arg_17_2, var_17_1, var_17_2, var_17_3)
	end

	return var_17_2 and lua_skill_buff.configDict[var_17_2.buffId]
end

function var_0_0.getLockBuffMo(arg_18_0, arg_18_1, arg_18_2, arg_18_3, arg_18_4)
	if not arg_18_0 then
		return
	end

	arg_18_4 = arg_18_4 or -1
	arg_18_1 = arg_18_1 or arg_18_0:getBuffList()

	for iter_18_0, iter_18_1 in ipairs(arg_18_1) do
		local var_18_0 = FightConfig.instance:getBuffFeatures(iter_18_1.buffId)

		for iter_18_2, iter_18_3 in pairs(var_18_0) do
			if var_0_0.isLockByLockBuffType(iter_18_3, arg_18_2, arg_18_0.id) then
				local var_18_1 = FightEnum.CardLockPriorityDict[iter_18_2] or -1

				if not arg_18_3 then
					arg_18_3 = iter_18_1
					arg_18_4 = var_18_1
				elseif arg_18_4 < var_18_1 or var_18_1 == arg_18_4 and tonumber(iter_18_1.uid) > tonumber(arg_18_3.uid) then
					arg_18_3 = iter_18_1
					arg_18_4 = var_18_1
				end
			end
		end
	end

	return arg_18_3, arg_18_4
end

function var_0_0.logSkill(arg_19_0, arg_19_1)
	local var_19_0 = lua_skill.configDict[arg_19_0]

	logError(string.format("%s : %s", var_19_0.name, arg_19_1))
end

return var_0_0
