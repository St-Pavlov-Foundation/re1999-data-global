module("modules.logic.fight.view.FightViewHandCard", package.seeall)

slot0 = class("FightViewHandCard", BaseView)
slot1 = 256
slot2 = 185
slot0.blockOperate = false

function slot0.onInitView(slot0)
	slot0._handCardContainer = gohelper.findChild(slot0.viewGO, "root/handcards")
	slot0._handCardGO = gohelper.findChild(slot0.viewGO, "root/handcards/handcards")
	slot0._handCardTransform = slot0._handCardContainer.transform
	uv0.handCardSiblingIndex = slot0._handCardTransform:GetSiblingIndex()
	slot0._playCardTransform = gohelper.findChild(slot0.viewGO, "root/playcards").transform
	uv0.playCardSiblingIndex = slot0._playCardTransform:GetSiblingIndex()
	slot0._abandon = gohelper.findChild(slot0.viewGO, "root/abandon")
	slot0._abandonLine = gohelper.findChild(slot0.viewGO, "root/abandon/rightBottom/line").transform

	gohelper.setActive(slot0._abandon, false)

	slot0._abandonTran = slot0._abandon.transform
	slot0._abandonCardRoot = gohelper.findChild(slot0.viewGO, "root/abandon/cardRoot")
	slot0._abandonCardRootTran = slot0._abandonCardRoot.transform
	slot0._precisionFrame = gohelper.findChild(slot0.viewGO, "root/handcards/areaFrameRoot")

	gohelper.setActive(slot0._precisionFrame, false)

	slot0._handCardGOCanvasGroup = gohelper.onceAddComponent(slot0._handCardGO, typeof(UnityEngine.CanvasGroup))
	slot0._handCardTr = slot0._handCardGO.transform
	slot0._handCardItemPrefab = gohelper.findChild(slot0.viewGO, "root/handcards/handcards/cardItem")

	gohelper.setActive(slot0._handCardItemPrefab, false)

	slot0._handCardItemList = {}

	slot0:_setBlockOperate(false)

	slot0.areaSize = 0
	slot0.LyNeedCheckFlowList = {}

	slot0:initRedOrBlueArea()
	slot0:addEventCb(FightController.instance, FightEvent.OnHandCardFlowCreate, slot0._onHandCardFlowCreate, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnHandCardFlowStart, slot0._onHandCardFlowStart, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnHandCardFlowEnd, slot0._onHandCardFlowEnd, slot0)

	uv0.handCardContainer = slot0._handCardContainer
	uv0.HalfWidth = recthelper.getWidth(slot0._handCardTr) / 2
	uv0.HalfItemWidth = recthelper.getWidth(slot0._handCardItemPrefab.transform) / 2
	uv0.HandCardWidth = uv1
	uv0.HandCardHeight = uv2
	slot0._autoPlayCardFlow = nil
	slot0._correctHandCardScale = FightViewHandCardSequenceFlow.New()

	slot0._correctHandCardScale:addWork(FigthCardDistributeCorrectScale.New())

	slot0._cardDistributeFlow = FightViewHandCardParallelFlow.New()

	slot0._cardDistributeFlow:addWork(FigthCardDistributeCorrectScale.New())
	slot0._cardDistributeFlow:addWork(FigthCardDistributeEffect.New())
	slot0._cardDistributeFlow:addWork(FightCardCombineEndEffect.New())

	slot0._cardPlayFlow = FightViewHandCardSequenceFlow.New()

	slot0._cardPlayFlow:addWork(FightCardPlayEffect.New())
	slot0._cardPlayFlow:addWork(FightCardDissolveCardsAfterPlay.New())
	slot0._cardPlayFlow:addWork(FightCardDiscardAfterPlay.New())
	slot0._cardPlayFlow:addWork(FightCardCheckCombineCards.New())

	slot0._cardCombineFlow = FightViewHandCardSequenceFlow.New()

	slot0._cardCombineFlow:addWork(FightCardCombineEffect.New())

	slot0._cardLongPressFlow = FightViewHandCardSequenceFlow.New()

	slot0._cardLongPressFlow:addWork(FightCardLongPressEffect.New())

	slot0._cardLongPressEndFlow = FightViewHandCardSequenceFlow.New()

	slot0._cardLongPressEndFlow:addWork(FightCardLongPressEndEffect.New())

	slot0._cardDragFlow = FightViewHandCardSequenceFlow.New()

	slot0._cardDragFlow:addWork(FightCardDragEffect.New())

	slot0._cardDragEndFlow = FightViewHandCardSequenceFlow.New()

	slot0._cardDragEndFlow:addWork(FightCardDragEndEffect.New())

	slot0._cardEndFlow = FightViewHandCardSequenceFlow.New()

	slot0._cardEndFlow:addWork(FightGuideCardEnd.New())
	slot0._cardEndFlow:addWork(FightCardEndEffect.New())

	slot0._changeCardFlow = FightViewHandCardSequenceFlow.New()

	slot0._changeCardFlow:addWork(FightCardChangeEffect.New())

	slot0._redealCardFlow = FightViewHandCardSequenceFlow.New()

	slot0._redealCardFlow:addWork(FightCardRedealEffect.New())

	slot0._universalAppearFlow = FightViewHandCardSequenceFlow.New()

	slot0._universalAppearFlow:addWork(FightCardUniversalAppearEffect.New())

	slot0._magicEffectCardFlow = FightViewHandCardSequenceFlow.New()

	slot0._magicEffectCardFlow:addWork(FightCardChangeMagicEffect.New())
end

function slot0.initRedOrBlueArea(slot0)
	slot0.goLYAreaRoot = gohelper.findChild(slot0.viewGO, "root/handcards/LiangyueframeRoot")
	slot0.animatorLyRoot = slot0.goLYAreaRoot:GetComponent(gohelper.Type_Animator)
	slot0.goRedArea = gohelper.findChild(slot0.goLYAreaRoot, "redarea")
	slot0.goGreenArea = gohelper.findChild(slot0.goLYAreaRoot, "greenarea")
	slot0.rectTrRedArea = slot0.goRedArea:GetComponent(gohelper.Type_RectTransform)
	slot0.rectTrGreenArea = slot0.goGreenArea:GetComponent(gohelper.Type_RectTransform)
end

function slot0.onDestroyView(slot0)
	uv0.handCardContainer = nil
	slot0.LyNeedCheckFlowList = nil
end

