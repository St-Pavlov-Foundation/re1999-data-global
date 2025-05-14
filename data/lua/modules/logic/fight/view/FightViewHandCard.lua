module("modules.logic.fight.view.FightViewHandCard", package.seeall)

local var_0_0 = class("FightViewHandCard", BaseView)
local var_0_1 = 256
local var_0_2 = 185

var_0_0.blockOperate = false

function var_0_0.onInitView(arg_1_0)
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

	arg_1_0._changeCardFlow = FightViewHandCardSequenceFlow.New()

	arg_1_0._changeCardFlow:addWork(FightCardChangeEffect.New())

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
	arg_4_0:addEventCb(FightController.instance, FightEvent.PlayChangeCardEffect, arg_4_0._playChangeCardEffect, arg_4_0)
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
	arg_4_0:_setBlockOperate(false)
	arg_4_0:_refreshPrecisionShow()
end

function var_0_0.onClose(arg_5_0)
	FightCardModel.instance:setLongPressIndex(-1)
	TaskDispatcher.cancelTask(arg_5_0._delayCancelBlock, arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayPlayCardsChangeEffect, arg_5_0)
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
	arg_5_0._changeCardFlow:stop()
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

function var_0_0._onStageChanged(arg_9_0)
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
	local var_13_0 = FightCardModel.instance:getHandCards()
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
	local var_14_1 = FightCardModel.instance:getHandCards()
	local var_14_2 = var_14_1 and #var_14_1 or 0
	local var_14_3 = math.min(var_14_0, var_14_2)
	local var_14_4 = FightCardModel.instance:getHandCards()
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

		if FightCardModel.instance:tryGettingHandCardsByOps(FightCardModel.instance:getCardOps()) then
			arg_15_0:_updateNow()
		else
			FightCardModel.instance:clearCardOps()
			FightRpc.instance:sendResetRoundRequest()
		end
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
	if FightCardModel.instance:isCardOpEnd() and #FightCardModel.instance:getCardOps() > 0 then
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
	local var_22_0 = FightCardModel.instance:getHandCards()

	FightCardModel.instance:coverCard(var_22_0)
	FightDataHelper.coverData(var_22_0, FightLocalDataMgr.instance.handCardMgr:getHandCard())
	FightDataHelper.coverData(var_22_0, FightDataHelper.handCardMgr:getHandCard())
	arg_22_0:_setBlockOperate(false)
	arg_22_0._cardEndFlow:unregisterDoneListener(arg_22_0._onCardEndFlowDone, arg_22_0)

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	FightRpc.instance:sendBeginRoundRequest(FightCardModel.instance:getCardOps())

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

function var_0_0._startDistributeCards(arg_30_0)
	arg_30_0:_nextDistributeCards()
end

function var_0_0._nextDistributeCards(arg_31_0, arg_31_1)
	arg_31_0._correctHandCardScale:stop()
	arg_31_0._cardDistributeFlow:stop()
	arg_31_0._cardCombineFlow:stop()
	arg_31_0._changeCardFlow:stop()
	arg_31_0._redealCardFlow:stop()
	arg_31_0._magicEffectCardFlow:stop()

	local var_31_0 = FightCardModel.instance:getDistributeQueueLen()

	if var_31_0 > 0 then
		local var_31_1, var_31_2 = FightCardModel.instance:dequeueDistribute()

		if canLogNormal then
			local var_31_3 = {}
			local var_31_4 = {}

			for iter_31_0, iter_31_1 in ipairs(var_31_1) do
				table.insert(var_31_3, iter_31_1.skillId)
			end

			for iter_31_2, iter_31_3 in ipairs(var_31_2) do
				table.insert(var_31_4, iter_31_3.skillId)
			end

			logNormal(string.format("发牌: before(%s) new(%s)", table.concat(var_31_3, ","), table.concat(var_31_4, ",")))
		end

		local var_31_5 = {}

		tabletool.addValues(var_31_5, var_31_1)
		tabletool.addValues(var_31_5, var_31_2)

		local var_31_6 = FightCardCombineEffect.getCardPosXList(arg_31_0._handCardItemList)

		arg_31_0:_updateHandCards(var_31_5)

		local var_31_7 = arg_31_0:getUserDataTb_()

		var_31_7.cards = var_31_5
		var_31_7.handCardItemList = arg_31_0._handCardItemList
		var_31_7.oldPosXList = var_31_6
		var_31_7.preCombineIndex = arg_31_1
		var_31_7.preCardCount = #var_31_1
		var_31_7.newCardCount = #var_31_2
		var_31_7.playCardContainer = gohelper.findChild(arg_31_0.viewGO, "root/playcards")
		var_31_7.isEnd = var_31_0 == 1
		var_31_7.handCardContainer = arg_31_0._handCardContainer

		arg_31_0:_setBlockOperate(true)
		arg_31_0._cardDistributeFlow:registerDoneListener(arg_31_0._onDistributeCards, arg_31_0)
		arg_31_0._cardDistributeFlow:start(var_31_7)
	else
		arg_31_0:_onDistributeCards()
	end
end

function var_0_0._onDistributeCards(arg_32_0)
	arg_32_0._cardDistributeFlow:unregisterDoneListener(arg_32_0._onDistributeCards, arg_32_0)

	local var_32_0 = arg_32_0._cardDistributeFlow.context and arg_32_0._cardDistributeFlow.context.cards or FightCardModel.instance:getHandCards()

	arg_32_0:_combineCards(var_32_0)
end

function var_0_0._toAutoPlayCard(arg_33_0)
	local var_33_0 = FightModel.instance.autoPlayCardList

	if #var_33_0 > 0 then
		arg_33_0._autoPlayCardFlow = FlowSequence.New()

		arg_33_0._autoPlayCardFlow:addWork(FightAutoBindContractWork.New())
		arg_33_0._autoPlayCardFlow:addWork(FightAutoDetectUpgradeWork.New())

		if arg_33_0._cardPlayFlow and arg_33_0._cardPlayFlow.status == WorkStatus.Running then
			arg_33_0._autoPlayCardFlow:addWork(FightAutoPlayCardWork.New())
		end

		local var_33_1 = 0

		for iter_33_0, iter_33_1 in ipairs(var_33_0) do
			if iter_33_1:isAssistBossPlayCard() then
				arg_33_0._autoPlayCardFlow:addWork(WorkWaitSeconds.New(0.3))
				arg_33_0._autoPlayCardFlow:addWork(FightAutoPlayAssistBossCardWork.New(iter_33_1))
			elseif iter_33_1:isSeason2ChangeHero() then
				var_33_1 = var_33_1 + 1

				if var_33_1 == 3 then
					arg_33_0._autoPlayCardFlow:addWork(WorkWaitSeconds.New(0.1))
					arg_33_0._autoPlayCardFlow:addWork(FightWorkAutoSeason2ChangeHero.New(var_33_0, iter_33_0))
				end
			elseif iter_33_1:isPlayerFinisherSkill() then
				arg_33_0._autoPlayCardFlow:addWork(WorkWaitSeconds.New(0.1))
				arg_33_0._autoPlayCardFlow:addWork(FightWorkAutoPlayerFinisherSkill.New(iter_33_1))
			else
				arg_33_0._autoPlayCardFlow:addWork(WorkWaitSeconds.New(0.01))
				arg_33_0._autoPlayCardFlow:addWork(FightAutoPlayCardWork.New(iter_33_1))
			end
		end

		arg_33_0._autoPlayCardFlow:addWork(FightAutoDetectForceEndWork.New())
		arg_33_0._autoPlayCardFlow:registerDoneListener(arg_33_0._onAutoPlayCardFlowDone, arg_33_0)
		arg_33_0._autoPlayCardFlow:start()
	else
		arg_33_0:_onCardEndFlowDone()
		FightViewPartVisible.set()
	end
