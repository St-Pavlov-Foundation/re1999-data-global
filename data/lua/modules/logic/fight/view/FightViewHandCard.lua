module("modules.logic.fight.view.FightViewHandCard", package.seeall)

local var_0_0 = class("FightViewHandCard", FightBaseView)
local var_0_1 = 256
local var_0_2 = 185

var_0_0.blockOperate = false

function var_0_0.onInitView(arg_1_0)
	arg_1_0.skinDownEffectRoot = gohelper.findChild(arg_1_0.viewGO, "root/hand_card_skin_down")
	arg_1_0.skinUpEffectRoot = gohelper.findChild(arg_1_0.viewGO, "root/hand_card_skin_up")
	arg_1_0._handCardContainer = gohelper.findChild(arg_1_0.viewGO, "root/handcards")
	arg_1_0._handCardGO = gohelper.findChild(arg_1_0.viewGO, "root/handcards/handcards")
	arg_1_0._handCardTransform = arg_1_0._handCardContainer.transform
	var_0_0.handCardSiblingIndex = arg_1_0._handCardTransform:GetSiblingIndex()
	arg_1_0._playCardTransform = gohelper.findChild(arg_1_0.viewGO, "root/playcards").transform
	var_0_0.playCardSiblingIndex = arg_1_0._playCardTransform:GetSiblingIndex()
	arg_1_0._abandon = gohelper.findChild(arg_1_0.viewGO, "root/abandon")
	arg_1_0._abandonLine = gohelper.findChild(arg_1_0.viewGO, "root/abandon/rightBottom/line").transform

	gohelper.setActive(arg_1_0._abandon, false)

	arg_1_0._abandonTran = arg_1_0._abandon.transform
	arg_1_0._abandonCardRoot = gohelper.findChild(arg_1_0.viewGO, "root/abandon/cardRoot")
	arg_1_0._abandonCardRootTran = arg_1_0._abandonCardRoot.transform
	arg_1_0._precisionFrame = gohelper.findChild(arg_1_0.viewGO, "root/handcards/areaFrameRoot")

	gohelper.setActive(arg_1_0._precisionFrame, false)

	arg_1_0._handCardGOCanvasGroup = gohelper.onceAddComponent(arg_1_0._handCardGO, typeof(UnityEngine.CanvasGroup))
	arg_1_0._handCardTr = arg_1_0._handCardGO.transform
	arg_1_0._handCardItemPrefab = gohelper.findChild(arg_1_0.viewGO, "root/handcards/handcards/cardItem")

	gohelper.setActive(arg_1_0._handCardItemPrefab, false)

	arg_1_0._handCardItemList = {}

	arg_1_0:_setBlockOperate(false)

	arg_1_0.areaSize = 0
	arg_1_0.LyNeedCheckFlowList = {}

	arg_1_0:initRedOrBlueArea()
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnHandCardFlowCreate, arg_1_0._onHandCardFlowCreate, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnHandCardFlowStart, arg_1_0._onHandCardFlowStart, arg_1_0)
	arg_1_0:addEventCb(FightController.instance, FightEvent.OnHandCardFlowEnd, arg_1_0._onHandCardFlowEnd, arg_1_0)

	var_0_0.handCardContainer = arg_1_0._handCardContainer
	var_0_0.HalfWidth = recthelper.getWidth(arg_1_0._handCardTr) / 2
	var_0_0.HalfItemWidth = recthelper.getWidth(arg_1_0._handCardItemPrefab.transform) / 2
	var_0_0.HandCardWidth = var_0_2
	var_0_0.HandCardHeight = var_0_1
	arg_1_0._autoPlayCardFlow = nil
	arg_1_0._correctHandCardScale = FightViewHandCardSequenceFlow.New()

	arg_1_0._correctHandCardScale:addWork(FigthCardDistributeCorrectScale.New())

	arg_1_0._cardDistributeFlow = FightViewHandCardParallelFlow.New()

	arg_1_0._cardDistributeFlow:addWork(FigthCardDistributeCorrectScale.New())
	arg_1_0._cardDistributeFlow:addWork(FigthCardDistributeEffect.New())
	arg_1_0._cardDistributeFlow:addWork(FightCardCombineEndEffect.New())

	arg_1_0._cardPlayFlow = FightViewHandCardSequenceFlow.New()

	arg_1_0._cardPlayFlow:addWork(FightCardPlayEffect.New())
	arg_1_0._cardPlayFlow:addWork(FightCardDissolveCardsAfterPlay.New())
	arg_1_0._cardPlayFlow:addWork(FightCardDiscardAfterPlay.New())
	arg_1_0._cardPlayFlow:addWork(FightCardCheckCombineCards.New())

	arg_1_0._cardCombineFlow = FightViewHandCardSequenceFlow.New()

	arg_1_0._cardCombineFlow:addWork(FightCardCombineEffect.New())

	arg_1_0._cardLongPressFlow = FightViewHandCardSequenceFlow.New()

	arg_1_0._cardLongPressFlow:addWork(FightCardLongPressEffect.New())

	arg_1_0._cardLongPressEndFlow = FightViewHandCardSequenceFlow.New()

	arg_1_0._cardLongPressEndFlow:addWork(FightCardLongPressEndEffect.New())

	arg_1_0._cardDragFlow = FightViewHandCardSequenceFlow.New()

	arg_1_0._cardDragFlow:addWork(FightCardDragEffect.New())

	arg_1_0._cardDragEndFlow = FightViewHandCardSequenceFlow.New()

	arg_1_0._cardDragEndFlow:addWork(FightCardDragEndEffect.New())

	arg_1_0._cardEndFlow = FightViewHandCardSequenceFlow.New()

	arg_1_0._cardEndFlow:addWork(FightGuideCardEnd.New())
	arg_1_0._cardEndFlow:addWork(FightCardEndEffect.New())

	arg_1_0._redealCardFlow = FightViewHandCardSequenceFlow.New()

	arg_1_0._redealCardFlow:addWork(FightCardRedealEffect.New())

	arg_1_0._universalAppearFlow = FightViewHandCardSequenceFlow.New()

	arg_1_0._universalAppearFlow:addWork(FightCardUniversalAppearEffect.New())

	arg_1_0._magicEffectCardFlow = FightViewHandCardSequenceFlow.New()

	arg_1_0._magicEffectCardFlow:addWork(FightCardChangeMagicEffect.New())
end

function var_0_0.initRedOrBlueArea(arg_2_0)
	arg_2_0.goLYAreaRoot = gohelper.findChild(arg_2_0.viewGO, "root/handcards/LiangyueframeRoot")
	arg_2_0.animatorLyRoot = arg_2_0.goLYAreaRoot:GetComponent(gohelper.Type_Animator)
	arg_2_0.goRedArea = gohelper.findChild(arg_2_0.goLYAreaRoot, "redarea")
	arg_2_0.goGreenArea = gohelper.findChild(arg_2_0.goLYAreaRoot, "greenarea")
	arg_2_0.rectTrRedArea = arg_2_0.goRedArea:GetComponent(gohelper.Type_RectTransform)
	arg_2_0.rectTrGreenArea = arg_2_0.goGreenArea:GetComponent(gohelper.Type_RectTransform)
end

function var_0_0.onDestroyView(arg_3_0)
	var_0_0.handCardContainer = nil
	arg_3_0.LyNeedCheckFlowList = nil
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:_updateNow()
	arg_4_0:addEventCb(FightController.instance, FightEvent.DistributeCards, arg_4_0._startDistributeCards, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.AutoPlayCard, arg_4_0._toAutoPlayCard, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.PushCardInfo, arg_4_0._updateNow, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.PlayHandCard, arg_4_0._playHandCard, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.PlayCombineCards, arg_4_0._onPlayCombineCards, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.UpdateHandCards, arg_4_0._updateHandCards, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.ResetCard, arg_4_0._resetCard, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.DragHandCardBegin, arg_4_0._onDragHandCardBegin, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.DragHandCardEnd, arg_4_0._onDragHandCardEnd, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.LongPressHandCard, arg_4_0._longPressHandCard, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.LongPressHandCardEnd, arg_4_0._longPressHandCardEnd, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.PlayRedealCardEffect, arg_4_0._playRedealCardEffect, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.UniversalAppear, arg_4_0._playUniversalAppear, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.CheckCardOpEnd, arg_4_0._checkCardOpEnd, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.DetectCardOpEndAfterOperationEffectDone, arg_4_0._onDetectCardOpEndAfterOperationEffectDone, arg_4_0)
	arg_4_0:addEventCb(GameStateMgr.instance, GameStateEvent.onApplicationPause, arg_4_0._onApplicationPause, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.SetCardMagicEffectChange, arg_4_0._setCardMagicEffectChange, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.PlayCardMagicEffectChange, arg_4_0._playCardMagicEffectChange, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.SetBlockCardOperate, arg_4_0._setBlockOperate, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.SpCardAdd, arg_4_0._onSpCardAdd, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.AddHandCard, arg_4_0._onAddHandCard, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.TempCardRemove, arg_4_0._onTempCardRemove, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.ChangeToTempCard, arg_4_0._onChangeToTempCard, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.CorrectHandCardScale, arg_4_0._onCorrectHandCardScale, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.RemoveEntityCards, arg_4_0._onRemoveEntityCards, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.CardRemove, arg_4_0._onCardRemove, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.CardRemove2, arg_4_0._onCardRemove2, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.RefreshHandCard, arg_4_0._updateNow, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.CardsCompose, arg_4_0._onCardsCompose, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.CardsComposeTimeOut, arg_4_0._onCardsComposeTimeOut, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.CardLevelChange, arg_4_0._onCardLevelChange, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.AfterForceUpdatePerformanceData, arg_4_0._onAfterForceUpdatePerformanceData, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_4_0._onRoundSequenceFinish, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, arg_4_0._onClothSkillRoundSequenceFinish, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.MasterAddHandCard, arg_4_0._onMasterAddHandCard, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.MasterCardRemove, arg_4_0._onMasterCardRemove, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.CardAConvertCardB, arg_4_0._onCardAConvertCardB, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_4_0._updateNow, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.ForceEndAutoCardFlow, arg_4_0._onForceEndAutoCardFlow, arg_4_0)
	arg_4_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectCard, arg_4_0.OnKeyPlayCard, arg_4_0)
	arg_4_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleMoveCardEnd, arg_4_0.onControlRelease, arg_4_0)
	arg_4_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectLeft, arg_4_0.selectLeftCard, arg_4_0)
	arg_4_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectRight, arg_4_0.selectRightCard, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.EnterStage, arg_4_0._onEnterStage, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.ExitStage, arg_4_0._onExitStage, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.StageChanged, arg_4_0._onStageChanged, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.EnterOperateState, arg_4_0._onEnterOperateState, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.ExitOperateState, arg_4_0._onExitOperateState, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.CardEffectChange, arg_4_0._onCardEffectChange, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.RefreshHandCardPrecisionEffect, arg_4_0._onRefreshHandCardPrecisionEffect, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.LY_CardAreaSizeChange, arg_4_0.onLY_CardAreaSizeChange, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.RefreshCardHeatShow, arg_4_0._onRefreshCardHeatShow, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.ASFD_OnChangeCardEnergy, arg_4_0.onChangeCardEnergy, arg_4_0)
	arg_4_0:_setBlockOperate(false)
	arg_4_0:_refreshPrecisionShow()