function slot0.onOpen(slot0)
	slot0:_updateNow()
	slot0:addEventCb(FightController.instance, FightEvent.DistributeCards, slot0._startDistributeCards, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.AutoPlayCard, slot0._toAutoPlayCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PushCardInfo, slot0._updateNow, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PlayHandCard, slot0._playHandCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PlayCombineCards, slot0._onPlayCombineCards, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.UpdateHandCards, slot0._updateHandCards, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ResetCard, slot0._resetCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.DragHandCardBegin, slot0._onDragHandCardBegin, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.DragHandCardEnd, slot0._onDragHandCardEnd, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.LongPressHandCard, slot0._longPressHandCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.LongPressHandCardEnd, slot0._longPressHandCardEnd, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PlayChangeCardEffect, slot0._playChangeCardEffect, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PlayRedealCardEffect, slot0._playRedealCardEffect, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.UniversalAppear, slot0._playUniversalAppear, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.CheckCardOpEnd, slot0._checkCardOpEnd, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.DetectCardOpEndAfterOperationEffectDone, slot0._onDetectCardOpEndAfterOperationEffectDone, slot0)
	slot0:addEventCb(GameStateMgr.instance, GameStateEvent.onApplicationPause, slot0._onApplicationPause, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SetCardMagicEffectChange, slot0._setCardMagicEffectChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PlayCardMagicEffectChange, slot0._playCardMagicEffectChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SetBlockCardOperate, slot0._setBlockOperate, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.SpCardAdd, slot0._onSpCardAdd, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.AddHandCard, slot0._onAddHandCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.TempCardRemove, slot0._onTempCardRemove, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ChangeToTempCard, slot0._onChangeToTempCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.CorrectHandCardScale, slot0._onCorrectHandCardScale, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RemoveEntityCards, slot0._onRemoveEntityCards, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.CardRemove, slot0._onCardRemove, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.CardRemove2, slot0._onCardRemove2, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RefreshHandCard, slot0._updateNow, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.CardsCompose, slot0._onCardsCompose, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.CardsComposeTimeOut, slot0._onCardsComposeTimeOut, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.CardLevelChange, slot0._onCardLevelChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.AfterForceUpdatePerformanceData, slot0._onAfterForceUpdatePerformanceData, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, slot0._onClothSkillRoundSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.MasterAddHandCard, slot0._onMasterAddHandCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.MasterCardRemove, slot0._onMasterCardRemove, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.CardAConvertCardB, slot0._onCardAConvertCardB, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, slot0._updateNow, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ForceEndAutoCardFlow, slot0._onForceEndAutoCardFlow, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectCard, slot0.OnKeyPlayCard, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleMoveCardEnd, slot0.onControlRelease, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectLeft, slot0.selectLeftCard, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectRight, slot0.selectRightCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.EnterStage, slot0._onEnterStage, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ExitStage, slot0._onExitStage, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.StageChanged, slot0._onStageChanged, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.EnterOperateState, slot0._onEnterOperateState, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ExitOperateState, slot0._onExitOperateState, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.CardEffectChange, slot0._onCardEffectChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RefreshHandCardPrecisionEffect, slot0._onRefreshHandCardPrecisionEffect, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.LY_CardAreaSizeChange, slot0.onLY_CardAreaSizeChange, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RefreshCardHeatShow, slot0._onRefreshCardHeatShow, slot0)
	slot0:_setBlockOperate(false)
	slot0:_refreshPrecisionShow()
end

function slot0.onClose(slot0)
	FightCardModel.instance:setLongPressIndex(-1)
	TaskDispatcher.cancelTask(slot0._delayCancelBlock, slot0)
	TaskDispatcher.cancelTask(slot0._delayPlayCardsChangeEffect, slot0)
	TaskDispatcher.cancelTask(slot0._combineCardsAfterAddHandCard, slot0)
	TaskDispatcher.cancelTask(slot0._correctActiveCardObjPos, slot0)
	TaskDispatcher.cancelTask(slot0._combineAfterCardLevelChange, slot0)
	TaskDispatcher.cancelTask(slot0._combineAfterCardRemove, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectCard, slot0.OnKeyPlayCard, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleMoveCardEnd, slot0.onControlRelease, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectLeft, slot0.selectLeftCard, slot0)

	slot4 = PCInputEvent.NotifyBattleSelectRight
	slot5 = slot0.selectRightCard

	slot0:removeEventCb(PCInputController.instance, slot4, slot5, slot0)

	for slot4, slot5 in ipairs(slot0._handCardItemList) do
		slot5:releaseSelf()
	end

	if slot0._autoPlayCardFlow then
		slot0._autoPlayCardFlow:stop()

		slot0._autoPlayCardFlow = nil
	end

	slot0._correctHandCardScale:stop()
	slot0._cardDistributeFlow:stop()
	slot0._cardPlayFlow:stop()
	slot0._cardCombineFlow:stop()
	slot0._cardLongPressFlow:stop()
	slot0._cardLongPressEndFlow:stop()
	slot0._cardDragFlow:stop()
	slot0._cardDragEndFlow:stop()
	slot0._cardEndFlow:stop()
	slot0._changeCardFlow:stop()
	slot0._redealCardFlow:stop()
	slot0._universalAppearFlow:stop()
	slot0._magicEffectCardFlow:stop()
end

function slot0._onHandCardFlowCreate(slot0, slot1)
	table.insert(slot0.LyNeedCheckFlowList, slot1)
end

function slot0._onHandCardFlowEnd(slot0, slot1)
	if slot1 == slot0._cardLongPressEndFlow or slot1 == slot0._cardDragEndFlow then
		slot0.longPressing = false
	end

	return slot0:refreshLYAreaActive()
end

function slot0._onHandCardFlowStart(slot0, slot1)
	if slot1 == slot0._cardLongPressFlow then
		slot0.longPressing = true
	end

	return slot0:refreshLYAreaActive()
end

function slot0._onStageChanged(slot0)
	return slot0:refreshLYAreaActive()
end

function slot0.refreshLYAreaActive(slot0)
	if uv0.blockOperate then
		return slot0:setActiveLyRoot(false)
	end

	if slot0.longPressing then
		return slot0:setActiveLyRoot(false)
	end

	if not (FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Normal) then
		return slot0:setActiveLyRoot(false)
	end

	if slot0.LyNeedCheckFlowList then
		for slot6, slot7 in ipairs(slot0.LyNeedCheckFlowList) do
			if slot7.status == WorkStatus.Running then
				return slot0:setActiveLyRoot(false)
			end
		end
	end

	slot0:refreshLyAreaPos()
	slot0:setActiveLyRoot(true)
end

function slot0.setActiveLyRoot(slot0, slot1)
	if FightDataHelper.LYDataMgr.LYCardAreaSize < 1 then
		gohelper.setActive(slot0.goLYAreaRoot, false)

		return
	end

	gohelper.setActive(slot0.goLYAreaRoot, true)

	if slot1 then
		if not slot0.goLYAreaRoot.activeInHierarchy then
			gohelper.setActive(slot0.goLYAreaRoot, true)
			slot0.animatorLyRoot:Play("open", 0, 0)
		end
	else
		gohelper.setActive(slot0.goLYAreaRoot, false)
	end
end

function slot0.onLY_CardAreaSizeChange(slot0)
	slot0:refreshLyCardTag()
	slot0:refreshLYAreaActive()
end

function slot0.refreshLyCardTag(slot0)
	slot2 = FightDataHelper.LYDataMgr.LYCardAreaSize
	slot3 = FightCardModel.instance:getHandCards() and #slot1 or 0

	for slot7 = 1, slot3 do
		if slot0._handCardItemList[slot7] then
			slot8:resetRedAndBlue()

			if slot2 > slot3 - slot7 and slot7 <= slot2 then
				slot8:setActiveBoth(true)
			else
				slot8:setActiveBlue(slot2 > slot3 - slot7)
				slot8:setActiveRed(slot7 <= slot2)
			end
		end
	end
end