end

function var_0_0._onForceEndAutoCardFlow(arg_34_0)
	if arg_34_0._autoPlayCardFlow then
		arg_34_0._autoPlayCardFlow:stop()
		arg_34_0:_onCardEndFlowDone()
		FightViewPartVisible.set()
	end
end

function var_0_0._onAutoPlayCardFlowDone(arg_35_0)
	arg_35_0._autoPlayCardFlow:unregisterDoneListener(arg_35_0._onAutoPlayCardFlowDone, arg_35_0)

	arg_35_0._autoPlayCardFlow = nil
end

function var_0_0._playHandCard(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	if FightCardModel.instance:isCardOpEnd() then
		return
	end

	local var_36_0 = FightCardModel.instance:getHandCards()
	local var_36_1 = var_36_0[arg_36_1]

	if not var_36_1 then
		arg_36_0:_updateNow()

		return
	end

	if arg_36_0._cardPlayFlow.status == WorkStatus.Running then
		return
	end

	FightController.instance:dispatchEvent(FightEvent.HideCardSkillTips)
	arg_36_0:_setBlockOperate(true)

	var_36_1.playCanAddExpoint = FightCardDataHelper.playCanAddExpoint(var_36_0, var_36_1)

	local var_36_2 = FightCardModel.instance:playHandCardOp(arg_36_1, arg_36_2, var_36_1.skillId, var_36_1.uid, var_36_1)

	var_36_2.cardColor = FightDataHelper.LYDataMgr:getCardColor(var_36_0, arg_36_1)
	var_36_2.cardInfoMO.areaRedOrBlue = var_36_2.cardColor

	if var_36_1.heatId ~= 0 then
		local var_36_3 = FightDataHelper.teamDataMgr
		local var_36_4 = var_36_1.heatId
		local var_36_5 = var_36_3.myData.cardHeat.values[var_36_4]
		local var_36_6 = var_36_3.myCardHeatOffset[var_36_4] or 0

		var_36_3.myCardHeatOffset[var_36_4] = var_36_6 + var_36_5.changeValue

		FightController.instance:dispatchEvent(FightEvent.RefreshCardHeatShow, var_36_4)
	end

	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, var_36_2)

	local var_36_7

	if FightConfig.instance:isUniqueSkill(var_36_1.skillId) then
		local var_36_8 = FightCardModel.instance:getHandCards()

		while true do
			if #var_36_8 > 0 then
				local var_36_9 = false

				for iter_36_0 = 1, #var_36_8 do
					local var_36_10 = var_36_8[iter_36_0]

					if var_36_10.uid == var_36_1.uid and FightConfig.instance:isUniqueSkill(var_36_10.skillId) then
						var_36_7 = var_36_7 or {}

						table.insert(var_36_7, iter_36_0)
						FightCardModel.instance:simulateDissolveCard(iter_36_0)
						table.remove(var_36_8, iter_36_0)

						break
					end

					if iter_36_0 == #var_36_8 then
						var_36_9 = true
					end
				end

				if var_36_9 then
					break
				end
			else
				break
			end
		end
	end

	local var_36_11 = false

	if FightCardDataHelper.isDiscard(var_36_1) then
		var_36_11 = true
	end

	arg_36_0._cardsForCombines = var_36_0

	local var_36_12 = arg_36_0:getUserDataTb_()

	var_36_12.view = arg_36_0
	var_36_12.cards = var_36_0
	var_36_12.from = arg_36_1
	var_36_12.viewGO = arg_36_0.viewGO
	var_36_12.handCardTr = arg_36_0._handCardTr
	var_36_12.handCardItemList = arg_36_0._handCardItemList
	var_36_12.fightBeginRoundOp = var_36_2
	var_36_12.dissolveCardIndexsAfterPlay = var_36_7
	var_36_12.needDiscard = var_36_11
	var_36_12.param2 = arg_36_3

	arg_36_0._cardPlayFlow:registerDoneListener(arg_36_0._onPlayCardDone, arg_36_0)
	arg_36_0._cardPlayFlow:start(var_36_12)
	arg_36_0:_playCardAudio(var_36_1)
end

