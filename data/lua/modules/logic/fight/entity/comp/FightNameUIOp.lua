module("modules.logic.fight.entity.comp.FightNameUIOp", package.seeall)

local var_0_0 = class("FightNameUIOp")

function var_0_0.init(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.forceLockFirst = false
	arg_1_0.entity = arg_1_1

	local var_1_0 = arg_1_0.entity:getMO()
	local var_1_1 = var_1_0 and var_1_0.custom_refreshNameUIOp

	arg_1_0.playCardInfoList = {}

	if var_1_1 then
		arg_1_0:setPlayCardInfo(true)
	end

	arg_1_0._opContainerCanvasGroup = gohelper.onceAddComponent(arg_1_2, typeof(UnityEngine.CanvasGroup))
	arg_1_0._opItemGO = arg_1_3

	gohelper.setActive(arg_1_0._opItemGO, false)

	arg_1_0._opItemList = {}
	arg_1_0._canUseCard = {}

	arg_1_0:_updateEntityOps(var_1_1)

	if var_1_1 then
		arg_1_0:_calCanUseCard()
	end

	FightController.instance:registerCallback(FightEvent.OnStageChange, arg_1_0._onStageChange, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnInvokeSkill, arg_1_0._onInvokeSkill, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, arg_1_0._onSkillPlayStart, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, arg_1_0._onSkillPlayFinish, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, arg_1_0._onBuffUpdate, arg_1_0)
	FightController.instance:registerCallback(FightEvent.FightRoundEnd, arg_1_0._onFightRoundEnd, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnStartSequenceFinish, arg_1_0._onStartSequenceFinish, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, arg_1_0._onRoundSequenceFinish, arg_1_0)
	FightController.instance:registerCallback(FightEvent.PlayEnemyChangeCardEffect, arg_1_0._playEnemyChangeCardEffect, arg_1_0)
	FightController.instance:registerCallback(FightEvent.OnExPointChange, arg_1_0._onExPointChange, arg_1_0)
	FightController.instance:registerCallback(FightEvent.GMHideFightView, arg_1_0._checkGMHideUI, arg_1_0)
	FightController.instance:registerCallback(FightEvent.MultiHpChange, arg_1_0._onMultiHpChange, arg_1_0)
	FightController.instance:registerCallback(FightEvent.InvalidEnemyUsedCard, arg_1_0._onInvalidEnemyUsedCard, arg_1_0)
end

function var_0_0._onRoundSequenceFinish(arg_2_0)
	if FightModel.instance:isSeason2() then
		arg_2_0:_calCanUseCard()

		return
	end

	arg_2_0:_playOpInAnim()
end

function var_0_0._onStartSequenceFinish(arg_3_0)
	arg_3_0:_playOpInAnim()
end

function var_0_0.beforeDestroy(arg_4_0)
	arg_4_0._opContainerCanvasGroup = nil
	arg_4_0._opItemGO = nil
	arg_4_0._opItemList = nil

	FightController.instance:unregisterCallback(FightEvent.OnStageChange, arg_4_0._onStageChange, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnInvokeSkill, arg_4_0._onInvokeSkill, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, arg_4_0._onSkillPlayStart, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, arg_4_0._onSkillPlayFinish, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, arg_4_0._onBuffUpdate, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.FightRoundEnd, arg_4_0._onFightRoundEnd, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnStartSequenceFinish, arg_4_0._onStartSequenceFinish, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, arg_4_0._onRoundSequenceFinish, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.PlayEnemyChangeCardEffect, arg_4_0._playEnemyChangeCardEffect, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.OnExPointChange, arg_4_0._onExPointChange, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.GMHideFightView, arg_4_0._checkGMHideUI, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.MultiHpChange, arg_4_0._onMultiHpChange, arg_4_0)
	FightController.instance:unregisterCallback(FightEvent.InvalidEnemyUsedCard, arg_4_0._onInvalidEnemyUsedCard, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._destroyImprisonMat, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0.hideOpContainer, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._removePlayedCard, arg_4_0)
	arg_4_0:_destroyImprisonMat()
end

function var_0_0.setPlayCardInfo(arg_5_0, arg_5_1)
	arg_5_0.playCardInfoList = {}

	local var_5_0 = FightDataHelper.roundMgr:getRoundData()

	if var_5_0 then
		local var_5_1 = FightDataHelper.roundMgr:getPreRoundData()

		if arg_5_1 and var_5_1 then
			local var_5_2 = var_5_1:getEntityAIUseCardMOList(arg_5_0.entity.id)

			tabletool.addValues(arg_5_0.playCardInfoList, var_5_2)
		else
			local var_5_3 = var_5_0:getEntityAIUseCardMOList(arg_5_0.entity.id)

			tabletool.addValues(arg_5_0.playCardInfoList, var_5_3)
		end
	end
end

function var_0_0.getSkillOpGO(arg_6_0, arg_6_1)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0._opItemList) do
		if iter_6_1.cardInfoMO == arg_6_1 then
			return iter_6_1.go
		end
	end
