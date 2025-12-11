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
	arg_1_0._correctHandCardScale = FightViewHandCardSequenceFlow.New()

	arg_1_0._correctHandCardScale:addWork(FigthCardDistributeCorrectScale.New())

	arg_1_0._cardDistributeFlow = FightViewHandCardParallelFlow.New()

	arg_1_0._cardDistributeFlow:addWork(FigthCardDistributeCorrectScale.New())
	arg_1_0._cardDistributeFlow:addWork(FigthCardDistributeEffect.New())
	arg_1_0._cardDistributeFlow:addWork(FightCardCombineEndEffect.New())

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

function var_0_0.addEvents(arg_4_0)
	arg_4_0:com_registMsg(FightMsgId.RegistPlayHandCardWork, arg_4_0.onRegistPlayHandCardWork)
	arg_4_0:com_registMsg(FightMsgId.RegistCardEndAniFlow, arg_4_0.onRegistCardEndAniFlow)
end

function var_0_0.onOpen(arg_5_0)
	arg_5_0:_updateNow()
	arg_5_0:addEventCb(FightController.instance, FightEvent.DistributeCards, arg_5_0._startDistributeCards, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.PushCardInfo, arg_5_0._updateNow, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.PlayHandCard, arg_5_0._playHandCard, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.PlayCombineCards, arg_5_0._onPlayCombineCards, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.UpdateHandCards, arg_5_0._updateHandCards, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.ResetCard, arg_5_0._resetCard, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.DragHandCardBegin, arg_5_0._onDragHandCardBegin, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.DragHandCardEnd, arg_5_0._onDragHandCardEnd, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.LongPressHandCard, arg_5_0._longPressHandCard, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.LongPressHandCardEnd, arg_5_0._longPressHandCardEnd, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.PlayRedealCardEffect, arg_5_0._playRedealCardEffect, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.UniversalAppear, arg_5_0._playUniversalAppear, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.CheckCardOpEnd, arg_5_0._checkCardOpEnd, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.DetectCardOpEndAfterOperationEffectDone, arg_5_0._onDetectCardOpEndAfterOperationEffectDone, arg_5_0)
	arg_5_0:addEventCb(GameStateMgr.instance, GameStateEvent.onApplicationPause, arg_5_0._onApplicationPause, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.SetCardMagicEffectChange, arg_5_0._setCardMagicEffectChange, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.PlayCardMagicEffectChange, arg_5_0._playCardMagicEffectChange, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.SetBlockCardOperate, arg_5_0._setBlockOperate, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.SpCardAdd, arg_5_0._onSpCardAdd, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.AddHandCard, arg_5_0._onAddHandCard, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.TempCardRemove, arg_5_0._onTempCardRemove, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.ChangeToTempCard, arg_5_0._onChangeToTempCard, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.CorrectHandCardScale, arg_5_0._onCorrectHandCardScale, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.RemoveEntityCards, arg_5_0._onRemoveEntityCards, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.CardRemove, arg_5_0._onCardRemove, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.CardRemove2, arg_5_0._onCardRemove2, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.RefreshHandCard, arg_5_0._updateNow, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.CardsCompose, arg_5_0._onCardsCompose, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.CardsComposeTimeOut, arg_5_0._onCardsComposeTimeOut, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.CardLevelChange, arg_5_0._onCardLevelChange, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.AfterForceUpdatePerformanceData, arg_5_0._onAfterForceUpdatePerformanceData, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_5_0._onRoundSequenceFinish, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, arg_5_0._onClothSkillRoundSequenceFinish, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.MasterAddHandCard, arg_5_0._onMasterAddHandCard, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.MasterCardRemove, arg_5_0._onMasterCardRemove, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.CardAConvertCardB, arg_5_0._onCardAConvertCardB, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_5_0._updateNow, arg_5_0)
	arg_5_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectCard, arg_5_0.OnKeyPlayCard, arg_5_0)
	arg_5_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleMoveCardEnd, arg_5_0.onControlRelease, arg_5_0)
	arg_5_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectLeft, arg_5_0.selectLeftCard, arg_5_0)
	arg_5_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectRight, arg_5_0.selectRightCard, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.StageChanged, arg_5_0._onStageChanged, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.EnterOperateState, arg_5_0._onEnterOperateState, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.ExitOperateState, arg_5_0._onExitOperateState, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.CardEffectChange, arg_5_0._onCardEffectChange, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.RefreshHandCardPrecisionEffect, arg_5_0._onRefreshHandCardPrecisionEffect, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.LY_CardAreaSizeChange, arg_5_0.onLY_CardAreaSizeChange, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.RefreshCardHeatShow, arg_5_0._onRefreshCardHeatShow, arg_5_0)
	arg_5_0:addEventCb(FightController.instance, FightEvent.ASFD_OnChangeCardEnergy, arg_5_0.onChangeCardEnergy, arg_5_0)
	arg_5_0:_setBlockOperate(false)
	arg_5_0:_refreshPrecisionShow()
end

function var_0_0.onClose(arg_6_0)
	FightCardModel.instance:setLongPressIndex(-1)
	TaskDispatcher.cancelTask(arg_6_0._delayCancelBlock, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._combineCardsAfterAddHandCard, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._correctActiveCardObjPos, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._combineAfterCardLevelChange, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._combineAfterCardRemove, arg_6_0)
	arg_6_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectCard, arg_6_0.OnKeyPlayCard, arg_6_0)
	arg_6_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleMoveCardEnd, arg_6_0.onControlRelease, arg_6_0)
	arg_6_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectLeft, arg_6_0.selectLeftCard, arg_6_0)
	arg_6_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectRight, arg_6_0.selectRightCard, arg_6_0)

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._handCardItemList) do
		iter_6_1:releaseSelf()
	end

	arg_6_0._correctHandCardScale:stop()
	arg_6_0._cardDistributeFlow:stop()
	arg_6_0._cardCombineFlow:stop()
	arg_6_0._cardLongPressFlow:stop()
	arg_6_0._cardLongPressEndFlow:stop()
	arg_6_0._cardDragFlow:stop()
	arg_6_0._cardDragEndFlow:stop()
	arg_6_0._redealCardFlow:stop()
	arg_6_0._universalAppearFlow:stop()
	arg_6_0._magicEffectCardFlow:stop()
end

function var_0_0._onHandCardFlowCreate(arg_7_0, arg_7_1)
	table.insert(arg_7_0.LyNeedCheckFlowList, arg_7_1)
end

function var_0_0._onHandCardFlowEnd(arg_8_0, arg_8_1)
	if arg_8_1 == arg_8_0._cardLongPressEndFlow or arg_8_1 == arg_8_0._cardDragEndFlow then
		arg_8_0.longPressing = false
	end

	return arg_8_0:refreshLYAreaActive()
end

function var_0_0._onHandCardFlowStart(arg_9_0, arg_9_1)
	if arg_9_1 == arg_9_0._cardLongPressFlow then
		arg_9_0.longPressing = true
	end

	return arg_9_0:refreshLYAreaActive()
end

function var_0_0._onStageChanged(arg_10_0, arg_10_1)
	if arg_10_1 == FightStageMgr.StageType.Operate then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._handCardItemList) do
			iter_10_1:setASFDActive(true)
		end

		arg_10_0:_refreshPrecisionShow()
	elseif arg_10_1 == FightStageMgr.StageType.Play then
		gohelper.setActive(arg_10_0._precisionFrame, false)
		arg_10_0:_setBlockOperate(false)
	end

	return arg_10_0:refreshLYAreaActive()
end

function var_0_0.refreshLYAreaActive(arg_11_0)
	if var_0_0.blockOperate then
		return arg_11_0:setActiveLyRoot(false)
	end

	if arg_11_0.longPressing then
		return arg_11_0:setActiveLyRoot(false)
	end

	if not (FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate) then
		return arg_11_0:setActiveLyRoot(false)
	end

	if arg_11_0.LyNeedCheckFlowList then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0.LyNeedCheckFlowList) do
			if iter_11_1.status == WorkStatus.Running then
				return arg_11_0:setActiveLyRoot(false)
			end
		end
	end

	arg_11_0:refreshLyAreaPos()
	arg_11_0:setActiveLyRoot(true)