function slot0.refreshLyAreaPos(slot0)
	slot1 = math.min(FightDataHelper.LYDataMgr.LYCardAreaSize, FightCardModel.instance:getHandCards() and #slot2 or 0)
	slot6 = slot1 and slot1 > 0 and (FightCardModel.instance:getHandCards() and #slot4 or 0) > 0

	gohelper.setActive(slot0.goRedArea, slot6)
	gohelper.setActive(slot0.goGreenArea, slot6)

	if slot6 then
		slot7 = uv0.calcTotalWidth(slot1, 1) + FightEnum.LYCardAreaWidthOffset

		recthelper.setWidth(slot0.rectTrRedArea, slot7)
		recthelper.setWidth(slot0.rectTrGreenArea, slot7)
		recthelper.setAnchorX(slot0.rectTrGreenArea, -uv0.calcTotalWidth(slot5 - slot1, 1))
	end
end

function slot0._onApplicationPause(slot0, slot1)
	if slot1 and FightModel.instance:getCurStage() == FightEnum.Stage.Card then
		if slot0._cardDragFlow and slot0._cardDragFlow.status == WorkStatus.Running then
			slot0._cardDragFlow:stop()
		end

		if FightCardModel.instance:tryGettingHandCardsByOps(FightCardModel.instance:getCardOps()) then
			slot0:_updateNow()
		else
			FightCardModel.instance:clearCardOps()
			FightRpc.instance:sendResetRoundRequest()
		end
	end
end

function slot0.getHandCardItem(slot0, slot1)
	return slot0._handCardItemList[slot1]
end

function slot0.isPlayCardFlow(slot0)
	return slot0._cardPlayFlow.status == WorkStatus.Running
end

function slot0.isMoveCardFlow(slot0)
	return slot0._cardDragFlow.status == WorkStatus.Running or slot0._cardDragEndFlow.status == WorkStatus.Running
end

function slot0.isCombineCardFlow(slot0)
	return slot0._cardCombineFlow.status == WorkStatus.Running
end

function slot0._checkCardOpEnd(slot0)
	if FightCardModel.instance:isCardOpEnd() and #FightCardModel.instance:getCardOps() > 0 then
		FightController.instance:dispatchEvent(FightEvent.CardOpEnd)

		if slot0._cardEndFlow.status ~= WorkStatus.Running then
			if FightModel.instance:isSeason2() then
				if slot0._autoPlayCardFlow then
					slot0._autoPlayCardFlow:stop()
				end

				slot0:_onCardEndFlowDone()
				FightViewPartVisible.set(nil, , , , true)
				FightController.instance:dispatchEvent(FightEvent.HidePlayCardAllCard)

				return
			end

			slot0:_setBlockOperate(true)
			slot0._cardEndFlow:registerDoneListener(slot0._onCardEndFlowDone, slot0)

			slot1 = slot0:getUserDataTb_()
			slot1.handCardContainer = slot0._handCardGO
			slot1.playCardContainer = gohelper.findChild(slot0.viewGO, "root/playcards")
			slot1.waitCardContainer = gohelper.findChild(slot0.viewGO, "root/waitingArea/inner")
			slot1.handCardItemList = slot0._handCardItemList

			gohelper.setActive(slot0._precisionFrame, false)
			slot0._cardEndFlow:start(slot1)
		end
	end
end

function slot0._onDetectCardOpEndAfterOperationEffectDone(slot0, slot1)
	if slot1 and FightModel.instance:isSeason2() and slot1:isMoveUniversal() then
		slot0:_onCardEndFlowDone()

		return
	end

	slot0:_checkCardOpEnd()
end

function slot0._onCardEndFlowDone(slot0)
	slot1 = FightCardModel.instance:getHandCards()

	FightCardModel.instance:coverCard(slot1)
	FightDataHelper.coverData(slot1, FightLocalDataMgr.instance.handCardMgr:getHandCard())
	FightDataHelper.coverData(slot1, FightDataHelper.handCardMgr:getHandCard())
	slot0:_setBlockOperate(false)
	slot0._cardEndFlow:unregisterDoneListener(slot0._onCardEndFlowDone, slot0)

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

function slot0._onEnterStage(slot0, slot1)
	if slot1 == FightStageMgr.StageType.Play then
		gohelper.setActive(slot0._precisionFrame, false)
		slot0:_setBlockOperate(false)
	end
end

function slot0._onCardEffectChange(slot0, slot1)
	if slot1 == 1 then
		slot0:_refreshPrecisionShow()
	end
end

function slot0._onExitStage(slot0, slot1)
	slot0:_refreshPrecisionShow()
end

function slot0.refreshPreDeleteCard(slot0, slot1)
	slot0.needPreDeleteCardIndexDict = slot0.needPreDeleteCardIndexDict or {}

	tabletool.clear(slot0.needPreDeleteCardIndexDict)

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			if slot6.skillId and lua_fight_card_pre_delete.configDict[slot7] then
				if slot8.left > 0 then
					for slot13 = 1, slot9 do
						slot0.needPreDeleteCardIndexDict[slot5 + slot13] = true
					end
				end

				if slot8.right > 0 then
					for slot14 = 1, slot10 do
						slot0.needPreDeleteCardIndexDict[slot5 - slot14] = true
					end
				end
			end
		end
	end

	for slot5, slot6 in ipairs(slot0._handCardItemList) do
		slot6:refreshPreDeleteImage(slot0.needPreDeleteCardIndexDict and slot0.needPreDeleteCardIndexDict[slot5])
	end
end

function slot0._refreshPrecisionShow(slot0)
	slot0._precisionState = false

	gohelper.setActive(slot0._precisionFrame, false)

	if FightDataHelper.stageMgr:isNormalStage() then
		slot1 = {}

		FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.MySide, slot1)

		slot5 = slot1

		FightDataHelper.entityMgr:getSubList(FightEnum.EntitySide.MySide, slot5)

		for slot5, slot6 in ipairs(slot1) do
			if slot6:hasBuffFeature(FightEnum.BuffFeature.PrecisionRegion) then
				gohelper.setActive(slot0._precisionFrame, true)

				slot0._precisionState = true

				slot0:_detectPlayPrecisionEffect()

				break
			end
		end
	end
end

function slot0._detectPlayPrecisionEffect(slot0)
	if slot0._handCardItemList then
		for slot4, slot5 in ipairs(slot0._handCardItemList) do
			slot6 = slot5:getCardItem()

			if slot4 == 1 then
				if FightCardDataHelper.isPrecision(slot6._cardInfoMO) and slot0._precisionState then
					slot6:showPrecisionEffect()
				else
					slot6:hidePrecisionEffect()
				end
			else
				slot6:hidePrecisionEffect()
			end
		end
	end
end

function slot0._onRefreshHandCardPrecisionEffect(slot0)
	slot0:_detectPlayPrecisionEffect()
end

function slot0._startDistributeCards(slot0)
	slot0:_nextDistributeCards()
end

function slot0._nextDistributeCards(slot0, slot1)
	slot0._correctHandCardScale:stop()
	slot0._cardDistributeFlow:stop()
	slot0._cardCombineFlow:stop()
	slot0._changeCardFlow:stop()
	slot0._redealCardFlow:stop()
	slot0._magicEffectCardFlow:stop()

	if FightCardModel.instance:getDistributeQueueLen() > 0 then
		slot3, slot4 = FightCardModel.instance:dequeueDistribute()

		if canLogNormal then
			slot6 = {}

			for slot10, slot11 in ipairs(slot3) do
				table.insert({}, slot11.skillId)
			end

			for slot10, slot11 in ipairs(slot4) do
				table.insert(slot6, slot11.skillId)
			end

			logNormal(string.format("发牌: before(%s) new(%s)", table.concat(slot5, ","), table.concat(slot6, ",")))
		end

		slot5 = {}

		tabletool.addValues(slot5, slot3)
		tabletool.addValues(slot5, slot4)
		slot0:_updateHandCards(slot5)

		slot7 = slot0:getUserDataTb_()
		slot7.cards = slot5
		slot7.handCardItemList = slot0._handCardItemList
		slot7.oldPosXList = FightCardCombineEffect.getCardPosXList(slot0._handCardItemList)
		slot7.preCombineIndex = slot1
		slot7.preCardCount = #slot3
		slot7.newCardCount = #slot4
		slot7.playCardContainer = gohelper.findChild(slot0.viewGO, "root/playcards")
		slot7.isEnd = slot2 == 1
		slot7.handCardContainer = slot0._handCardContainer

		slot0:_setBlockOperate(true)
		slot0._cardDistributeFlow:registerDoneListener(slot0._onDistributeCards, slot0)
		slot0._cardDistributeFlow:start(slot7)
	else
		slot0:_onDistributeCards()
	end
end

function slot0._onDistributeCards(slot0)
	slot0._cardDistributeFlow:unregisterDoneListener(slot0._onDistributeCards, slot0)
	slot0:_combineCards(slot0._cardDistributeFlow.context and slot0._cardDistributeFlow.context.cards or FightCardModel.instance:getHandCards())
end

function slot0._toAutoPlayCard(slot0)
	if #FightModel.instance.autoPlayCardList > 0 then
		slot0._autoPlayCardFlow = FlowSequence.New()

		slot0._autoPlayCardFlow:addWork(FightAutoBindContractWork.New())
		slot0._autoPlayCardFlow:addWork(FightAutoDetectUpgradeWork.New())

		if slot0._cardPlayFlow and slot0._cardPlayFlow.status == WorkStatus.Running then
			slot0._autoPlayCardFlow:addWork(FightAutoPlayCardWork.New())
		end

		slot2 = 0

		for slot6, slot7 in ipairs(slot1) do
			if slot7:isAssistBossPlayCard() then
				slot0._autoPlayCardFlow:addWork(WorkWaitSeconds.New(0.3))
				slot0._autoPlayCardFlow:addWork(FightAutoPlayAssistBossCardWork.New(slot7))
			elseif slot7:isSeason2ChangeHero() then
				if slot2 + 1 == 3 then
					slot0._autoPlayCardFlow:addWork(WorkWaitSeconds.New(0.1))
					slot0._autoPlayCardFlow:addWork(FightWorkAutoSeason2ChangeHero.New(slot1, slot6))
				end
			elseif slot7:isPlayerFinisherSkill() then
				slot0._autoPlayCardFlow:addWork(WorkWaitSeconds.New(0.1))
				slot0._autoPlayCardFlow:addWork(FightWorkAutoPlayerFinisherSkill.New(slot7))
			else
				slot0._autoPlayCardFlow:addWork(WorkWaitSeconds.New(0.01))
				slot0._autoPlayCardFlow:addWork(FightAutoPlayCardWork.New(slot7))
			end
		end

		slot0._autoPlayCardFlow:addWork(FightAutoDetectForceEndWork.New())
		slot0._autoPlayCardFlow:registerDoneListener(slot0._onAutoPlayCardFlowDone, slot0)
		slot0._autoPlayCardFlow:start()
	else
		slot0:_onCardEndFlowDone()
		FightViewPartVisible.set()
	end
end

function slot0._onForceEndAutoCardFlow(slot0)
	if slot0._autoPlayCardFlow then
		slot0._autoPlayCardFlow:stop()
		slot0:_onCardEndFlowDone()
		FightViewPartVisible.set()
	end
end

function slot0._onAutoPlayCardFlowDone(slot0)
	slot0._autoPlayCardFlow:unregisterDoneListener(slot0._onAutoPlayCardFlowDone, slot0)

	slot0._autoPlayCardFlow = nil
end

function slot0._playHandCard(slot0, slot1, slot2, slot3)
	if FightCardModel.instance:isCardOpEnd() then
		return
	end

	if not FightCardModel.instance:getHandCards()[slot1] then
		slot0:_updateNow()

		return
	end

	if slot0._cardPlayFlow.status == WorkStatus.Running then
		return
	end

	FightController.instance:dispatchEvent(FightEvent.HideCardSkillTips)
	slot0:_setBlockOperate(true)

	slot5.playCanAddExpoint = FightCardDataHelper.playCanAddExpoint(slot4, slot5)
	slot6 = FightCardModel.instance:playHandCardOp(slot1, slot2, slot5.skillId, slot5.uid, slot5)
	slot6.cardColor = FightDataHelper.LYDataMgr:getCardColor(slot4, slot1)
	slot6.cardInfoMO.areaRedOrBlue = slot6.cardColor

	if slot5.heatId ~= 0 then
		slot7 = FightDataHelper.teamDataMgr
		slot8 = slot5.heatId
		slot7.myCardHeatOffset[slot8] = (slot7.myCardHeatOffset[slot8] or 0) + slot7.myData.cardHeat.values[slot8].changeValue

		FightController.instance:dispatchEvent(FightEvent.RefreshCardHeatShow, slot8)
	end

	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, slot6)

	slot7 = nil

	if FightConfig.instance:isUniqueSkill(slot5.skillId) then
		slot8 = FightCardModel.instance:getHandCards()

		while true do
			if #slot8 > 0 then
				slot9 = false

				for slot13 = 1, #slot8 do
					if slot8[slot13].uid == slot5.uid and FightConfig.instance:isUniqueSkill(slot14.skillId) then
						table.insert(slot7 or {}, slot13)
						FightCardModel.instance:simulateDissolveCard(slot13)
						table.remove(slot8, slot13)

						break
					end

					if slot13 == #slot8 then
						slot9 = true
					end
				end

				if slot9 then
					break
				end
			else
				break
			end
		end
	end

	slot8 = false

	if FightCardDataHelper.isDiscard(slot5) then
		slot8 = true
	end

	slot0._cardsForCombines = slot4
	slot9 = slot0:getUserDataTb_()
	slot9.view = slot0
	slot9.cards = slot4
	slot9.from = slot1
	slot9.viewGO = slot0.viewGO
	slot9.handCardTr = slot0._handCardTr
	slot9.handCardItemList = slot0._handCardItemList
	slot9.fightBeginRoundOp = slot6
	slot9.dissolveCardIndexsAfterPlay = slot7
	slot9.needDiscard = slot8
	slot9.param2 = slot3

	slot0._cardPlayFlow:registerDoneListener(slot0._onPlayCardDone, slot0)
	slot0._cardPlayFlow:start(slot9)
	slot0:_playCardAudio(slot5)