end

function var_0_0.updateUI(arg_7_0)
	if arg_7_0.entity then
		arg_7_0:_updateEntityOps()
	end
end

function var_0_0._playEnemyChangeCardEffect(arg_8_0, arg_8_1)
	if not arg_8_0.entity or not arg_8_1 then
		return
	end

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		if iter_8_1.entityId == arg_8_0.entity.id then
			local var_8_0 = arg_8_0._opItemList[iter_8_1.cardIndex]

			if var_8_0 then
				local var_8_1 = FightCardInfoData.New({
					uid = iter_8_1.entityId,
					skillId = iter_8_1.targetSkillId
				})

				var_8_0:updateCardInfoMO(var_8_1)
			end
		end
	end
end

function var_0_0._onExPointChange(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if arg_9_1 == arg_9_0.entity.id then
		arg_9_0:_checkPlayForbid()
	end
end

function var_0_0._checkGMHideUI(arg_10_0)
	gohelper.setActive(arg_10_0._opContainerCanvasGroup.gameObject, GMFightShowState.enemyOp)
end

function var_0_0.checkLockFirst(arg_11_0)
	arg_11_0.forceLockFirst = false

	if FightModel.instance:isSeason2() then
		local var_11_0 = arg_11_0.entity:getMO()

		if var_11_0 then
			local var_11_1 = var_11_0:getBuffList()

			for iter_11_0, iter_11_1 in ipairs(var_11_1) do
				if iter_11_1.buffId == 832400103 then
					arg_11_0.forceLockFirst = true
				end
			end
		end
	end
end

function var_0_0._onStageChange(arg_12_0, arg_12_1)
	arg_12_0:checkLockFirst()

	if arg_12_1 == FightEnum.Stage.Card or arg_12_1 == FightEnum.Stage.AutoCard then
		if FightModel.instance:isSeason2() then
			if arg_12_0._curRound ~= FightModel.instance:getCurRoundId() then
				arg_12_0._curRound = FightModel.instance:getCurRoundId()
			else
				return
			end
		end

		arg_12_0:setPlayCardInfo()
	end

	arg_12_0:_updateEntityOps()
end

function var_0_0._canUseCardSkill(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = FightDataHelper.entityMgr:getById(arg_13_1)

	if not var_13_0 then
		return false
	end

	if not FightModel.instance:isSeason2() then
		return FightViewHandCardItemLock.canUseCardSkill(arg_13_0.entity.id, arg_13_2)
	end

	local var_13_1 = var_13_0:getBuffList()
	local var_13_2 = false

	for iter_13_0, iter_13_1 in ipairs(var_13_1) do
		if iter_13_1.buffId == 832400103 then
			var_13_2 = true

			break
		end
	end

	if var_13_2 then
		var_13_1 = FightDataUtil.coverData(var_13_1)

		for iter_13_2 = #var_13_1, 1, -1 do
			if var_13_1[iter_13_2].buffId == 832400103 then
				table.remove(var_13_1, iter_13_2)
			end
		end
	end

	return FightViewHandCardItemLock.canUseCardSkill(arg_13_0.entity.id, arg_13_2, var_13_1)
end

function var_0_0._playOpInAnim(arg_14_0)
	arg_14_0:_updateEntityOps()

	arg_14_0._canUseCard = {}

	for iter_14_0, iter_14_1 in ipairs(arg_14_0._opItemList) do
		arg_14_0:_getAnimator(iter_14_0).enabled = false

		gohelper.setActive(iter_14_1.go, true)

		gohelper.onceAddComponent(iter_14_1.go, typeof(UnityEngine.CanvasGroup)).alpha = 0

		local var_14_0 = iter_14_1.cardInfoMO.skillId
		local var_14_1 = iter_14_1.cardInfoMO.clientData.custom_enemyCardIndex

		arg_14_0._canUseCard[var_14_1] = arg_14_0:_canUseCardSkill(arg_14_0.entity.id, var_14_0)
	end
end

function var_0_0._calCanUseCard(arg_15_0)
	arg_15_0._canUseCard = {}

	if FightDataHelper.roundMgr:getRoundData() then
		for iter_15_0, iter_15_1 in ipairs(arg_15_0.playCardInfoList) do
			local var_15_0 = iter_15_1.skillId
			local var_15_1 = iter_15_1.clientData.custom_enemyCardIndex

			arg_15_0._canUseCard[var_15_1] = arg_15_0:_canUseCardSkill(arg_15_0.entity.id, var_15_0)
		end
	end
end

function var_0_0.onFlyEnd(arg_16_0, arg_16_1)
	gohelper.onceAddComponent(arg_16_1.go, typeof(UnityEngine.CanvasGroup)).alpha = 1

	local var_16_0 = arg_16_1.cardInfoMO.skillId
	local var_16_1 = arg_16_0:_canUseSkill(var_16_0)

	if arg_16_0.forceLockFirst and arg_16_1 == arg_16_0._opItemList[1] then
		var_16_1 = false
	end

	if not var_16_1 then
		arg_16_0:_playOpForbidIn(arg_16_1)
	else
		arg_16_0:_playOpIn(arg_16_1)
	end
end

function var_0_0._canUseSkill(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_0.entity:getMO()
	local var_17_1 = arg_17_0:_canUseCardSkill(arg_17_0.entity.id, arg_17_1)
	local var_17_2 = FightCardDataHelper.isBigSkill(arg_17_1)

	if lua_skill_next.configDict[arg_17_1] then
		var_17_2 = false
	end

	if var_17_2 then
		local var_17_3 = var_17_0.exPoint
		local var_17_4 = var_17_0:getUniqueSkillPoint()

		var_17_1 = var_17_1 and var_17_4 <= var_17_3
	end

	return var_17_1
end

function var_0_0._onSkillPlayStart(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	if arg_18_1.id ~= arg_18_0.entity.id then
		return
	end

	arg_18_0:_checkPlaySkill(arg_18_3)
end

function var_0_0._checkPlaySkill(arg_19_0, arg_19_1)
	for iter_19_0, iter_19_1 in ipairs(arg_19_0._opItemList) do
		if iter_19_1.cardInfoMO and iter_19_1.cardInfoMO.clientData.custom_enemyCardIndex == arg_19_1.cardIndex then
			iter_19_1.cardInfoMO.custom_done = true

			arg_19_0:_playOpOut(iter_19_1)

			arg_19_0._playingOutOpItem = arg_19_0._playingOutOpItem or {}

			table.insert(arg_19_0._playingOutOpItem, table.remove(arg_19_0._opItemList, iter_19_0))
			TaskDispatcher.cancelTask(arg_19_0._removePlayedCard, arg_19_0)
			TaskDispatcher.runDelay(arg_19_0._removePlayedCard, arg_19_0, 0.4)

			break
		end
	end
end

function var_0_0._removePlayedCard(arg_20_0)
	if arg_20_0._playingOutOpItem then
		for iter_20_0, iter_20_1 in ipairs(arg_20_0._playingOutOpItem) do
			gohelper.destroy(iter_20_1.go)
		end

		arg_20_0._playingOutOpItem = nil
	end
end

function var_0_0._onInvokeSkill(arg_21_0, arg_21_1)
	if arg_21_1.fromId ~= arg_21_0.entity.id then
		return
	end

	arg_21_0:_checkPlaySkill(arg_21_1)
end

function var_0_0._onSkillPlayFinish(arg_22_0)
	return
end

function var_0_0._onBuffUpdate(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	if arg_23_1 ~= arg_23_0.entity.id then
		return
	end

	if arg_23_2 == FightEnum.EffectType.BUFFADD or arg_23_2 == FightEnum.EffectType.BUFFDEL then
		arg_23_0:_checkPlayForbid()
	end
end

function var_0_0._checkPlayForbid(arg_24_0)
	arg_24_0:checkLockFirst()

	for iter_24_0, iter_24_1 in ipairs(arg_24_0._opItemList) do
		local var_24_0 = iter_24_1.cardInfoMO

		if var_24_0 and not var_24_0.custom_done then
			local var_24_1 = iter_24_1.cardInfoMO.skillId
			local var_24_2 = arg_24_0:_canUseSkill(var_24_1)
			local var_24_3 = iter_24_1.cardInfoMO.clientData.custom_enemyCardIndex
			local var_24_4 = arg_24_0._canUseCard[var_24_3]

			if arg_24_0.forceLockFirst and iter_24_0 == 1 then
				var_24_2 = false
			end

			if var_24_2 and not var_24_4 then
				iter_24_1:updateCardInfoMO(iter_24_1.cardInfoMO)
				arg_24_0:_playOpForbidUnlock(iter_24_1)
			elseif not var_24_2 and var_24_4 then
				iter_24_1:updateCardInfoMO(iter_24_1.cardInfoMO)
				arg_24_0:_playOpForbidIn(iter_24_1)
			end

			arg_24_0._canUseCard[var_24_3] = var_24_2
		end
	end
end

function var_0_0._onFightRoundEnd(arg_25_0)
	if FightModel.instance:isFinish() then
		return
	end

	if FightModel.instance:isSeason2() then
		return
	end

	for iter_25_0, iter_25_1 in ipairs(arg_25_0._opItemList) do
		local var_25_0 = iter_25_1.cardInfoMO

		if var_25_0 and not var_25_0.custom_done then
			arg_25_0:_playOpForbidImprison(iter_25_1)

			var_25_0.custom_done = true

			FightController.instance:dispatchEvent(FightEvent.NeedWaitEnemyOPEnd)
		end
	end
end

function var_0_0._onInvalidEnemyUsedCard(arg_26_0, arg_26_1)
	if arg_26_0._opItemList then
		for iter_26_0, iter_26_1 in ipairs(arg_26_0._opItemList) do
			if iter_26_1.cardInfoMO and iter_26_1.cardInfoMO.clientData.custom_enemyCardIndex == arg_26_1 then
				arg_26_0:_playOpForbidIn(iter_26_1)

				iter_26_1.cardInfoMO.custom_done = true
			end
		end
	end
end

function var_0_0._updateEntityOps(arg_27_0, arg_27_1)
	local var_27_0 = FightModel.instance:getCurStage()

	if var_27_0 == FightEnum.Stage.Card or var_27_0 == FightEnum.Stage.AutoCard or arg_27_1 then
		local var_27_1 = arg_27_0.playCardInfoList
		local var_27_2 = var_27_1 and #var_27_1 or 0
		local var_27_3 = 0

		for iter_27_0 = 1, var_27_2 do
			local var_27_4 = var_27_1[iter_27_0]

			if not var_27_4.custom_done then
				var_27_3 = var_27_3 + 1

				local var_27_5 = arg_27_0._opItemList[iter_27_0]

				if not var_27_5 then
					local var_27_6 = gohelper.cloneInPlace(arg_27_0._opItemGO, "op" .. iter_27_0)

					var_27_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_27_6, FightOpItem)

					table.insert(arg_27_0._opItemList, var_27_5)
				end

				gohelper.setAsFirstSibling(var_27_5.go)
				gohelper.setActive(var_27_5.go, true)
				var_27_5:updateCardInfoMO(var_27_4)
			end
		end

		for iter_27_1 = var_27_3 + 1, #arg_27_0._opItemList do
			gohelper.destroy(arg_27_0._opItemList[iter_27_1].go)

			arg_27_0._opItemList[iter_27_1] = nil
		end
	end
end

function var_0_0.getOpItemList(arg_28_0)
	return arg_28_0._opItemList or {}
end

function var_0_0._playOpIn(arg_29_0, arg_29_1)
	if arg_29_0._opForbidOpItems then
		tabletool.removeValue(arg_29_0._opForbidOpItems, arg_29_1)
	end

	arg_29_1:cancelOpForbid()
	arg_29_0:_removeOpItemImprision(arg_29_1)

	local var_29_0 = arg_29_1.go:GetComponent(typeof(UnityEngine.Animator))

	var_29_0.enabled = true

	var_29_0:Play("fightname_op_in", 0, 0)
	var_29_0:Update(0)
end

function var_0_0._playOpOut(arg_30_0, arg_30_1)
	arg_30_0:_removeOpItemImprision(arg_30_1)
	arg_30_0:showOpContainer(0.67)

	local var_30_0 = arg_30_1.go:GetComponent(typeof(UnityEngine.Animator))

	var_30_0.enabled = true

	var_30_0:Play("fightname_op_play", 0, 0)
	var_30_0:Update(0)
end

function var_0_0._playOpForbidIn(arg_31_0, arg_31_1)
	arg_31_0:_removeOpItemImprision(arg_31_1)
	arg_31_0:showOpContainer()

	local var_31_0 = arg_31_1.go:GetComponent(typeof(UnityEngine.Animator))

	var_31_0.enabled = true

	var_31_0:Play("fightname_forbid_in", 0, 0)
	var_31_0:Update(0)
end

function var_0_0._playOpForbidUnlock(arg_32_0, arg_32_1)
	arg_32_0:_removeOpItemImprision(arg_32_1)
	arg_32_0:showOpContainer()

	local var_32_0 = arg_32_1.go:GetComponent(typeof(UnityEngine.Animator))

	var_32_0.enabled = true

	var_32_0:Play("fightname_forbid_unlock", 0, 0)
	var_32_0:Update(0)
end

function var_0_0._playOpForbidImprison(arg_33_0, arg_33_1)
	arg_33_0:_removeOpItemImprision(arg_33_1)
	arg_33_0:showOpContainer()

	local var_33_0 = arg_33_1.go:GetComponent(typeof(UnityEngine.Animator))

	var_33_0.enabled = true

	var_33_0:Play("fightname_forbid_imprison", 0, 0)
	var_33_0:Update(0)
	arg_33_1:showOpForbid()
	AudioMgr.instance:trigger(AudioEnum.UI.play_buff_attribute_up)

	if not arg_33_0._opForbidOpItems then
		arg_33_0._opForbidOpItems = {}

		TaskDispatcher.runDelay(arg_33_0._destroyImprisonMat, arg_33_0, 0.94)
	end

	table.insert(arg_33_0._opForbidOpItems, arg_33_1)
end

function var_0_0._removeOpItemImprision(arg_34_0, arg_34_1)
	if arg_34_0._opForbidOpItems and tabletool.indexOf(arg_34_0._opForbidOpItems, arg_34_1) then
		tabletool.removeValue(arg_34_0._opForbidOpItems, arg_34_1)
		arg_34_1:cancelOpForbid()

		if #arg_34_0._opForbidOpItems == 0 then
			TaskDispatcher.cancelTask(arg_34_0._destroyImprisonMat, arg_34_0)
		end
	end
end

function var_0_0._destroyImprisonMat(arg_35_0)
	if arg_35_0._opForbidOpItems then
		for iter_35_0, iter_35_1 in ipairs(arg_35_0._opForbidOpItems) do
			iter_35_1:cancelOpForbid()
			gohelper.setActive(iter_35_1.go, false)
		end

		arg_35_0._opForbidOpItems = nil
	end
end

function var_0_0._getAnimator(arg_36_0, arg_36_1)
	local var_36_0 = arg_36_0._opItemList[arg_36_1].go

	return var_36_0 and var_36_0:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0.showOpContainer(arg_37_0, arg_37_1)
	arg_37_0:_checkGMHideUI()

	if not gohelper.isNil(arg_37_0._opContainerCanvasGroup) then
		arg_37_0._opContainerCanvasGroup.alpha = 1
	end

	TaskDispatcher.cancelTask(arg_37_0.hideOpContainer, arg_37_0)

	if arg_37_1 and arg_37_1 > 0 then
		TaskDispatcher.runDelay(arg_37_0.hideOpContainer, arg_37_0, arg_37_1)
	end
end

function var_0_0.hideOpContainer(arg_38_0)
	if not gohelper.isNil(arg_38_0._opContainerCanvasGroup) then
		arg_38_0._opContainerCanvasGroup.alpha = 0
	end
end

function var_0_0._onMultiHpChange(arg_39_0, arg_39_1)
	if arg_39_0.entity and arg_39_0.entity.id == arg_39_1 then
		arg_39_0:updateUI()
	end
end

return var_0_0