end

function var_0_0.setActiveLyRoot(arg_12_0, arg_12_1)
	if FightDataHelper.LYDataMgr.LYCardAreaSize < 1 then
		gohelper.setActive(arg_12_0.goLYAreaRoot, false)

		return
	end

	gohelper.setActive(arg_12_0.goLYAreaRoot, true)

	if arg_12_1 then
		if not arg_12_0.goLYAreaRoot.activeInHierarchy then
			gohelper.setActive(arg_12_0.goLYAreaRoot, true)
			arg_12_0.animatorLyRoot:Play("open", 0, 0)
		end
	else
		gohelper.setActive(arg_12_0.goLYAreaRoot, false)
	end
end

function var_0_0.onLY_CardAreaSizeChange(arg_13_0)
	arg_13_0:refreshLyCardTag()
	arg_13_0:refreshLYAreaActive()
end

function var_0_0.refreshLyCardTag(arg_14_0)
	local var_14_0 = FightDataHelper.handCardMgr.handCard
	local var_14_1 = FightDataHelper.LYDataMgr.LYCardAreaSize
	local var_14_2 = var_14_0 and #var_14_0 or 0

	for iter_14_0 = 1, var_14_2 do
		local var_14_3 = arg_14_0._handCardItemList[iter_14_0]

		if var_14_3 then
			var_14_3:resetRedAndBlue()

			if var_14_1 > var_14_2 - iter_14_0 and iter_14_0 <= var_14_1 then
				var_14_3:setActiveBoth(true)
			else
				var_14_3:setActiveBlue(var_14_1 > var_14_2 - iter_14_0)
				var_14_3:setActiveRed(iter_14_0 <= var_14_1)
			end
		end
	end
end

function var_0_0.refreshLyAreaPos(arg_15_0)
	local var_15_0 = FightDataHelper.LYDataMgr.LYCardAreaSize
	local var_15_1 = FightDataHelper.handCardMgr.handCard
	local var_15_2 = var_15_1 and #var_15_1 or 0
	local var_15_3 = math.min(var_15_0, var_15_2)
	local var_15_4 = FightDataHelper.handCardMgr.handCard
	local var_15_5 = var_15_4 and #var_15_4 or 0
	local var_15_6 = var_15_3 and var_15_3 > 0 and var_15_5 > 0

	gohelper.setActive(arg_15_0.goRedArea, var_15_6)
	gohelper.setActive(arg_15_0.goGreenArea, var_15_6)

	if var_15_6 then
		local var_15_7 = var_0_0.calcTotalWidth(var_15_3, 1) + FightEnum.LYCardAreaWidthOffset

		recthelper.setWidth(arg_15_0.rectTrRedArea, var_15_7)
		recthelper.setWidth(arg_15_0.rectTrGreenArea, var_15_7)

		local var_15_8 = var_0_0.calcTotalWidth(var_15_5 - var_15_3, 1)

		recthelper.setAnchorX(arg_15_0.rectTrGreenArea, -var_15_8)
	end
end

function var_0_0._onApplicationPause(arg_16_0, arg_16_1)
	if arg_16_1 and FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		if arg_16_0._cardDragFlow and arg_16_0._cardDragFlow.status == WorkStatus.Running then
			arg_16_0._cardDragFlow:stop()
		end

		arg_16_0:_updateNow()
	end
end

function var_0_0.getHandCardItem(arg_17_0, arg_17_1)
	return arg_17_0._handCardItemList[arg_17_1]
end

function var_0_0.isMoveCardFlow(arg_18_0)
	return arg_18_0._cardDragFlow.status == WorkStatus.Running or arg_18_0._cardDragEndFlow.status == WorkStatus.Running
end

function var_0_0.isCombineCardFlow(arg_19_0)
	return arg_19_0._cardCombineFlow.status == WorkStatus.Running
end

function var_0_0.onRegistCardEndAniFlow(arg_20_0)
	local var_20_0 = arg_20_0:buildOperateEndFlow()

	FightMsgMgr.replyMsg(FightMsgId.RegistCardEndAniFlow, var_20_0)
end

function var_0_0.buildOperateEndFlow(arg_21_0)
	local var_21_0 = arg_21_0:com_registFlowSequence()
	local var_21_1 = FightViewHandCardSequenceFlow.New()

	var_21_1:addWork(FightGuideCardEnd.New())
	var_21_1:addWork(FightCardEndEffect.New())
	var_21_0:addWork(var_21_1)

	local var_21_2 = arg_21_0:getUserDataTb_()

	var_21_2.handCardContainer = arg_21_0._handCardGO
	var_21_2.playCardContainer = gohelper.findChild(arg_21_0.viewGO, "root/playcards")
	var_21_2.waitCardContainer = gohelper.findChild(arg_21_0.viewGO, "root/waitingArea/inner")
	var_21_2.handCardItemList = arg_21_0._handCardItemList
	var_21_0.context = var_21_2

	return var_21_0
end

function var_0_0._checkCardOpEnd(arg_22_0)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.AutoCardPlaying) then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() and #FightDataHelper.operationDataMgr:getOpList() > 0 then
		FightController.instance:dispatchEvent(FightEvent.CardOpEnd)

		if FightModel.instance:isSeason2() then
			FightWorkSendOperate2Server:onFinish()
			FightViewPartVisible.set(nil, nil, nil, nil, true)
			FightController.instance:dispatchEvent(FightEvent.HidePlayCardAllCard)

			return
		end

		arg_22_0:_setBlockOperate(true)
		gohelper.setActive(arg_22_0._precisionFrame, false)
		FightGameMgr.operateMgr:sendOperate2Server()
	end
end

function var_0_0._onDetectCardOpEndAfterOperationEffectDone(arg_23_0, arg_23_1)
	if arg_23_1 and FightModel.instance:isSeason2() and arg_23_1:isMoveUniversal() then
		FightWorkSendOperate2Server:onFinish()

		return
	end

	arg_23_0:_checkCardOpEnd()
end

function var_0_0._onCardEffectChange(arg_24_0, arg_24_1)
	if arg_24_1 == 1 then
		arg_24_0:_refreshPrecisionShow()
	end
end

function var_0_0.refreshPreDeleteCard(arg_25_0, arg_25_1)
	arg_25_0.needPreDeleteCardIndexDict = arg_25_0.needPreDeleteCardIndexDict or {}

	tabletool.clear(arg_25_0.needPreDeleteCardIndexDict)

	if arg_25_1 then
		for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
			local var_25_0 = iter_25_1.skillId
			local var_25_1 = var_25_0 and lua_fight_card_pre_delete.configDict[var_25_0]

			if var_25_1 then
				local var_25_2 = var_25_1.left

				if var_25_2 > 0 then
					for iter_25_2 = 1, var_25_2 do
						arg_25_0.needPreDeleteCardIndexDict[iter_25_0 + iter_25_2] = true
					end
				end

				local var_25_3 = var_25_1.right

				if var_25_3 > 0 then
					for iter_25_3 = 1, var_25_3 do
						arg_25_0.needPreDeleteCardIndexDict[iter_25_0 - iter_25_3] = true
					end
				end
			end
		end
	end

	for iter_25_4, iter_25_5 in ipairs(arg_25_0._handCardItemList) do
		iter_25_5:refreshPreDeleteImage(arg_25_0.needPreDeleteCardIndexDict and arg_25_0.needPreDeleteCardIndexDict[iter_25_4])
	end
end

function var_0_0._refreshPrecisionShow(arg_26_0)
	arg_26_0._precisionState = false

	gohelper.setActive(arg_26_0._precisionFrame, false)

	if FightDataHelper.stageMgr:isOperateStage() then
		local var_26_0 = {}

		FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.MySide, var_26_0)
		FightDataHelper.entityMgr:getSubList(FightEnum.EntitySide.MySide, var_26_0)

		for iter_26_0, iter_26_1 in ipairs(var_26_0) do
			if iter_26_1:hasBuffFeature(FightEnum.BuffFeature.PrecisionRegion) then
				gohelper.setActive(arg_26_0._precisionFrame, true)

				arg_26_0._precisionState = true

				arg_26_0:_detectPlayPrecisionEffect()

				break
			end
		end
	end