end

function slot0._playCardAudio(slot0, slot1)
	if FightReplayModel.instance:isReplay() then
		return
	end

	if not (FightHelper.getEntity(slot1.uid) and slot2:getMO()) then
		return
	end

	if FightEntityDataHelper.isPlayerUid(slot3.id) then
		return
	end

	slot4 = FightCardModel.instance:getCardOps()

	if not FightViewHandCardItemLock.canUseCardSkill(slot1.uid, slot1.skillId, FightBuffHelper.simulateBuffList(slot3, slot4[#slot4])) then
		return
	end

	slot8 = HeroConfig.instance:getHeroCO(slot3.modelId)
	slot9 = nil

	if FightCardModel.instance:getSkillLv(slot1.uid, slot1.skillId) == 1 or slot6 == 2 then
		slot9 = FightAudioMgr.instance:getHeroVoiceRandom(slot7, CharacterEnum.VoiceType.FightCardStar12, slot1.uid)
	elseif slot6 == 3 then
		if not FightAudioMgr.instance:getHeroVoiceRandom(slot7, CharacterEnum.VoiceType.FightCardStar3, slot1.uid) then
			if slot8 and slot8.rare >= 4 then
				slot9 = FightAudioMgr.instance:getHeroVoiceRandom(slot7, CharacterEnum.VoiceType.FightCardStar3, slot1.uid)
			else
				slot9 = FightAudioMgr.instance:getHeroVoiceRandom(slot7, CharacterEnum.VoiceType.FightCardStar12, slot1.uid)
			end
		end
	elseif slot6 == FightEnum.UniqueSkillCardLv then
		slot9 = FightAudioMgr.instance:getHeroVoiceRandom(slot7, CharacterEnum.VoiceType.FightCardUnique, slot1.uid)
	end

	if slot9 then
		FightAudioMgr.instance:playCardAudio(slot1.uid, slot9, slot7)
	end
end

function slot0._onPlayCardDone(slot0, slot1)
	slot0._cardPlayFlow:unregisterDoneListener(slot0._onPlayCardDone, slot0)
	slot0:_updateHandCards(slot0._cardPlayFlow.context.cards or FightCardModel.instance:getHandCards())
	FightController.instance:dispatchEvent(FightEvent.OnPlayCardFlowDone, slot0._cardPlayFlow.context.fightBeginRoundOp)
	FightController.instance:dispatchEvent(FightEvent.PlayCardOver)
	slot0:_detectPlayPrecisionEffect()

	if FightCardModel.instance:isCardOpEnd() then
		slot0:_setBlockOperate(true)

		return
	end
end

function slot0._playRedealCardEffect(slot0, slot1, slot2, slot3)
	slot0._canCombineAfterRedealCards = slot3
	slot4 = slot0:getUserDataTb_()
	slot4.oldCards = slot1
	slot4.newCards = slot2
	slot4.handCardItemList = slot0._handCardItemList

	if #slot2 > #slot0._handCardItemList then
		slot0:_updateHandCards(slot1)
	end

	for slot8, slot9 in ipairs(slot0._handCardItemList) do
		slot9:refreshCardMO(slot8, slot2[slot8])
	end

	slot0:beforeRedealCardFlow()
	slot0._redealCardFlow:registerDoneListener(slot0._onRedealCardDone, slot0)
	slot0._redealCardFlow:start(slot4)
end

function slot0.beforeRedealCardFlow(slot0)
	for slot4, slot5 in ipairs(slot0._handCardItemList) do
		slot5:playASFDAnim("close")
	end
end

function slot0.afterRedealCardFlow(slot0)
	for slot4, slot5 in ipairs(slot0._handCardItemList) do
		slot5:playASFDAnim("open")
	end
end

function slot0._onRedealCardDone(slot0)
	slot0._redealCardFlow:unregisterDoneListener(slot0._onRedealCardDone, slot0)
	slot0:afterRedealCardFlow()
	slot0:_updateNow()

	if slot0._canCombineAfterRedealCards then
		slot0:_combineCards(FightCardModel.instance:getHandCards())
	end
end

function slot0._playChangeCardEffect(slot0, slot1)
	for slot6 = #slot1, 1, -1 do
		if slot1[slot6].cardIndex > #FightCardModel.instance:getHandCards() then
			table.remove(slot1, slot6)
		end
	end

	slot0._changeInfos = slot0._changeInfos or {}

	tabletool.addValues(slot0._changeInfos, slot1)
	FightCardModel.instance:setChanging(true)
	TaskDispatcher.cancelTask(slot0._delayPlayCardsChangeEffect, slot0)
	TaskDispatcher.runDelay(slot0._delayPlayCardsChangeEffect, slot0, 0.03)
end

function slot0._delayPlayCardsChangeEffect(slot0)
	if slot0._changeCardFlow.status ~= WorkStatus.Running then
		slot1 = slot0:getUserDataTb_()
		slot1.changeInfos = slot0._changeInfos
		slot0._changeInfos = nil
		slot1.handCardItemList = slot0._handCardItemList

		slot0:_setBlockOperate(true)
		slot0:addEventCb(FightController.instance, FightEvent.OnCombineCardEnd, slot0._onChangeCombineDone, slot0)
		slot0._changeCardFlow:registerDoneListener(slot0._onChangeCardDone, slot0)
		slot0._changeCardFlow:start(slot1)
	end
end

function slot0._setCardMagicEffectChange(slot0, slot1, slot2, slot3)
	slot0._card_magic_effect_change_info = slot0._card_magic_effect_change_info or {}
	slot0._card_magic_effect_change_info[slot1] = {
		old_effect = slot2,
		new_effect = slot3
	}
end

function slot0._playCardMagicEffectChange(slot0)
	slot1 = slot0:getUserDataTb_()
	slot1.changeInfos = slot0._card_magic_effect_change_info
	slot1.handCardItemList = slot0._handCardItemList
	slot0._card_magic_effect_change_info = nil

	slot0:_setBlockOperate(true)
	slot0._magicEffectCardFlow:registerDoneListener(slot0._onMagicEffectCardFlowDone, slot0)
	slot0._magicEffectCardFlow:start(slot1)
end

function slot0._onMagicEffectCardFlowDone(slot0)
	slot0._magicEffectCardFlow:unregisterDoneListener(slot0._onMagicEffectCardFlowDone, slot0)
	slot0:_combineCards(FightCardModel.instance:getHandCards())
end

function slot0._onChangeCardDone(slot0)
	slot0._changeCardFlow:unregisterDoneListener(slot0._onChangeCardDone, slot0)
	slot0:_onChangeOrRedealCardDone(slot0._changeCardFlow.context.changeInfos)
end

function slot0._onChangeOrRedealCardDone(slot0, slot1)
	if slot1 then
		slot2 = slot0:_filterInvalidCard(FightCardModel.instance:getHandCards())

		for slot6, slot7 in ipairs(slot1) do
			slot9 = slot7.cardInfo

			if slot2[slot7.cardIndex] then
				if slot9 then
					slot10:init(slot9)
				else
					slot10.uid = slot7.entityId
					slot10.skillId = slot7.targetSkillId
				end
			else
				logError(string.format("更换当前手牌中的第%d张牌的数据,但是并没有找到这张牌", slot8))
			end
		end

		FightCardModel.instance:clearCardOps()
		FightCardModel.instance:coverCard(slot2)
		slot0:_updateNow()
		slot0:_combineCards(slot2)
	end
end

function slot0._onRedealCombineDone(slot0, slot1)
	FightCardModel.instance:clearCardOps()
	FightCardModel.instance:coverCard(slot1)
	slot0:removeEventCb(FightController.instance, FightEvent.OnCombineCardEnd, slot0._onRedealCombineDone, slot0)
	FightController.instance:dispatchEvent(FightEvent.OnChangeCardEffectDone)
	slot0:_setBlockOperate(false)
end

function slot0._onChangeCombineDone(slot0, slot1)
	FightCardModel.instance:clearCardOps()
	FightCardModel.instance:coverCard(slot1)
	slot0:removeEventCb(FightController.instance, FightEvent.OnCombineCardEnd, slot0._onChangeCombineDone, slot0)

	if slot0._changeInfos and #slot0._changeInfos > 0 then
		TaskDispatcher.cancelTask(slot0._delayPlayCardsChangeEffect, slot0)
		TaskDispatcher.runDelay(slot0._delayPlayCardsChangeEffect, slot0, 0.03)
	else
		FightCardModel.instance:setChanging(false)
		FightController.instance:dispatchEvent(FightEvent.OnChangeCardEffectDone)
		slot0:_setBlockOperate(false)
	end
end

function slot0._playUniversalAppear(slot0, slot1)
	slot0:_setBlockOperate(true)

	slot2 = FightCardModel.instance:getHandCards()

	table.insert(slot2, slot1)
	FightCardModel.instance:coverCard(slot2)
	slot0:_updateNow()

	slot3 = slot0:getUserDataTb_()
	slot3.handCardItemList = slot0._handCardItemList

	slot0._universalAppearFlow:start(slot3)
	slot0._universalAppearFlow:registerDoneListener(slot0._onUniversalAppearDone, slot0)
end

function slot0._onSpCardAdd(slot0, slot1)
	slot0:_playCorrectHandCardScale(0)
	slot0:_updateHandCards(FightCardModel.instance:getHandCards(), slot1)

	slot3 = slot0._handCardItemList[slot1]

	gohelper.setActive(slot3.go, false)
	slot3:playCardAni(ViewAnim.FightCardBalance)
end

function slot0._onCorrectHandCardScale(slot0, slot1)
	slot0:_playCorrectHandCardScale(slot1)
end

function slot0._playCorrectHandCardScale(slot0, slot1, slot2)
	slot0._correctHandCardScale:stop()

	slot3 = slot0:getUserDataTb_()
	slot3.cards = tabletool.copy(FightCardModel.instance:getHandCards())
	slot3.oldScale = slot1
	slot3.newScale = slot2
	slot3.handCardContainer = slot0._handCardContainer

	slot0._correctHandCardScale:start(slot3)
end

function slot0._onCardsCompose(slot0)
	slot0:_combineCards(FightCardModel.instance:getHandCards())
end

function slot0._onCardsComposeTimeOut(slot0)
	if slot0._cardCombineFlow then
		slot0._cardCombineFlow:stop()
	end

	slot0:_updateNow()
end

function slot0._onRemoveEntityCards(slot0, slot1)
	for slot5 = #slot0._handCardItemList, 1, -1 do
		if slot0._handCardItemList[slot5].go.activeInHierarchy and slot6:dissolveEntityCard(slot1) then
			table.insert(slot0._handCardItemList, table.remove(slot0._handCardItemList, slot5))
		end
	end

	TaskDispatcher.cancelTask(slot0._correctActiveCardObjPos, slot0)
	TaskDispatcher.runDelay(slot0._correctActiveCardObjPos, slot0, 1 / FightModel.instance:getUISpeed())
end

function slot0._onCardLevelChange(slot0, slot1, slot2, slot3, slot4)
	if slot0._handCardItemList[slot2] then
		slot5:playCardLevelChange(slot1, slot3)
	end

	if slot4 then
		TaskDispatcher.cancelTask(slot0._combineAfterCardLevelChange, slot0)
		TaskDispatcher.runDelay(slot0._combineAfterCardLevelChange, slot0, FightEnum.PerformanceTime.CardLevelChange / FightModel.instance:getUISpeed())
	end
end

function slot0._combineAfterCardLevelChange(slot0)
	slot0:_combineCards(FightCardModel.instance:getHandCards())
end

function slot0._onPlayCombineCards(slot0, slot1)
	slot0:_combineCards(slot1)
end

function slot0._onCardRemove(slot0, slot1, slot2, slot3)
	slot0:_onCardRemove2(slot1)

	if slot3 then
		TaskDispatcher.cancelTask(slot0._combineAfterCardRemove, slot0)
		TaskDispatcher.runDelay(slot0._combineAfterCardRemove, slot0, slot2 / FightModel.instance:getUISpeed())
	end
end

function slot0._combineAfterCardRemove(slot0)
	slot0:_combineCards(FightCardModel.instance:getHandCards())
end

function slot0._onCardRemove2(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		if table.remove(slot0._handCardItemList, slot6) and slot7.go.activeInHierarchy then
			slot7:dissolveCard()
			table.insert(slot0._handCardItemList, slot7)
		end
	end

	TaskDispatcher.cancelTask(slot0._correctActiveCardObjPos, slot0)
	TaskDispatcher.runDelay(slot0._correctActiveCardObjPos, slot0, 1 / FightModel.instance:getUISpeed())
end

function slot0._correctActiveCardObjPos(slot0)
	slot1 = 0

	for slot5 = 1, #slot0._handCardItemList do
		slot6 = slot0._handCardItemList[slot5]
		slot6.index = slot5
		slot6.go.name = "cardItem" .. slot5

		if not slot6.go.activeInHierarchy then
			break
		end

		if math.abs(recthelper.getAnchorX(slot7.transform) - uv0.calcCardPosX(slot5)) >= 10 then
			slot6:moveSelfPos(slot5, slot1, slot9)

			slot1 = slot1 + 1
		end
	end
end

function slot0._onAddHandCard(slot0, slot1, slot2)
	slot0:_playCorrectHandCardScale(0)

	slot3 = FightCardModel.instance:getHandCards()
	slot4 = #slot3

	slot0:_updateHandCards(slot3, slot4)
	slot0._handCardItemList[slot4]:playDistribute()

	if slot2 then
		TaskDispatcher.runDelay(slot0._combineCardsAfterAddHandCard, slot0, 0.5 / FightModel.instance:getUISpeed())
	end
end

function slot0._onMasterAddHandCard(slot0, slot1, slot2)
	slot0:_playCorrectHandCardScale(0)

	slot3 = FightCardModel.instance:getHandCards()
	slot4 = #slot3

	slot0:_updateHandCards(slot3, slot4)
	slot0._handCardItemList[slot4]:playMasterAddHandCard()

	if slot2 then
		TaskDispatcher.runDelay(slot0._combineCardsAfterAddHandCard, slot0, 1 / FightModel.instance:getUISpeed())
	end
end

function slot0._onMasterCardRemove(slot0, slot1, slot2, slot3)
	for slot7, slot8 in ipairs(slot1) do
		if table.remove(slot0._handCardItemList, slot8) and slot9.go.activeInHierarchy then
			slot9:playMasterCardRemove()
			table.insert(slot0._handCardItemList, slot9)
		end
	end

	TaskDispatcher.cancelTask(slot0._correctActiveCardObjPos, slot0)
	TaskDispatcher.runDelay(slot0._correctActiveCardObjPos, slot0, 0.7 / FightModel.instance:getUISpeed())

	if slot3 then
		TaskDispatcher.cancelTask(slot0._combineAfterCardRemove, slot0)
		TaskDispatcher.runDelay(slot0._combineAfterCardRemove, slot0, slot2 / FightModel.instance:getUISpeed())
	end
end

function slot0._combineCardsAfterAddHandCard(slot0)
	slot0:_combineCards(FightCardModel.instance:getHandCards())
end

function slot0._onCardAConvertCardB(slot0, slot1)
	if slot0._handCardItemList[slot1] then
		slot3:playCardAConvertCardB()
		slot3:updateItem(slot1, FightCardModel.instance:getHandCards()[slot1])
	else
		slot0:_updateNow()
	end
end

function slot0._onTempCardRemove(slot0)
	slot0:_updateNow()
	slot0:_combineCards(FightCardModel.instance:getHandCards())
end

function slot0._onChangeToTempCard(slot0, slot1)
	if slot0._handCardItemList[slot1] then
		slot2:changeToTempCard()
	end
end

function slot0._onUniversalAppearDone(slot0)
	slot0._universalAppearFlow:unregisterDoneListener(slot0._onUniversalAppearDone, slot0)
	slot0:_setBlockOperate(false)
	FightController.instance:dispatchEvent(FightEvent.OnUniversalAppear)
end

function slot0._combineCards(slot0, slot1, slot2, slot3)
	slot0._combineIndex = slot2 or FightCardModel.getCombineIndexOnce(slot1)
	slot0._isUniversalCombine = slot2 and true or false

	if slot0._combineIndex then
		slot0._cardsForCombines = slot1
		slot4 = slot0:getUserDataTb_()
		slot4.cards = slot1
		slot4.combineIndex = slot0._combineIndex
		slot4.handCardItemList = slot0._handCardItemList
		slot4.fightBeginRoundOp = slot3

		slot0._cardCombineFlow:registerDoneListener(slot0._onCombineCardDone, slot0)
		slot0._cardCombineFlow:start(slot4)
	else
		slot0:_setBlockOperate(false)
		FightCardModel.instance:setDissolving(false)
		FightController.instance:dispatchEvent(FightEvent.OnCombineCardEnd, slot1)

		if FightModel.instance:getCurStage() == FightEnum.Stage.Distribute or slot4 == FightEnum.Stage.FillCard then
			if FightCardModel.instance:getDistributeQueueLen() > 0 then
				slot0:_nextDistributeCards(#slot1)
			else
				gohelper.destroy(gohelper.findChild(slot0._handCardGO, "CombineEffect"))

				for slot9, slot10 in ipairs(slot1) do
					table.insert({}, slot10.skillId)
				end

				if slot4 == FightEnum.Stage.Distribute then
					logNormal("发牌结果" .. table.concat(slot5, ","))
				else
					logNormal("补牌结果" .. table.concat(slot5, ","))
				end

				FightCardModel.instance:clearCardOps()
				FightCardModel.instance:coverCard(slot1)
				slot0:_updateNow()
				FightController.instance:dispatchEvent(FightEvent.OnDistributeCards)
			end
		elseif slot4 == FightEnum.Stage.AutoCard and slot0._autoPlayCardFlow and slot0._autoPlayCardFlow.status == WorkStatus.Running then
			FightController.instance:dispatchEvent(FightEvent.OneAutoPlayCardFinish)
		end

		if slot3 then
			FightController.instance:dispatchEvent(FightEvent.PlayOperationEffectDone, slot3)
			slot0:_detectPlayPrecisionEffect()
		end
	end
end

function slot0._onCombineCardDone(slot0, slot1)
	slot0._cardCombineFlow:unregisterDoneListener(slot0._onCombineCardDone, slot0)
	FightController.instance:dispatchEvent(FightEvent.OnCombineOneCard, slot0._cardsForCombines[slot0._combineIndex], slot0._isUniversalCombine)
	slot0:_combineCards(slot0._cardsForCombines, nil, slot0._cardCombineFlow.context.fightBeginRoundOp)
end

function slot0._resetCard(slot0, slot1)
	FightCardModel.instance:resetCardOps()
	FightDataHelper.paTaMgr:resetOp()
	FightController.instance:dispatchEvent(FightEvent.OnResetCard, slot1)

	if slot0._cardPlayFlow.status == WorkStatus.Running then
		slot0._cardPlayFlow:stop()
	end
end

function slot0._updateNow(slot0)
	slot0:_updateHandCards(FightCardModel.instance:getHandCards())
end

function slot0._filterInvalidCard(slot0, slot1)
	for slot5 = #slot1, 1, -1 do
		if not lua_skill.configDict[slot1[slot5].skillId] then
			if not slot6 then
				logError("手牌数据没有skillId,请保存复现数据找开发看看")
			else
				logError("技能表找不到id:" .. slot6)
			end

			table.remove(slot1, slot5)
		end
	end

	return slot1
end

function slot0._updateHandCards(slot0, slot1, slot2)
	slot3 = slot0:_filterInvalidCard(slot1) and #slot1 or 0

	for slot7 = slot2 or 1, slot3 do
		if not slot0._handCardItemList[slot7] then
			table.insert(slot0._handCardItemList, MonoHelper.addLuaComOnceToGo(gohelper.clone(slot0._handCardItemPrefab, slot0._handCardGO), FightViewHandCardItem, slot0))
		end

		slot8.go.name = "cardItem" .. slot7

		recthelper.setAnchor(slot8.tr, uv0.calcCardPosX(slot7), 0)
		gohelper.setActive(slot8.go, true)
		transformhelper.setLocalScale(slot8.tr, 1, 1, 1)
		slot8:updateItem(slot7, slot1[slot7])
		gohelper.setAsLastSibling(slot8.go)
	end

	for slot7 = slot3 + 1, #slot0._handCardItemList do
		slot8 = slot0._handCardItemList[slot7]

		gohelper.setActive(slot8.go, false)

		slot8.go.name = "cardItem" .. slot7

		slot8:updateItem(slot7, nil)
	end

	slot0:refreshPreDeleteCard(slot1)
	slot0:refreshLyCardTag()
end

function slot0._setBlockOperate(slot0, slot1)
	uv0.blockOperate = slot1 and true or false

	if not gohelper.isNil(slot0._handCardGOCanvasGroup) then
		slot0._handCardGOCanvasGroup.blocksRaycasts = not slot1
	end

	if slot1 then
		TaskDispatcher.cancelTask(slot0._delayCancelBlock, slot0)
		TaskDispatcher.runDelay(slot0._delayCancelBlock, slot0, 10)
	else
		TaskDispatcher.cancelTask(slot0._delayCancelBlock, slot0)
	end

	slot0:refreshLYAreaActive()
end

function slot0._delayCancelBlock(slot0)
	slot0:_setBlockOperate(false)
end

function slot0._onAfterForceUpdatePerformanceData(slot0)
	slot0:_updateNow()
end

function slot0._onRoundSequenceFinish(slot0)
	slot0:_updateNow()
end

function slot0._onClothSkillRoundSequenceFinish(slot0)
end

function slot0._onDragHandCardBegin(slot0, slot1, slot2)
	if slot0._cardDragFlow.status == WorkStatus.Running then
		return
	end

	if slot0._cardLongPressFlow.status == WorkStatus.Running then
		slot0._cardLongPressFlow:stop()
		slot0._cardLongPressFlow:reset()
	end

	slot0._dragBeginCards = FightCardModel.instance:getHandCards()
	slot0._cardCount = #slot0._dragBeginCards

	if slot0._cardCount < slot1 then
		return
	end

	slot3 = slot0:getUserDataTb_()
	slot3.index = slot1
	slot3.position = slot2
	slot3.cardCount = slot0._cardCount
	slot3.handCardItemList = slot0._handCardItemList
	slot3.handCardTr = slot0._handCardTr
	slot3.handCards = slot0._dragBeginCards

	slot0._cardDragFlow:start(slot3)
	slot0._handCardItemList[slot1]:stopLongPressEffect()
	FightController.instance:dispatchEvent(FightEvent.HideCardSkillTips)
end

function slot0._onDragHandCardEnd(slot0, slot1, slot2)
	if slot0._cardCount < slot1 then
		slot0:_updateNow()

		return
	end

	slot0._cardDragFlow:stop()
	slot0._cardDragFlow:reset()

	slot0._dragIndex = slot1
	slot4, slot5, slot6 = transformhelper.getLocalScale(slot0._handCardItemList[slot1].tr)
	slot0._targetIndex = uv0.calcCardIndexDraging(recthelper.screenPosToAnchorPos(slot2, slot0._handCardTr).x - uv0.HalfWidth, slot0._cardCount, 1)
	slot8 = slot0:getUserDataTb_()
	slot8.index = slot1
	slot8.targetIndex = slot0._targetIndex
	slot8.cardCount = slot0._cardCount
	slot8.handCardItemList = slot0._handCardItemList
	slot8.handCardTr = slot0._handCardTr
	slot8.handCards = slot0._dragBeginCards

	slot0._cardDragEndFlow:registerDoneListener(slot0._onDragEndFlowDone, slot0)
	slot0._cardDragEndFlow:start(slot8)
	slot0:_setBlockOperate(true)
end

function slot0._onDragEndFlowDone(slot0)
	slot0._cardDragEndFlow:unregisterDoneListener(slot0._onDragEndFlowDone, slot0)

	if not slot0:_checkGuideMoveCard(slot0._dragIndex, slot0._targetIndex) then
		return
	end

	slot3 = slot0._dragBeginCards
	slot3[slot1].moveCanAddExpoint = FightCardDataHelper.moveCanAddExpoint(slot3, slot3[slot1])

	if FightEnum.UniversalCard[slot3[slot1].skillId] and not FightCardModel.instance:getBeCombineCardMO() then
		slot0:_updateNow()
		slot0:_setBlockOperate(false)

		return
	end

	if (slot3[slot1].uid == FightEntityScene.MySideId or slot3[slot1].uid == FightEntityScene.EnemySideId) and not FightEnum.UniversalCard[slot5] then
		slot0:_updateNow()
		slot0:_setBlockOperate(false)

		return
	end

	slot0:_moveCardItemInList(slot1, slot2)

	if not FightCardModel.instance:isCardOpEnd() then
		slot6 = nil
		slot7 = slot3[slot1]
		slot9 = tabletool.indexOf(slot3, slot4)

		if slot4 and slot8 then
			if slot2 < slot8 then
				slot9 = slot2
			end

			slot6 = FightCardModel.instance:moveUniversalCardOp(slot1, slot8, slot7.skillId, slot7.uid, slot2)
		else
			slot6 = FightCardModel.instance:moveHandCardOp(slot1, slot2, slot7.skillId, slot7.uid)
		end

		FightCardModel.moveOnly(slot3, slot1, slot2)

		if slot1 ~= slot2 then
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_FightMoveCardEnd)
		end

		slot0:_updateHandCards(slot3)
		FightController.instance:dispatchEvent(FightEvent.OnMoveHandCard, slot7, slot1, slot2)
		FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, slot6)
		slot0:_combineCards(slot3, slot9, slot6)
	else
		slot0:_updateHandCards(slot3)

		if not FightReplayModel.instance:isReplay() then
			-- Nothing
		end

		slot0:_setBlockOperate(false)
	end
end

function slot0._moveCardItemInList(slot0, slot1, slot2)
	if not slot0._handCardItemList or not slot0._handCardItemList[slot1] or not slot0._handCardItemList[slot2] then
		return
	end

	if slot1 == slot2 then
		return
	end

	slot3 = slot0._handCardItemList[slot1]
	slot4 = slot1 < slot2 and 1 or -1

	for slot8 = slot1, slot2 - slot4, slot4 do
		slot0._handCardItemList[slot8] = slot0._handCardItemList[slot8 + slot4]
	end

	slot0._handCardItemList[slot2] = slot3
end

function slot0._playCardItemInList(slot0, slot1)
	if not slot0._handCardItemList or not slot0._handCardItemList[slot1] then
		return
	end

	slot0:_moveCardItemInList(slot1, #slot0._handCardItemList)
end

function slot0._checkGuideMoveCard(slot0, slot1, slot2)
	if GuideModel.instance:getFlagValue(GuideModel.GuideFlag.FightMoveCard) then
		if slot1 == slot3.from then
			slot5 = false

			for slot10, slot11 in ipairs(slot3.tos) do
				if slot2 == slot11 then
					slot5 = true

					break
				end
			end

			slot4 = slot5
		end

		if slot4 then
			FightController.instance:dispatchEvent(FightEvent.OnGuideDragCard)

			return true
		else
			slot0:_resetCard({})
			slot0:_setBlockOperate(false)

			return false
		end
	end

	return true
end

function slot0.selectLeftCard(slot0)
	if slot0._longPressIndex == nil then
		for slot5, slot6 in pairs(slot0._handCardItemList) do
			if slot6.go.activeInHierarchy and 1 < slot6.index then
				slot1 = slot6.index
			end
		end

		slot0:OnkeyLongPress(slot1)
	else
		if slot0._longPressIndex + 1 > #slot0._handCardItemList then
			return
		end

		if slot0._handCardItemList[slot0._longPressIndex + 1] and not slot1.go.activeInHierarchy then
			return
		end

		slot0:OnkeyLongPress(slot0._longPressIndex + 1)
	end
end

function slot0.selectRightCard(slot0)
	if slot0._longPressIndex == nil then
		for slot5, slot6 in pairs(slot0._handCardItemList) do
			if slot6.go.activeInHierarchy and slot6.index < 1 then
				slot1 = slot6.index
			end
		end

		slot0:OnkeyLongPress(slot1)
	else
		if slot0._longPressIndex - 1 < 1 then
			return
		end

		slot0:OnkeyLongPress(slot0._longPressIndex - 1)
	end
end

function slot0.OnKeyPlayCard(slot0, slot1)
	if ViewMgr.instance:IsPopUpViewOpen() then
		return
	end

	slot0:_longPressHandCardEnd()

	for slot6, slot7 in pairs(slot0._handCardItemList) do
		if slot7.index == #FightCardModel.instance:getHandCards() - slot1 + 1 and slot7.go.activeInHierarchy then
			slot7:_onClickThis()
		end
	end
end

function slot0.OnkeyLongPress(slot0, slot1)
	if FightReplayModel.instance:isReplay() then
		return
	end

	slot0:_longPressHandCardEnd()
	FightController.instance:dispatchEvent(FightEvent.HideCardSkillTips)

	for slot5, slot6 in pairs(slot0._handCardItemList) do
		if slot6.index == slot1 and slot6.go.activeInHierarchy then
			slot6:_onLongPress()
		end
	end
end

function slot0.onControlRelease(slot0)
	if not slot0._longPressIndex then
		return
	end

	for slot4, slot5 in pairs(slot0._handCardItemList) do
		if slot5 and slot5.index == slot0._longPressIndex then
			slot5:_onClickThis()
		end
	end
end

function slot0.OnSeleCardMoveEnd(slot0)
	slot0._keyDrag = false

	FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCardEnd, slot0.startDragIndex, slot0.dragIndex)

	slot0.dragIndex = nil
	slot0.curLongPress = nil
end

function slot0.getLongPressItemIndex(slot0)
	for slot4, slot5 in pairs(slot0._handCardItemList) do
		if slot5 and slot5._isLongPress then
			return slot5
		end
	end

	return nil
end

function slot0._longPressHandCard(slot0, slot1)
	slot0:_longPressHandCardEnd()

	if slot0._cardDragFlow.status == WorkStatus.Running then
		return
	end

	if slot0._cardLongPressFlow.status == WorkStatus.Running then
		return
	end

	FightCardModel.instance:setLongPressIndex(slot1)

	slot0._longPressIndex = slot1
	slot0._clearPressIndex = false
	slot0._cardCount = #FightCardModel.instance:getHandCards()
	slot2 = slot0:getUserDataTb_()
	slot2.index = slot1
	slot2.cardCount = slot0._cardCount
	slot2.handCardItemList = slot0._handCardItemList

	slot0._cardLongPressFlow:registerDoneListener(slot0._onLongPressFlowDone, slot0)
	slot0._cardLongPressFlow:start(slot2)
	slot0._handCardItemList[slot1]:playLongPressEffect()
end

function slot0._onLongPressFlowDone(slot0)
	slot0._cardLongPressFlow:unregisterDoneListener(slot0._onLongPressFlowDone, slot0)
end

function slot0._longPressHandCardEnd(slot0, slot1)
	if not (slot1 or slot0._longPressIndex) then
		return
	end

	slot0._handCardItemList[slot1]:stopLongPressEffect()
	slot0._handCardItemList[slot1]:onLongPressEnd()

	if slot0._cardLongPressFlow.status == WorkStatus.Running then
		slot0._cardLongPressFlow:stop()
		slot0._cardLongPressFlow:reset()
	end

	slot0._clearPressIndex = true
	slot2 = slot0:getUserDataTb_()
	slot2.index = slot1
	slot2.cardCount = slot0._cardCount
	slot2.handCardItemList = slot0._handCardItemList

	slot0._cardLongPressEndFlow:registerDoneListener(slot0._onLongPressEndFlowDone, slot0)
	slot0._cardLongPressEndFlow:start(slot2)

	slot0._longPressIndex = nil
end

function slot0._onLongPressEndFlowDone(slot0)
	if slot0._clearPressIndex then
		slot0._longPressIndex = nil

		FightCardModel.instance:setLongPressIndex(-1)
	end

	slot0._cardLongPressEndFlow:unregisterDoneListener(slot0._onLongPressEndFlowDone, slot0)
end

function slot0._onEnterOperateState(slot0, slot1)
	if slot1 == FightStageMgr.OperateStateType.Discard then
		slot0._abandonTran:SetAsLastSibling()
		gohelper.setActive(slot0._abandon, true)
		slot0._playCardTransform:SetAsLastSibling()

		for slot6 = 1, #slot0._handCardItemList do
			if slot0._handCardItemList[slot6] then
				if slot7.go.activeInHierarchy then
					slot2 = 0 + 1
				else
					break
				end

				slot9 = false

				if FightDataHelper.entityMgr:getById(slot7.cardInfoMO.uid) then
					if not slot10:isUniqueSkill(slot8.skillId) then
						slot9 = true
					end
				else
					slot9 = true
				end

				if slot9 then
					slot7.go.transform:SetParent(slot0._abandonCardRootTran, true)
				end
			end
		end

		recthelper.setWidth(slot0._abandonLine, slot2 * uv0 + 20)
	end
end

function slot0.cancelAbandonState(slot0)
	gohelper.setActive(slot0._abandon, false)

	for slot5 = slot0._abandonCardRootTran.childCount - 1, 0, -1 do
		slot0._abandonCardRootTran:GetChild(slot5):SetParent(slot0._handCardTr, true)
	end

	slot0._playCardTransform:SetSiblingIndex(uv0.playCardSiblingIndex)
end

function slot0._onExitOperateState(slot0, slot1)
	if slot1 == FightStageMgr.OperateStateType.Discard then
		slot0:cancelAbandonState()
	end
end

function slot0._onRefreshCardHeatShow(slot0, slot1)
	if slot0._handCardItemList then
		for slot5, slot6 in ipairs(slot0._handCardItemList) do
			slot6:showCardHeat()
		end
	end
end

function slot0.calcCardPosXDraging(slot0, slot1, slot2, slot3)
	slot5 = uv0.calcTotalWidth(slot1, slot3) / (slot1 - 1 + slot3)

	if slot0 < slot2 then
		return -0.5 * slot5 - slot5 * (slot0 - 1)
	elseif slot2 < slot0 then
		return -0.5 * slot5 - slot5 * (slot0 - 1) - (slot3 - 1) * slot5
	else
		return -0.5 * slot5 - slot5 * (slot0 - 2) - (slot3 * 0.5 + 0.5) * slot5
	end
end

function slot0.calcCardIndexDraging(slot0, slot1, slot2)
	return Mathf.Clamp(math.floor(-slot0 / (uv0.calcTotalWidth(slot1, slot2) / (slot1 - 1 + slot2)) - slot2 * 0.5 + 1 + 0.5), 1, slot1)
end

function slot0.calcTotalWidth(slot0, slot1)
	return slot0 * uv0 + (slot1 - 1) * uv0 * 0.5
end

function slot0.calcCardPosX(slot0)
	return -1 * uv0 * (slot0 - 1) - uv0 / 2
end

return slot0