function var_0_0._playCardAudio(arg_37_0, arg_37_1)
	if FightReplayModel.instance:isReplay() then
		return
	end

	local var_37_0 = FightHelper.getEntity(arg_37_1.uid)
	local var_37_1 = var_37_0 and var_37_0:getMO()

	if not var_37_1 then
		return
	end

	if FightEntityDataHelper.isPlayerUid(var_37_1.id) then
		return
	end

	local var_37_2 = FightCardModel.instance:getCardOps()
	local var_37_3 = FightBuffHelper.simulateBuffList(var_37_1, var_37_2[#var_37_2])

	if not FightViewHandCardItemLock.canUseCardSkill(arg_37_1.uid, arg_37_1.skillId, var_37_3) then
		return
	end

	local var_37_4 = FightCardModel.instance:getSkillLv(arg_37_1.uid, arg_37_1.skillId)
	local var_37_5 = var_37_1.modelId
	local var_37_6 = HeroConfig.instance:getHeroCO(var_37_5)
	local var_37_7

	if var_37_4 == 1 or var_37_4 == 2 then
		var_37_7 = FightAudioMgr.instance:getHeroVoiceRandom(var_37_5, CharacterEnum.VoiceType.FightCardStar12, arg_37_1.uid)
	elseif var_37_4 == 3 then
		var_37_7 = FightAudioMgr.instance:getHeroVoiceRandom(var_37_5, CharacterEnum.VoiceType.FightCardStar3, arg_37_1.uid)

		if not var_37_7 then
			if var_37_6 and var_37_6.rare >= 4 then
				var_37_7 = FightAudioMgr.instance:getHeroVoiceRandom(var_37_5, CharacterEnum.VoiceType.FightCardStar3, arg_37_1.uid)
			else
				var_37_7 = FightAudioMgr.instance:getHeroVoiceRandom(var_37_5, CharacterEnum.VoiceType.FightCardStar12, arg_37_1.uid)
			end
		end
	elseif var_37_4 == FightEnum.UniqueSkillCardLv then
		var_37_7 = FightAudioMgr.instance:getHeroVoiceRandom(var_37_5, CharacterEnum.VoiceType.FightCardUnique, arg_37_1.uid)
	end

	if var_37_7 then
		FightAudioMgr.instance:playCardAudio(arg_37_1.uid, var_37_7, var_37_5)
	end
end

function var_0_0._onPlayCardDone(arg_38_0, arg_38_1)
	arg_38_0._cardPlayFlow:unregisterDoneListener(arg_38_0._onPlayCardDone, arg_38_0)

	local var_38_0 = arg_38_0._cardPlayFlow.context.cards or FightCardModel.instance:getHandCards()

	arg_38_0:_updateHandCards(var_38_0)
	FightController.instance:dispatchEvent(FightEvent.OnPlayCardFlowDone, arg_38_0._cardPlayFlow.context.fightBeginRoundOp)
	FightController.instance:dispatchEvent(FightEvent.PlayCardOver)
	arg_38_0:_detectPlayPrecisionEffect()

	if FightCardModel.instance:isCardOpEnd() then
		arg_38_0:_setBlockOperate(true)

		return
	end
end

function var_0_0._playRedealCardEffect(arg_39_0, arg_39_1, arg_39_2, arg_39_3)
	arg_39_0._canCombineAfterRedealCards = arg_39_3

	local var_39_0 = arg_39_0:getUserDataTb_()

	var_39_0.oldCards = arg_39_1
	var_39_0.newCards = arg_39_2
	var_39_0.handCardItemList = arg_39_0._handCardItemList

	if #arg_39_2 > #arg_39_0._handCardItemList then
		arg_39_0:_updateHandCards(arg_39_1)
	end

	for iter_39_0, iter_39_1 in ipairs(arg_39_0._handCardItemList) do
		iter_39_1:refreshCardMO(iter_39_0, arg_39_2[iter_39_0])
	end

	arg_39_0:beforeRedealCardFlow()
	arg_39_0._redealCardFlow:registerDoneListener(arg_39_0._onRedealCardDone, arg_39_0)
	arg_39_0._redealCardFlow:start(var_39_0)
end

function var_0_0.beforeRedealCardFlow(arg_40_0)
	for iter_40_0, iter_40_1 in ipairs(arg_40_0._handCardItemList) do
		iter_40_1:playASFDAnim("close")
	end
end

function var_0_0.afterRedealCardFlow(arg_41_0)
	for iter_41_0, iter_41_1 in ipairs(arg_41_0._handCardItemList) do
		iter_41_1:playASFDAnim("open")
	end
end

function var_0_0._onRedealCardDone(arg_42_0)
	arg_42_0._redealCardFlow:unregisterDoneListener(arg_42_0._onRedealCardDone, arg_42_0)
	arg_42_0:afterRedealCardFlow()
	arg_42_0:_updateNow()

	if arg_42_0._canCombineAfterRedealCards then
		local var_42_0 = FightCardModel.instance:getHandCards()

		arg_42_0:_combineCards(var_42_0)
	end
end

function var_0_0._playChangeCardEffect(arg_43_0, arg_43_1)
	local var_43_0 = FightCardModel.instance:getHandCards()

	for iter_43_0 = #arg_43_1, 1, -1 do
		if arg_43_1[iter_43_0].cardIndex > #var_43_0 then
			table.remove(arg_43_1, iter_43_0)
		end
	end

	arg_43_0._changeInfos = arg_43_0._changeInfos or {}

	tabletool.addValues(arg_43_0._changeInfos, arg_43_1)
	FightCardModel.instance:setChanging(true)
	TaskDispatcher.cancelTask(arg_43_0._delayPlayCardsChangeEffect, arg_43_0)
	TaskDispatcher.runDelay(arg_43_0._delayPlayCardsChangeEffect, arg_43_0, 0.03)
end

function var_0_0._delayPlayCardsChangeEffect(arg_44_0)
	if arg_44_0._changeCardFlow.status ~= WorkStatus.Running then
		local var_44_0 = arg_44_0:getUserDataTb_()

		var_44_0.changeInfos = arg_44_0._changeInfos
		arg_44_0._changeInfos = nil
		var_44_0.handCardItemList = arg_44_0._handCardItemList

		arg_44_0:_setBlockOperate(true)
		arg_44_0:addEventCb(FightController.instance, FightEvent.OnCombineCardEnd, arg_44_0._onChangeCombineDone, arg_44_0)
		arg_44_0._changeCardFlow:registerDoneListener(arg_44_0._onChangeCardDone, arg_44_0)
		arg_44_0._changeCardFlow:start(var_44_0)
	end
end

function var_0_0._setCardMagicEffectChange(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
	arg_45_0._card_magic_effect_change_info = arg_45_0._card_magic_effect_change_info or {}
	arg_45_0._card_magic_effect_change_info[arg_45_1] = {
		old_effect = arg_45_2,
		new_effect = arg_45_3
	}
end

function var_0_0._playCardMagicEffectChange(arg_46_0)
	local var_46_0 = arg_46_0:getUserDataTb_()

	var_46_0.changeInfos = arg_46_0._card_magic_effect_change_info
	var_46_0.handCardItemList = arg_46_0._handCardItemList
	arg_46_0._card_magic_effect_change_info = nil

	arg_46_0:_setBlockOperate(true)
	arg_46_0._magicEffectCardFlow:registerDoneListener(arg_46_0._onMagicEffectCardFlowDone, arg_46_0)
	arg_46_0._magicEffectCardFlow:start(var_46_0)
end

function var_0_0._onMagicEffectCardFlowDone(arg_47_0)
	arg_47_0._magicEffectCardFlow:unregisterDoneListener(arg_47_0._onMagicEffectCardFlowDone, arg_47_0)

	local var_47_0 = FightCardModel.instance:getHandCards()

	arg_47_0:_combineCards(var_47_0)
end

function var_0_0._onChangeCardDone(arg_48_0)
	arg_48_0._changeCardFlow:unregisterDoneListener(arg_48_0._onChangeCardDone, arg_48_0)
	arg_48_0:_onChangeOrRedealCardDone(arg_48_0._changeCardFlow.context.changeInfos)
end

function var_0_0._onChangeOrRedealCardDone(arg_49_0, arg_49_1)
	if arg_49_1 then
		local var_49_0 = FightCardModel.instance:getHandCards()
		local var_49_1 = arg_49_0:_filterInvalidCard(var_49_0)

		for iter_49_0, iter_49_1 in ipairs(arg_49_1) do
			local var_49_2 = iter_49_1.cardIndex
			local var_49_3 = iter_49_1.cardInfo
			local var_49_4 = var_49_1[var_49_2]

			if var_49_4 then
				if var_49_3 then
					var_49_4:init(var_49_3)
				else
					var_49_4.uid = iter_49_1.entityId
					var_49_4.skillId = iter_49_1.targetSkillId
				end
			else
				local var_49_5 = string.format("更换当前手牌中的第%d张牌的数据,但是并没有找到这张牌", var_49_2)

				logError(var_49_5)
			end
		end

		FightCardModel.instance:clearCardOps()
		FightCardModel.instance:coverCard(var_49_1)
		arg_49_0:_updateNow()
		arg_49_0:_combineCards(var_49_1)
	end
end

function var_0_0._onRedealCombineDone(arg_50_0, arg_50_1)
	FightCardModel.instance:clearCardOps()
	FightCardModel.instance:coverCard(arg_50_1)
	arg_50_0:removeEventCb(FightController.instance, FightEvent.OnCombineCardEnd, arg_50_0._onRedealCombineDone, arg_50_0)
	FightController.instance:dispatchEvent(FightEvent.OnChangeCardEffectDone)
	arg_50_0:_setBlockOperate(false)
end

function var_0_0._onChangeCombineDone(arg_51_0, arg_51_1)
	FightCardModel.instance:clearCardOps()
	FightCardModel.instance:coverCard(arg_51_1)
	arg_51_0:removeEventCb(FightController.instance, FightEvent.OnCombineCardEnd, arg_51_0._onChangeCombineDone, arg_51_0)

	if arg_51_0._changeInfos and #arg_51_0._changeInfos > 0 then
		TaskDispatcher.cancelTask(arg_51_0._delayPlayCardsChangeEffect, arg_51_0)
		TaskDispatcher.runDelay(arg_51_0._delayPlayCardsChangeEffect, arg_51_0, 0.03)
	else
		FightCardModel.instance:setChanging(false)
		FightController.instance:dispatchEvent(FightEvent.OnChangeCardEffectDone)
		arg_51_0:_setBlockOperate(false)
	end
end

function var_0_0._playUniversalAppear(arg_52_0, arg_52_1)
	arg_52_0:_setBlockOperate(true)

	local var_52_0 = FightCardModel.instance:getHandCards()

	table.insert(var_52_0, arg_52_1)
	FightCardModel.instance:coverCard(var_52_0)
	arg_52_0:_updateNow()

	local var_52_1 = arg_52_0:getUserDataTb_()

	var_52_1.handCardItemList = arg_52_0._handCardItemList

	arg_52_0._universalAppearFlow:start(var_52_1)
	arg_52_0._universalAppearFlow:registerDoneListener(arg_52_0._onUniversalAppearDone, arg_52_0)
end

function var_0_0._onSpCardAdd(arg_53_0, arg_53_1)
	arg_53_0:_playCorrectHandCardScale(0)

	local var_53_0 = FightCardModel.instance:getHandCards()

	arg_53_0:_updateHandCards(var_53_0, arg_53_1)

	local var_53_1 = arg_53_0._handCardItemList[arg_53_1]

	gohelper.setActive(var_53_1.go, false)
	var_53_1:playCardAni(ViewAnim.FightCardBalance)
end

function var_0_0._onCorrectHandCardScale(arg_54_0, arg_54_1)
	arg_54_0:_playCorrectHandCardScale(arg_54_1)
end

function var_0_0._playCorrectHandCardScale(arg_55_0, arg_55_1, arg_55_2)
	arg_55_0._correctHandCardScale:stop()

	local var_55_0 = arg_55_0:getUserDataTb_()

	var_55_0.cards = tabletool.copy(FightCardModel.instance:getHandCards())
	var_55_0.oldScale = arg_55_1
	var_55_0.newScale = arg_55_2
	var_55_0.handCardContainer = arg_55_0._handCardContainer

	arg_55_0._correctHandCardScale:start(var_55_0)
end

function var_0_0._onCardsCompose(arg_56_0)
	local var_56_0 = FightCardModel.instance:getHandCards()

	arg_56_0:_combineCards(var_56_0)
end

function var_0_0._onCardsComposeTimeOut(arg_57_0)
	if arg_57_0._cardCombineFlow then
		arg_57_0._cardCombineFlow:stop()
	end

	arg_57_0:_updateNow()
end

function var_0_0._onRemoveEntityCards(arg_58_0, arg_58_1)
	for iter_58_0 = #arg_58_0._handCardItemList, 1, -1 do
		local var_58_0 = arg_58_0._handCardItemList[iter_58_0]

		if var_58_0.go.activeInHierarchy and var_58_0:dissolveEntityCard(arg_58_1) then
			table.insert(arg_58_0._handCardItemList, table.remove(arg_58_0._handCardItemList, iter_58_0))
		end
	end

	TaskDispatcher.cancelTask(arg_58_0._correctActiveCardObjPos, arg_58_0)
	TaskDispatcher.runDelay(arg_58_0._correctActiveCardObjPos, arg_58_0, 1 / FightModel.instance:getUISpeed())
end

function var_0_0._onCardLevelChange(arg_59_0, arg_59_1, arg_59_2, arg_59_3, arg_59_4)
	local var_59_0 = arg_59_0._handCardItemList[arg_59_2]

	if var_59_0 then
		var_59_0:playCardLevelChange(arg_59_1, arg_59_3)
	end

	if arg_59_4 then
		TaskDispatcher.cancelTask(arg_59_0._combineAfterCardLevelChange, arg_59_0)
		TaskDispatcher.runDelay(arg_59_0._combineAfterCardLevelChange, arg_59_0, FightEnum.PerformanceTime.CardLevelChange / FightModel.instance:getUISpeed())
	end
end

function var_0_0._combineAfterCardLevelChange(arg_60_0)
	local var_60_0 = FightCardModel.instance:getHandCards()

	arg_60_0:_combineCards(var_60_0)
end

function var_0_0._onPlayCombineCards(arg_61_0, arg_61_1)
	arg_61_0:_combineCards(arg_61_1)
end

function var_0_0._onCardRemove(arg_62_0, arg_62_1, arg_62_2, arg_62_3)
	arg_62_0:_onCardRemove2(arg_62_1)

	if arg_62_3 then
		TaskDispatcher.cancelTask(arg_62_0._combineAfterCardRemove, arg_62_0)
		TaskDispatcher.runDelay(arg_62_0._combineAfterCardRemove, arg_62_0, arg_62_2 / FightModel.instance:getUISpeed())
	end
end

function var_0_0._combineAfterCardRemove(arg_63_0)
	local var_63_0 = FightCardModel.instance:getHandCards()

	arg_63_0:_combineCards(var_63_0)
end

function var_0_0._onCardRemove2(arg_64_0, arg_64_1)
	for iter_64_0, iter_64_1 in ipairs(arg_64_1) do
		local var_64_0 = table.remove(arg_64_0._handCardItemList, iter_64_1)

		if var_64_0 and var_64_0.go.activeInHierarchy then
			var_64_0:dissolveCard()
			table.insert(arg_64_0._handCardItemList, var_64_0)
		end
	end

	TaskDispatcher.cancelTask(arg_64_0._correctActiveCardObjPos, arg_64_0)
	TaskDispatcher.runDelay(arg_64_0._correctActiveCardObjPos, arg_64_0, 1 / FightModel.instance:getUISpeed())
end

function var_0_0._correctActiveCardObjPos(arg_65_0)
	local var_65_0 = 0

	for iter_65_0 = 1, #arg_65_0._handCardItemList do
		local var_65_1 = arg_65_0._handCardItemList[iter_65_0]

		var_65_1.index = iter_65_0
		var_65_1.go.name = "cardItem" .. iter_65_0

		local var_65_2 = var_65_1.go

		if not var_65_2.activeInHierarchy then
			break
		end

		local var_65_3 = recthelper.getAnchorX(var_65_2.transform)
		local var_65_4 = var_0_0.calcCardPosX(iter_65_0)

		if math.abs(var_65_3 - var_65_4) >= 10 then
			var_65_1:moveSelfPos(iter_65_0, var_65_0, var_65_4)

			var_65_0 = var_65_0 + 1
		end
	end
end

function var_0_0._onAddHandCard(arg_66_0, arg_66_1, arg_66_2)
	arg_66_0:_playCorrectHandCardScale(0)

	local var_66_0 = FightCardModel.instance:getHandCards()
	local var_66_1 = #var_66_0

	arg_66_0:_updateHandCards(var_66_0, var_66_1)
	arg_66_0._handCardItemList[var_66_1]:playDistribute()

	if arg_66_2 then
		TaskDispatcher.runDelay(arg_66_0._combineCardsAfterAddHandCard, arg_66_0, 0.5 / FightModel.instance:getUISpeed())
	end
end

function var_0_0._onMasterAddHandCard(arg_67_0, arg_67_1, arg_67_2)
	arg_67_0:_playCorrectHandCardScale(0)

	local var_67_0 = FightCardModel.instance:getHandCards()
	local var_67_1 = #var_67_0

	arg_67_0:_updateHandCards(var_67_0, var_67_1)
	arg_67_0._handCardItemList[var_67_1]:playMasterAddHandCard()

	if arg_67_2 then
		TaskDispatcher.runDelay(arg_67_0._combineCardsAfterAddHandCard, arg_67_0, 1 / FightModel.instance:getUISpeed())
	end
end

function var_0_0._onMasterCardRemove(arg_68_0, arg_68_1, arg_68_2, arg_68_3)
	for iter_68_0, iter_68_1 in ipairs(arg_68_1) do
		local var_68_0 = table.remove(arg_68_0._handCardItemList, iter_68_1)

		if var_68_0 and var_68_0.go.activeInHierarchy then
			var_68_0:playMasterCardRemove()
			table.insert(arg_68_0._handCardItemList, var_68_0)
		end
	end

	TaskDispatcher.cancelTask(arg_68_0._correctActiveCardObjPos, arg_68_0)
	TaskDispatcher.runDelay(arg_68_0._correctActiveCardObjPos, arg_68_0, 0.7 / FightModel.instance:getUISpeed())

	if arg_68_3 then
		TaskDispatcher.cancelTask(arg_68_0._combineAfterCardRemove, arg_68_0)
		TaskDispatcher.runDelay(arg_68_0._combineAfterCardRemove, arg_68_0, arg_68_2 / FightModel.instance:getUISpeed())
	end
end

function var_0_0._combineCardsAfterAddHandCard(arg_69_0)
	local var_69_0 = FightCardModel.instance:getHandCards()

	arg_69_0:_combineCards(var_69_0)
end

function var_0_0._onCardAConvertCardB(arg_70_0, arg_70_1)
	local var_70_0 = FightCardModel.instance:getHandCards()
	local var_70_1 = arg_70_0._handCardItemList[arg_70_1]

	if var_70_1 then
		var_70_1:playCardAConvertCardB()
		var_70_1:updateItem(arg_70_1, var_70_0[arg_70_1])
	else
		arg_70_0:_updateNow()
	end
end

function var_0_0._onTempCardRemove(arg_71_0)
	arg_71_0:_updateNow()

	local var_71_0 = FightCardModel.instance:getHandCards()

	arg_71_0:_combineCards(var_71_0)
end

function var_0_0._onChangeToTempCard(arg_72_0, arg_72_1)
	local var_72_0 = arg_72_0._handCardItemList[arg_72_1]

	if var_72_0 then
		var_72_0:changeToTempCard()
	end
end

function var_0_0._onUniversalAppearDone(arg_73_0)
	arg_73_0._universalAppearFlow:unregisterDoneListener(arg_73_0._onUniversalAppearDone, arg_73_0)
	arg_73_0:_setBlockOperate(false)
	FightController.instance:dispatchEvent(FightEvent.OnUniversalAppear)
end

function var_0_0._combineCards(arg_74_0, arg_74_1, arg_74_2, arg_74_3)
	arg_74_0._combineIndex = arg_74_2 or FightCardModel.getCombineIndexOnce(arg_74_1)
	arg_74_0._isUniversalCombine = arg_74_2 and true or false

	if arg_74_0._combineIndex then
		arg_74_0._cardsForCombines = arg_74_1

		local var_74_0 = arg_74_0:getUserDataTb_()

		var_74_0.cards = arg_74_1
		var_74_0.combineIndex = arg_74_0._combineIndex
		var_74_0.handCardItemList = arg_74_0._handCardItemList
		var_74_0.fightBeginRoundOp = arg_74_3

		arg_74_0._cardCombineFlow:registerDoneListener(arg_74_0._onCombineCardDone, arg_74_0)
		arg_74_0._cardCombineFlow:start(var_74_0)
	else
		arg_74_0:_setBlockOperate(false)
		FightCardModel.instance:setDissolving(false)
		FightController.instance:dispatchEvent(FightEvent.OnCombineCardEnd, arg_74_1)

		local var_74_1 = FightModel.instance:getCurStage()

		if var_74_1 == FightEnum.Stage.Distribute or var_74_1 == FightEnum.Stage.FillCard then
			if FightCardModel.instance:getDistributeQueueLen() > 0 then
				arg_74_0:_nextDistributeCards(#arg_74_1)
			else
				gohelper.destroy(gohelper.findChild(arg_74_0._handCardGO, "CombineEffect"))

				local var_74_2 = {}

				for iter_74_0, iter_74_1 in ipairs(arg_74_1) do
					table.insert(var_74_2, iter_74_1.skillId)
				end

				if var_74_1 == FightEnum.Stage.Distribute then
					logNormal("发牌结果" .. table.concat(var_74_2, ","))
				else
					logNormal("补牌结果" .. table.concat(var_74_2, ","))
				end

				FightCardModel.instance:clearCardOps()
				FightCardModel.instance:coverCard(arg_74_1)
				arg_74_0:_updateNow()
				FightController.instance:dispatchEvent(FightEvent.OnDistributeCards)
			end
		elseif var_74_1 == FightEnum.Stage.AutoCard and arg_74_0._autoPlayCardFlow and arg_74_0._autoPlayCardFlow.status == WorkStatus.Running then
			FightController.instance:dispatchEvent(FightEvent.OneAutoPlayCardFinish)
		end

		if arg_74_3 then
			FightController.instance:dispatchEvent(FightEvent.PlayOperationEffectDone, arg_74_3)
			arg_74_0:_detectPlayPrecisionEffect()
		end
	end
end

function var_0_0._onCombineCardDone(arg_75_0, arg_75_1)
	arg_75_0._cardCombineFlow:unregisterDoneListener(arg_75_0._onCombineCardDone, arg_75_0)

	local var_75_0 = arg_75_0._cardsForCombines[arg_75_0._combineIndex]

	FightController.instance:dispatchEvent(FightEvent.OnCombineOneCard, var_75_0, arg_75_0._isUniversalCombine)
	arg_75_0:_combineCards(arg_75_0._cardsForCombines, nil, arg_75_0._cardCombineFlow.context.fightBeginRoundOp)
end

function var_0_0._resetCard(arg_76_0, arg_76_1)
	FightCardModel.instance:resetCardOps()
	FightDataHelper.paTaMgr:resetOp()
	FightController.instance:dispatchEvent(FightEvent.OnResetCard, arg_76_1)

	if arg_76_0._cardPlayFlow.status == WorkStatus.Running then
		arg_76_0._cardPlayFlow:stop()
	end
end

function var_0_0._updateNow(arg_77_0)
	arg_77_0:_updateHandCards(FightCardModel.instance:getHandCards())
end

function var_0_0._filterInvalidCard(arg_78_0, arg_78_1)
	for iter_78_0 = #arg_78_1, 1, -1 do
		local var_78_0 = arg_78_1[iter_78_0].skillId

		if not lua_skill.configDict[var_78_0] then
			if not var_78_0 then
				logError("手牌数据没有skillId,请保存复现数据找开发看看")
			else
				logError("技能表找不到id:" .. var_78_0)
			end

			table.remove(arg_78_1, iter_78_0)
		end
	end

	return arg_78_1
end

function var_0_0._updateHandCards(arg_79_0, arg_79_1, arg_79_2)
	arg_79_1 = arg_79_0:_filterInvalidCard(arg_79_1)

	local var_79_0 = arg_79_1 and #arg_79_1 or 0

	for iter_79_0 = arg_79_2 or 1, var_79_0 do
		local var_79_1 = arg_79_0._handCardItemList[iter_79_0]

		if not var_79_1 then
			local var_79_2 = gohelper.clone(arg_79_0._handCardItemPrefab, arg_79_0._handCardGO)

			var_79_1 = MonoHelper.addLuaComOnceToGo(var_79_2, FightViewHandCardItem, arg_79_0)

			table.insert(arg_79_0._handCardItemList, var_79_1)
		end

		var_79_1.go.name = "cardItem" .. iter_79_0

		local var_79_3 = var_0_0.calcCardPosX(iter_79_0)

		recthelper.setAnchor(var_79_1.tr, var_79_3, 0)
		gohelper.setActive(var_79_1.go, true)
		transformhelper.setLocalScale(var_79_1.tr, 1, 1, 1)
		var_79_1:updateItem(iter_79_0, arg_79_1[iter_79_0])
		gohelper.setAsLastSibling(var_79_1.go)
	end

	for iter_79_1 = var_79_0 + 1, #arg_79_0._handCardItemList do
		local var_79_4 = arg_79_0._handCardItemList[iter_79_1]

		gohelper.setActive(var_79_4.go, false)

		var_79_4.go.name = "cardItem" .. iter_79_1

		var_79_4:updateItem(iter_79_1, nil)
	end

	arg_79_0:refreshPreDeleteCard(arg_79_1)
	arg_79_0:refreshLyCardTag()
end

function var_0_0._setBlockOperate(arg_80_0, arg_80_1)
	var_0_0.blockOperate = arg_80_1 and true or false

	if not gohelper.isNil(arg_80_0._handCardGOCanvasGroup) then
		arg_80_0._handCardGOCanvasGroup.blocksRaycasts = not arg_80_1
	end

	if arg_80_1 then
		TaskDispatcher.cancelTask(arg_80_0._delayCancelBlock, arg_80_0)
		TaskDispatcher.runDelay(arg_80_0._delayCancelBlock, arg_80_0, 10)
	else
		TaskDispatcher.cancelTask(arg_80_0._delayCancelBlock, arg_80_0)
	end

	arg_80_0:refreshLYAreaActive()
end

function var_0_0._delayCancelBlock(arg_81_0)
	arg_81_0:_setBlockOperate(false)
end

function var_0_0._onAfterForceUpdatePerformanceData(arg_82_0)
	arg_82_0:_updateNow()
end

function var_0_0._onRoundSequenceFinish(arg_83_0)
	arg_83_0:_updateNow()
end

function var_0_0._onClothSkillRoundSequenceFinish(arg_84_0)
	return
end

function var_0_0._onDragHandCardBegin(arg_85_0, arg_85_1, arg_85_2)
	if arg_85_0._cardDragFlow.status == WorkStatus.Running then
		return
	end

	if arg_85_0._cardLongPressFlow.status == WorkStatus.Running then
		arg_85_0._cardLongPressFlow:stop()
		arg_85_0._cardLongPressFlow:reset()
	end

	arg_85_0._dragBeginCards = FightCardModel.instance:getHandCards()
	arg_85_0._cardCount = #arg_85_0._dragBeginCards

	if arg_85_1 > arg_85_0._cardCount then
		return
	end

	local var_85_0 = arg_85_0:getUserDataTb_()

	var_85_0.index = arg_85_1
	var_85_0.position = arg_85_2
	var_85_0.cardCount = arg_85_0._cardCount
	var_85_0.handCardItemList = arg_85_0._handCardItemList
	var_85_0.handCardTr = arg_85_0._handCardTr
	var_85_0.handCards = arg_85_0._dragBeginCards

	arg_85_0._cardDragFlow:start(var_85_0)
	arg_85_0._handCardItemList[arg_85_1]:stopLongPressEffect()
	FightController.instance:dispatchEvent(FightEvent.HideCardSkillTips)
end

function var_0_0._onDragHandCardEnd(arg_86_0, arg_86_1, arg_86_2)
	if arg_86_1 > arg_86_0._cardCount then
		arg_86_0:_updateNow()

		return
	end

	arg_86_0._cardDragFlow:stop()
	arg_86_0._cardDragFlow:reset()

	arg_86_0._dragIndex = arg_86_1

	local var_86_0 = recthelper.screenPosToAnchorPos(arg_86_2, arg_86_0._handCardTr)
	local var_86_1, var_86_2, var_86_3 = transformhelper.getLocalScale(arg_86_0._handCardItemList[arg_86_1].tr)
	local var_86_4 = var_86_0.x - var_0_0.HalfWidth

	arg_86_0._targetIndex = var_0_0.calcCardIndexDraging(var_86_4, arg_86_0._cardCount, 1)

	local var_86_5 = arg_86_0:getUserDataTb_()

	var_86_5.index = arg_86_1
	var_86_5.targetIndex = arg_86_0._targetIndex
	var_86_5.cardCount = arg_86_0._cardCount
	var_86_5.handCardItemList = arg_86_0._handCardItemList
	var_86_5.handCardTr = arg_86_0._handCardTr
	var_86_5.handCards = arg_86_0._dragBeginCards

	arg_86_0._cardDragEndFlow:registerDoneListener(arg_86_0._onDragEndFlowDone, arg_86_0)
	arg_86_0._cardDragEndFlow:start(var_86_5)
	arg_86_0:_setBlockOperate(true)
end

function var_0_0._onDragEndFlowDone(arg_87_0)
	arg_87_0._cardDragEndFlow:unregisterDoneListener(arg_87_0._onDragEndFlowDone, arg_87_0)

	local var_87_0 = arg_87_0._dragIndex
	local var_87_1 = arg_87_0._targetIndex

	if not arg_87_0:_checkGuideMoveCard(var_87_0, var_87_1) then
		return
	end

	local var_87_2 = arg_87_0._dragBeginCards

	var_87_2[var_87_0].moveCanAddExpoint = FightCardDataHelper.moveCanAddExpoint(var_87_2, var_87_2[var_87_0])

	local var_87_3 = FightCardModel.instance:getBeCombineCardMO()
	local var_87_4 = var_87_2[var_87_0].skillId

	if FightEnum.UniversalCard[var_87_4] and not var_87_3 then
		arg_87_0:_updateNow()
		arg_87_0:_setBlockOperate(false)

		return
	end

	if (var_87_2[var_87_0].uid == FightEntityScene.MySideId or var_87_2[var_87_0].uid == FightEntityScene.EnemySideId) and not FightEnum.UniversalCard[var_87_4] then
		arg_87_0:_updateNow()
		arg_87_0:_setBlockOperate(false)

		return
	end

	arg_87_0:_moveCardItemInList(var_87_0, var_87_1)

	if not FightCardModel.instance:isCardOpEnd() then
		local var_87_5
		local var_87_6 = var_87_2[var_87_0]
		local var_87_7 = tabletool.indexOf(var_87_2, var_87_3)
		local var_87_8 = var_87_7

		if var_87_3 and var_87_7 then
			if var_87_1 < var_87_7 then
				var_87_8 = var_87_1
			end

			var_87_5 = FightCardModel.instance:moveUniversalCardOp(var_87_0, var_87_7, var_87_6.skillId, var_87_6.uid, var_87_1)
		else
			var_87_5 = FightCardModel.instance:moveHandCardOp(var_87_0, var_87_1, var_87_6.skillId, var_87_6.uid)
		end

		FightCardModel.moveOnly(var_87_2, var_87_0, var_87_1)

		if var_87_0 ~= var_87_1 then
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_FightMoveCardEnd)
		end

		arg_87_0:_updateHandCards(var_87_2)
		FightController.instance:dispatchEvent(FightEvent.OnMoveHandCard, var_87_6, var_87_0, var_87_1)
		FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, var_87_5)
		arg_87_0:_combineCards(var_87_2, var_87_8, var_87_5)
	else
		arg_87_0:_updateHandCards(var_87_2)

		if not FightReplayModel.instance:isReplay() then
			-- block empty
		end

		arg_87_0:_setBlockOperate(false)
	end
end

function var_0_0._moveCardItemInList(arg_88_0, arg_88_1, arg_88_2)
	if not arg_88_0._handCardItemList or not arg_88_0._handCardItemList[arg_88_1] or not arg_88_0._handCardItemList[arg_88_2] then
		return
	end

	if arg_88_1 == arg_88_2 then
		return
	end

	local var_88_0 = arg_88_0._handCardItemList[arg_88_1]
	local var_88_1 = arg_88_1 < arg_88_2 and 1 or -1

	for iter_88_0 = arg_88_1, arg_88_2 - var_88_1, var_88_1 do
		arg_88_0._handCardItemList[iter_88_0] = arg_88_0._handCardItemList[iter_88_0 + var_88_1]
	end

	arg_88_0._handCardItemList[arg_88_2] = var_88_0
end

function var_0_0._playCardItemInList(arg_89_0, arg_89_1)
	if not arg_89_0._handCardItemList or not arg_89_0._handCardItemList[arg_89_1] then
		return
	end

	arg_89_0:_moveCardItemInList(arg_89_1, #arg_89_0._handCardItemList)
end

function var_0_0._checkGuideMoveCard(arg_90_0, arg_90_1, arg_90_2)
	local var_90_0 = GuideModel.instance:getFlagValue(GuideModel.GuideFlag.FightMoveCard)

	if var_90_0 then
		local var_90_1 = arg_90_1 == var_90_0.from

		if var_90_1 then
			local var_90_2 = false
			local var_90_3 = var_90_0.tos

			for iter_90_0, iter_90_1 in ipairs(var_90_3) do
				if arg_90_2 == iter_90_1 then
					var_90_2 = true

					break
				end
			end

			var_90_1 = var_90_2
		end

		if var_90_1 then
			FightController.instance:dispatchEvent(FightEvent.OnGuideDragCard)

			return true
		else
			arg_90_0:_resetCard({})
			arg_90_0:_setBlockOperate(false)

			return false
		end
	end

	return true
end

function var_0_0.selectLeftCard(arg_91_0)
	if arg_91_0._longPressIndex == nil then
		local var_91_0 = 1

		for iter_91_0, iter_91_1 in pairs(arg_91_0._handCardItemList) do
			if iter_91_1.go.activeInHierarchy and var_91_0 < iter_91_1.index then
				var_91_0 = iter_91_1.index
			end
		end

		arg_91_0:OnkeyLongPress(var_91_0)
	else
		if arg_91_0._longPressIndex + 1 > #arg_91_0._handCardItemList then
			return
		end

		local var_91_1 = arg_91_0._handCardItemList[arg_91_0._longPressIndex + 1]

		if var_91_1 and not var_91_1.go.activeInHierarchy then
			return
		end

		arg_91_0:OnkeyLongPress(arg_91_0._longPressIndex + 1)
	end
end

function var_0_0.selectRightCard(arg_92_0)
	if arg_92_0._longPressIndex == nil then
		local var_92_0 = 1

		for iter_92_0, iter_92_1 in pairs(arg_92_0._handCardItemList) do
			if iter_92_1.go.activeInHierarchy and var_92_0 > iter_92_1.index then
				var_92_0 = iter_92_1.index
			end
		end

		arg_92_0:OnkeyLongPress(var_92_0)
	else
		if arg_92_0._longPressIndex - 1 < 1 then
			return
		end

		arg_92_0:OnkeyLongPress(arg_92_0._longPressIndex - 1)
	end
end

function var_0_0.OnKeyPlayCard(arg_93_0, arg_93_1)
	if ViewMgr.instance:IsPopUpViewOpen() then
		return
	end

	arg_93_0:_longPressHandCardEnd()

	local var_93_0 = #FightCardModel.instance:getHandCards()

	for iter_93_0, iter_93_1 in pairs(arg_93_0._handCardItemList) do
		if iter_93_1.index == var_93_0 - arg_93_1 + 1 and iter_93_1.go.activeInHierarchy then
			iter_93_1:_onClickThis()
		end
	end
end

function var_0_0.OnkeyLongPress(arg_94_0, arg_94_1)
	if FightReplayModel.instance:isReplay() then
		return
	end

	arg_94_0:_longPressHandCardEnd()
	FightController.instance:dispatchEvent(FightEvent.HideCardSkillTips)

	for iter_94_0, iter_94_1 in pairs(arg_94_0._handCardItemList) do
		if iter_94_1.index == arg_94_1 and iter_94_1.go.activeInHierarchy then
			iter_94_1:_onLongPress()
		end
	end
end

function var_0_0.onControlRelease(arg_95_0)
	if not arg_95_0._longPressIndex then
		return
	end

	for iter_95_0, iter_95_1 in pairs(arg_95_0._handCardItemList) do
		if iter_95_1 and iter_95_1.index == arg_95_0._longPressIndex then
			iter_95_1:_onClickThis()
		end
	end
end

function var_0_0.OnSeleCardMoveEnd(arg_96_0)
	arg_96_0._keyDrag = false

	FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCardEnd, arg_96_0.startDragIndex, arg_96_0.dragIndex)

	arg_96_0.dragIndex = nil
	arg_96_0.curLongPress = nil
end

function var_0_0.getLongPressItemIndex(arg_97_0)
	for iter_97_0, iter_97_1 in pairs(arg_97_0._handCardItemList) do
		if iter_97_1 and iter_97_1._isLongPress then
			return iter_97_1
		end
	end

	return nil
end

function var_0_0._longPressHandCard(arg_98_0, arg_98_1)
	arg_98_0:_longPressHandCardEnd()

	if arg_98_0._cardDragFlow.status == WorkStatus.Running then
		return
	end

	if arg_98_0._cardLongPressFlow.status == WorkStatus.Running then
		return
	end

	FightCardModel.instance:setLongPressIndex(arg_98_1)

	arg_98_0._longPressIndex = arg_98_1
	arg_98_0._clearPressIndex = false
	arg_98_0._cardCount = #FightCardModel.instance:getHandCards()

	local var_98_0 = arg_98_0:getUserDataTb_()

	var_98_0.index = arg_98_1
	var_98_0.cardCount = arg_98_0._cardCount
	var_98_0.handCardItemList = arg_98_0._handCardItemList

	arg_98_0._cardLongPressFlow:registerDoneListener(arg_98_0._onLongPressFlowDone, arg_98_0)
	arg_98_0._cardLongPressFlow:start(var_98_0)
	arg_98_0._handCardItemList[arg_98_1]:playLongPressEffect()
end

function var_0_0._onLongPressFlowDone(arg_99_0)
	arg_99_0._cardLongPressFlow:unregisterDoneListener(arg_99_0._onLongPressFlowDone, arg_99_0)
end

function var_0_0._longPressHandCardEnd(arg_100_0, arg_100_1)
	arg_100_1 = arg_100_1 or arg_100_0._longPressIndex

	if not arg_100_1 then
		return
	end

	arg_100_0._handCardItemList[arg_100_1]:stopLongPressEffect()
	arg_100_0._handCardItemList[arg_100_1]:onLongPressEnd()

	if arg_100_0._cardLongPressFlow.status == WorkStatus.Running then
		arg_100_0._cardLongPressFlow:stop()
		arg_100_0._cardLongPressFlow:reset()
	end

	arg_100_0._clearPressIndex = true

	local var_100_0 = arg_100_0:getUserDataTb_()

	var_100_0.index = arg_100_1
	var_100_0.cardCount = arg_100_0._cardCount
	var_100_0.handCardItemList = arg_100_0._handCardItemList

	arg_100_0._cardLongPressEndFlow:registerDoneListener(arg_100_0._onLongPressEndFlowDone, arg_100_0)
	arg_100_0._cardLongPressEndFlow:start(var_100_0)

	arg_100_0._longPressIndex = nil
end

function var_0_0._onLongPressEndFlowDone(arg_101_0)
	if arg_101_0._clearPressIndex then
		arg_101_0._longPressIndex = nil

		FightCardModel.instance:setLongPressIndex(-1)
	end

	arg_101_0._cardLongPressEndFlow:unregisterDoneListener(arg_101_0._onLongPressEndFlowDone, arg_101_0)
end

function var_0_0._onEnterOperateState(arg_102_0, arg_102_1)
	if arg_102_1 == FightStageMgr.OperateStateType.Discard then
		arg_102_0._abandonTran:SetAsLastSibling()
		gohelper.setActive(arg_102_0._abandon, true)
		arg_102_0._playCardTransform:SetAsLastSibling()

		local var_102_0 = 0

		for iter_102_0 = 1, #arg_102_0._handCardItemList do
			local var_102_1 = arg_102_0._handCardItemList[iter_102_0]

			if var_102_1 then
				if var_102_1.go.activeInHierarchy then
					var_102_0 = var_102_0 + 1
				else
					break
				end

				local var_102_2 = var_102_1.cardInfoMO
				local var_102_3 = false
				local var_102_4 = FightDataHelper.entityMgr:getById(var_102_2.uid)

				if var_102_4 then
					if not var_102_4:isUniqueSkill(var_102_2.skillId) then
						var_102_3 = true
					end
				else
					var_102_3 = true
				end

				if var_102_3 then
					var_102_1.go.transform:SetParent(arg_102_0._abandonCardRootTran, true)
				end
			end
		end

		recthelper.setWidth(arg_102_0._abandonLine, var_102_0 * var_0_2 + 20)
	end
end

function var_0_0.cancelAbandonState(arg_103_0)
	gohelper.setActive(arg_103_0._abandon, false)

	for iter_103_0 = arg_103_0._abandonCardRootTran.childCount - 1, 0, -1 do
		arg_103_0._abandonCardRootTran:GetChild(iter_103_0):SetParent(arg_103_0._handCardTr, true)
	end

	arg_103_0._playCardTransform:SetSiblingIndex(var_0_0.playCardSiblingIndex)
end

function var_0_0._onExitOperateState(arg_104_0, arg_104_1)
	if arg_104_1 == FightStageMgr.OperateStateType.Discard then
		arg_104_0:cancelAbandonState()
	end
end

function var_0_0._onRefreshCardHeatShow(arg_105_0, arg_105_1)
	if arg_105_0._handCardItemList then
		for iter_105_0, iter_105_1 in ipairs(arg_105_0._handCardItemList) do
			iter_105_1:showCardHeat()
		end
	end
end

function var_0_0.calcCardPosXDraging(arg_106_0, arg_106_1, arg_106_2, arg_106_3)
	local var_106_0 = var_0_0.calcTotalWidth(arg_106_1, arg_106_3) / (arg_106_1 - 1 + arg_106_3)

	if arg_106_0 < arg_106_2 then
		return -0.5 * var_106_0 - var_106_0 * (arg_106_0 - 1)
	elseif arg_106_2 < arg_106_0 then
		return -0.5 * var_106_0 - var_106_0 * (arg_106_0 - 1) - (arg_106_3 - 1) * var_106_0
	else
		return -0.5 * var_106_0 - var_106_0 * (arg_106_0 - 2) - (arg_106_3 * 0.5 + 0.5) * var_106_0
	end
end

function var_0_0.calcCardIndexDraging(arg_107_0, arg_107_1, arg_107_2)
	local var_107_0 = var_0_0.calcTotalWidth(arg_107_1, arg_107_2) / (arg_107_1 - 1 + arg_107_2)
	local var_107_1 = -arg_107_0 / var_107_0 - arg_107_2 * 0.5 + 1
	local var_107_2 = math.floor(var_107_1 + 0.5)

	return (Mathf.Clamp(var_107_2, 1, arg_107_1))
end

function var_0_0.calcTotalWidth(arg_108_0, arg_108_1)
	return arg_108_0 * var_0_2 + (arg_108_1 - 1) * var_0_2 * 0.5
end

function var_0_0.calcCardPosX(arg_109_0)
	return -1 * var_0_2 * (arg_109_0 - 1) - var_0_2 / 2
end

return var_0_0