end

function var_0_0.onClose(arg_5_0)
	FightCardModel.instance:setLongPressIndex(-1)
	TaskDispatcher.cancelTask(arg_5_0._delayCancelBlock, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._combineCardsAfterAddHandCard, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._correctActiveCardObjPos, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._combineAfterCardLevelChange, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._combineAfterCardRemove, arg_5_0)
	arg_5_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectCard, arg_5_0.OnKeyPlayCard, arg_5_0)
	arg_5_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleMoveCardEnd, arg_5_0.onControlRelease, arg_5_0)
	arg_5_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectLeft, arg_5_0.selectLeftCard, arg_5_0)
	arg_5_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectRight, arg_5_0.selectRightCard, arg_5_0)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._handCardItemList) do
		iter_5_1:releaseSelf()
	end

	if arg_5_0._autoPlayCardFlow then
		arg_5_0._autoPlayCardFlow:stop()

		arg_5_0._autoPlayCardFlow = nil
	end

	arg_5_0._correctHandCardScale:stop()
	arg_5_0._cardDistributeFlow:stop()
	arg_5_0._cardPlayFlow:stop()
	arg_5_0._cardCombineFlow:stop()
	arg_5_0._cardLongPressFlow:stop()
	arg_5_0._cardLongPressEndFlow:stop()
	arg_5_0._cardDragFlow:stop()
	arg_5_0._cardDragEndFlow:stop()
	arg_5_0._cardEndFlow:stop()
	arg_5_0._redealCardFlow:stop()
	arg_5_0._universalAppearFlow:stop()
	arg_5_0._magicEffectCardFlow:stop()
end

function var_0_0._onHandCardFlowCreate(arg_6_0, arg_6_1)
	table.insert(arg_6_0.LyNeedCheckFlowList, arg_6_1)
end

function var_0_0._onHandCardFlowEnd(arg_7_0, arg_7_1)
	if arg_7_1 == arg_7_0._cardLongPressEndFlow or arg_7_1 == arg_7_0._cardDragEndFlow then
		arg_7_0.longPressing = false
	end

	return arg_7_0:refreshLYAreaActive()
end

function var_0_0._onHandCardFlowStart(arg_8_0, arg_8_1)
	if arg_8_1 == arg_8_0._cardLongPressFlow then
		arg_8_0.longPressing = true
	end

	return arg_8_0:refreshLYAreaActive()
end

function var_0_0._onStageChanged(arg_9_0, arg_9_1)
	if arg_9_1 == FightStageMgr.StageType.Normal then
		for iter_9_0, iter_9_1 in ipairs(arg_9_0._handCardItemList) do
			iter_9_1:setASFDActive(true)
		end
	end

	return arg_9_0:refreshLYAreaActive()
end

function var_0_0.refreshLYAreaActive(arg_10_0)
	if var_0_0.blockOperate then
		return arg_10_0:setActiveLyRoot(false)
	end

	if arg_10_0.longPressing then
		return arg_10_0:setActiveLyRoot(false)
	end

	if not (FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Normal) then
		return arg_10_0:setActiveLyRoot(false)
	end

	if arg_10_0.LyNeedCheckFlowList then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0.LyNeedCheckFlowList) do
			if iter_10_1.status == WorkStatus.Running then
				return arg_10_0:setActiveLyRoot(false)
			end
		end
	end

	arg_10_0:refreshLyAreaPos()
	arg_10_0:setActiveLyRoot(true)
end

function var_0_0.setActiveLyRoot(arg_11_0, arg_11_1)
	if FightDataHelper.LYDataMgr.LYCardAreaSize < 1 then
		gohelper.setActive(arg_11_0.goLYAreaRoot, false)

		return
	end

	gohelper.setActive(arg_11_0.goLYAreaRoot, true)

	if arg_11_1 then
		if not arg_11_0.goLYAreaRoot.activeInHierarchy then
			gohelper.setActive(arg_11_0.goLYAreaRoot, true)
			arg_11_0.animatorLyRoot:Play("open", 0, 0)
		end
	else
		gohelper.setActive(arg_11_0.goLYAreaRoot, false)
	end
end

function var_0_0.onLY_CardAreaSizeChange(arg_12_0)
	arg_12_0:refreshLyCardTag()
	arg_12_0:refreshLYAreaActive()
end

function var_0_0.refreshLyCardTag(arg_13_0)
	local var_13_0 = FightDataHelper.handCardMgr.handCard
	local var_13_1 = FightDataHelper.LYDataMgr.LYCardAreaSize
	local var_13_2 = var_13_0 and #var_13_0 or 0

	for iter_13_0 = 1, var_13_2 do
		local var_13_3 = arg_13_0._handCardItemList[iter_13_0]

		if var_13_3 then
			var_13_3:resetRedAndBlue()

			if var_13_1 > var_13_2 - iter_13_0 and iter_13_0 <= var_13_1 then
				var_13_3:setActiveBoth(true)
			else
				var_13_3:setActiveBlue(var_13_1 > var_13_2 - iter_13_0)
				var_13_3:setActiveRed(iter_13_0 <= var_13_1)
			end
		end
	end
end

function var_0_0.refreshLyAreaPos(arg_14_0)
	local var_14_0 = FightDataHelper.LYDataMgr.LYCardAreaSize
	local var_14_1 = FightDataHelper.handCardMgr.handCard
	local var_14_2 = var_14_1 and #var_14_1 or 0
	local var_14_3 = math.min(var_14_0, var_14_2)
	local var_14_4 = FightDataHelper.handCardMgr.handCard
	local var_14_5 = var_14_4 and #var_14_4 or 0
	local var_14_6 = var_14_3 and var_14_3 > 0 and var_14_5 > 0

	gohelper.setActive(arg_14_0.goRedArea, var_14_6)
	gohelper.setActive(arg_14_0.goGreenArea, var_14_6)

	if var_14_6 then
		local var_14_7 = var_0_0.calcTotalWidth(var_14_3, 1) + FightEnum.LYCardAreaWidthOffset

		recthelper.setWidth(arg_14_0.rectTrRedArea, var_14_7)
		recthelper.setWidth(arg_14_0.rectTrGreenArea, var_14_7)

		local var_14_8 = var_0_0.calcTotalWidth(var_14_5 - var_14_3, 1)

		recthelper.setAnchorX(arg_14_0.rectTrGreenArea, -var_14_8)
	end
end

function var_0_0._onApplicationPause(arg_15_0, arg_15_1)
	if arg_15_1 and FightModel.instance:getCurStage() == FightEnum.Stage.Card then
		if arg_15_0._cardDragFlow and arg_15_0._cardDragFlow.status == WorkStatus.Running then
			arg_15_0._cardDragFlow:stop()
		end

		arg_15_0:_updateNow()
	end
end

function var_0_0.getHandCardItem(arg_16_0, arg_16_1)
	return arg_16_0._handCardItemList[arg_16_1]
end

function var_0_0.isPlayCardFlow(arg_17_0)
	return arg_17_0._cardPlayFlow.status == WorkStatus.Running
end

function var_0_0.isMoveCardFlow(arg_18_0)
	return arg_18_0._cardDragFlow.status == WorkStatus.Running or arg_18_0._cardDragEndFlow.status == WorkStatus.Running
end

function var_0_0.isCombineCardFlow(arg_19_0)
	return arg_19_0._cardCombineFlow.status == WorkStatus.Running
end

