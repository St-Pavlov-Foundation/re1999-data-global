module("modules.logic.fight.view.FightViewWaitingArea", package.seeall)

slot0 = class("FightViewWaitingArea", BaseView)
slot1 = 0

function slot0.onInitView(slot0)
	slot0._waitingAreaTran = gohelper.findChild(slot0.viewGO, "root/waitingArea").transform
	slot0._waitingAreaGO = gohelper.findChild(slot0.viewGO, "root/waitingArea/inner")
	slot0._skillTipsGO = gohelper.findChild(slot0.viewGO, "root/waitingArea/inner/skill")
	slot0._txtCardTitle = gohelper.findChildText(slot0._skillTipsGO, "txtTips/txtTitle")
	slot0._txtCardDesc = gohelper.findChildText(slot0._skillTipsGO, "txtTips")
	slot0._cardItemList = {}
	slot0._cardItemGOList = slot0:getUserDataTb_()
	slot0._cardObjModel = gohelper.findChild(slot0._waitingAreaGO, "cardItemModel")
	slot1 = gohelper.cloneInPlace(slot0._cardObjModel, "cardItem1")

	table.insert(slot0._cardItemGOList, slot1)

	uv0 = recthelper.getWidth(slot1.transform)

	for slot6 = 2, 5 do
		slot7 = gohelper.findChild(slot0._waitingAreaGO, "cardItem" .. slot6) or gohelper.cloneInPlace(slot0._cardObjModel, "cardItem" .. slot6)

		table.insert(slot0._cardItemGOList, slot7)
		recthelper.setAnchorX(slot7.transform, recthelper.getAnchorX(slot1.transform) - 192 * (slot6 - 1))
	end

	slot0._cardDisplayFlow = FlowSequence.New()

	slot0._cardDisplayFlow:addWork(FightCardDisplayEffect.New())

	slot0._cardDisplayEndFlow = FlowSequence.New()

	slot0._cardDisplayEndFlow:addWork(FightCardDisplayEndEffect.New())

	slot0._cardDissolveFlow = FlowSequence.New()

	slot0._cardDissolveFlow:addWork(FightCardDissolveEffect.New())

	slot0._cardDisappearFlow = FlowParallel.New()

	slot0._cardDisappearFlow:addWork(FightCardDisplayHideAllEffect.New())
	slot0._cardDisappearFlow:addWork(FightCardDissolveEffect.New())

	slot0._changeCardFlow = FlowSequence.New()

	slot0._changeCardFlow:addWork(FightCardChangeEffectInWaitingArea.New())
	slot0:_refreshTipsVisibleState()
end

function slot0._refreshTipsVisibleState(slot0)
	gohelper.onceAddComponent(slot0._skillTipsGO, gohelper.Type_CanvasGroup).alpha = GMFightShowState.playSkillDes and 1 or 0
end

function slot0.onOpen(slot0)
	slot0:_makeTipsOutofSight()
	slot0:addEventCb(FightController.instance, FightEvent.UpdateWaitingArea, slot0._updateWaitingArea, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RespBeginRound, slot0._beginRoundSaveCardCantUse, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onEndRound, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.BeforePlaySkill, slot0._beforePlaySkill, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._skillFinishSaveCardCantUse, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PlayChangeCardEffectInWaitingArea, slot0._playChangeCardEffect, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.CardDisappear, slot0._onCardDisappear, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.FixWaitingAreaItemCount, slot0._fixWaitingAreaItemCount, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.GMHideFightView, slot0._refreshTipsVisibleState, slot0)
end

function slot0.onClose(slot0)
	slot0:_releaseScalseTween()
	slot0:removeEventCb(FightController.instance, FightEvent.UpdateWaitingArea, slot0._updateWaitingArea, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.RespBeginRound, slot0._beginRoundSaveCardCantUse, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onEndRound, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.BeforePlaySkill, slot0._beforePlaySkill, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._onSkillPlayFinish, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._skillFinishSaveCardCantUse, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnBuffUpdate, slot0._onBuffUpdate, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.PlayChangeCardEffectInWaitingArea, slot0._playChangeCardEffect, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.CardDisappear, slot0._onCardDisappear, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.FixWaitingAreaItemCount, slot0._fixWaitingAreaItemCount, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.GMHideFightView, slot0._refreshTipsVisibleState, slot0)
	slot0._cardDisplayFlow:stop()
	slot0._cardDisplayEndFlow:stop()
	slot0._cardDissolveFlow:stop()
	slot0._cardDisappearFlow:stop()
	slot0._changeCardFlow:stop()
	TaskDispatcher.cancelTask(slot0._delayPlayCardsChangeEffect, slot0)
	TaskDispatcher.cancelTask(slot0._delayPlayCardDisappear, slot0)
