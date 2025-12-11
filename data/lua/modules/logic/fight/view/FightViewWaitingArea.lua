module("modules.logic.fight.view.FightViewWaitingArea", package.seeall)

local var_0_0 = class("FightViewWaitingArea", BaseView)
local var_0_1 = 0

function var_0_0.onInitView(arg_1_0)
	arg_1_0._waitingAreaTran = gohelper.findChild(arg_1_0.viewGO, "root/waitingArea").transform
	arg_1_0._waitingAreaGO = gohelper.findChild(arg_1_0.viewGO, "root/waitingArea/inner")
	arg_1_0._skillTipsGO = gohelper.findChild(arg_1_0.viewGO, "root/waitingArea/inner/skill")
	arg_1_0._txtCardTitle = gohelper.findChildText(arg_1_0._skillTipsGO, "txtTips/txtTitle")
	arg_1_0._txtCardDesc = gohelper.findChildText(arg_1_0._skillTipsGO, "txtTips")
	arg_1_0._rectTrCardDesc = arg_1_0._txtCardDesc:GetComponent(gohelper.Type_RectTransform)
	arg_1_0._cardItemList = {}
	arg_1_0._cardItemGOList = arg_1_0:getUserDataTb_()
	arg_1_0._cardObjModel = gohelper.findChild(arg_1_0._waitingAreaGO, "cardItemModel")

	local var_1_0 = gohelper.cloneInPlace(arg_1_0._cardObjModel, "cardItem1")

	table.insert(arg_1_0._cardItemGOList, var_1_0)

	var_0_1 = recthelper.getWidth(var_1_0.transform)

	local var_1_1 = recthelper.getAnchorX(var_1_0.transform)

	for iter_1_0 = 2, 5 do
		local var_1_2 = gohelper.findChild(arg_1_0._waitingAreaGO, "cardItem" .. iter_1_0) or gohelper.cloneInPlace(arg_1_0._cardObjModel, "cardItem" .. iter_1_0)

		table.insert(arg_1_0._cardItemGOList, var_1_2)
		recthelper.setAnchorX(var_1_2.transform, var_1_1 - 192 * (iter_1_0 - 1))
	end

	arg_1_0._cardDisplayFlow = FlowSequence.New()

	arg_1_0._cardDisplayFlow:addWork(FightCardDisplayEffect.New())

	arg_1_0._cardDisplayEndFlow = FlowSequence.New()

	arg_1_0._cardDisplayEndFlow:addWork(FightCardDisplayEndEffect.New())

	arg_1_0._cardDissolveFlow = FlowSequence.New()

	arg_1_0._cardDissolveFlow:addWork(FightCardDissolveEffect.New())

	arg_1_0._cardDisappearFlow = FlowParallel.New()

	arg_1_0._cardDisappearFlow:addWork(FightCardDisplayHideAllEffect.New())
	arg_1_0._cardDisappearFlow:addWork(FightCardDissolveEffect.New())

	arg_1_0._changeCardFlow = FlowSequence.New()

	arg_1_0._changeCardFlow:addWork(FightCardChangeEffectInWaitingArea.New())
	arg_1_0:_refreshTipsVisibleState()
end

function var_0_0._refreshTipsVisibleState(arg_2_0)
	gohelper.onceAddComponent(arg_2_0._skillTipsGO, gohelper.Type_CanvasGroup).alpha = GMFightShowState.playSkillDes and 1 or 0
end

function var_0_0.onOpen(arg_3_0)
	arg_3_0:_makeTipsOutofSight()
	arg_3_0:addEventCb(FightController.instance, FightEvent.UpdateWaitingArea, arg_3_0._updateWaitingArea, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.RespBeginRound, arg_3_0._beginRoundSaveCardCantUse, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_3_0._onEndRound, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.BeforePlaySkill, arg_3_0._beforePlaySkill, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_3_0._onSkillPlayFinish, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_3_0._skillFinishSaveCardCantUse, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_3_0._onBuffUpdate, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.PlayChangeCardEffectInWaitingArea, arg_3_0._playChangeCardEffect, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.CardDisappear, arg_3_0._onCardDisappear, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.FixWaitingAreaItemCount, arg_3_0._fixWaitingAreaItemCount, arg_3_0)
	arg_3_0:addEventCb(FightController.instance, FightEvent.GMHideFightView, arg_3_0._refreshTipsVisibleState, arg_3_0)