function var_0_0._checkCardOpEnd(arg_20_0)
	if FightDataHelper.operationDataMgr:isCardOpEnd() and #FightDataHelper.operationDataMgr:getOpList() > 0 then
		FightController.instance:dispatchEvent(FightEvent.CardOpEnd)

		if arg_20_0._cardEndFlow.status ~= WorkStatus.Running then
			if FightModel.instance:isSeason2() then
				if arg_20_0._autoPlayCardFlow then
					arg_20_0._autoPlayCardFlow:stop()
				end

				arg_20_0:_onCardEndFlowDone()
				FightViewPartVisible.set(nil, nil, nil, nil, true)
				FightController.instance:dispatchEvent(FightEvent.HidePlayCardAllCard)

				return
			end

			arg_20_0:_setBlockOperate(true)
			arg_20_0._cardEndFlow:registerDoneListener(arg_20_0._onCardEndFlowDone, arg_20_0)

			local var_20_0 = arg_20_0:getUserDataTb_()

			var_20_0.handCardContainer = arg_20_0._handCardGO
			var_20_0.playCardContainer = gohelper.findChild(arg_20_0.viewGO, "root/playcards")
			var_20_0.waitCardContainer = gohelper.findChild(arg_20_0.viewGO, "root/waitingArea/inner")
			var_20_0.handCardItemList = arg_20_0._handCardItemList

			gohelper.setActive(arg_20_0._precisionFrame, false)
			arg_20_0._cardEndFlow:start(var_20_0)
		end
	end
end

function var_0_0._onDetectCardOpEndAfterOperationEffectDone(arg_21_0, arg_21_1)
	if arg_21_1 and FightModel.instance:isSeason2() and arg_21_1:isMoveUniversal() then
		arg_21_0:_onCardEndFlowDone()

		return
	end

	arg_21_0:_checkCardOpEnd()
end

function var_0_0._onCardEndFlowDone(arg_22_0)
	local var_22_0 = FightDataHelper.handCardMgr.handCard

	FightDataUtil.coverData(var_22_0, FightLocalDataMgr.instance.handCardMgr:getHandCard())
	arg_22_0:_setBlockOperate(false)
	arg_22_0._cardEndFlow:unregisterDoneListener(arg_22_0._onCardEndFlowDone, arg_22_0)

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	FightRpc.instance:sendBeginRoundRequest(FightDataHelper.operationDataMgr:getOpList())

	if FightModel.instance:getVersion() >= 1 then
		FightController.instance:dispatchEvent(FightEvent.ShowSimulateClientUsedCard)

		return
	end

	FightPlayCardModel.instance:updateClientOps()
	FightController.instance:dispatchEvent(FightEvent.UpdateWaitingArea)
end

function var_0_0._onEnterStage(arg_23_0, arg_23_1)
	if arg_23_1 == FightStageMgr.StageType.Play then
		gohelper.setActive(arg_23_0._precisionFrame, false)
		arg_23_0:_setBlockOperate(false)
	end
end

function var_0_0._onCardEffectChange(arg_24_0, arg_24_1)
	if arg_24_1 == 1 then
		arg_24_0:_refreshPrecisionShow()
	end
end

function var_0_0._onExitStage(arg_25_0, arg_25_1)
	arg_25_0:_refreshPrecisionShow()
end

function var_0_0.refreshPreDeleteCard(arg_26_0, arg_26_1)
	arg_26_0.needPreDeleteCardIndexDict = arg_26_0.needPreDeleteCardIndexDict or {}

	tabletool.clear(arg_26_0.needPreDeleteCardIndexDict)

	if arg_26_1 then
		for iter_26_0, iter_26_1 in ipairs(arg_26_1) do
			local var_26_0 = iter_26_1.skillId
			local var_26_1 = var_26_0 and lua_fight_card_pre_delete.configDict[var_26_0]

			if var_26_1 then
				local var_26_2 = var_26_1.left

				if var_26_2 > 0 then
					for iter_26_2 = 1, var_26_2 do
						arg_26_0.needPreDeleteCardIndexDict[iter_26_0 + iter_26_2] = true
					end
				end

				local var_26_3 = var_26_1.right

				if var_26_3 > 0 then
					for iter_26_3 = 1, var_26_3 do
						arg_26_0.needPreDeleteCardIndexDict[iter_26_0 - iter_26_3] = true
					end
				end
			end
		end
	end

	for iter_26_4, iter_26_5 in ipairs(arg_26_0._handCardItemList) do
		iter_26_5:refreshPreDeleteImage(arg_26_0.needPreDeleteCardIndexDict and arg_26_0.needPreDeleteCardIndexDict[iter_26_4])
	end
end

function var_0_0._refreshPrecisionShow(arg_27_0)
	arg_27_0._precisionState = false

	gohelper.setActive(arg_27_0._precisionFrame, false)

	if FightDataHelper.stageMgr:isNormalStage() then
		local var_27_0 = {}

		FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.MySide, var_27_0)
		FightDataHelper.entityMgr:getSubList(FightEnum.EntitySide.MySide, var_27_0)

		for iter_27_0, iter_27_1 in ipairs(var_27_0) do
			if iter_27_1:hasBuffFeature(FightEnum.BuffFeature.PrecisionRegion) then
				gohelper.setActive(arg_27_0._precisionFrame, true)

				arg_27_0._precisionState = true

				arg_27_0:_detectPlayPrecisionEffect()

				break
			end
		end
	end
end

function var_0_0._detectPlayPrecisionEffect(arg_28_0)
	if arg_28_0._handCardItemList then
		for iter_28_0, iter_28_1 in ipairs(arg_28_0._handCardItemList) do
			local var_28_0 = iter_28_1:getCardItem()

			if iter_28_0 == 1 then
				if FightCardDataHelper.isPrecision(var_28_0._cardInfoMO) and arg_28_0._precisionState then
					var_28_0:showPrecisionEffect()
				else
					var_28_0:hidePrecisionEffect()
				end
			else
				var_28_0:hidePrecisionEffect()
			end
		end
	end
end

function var_0_0._onRefreshHandCardPrecisionEffect(arg_29_0)
	arg_29_0:_detectPlayPrecisionEffect()
end