end

function slot0._fixWaitingAreaItemCount(slot0, slot1)
	if slot1 <= (slot0._cardItemGOList and #slot0._cardItemGOList) then
		return
	end

	for slot8 = slot2 + 1, slot1 do
		slot9 = gohelper.findChild(slot0._waitingAreaGO, "cardItem" .. slot8) or gohelper.cloneInPlace(slot0._cardObjModel, "cardItem" .. slot8)

		table.insert(slot0._cardItemGOList, slot9)
		recthelper.setAnchorX(slot9.transform, recthelper.getAnchorX(slot0._cardItemGOList[1].transform) - 192 * (slot8 - 1))
	end
end

function slot0._updateWaitingArea(slot0)
	slot0:_updateView()
end

function slot0._onEndRound(slot0)
	slot0:_makeTipsOutofSight()
end

function slot0._beginRoundSaveCardCantUse(slot0)
	slot0:_saveCantUseStatus()
end

function slot0._skillFinishSaveCardCantUse(slot0, slot1, slot2, slot3)
	if not slot1:isMySide() then
		return
	end

	slot0:_saveCantUseStatus()
end

function slot0._saveCantUseStatus(slot0)
	slot0._cardCantUseDict = {}

	if #FightPlayCardModel.instance:getClientLeftSkillOpList() == 0 then
		-- Nothing
	end

	for slot5, slot6 in ipairs(slot1) do
		if FightEntityModel.instance:getDeadById(slot6.entityId) or slot8 and FightCardModel.instance:isUniqueSkill(slot6.entityId, slot6.skillId) and (FightEntityModel.instance:getById(slot6.entityId) and slot8.exPoint or 0) < (slot8 and slot8:getUniqueSkillPoint() or 5) or not FightViewHandCardItemLock.canUseCardSkill(slot6.entityId, slot6.skillId) then
			slot0._cardCantUseDict[slot6] = true
		end
	end
end

function slot0._onCardDisappear(slot0)
	slot0._dissapearCount = slot0._dissapearCount and slot0._dissapearCount + 1 or 1

	TaskDispatcher.runDelay(slot0._delayPlayCardDisappear, slot0, 0.01)
end

function slot0._delayPlayCardDisappear(slot0)
	slot1 = {
		dissolveSkillItemGOs = slot0:getUserDataTb_(),
		hideSkillItemGOs = slot0:getUserDataTb_()
	}

	if math.min(slot0._dissapearCount, #FightPlayCardModel.instance:getClientLeftSkillOpList()) == 0 then
		slot0:_onDisappearCallback()

		return
	end

	for slot6 = 1, slot2 do
		slot7 = FightPlayCardModel.instance:getClientLeftSkillOpList()
		slot9 = slot7[#slot7]
		slot11 = slot9.skillId
		slot12 = FightEntityModel.instance:getById(slot9.entityId)

		if slot0._cardCantUseDict and slot0._cardCantUseDict[slot9] then
			slot13 = slot0._cardItemList[slot8].go

			table.insert(slot1.dissolveSkillItemGOs, slot13)
			gohelper.setActive(gohelper.findChild(slot13.transform.parent.gameObject, "lock"), false)
		else
			table.insert(slot1.hideSkillItemGOs, slot0._cardItemList[slot8].go)
		end

		FightPlayCardModel.instance:removeClientSkillOnce()
	end

	slot0._dissapearCount = nil

	slot0._cardDisappearFlow:registerDoneListener(slot0._onDisappearCallback, slot0)
	slot0._cardDisappearFlow:start(slot1)
end

function slot0._onDisappearCallback(slot0)
	FightController.instance:dispatchEvent(FightEvent.CardDisappearFinish)
end

function slot0._beforePlaySkill(slot0, slot1, slot2, slot3)
	if #FightPlayCardModel.instance:getClientLeftSkillOpList() == 0 then
		FightController.instance:dispatchEvent(FightEvent.ToPlaySkill, slot2)

		return
	end

	slot0._playingEntityId = slot1.id
	slot0._playingSkillId = slot2
	slot0._displayingEntityId = nil
	slot0._displayingSkillId = nil

	slot0:_updateView()

	if FightModel.instance:getCurStage() == FightEnum.Stage.Play then
		if slot2 == slot4[slot5].skillId then
			slot0:_displayFlow(slot0._playingEntityId, slot0._playingSkillId)
			FightController.instance:dispatchEvent(FightEvent.ToPlaySkill, slot2)
		elseif #slot4 > 0 then
			slot0:_dissolveFlow(slot0._onSkillPlayDissolveDone)
		else
			FightController.instance:dispatchEvent(FightEvent.ToPlaySkill, slot2)
		end
	else
		FightController.instance:dispatchEvent(FightEvent.ToPlaySkill, slot2)
	end
end

function slot0._onSkillPlayDissolveDone(slot0)
	if #FightPlayCardModel.instance:getClientLeftSkillOpList() > 0 then
		slot3 = slot1[slot2]

		slot0:_displayFlow(slot3.entityId, slot3.skillId)
	end

	FightController.instance:dispatchEvent(FightEvent.ToPlaySkill, slot0._playingSkillId)
end

function slot0._displayFlow(slot0, slot1, slot2)
	slot0._displayingEntityId = slot1
	slot0._displayingSkillId = slot2

	if slot0._cardDisplayEndFlow.status == WorkStatus.Running then
		slot0._cardDisplayEndFlow:stop()
		slot0._cardDisplayFlow:reset()
	end

	if slot0._cardDisplayFlow.status == WorkStatus.Running then
		slot0._cardDisplayFlow:stop()
		slot0._cardDisplayFlow:reset()
	end

	slot4 = slot0:getUserDataTb_()
	slot4.skillTipsGO = slot0._skillTipsGO
	slot4.skillItemGO = slot0._cardItemList[#FightPlayCardModel.instance:getClientLeftSkillOpList()].go
	slot4.waitingAreaGO = slot0._waitingAreaGO

	slot0._cardDisplayFlow:start(slot4)
	FightPlayCardModel.instance:onPlayOneSkillId(slot0._displayingEntityId, slot0._displayingSkillId)
end

function slot0._dissolveFlow(slot0, slot1)
	slot0._dissolveEndCallback = slot1
	slot2 = {
		dissolveSkillItemGOs = slot0:getUserDataTb_()
	}
	slot4 = #FightPlayCardModel.instance:getClientLeftSkillOpList()

	while not false and slot4 > 0 and #FightPlayCardModel.instance:getServerLeftSkillOpList() <= slot4 do
		if not FightPlayCardModel.instance:checkClientSkillMatch(slot0._playingEntityId, slot0._playingSkillId) then
			FightPlayCardModel.instance:removeClientSkillOnce()

			slot6 = slot0._cardItemList[slot4].go

			table.insert(slot2.dissolveSkillItemGOs, slot6)
			gohelper.setActive(gohelper.findChild(slot6.transform.parent.gameObject, "lock"), false)
		end

		slot4 = #FightPlayCardModel.instance:getClientLeftSkillOpList()
	end

	slot0._cardDissolveFlow:registerDoneListener(slot0._onDissolveFlowDone, slot0)
	slot0._cardDissolveFlow:start(slot2)
end

function slot0._onDissolveFlowDone(slot0)
	slot0:_updateView()

	slot0._dissolveEndCallback = nil

	if slot0._dissolveEndCallback then
		slot1(slot0)
	end
end

function slot0._onSkillPlayFinish(slot0, slot1, slot2, slot3)
	if not slot0._displayingEntityId then
		return
	end

	if slot1.id ~= slot0._displayingEntityId or slot2 ~= slot0._displayingSkillId then
		return
	end

	slot4 = nil

	for slot8 = #slot0._cardItemList, 1, -1 do
		if slot0._cardItemList[slot8].go.activeSelf then
			slot4 = slot9.go

			break
		end
	end

	slot0._displayingEntityId = nil
	slot0._displayingSkillId = nil
	slot5 = slot0:getUserDataTb_()
	slot5.skillTipsGO = slot0._skillTipsGO
	slot5.skillItemGO = slot4
	slot5.waitingAreaGO = slot0._waitingAreaGO

	slot0._cardDisplayEndFlow:start(slot5)
end

function slot0._onBuffUpdate(slot0, slot1, slot2, slot3)
	if not FightEntityModel.instance:getById(slot1) or slot4.side ~= FightEnum.EntitySide.MySide then
		return
	end

	for slot9 = 1, #FightPlayCardModel.instance:getClientLeftSkillOpList() do
		if slot0._cardItemList[slot9] then
			slot0:_setCardLockEffect(slot10, slot5[slot9], slot9)
		end
	end
end

function slot0._makeTipsOutofSight(slot0)
	recthelper.setAnchorX(slot0._skillTipsGO.transform, 9999999)
end

function slot0._updateView(slot0)
	gohelper.setActive(slot0._waitingAreaGO, #FightPlayCardModel.instance:getClientLeftSkillOpList() > 0)

	for slot6 = 1, slot2 do
		slot8 = slot1[slot6].entityId
		slot9 = slot1[slot6].skillId

		if not slot0._cardItemList[slot6] then
			slot12 = slot0:getResInst(slot0.viewContainer:getSetting().otherRes[1], slot0._cardItemGOList[slot6], "card")

			gohelper.setAsFirstSibling(slot12)
			table.insert(slot0._cardItemList, MonoHelper.addNoUpdateLuaComOnceToGo(slot12, FightViewCardItem))
		end

		transformhelper.setLocalScale(slot10.tr, 1, 1, 1)
		recthelper.setAnchor(slot10.tr, 0, 0)

		gohelper.onceAddComponent(slot10.go, typeof(UnityEngine.CanvasGroup)).alpha = 1

		gohelper.setActive(slot10.go, true)
		slot10:updateItem(slot8, slot9)

		slot10.op = slot1[slot6]

		slot0:_setCardLockEffect(slot10, slot1[slot6], slot6)
	end

	for slot6 = slot2 + 1, #slot0._cardItemList do
		slot7 = slot0._cardItemList[slot6]

		gohelper.setActive(gohelper.findChild(slot7.tr.parent.gameObject, "lock"), false)
		gohelper.setActive(slot7.go, false)
	end

	slot3 = slot1[slot2] and slot1[slot2].skillId
	slot5 = slot3 and lua_skill.configDict[slot3]
	slot0._txtCardTitle.text = slot5 and slot5.name or ""
	slot0._txtCardDesc.text = slot5 and HeroSkillModel.instance:skillDesToSpot(FightConfig.instance:getEntitySkillDesc(slot1[slot2] and slot1[slot2].entityId, slot5, slot3)) or ""

	slot0:_releaseScalseTween()

	if (slot2 > 7 and 1 - (slot2 - 7) * 0.12 or 1) < 0 then
		slot7 = 0.5
	end

	slot8 = 1 / slot7

	transformhelper.setLocalScale(slot0._skillTipsGO.transform, slot8, slot8, slot8)

	slot0._tweenScale = ZProj.TweenHelper.DOScale(slot0._waitingAreaTran, slot7, slot7, slot7, 0.1)
end

function slot0._releaseScalseTween(slot0)
	if slot0._tweenScale then
		ZProj.TweenHelper.KillById(slot0._tweenScale)

		slot0._tweenScale = nil
	end
end

function slot0._setCardLockEffect(slot0, slot1, slot2, slot3)
	if slot0._unlockStartTime and slot0._unlockStartTime[slot2.skillId] and Time.time - slot5 < 1 then
		return
	end

	FightViewHandCardItemLock.setCardLock(slot2.entityId, slot2.skillId, gohelper.findChild(slot1.tr.parent.gameObject, "lock"), false)

	slot8 = FightPlayCardModel.instance:getServerLeftSkillOpList()[slot3]

	if not FightViewHandCardItemLock.canUseCardSkill(slot2.entityId, slot2.skillId) and slot8 and slot8.entityId == slot2.entityId and slot8.skillId == slot2.skillId then
		slot0._preRemoveState = slot0._preRemoveState or {}
		slot0._preRemoveState[slot2] = true

		FightViewHandCardItemLock.setCardPreRemove(slot2.entityId, slot2.skillId, slot6, false)
	end

	if slot7 and slot0._preRemoveState and slot0._preRemoveState[slot2] then
		gohelper.setActive(slot6, true)
		FightViewHandCardItemLock.setCardUnLock(slot2.entityId, slot2.skillId, slot6)

		slot0._preRemoveState[slot2] = nil
		slot0._unlockStartTime = slot0._unlockStartTime or {}
		slot0._unlockStartTime[slot2] = slot4
	end
end

function slot0._playChangeCardEffect(slot0, slot1)
	slot0._changeInfos = slot0._changeInfos or {}

	tabletool.addValues(slot0._changeInfos, slot1)
	TaskDispatcher.cancelTask(slot0._delayPlayCardsChangeEffect, slot0)
	TaskDispatcher.runDelay(slot0._delayPlayCardsChangeEffect, slot0, 0.03)
end

function slot0._delayPlayCardsChangeEffect(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.changeInfos = slot0._changeInfos
	slot1.cardItemList = slot0._cardItemList

	slot0._changeCardFlow:registerDoneListener(slot0._onChangeCardDone, slot0)
	slot0._changeCardFlow:start(slot1)

	slot0._changeInfos = nil
end

function slot0._onChangeCardDone(slot0)
	slot0._changeCardFlow:unregisterDoneListener(slot0._onChangeCardDone, slot0)
	slot0:_updateView()
	FightController.instance:dispatchEvent(FightEvent.OnChangeCardEffectDone)
end

return slot0