end

function var_0_0.onClose(arg_4_0)
	arg_4_0:_releaseScalseTween()
	arg_4_0:removeEventCb(FightController.instance, FightEvent.UpdateWaitingArea, arg_4_0._updateWaitingArea, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.RespBeginRound, arg_4_0._beginRoundSaveCardCantUse, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_4_0._onEndRound, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.BeforePlaySkill, arg_4_0._beforePlaySkill, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_4_0._onSkillPlayFinish, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, arg_4_0._skillFinishSaveCardCantUse, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.OnBuffUpdate, arg_4_0._onBuffUpdate, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.PlayChangeCardEffectInWaitingArea, arg_4_0._playChangeCardEffect, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.CardDisappear, arg_4_0._onCardDisappear, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.FixWaitingAreaItemCount, arg_4_0._fixWaitingAreaItemCount, arg_4_0)
	arg_4_0:removeEventCb(FightController.instance, FightEvent.GMHideFightView, arg_4_0._refreshTipsVisibleState, arg_4_0)
	arg_4_0._cardDisplayFlow:stop()
	arg_4_0._cardDisplayEndFlow:stop()
	arg_4_0._cardDissolveFlow:stop()
	arg_4_0._cardDisappearFlow:stop()
	arg_4_0._changeCardFlow:stop()
	TaskDispatcher.cancelTask(arg_4_0._delayPlayCardsChangeEffect, arg_4_0)
	TaskDispatcher.cancelTask(arg_4_0._delayPlayCardDisappear, arg_4_0)
end

