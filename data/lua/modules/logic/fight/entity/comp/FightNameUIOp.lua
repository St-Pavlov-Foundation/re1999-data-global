module("modules.logic.fight.entity.comp.FightNameUIOp", package.seeall)

slot0 = class("FightNameUIOp")

function slot0.init(slot0, slot1, slot2, slot3)
	slot0.forceLockFirst = false
	slot0.entity = slot1
	slot0.playCardInfoList = {}

	if slot0.entity:getMO() and slot4.custom_refreshNameUIOp then
		slot0:setPlayCardInfo(true)
	end

	slot0._opContainerCanvasGroup = gohelper.onceAddComponent(slot2, typeof(UnityEngine.CanvasGroup))
	slot0._opItemGO = slot3

	gohelper.setActive(slot0._opItemGO, false)

	slot0._opItemList = {}
	slot0._canUseCard = {}

	slot0:_updateEntityOps(slot5)

	if slot5 then
		slot0:_calCanUseCard()
	end

	FightController.instance:registerCallback(FightEvent.OnStageChange, slot0._onStageChange, slot0)
	FightController.instance:registerCallback(FightEvent.OnInvokeSkill, slot0._onInvokeSkill, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:registerCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:registerCallback(FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	FightController.instance:registerCallback(FightEvent.FightRoundEnd, slot0._onFightRoundEnd, slot0)
	FightController.instance:registerCallback(FightEvent.OnStartSequenceFinish, slot0._onStartSequenceFinish, slot0)
	FightController.instance:registerCallback(FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	FightController.instance:registerCallback(FightEvent.PlayEnemyChangeCardEffect, slot0._playEnemyChangeCardEffect, slot0)
	FightController.instance:registerCallback(FightEvent.OnExPointChange, slot0._onExPointChange, slot0)
	FightController.instance:registerCallback(FightEvent.GMHideFightView, slot0._checkGMHideUI, slot0)
	FightController.instance:registerCallback(FightEvent.MultiHpChange, slot0._onMultiHpChange, slot0)
	FightController.instance:registerCallback(FightEvent.InvalidEnemyUsedCard, slot0._onInvalidEnemyUsedCard, slot0)
end

function slot0._onRoundSequenceFinish(slot0)
	if FightModel.instance:isSeason2() then
		slot0:_calCanUseCard()

		return
	end

	slot0:_playOpInAnim()
end

function slot0._onStartSequenceFinish(slot0)
	slot0:_playOpInAnim()
end

function slot0.beforeDestroy(slot0)
	slot0._opContainerCanvasGroup = nil
	slot0._opItemGO = nil
	slot0._opItemList = nil

	FightController.instance:unregisterCallback(FightEvent.OnStageChange, slot0._onStageChange, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnInvokeSkill, slot0._onInvokeSkill, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayStart, slot0._onSkillPlayStart, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	FightController.instance:unregisterCallback(FightEvent.FightRoundEnd, slot0._onFightRoundEnd, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnStartSequenceFinish, slot0._onStartSequenceFinish, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	FightController.instance:unregisterCallback(FightEvent.PlayEnemyChangeCardEffect, slot0._playEnemyChangeCardEffect, slot0)
	FightController.instance:unregisterCallback(FightEvent.OnExPointChange, slot0._onExPointChange, slot0)
	FightController.instance:unregisterCallback(FightEvent.GMHideFightView, slot0._checkGMHideUI, slot0)
	FightController.instance:unregisterCallback(FightEvent.MultiHpChange, slot0._onMultiHpChange, slot0)
	FightController.instance:unregisterCallback(FightEvent.InvalidEnemyUsedCard, slot0._onInvalidEnemyUsedCard, slot0)
	TaskDispatcher.cancelTask(slot0._destroyImprisonMat, slot0)
	TaskDispatcher.cancelTask(slot0.hideOpContainer, slot0)
	TaskDispatcher.cancelTask(slot0._removePlayedCard, slot0)
	slot0:_destroyImprisonMat()
end

function slot0.setPlayCardInfo(slot0, slot1)
	slot0.playCardInfoList = {}

	if FightModel.instance:getCurRoundMO() then
		if slot1 then
			tabletool.addValues(slot0.playCardInfoList, slot2:getEntityLastAIUseCard(slot0.entity.id))
		else
			tabletool.addValues(slot0.playCardInfoList, slot2:getEntityAIUseCardMOs(slot0.entity.id))
		end
	end
end

function slot0.getSkillOpGO(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._opItemList) do
		if slot6.cardInfoMO == slot1 then
			return slot6.go
		end
	end
end

function slot0.updateUI(slot0)
	if slot0.entity then
		slot0:_updateEntityOps()
	end
end

function slot0._playEnemyChangeCardEffect(slot0, slot1)
	if not slot0.entity or not slot1 then
		return
	end

	for slot5, slot6 in ipairs(slot1) do
		if slot6.entityId == slot0.entity.id and slot0._opItemList[slot6.cardIndex] then
			slot8 = FightCardInfoMO.New()
			slot8.uid = slot6.entityId
			slot8.skillId = slot6.targetSkillId

			slot7:updateCardInfoMO(slot8)
		end
	end
end

function slot0._onExPointChange(slot0, slot1, slot2, slot3)
	if slot1 == slot0.entity.id then
		slot0:_checkPlayForbid()
	end
end

function slot0._checkGMHideUI(slot0)
	gohelper.setActive(slot0._opContainerCanvasGroup.gameObject, GMFightShowState.enemyOp)
end

function slot0.checkLockFirst(slot0)
	slot0.forceLockFirst = false

	if FightModel.instance:isSeason2() and slot0.entity:getMO() then
		for slot6, slot7 in ipairs(slot1:getBuffList()) do
			if slot7.buffId == 832400103 then
				slot0.forceLockFirst = true
			end
		end
	end
end

function slot0._onStageChange(slot0, slot1)
	slot0:checkLockFirst()

	if slot1 == FightEnum.Stage.Card or slot1 == FightEnum.Stage.AutoCard then
		if FightModel.instance:isSeason2() then
			if slot0._curRound ~= FightModel.instance:getCurRoundId() then
				slot0._curRound = FightModel.instance:getCurRoundId()
			else
				return
			end
		end

		slot0:setPlayCardInfo()
	end

	slot0:_updateEntityOps()
end

function slot0._canUseCardSkill(slot0, slot1, slot2)
	if not FightDataHelper.entityMgr:getById(slot1) then
		return false
	end

	if not FightModel.instance:isSeason2() then
		return FightViewHandCardItemLock.canUseCardSkill(slot0.entity.id, slot2)
	end

	slot5 = false

	for slot9, slot10 in ipairs(slot3:getBuffList()) do
		if slot10.buffId == 832400103 then
			slot5 = true

			break
		end
	end

	if slot5 then
		for slot9 = #FightDataHelper.coverData(slot4), 1, -1 do
			if slot4[slot9].buffId == 832400103 then
				table.remove(slot4, slot9)
			end
		end
	end

	return FightViewHandCardItemLock.canUseCardSkill(slot0.entity.id, slot2, slot4)
end

function slot0._playOpInAnim(slot0)
	slot0:_updateEntityOps()

	slot0._canUseCard = {}

	for slot4, slot5 in ipairs(slot0._opItemList) do
		slot0:_getAnimator(slot4).enabled = false

		gohelper.setActive(slot5.go, true)

		gohelper.onceAddComponent(slot5.go, typeof(UnityEngine.CanvasGroup)).alpha = 0
		slot0._canUseCard[slot5.cardInfoMO.custom_enemyCardIndex] = slot0:_canUseCardSkill(slot0.entity.id, slot5.cardInfoMO.skillId)
	end
end

function slot0._calCanUseCard(slot0)
	slot0._canUseCard = {}

	if FightModel.instance:getCurRoundMO() then
		for slot5, slot6 in ipairs(slot0.playCardInfoList) do
			slot0._canUseCard[slot6.custom_enemyCardIndex] = slot0:_canUseCardSkill(slot0.entity.id, slot6.skillId)
		end
	end
end

function slot0.onFlyEnd(slot0, slot1)
	gohelper.onceAddComponent(slot1.go, typeof(UnityEngine.CanvasGroup)).alpha = 1
	slot3 = slot0:_canUseSkill(slot1.cardInfoMO.skillId)

	if slot0.forceLockFirst and slot1 == slot0._opItemList[1] then
		slot3 = false
	end

	if not slot3 then
		slot0:_playOpForbidIn(slot1)
	else
		slot0:_playOpIn(slot1)
	end
end

function slot0._canUseSkill(slot0, slot1)
	slot2 = slot0.entity:getMO()

	if FightCardModel.instance:isUniqueSkill(slot0.entity.id, slot1) then
		slot3 = slot0:_canUseCardSkill(slot0.entity.id, slot1) and slot2:getUniqueSkillPoint() <= slot2.exPoint
	end

	return slot3
end

function slot0._onSkillPlayStart(slot0, slot1, slot2, slot3)
	if slot1.id ~= slot0.entity.id then
		return
	end

	slot0:_checkPlaySkill(slot3)
end

function slot0._checkPlaySkill(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._opItemList) do
		if slot6.cardInfoMO and slot6.cardInfoMO.custom_enemyCardIndex == slot1.cardIndex then
			slot6.cardInfoMO.custom_done = true

			slot0:_playOpOut(slot6)

			slot0._playingOutOpItem = slot0._playingOutOpItem or {}

			table.insert(slot0._playingOutOpItem, table.remove(slot0._opItemList, slot5))
			TaskDispatcher.cancelTask(slot0._removePlayedCard, slot0)
			TaskDispatcher.runDelay(slot0._removePlayedCard, slot0, 0.4)

			break
		end
	end
end

function slot0._removePlayedCard(slot0)
	if slot0._playingOutOpItem then
		for slot4, slot5 in ipairs(slot0._playingOutOpItem) do
			gohelper.destroy(slot5.go)
		end

		slot0._playingOutOpItem = nil
	end
end

function slot0._onInvokeSkill(slot0, slot1)
	if slot1.fromId ~= slot0.entity.id then
		return
	end

	slot0:_checkPlaySkill(slot1)
end

function slot0._onSkillPlayFinish(slot0)
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3)
	if slot1 ~= slot0.entity.id then
		return
	end

	if slot2 == FightEnum.EffectType.BUFFADD or slot2 == FightEnum.EffectType.BUFFDEL then
		slot0:_checkPlayForbid()
	end
end

function slot0._checkPlayForbid(slot0)
	slot0:checkLockFirst()

	for slot4, slot5 in ipairs(slot0._opItemList) do
		if slot5.cardInfoMO and not slot6.custom_done then
			slot8 = slot0:_canUseSkill(slot5.cardInfoMO.skillId)
			slot10 = slot0._canUseCard[slot5.cardInfoMO.custom_enemyCardIndex]

			if slot0.forceLockFirst and slot4 == 1 then
				slot8 = false
			end

			if slot8 and not slot10 then
				slot5:updateCardInfoMO(slot5.cardInfoMO)
				slot0:_playOpForbidUnlock(slot5)
			elseif not slot8 and slot10 then
				slot5:updateCardInfoMO(slot5.cardInfoMO)
				slot0:_playOpForbidIn(slot5)
			end

			slot0._canUseCard[slot9] = slot8
		end
	end
end

function slot0._onFightRoundEnd(slot0)
	if FightModel.instance:isFinish() then
		return
	end

	if FightModel.instance:isSeason2() then
		return
	end

	for slot4, slot5 in ipairs(slot0._opItemList) do
		if slot5.cardInfoMO and not slot6.custom_done then
			slot0:_playOpForbidImprison(slot5)

			slot6.custom_done = true

			FightController.instance:dispatchEvent(FightEvent.NeedWaitEnemyOPEnd)
		end
	end
end

function slot0._onInvalidEnemyUsedCard(slot0, slot1)
	if slot0._opItemList then
		for slot5, slot6 in ipairs(slot0._opItemList) do
			if slot6.cardInfoMO and slot6.cardInfoMO.custom_enemyCardIndex == slot1 then
				slot0:_playOpForbidIn(slot6)

				slot6.cardInfoMO.custom_done = true
			end
		end
	end
end

function slot0._updateEntityOps(slot0, slot1)
	if FightModel.instance:getCurStage() == FightEnum.Stage.Card or slot2 == FightEnum.Stage.AutoCard or slot1 then
		for slot10 = 1, slot0.playCardInfoList and #slot4 or 0 do
			if not slot4[slot10].custom_done then
				slot6 = 0 + 1

				if not slot0._opItemList[slot10] then
					table.insert(slot0._opItemList, MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.cloneInPlace(slot0._opItemGO, "op" .. slot10), FightOpItem))
				end

				gohelper.setAsFirstSibling(slot12.go)
				gohelper.setActive(slot12.go, true)
				slot12:updateCardInfoMO(slot11)
			end
		end

		for slot10 = slot6 + 1, #slot0._opItemList do
			gohelper.destroy(slot0._opItemList[slot10].go)

			slot0._opItemList[slot10] = nil
		end
	end
end

function slot0.getOpItemList(slot0)
	return slot0._opItemList or {}
end

function slot0._playOpIn(slot0, slot1)
	if slot0._opForbidOpItems then
		tabletool.removeValue(slot0._opForbidOpItems, slot1)
	end

	slot1:cancelOpForbid()
	slot0:_removeOpItemImprision(slot1)

	slot3 = slot1.go:GetComponent(typeof(UnityEngine.Animator))
	slot3.enabled = true

	slot3:Play("fightname_op_in", 0, 0)
	slot3:Update(0)
end

function slot0._playOpOut(slot0, slot1)
	slot0:_removeOpItemImprision(slot1)
	slot0:showOpContainer(0.67)

	slot3 = slot1.go:GetComponent(typeof(UnityEngine.Animator))
	slot3.enabled = true

	slot3:Play("fightname_op_play", 0, 0)
	slot3:Update(0)
end

function slot0._playOpForbidIn(slot0, slot1)
	slot0:_removeOpItemImprision(slot1)
	slot0:showOpContainer()

	slot3 = slot1.go:GetComponent(typeof(UnityEngine.Animator))
	slot3.enabled = true

	slot3:Play("fightname_forbid_in", 0, 0)
	slot3:Update(0)
end

function slot0._playOpForbidUnlock(slot0, slot1)
	slot0:_removeOpItemImprision(slot1)
	slot0:showOpContainer()

	slot3 = slot1.go:GetComponent(typeof(UnityEngine.Animator))
	slot3.enabled = true

	slot3:Play("fightname_forbid_unlock", 0, 0)
	slot3:Update(0)
end

function slot0._playOpForbidImprison(slot0, slot1)
	slot0:_removeOpItemImprision(slot1)
	slot0:showOpContainer()

	slot3 = slot1.go:GetComponent(typeof(UnityEngine.Animator))
	slot3.enabled = true

	slot3:Play("fightname_forbid_imprison", 0, 0)
	slot3:Update(0)
	slot1:showOpForbid()
	AudioMgr.instance:trigger(AudioEnum.UI.play_buff_attribute_up)

	if not slot0._opForbidOpItems then
		slot0._opForbidOpItems = {}

		TaskDispatcher.runDelay(slot0._destroyImprisonMat, slot0, 0.94)
	end

	table.insert(slot0._opForbidOpItems, slot1)
end

function slot0._removeOpItemImprision(slot0, slot1)
	if slot0._opForbidOpItems and tabletool.indexOf(slot0._opForbidOpItems, slot1) then
		tabletool.removeValue(slot0._opForbidOpItems, slot1)
		slot1:cancelOpForbid()

		if #slot0._opForbidOpItems == 0 then
			TaskDispatcher.cancelTask(slot0._destroyImprisonMat, slot0)
		end
	end
end

function slot0._destroyImprisonMat(slot0)
	if slot0._opForbidOpItems then
		for slot4, slot5 in ipairs(slot0._opForbidOpItems) do
			slot5:cancelOpForbid()
			gohelper.setActive(slot5.go, false)
		end

		slot0._opForbidOpItems = nil
	end
end

function slot0._getAnimator(slot0, slot1)
	return slot0._opItemList[slot1].go and slot2:GetComponent(typeof(UnityEngine.Animator))
end

function slot0.showOpContainer(slot0, slot1)
	slot0:_checkGMHideUI()

	if not gohelper.isNil(slot0._opContainerCanvasGroup) then
		slot0._opContainerCanvasGroup.alpha = 1
	end

	TaskDispatcher.cancelTask(slot0.hideOpContainer, slot0)

	if slot1 and slot1 > 0 then
		TaskDispatcher.runDelay(slot0.hideOpContainer, slot0, slot1)
	end
end

function slot0.hideOpContainer(slot0)
	if not gohelper.isNil(slot0._opContainerCanvasGroup) then
		slot0._opContainerCanvasGroup.alpha = 0
	end
end

function slot0._onMultiHpChange(slot0, slot1)
	if slot0.entity and slot0.entity.id == slot1 then
		slot0:updateUI()
	end
end

return slot0