function var_0_0._startDistributeCards(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	arg_30_0.distributeCards = FightDataUtil.copyData(arg_30_2) or {}

	FightDataUtil.coverData(arg_30_1, FightDataHelper.handCardMgr.handCard)
	arg_30_0:_updateHandCards()

	local var_30_0 = FightCardDataHelper.getCardSkin()

	if arg_30_3 then
		if var_30_0 == 672801 then
			local var_30_1 = arg_30_0:com_registWork(FightWorkEnterDistributeCards672801, arg_30_0, arg_30_0.distributeCards)

			var_30_1:registFinishCallback(arg_30_0.onEnterDistributeCardsSkinDone, arg_30_0)
			var_30_1:start()
		else
			arg_30_0:_nextDistributeCards()
		end
	else
		arg_30_0:_nextDistributeCards()
	end
end

function var_0_0.onEnterDistributeCardsSkinDone(arg_31_0)
	FightController.instance:dispatchEvent(FightEvent.OnDistributeCards)
end

function var_0_0._nextDistributeCards(arg_32_0, arg_32_1)
	arg_32_0._correctHandCardScale:stop()
	arg_32_0._cardDistributeFlow:stop()
	arg_32_0._cardCombineFlow:stop()
	arg_32_0._redealCardFlow:stop()
	arg_32_0._magicEffectCardFlow:stop()

	local var_32_0 = arg_32_0.distributeCards and #arg_32_0.distributeCards

	if var_32_0 > 0 then
		local var_32_1 = FightDataHelper.handCardMgr.handCard
		local var_32_2 = #var_32_1
		local var_32_3 = {}

		for iter_32_0 = 1, var_32_0 do
			local var_32_4 = table.remove(arg_32_0.distributeCards, 1)

			table.insert(var_32_3, var_32_4)
			table.insert(var_32_1, var_32_4)

			local var_32_5 = var_32_1[#var_32_1 - 1]

			if FightCardDataHelper.canCombineCardForPerformance(var_32_4, var_32_5) then
				break
			end
		end

		local var_32_6 = FightCardCombineEffect.getCardPosXList(arg_32_0._handCardItemList)

		arg_32_0:_updateHandCards(var_32_1)

		local var_32_7 = arg_32_0:getUserDataTb_()

		var_32_7.cards = var_32_1
		var_32_7.handCardItemList = arg_32_0._handCardItemList
		var_32_7.oldPosXList = var_32_6
		var_32_7.preCombineIndex = arg_32_1
		var_32_7.preCardCount = var_32_2
		var_32_7.newCardCount = #var_32_3
		var_32_7.playCardContainer = gohelper.findChild(arg_32_0.viewGO, "root/playcards")
		var_32_7.isEnd = var_32_0 == 1
		var_32_7.handCardContainer = arg_32_0._handCardContainer
		var_32_7.oldScale = 0

		arg_32_0:_setBlockOperate(true)
		arg_32_0._cardDistributeFlow:registerDoneListener(arg_32_0._onDistributeCards, arg_32_0)
		arg_32_0._cardDistributeFlow:start(var_32_7)
	else
		arg_32_0:_onDistributeCards()
	end
end

function var_0_0._onDistributeCards(arg_33_0)
	arg_33_0._cardDistributeFlow:unregisterDoneListener(arg_33_0._onDistributeCards, arg_33_0)

	local var_33_0 = arg_33_0._cardDistributeFlow.context and arg_33_0._cardDistributeFlow.context.cards or FightDataHelper.handCardMgr.handCard

	arg_33_0:_combineCards(var_33_0)
end

function var_0_0._toAutoPlayCard(arg_34_0)
	local var_34_0 = FightModel.instance.autoPlayCardList

	if #var_34_0 > 0 then
		if arg_34_0._autoPlayCardFlow then
			arg_34_0._autoPlayCardFlow:stop()

			arg_34_0._autoPlayCardFlow = nil
		end

		arg_34_0._autoPlayCardFlow = FlowSequence.New()

		arg_34_0._autoPlayCardFlow:addWork(FightAutoBindContractWork.New())
		arg_34_0._autoPlayCardFlow:addWork(FightAutoDetectUpgradeWork.New())

		if arg_34_0._cardPlayFlow and arg_34_0._cardPlayFlow.status == WorkStatus.Running then
			arg_34_0._autoPlayCardFlow:addWork(FightAutoPlayCardWork.New())
		end

		local var_34_1 = 0

		for iter_34_0, iter_34_1 in ipairs(var_34_0) do
			if iter_34_1:isAssistBossPlayCard() then
				arg_34_0._autoPlayCardFlow:addWork(WorkWaitSeconds.New(0.3))
				arg_34_0._autoPlayCardFlow:addWork(FightAutoPlayAssistBossCardWork.New(iter_34_1))
			elseif iter_34_1:isSeason2ChangeHero() then
				var_34_1 = var_34_1 + 1

				if var_34_1 == 3 then
					arg_34_0._autoPlayCardFlow:addWork(WorkWaitSeconds.New(0.1))
					arg_34_0._autoPlayCardFlow:addWork(FightWorkAutoSeason2ChangeHero.New(var_34_0, iter_34_0))
				end
			elseif iter_34_1:isPlayerFinisherSkill() then
				arg_34_0._autoPlayCardFlow:addWork(WorkWaitSeconds.New(0.1))
				arg_34_0._autoPlayCardFlow:addWork(FightWorkAutoPlayerFinisherSkill.New(iter_34_1))
			elseif iter_34_1:isBloodPoolSkill() then
				logError("自动打牌  血池牌 todo")
			else
				arg_34_0._autoPlayCardFlow:addWork(WorkWaitSeconds.New(0.01))
				arg_34_0._autoPlayCardFlow:addWork(FightAutoPlayCardWork.New(iter_34_1))
			end
		end

		arg_34_0._autoPlayCardFlow:addWork(FightAutoDetectForceEndWork.New())
		arg_34_0._autoPlayCardFlow:registerDoneListener(arg_34_0._onAutoPlayCardFlowDone, arg_34_0)
		arg_34_0._autoPlayCardFlow:start()
	else
		arg_34_0:_onCardEndFlowDone()
		FightViewPartVisible.set()
	end
end

function var_0_0._onForceEndAutoCardFlow(arg_35_0)
	if arg_35_0._autoPlayCardFlow then
		arg_35_0._autoPlayCardFlow:stop()
		arg_35_0:_onCardEndFlowDone()
		FightViewPartVisible.set()
	end
end

function var_0_0._onAutoPlayCardFlowDone(arg_36_0)
	arg_36_0._autoPlayCardFlow:unregisterDoneListener(arg_36_0._onAutoPlayCardFlowDone, arg_36_0)

	arg_36_0._autoPlayCardFlow = nil
end

function var_0_0._playHandCard(arg_37_0, arg_37_1, arg_37_2, arg_37_3, arg_37_4)
	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if arg_37_0._cardPlayFlow.status == WorkStatus.Running then
		return
	end

	local var_37_0 = FightDataHelper.handCardMgr.handCard
	local var_37_1 = var_37_0[arg_37_1]

	if not var_37_1 then
		arg_37_0:_updateNow()

		return
	end

	FightController.instance:dispatchEvent(FightEvent.HideCardSkillTips)
	arg_37_0:_setBlockOperate(true)

	if arg_37_4 and arg_37_4 ~= 0 then
		var_37_1.skillId = arg_37_4
	end

	var_37_1.playCanAddExpoint = FightCardDataHelper.playCanAddExpoint(var_37_0, var_37_1)

	local var_37_2 = FightDataHelper.operationDataMgr:newOperation()

	var_37_2:playCard(arg_37_1, arg_37_2, var_37_1, arg_37_3, arg_37_4)

	var_37_2.cardColor = FightDataHelper.LYDataMgr:getCardColor(var_37_0, arg_37_1)
	var_37_2.cardInfoMO.areaRedOrBlue = var_37_2.cardColor

	if var_37_1.heatId ~= 0 then
		local var_37_3 = FightDataHelper.teamDataMgr
		local var_37_4 = var_37_1.heatId
		local var_37_5 = var_37_3.myData.cardHeat.values[var_37_4]
		local var_37_6 = var_37_3.myCardHeatOffset[var_37_4] or 0

		var_37_3.myCardHeatOffset[var_37_4] = var_37_6 + var_37_5.changeValue

		FightController.instance:dispatchEvent(FightEvent.RefreshCardHeatShow, var_37_4)
	end

	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, var_37_2)
	table.remove(var_37_0, arg_37_1)

	local var_37_7 = FightDataUtil.copyData(var_37_0)
	local var_37_8

	if not FightCardDataHelper.isSkill3(var_37_1) and FightCardDataHelper.isBigSkill(var_37_1.skillId) then
		while true do
			if #var_37_0 > 0 then
				local var_37_9 = false

				for iter_37_0 = 1, #var_37_0 do
					local var_37_10 = var_37_0[iter_37_0]

					if var_37_10.uid == var_37_1.uid and FightCardDataHelper.isBigSkill(var_37_10.skillId) and not FightCardDataHelper.isSkill3(var_37_10) then
						var_37_8 = var_37_8 or {}

						table.insert(var_37_8, iter_37_0)
						FightDataHelper.operationDataMgr:newOperation():simulateDissolveCard(iter_37_0)
						table.remove(var_37_0, iter_37_0)

						break
					end

					if iter_37_0 == #var_37_0 then
						var_37_9 = true
					end
				end

				if var_37_9 then
					break
				end
			else
				break
			end
		end
	end

	local var_37_11 = false

	if FightCardDataHelper.isDiscard(var_37_1) then
		var_37_11 = true
	end

	arg_37_0._cardsForCombines = var_37_0

	local var_37_12 = arg_37_0:getUserDataTb_()

	var_37_12.view = arg_37_0
	var_37_12.cards = var_37_0
	var_37_12.from = arg_37_1
	var_37_12.viewGO = arg_37_0.viewGO
	var_37_12.handCardTr = arg_37_0._handCardTr
	var_37_12.handCardItemList = arg_37_0._handCardItemList
	var_37_12.fightBeginRoundOp = var_37_2
	var_37_12.beforeDissolveCards = var_37_7
	var_37_12.dissolveCardIndexsAfterPlay = var_37_8
	var_37_12.needDiscard = var_37_11
	var_37_12.param2 = arg_37_3

	arg_37_0._cardPlayFlow:registerDoneListener(arg_37_0._onPlayCardDone, arg_37_0)
	arg_37_0._cardPlayFlow:start(var_37_12)
	arg_37_0:_playCardAudio(var_37_1)
end

local var_0_3 = {
	31160101,
	31160102,
	31160103,
	31160104,
	31160105,
	31160106
}

function var_0_0._playCardAudio(arg_38_0, arg_38_1)
	if FightReplayModel.instance:isReplay() then
		return
	end

	local var_38_0 = FightHelper.getEntity(arg_38_1.uid)
	local var_38_1 = var_38_0 and var_38_0:getMO()

	if not var_38_1 then
		return
	end

	if FightEntityDataHelper.isPlayerUid(var_38_1.id) then
		return
	end

	local var_38_2 = FightDataHelper.operationDataMgr:getOpList()
	local var_38_3 = FightBuffHelper.simulateBuffList(var_38_1, var_38_2[#var_38_2])

	if not FightViewHandCardItemLock.canUseCardSkill(arg_38_1.uid, arg_38_1.skillId, var_38_3) then
		return
	end

	local var_38_4 = FightCardDataHelper.getSkillLv(arg_38_1.uid, arg_38_1.skillId)
	local var_38_5 = var_38_1.modelId
	local var_38_6 = HeroConfig.instance:getHeroCO(var_38_5)
	local var_38_7

	if not tabletool.indexOf(var_0_3, arg_38_1.skillId) and arg_38_1.cardType == FightEnum.CardType.SKILL3 then
		local var_38_8 = FightConfig.instance:getSkinSkillTimeline(var_38_1.skin, arg_38_1.skillId)
		local var_38_9 = FightAudioMgr.instance:_getHeroVoiceCOs(var_38_5, CharacterEnum.VoiceType.FightCardSkill3, var_38_1.skin)

		for iter_38_0, iter_38_1 in ipairs(var_38_9) do
			if iter_38_1.param == var_38_8 then
				var_38_7 = iter_38_1.audio

				break
			end
		end
	elseif var_38_4 == 1 or var_38_4 == 2 then
		var_38_7 = FightAudioMgr.instance:getHeroVoiceRandom(var_38_5, CharacterEnum.VoiceType.FightCardStar12, arg_38_1.uid)
	elseif var_38_4 == 3 then
		var_38_7 = FightAudioMgr.instance:getHeroVoiceRandom(var_38_5, CharacterEnum.VoiceType.FightCardStar3, arg_38_1.uid)

		if not var_38_7 then
			if var_38_6 and var_38_6.rare >= 4 then
				var_38_7 = FightAudioMgr.instance:getHeroVoiceRandom(var_38_5, CharacterEnum.VoiceType.FightCardStar3, arg_38_1.uid)
			else
				var_38_7 = FightAudioMgr.instance:getHeroVoiceRandom(var_38_5, CharacterEnum.VoiceType.FightCardStar12, arg_38_1.uid)
			end
		end
	elseif var_38_4 == FightEnum.UniqueSkillCardLv then
		var_38_7 = FightAudioMgr.instance:getHeroVoiceRandom(var_38_5, CharacterEnum.VoiceType.FightCardUnique, arg_38_1.uid)
	end

	if var_38_7 then
		FightAudioMgr.instance:playCardAudio(arg_38_1.uid, var_38_7, var_38_5)
	end
end

function var_0_0._onPlayCardDone(arg_39_0, arg_39_1)
	arg_39_0._cardPlayFlow:unregisterDoneListener(arg_39_0._onPlayCardDone, arg_39_0)

	local var_39_0 = arg_39_0._cardPlayFlow.context.cards or FightDataHelper.handCardMgr.handCard

	arg_39_0:_updateHandCards(var_39_0)
	FightController.instance:dispatchEvent(FightEvent.OnPlayCardFlowDone, arg_39_0._cardPlayFlow.context.fightBeginRoundOp)
	FightController.instance:dispatchEvent(FightEvent.PlayCardOver)
	arg_39_0:_detectPlayPrecisionEffect()

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		arg_39_0:_setBlockOperate(true)

		return
	end
end

function var_0_0._playRedealCardEffect(arg_40_0, arg_40_1, arg_40_2)
	local var_40_0 = arg_40_0:getUserDataTb_()

	var_40_0.oldCards = arg_40_1
	var_40_0.newCards = arg_40_2
	var_40_0.handCardItemList = arg_40_0._handCardItemList

	arg_40_0:beforeRedealCardFlow()
	arg_40_0._redealCardFlow:registerDoneListener(arg_40_0._onRedealCardDone, arg_40_0)
	arg_40_0._redealCardFlow:start(var_40_0)
end

function var_0_0.beforeRedealCardFlow(arg_41_0)
	for iter_41_0, iter_41_1 in ipairs(arg_41_0._handCardItemList) do
		iter_41_1:playASFDAnim("close")
	end
end

function var_0_0.afterRedealCardFlow(arg_42_0)
	for iter_42_0, iter_42_1 in ipairs(arg_42_0._handCardItemList) do
		iter_42_1:playASFDAnim("open")
	end
end

function var_0_0._onRedealCardDone(arg_43_0)
	arg_43_0._redealCardFlow:unregisterDoneListener(arg_43_0._onRedealCardDone, arg_43_0)
	arg_43_0:afterRedealCardFlow()
	arg_43_0:_updateNow()
end

function var_0_0._setCardMagicEffectChange(arg_44_0, arg_44_1, arg_44_2, arg_44_3)
	arg_44_0._card_magic_effect_change_info = arg_44_0._card_magic_effect_change_info or {}
	arg_44_0._card_magic_effect_change_info[arg_44_1] = {
		old_effect = arg_44_2,
		new_effect = arg_44_3
	}
end

function var_0_0._playCardMagicEffectChange(arg_45_0)
	local var_45_0 = arg_45_0:getUserDataTb_()

	var_45_0.changeInfos = arg_45_0._card_magic_effect_change_info
	var_45_0.handCardItemList = arg_45_0._handCardItemList
	arg_45_0._card_magic_effect_change_info = nil

	arg_45_0:_setBlockOperate(true)
	arg_45_0._magicEffectCardFlow:registerDoneListener(arg_45_0._onMagicEffectCardFlowDone, arg_45_0)
	arg_45_0._magicEffectCardFlow:start(var_45_0)
end

function var_0_0._onMagicEffectCardFlowDone(arg_46_0)
	arg_46_0._magicEffectCardFlow:unregisterDoneListener(arg_46_0._onMagicEffectCardFlowDone, arg_46_0)

	local var_46_0 = FightDataHelper.handCardMgr.handCard

	arg_46_0:_combineCards(var_46_0)
end

function var_0_0._playUniversalAppear(arg_47_0)
	arg_47_0:_setBlockOperate(true)
	arg_47_0:_updateNow()

	local var_47_0 = arg_47_0:getUserDataTb_()

	var_47_0.handCardItemList = arg_47_0._handCardItemList

	arg_47_0._universalAppearFlow:start(var_47_0)
	arg_47_0._universalAppearFlow:registerDoneListener(arg_47_0._onUniversalAppearDone, arg_47_0)
end

function var_0_0._onSpCardAdd(arg_48_0, arg_48_1)
	arg_48_0:_playCorrectHandCardScale(0)

	local var_48_0 = FightDataHelper.handCardMgr.handCard

	arg_48_0:_updateHandCards(var_48_0, arg_48_1)

	local var_48_1 = arg_48_0._handCardItemList[arg_48_1]

	gohelper.setActive(var_48_1.go, false)
	var_48_1:playCardAni(ViewAnim.FightCardBalance)
end

function var_0_0._onCorrectHandCardScale(arg_49_0, arg_49_1)
	arg_49_0:_playCorrectHandCardScale(arg_49_1)
end

function var_0_0._playCorrectHandCardScale(arg_50_0, arg_50_1, arg_50_2)
	arg_50_0._correctHandCardScale:stop()

	local var_50_0 = arg_50_0:getUserDataTb_()

	var_50_0.cards = tabletool.copy(FightDataHelper.handCardMgr.handCard)
	var_50_0.oldScale = arg_50_1
	var_50_0.newScale = arg_50_2
	var_50_0.handCardContainer = arg_50_0._handCardContainer

	arg_50_0._correctHandCardScale:start(var_50_0)
end

function var_0_0._onCardsCompose(arg_51_0)
	local var_51_0 = FightDataHelper.handCardMgr.handCard

	arg_51_0:_combineCards(var_51_0)
end

function var_0_0._onCardsComposeTimeOut(arg_52_0)
	if arg_52_0._cardCombineFlow then
		arg_52_0._cardCombineFlow:stop()
	end

	arg_52_0:_updateNow()
end

function var_0_0._onRemoveEntityCards(arg_53_0, arg_53_1)
	for iter_53_0 = #arg_53_0._handCardItemList, 1, -1 do
		local var_53_0 = arg_53_0._handCardItemList[iter_53_0]

		if var_53_0.go.activeInHierarchy and var_53_0:dissolveEntityCard(arg_53_1) then
			table.insert(arg_53_0._handCardItemList, table.remove(arg_53_0._handCardItemList, iter_53_0))
		end
	end

	var_0_0.refreshCardIndex(arg_53_0._handCardItemList)
	TaskDispatcher.cancelTask(arg_53_0._correctActiveCardObjPos, arg_53_0)
	TaskDispatcher.runDelay(arg_53_0._correctActiveCardObjPos, arg_53_0, 1 / FightModel.instance:getUISpeed())
end

function var_0_0.refreshCardIndex(arg_54_0)
	for iter_54_0, iter_54_1 in ipairs(arg_54_0) do
		iter_54_1.index = iter_54_0
	end
end

function var_0_0._onCardLevelChange(arg_55_0, arg_55_1, arg_55_2, arg_55_3)
	local var_55_0 = arg_55_0._handCardItemList[arg_55_1]

	if var_55_0 then
		var_55_0:playCardLevelChange(arg_55_2)
	end

	if arg_55_3 then
		TaskDispatcher.cancelTask(arg_55_0._combineAfterCardLevelChange, arg_55_0)
		TaskDispatcher.runDelay(arg_55_0._combineAfterCardLevelChange, arg_55_0, FightEnum.PerformanceTime.CardLevelChange / FightModel.instance:getUISpeed())
	end
end

function var_0_0._combineAfterCardLevelChange(arg_56_0)
	local var_56_0 = FightDataHelper.handCardMgr.handCard

	arg_56_0:_combineCards(var_56_0)
end

function var_0_0._onPlayCombineCards(arg_57_0, arg_57_1)
	arg_57_0:_combineCards(arg_57_1)
end

function var_0_0._onCardRemove(arg_58_0, arg_58_1, arg_58_2, arg_58_3)
	arg_58_0:_onCardRemove2(arg_58_1)

	if arg_58_3 then
		TaskDispatcher.cancelTask(arg_58_0._combineAfterCardRemove, arg_58_0)
		TaskDispatcher.runDelay(arg_58_0._combineAfterCardRemove, arg_58_0, arg_58_2 / FightModel.instance:getUISpeed())
	end
end

function var_0_0._combineAfterCardRemove(arg_59_0)
	local var_59_0 = FightDataHelper.handCardMgr.handCard

	arg_59_0:_combineCards(var_59_0)
end

function var_0_0._onCardRemove2(arg_60_0, arg_60_1)
	for iter_60_0, iter_60_1 in ipairs(arg_60_1) do
		local var_60_0 = table.remove(arg_60_0._handCardItemList, iter_60_1)

		if var_60_0 and var_60_0.go.activeInHierarchy then
			var_60_0:dissolveCard()
			table.insert(arg_60_0._handCardItemList, var_60_0)
		end
	end

	var_0_0.refreshCardIndex(arg_60_0._handCardItemList)
	TaskDispatcher.cancelTask(arg_60_0._correctActiveCardObjPos, arg_60_0)
	TaskDispatcher.runDelay(arg_60_0._correctActiveCardObjPos, arg_60_0, 1 / FightModel.instance:getUISpeed())
end

function var_0_0._correctActiveCardObjPos(arg_61_0)
	local var_61_0 = 0

	for iter_61_0 = 1, #arg_61_0._handCardItemList do
		local var_61_1 = arg_61_0._handCardItemList[iter_61_0]

		var_61_1.index = iter_61_0
		var_61_1.go.name = "cardItem" .. iter_61_0

		local var_61_2 = var_61_1.go

		if not var_61_2.activeInHierarchy then
			break
		end

		local var_61_3 = recthelper.getAnchorX(var_61_2.transform)
		local var_61_4 = var_0_0.calcCardPosX(iter_61_0)

		if math.abs(var_61_3 - var_61_4) >= 10 then
			var_61_1:moveSelfPos(iter_61_0, var_61_0, var_61_4)

			var_61_0 = var_61_0 + 1
		end
	end
end

function var_0_0._onAddHandCard(arg_62_0, arg_62_1, arg_62_2)
	arg_62_0:_playCorrectHandCardScale(0)

	local var_62_0 = FightDataHelper.handCardMgr.handCard
	local var_62_1 = #var_62_0

	arg_62_0:_updateHandCards(var_62_0, var_62_1)
	arg_62_0._handCardItemList[var_62_1]:playDistribute()

	if arg_62_2 then
		TaskDispatcher.runDelay(arg_62_0._combineCardsAfterAddHandCard, arg_62_0, 0.5 / FightModel.instance:getUISpeed())
	end
end

function var_0_0._onMasterAddHandCard(arg_63_0, arg_63_1, arg_63_2)
	arg_63_0:_playCorrectHandCardScale(0)

	local var_63_0 = FightDataHelper.handCardMgr.handCard
	local var_63_1 = #var_63_0

	arg_63_0:_updateHandCards(var_63_0, var_63_1)
	arg_63_0._handCardItemList[var_63_1]:playMasterAddHandCard()

	if arg_63_2 then
		TaskDispatcher.runDelay(arg_63_0._combineCardsAfterAddHandCard, arg_63_0, 1 / FightModel.instance:getUISpeed())
	end
end

function var_0_0._onMasterCardRemove(arg_64_0, arg_64_1, arg_64_2, arg_64_3)
	for iter_64_0, iter_64_1 in ipairs(arg_64_1) do
		local var_64_0 = table.remove(arg_64_0._handCardItemList, iter_64_1)

		if var_64_0 and var_64_0.go.activeInHierarchy then
			var_64_0:playMasterCardRemove()
			table.insert(arg_64_0._handCardItemList, var_64_0)
		end
	end

	var_0_0.refreshCardIndex(arg_64_0._handCardItemList)
	TaskDispatcher.cancelTask(arg_64_0._correctActiveCardObjPos, arg_64_0)
	TaskDispatcher.runDelay(arg_64_0._correctActiveCardObjPos, arg_64_0, 0.7 / FightModel.instance:getUISpeed())

	if arg_64_3 then
		TaskDispatcher.cancelTask(arg_64_0._combineAfterCardRemove, arg_64_0)
		TaskDispatcher.runDelay(arg_64_0._combineAfterCardRemove, arg_64_0, arg_64_2 / FightModel.instance:getUISpeed())
	end
end

function var_0_0._combineCardsAfterAddHandCard(arg_65_0)
	local var_65_0 = FightDataHelper.handCardMgr.handCard

	arg_65_0:_combineCards(var_65_0)
end

function var_0_0._onCardAConvertCardB(arg_66_0, arg_66_1)
	local var_66_0 = FightDataHelper.handCardMgr.handCard
	local var_66_1 = arg_66_0._handCardItemList[arg_66_1]

	if var_66_1 then
		var_66_1:playCardAConvertCardB()
		var_66_1:updateItem(arg_66_1, var_66_0[arg_66_1])
	else
		arg_66_0:_updateNow()
	end
end

function var_0_0._onTempCardRemove(arg_67_0)
	arg_67_0:_updateNow()

	local var_67_0 = FightDataHelper.handCardMgr.handCard

	arg_67_0:_combineCards(var_67_0)
end

function var_0_0._onChangeToTempCard(arg_68_0, arg_68_1)
	local var_68_0 = arg_68_0._handCardItemList[arg_68_1]

	if var_68_0 then
		var_68_0:changeToTempCard()
	end
end

function var_0_0._onUniversalAppearDone(arg_69_0)
	arg_69_0._universalAppearFlow:unregisterDoneListener(arg_69_0._onUniversalAppearDone, arg_69_0)
	arg_69_0:_setBlockOperate(false)
	FightController.instance:dispatchEvent(FightEvent.OnUniversalAppear)
end

function var_0_0._combineCards(arg_70_0, arg_70_1, arg_70_2, arg_70_3)
	arg_70_0._combineIndex = arg_70_2 or FightCardDataHelper.canCombineCardListForPerformance(arg_70_1)
	arg_70_0._isUniversalCombine = arg_70_2 and true or false

	if arg_70_0._combineIndex then
		arg_70_0._cardsForCombines = arg_70_1

		local var_70_0 = arg_70_0:getUserDataTb_()

		var_70_0.cards = arg_70_1
		var_70_0.combineIndex = arg_70_0._combineIndex
		var_70_0.handCardItemList = arg_70_0._handCardItemList
		var_70_0.fightBeginRoundOp = arg_70_3

		arg_70_0._cardCombineFlow:registerDoneListener(arg_70_0._onCombineCardDone, arg_70_0)
		arg_70_0._cardCombineFlow:start(var_70_0)
	else
		arg_70_0:_setBlockOperate(false)
		FightController.instance:dispatchEvent(FightEvent.OnCombineCardEnd, arg_70_1)

		local var_70_1 = FightModel.instance:getCurStage()

		if var_70_1 == FightEnum.Stage.Distribute or var_70_1 == FightEnum.Stage.FillCard then
			if arg_70_0.distributeCards and #arg_70_0.distributeCards > 0 then
				arg_70_0:_nextDistributeCards(#arg_70_1)
			else
				gohelper.destroy(gohelper.findChild(arg_70_0._handCardGO, "CombineEffect"))
				arg_70_0:_updateNow()
				FightController.instance:dispatchEvent(FightEvent.OnDistributeCards)
			end
		elseif var_70_1 == FightEnum.Stage.AutoCard and arg_70_0._autoPlayCardFlow and arg_70_0._autoPlayCardFlow.status == WorkStatus.Running then
			FightController.instance:dispatchEvent(FightEvent.OneAutoPlayCardFinish)
		end

		if arg_70_3 then
			FightController.instance:dispatchEvent(FightEvent.PlayOperationEffectDone, arg_70_3)
			arg_70_0:_detectPlayPrecisionEffect()
		end
	end
end

function var_0_0._onCombineCardDone(arg_71_0, arg_71_1)
	arg_71_0._cardCombineFlow:unregisterDoneListener(arg_71_0._onCombineCardDone, arg_71_0)

	local var_71_0 = arg_71_0._cardsForCombines[arg_71_0._combineIndex]

	FightController.instance:dispatchEvent(FightEvent.OnCombineOneCard, var_71_0, arg_71_0._isUniversalCombine)
	arg_71_0:_combineCards(arg_71_0._cardsForCombines, nil, arg_71_0._cardCombineFlow.context.fightBeginRoundOp)
end

function var_0_0._resetCard(arg_72_0, arg_72_1)
	FightDataHelper.paTaMgr:resetOp()
	FightController.instance:dispatchEvent(FightEvent.OnResetCard, arg_72_1)

	if arg_72_0._cardPlayFlow.status == WorkStatus.Running then
		arg_72_0._cardPlayFlow:stop()
	end

	if arg_72_0._autoPlayCardFlow then
		arg_72_0._autoPlayCardFlow:stop()
	end

	if FightModel.instance:getCurStage() == FightEnum.Stage.AutoCard and not FightModel.instance:isAuto() then
		FightController.instance:setCurStage(FightEnum.Stage.Card)
	end
end

function var_0_0._updateNow(arg_73_0)
	arg_73_0:_updateHandCards(FightDataHelper.handCardMgr.handCard)
end

function var_0_0._filterInvalidCard(arg_74_0, arg_74_1)
	for iter_74_0 = #arg_74_1, 1, -1 do
		local var_74_0 = arg_74_1[iter_74_0].skillId

		if not lua_skill.configDict[var_74_0] then
			if not var_74_0 then
				logError("手牌数据没有skillId,请保存复现数据找开发看看")
			else
				logError("技能表找不到id:" .. var_74_0)
			end

			table.remove(arg_74_1, iter_74_0)
		end
	end

	return arg_74_1
end

function var_0_0._updateHandCards(arg_75_0, arg_75_1, arg_75_2)
	arg_75_1 = arg_75_1 or FightDataHelper.handCardMgr.handCard
	arg_75_1 = arg_75_0:_filterInvalidCard(arg_75_1)

	local var_75_0 = arg_75_1 and #arg_75_1 or 0

	for iter_75_0 = arg_75_2 or 1, var_75_0 do
		local var_75_1 = arg_75_0._handCardItemList[iter_75_0]

		if not var_75_1 then
			local var_75_2 = gohelper.clone(arg_75_0._handCardItemPrefab, arg_75_0._handCardGO)

			var_75_1 = MonoHelper.addLuaComOnceToGo(var_75_2, FightViewHandCardItem, arg_75_0)

			table.insert(arg_75_0._handCardItemList, var_75_1)
		end

		var_75_1.go.name = "cardItem" .. iter_75_0

		local var_75_3 = var_0_0.calcCardPosX(iter_75_0)

		recthelper.setAnchor(var_75_1.tr, var_75_3, 0)
		gohelper.setActive(var_75_1.go, true)
		transformhelper.setLocalScale(var_75_1.tr, 1, 1, 1)
		var_75_1:updateItem(iter_75_0, arg_75_1[iter_75_0])
		gohelper.setAsLastSibling(var_75_1.go)
	end

	for iter_75_1 = var_75_0 + 1, #arg_75_0._handCardItemList do
		local var_75_4 = arg_75_0._handCardItemList[iter_75_1]

		gohelper.setActive(var_75_4.go, false)

		var_75_4.go.name = "cardItem" .. iter_75_1

		var_75_4:updateItem(iter_75_1, nil)
	end

	arg_75_0:refreshPreDeleteCard(arg_75_1)
	arg_75_0:refreshLyCardTag()
end

function var_0_0._setBlockOperate(arg_76_0, arg_76_1)
	var_0_0.blockOperate = arg_76_1 and true or false

	if not gohelper.isNil(arg_76_0._handCardGOCanvasGroup) then
		arg_76_0._handCardGOCanvasGroup.blocksRaycasts = not arg_76_1
	end

	if arg_76_1 then
		TaskDispatcher.cancelTask(arg_76_0._delayCancelBlock, arg_76_0)
		TaskDispatcher.runDelay(arg_76_0._delayCancelBlock, arg_76_0, 10)
	else
		TaskDispatcher.cancelTask(arg_76_0._delayCancelBlock, arg_76_0)
	end

	arg_76_0:refreshLYAreaActive()
end

function var_0_0._delayCancelBlock(arg_77_0)
	arg_77_0:_setBlockOperate(false)
end

function var_0_0._onAfterForceUpdatePerformanceData(arg_78_0)
	arg_78_0:_updateNow()
end

function var_0_0._onRoundSequenceFinish(arg_79_0)
	arg_79_0:_updateNow()
end

function var_0_0._onClothSkillRoundSequenceFinish(arg_80_0)
	return
end

function var_0_0._onDragHandCardBegin(arg_81_0, arg_81_1, arg_81_2)
	if arg_81_0._cardDragFlow.status == WorkStatus.Running then
		return
	end

	if arg_81_0._cardLongPressFlow.status == WorkStatus.Running then
		arg_81_0._cardLongPressFlow:stop()
		arg_81_0._cardLongPressFlow:reset()
	end

	arg_81_0._dragBeginCards = FightDataHelper.handCardMgr.handCard
	arg_81_0._cardCount = #arg_81_0._dragBeginCards

	if arg_81_1 > arg_81_0._cardCount then
		return
	end

	local var_81_0 = arg_81_0:getUserDataTb_()

	var_81_0.index = arg_81_1
	var_81_0.position = arg_81_2
	var_81_0.cardCount = arg_81_0._cardCount
	var_81_0.handCardItemList = arg_81_0._handCardItemList
	var_81_0.handCardTr = arg_81_0._handCardTr
	var_81_0.handCards = arg_81_0._dragBeginCards

	arg_81_0._cardDragFlow:start(var_81_0)
	arg_81_0._handCardItemList[arg_81_1]:stopLongPressEffect()
	FightController.instance:dispatchEvent(FightEvent.HideCardSkillTips)
end

function var_0_0._onDragHandCardEnd(arg_82_0, arg_82_1, arg_82_2)
	if arg_82_1 > arg_82_0._cardCount then
		arg_82_0:_updateNow()

		return
	end

	arg_82_0._cardDragFlow:stop()
	arg_82_0._cardDragFlow:reset()

	arg_82_0._dragIndex = arg_82_1

	local var_82_0 = recthelper.screenPosToAnchorPos(arg_82_2, arg_82_0._handCardTr)
	local var_82_1, var_82_2, var_82_3 = transformhelper.getLocalScale(arg_82_0._handCardItemList[arg_82_1].tr)
	local var_82_4 = var_82_0.x - var_0_0.HalfWidth

	arg_82_0._targetIndex = var_0_0.calcCardIndexDraging(var_82_4, arg_82_0._cardCount, 1)

	local var_82_5 = arg_82_0:getUserDataTb_()

	var_82_5.index = arg_82_1
	var_82_5.targetIndex = arg_82_0._targetIndex
	var_82_5.cardCount = arg_82_0._cardCount
	var_82_5.handCardItemList = arg_82_0._handCardItemList
	var_82_5.handCardTr = arg_82_0._handCardTr
	var_82_5.handCards = arg_82_0._dragBeginCards

	arg_82_0._cardDragEndFlow:registerDoneListener(arg_82_0._onDragEndFlowDone, arg_82_0)
	arg_82_0._cardDragEndFlow:start(var_82_5)
	arg_82_0:_setBlockOperate(true)
end

function var_0_0._onDragEndFlowDone(arg_83_0)
	arg_83_0._cardDragEndFlow:unregisterDoneListener(arg_83_0._onDragEndFlowDone, arg_83_0)

	local var_83_0 = arg_83_0._dragIndex
	local var_83_1 = arg_83_0._targetIndex

	if not arg_83_0:_checkGuideMoveCard(var_83_0, var_83_1) then
		return
	end

	if var_83_0 == var_83_1 then
		arg_83_0:_setBlockOperate(false)

		return
	end

	local var_83_2 = arg_83_0._dragBeginCards[var_83_0]
	local var_83_3 = false

	if FightEnum.UniversalCard[var_83_2.skillId] then
		local var_83_4 = tabletool.copy(arg_83_0._dragBeginCards)

		table.remove(var_83_4, var_83_0)
		table.insert(var_83_4, var_83_1, var_83_2)

		if not FightCardDataHelper.canCombineWithUniversalForPerformance(var_83_2, var_83_4[var_83_1 + 1]) then
			arg_83_0:_updateNow()
			arg_83_0:_setBlockOperate(false)

			return
		end

		var_83_3 = var_83_1
	end

	local var_83_5 = arg_83_0._dragBeginCards
	local var_83_6 = var_83_2.skillId

	if (var_83_2.uid == FightEntityScene.MySideId or var_83_2.uid == FightEntityScene.EnemySideId) and not FightEnum.UniversalCard[var_83_6] then
		arg_83_0:_updateNow()
		arg_83_0:_setBlockOperate(false)

		return
	end

	arg_83_0:_moveCardItemInList(var_83_0, var_83_1)

	if not FightDataHelper.operationDataMgr:isCardOpEnd() then
		local var_83_7 = FightDataHelper.operationDataMgr:newOperation()

		var_83_7.moveCanAddExpoint = FightCardDataHelper.moveCanAddExpoint(var_83_5, var_83_2)

		if var_83_3 then
			var_83_7:moveUniversalCard(var_83_0, var_83_1, var_83_2)
		else
			var_83_7:moveCard(var_83_0, var_83_1, var_83_2)
		end

		FightCardDataHelper.moveOnly(var_83_5, var_83_0, var_83_1)

		if var_83_0 ~= var_83_1 then
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_FightMoveCardEnd)
		end

		arg_83_0:_updateHandCards(var_83_5)
		FightController.instance:dispatchEvent(FightEvent.OnMoveHandCard, var_83_7, var_83_2)
		FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, var_83_7)

		local var_83_8 = var_83_3 and var_83_1

		arg_83_0:_combineCards(var_83_5, var_83_8, var_83_7)
	else
		arg_83_0:_updateHandCards(var_83_5)

		if not FightReplayModel.instance:isReplay() then
			-- block empty
		end

		arg_83_0:_setBlockOperate(false)
	end
end

function var_0_0._moveCardItemInList(arg_84_0, arg_84_1, arg_84_2)
	if not arg_84_0._handCardItemList or not arg_84_0._handCardItemList[arg_84_1] or not arg_84_0._handCardItemList[arg_84_2] then
		return
	end

	if arg_84_1 == arg_84_2 then
		return
	end

	local var_84_0 = arg_84_0._handCardItemList[arg_84_1]
	local var_84_1 = arg_84_1 < arg_84_2 and 1 or -1

	for iter_84_0 = arg_84_1, arg_84_2 - var_84_1, var_84_1 do
		arg_84_0._handCardItemList[iter_84_0] = arg_84_0._handCardItemList[iter_84_0 + var_84_1]
	end

	arg_84_0._handCardItemList[arg_84_2] = var_84_0
end

function var_0_0._playCardItemInList(arg_85_0, arg_85_1)
	if not arg_85_0._handCardItemList or not arg_85_0._handCardItemList[arg_85_1] then
		return
	end

	arg_85_0:_moveCardItemInList(arg_85_1, #arg_85_0._handCardItemList)
end

function var_0_0._checkGuideMoveCard(arg_86_0, arg_86_1, arg_86_2)
	local var_86_0 = GuideModel.instance:getFlagValue(GuideModel.GuideFlag.FightMoveCard)

	if var_86_0 then
		local var_86_1 = arg_86_1 == var_86_0.from

		if var_86_1 then
			local var_86_2 = false
			local var_86_3 = var_86_0.tos

			for iter_86_0, iter_86_1 in ipairs(var_86_3) do
				if arg_86_2 == iter_86_1 then
					var_86_2 = true

					break
				end
			end

			var_86_1 = var_86_2
		end

		if var_86_1 then
			FightController.instance:dispatchEvent(FightEvent.OnGuideDragCard)

			return true
		else
			arg_86_0:_resetCard({})
			arg_86_0:_setBlockOperate(false)

			return false
		end
	end

	return true
end

function var_0_0.selectLeftCard(arg_87_0)
	if arg_87_0._longPressIndex == nil then
		local var_87_0 = 1

		for iter_87_0, iter_87_1 in pairs(arg_87_0._handCardItemList) do
			if iter_87_1.go.activeInHierarchy and var_87_0 < iter_87_1.index then
				var_87_0 = iter_87_1.index
			end
		end

		arg_87_0:OnkeyLongPress(var_87_0)
	else
		if arg_87_0._longPressIndex + 1 > #arg_87_0._handCardItemList then
			return
		end

		local var_87_1 = arg_87_0._handCardItemList[arg_87_0._longPressIndex + 1]

		if var_87_1 and not var_87_1.go.activeInHierarchy then
			return
		end

		arg_87_0:OnkeyLongPress(arg_87_0._longPressIndex + 1)
	end
end

function var_0_0.selectRightCard(arg_88_0)
	if arg_88_0._longPressIndex == nil then
		local var_88_0 = 1

		for iter_88_0, iter_88_1 in pairs(arg_88_0._handCardItemList) do
			if iter_88_1.go.activeInHierarchy and var_88_0 > iter_88_1.index then
				var_88_0 = iter_88_1.index
			end
		end

		arg_88_0:OnkeyLongPress(var_88_0)
	else
		if arg_88_0._longPressIndex - 1 < 1 then
			return
		end

		arg_88_0:OnkeyLongPress(arg_88_0._longPressIndex - 1)
	end
end

function var_0_0.OnKeyPlayCard(arg_89_0, arg_89_1)
	if ViewMgr.instance:IsPopUpViewOpen() then
		return
	end

	arg_89_0:_longPressHandCardEnd()

	local var_89_0 = #FightDataHelper.handCardMgr.handCard

	for iter_89_0, iter_89_1 in pairs(arg_89_0._handCardItemList) do
		if iter_89_1.index == var_89_0 - arg_89_1 + 1 and iter_89_1.go.activeInHierarchy then
			iter_89_1:_onClickThis()
		end
	end
end

function var_0_0.OnkeyLongPress(arg_90_0, arg_90_1)
	if FightReplayModel.instance:isReplay() then
		return
	end

	arg_90_0:_longPressHandCardEnd()
	FightController.instance:dispatchEvent(FightEvent.HideCardSkillTips)

	for iter_90_0, iter_90_1 in pairs(arg_90_0._handCardItemList) do
		if iter_90_1.index == arg_90_1 and iter_90_1.go.activeInHierarchy then
			iter_90_1:_onLongPress()
		end
	end
end

function var_0_0.onControlRelease(arg_91_0)
	if not arg_91_0._longPressIndex then
		return
	end

	for iter_91_0, iter_91_1 in pairs(arg_91_0._handCardItemList) do
		if iter_91_1 and iter_91_1.index == arg_91_0._longPressIndex then
			iter_91_1:_onClickThis()
		end
	end
end

function var_0_0.OnSeleCardMoveEnd(arg_92_0)
	arg_92_0._keyDrag = false

	FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCardEnd, arg_92_0.startDragIndex, arg_92_0.dragIndex)

	arg_92_0.dragIndex = nil
	arg_92_0.curLongPress = nil
end

function var_0_0.getLongPressItemIndex(arg_93_0)
	for iter_93_0, iter_93_1 in pairs(arg_93_0._handCardItemList) do
		if iter_93_1 and iter_93_1._isLongPress then
			return iter_93_1
		end
	end

	return nil
end

function var_0_0._longPressHandCard(arg_94_0, arg_94_1)
	arg_94_0:_longPressHandCardEnd()

	if arg_94_0._cardDragFlow.status == WorkStatus.Running then
		return
	end

	if arg_94_0._cardLongPressFlow.status == WorkStatus.Running then
		return
	end

	FightCardModel.instance:setLongPressIndex(arg_94_1)

	arg_94_0._longPressIndex = arg_94_1
	arg_94_0._cardCount = #FightDataHelper.handCardMgr.handCard
	arg_94_0._clearPressIndex = false

	local var_94_0 = arg_94_0:getUserDataTb_()

	var_94_0.index = arg_94_1
	var_94_0.cardCount = arg_94_0._cardCount
	var_94_0.handCardItemList = arg_94_0._handCardItemList

	arg_94_0._cardLongPressFlow:registerDoneListener(arg_94_0._onLongPressFlowDone, arg_94_0)
	arg_94_0._cardLongPressFlow:start(var_94_0)
	arg_94_0._handCardItemList[arg_94_1]:playLongPressEffect()
end

function var_0_0._onLongPressFlowDone(arg_95_0)
	arg_95_0._cardLongPressFlow:unregisterDoneListener(arg_95_0._onLongPressFlowDone, arg_95_0)
end

function var_0_0._longPressHandCardEnd(arg_96_0, arg_96_1)
	arg_96_1 = arg_96_1 or arg_96_0._longPressIndex

	if not arg_96_1 then
		return
	end

	arg_96_0._handCardItemList[arg_96_1]:stopLongPressEffect()
	arg_96_0._handCardItemList[arg_96_1]:onLongPressEnd()

	if arg_96_0._cardLongPressFlow.status == WorkStatus.Running then
		arg_96_0._cardLongPressFlow:stop()
		arg_96_0._cardLongPressFlow:reset()
	end

	arg_96_0._clearPressIndex = true

	local var_96_0 = arg_96_0:getUserDataTb_()

	var_96_0.index = arg_96_1
	var_96_0.cardCount = arg_96_0._cardCount
	var_96_0.handCardItemList = arg_96_0._handCardItemList

	arg_96_0._cardLongPressEndFlow:registerDoneListener(arg_96_0._onLongPressEndFlowDone, arg_96_0)
	arg_96_0._cardLongPressEndFlow:start(var_96_0)

	arg_96_0._longPressIndex = nil
end

function var_0_0._onLongPressEndFlowDone(arg_97_0)
	if arg_97_0._clearPressIndex then
		arg_97_0._longPressIndex = nil

		FightCardModel.instance:setLongPressIndex(-1)
	end

	arg_97_0._cardLongPressEndFlow:unregisterDoneListener(arg_97_0._onLongPressEndFlowDone, arg_97_0)
end

function var_0_0._onEnterOperateState(arg_98_0, arg_98_1)
	if arg_98_1 == FightStageMgr.OperateStateType.Discard then
		arg_98_0._abandonTran:SetAsLastSibling()
		gohelper.setActive(arg_98_0._abandon, true)
		arg_98_0._playCardTransform:SetAsLastSibling()

		local var_98_0 = 0

		for iter_98_0 = 1, #arg_98_0._handCardItemList do
			local var_98_1 = arg_98_0._handCardItemList[iter_98_0]

			if var_98_1 then
				if var_98_1.go.activeInHierarchy then
					var_98_0 = var_98_0 + 1
				else
					break
				end

				local var_98_2 = var_98_1.cardInfoMO
				local var_98_3 = false

				if FightDataHelper.entityMgr:getById(var_98_2.uid) then
					if not FightCardDataHelper.isBigSkill(var_98_2.skillId) then
						var_98_3 = true
					end
				else
					var_98_3 = true
				end

				if var_98_3 then
					var_98_1.go.transform:SetParent(arg_98_0._abandonCardRootTran, true)
				end
			end
		end

		recthelper.setWidth(arg_98_0._abandonLine, var_98_0 * var_0_2 + 20)
	end
end

function var_0_0.cancelAbandonState(arg_99_0)
	gohelper.setActive(arg_99_0._abandon, false)

	for iter_99_0 = arg_99_0._abandonCardRootTran.childCount - 1, 0, -1 do
		arg_99_0._abandonCardRootTran:GetChild(iter_99_0):SetParent(arg_99_0._handCardTr, true)
	end

	arg_99_0._playCardTransform:SetSiblingIndex(var_0_0.playCardSiblingIndex)
end

function var_0_0._onExitOperateState(arg_100_0, arg_100_1)
	if arg_100_1 == FightStageMgr.OperateStateType.Discard then
		arg_100_0:cancelAbandonState()
	end
end

function var_0_0._onRefreshCardHeatShow(arg_101_0, arg_101_1)
	if arg_101_0._handCardItemList then
		for iter_101_0, iter_101_1 in ipairs(arg_101_0._handCardItemList) do
			iter_101_1:showCardHeat()
		end
	end
end

function var_0_0.onChangeCardEnergy(arg_102_0, arg_102_1)
	if not arg_102_1 then
		return
	end

	for iter_102_0, iter_102_1 in ipairs(arg_102_1) do
		local var_102_0 = iter_102_1[1]
		local var_102_1 = arg_102_0._handCardItemList[var_102_0]

		if var_102_1 then
			var_102_1:changeEnergy()
		end
	end
end

function var_0_0.calcCardPosXDraging(arg_103_0, arg_103_1, arg_103_2, arg_103_3)
	local var_103_0 = var_0_0.calcTotalWidth(arg_103_1, arg_103_3) / (arg_103_1 - 1 + arg_103_3)

	if arg_103_0 < arg_103_2 then
		return -0.5 * var_103_0 - var_103_0 * (arg_103_0 - 1)
	elseif arg_103_2 < arg_103_0 then
		return -0.5 * var_103_0 - var_103_0 * (arg_103_0 - 1) - (arg_103_3 - 1) * var_103_0
	else
		return -0.5 * var_103_0 - var_103_0 * (arg_103_0 - 2) - (arg_103_3 * 0.5 + 0.5) * var_103_0
	end
end

function var_0_0.calcCardIndexDraging(arg_104_0, arg_104_1, arg_104_2)
	local var_104_0 = var_0_0.calcTotalWidth(arg_104_1, arg_104_2) / (arg_104_1 - 1 + arg_104_2)
	local var_104_1 = -arg_104_0 / var_104_0 - arg_104_2 * 0.5 + 1
	local var_104_2 = math.floor(var_104_1 + 0.5)

	return (Mathf.Clamp(var_104_2, 1, arg_104_1))
end

function var_0_0.calcTotalWidth(arg_105_0, arg_105_1)
	return arg_105_0 * var_0_2 + (arg_105_1 - 1) * var_0_2 * 0.5
end

function var_0_0.calcCardPosX(arg_106_0)
	return -1 * var_0_2 * (arg_106_0 - 1) - var_0_2 / 2
end

return var_0_0