end

function var_0_0._detectPlayPrecisionEffect(arg_27_0)
	if arg_27_0._handCardItemList then
		for iter_27_0, iter_27_1 in ipairs(arg_27_0._handCardItemList) do
			local var_27_0 = iter_27_1:getCardItem()

			if iter_27_0 == 1 then
				if FightCardDataHelper.isPrecision(var_27_0._cardInfoMO) and arg_27_0._precisionState then
					var_27_0:showPrecisionEffect()
				else
					var_27_0:hidePrecisionEffect()
				end
			else
				var_27_0:hidePrecisionEffect()
			end
		end
	end
end

function var_0_0._onRefreshHandCardPrecisionEffect(arg_28_0)
	arg_28_0:_detectPlayPrecisionEffect()
end

function var_0_0._startDistributeCards(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	arg_29_0.distributeCards = FightDataUtil.copyData(arg_29_2) or {}

	FightDataUtil.coverData(arg_29_1, FightDataHelper.handCardMgr.handCard)
	arg_29_0:_updateHandCards()

	local var_29_0 = FightCardDataHelper.getCardSkin()

	if arg_29_3 then
		if var_29_0 == 672801 then
			local var_29_1 = arg_29_0:com_registWork(FightWorkEnterDistributeCards672801, arg_29_0, arg_29_0.distributeCards)

			var_29_1:registFinishCallback(arg_29_0.onEnterDistributeCardsSkinDone, arg_29_0)
			var_29_1:start()
		else
			arg_29_0:_nextDistributeCards()
		end
	else
		arg_29_0:_nextDistributeCards()
	end
end

function var_0_0.onEnterDistributeCardsSkinDone(arg_30_0)
	FightController.instance:dispatchEvent(FightEvent.OnDistributeCards)
end

function var_0_0._nextDistributeCards(arg_31_0, arg_31_1)
	arg_31_0._correctHandCardScale:stop()
	arg_31_0._cardDistributeFlow:stop()
	arg_31_0._cardCombineFlow:stop()
	arg_31_0._redealCardFlow:stop()
	arg_31_0._magicEffectCardFlow:stop()

	local var_31_0 = arg_31_0.distributeCards and #arg_31_0.distributeCards

	if var_31_0 > 0 then
		local var_31_1 = FightDataHelper.handCardMgr.handCard
		local var_31_2 = #var_31_1
		local var_31_3 = {}

		for iter_31_0 = 1, var_31_0 do
			local var_31_4 = table.remove(arg_31_0.distributeCards, 1)

			table.insert(var_31_3, var_31_4)
			table.insert(var_31_1, var_31_4)

			local var_31_5 = var_31_1[#var_31_1 - 1]

			if FightCardDataHelper.canCombineCardForPerformance(var_31_4, var_31_5) then
				break
			end
		end

		local var_31_6 = FightCardCombineEffect.getCardPosXList(arg_31_0._handCardItemList)

		arg_31_0:_updateHandCards(var_31_1)

		local var_31_7 = arg_31_0:getUserDataTb_()

		var_31_7.cards = var_31_1
		var_31_7.handCardItemList = arg_31_0._handCardItemList
		var_31_7.oldPosXList = var_31_6
		var_31_7.preCombineIndex = arg_31_1
		var_31_7.preCardCount = var_31_2
		var_31_7.newCardCount = #var_31_3
		var_31_7.playCardContainer = gohelper.findChild(arg_31_0.viewGO, "root/playcards")
		var_31_7.isEnd = var_31_0 == 1
		var_31_7.handCardContainer = arg_31_0._handCardContainer
		var_31_7.oldScale = 0

		arg_31_0:_setBlockOperate(true)
		arg_31_0._cardDistributeFlow:registerDoneListener(arg_31_0._onDistributeCards, arg_31_0)
		arg_31_0._cardDistributeFlow:start(var_31_7)
	else
		arg_31_0:_onDistributeCards()
	end
end

function var_0_0._onDistributeCards(arg_32_0)
	arg_32_0._cardDistributeFlow:unregisterDoneListener(arg_32_0._onDistributeCards, arg_32_0)

	local var_32_0 = arg_32_0._cardDistributeFlow.context and arg_32_0._cardDistributeFlow.context.cards or FightDataHelper.handCardMgr.handCard

	arg_32_0:_combineCards(var_32_0)
end

function var_0_0._playHandCard(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4)
	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightGameMgr.operateMgr:isOperating() then
		return
	end

	if not FightDataHelper.handCardMgr.handCard[arg_33_1] then
		arg_33_0:_updateNow()

		return
	end

	FightGameMgr.operateMgr:playHandCard(arg_33_1, arg_33_2, arg_33_3, arg_33_4)
end

function var_0_0.buildPlayHandCardFlow(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	local var_34_0 = FightDataHelper.handCardMgr.handCard
	local var_34_1 = var_34_0[arg_34_1]

	if not var_34_1 then
		return
	end

	local var_34_2 = arg_34_0._handCardItemList[arg_34_1]

	if not var_34_2 then
		return
	end

	if not var_34_2.go.activeInHierarchy then
		return
	end

	local var_34_3 = arg_34_0:com_registFlowSequence()
	local var_34_4 = FightViewHandCardSequenceFlow.New()

	var_34_4:addWork(FightCardPlayEffect.New())
	var_34_4:addWork(FightCardDissolveCardsAfterPlay.New())
	var_34_4:addWork(FightCardDiscardAfterPlay.New())
	var_34_4:addWork(FightCardCheckCombineCards.New())
	var_34_3:addWork(var_34_4)
	var_34_3:registWork(FightWorkFunction, arg_34_0._onPlayCardDone, arg_34_0)
	FightController.instance:dispatchEvent(FightEvent.HideCardSkillTips)
	arg_34_0:_setBlockOperate(true)

	if arg_34_4 and arg_34_4 ~= 0 then
		var_34_1.skillId = arg_34_4
	end

	var_34_1.playCanAddExpoint = FightCardDataHelper.playCanAddExpoint(var_34_0, var_34_1)

	local var_34_5 = FightDataHelper.operationDataMgr:newOperation()

	var_34_5:playCard(arg_34_1, arg_34_2, var_34_1, arg_34_3, arg_34_4)

	var_34_5.cardColor = FightDataHelper.LYDataMgr:getCardColor(var_34_0, arg_34_1)
	var_34_5.cardInfoMO.areaRedOrBlue = var_34_5.cardColor

	if var_34_1.heatId ~= 0 then
		local var_34_6 = FightDataHelper.teamDataMgr
		local var_34_7 = var_34_1.heatId
		local var_34_8 = var_34_6.myData.cardHeat.values[var_34_7]
		local var_34_9 = var_34_6.myCardHeatOffset[var_34_7] or 0

		var_34_6.myCardHeatOffset[var_34_7] = var_34_9 + var_34_8.changeValue

		FightController.instance:dispatchEvent(FightEvent.RefreshCardHeatShow, var_34_7)
	end

	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, var_34_5)
	table.remove(var_34_0, arg_34_1)

	local var_34_10 = FightDataUtil.copyData(var_34_0)
	local var_34_11

	if not FightCardDataHelper.isSkill3(var_34_1) and FightCardDataHelper.isBigSkill(var_34_1.skillId) then
		while true do
			if #var_34_0 > 0 then
				local var_34_12 = false

				for iter_34_0 = 1, #var_34_0 do
					local var_34_13 = var_34_0[iter_34_0]

					if var_34_13.uid == var_34_1.uid and FightCardDataHelper.isBigSkill(var_34_13.skillId) and not FightCardDataHelper.isSkill3(var_34_13) then
						var_34_11 = var_34_11 or {}

						table.insert(var_34_11, iter_34_0)
						FightDataHelper.operationDataMgr:newOperation():simulateDissolveCard(iter_34_0)
						table.remove(var_34_0, iter_34_0)

						break
					end

					if iter_34_0 == #var_34_0 then
						var_34_12 = true
					end
				end

				if var_34_12 then
					break
				end
			else
				break
			end
		end
	end

	local var_34_14 = false

	if FightCardDataHelper.isDiscard(var_34_1) then
		var_34_14 = true
	end

	arg_34_0._cardsForCombines = var_34_0

	local var_34_15 = arg_34_0:getUserDataTb_()

	var_34_15.view = arg_34_0
	var_34_15.cards = var_34_0
	var_34_15.from = arg_34_1
	var_34_15.viewGO = arg_34_0.viewGO
	var_34_15.handCardTr = arg_34_0._handCardTr
	var_34_15.handCardItemList = arg_34_0._handCardItemList
	var_34_15.fightBeginRoundOp = var_34_5
	var_34_15.beforeDissolveCards = var_34_10
	var_34_15.dissolveCardIndexsAfterPlay = var_34_11
	var_34_15.needDiscard = var_34_14
	var_34_15.param2 = arg_34_3
	var_34_3.context = var_34_15
	arg_34_0.playCardFightBeginRoundOp = var_34_5

	arg_34_0:_playCardAudio(var_34_1)

	return var_34_3
end

function var_0_0.onRegistPlayHandCardWork(arg_35_0, arg_35_1, arg_35_2, arg_35_3, arg_35_4)
	local var_35_0 = arg_35_0:buildPlayHandCardFlow(arg_35_1, arg_35_2, arg_35_3, arg_35_4)

	if var_35_0 then
		FightMsgMgr.replyMsg(FightMsgId.RegistPlayHandCardWork, var_35_0)
	end
end

function var_0_0._onPlayCardDone(arg_36_0)
	arg_36_0:_updateHandCards(FightDataHelper.handCardMgr.handCard)
	FightController.instance:dispatchEvent(FightEvent.OnPlayCardFlowDone, arg_36_0.playCardFightBeginRoundOp)
	FightController.instance:dispatchEvent(FightEvent.PlayCardOver)
	arg_36_0:_detectPlayPrecisionEffect()

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		arg_36_0:_setBlockOperate(true)

		return
	end
end

function var_0_0._playCardAudio(arg_37_0, arg_37_1)
	if FightDataHelper.stateMgr.isReplay then
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

	local var_37_2 = FightDataHelper.operationDataMgr:getOpList()
	local var_37_3 = FightBuffHelper.simulateBuffList(var_37_1, var_37_2[#var_37_2])

	if not FightViewHandCardItemLock.canUseCardSkill(arg_37_1.uid, arg_37_1.skillId, var_37_3) then
		return
	end

	local var_37_4 = FightCardDataHelper.getSkillLv(arg_37_1.uid, arg_37_1.skillId)
	local var_37_5 = var_37_1.modelId
	local var_37_6 = HeroConfig.instance:getHeroCO(var_37_5)
	local var_37_7

	if arg_37_1.cardType == FightEnum.CardType.SKILL3 then
		var_37_7 = arg_37_0:getSkill3AudioId(var_37_1, arg_37_1)
	elseif var_37_4 == 1 or var_37_4 == 2 then
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

function var_0_0.getSkill3AudioId(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = FightConfig.instance:getSkinSkillTimeline(arg_38_1.skin, arg_38_2.skillId)
	local var_38_1 = FightAudioMgr.instance:_getHeroVoiceCOs(arg_38_1.modelId, CharacterEnum.VoiceType.FightCardSkill3, arg_38_1.skin)

	if not var_38_1 then
		return
	end

	for iter_38_0 = #var_38_1, 1, -1 do
		local var_38_2 = var_38_1[iter_38_0]
		local var_38_3 = string.split(var_38_2.param, "#")

		if not (var_38_3 and tabletool.indexOf(var_38_3, var_38_0)) then
			table.remove(var_38_1, iter_38_0)
		end
	end

	local var_38_4 = #var_38_1

	if var_38_4 < 1 then
		return
	end

	if var_38_4 == 1 then
		return var_38_1[1].audio
	end

	return var_38_1[math.random(var_38_4)].audio
end

function var_0_0._playRedealCardEffect(arg_39_0, arg_39_1, arg_39_2)
	local var_39_0 = arg_39_0:getUserDataTb_()

	var_39_0.oldCards = arg_39_1
	var_39_0.newCards = arg_39_2
	var_39_0.handCardItemList = arg_39_0._handCardItemList

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
end

function var_0_0._setCardMagicEffectChange(arg_43_0, arg_43_1, arg_43_2, arg_43_3)
	arg_43_0._card_magic_effect_change_info = arg_43_0._card_magic_effect_change_info or {}
	arg_43_0._card_magic_effect_change_info[arg_43_1] = {
		old_effect = arg_43_2,
		new_effect = arg_43_3
	}
end

function var_0_0._playCardMagicEffectChange(arg_44_0)
	local var_44_0 = arg_44_0:getUserDataTb_()

	var_44_0.changeInfos = arg_44_0._card_magic_effect_change_info
	var_44_0.handCardItemList = arg_44_0._handCardItemList
	arg_44_0._card_magic_effect_change_info = nil

	arg_44_0:_setBlockOperate(true)
	arg_44_0._magicEffectCardFlow:registerDoneListener(arg_44_0._onMagicEffectCardFlowDone, arg_44_0)
	arg_44_0._magicEffectCardFlow:start(var_44_0)
end

function var_0_0._onMagicEffectCardFlowDone(arg_45_0)
	arg_45_0._magicEffectCardFlow:unregisterDoneListener(arg_45_0._onMagicEffectCardFlowDone, arg_45_0)

	local var_45_0 = FightDataHelper.handCardMgr.handCard

	arg_45_0:_combineCards(var_45_0)
end

function var_0_0._playUniversalAppear(arg_46_0)
	arg_46_0:_setBlockOperate(true)
	arg_46_0:_updateNow()

	local var_46_0 = arg_46_0:getUserDataTb_()

	var_46_0.handCardItemList = arg_46_0._handCardItemList

	arg_46_0._universalAppearFlow:start(var_46_0)
	arg_46_0._universalAppearFlow:registerDoneListener(arg_46_0._onUniversalAppearDone, arg_46_0)
end

function var_0_0._onSpCardAdd(arg_47_0, arg_47_1)
	arg_47_0:_playCorrectHandCardScale(0)

	local var_47_0 = FightDataHelper.handCardMgr.handCard

	arg_47_0:_updateHandCards(var_47_0, arg_47_1)

	local var_47_1 = arg_47_0._handCardItemList[arg_47_1]

	gohelper.setActive(var_47_1.go, false)
	var_47_1:playCardAni(ViewAnim.FightCardBalance)
end

function var_0_0._onCorrectHandCardScale(arg_48_0, arg_48_1)
	arg_48_0:_playCorrectHandCardScale(arg_48_1)
end

function var_0_0._playCorrectHandCardScale(arg_49_0, arg_49_1, arg_49_2)
	arg_49_0._correctHandCardScale:stop()

	local var_49_0 = arg_49_0:getUserDataTb_()

	var_49_0.cards = tabletool.copy(FightDataHelper.handCardMgr.handCard)
	var_49_0.oldScale = arg_49_1
	var_49_0.newScale = arg_49_2
	var_49_0.handCardContainer = arg_49_0._handCardContainer

	arg_49_0._correctHandCardScale:start(var_49_0)
end

function var_0_0._onCardsCompose(arg_50_0)
	local var_50_0 = FightDataHelper.handCardMgr.handCard

	arg_50_0:_combineCards(var_50_0)
end

function var_0_0._onCardsComposeTimeOut(arg_51_0)
	if arg_51_0._cardCombineFlow then
		arg_51_0._cardCombineFlow:stop()
	end

	arg_51_0:_updateNow()
end

function var_0_0._onRemoveEntityCards(arg_52_0, arg_52_1)
	for iter_52_0 = #arg_52_0._handCardItemList, 1, -1 do
		local var_52_0 = arg_52_0._handCardItemList[iter_52_0]

		if var_52_0.go.activeInHierarchy and var_52_0:dissolveEntityCard(arg_52_1) then
			table.insert(arg_52_0._handCardItemList, table.remove(arg_52_0._handCardItemList, iter_52_0))
		end
	end

	var_0_0.refreshCardIndex(arg_52_0._handCardItemList)
	TaskDispatcher.cancelTask(arg_52_0._correctActiveCardObjPos, arg_52_0)
	TaskDispatcher.runDelay(arg_52_0._correctActiveCardObjPos, arg_52_0, 1 / FightModel.instance:getUISpeed())
end

function var_0_0.refreshCardIndex(arg_53_0)
	for iter_53_0, iter_53_1 in ipairs(arg_53_0) do
		iter_53_1.index = iter_53_0
	end
end

function var_0_0._onCardLevelChange(arg_54_0, arg_54_1, arg_54_2, arg_54_3)
	local var_54_0 = arg_54_0._handCardItemList[arg_54_1]

	if var_54_0 then
		var_54_0:playCardLevelChange(arg_54_2)
	end

	if arg_54_3 then
		TaskDispatcher.cancelTask(arg_54_0._combineAfterCardLevelChange, arg_54_0)
		TaskDispatcher.runDelay(arg_54_0._combineAfterCardLevelChange, arg_54_0, FightEnum.PerformanceTime.CardLevelChange / FightModel.instance:getUISpeed())
	end
end

function var_0_0._combineAfterCardLevelChange(arg_55_0)
	local var_55_0 = FightDataHelper.handCardMgr.handCard

	arg_55_0:_combineCards(var_55_0)
end

function var_0_0._onPlayCombineCards(arg_56_0, arg_56_1)
	arg_56_0:_combineCards(arg_56_1)
end

function var_0_0._onCardRemove(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
	arg_57_0:_onCardRemove2(arg_57_1)

	if arg_57_3 then
		TaskDispatcher.cancelTask(arg_57_0._combineAfterCardRemove, arg_57_0)
		TaskDispatcher.runDelay(arg_57_0._combineAfterCardRemove, arg_57_0, arg_57_2 / FightModel.instance:getUISpeed())
	end
end

function var_0_0._combineAfterCardRemove(arg_58_0)
	local var_58_0 = FightDataHelper.handCardMgr.handCard

	arg_58_0:_combineCards(var_58_0)
end

function var_0_0._onCardRemove2(arg_59_0, arg_59_1)
	for iter_59_0, iter_59_1 in ipairs(arg_59_1) do
		local var_59_0 = table.remove(arg_59_0._handCardItemList, iter_59_1)

		if var_59_0 and var_59_0.go.activeInHierarchy then
			var_59_0:dissolveCard()
			table.insert(arg_59_0._handCardItemList, var_59_0)
		end
	end

	var_0_0.refreshCardIndex(arg_59_0._handCardItemList)
	TaskDispatcher.cancelTask(arg_59_0._correctActiveCardObjPos, arg_59_0)
	TaskDispatcher.runDelay(arg_59_0._correctActiveCardObjPos, arg_59_0, 1 / FightModel.instance:getUISpeed())
end

function var_0_0._correctActiveCardObjPos(arg_60_0)
	local var_60_0 = 0

	for iter_60_0 = 1, #arg_60_0._handCardItemList do
		local var_60_1 = arg_60_0._handCardItemList[iter_60_0]

		var_60_1.index = iter_60_0
		var_60_1.go.name = "cardItem" .. iter_60_0

		local var_60_2 = var_60_1.go

		if not var_60_2.activeInHierarchy then
			break
		end

		local var_60_3 = recthelper.getAnchorX(var_60_2.transform)
		local var_60_4 = var_0_0.calcCardPosX(iter_60_0)

		if math.abs(var_60_3 - var_60_4) >= 10 then
			var_60_1:moveSelfPos(iter_60_0, var_60_0, var_60_4)

			var_60_0 = var_60_0 + 1
		end
	end
end

function var_0_0._onAddHandCard(arg_61_0, arg_61_1, arg_61_2)
	arg_61_0:_playCorrectHandCardScale(0)

	local var_61_0 = FightDataHelper.handCardMgr.handCard
	local var_61_1 = #var_61_0

	arg_61_0:_updateHandCards(var_61_0, var_61_1)
	arg_61_0._handCardItemList[var_61_1]:playDistribute()

	if arg_61_2 then
		TaskDispatcher.runDelay(arg_61_0._combineCardsAfterAddHandCard, arg_61_0, 0.5 / FightModel.instance:getUISpeed())
	end
end

function var_0_0._onMasterAddHandCard(arg_62_0, arg_62_1, arg_62_2)
	arg_62_0:_playCorrectHandCardScale(0)

	local var_62_0 = FightDataHelper.handCardMgr.handCard
	local var_62_1 = #var_62_0

	arg_62_0:_updateHandCards(var_62_0, var_62_1)
	arg_62_0._handCardItemList[var_62_1]:playMasterAddHandCard()

	if arg_62_2 then
		TaskDispatcher.runDelay(arg_62_0._combineCardsAfterAddHandCard, arg_62_0, 1 / FightModel.instance:getUISpeed())
	end
end

function var_0_0._onMasterCardRemove(arg_63_0, arg_63_1, arg_63_2, arg_63_3)
	for iter_63_0, iter_63_1 in ipairs(arg_63_1) do
		local var_63_0 = table.remove(arg_63_0._handCardItemList, iter_63_1)

		if var_63_0 and var_63_0.go.activeInHierarchy then
			var_63_0:playMasterCardRemove()
			table.insert(arg_63_0._handCardItemList, var_63_0)
		end
	end

	var_0_0.refreshCardIndex(arg_63_0._handCardItemList)
	TaskDispatcher.cancelTask(arg_63_0._correctActiveCardObjPos, arg_63_0)
	TaskDispatcher.runDelay(arg_63_0._correctActiveCardObjPos, arg_63_0, 0.7 / FightModel.instance:getUISpeed())

	if arg_63_3 then
		TaskDispatcher.cancelTask(arg_63_0._combineAfterCardRemove, arg_63_0)
		TaskDispatcher.runDelay(arg_63_0._combineAfterCardRemove, arg_63_0, arg_63_2 / FightModel.instance:getUISpeed())
	end
end

function var_0_0._combineCardsAfterAddHandCard(arg_64_0)
	local var_64_0 = FightDataHelper.handCardMgr.handCard

	arg_64_0:_combineCards(var_64_0)
end

function var_0_0._onCardAConvertCardB(arg_65_0, arg_65_1)
	local var_65_0 = FightDataHelper.handCardMgr.handCard
	local var_65_1 = arg_65_0._handCardItemList[arg_65_1]

	if var_65_1 then
		var_65_1:playCardAConvertCardB()
		var_65_1:updateItem(arg_65_1, var_65_0[arg_65_1])
	else
		arg_65_0:_updateNow()
	end
end

function var_0_0._onTempCardRemove(arg_66_0)
	arg_66_0:_updateNow()

	local var_66_0 = FightDataHelper.handCardMgr.handCard

	arg_66_0:_combineCards(var_66_0)
end

function var_0_0._onChangeToTempCard(arg_67_0, arg_67_1)
	local var_67_0 = arg_67_0._handCardItemList[arg_67_1]

	if var_67_0 then
		var_67_0:changeToTempCard()
	end
end

function var_0_0._onUniversalAppearDone(arg_68_0)
	arg_68_0._universalAppearFlow:unregisterDoneListener(arg_68_0._onUniversalAppearDone, arg_68_0)
	arg_68_0:_setBlockOperate(false)
	FightController.instance:dispatchEvent(FightEvent.OnUniversalAppear)
end

function var_0_0._combineCards(arg_69_0, arg_69_1, arg_69_2, arg_69_3)
	arg_69_0._combineIndex = arg_69_2 or FightCardDataHelper.canCombineCardListForPerformance(arg_69_1)
	arg_69_0._isUniversalCombine = arg_69_2 and true or false

	if arg_69_0._combineIndex then
		arg_69_0._cardsForCombines = arg_69_1

		local var_69_0 = arg_69_0:getUserDataTb_()

		var_69_0.cards = arg_69_1
		var_69_0.combineIndex = arg_69_0._combineIndex
		var_69_0.handCardItemList = arg_69_0._handCardItemList
		var_69_0.fightBeginRoundOp = arg_69_3

		arg_69_0._cardCombineFlow:registerDoneListener(arg_69_0._onCombineCardDone, arg_69_0)
		arg_69_0._cardCombineFlow:start(var_69_0)
	else
		arg_69_0:_setBlockOperate(false)
		FightController.instance:dispatchEvent(FightEvent.OnCombineCardEnd, arg_69_1)

		if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DistributeCard) then
			if arg_69_0.distributeCards and #arg_69_0.distributeCards > 0 then
				arg_69_0:_nextDistributeCards(#arg_69_1)
			else
				gohelper.destroy(gohelper.findChild(arg_69_0._handCardGO, "CombineEffect"))
				arg_69_0:_updateNow()
				FightController.instance:dispatchEvent(FightEvent.OnDistributeCards)
			end
		end

		if arg_69_3 then
			FightController.instance:dispatchEvent(FightEvent.PlayOperationEffectDone, arg_69_3)
			arg_69_0:_detectPlayPrecisionEffect()
		end
	end
end

function var_0_0._onCombineCardDone(arg_70_0, arg_70_1)
	arg_70_0._cardCombineFlow:unregisterDoneListener(arg_70_0._onCombineCardDone, arg_70_0)

	local var_70_0 = arg_70_0._cardsForCombines[arg_70_0._combineIndex]

	FightController.instance:dispatchEvent(FightEvent.OnCombineOneCard, var_70_0, arg_70_0._isUniversalCombine)
	arg_70_0:_combineCards(arg_70_0._cardsForCombines, nil, arg_70_0._cardCombineFlow.context.fightBeginRoundOp)
end

function var_0_0._resetCard(arg_71_0, arg_71_1)
	FightGameMgr.operateMgr:cancelAllOperate()
	FightDataHelper.paTaMgr:resetOp()
	FightController.instance:dispatchEvent(FightEvent.OnResetCard, arg_71_1)
end

function var_0_0._updateNow(arg_72_0)
	arg_72_0:_updateHandCards(FightDataHelper.handCardMgr.handCard)
end

function var_0_0._filterInvalidCard(arg_73_0, arg_73_1)
	for iter_73_0 = #arg_73_1, 1, -1 do
		local var_73_0 = arg_73_1[iter_73_0].skillId

		if not lua_skill.configDict[var_73_0] then
			if not var_73_0 then
				logError("手牌数据没有skillId,请保存复现数据找开发看看")
			else
				logError("技能表找不到id:" .. var_73_0)
			end

			table.remove(arg_73_1, iter_73_0)
		end
	end

	return arg_73_1
end

function var_0_0._updateHandCards(arg_74_0, arg_74_1, arg_74_2)
	arg_74_1 = arg_74_1 or FightDataHelper.handCardMgr.handCard
	arg_74_1 = arg_74_0:_filterInvalidCard(arg_74_1)

	local var_74_0 = arg_74_1 and #arg_74_1 or 0

	for iter_74_0 = arg_74_2 or 1, var_74_0 do
		local var_74_1 = arg_74_0._handCardItemList[iter_74_0]

		if not var_74_1 then
			local var_74_2 = gohelper.clone(arg_74_0._handCardItemPrefab, arg_74_0._handCardGO)

			var_74_1 = MonoHelper.addLuaComOnceToGo(var_74_2, FightViewHandCardItem, arg_74_0)

			table.insert(arg_74_0._handCardItemList, var_74_1)
		end

		var_74_1.go.name = "cardItem" .. iter_74_0

		local var_74_3 = var_0_0.calcCardPosX(iter_74_0)

		recthelper.setAnchor(var_74_1.tr, var_74_3, 0)
		gohelper.setActive(var_74_1.go, true)
		transformhelper.setLocalScale(var_74_1.tr, 1, 1, 1)
		var_74_1:updateItem(iter_74_0, arg_74_1[iter_74_0])
		gohelper.setAsLastSibling(var_74_1.go)
	end

	for iter_74_1 = var_74_0 + 1, #arg_74_0._handCardItemList do
		local var_74_4 = arg_74_0._handCardItemList[iter_74_1]

		gohelper.setActive(var_74_4.go, false)

		var_74_4.go.name = "cardItem" .. iter_74_1

		var_74_4:updateItem(iter_74_1, nil)
	end

	arg_74_0:refreshPreDeleteCard(arg_74_1)
	arg_74_0:refreshLyCardTag()
end

function var_0_0._setBlockOperate(arg_75_0, arg_75_1)
	var_0_0.blockOperate = arg_75_1 and true or false

	if not gohelper.isNil(arg_75_0._handCardGOCanvasGroup) then
		arg_75_0._handCardGOCanvasGroup.blocksRaycasts = not arg_75_1
	end

	if arg_75_1 then
		TaskDispatcher.cancelTask(arg_75_0._delayCancelBlock, arg_75_0)
		TaskDispatcher.runDelay(arg_75_0._delayCancelBlock, arg_75_0, 10)
	else
		TaskDispatcher.cancelTask(arg_75_0._delayCancelBlock, arg_75_0)
	end

	arg_75_0:refreshLYAreaActive()
end

function var_0_0._delayCancelBlock(arg_76_0)
	arg_76_0:_setBlockOperate(false)
end

function var_0_0._onAfterForceUpdatePerformanceData(arg_77_0)
	arg_77_0:_updateNow()
end

function var_0_0._onRoundSequenceFinish(arg_78_0)
	arg_78_0:_updateNow()
end

function var_0_0._onClothSkillRoundSequenceFinish(arg_79_0)
	return
end

function var_0_0._onDragHandCardBegin(arg_80_0, arg_80_1, arg_80_2)
	if arg_80_0._cardDragFlow.status == WorkStatus.Running then
		return
	end

	if arg_80_0._cardLongPressFlow.status == WorkStatus.Running then
		arg_80_0._cardLongPressFlow:stop()
		arg_80_0._cardLongPressFlow:reset()
	end

	arg_80_0._dragBeginCards = FightDataHelper.handCardMgr.handCard
	arg_80_0._cardCount = #arg_80_0._dragBeginCards

	if arg_80_1 > arg_80_0._cardCount then
		return
	end

	local var_80_0 = arg_80_0:getUserDataTb_()

	var_80_0.index = arg_80_1
	var_80_0.position = arg_80_2
	var_80_0.cardCount = arg_80_0._cardCount
	var_80_0.handCardItemList = arg_80_0._handCardItemList
	var_80_0.handCardTr = arg_80_0._handCardTr
	var_80_0.handCards = arg_80_0._dragBeginCards

	arg_80_0._cardDragFlow:start(var_80_0)
	arg_80_0._handCardItemList[arg_80_1]:stopLongPressEffect()
	FightController.instance:dispatchEvent(FightEvent.HideCardSkillTips)
end

function var_0_0._onDragHandCardEnd(arg_81_0, arg_81_1, arg_81_2)
	if arg_81_1 > arg_81_0._cardCount then
		arg_81_0:_updateNow()

		return
	end

	arg_81_0._cardDragFlow:stop()
	arg_81_0._cardDragFlow:reset()

	arg_81_0._dragIndex = arg_81_1

	local var_81_0 = recthelper.screenPosToAnchorPos(arg_81_2, arg_81_0._handCardTr)
	local var_81_1, var_81_2, var_81_3 = transformhelper.getLocalScale(arg_81_0._handCardItemList[arg_81_1].tr)
	local var_81_4 = var_81_0.x - var_0_0.HalfWidth

	arg_81_0._targetIndex = var_0_0.calcCardIndexDraging(var_81_4, arg_81_0._cardCount, 1)

	local var_81_5 = arg_81_0:getUserDataTb_()

	var_81_5.index = arg_81_1
	var_81_5.targetIndex = arg_81_0._targetIndex
	var_81_5.cardCount = arg_81_0._cardCount
	var_81_5.handCardItemList = arg_81_0._handCardItemList
	var_81_5.handCardTr = arg_81_0._handCardTr
	var_81_5.handCards = arg_81_0._dragBeginCards

	arg_81_0._cardDragEndFlow:registerDoneListener(arg_81_0._onDragEndFlowDone, arg_81_0)
	arg_81_0._cardDragEndFlow:start(var_81_5)
	arg_81_0:_setBlockOperate(true)
end

function var_0_0._onDragEndFlowDone(arg_82_0)
	arg_82_0._cardDragEndFlow:unregisterDoneListener(arg_82_0._onDragEndFlowDone, arg_82_0)

	local var_82_0 = arg_82_0._dragIndex
	local var_82_1 = arg_82_0._targetIndex

	if not arg_82_0:_checkGuideMoveCard(var_82_0, var_82_1) then
		return
	end

	if var_82_0 == var_82_1 then
		arg_82_0:_setBlockOperate(false)

		return
	end

	local var_82_2 = arg_82_0._dragBeginCards[var_82_0]
	local var_82_3 = false

	if FightEnum.UniversalCard[var_82_2.skillId] then
		local var_82_4 = tabletool.copy(arg_82_0._dragBeginCards)

		table.remove(var_82_4, var_82_0)
		table.insert(var_82_4, var_82_1, var_82_2)

		if not FightCardDataHelper.canCombineWithUniversalForPerformance(var_82_2, var_82_4[var_82_1 + 1]) then
			arg_82_0:_updateNow()
			arg_82_0:_setBlockOperate(false)

			return
		end

		var_82_3 = var_82_1
	end

	local var_82_5 = arg_82_0._dragBeginCards
	local var_82_6 = var_82_2.skillId

	if (var_82_2.uid == FightEntityScene.MySideId or var_82_2.uid == FightEntityScene.EnemySideId) and not FightEnum.UniversalCard[var_82_6] then
		arg_82_0:_updateNow()
		arg_82_0:_setBlockOperate(false)

		return
	end

	arg_82_0:_moveCardItemInList(var_82_0, var_82_1)

	if not FightDataHelper.operationDataMgr:isCardOpEnd() then
		local var_82_7 = FightDataHelper.operationDataMgr:newOperation()

		var_82_7.moveCanAddExpoint, var_82_7.isUnlimitMoveOrExtraMove = FightCardDataHelper.moveCanAddExpoint(var_82_5, var_82_2)

		if var_82_3 then
			var_82_7:moveUniversalCard(var_82_0, var_82_1, var_82_2)
		else
			var_82_7:moveCard(var_82_0, var_82_1, var_82_2)
		end

		FightCardDataHelper.moveOnly(var_82_5, var_82_0, var_82_1)

		if var_82_0 ~= var_82_1 then
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_FightMoveCardEnd)
		end

		arg_82_0:_updateHandCards(var_82_5)
		FightController.instance:dispatchEvent(FightEvent.OnMoveHandCard, var_82_7, var_82_2)
		FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, var_82_7)

		local var_82_8 = var_82_3 and var_82_1

		arg_82_0:_combineCards(var_82_5, var_82_8, var_82_7)
	else
		arg_82_0:_updateHandCards(var_82_5)

		if not FightDataHelper.stateMgr.isReplay then
			-- block empty
		end

		arg_82_0:_setBlockOperate(false)
	end
end

function var_0_0._moveCardItemInList(arg_83_0, arg_83_1, arg_83_2)
	if not arg_83_0._handCardItemList or not arg_83_0._handCardItemList[arg_83_1] or not arg_83_0._handCardItemList[arg_83_2] then
		return
	end

	if arg_83_1 == arg_83_2 then
		return
	end

	local var_83_0 = arg_83_0._handCardItemList[arg_83_1]
	local var_83_1 = arg_83_1 < arg_83_2 and 1 or -1

	for iter_83_0 = arg_83_1, arg_83_2 - var_83_1, var_83_1 do
		arg_83_0._handCardItemList[iter_83_0] = arg_83_0._handCardItemList[iter_83_0 + var_83_1]
	end

	arg_83_0._handCardItemList[arg_83_2] = var_83_0
end

function var_0_0._playCardItemInList(arg_84_0, arg_84_1)
	if not arg_84_0._handCardItemList or not arg_84_0._handCardItemList[arg_84_1] then
		return
	end

	arg_84_0:_moveCardItemInList(arg_84_1, #arg_84_0._handCardItemList)
end

function var_0_0._checkGuideMoveCard(arg_85_0, arg_85_1, arg_85_2)
	local var_85_0 = GuideModel.instance:getFlagValue(GuideModel.GuideFlag.FightMoveCard)

	if var_85_0 then
		local var_85_1 = arg_85_1 == var_85_0.from

		if var_85_1 then
			local var_85_2 = false
			local var_85_3 = var_85_0.tos

			for iter_85_0, iter_85_1 in ipairs(var_85_3) do
				if arg_85_2 == iter_85_1 then
					var_85_2 = true

					break
				end
			end

			var_85_1 = var_85_2
		end

		if var_85_1 then
			FightController.instance:dispatchEvent(FightEvent.OnGuideDragCard)

			return true
		else
			arg_85_0:_resetCard({})
			arg_85_0:_setBlockOperate(false)

			return false
		end
	end

	return true
end

function var_0_0.selectLeftCard(arg_86_0)
	if arg_86_0._longPressIndex == nil then
		local var_86_0 = 1

		for iter_86_0, iter_86_1 in pairs(arg_86_0._handCardItemList) do
			if iter_86_1.go.activeInHierarchy and var_86_0 < iter_86_1.index then
				var_86_0 = iter_86_1.index
			end
		end

		arg_86_0:OnkeyLongPress(var_86_0)
	else
		if arg_86_0._longPressIndex + 1 > #arg_86_0._handCardItemList then
			return
		end

		local var_86_1 = arg_86_0._handCardItemList[arg_86_0._longPressIndex + 1]

		if var_86_1 and not var_86_1.go.activeInHierarchy then
			return
		end

		arg_86_0:OnkeyLongPress(arg_86_0._longPressIndex + 1)
	end
end

function var_0_0.selectRightCard(arg_87_0)
	if arg_87_0._longPressIndex == nil then
		local var_87_0 = 1

		for iter_87_0, iter_87_1 in pairs(arg_87_0._handCardItemList) do
			if iter_87_1.go.activeInHierarchy and var_87_0 > iter_87_1.index then
				var_87_0 = iter_87_1.index
			end
		end

		arg_87_0:OnkeyLongPress(var_87_0)
	else
		if arg_87_0._longPressIndex - 1 < 1 then
			return
		end

		arg_87_0:OnkeyLongPress(arg_87_0._longPressIndex - 1)
	end
end

function var_0_0.OnKeyPlayCard(arg_88_0, arg_88_1)
	if ViewMgr.instance:IsPopUpViewOpen() then
		return
	end

	arg_88_0:_longPressHandCardEnd()

	local var_88_0 = #FightDataHelper.handCardMgr.handCard

	for iter_88_0, iter_88_1 in pairs(arg_88_0._handCardItemList) do
		if iter_88_1.index == var_88_0 - arg_88_1 + 1 and iter_88_1.go.activeInHierarchy then
			iter_88_1:_onClickThis()
		end
	end
end

function var_0_0.OnkeyLongPress(arg_89_0, arg_89_1)
	if FightDataHelper.stateMgr.isReplay then
		return
	end

	arg_89_0:_longPressHandCardEnd()
	FightController.instance:dispatchEvent(FightEvent.HideCardSkillTips)

	for iter_89_0, iter_89_1 in pairs(arg_89_0._handCardItemList) do
		if iter_89_1.index == arg_89_1 and iter_89_1.go.activeInHierarchy then
			iter_89_1:_onLongPress()
		end
	end
end

function var_0_0.onControlRelease(arg_90_0)
	if not arg_90_0._longPressIndex then
		return
	end

	for iter_90_0, iter_90_1 in pairs(arg_90_0._handCardItemList) do
		if iter_90_1 and iter_90_1.index == arg_90_0._longPressIndex then
			iter_90_1:_onClickThis()
		end
	end
end

function var_0_0.OnSeleCardMoveEnd(arg_91_0)
	arg_91_0._keyDrag = false

	FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCardEnd, arg_91_0.startDragIndex, arg_91_0.dragIndex)

	arg_91_0.dragIndex = nil
	arg_91_0.curLongPress = nil
end

function var_0_0.getLongPressItemIndex(arg_92_0)
	for iter_92_0, iter_92_1 in pairs(arg_92_0._handCardItemList) do
		if iter_92_1 and iter_92_1._isLongPress then
			return iter_92_1
		end
	end

	return nil
end

function var_0_0._longPressHandCard(arg_93_0, arg_93_1)
	arg_93_0:_longPressHandCardEnd()

	if arg_93_0._cardDragFlow.status == WorkStatus.Running then
		return
	end

	if arg_93_0._cardLongPressFlow.status == WorkStatus.Running then
		return
	end

	FightCardModel.instance:setLongPressIndex(arg_93_1)

	arg_93_0._longPressIndex = arg_93_1
	arg_93_0._cardCount = #FightDataHelper.handCardMgr.handCard
	arg_93_0._clearPressIndex = false

	local var_93_0 = arg_93_0:getUserDataTb_()

	var_93_0.index = arg_93_1
	var_93_0.cardCount = arg_93_0._cardCount
	var_93_0.handCardItemList = arg_93_0._handCardItemList

	arg_93_0._cardLongPressFlow:registerDoneListener(arg_93_0._onLongPressFlowDone, arg_93_0)
	arg_93_0._cardLongPressFlow:start(var_93_0)
	arg_93_0._handCardItemList[arg_93_1]:playLongPressEffect()
end

function var_0_0._onLongPressFlowDone(arg_94_0)
	arg_94_0._cardLongPressFlow:unregisterDoneListener(arg_94_0._onLongPressFlowDone, arg_94_0)
end

function var_0_0._longPressHandCardEnd(arg_95_0, arg_95_1)
	arg_95_1 = arg_95_1 or arg_95_0._longPressIndex

	if not arg_95_1 then
		return
	end

	arg_95_0._handCardItemList[arg_95_1]:stopLongPressEffect()
	arg_95_0._handCardItemList[arg_95_1]:onLongPressEnd()

	if arg_95_0._cardLongPressFlow.status == WorkStatus.Running then
		arg_95_0._cardLongPressFlow:stop()
		arg_95_0._cardLongPressFlow:reset()
	end

	arg_95_0._clearPressIndex = true

	local var_95_0 = arg_95_0:getUserDataTb_()

	var_95_0.index = arg_95_1
	var_95_0.cardCount = arg_95_0._cardCount
	var_95_0.handCardItemList = arg_95_0._handCardItemList

	arg_95_0._cardLongPressEndFlow:registerDoneListener(arg_95_0._onLongPressEndFlowDone, arg_95_0)
	arg_95_0._cardLongPressEndFlow:start(var_95_0)

	arg_95_0._longPressIndex = nil
end

function var_0_0._onLongPressEndFlowDone(arg_96_0)
	if arg_96_0._clearPressIndex then
		arg_96_0._longPressIndex = nil

		FightCardModel.instance:setLongPressIndex(-1)
	end

	arg_96_0._cardLongPressEndFlow:unregisterDoneListener(arg_96_0._onLongPressEndFlowDone, arg_96_0)
end

function var_0_0._onEnterOperateState(arg_97_0, arg_97_1)
	if arg_97_1 == FightStageMgr.OperateStateType.Discard then
		arg_97_0._abandonTran:SetAsLastSibling()
		gohelper.setActive(arg_97_0._abandon, true)
		arg_97_0._playCardTransform:SetAsLastSibling()

		local var_97_0 = 0

		for iter_97_0 = 1, #arg_97_0._handCardItemList do
			local var_97_1 = arg_97_0._handCardItemList[iter_97_0]

			if var_97_1 then
				if var_97_1.go.activeInHierarchy then
					var_97_0 = var_97_0 + 1
				else
					break
				end

				local var_97_2 = var_97_1.cardInfoMO
				local var_97_3 = false

				if FightDataHelper.entityMgr:getById(var_97_2.uid) then
					if not FightCardDataHelper.isBigSkill(var_97_2.skillId) then
						var_97_3 = true
					end
				else
					var_97_3 = true
				end

				if var_97_3 then
					var_97_1.go.transform:SetParent(arg_97_0._abandonCardRootTran, true)
				end
			end
		end

		recthelper.setWidth(arg_97_0._abandonLine, var_97_0 * var_0_2 + 20)
	end
end

function var_0_0.cancelAbandonState(arg_98_0)
	gohelper.setActive(arg_98_0._abandon, false)

	for iter_98_0 = arg_98_0._abandonCardRootTran.childCount - 1, 0, -1 do
		arg_98_0._abandonCardRootTran:GetChild(iter_98_0):SetParent(arg_98_0._handCardTr, true)
	end

	arg_98_0._playCardTransform:SetSiblingIndex(var_0_0.playCardSiblingIndex)
end

function var_0_0._onExitOperateState(arg_99_0, arg_99_1)
	if arg_99_1 == FightStageMgr.OperateStateType.Discard then
		arg_99_0:cancelAbandonState()
	end
end

function var_0_0._onRefreshCardHeatShow(arg_100_0, arg_100_1)
	if arg_100_0._handCardItemList then
		for iter_100_0, iter_100_1 in ipairs(arg_100_0._handCardItemList) do
			iter_100_1:showCardHeat()
		end
	end
end

function var_0_0.onChangeCardEnergy(arg_101_0, arg_101_1)
	if not arg_101_1 then
		return
	end

	for iter_101_0, iter_101_1 in ipairs(arg_101_1) do
		local var_101_0 = iter_101_1[1]
		local var_101_1 = arg_101_0._handCardItemList[var_101_0]

		if var_101_1 then
			var_101_1:changeEnergy()
		end
	end
end

function var_0_0.calcCardPosXDraging(arg_102_0, arg_102_1, arg_102_2, arg_102_3)
	local var_102_0 = var_0_0.calcTotalWidth(arg_102_1, arg_102_3) / (arg_102_1 - 1 + arg_102_3)

	if arg_102_0 < arg_102_2 then
		return -0.5 * var_102_0 - var_102_0 * (arg_102_0 - 1)
	elseif arg_102_2 < arg_102_0 then
		return -0.5 * var_102_0 - var_102_0 * (arg_102_0 - 1) - (arg_102_3 - 1) * var_102_0
	else
		return -0.5 * var_102_0 - var_102_0 * (arg_102_0 - 2) - (arg_102_3 * 0.5 + 0.5) * var_102_0
	end
end

function var_0_0.calcCardIndexDraging(arg_103_0, arg_103_1, arg_103_2)
	local var_103_0 = var_0_0.calcTotalWidth(arg_103_1, arg_103_2) / (arg_103_1 - 1 + arg_103_2)
	local var_103_1 = -arg_103_0 / var_103_0 - arg_103_2 * 0.5 + 1
	local var_103_2 = math.floor(var_103_1 + 0.5)

	return (Mathf.Clamp(var_103_2, 1, arg_103_1))
end

function var_0_0.calcTotalWidth(arg_104_0, arg_104_1)
	return arg_104_0 * var_0_2 + (arg_104_1 - 1) * var_0_2 * 0.5
end

function var_0_0.calcCardPosX(arg_105_0)
	return -1 * var_0_2 * (arg_105_0 - 1) - var_0_2 / 2
end

return var_0_0