function var_0_0._fixWaitingAreaItemCount(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_0._cardItemGOList and #arg_5_0._cardItemGOList

	if arg_5_1 <= var_5_0 then
		return
	end

	local var_5_1 = arg_5_0._cardItemGOList[1]
	local var_5_2 = recthelper.getAnchorX(var_5_1.transform)

	for iter_5_0 = var_5_0 + 1, arg_5_1 do
		local var_5_3 = gohelper.findChild(arg_5_0._waitingAreaGO, "cardItem" .. iter_5_0) or gohelper.cloneInPlace(arg_5_0._cardObjModel, "cardItem" .. iter_5_0)

		table.insert(arg_5_0._cardItemGOList, var_5_3)
		recthelper.setAnchorX(var_5_3.transform, var_5_2 - 192 * (iter_5_0 - 1))
	end
end

function var_0_0._updateWaitingArea(arg_6_0)
	arg_6_0:_updateView()
end

function var_0_0._onEndRound(arg_7_0)
	arg_7_0:_makeTipsOutofSight()
end

function var_0_0._beginRoundSaveCardCantUse(arg_8_0)
	arg_8_0:_saveCantUseStatus()
end

function var_0_0._skillFinishSaveCardCantUse(arg_9_0, arg_9_1, arg_9_2, arg_9_3)
	if not arg_9_1:isMySide() then
		return
	end

	arg_9_0:_saveCantUseStatus()
end

function var_0_0._saveCantUseStatus(arg_10_0)
	arg_10_0._cardCantUseDict = {}

	local var_10_0 = FightPlayCardModel.instance:getClientLeftSkillOpList()

	if #var_10_0 == 0 then
		-- block empty
	end

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		local var_10_1 = FightDataHelper.entityMgr:getById(iter_10_1.entityId)
		local var_10_2 = var_10_1 and var_10_1:isStatusDead()
		local var_10_3 = var_10_1 and var_10_1.exPoint or 0
		local var_10_4 = var_10_1 and var_10_1:getUniqueSkillPoint() or 5
		local var_10_5 = var_10_1 and FightCardDataHelper.isBigSkill(iter_10_1.skillId) and var_10_3 < var_10_4
		local var_10_6 = FightViewHandCardItemLock.canUseCardSkill(iter_10_1.entityId, iter_10_1.skillId)

		if var_10_2 or var_10_5 or not var_10_6 then
			arg_10_0._cardCantUseDict[iter_10_1] = true
		end
	end
end

function var_0_0._onCardDisappear(arg_11_0)
	arg_11_0._dissapearCount = arg_11_0._dissapearCount and arg_11_0._dissapearCount + 1 or 1

	TaskDispatcher.runDelay(arg_11_0._delayPlayCardDisappear, arg_11_0, 0.01)
end

function var_0_0._delayPlayCardDisappear(arg_12_0)
	local var_12_0 = {
		dissolveSkillItemGOs = arg_12_0:getUserDataTb_(),
		hideSkillItemGOs = arg_12_0:getUserDataTb_()
	}
	local var_12_1 = math.min(arg_12_0._dissapearCount, #FightPlayCardModel.instance:getClientLeftSkillOpList())

	if var_12_1 == 0 then
		arg_12_0:_onDisappearCallback()

		return
	end

	for iter_12_0 = 1, var_12_1 do
		local var_12_2 = FightPlayCardModel.instance:getClientLeftSkillOpList()
		local var_12_3 = #var_12_2
		local var_12_4 = var_12_2[var_12_3]
		local var_12_5 = var_12_4.entityId
		local var_12_6 = var_12_4.skillId
		local var_12_7 = FightDataHelper.entityMgr:getById(var_12_5)

		if arg_12_0._cardCantUseDict and arg_12_0._cardCantUseDict[var_12_4] then
			local var_12_8 = arg_12_0._cardItemList[var_12_3].go

			table.insert(var_12_0.dissolveSkillItemGOs, var_12_8)

			local var_12_9 = gohelper.findChild(var_12_8.transform.parent.gameObject, "lock")

			gohelper.setActive(var_12_9, false)
		else
			table.insert(var_12_0.hideSkillItemGOs, arg_12_0._cardItemList[var_12_3].go)
		end

		FightPlayCardModel.instance:removeClientSkillOnce()
	end

	arg_12_0._dissapearCount = nil

	arg_12_0._cardDisappearFlow:registerDoneListener(arg_12_0._onDisappearCallback, arg_12_0)
	arg_12_0._cardDisappearFlow:start(var_12_0)
end

function var_0_0._onDisappearCallback(arg_13_0)
	FightController.instance:dispatchEvent(FightEvent.CardDisappearFinish)
end

function var_0_0._beforePlaySkill(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = FightPlayCardModel.instance:getClientLeftSkillOpList()
	local var_14_1 = #var_14_0

	if var_14_1 == 0 then
		FightController.instance:dispatchEvent(FightEvent.ToPlaySkill, arg_14_2)

		return
	end

	arg_14_0._playingEntityId = arg_14_1.id
	arg_14_0._playingSkillId = arg_14_2
	arg_14_0._displayingEntityId = nil
	arg_14_0._displayingSkillId = nil

	arg_14_0:_updateView()

	if FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Play then
		if arg_14_2 == var_14_0[var_14_1].skillId then
			arg_14_0:_displayFlow(arg_14_0._playingEntityId, arg_14_0._playingSkillId)
			FightController.instance:dispatchEvent(FightEvent.ToPlaySkill, arg_14_2)
		elseif #var_14_0 > 0 then
			arg_14_0:_dissolveFlow(arg_14_0._onSkillPlayDissolveDone)
		else
			FightController.instance:dispatchEvent(FightEvent.ToPlaySkill, arg_14_2)
		end
	else
		FightController.instance:dispatchEvent(FightEvent.ToPlaySkill, arg_14_2)
	end
end

function var_0_0._onSkillPlayDissolveDone(arg_15_0)
	local var_15_0 = FightPlayCardModel.instance:getClientLeftSkillOpList()
	local var_15_1 = #var_15_0

	if var_15_1 > 0 then
		local var_15_2 = var_15_0[var_15_1]

		arg_15_0:_displayFlow(var_15_2.entityId, var_15_2.skillId)
	end

	FightController.instance:dispatchEvent(FightEvent.ToPlaySkill, arg_15_0._playingSkillId)
end

function var_0_0._displayFlow(arg_16_0, arg_16_1, arg_16_2)
	arg_16_0._displayingEntityId = arg_16_1
	arg_16_0._displayingSkillId = arg_16_2

	if arg_16_0._cardDisplayEndFlow.status == WorkStatus.Running then
		arg_16_0._cardDisplayEndFlow:stop()
		arg_16_0._cardDisplayFlow:reset()
	end

	if arg_16_0._cardDisplayFlow.status == WorkStatus.Running then
		arg_16_0._cardDisplayFlow:stop()
		arg_16_0._cardDisplayFlow:reset()
	end

	local var_16_0 = #FightPlayCardModel.instance:getClientLeftSkillOpList()
	local var_16_1 = arg_16_0:getUserDataTb_()

	var_16_1.skillTipsGO = arg_16_0._skillTipsGO
	var_16_1.skillItemGO = arg_16_0._cardItemList[var_16_0].go
	var_16_1.waitingAreaGO = arg_16_0._waitingAreaGO

	arg_16_0._cardDisplayFlow:start(var_16_1)
	FightPlayCardModel.instance:onPlayOneSkillId(arg_16_0._displayingEntityId, arg_16_0._displayingSkillId)
end

function var_0_0._dissolveFlow(arg_17_0, arg_17_1)
	arg_17_0._dissolveEndCallback = arg_17_1

	local var_17_0 = {
		dissolveSkillItemGOs = arg_17_0:getUserDataTb_()
	}
	local var_17_1 = false
	local var_17_2 = #FightPlayCardModel.instance:getClientLeftSkillOpList()
	local var_17_3 = #FightPlayCardModel.instance:getServerLeftSkillOpList()

	while not var_17_1 and var_17_2 > 0 and var_17_3 <= var_17_2 do
		var_17_1 = FightPlayCardModel.instance:checkClientSkillMatch(arg_17_0._playingEntityId, arg_17_0._playingSkillId)

		if not var_17_1 then
			FightPlayCardModel.instance:removeClientSkillOnce()

			local var_17_4 = arg_17_0._cardItemList[var_17_2].go

			table.insert(var_17_0.dissolveSkillItemGOs, var_17_4)

			local var_17_5 = gohelper.findChild(var_17_4.transform.parent.gameObject, "lock")

			gohelper.setActive(var_17_5, false)
		end

		var_17_2 = #FightPlayCardModel.instance:getClientLeftSkillOpList()
	end

	arg_17_0._cardDissolveFlow:registerDoneListener(arg_17_0._onDissolveFlowDone, arg_17_0)
	arg_17_0._cardDissolveFlow:start(var_17_0)
end

function var_0_0._onDissolveFlowDone(arg_18_0)
	arg_18_0:_updateView()

	local var_18_0 = arg_18_0._dissolveEndCallback

	arg_18_0._dissolveEndCallback = nil

	if var_18_0 then
		var_18_0(arg_18_0)
	end
end

function var_0_0._onSkillPlayFinish(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if not arg_19_0._displayingEntityId then
		return
	end

	if arg_19_1.id ~= arg_19_0._displayingEntityId or arg_19_2 ~= arg_19_0._displayingSkillId then
		return
	end

	local var_19_0

	for iter_19_0 = #arg_19_0._cardItemList, 1, -1 do
		local var_19_1 = arg_19_0._cardItemList[iter_19_0]

		if var_19_1.go.activeSelf then
			var_19_0 = var_19_1.go

			break
		end
	end

	arg_19_0._displayingEntityId = nil
	arg_19_0._displayingSkillId = nil

	local var_19_2 = arg_19_0:getUserDataTb_()

	var_19_2.skillTipsGO = arg_19_0._skillTipsGO
	var_19_2.skillItemGO = var_19_0
	var_19_2.waitingAreaGO = arg_19_0._waitingAreaGO

	arg_19_0._cardDisplayEndFlow:start(var_19_2)
end

function var_0_0._onBuffUpdate(arg_20_0, arg_20_1, arg_20_2, arg_20_3)
	local var_20_0 = FightDataHelper.entityMgr:getById(arg_20_1)

	if not var_20_0 or var_20_0.side ~= FightEnum.EntitySide.MySide then
		return
	end

	local var_20_1 = FightPlayCardModel.instance:getClientLeftSkillOpList()

	for iter_20_0 = 1, #var_20_1 do
		local var_20_2 = arg_20_0._cardItemList[iter_20_0]

		if var_20_2 then
			arg_20_0:_setCardLockEffect(var_20_2, var_20_1[iter_20_0], iter_20_0)
		end
	end
end

function var_0_0._makeTipsOutofSight(arg_21_0)
	local var_21_0 = arg_21_0._skillTipsGO.transform

	recthelper.setAnchorX(var_21_0, 960 + recthelper.getWidth(var_21_0))
end

function var_0_0._updateView(arg_22_0)
	local var_22_0 = FightPlayCardModel.instance:getClientLeftSkillOpList()
	local var_22_1 = #var_22_0

	gohelper.setActive(arg_22_0._waitingAreaGO, var_22_1 > 0)

	for iter_22_0 = 1, var_22_1 do
		local var_22_2 = arg_22_0._cardItemGOList[iter_22_0]
		local var_22_3 = var_22_0[iter_22_0].entityId
		local var_22_4 = var_22_0[iter_22_0].skillId
		local var_22_5 = arg_22_0._cardItemList[iter_22_0]

		if not var_22_5 then
			local var_22_6 = arg_22_0.viewContainer:getSetting().otherRes[1]
			local var_22_7 = arg_22_0:getResInst(var_22_6, var_22_2, "card")

			gohelper.setAsFirstSibling(var_22_7)

			var_22_5 = MonoHelper.addNoUpdateLuaComOnceToGo(var_22_7, FightViewCardItem, FightEnum.CardShowType.PlayCard)

			table.insert(arg_22_0._cardItemList, var_22_5)
		end

		transformhelper.setLocalScale(var_22_5.tr, 1, 1, 1)
		recthelper.setAnchor(var_22_5.tr, 0, 0)

		gohelper.onceAddComponent(var_22_5.go, typeof(UnityEngine.CanvasGroup)).alpha = 1

		gohelper.setActive(var_22_5.go, true)
		var_22_5:updateItem(var_22_3, var_22_4)

		var_22_5.op = var_22_0[iter_22_0]

		arg_22_0:_setCardLockEffect(var_22_5, var_22_0[iter_22_0], iter_22_0)
	end

	for iter_22_1 = var_22_1 + 1, #arg_22_0._cardItemList do
		local var_22_8 = arg_22_0._cardItemList[iter_22_1]
		local var_22_9 = gohelper.findChild(var_22_8.tr.parent.gameObject, "lock")

		gohelper.setActive(var_22_9, false)
		gohelper.setActive(var_22_8.go, false)
	end

	local var_22_10 = var_22_0[var_22_1] and var_22_0[var_22_1].skillId
	local var_22_11 = var_22_0[var_22_1] and var_22_0[var_22_1].entityId
	local var_22_12 = var_22_10 and lua_skill.configDict[var_22_10]
	local var_22_13 = FightConfig.instance:getEntitySkillDesc(var_22_11, var_22_12, var_22_10)

	arg_22_0._txtCardTitle.text = var_22_12 and var_22_12.name or ""
	arg_22_0._txtCardDesc.text = var_22_12 and HeroSkillModel.instance:skillDesToSpot(var_22_13) or ""

	arg_22_0._txtCardDesc:ForceMeshUpdate(true, true)

	local var_22_14 = arg_22_0._txtCardDesc:GetRenderedValues().y
	local var_22_15 = var_22_14 + 83

	recthelper.setHeight(arg_22_0._rectTrCardDesc, var_22_14)
	recthelper.setHeight(arg_22_0._skillTipsGO.transform, var_22_15)
	arg_22_0:_releaseScalseTween()

	local var_22_16 = var_22_1 > 7 and 1 - (var_22_1 - 7) * 0.12 or 1

	if var_22_16 < 0 then
		var_22_16 = 0.5
	end

	local var_22_17 = 1 / var_22_16

	transformhelper.setLocalScale(arg_22_0._skillTipsGO.transform, var_22_17, var_22_17, var_22_17)

	arg_22_0._tweenScale = ZProj.TweenHelper.DOScale(arg_22_0._waitingAreaTran, var_22_16, var_22_16, var_22_16, 0.1)
end

function var_0_0._releaseScalseTween(arg_23_0)
	if arg_23_0._tweenScale then
		ZProj.TweenHelper.KillById(arg_23_0._tweenScale)

		arg_23_0._tweenScale = nil
	end
end

function var_0_0._setCardLockEffect(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = Time.time
	local var_24_1 = arg_24_0._unlockStartTime and arg_24_0._unlockStartTime[arg_24_2.skillId]

	if var_24_1 and var_24_0 - var_24_1 < 1 then
		return
	end

	local var_24_2 = gohelper.findChild(arg_24_1.tr.parent.gameObject, "lock")

	FightViewHandCardItemLock.setCardLock(arg_24_2.entityId, arg_24_2.skillId, var_24_2, false)

	local var_24_3 = FightViewHandCardItemLock.canUseCardSkill(arg_24_2.entityId, arg_24_2.skillId)
	local var_24_4 = FightPlayCardModel.instance:getServerLeftSkillOpList()[arg_24_3]

	if not var_24_3 and var_24_4 and var_24_4.entityId == arg_24_2.entityId and var_24_4.skillId == arg_24_2.skillId then
		arg_24_0._preRemoveState = arg_24_0._preRemoveState or {}
		arg_24_0._preRemoveState[arg_24_2] = true

		FightViewHandCardItemLock.setCardPreRemove(arg_24_2.entityId, arg_24_2.skillId, var_24_2, false)
	end

	if var_24_3 and arg_24_0._preRemoveState and arg_24_0._preRemoveState[arg_24_2] then
		gohelper.setActive(var_24_2, true)
		FightViewHandCardItemLock.setCardUnLock(arg_24_2.entityId, arg_24_2.skillId, var_24_2)

		arg_24_0._preRemoveState[arg_24_2] = nil
		arg_24_0._unlockStartTime = arg_24_0._unlockStartTime or {}
		arg_24_0._unlockStartTime[arg_24_2] = var_24_0
	end
end

function var_0_0._playChangeCardEffect(arg_25_0, arg_25_1)
	arg_25_0._changeInfos = arg_25_0._changeInfos or {}

	tabletool.addValues(arg_25_0._changeInfos, arg_25_1)
	TaskDispatcher.cancelTask(arg_25_0._delayPlayCardsChangeEffect, arg_25_0)
	TaskDispatcher.runDelay(arg_25_0._delayPlayCardsChangeEffect, arg_25_0, 0.03)
end

function var_0_0._delayPlayCardsChangeEffect(arg_26_0)
	local var_26_0 = arg_26_0:getUserDataTb_()

	var_26_0.changeInfos = arg_26_0._changeInfos
	var_26_0.cardItemList = arg_26_0._cardItemList

	arg_26_0._changeCardFlow:registerDoneListener(arg_26_0._onChangeCardDone, arg_26_0)
	arg_26_0._changeCardFlow:start(var_26_0)

	arg_26_0._changeInfos = nil
end

function var_0_0._onChangeCardDone(arg_27_0)
	arg_27_0._changeCardFlow:unregisterDoneListener(arg_27_0._onChangeCardDone, arg_27_0)
	arg_27_0:_updateView()
	FightController.instance:dispatchEvent(FightEvent.OnChangeCardEffectDone)
end

return var_0_0
