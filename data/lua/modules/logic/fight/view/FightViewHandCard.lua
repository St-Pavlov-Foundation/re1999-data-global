-- chunkname: @modules/logic/fight/view/FightViewHandCard.lua

module("modules.logic.fight.view.FightViewHandCard", package.seeall)

local FightViewHandCard = class("FightViewHandCard", FightBaseView)
local HandCardHeight = 256
local HandCardWidth = 185

FightViewHandCard.blockOperate = false

function FightViewHandCard:onInitView()
	self.skinDownEffectRoot = gohelper.findChild(self.viewGO, "root/hand_card_skin_down")
	self.skinUpEffectRoot = gohelper.findChild(self.viewGO, "root/hand_card_skin_up")
	self._handCardContainer = gohelper.findChild(self.viewGO, "root/handcards")
	self._handCardGO = gohelper.findChild(self.viewGO, "root/handcards/handcards")
	self._handCardTransform = self._handCardContainer.transform
	FightViewHandCard.handCardSiblingIndex = self._handCardTransform:GetSiblingIndex()
	self._playCardTransform = gohelper.findChild(self.viewGO, "root/playcards").transform
	FightViewHandCard.playCardSiblingIndex = self._playCardTransform:GetSiblingIndex()
	self._abandon = gohelper.findChild(self.viewGO, "root/abandon")
	self._abandonLine = gohelper.findChild(self.viewGO, "root/abandon/rightBottom/line").transform

	gohelper.setActive(self._abandon, false)

	self._abandonTran = self._abandon.transform
	self._abandonCardRoot = gohelper.findChild(self.viewGO, "root/abandon/cardRoot")
	self._abandonCardRootTran = self._abandonCardRoot.transform
	self._precisionFrame = gohelper.findChild(self.viewGO, "root/handcards/areaFrameRoot")

	gohelper.setActive(self._precisionFrame, false)

	self._handCardGOCanvasGroup = gohelper.onceAddComponent(self._handCardGO, typeof(UnityEngine.CanvasGroup))
	self._handCardTr = self._handCardGO.transform
	self._handCardItemPrefab = gohelper.findChild(self.viewGO, "root/handcards/handcards/cardItem")

	gohelper.setActive(self._handCardItemPrefab, false)

	self._handCardItemList = {}

	self:_setBlockOperate(false)

	self.areaSize = 0
	self.LyNeedCheckFlowList = {}

	self:initRedOrBlueArea()
	self:addEventCb(FightController.instance, FightEvent.OnHandCardFlowCreate, self._onHandCardFlowCreate, self)
	self:addEventCb(FightController.instance, FightEvent.OnHandCardFlowStart, self._onHandCardFlowStart, self)
	self:addEventCb(FightController.instance, FightEvent.OnHandCardFlowEnd, self._onHandCardFlowEnd, self)

	FightViewHandCard.handCardContainer = self._handCardContainer
	FightViewHandCard.HalfWidth = recthelper.getWidth(self._handCardTr) / 2
	FightViewHandCard.HalfItemWidth = recthelper.getWidth(self._handCardItemPrefab.transform) / 2
	FightViewHandCard.HandCardWidth = HandCardWidth
	FightViewHandCard.HandCardHeight = HandCardHeight
	self._correctHandCardScale = FightViewHandCardSequenceFlow.New()

	self._correctHandCardScale:addWork(FigthCardDistributeCorrectScale.New())

	self._cardDistributeFlow = FightViewHandCardParallelFlow.New()

	self._cardDistributeFlow:addWork(FigthCardDistributeCorrectScale.New())
	self._cardDistributeFlow:addWork(FigthCardDistributeEffect.New())
	self._cardDistributeFlow:addWork(FightCardCombineEndEffect.New())

	self._cardCombineFlow = FightViewHandCardSequenceFlow.New()

	self._cardCombineFlow:addWork(FightCardCombineEffect.New())

	self._cardLongPressFlow = FightViewHandCardSequenceFlow.New()

	self._cardLongPressFlow:addWork(FightCardLongPressEffect.New())

	self._cardLongPressEndFlow = FightViewHandCardSequenceFlow.New()

	self._cardLongPressEndFlow:addWork(FightCardLongPressEndEffect.New())

	self._cardDragFlow = FightViewHandCardSequenceFlow.New()

	self._cardDragFlow:addWork(FightCardDragEffect.New())

	self._cardDragEndFlow = FightViewHandCardSequenceFlow.New()

	self._cardDragEndFlow:addWork(FightCardDragEndEffect.New())

	self._redealCardFlow = FightViewHandCardSequenceFlow.New()

	self._redealCardFlow:addWork(FightCardRedealEffect.New())

	self._universalAppearFlow = FightViewHandCardSequenceFlow.New()

	self._universalAppearFlow:addWork(FightCardUniversalAppearEffect.New())

	self._magicEffectCardFlow = FightViewHandCardSequenceFlow.New()

	self._magicEffectCardFlow:addWork(FightCardChangeMagicEffect.New())
end

function FightViewHandCard:initRedOrBlueArea()
	self.goLYAreaRoot = gohelper.findChild(self.viewGO, "root/handcards/LiangyueframeRoot")
	self.animatorLyRoot = self.goLYAreaRoot:GetComponent(gohelper.Type_Animator)
	self.goRedArea = gohelper.findChild(self.goLYAreaRoot, "redarea")
	self.goGreenArea = gohelper.findChild(self.goLYAreaRoot, "greenarea")
	self.rectTrRedArea = self.goRedArea:GetComponent(gohelper.Type_RectTransform)
	self.rectTrGreenArea = self.goGreenArea:GetComponent(gohelper.Type_RectTransform)
end

function FightViewHandCard:onDestroyView()
	FightViewHandCard.handCardContainer = nil
	self.LyNeedCheckFlowList = nil
end

function FightViewHandCard:addEvents()
	self:com_registMsg(FightMsgId.RegistPlayHandCardWork, self.onRegistPlayHandCardWork)
	self:com_registMsg(FightMsgId.RegistCardEndAniFlow, self.onRegistCardEndAniFlow)
end

function FightViewHandCard:onOpen()
	self:_updateNow()
	self:addEventCb(FightController.instance, FightEvent.DistributeCards, self._startDistributeCards, self)
	self:addEventCb(FightController.instance, FightEvent.PushCardInfo, self._updateNow, self)
	self:addEventCb(FightController.instance, FightEvent.PlayHandCard, self._playHandCard, self)
	self:addEventCb(FightController.instance, FightEvent.PlayCombineCards, self._onPlayCombineCards, self)
	self:addEventCb(FightController.instance, FightEvent.UpdateHandCards, self._updateHandCards, self)
	self:addEventCb(FightController.instance, FightEvent.ResetCard, self._resetCard, self)
	self:addEventCb(FightController.instance, FightEvent.DragHandCardBegin, self._onDragHandCardBegin, self)
	self:addEventCb(FightController.instance, FightEvent.DragHandCardEnd, self._onDragHandCardEnd, self)
	self:addEventCb(FightController.instance, FightEvent.LongPressHandCard, self._longPressHandCard, self)
	self:addEventCb(FightController.instance, FightEvent.LongPressHandCardEnd, self._longPressHandCardEnd, self)
	self:addEventCb(FightController.instance, FightEvent.PlayRedealCardEffect, self._playRedealCardEffect, self)
	self:addEventCb(FightController.instance, FightEvent.UniversalAppear, self._playUniversalAppear, self)
	self:addEventCb(FightController.instance, FightEvent.CheckCardOpEnd, self._checkCardOpEnd, self)
	self:addEventCb(FightController.instance, FightEvent.DetectCardOpEndAfterOperationEffectDone, self._onDetectCardOpEndAfterOperationEffectDone, self)
	self:addEventCb(GameStateMgr.instance, GameStateEvent.onApplicationPause, self._onApplicationPause, self)
	self:addEventCb(FightController.instance, FightEvent.SetCardMagicEffectChange, self._setCardMagicEffectChange, self)
	self:addEventCb(FightController.instance, FightEvent.PlayCardMagicEffectChange, self._playCardMagicEffectChange, self)
	self:addEventCb(FightController.instance, FightEvent.SetBlockCardOperate, self._setBlockOperate, self)
	self:addEventCb(FightController.instance, FightEvent.SpCardAdd, self._onSpCardAdd, self)
	self:addEventCb(FightController.instance, FightEvent.AddHandCard, self._onAddHandCard, self)
	self:addEventCb(FightController.instance, FightEvent.TempCardRemove, self._onTempCardRemove, self)
	self:addEventCb(FightController.instance, FightEvent.ChangeToTempCard, self._onChangeToTempCard, self)
	self:addEventCb(FightController.instance, FightEvent.CorrectHandCardScale, self._onCorrectHandCardScale, self)
	self:addEventCb(FightController.instance, FightEvent.RemoveEntityCards, self._onRemoveEntityCards, self)
	self:addEventCb(FightController.instance, FightEvent.CardRemove, self._onCardRemove, self)
	self:addEventCb(FightController.instance, FightEvent.CardRemove2, self._onCardRemove2, self)
	self:addEventCb(FightController.instance, FightEvent.RefreshHandCard, self._updateNow, self)
	self:addEventCb(FightController.instance, FightEvent.CardsCompose, self._onCardsCompose, self)
	self:addEventCb(FightController.instance, FightEvent.CardsComposeTimeOut, self._onCardsComposeTimeOut, self)
	self:addEventCb(FightController.instance, FightEvent.CardLevelChange, self._onCardLevelChange, self)
	self:addEventCb(FightController.instance, FightEvent.AfterForceUpdatePerformanceData, self._onAfterForceUpdatePerformanceData, self)
	self:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, self._onRoundSequenceFinish, self)
	self:addEventCb(FightController.instance, FightEvent.OnClothSkillRoundSequenceFinish, self._onClothSkillRoundSequenceFinish, self)
	self:addEventCb(FightController.instance, FightEvent.MasterAddHandCard, self._onMasterAddHandCard, self)
	self:addEventCb(FightController.instance, FightEvent.MasterCardRemove, self._onMasterCardRemove, self)
	self:addEventCb(FightController.instance, FightEvent.CardAConvertCardB, self._onCardAConvertCardB, self)
	self:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, self._updateNow, self)
	self:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectCard, self.OnKeyPlayCard, self)
	self:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleMoveCardEnd, self.onControlRelease, self)
	self:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectLeft, self.selectLeftCard, self)
	self:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectRight, self.selectRightCard, self)
	self:addEventCb(FightController.instance, FightEvent.StageChanged, self._onStageChanged, self)
	self:addEventCb(FightController.instance, FightEvent.EnterOperateState, self._onEnterOperateState, self)
	self:addEventCb(FightController.instance, FightEvent.ExitOperateState, self._onExitOperateState, self)
	self:addEventCb(FightController.instance, FightEvent.CardEffectChange, self._onCardEffectChange, self)
	self:addEventCb(FightController.instance, FightEvent.RefreshHandCardPrecisionEffect, self._onRefreshHandCardPrecisionEffect, self)
	self:addEventCb(FightController.instance, FightEvent.LY_CardAreaSizeChange, self.onLY_CardAreaSizeChange, self)
	self:addEventCb(FightController.instance, FightEvent.RefreshCardHeatShow, self._onRefreshCardHeatShow, self)
	self:addEventCb(FightController.instance, FightEvent.ASFD_OnChangeCardEnergy, self.onChangeCardEnergy, self)
	self:_setBlockOperate(false)
	self:_refreshPrecisionShow()
end

function FightViewHandCard:onClose()
	FightCardModel.instance:setLongPressIndex(-1)
	TaskDispatcher.cancelTask(self._delayCancelBlock, self)
	TaskDispatcher.cancelTask(self._combineCardsAfterAddHandCard, self)
	TaskDispatcher.cancelTask(self._correctActiveCardObjPos, self)
	TaskDispatcher.cancelTask(self._combineAfterCardLevelChange, self)
	TaskDispatcher.cancelTask(self._combineAfterCardRemove, self)
	self:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectCard, self.OnKeyPlayCard, self)
	self:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleMoveCardEnd, self.onControlRelease, self)
	self:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectLeft, self.selectLeftCard, self)
	self:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBattleSelectRight, self.selectRightCard, self)

	for i, v in ipairs(self._handCardItemList) do
		v:releaseSelf()
	end

	self._correctHandCardScale:stop()
	self._cardDistributeFlow:stop()
	self._cardCombineFlow:stop()
	self._cardLongPressFlow:stop()
	self._cardLongPressEndFlow:stop()
	self._cardDragFlow:stop()
	self._cardDragEndFlow:stop()
	self._redealCardFlow:stop()
	self._universalAppearFlow:stop()
	self._magicEffectCardFlow:stop()
end

function FightViewHandCard:_onHandCardFlowCreate(flow)
	table.insert(self.LyNeedCheckFlowList, flow)
end

function FightViewHandCard:_onHandCardFlowEnd(flow)
	if flow == self._cardLongPressEndFlow or flow == self._cardDragEndFlow then
		self.longPressing = false
	end

	return self:refreshLYAreaActive()
end

function FightViewHandCard:_onHandCardFlowStart(flow)
	if flow == self._cardLongPressFlow then
		self.longPressing = true
	end

	return self:refreshLYAreaActive()
end

function FightViewHandCard:_onStageChanged(curStage)
	if curStage == FightStageMgr.StageType.Operate then
		for _, handCardItem in ipairs(self._handCardItemList) do
			handCardItem:setASFDActive(true)
		end

		self:_refreshPrecisionShow()
	elseif curStage == FightStageMgr.StageType.Play then
		gohelper.setActive(self._precisionFrame, false)
		self:_setBlockOperate(false)
	end

	return self:refreshLYAreaActive()
end

function FightViewHandCard:refreshLYAreaActive()
	if FightViewHandCard.blockOperate then
		return self:setActiveLyRoot(false)
	end

	if self.longPressing then
		return self:setActiveLyRoot(false)
	end

	local curStage = FightDataHelper.stageMgr:getCurStage()
	local isNormal = curStage == FightStageMgr.StageType.Operate

	if not isNormal then
		return self:setActiveLyRoot(false)
	end

	if self.LyNeedCheckFlowList then
		for _, flow in ipairs(self.LyNeedCheckFlowList) do
			if flow.status == WorkStatus.Running then
				return self:setActiveLyRoot(false)
			end
		end
	end

	self:refreshLyAreaPos()
	self:setActiveLyRoot(true)
end

function FightViewHandCard:setActiveLyRoot(active)
	local areaSize = FightDataHelper.LYDataMgr.LYCardAreaSize

	if areaSize < 1 then
		gohelper.setActive(self.goLYAreaRoot, false)

		return
	end

	gohelper.setActive(self.goLYAreaRoot, true)

	if active then
		if not self.goLYAreaRoot.activeInHierarchy then
			gohelper.setActive(self.goLYAreaRoot, true)
			self.animatorLyRoot:Play("open", 0, 0)
		end
	else
		gohelper.setActive(self.goLYAreaRoot, false)
	end
end

function FightViewHandCard:onLY_CardAreaSizeChange()
	self:refreshLyCardTag()
	self:refreshLYAreaActive()
end

function FightViewHandCard:refreshLyCardTag()
	local cards = FightDataHelper.handCardMgr.handCard
	local areaSize = FightDataHelper.LYDataMgr.LYCardAreaSize
	local len = cards and #cards or 0

	for i = 1, len do
		local handCardItem = self._handCardItemList[i]

		if handCardItem then
			handCardItem:resetRedAndBlue()

			if areaSize > len - i and i <= areaSize then
				handCardItem:setActiveBoth(true)
			else
				handCardItem:setActiveBlue(areaSize > len - i)
				handCardItem:setActiveRed(i <= areaSize)
			end
		end
	end
end

function FightViewHandCard:refreshLyAreaPos()
	local areaSize = FightDataHelper.LYDataMgr.LYCardAreaSize
	local curHandCardList = FightDataHelper.handCardMgr.handCard
	local handCardLen = curHandCardList and #curHandCardList or 0

	areaSize = math.min(areaSize, handCardLen)

	local cards = FightDataHelper.handCardMgr.handCard
	local len = cards and #cards or 0
	local show = areaSize and areaSize > 0 and len > 0

	gohelper.setActive(self.goRedArea, show)
	gohelper.setActive(self.goGreenArea, show)

	if show then
		local width = FightViewHandCard.calcTotalWidth(areaSize, 1) + FightEnum.LYCardAreaWidthOffset

		recthelper.setWidth(self.rectTrRedArea, width)
		recthelper.setWidth(self.rectTrGreenArea, width)

		local anchorX = FightViewHandCard.calcTotalWidth(len - areaSize, 1)

		recthelper.setAnchorX(self.rectTrGreenArea, -anchorX)
	end
end

function FightViewHandCard:_onApplicationPause(isFront)
	if isFront and FightDataHelper.stageMgr:getCurStage() == FightStageMgr.StageType.Operate then
		if self._cardDragFlow and self._cardDragFlow.status == WorkStatus.Running then
			self._cardDragFlow:stop()
		end

		self:_updateNow()
	end
end

function FightViewHandCard:getHandCardItem(index)
	return self._handCardItemList[index]
end

function FightViewHandCard:isMoveCardFlow()
	return self._cardDragFlow.status == WorkStatus.Running or self._cardDragEndFlow.status == WorkStatus.Running
end

function FightViewHandCard:isCombineCardFlow()
	return self._cardCombineFlow.status == WorkStatus.Running
end

function FightViewHandCard:onRegistCardEndAniFlow()
	local flow = self:buildOperateEndFlow()

	FightMsgMgr.replyMsg(FightMsgId.RegistCardEndAniFlow, flow)
end

function FightViewHandCard:buildOperateEndFlow()
	local flow = self:com_registFlowSequence()
	local oldFlow = FightViewHandCardSequenceFlow.New()

	oldFlow:addWork(FightGuideCardEnd.New())
	oldFlow:addWork(FightCardEndEffect.New())
	flow:addWork(oldFlow)

	local context = self:getUserDataTb_()

	context.handCardContainer = self._handCardGO
	context.playCardContainer = gohelper.findChild(self.viewGO, "root/playcards")
	context.waitCardContainer = gohelper.findChild(self.viewGO, "root/waitingArea/inner")
	context.handCardItemList = self._handCardItemList
	flow.context = context

	return flow
end

function FightViewHandCard:_checkCardOpEnd()
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

		self:_setBlockOperate(true)
		gohelper.setActive(self._precisionFrame, false)
		FightGameMgr.operateMgr:sendOperate2Server()
	end
end

function FightViewHandCard:_onDetectCardOpEndAfterOperationEffectDone(round_op)
	if round_op and FightModel.instance:isSeason2() and round_op:isMoveUniversal() then
		FightWorkSendOperate2Server:onFinish()

		return
	end

	self:_checkCardOpEnd()
end

function FightViewHandCard:_onCardEffectChange(index)
	if index == 1 then
		self:_refreshPrecisionShow()
	end
end

function FightViewHandCard:refreshPreDeleteCard(handCards)
	self.needPreDeleteCardIndexDict = self.needPreDeleteCardIndexDict or {}

	tabletool.clear(self.needPreDeleteCardIndexDict)

	if handCards then
		for index, cardInfoMo in ipairs(handCards) do
			local skillId = cardInfoMo.skillId
			local preDeleteCo = skillId and lua_fight_card_pre_delete.configDict[skillId]

			if preDeleteCo then
				local left = preDeleteCo.left

				if left > 0 then
					for i = 1, left do
						self.needPreDeleteCardIndexDict[index + i] = true
					end
				end

				local right = preDeleteCo.right

				if right > 0 then
					for i = 1, right do
						self.needPreDeleteCardIndexDict[index - i] = true
					end
				end
			end
		end
	end

	for index, handCardItem in ipairs(self._handCardItemList) do
		handCardItem:refreshPreDeleteImage(self.needPreDeleteCardIndexDict and self.needPreDeleteCardIndexDict[index])
	end
end

function FightViewHandCard:_refreshPrecisionShow()
	self._precisionState = false

	gohelper.setActive(self._precisionFrame, false)

	if FightDataHelper.stageMgr:isOperateStage() then
		local entityList = {}

		FightDataHelper.entityMgr:getNormalList(FightEnum.EntitySide.MySide, entityList)
		FightDataHelper.entityMgr:getSubList(FightEnum.EntitySide.MySide, entityList)

		for i, entityMO in ipairs(entityList) do
			if entityMO:hasBuffFeature(FightEnum.BuffFeature.PrecisionRegion) then
				gohelper.setActive(self._precisionFrame, true)

				self._precisionState = true

				self:_detectPlayPrecisionEffect()

				break
			end
		end
	end
end

function FightViewHandCard:_detectPlayPrecisionEffect()
	if self._handCardItemList then
		for i, v in ipairs(self._handCardItemList) do
			local cardItem = v:getCardItem()

			if i == 1 then
				if FightCardDataHelper.isPrecision(cardItem._cardInfoMO) and self._precisionState then
					cardItem:showPrecisionEffect()
				else
					cardItem:hidePrecisionEffect()
				end
			else
				cardItem:hidePrecisionEffect()
			end
		end
	end
end

function FightViewHandCard:_onRefreshHandCardPrecisionEffect()
	self:_detectPlayPrecisionEffect()
end

function FightViewHandCard:_startDistributeCards(beforeCards, distributeCards, isEnterDistribute)
	self.distributeCards = FightDataUtil.copyData(distributeCards) or {}

	FightDataUtil.coverData(beforeCards, FightDataHelper.handCardMgr.handCard)
	self:_updateHandCards()

	local cardSkin = FightCardDataHelper.getCardSkin()

	if isEnterDistribute then
		if cardSkin == 672801 then
			local work = self:com_registWork(FightWorkEnterDistributeCards672801, self, self.distributeCards)

			work:registFinishCallback(self.onEnterDistributeCardsSkinDone, self)
			work:start()
		else
			self:_nextDistributeCards()
		end
	else
		self:_nextDistributeCards()
	end
end

function FightViewHandCard:onEnterDistributeCardsSkinDone()
	FightController.instance:dispatchEvent(FightEvent.OnDistributeCards)
end

function FightViewHandCard:_nextDistributeCards(preCombineIndex)
	self._correctHandCardScale:stop()
	self._cardDistributeFlow:stop()
	self._cardCombineFlow:stop()
	self._redealCardFlow:stop()
	self._magicEffectCardFlow:stop()

	local queueLen = self.distributeCards and #self.distributeCards

	if queueLen > 0 then
		local handCard = FightDataHelper.handCardMgr.handCard
		local beforeCount = #handCard
		local newArr = {}

		for i = 1, queueLen do
			local distributeCard = table.remove(self.distributeCards, 1)

			table.insert(newArr, distributeCard)
			table.insert(handCard, distributeCard)

			local preCard = handCard[#handCard - 1]

			if FightCardDataHelper.canCombineCardForPerformance(distributeCard, preCard) then
				break
			end
		end

		local oldPosXList = FightCardCombineEffect.getCardPosXList(self._handCardItemList)

		self:_updateHandCards(handCard)

		local context = self:getUserDataTb_()

		context.cards = handCard
		context.handCardItemList = self._handCardItemList
		context.oldPosXList = oldPosXList
		context.preCombineIndex = preCombineIndex
		context.preCardCount = beforeCount
		context.newCardCount = #newArr
		context.playCardContainer = gohelper.findChild(self.viewGO, "root/playcards")
		context.isEnd = queueLen == 1
		context.handCardContainer = self._handCardContainer
		context.oldScale = 0

		self:_setBlockOperate(true)
		self._cardDistributeFlow:registerDoneListener(self._onDistributeCards, self)
		self._cardDistributeFlow:start(context)
	else
		self:_onDistributeCards()
	end
end

function FightViewHandCard:_onDistributeCards()
	self._cardDistributeFlow:unregisterDoneListener(self._onDistributeCards, self)

	local cards = self._cardDistributeFlow.context and self._cardDistributeFlow.context.cards or FightDataHelper.handCardMgr.handCard

	self:_combineCards(cards)
end

function FightViewHandCard:_playHandCard(from, targetEntityId, param2, param3)
	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	if FightGameMgr.operateMgr:isOperating() then
		return
	end

	local cards = FightDataHelper.handCardMgr.handCard
	local cardInfoMO = cards[from]

	if not cardInfoMO then
		self:_updateNow()

		return
	end

	FightGameMgr.operateMgr:playHandCard(from, targetEntityId, param2, param3)
end

function FightViewHandCard:buildPlayHandCardFlow(from, targetEntityId, param2, param3)
	local cards = FightDataHelper.handCardMgr.handCard
	local cardInfoMO = cards[from]

	if not cardInfoMO then
		return
	end

	local cardItem = self._handCardItemList[from]

	if not cardItem then
		return
	end

	if not cardItem.go.activeInHierarchy then
		return
	end

	local flow = self:com_registFlowSequence()
	local oldFlow = FightViewHandCardSequenceFlow.New()

	oldFlow:addWork(FightCardRouge2PushMusicWork.New())
	oldFlow:addWork(FightCardPlayEffect.New())
	oldFlow:addWork(FightCardDissolveCardsAfterPlay.New())
	oldFlow:addWork(FightCardDiscardAfterPlay.New())
	oldFlow:addWork(FightCardCheckCombineCards.New())
	oldFlow:addWork(FightCardRouge2PopMusicWork.New())
	flow:addWork(oldFlow)
	flow:registWork(FightWorkFunction, self._onPlayCardDone, self)
	FightController.instance:dispatchEvent(FightEvent.HideCardSkillTips)
	self:_setBlockOperate(true)

	if param3 and param3 ~= 0 then
		cardInfoMO.skillId = param3
	end

	cardInfoMO.playCanAddExpoint = FightCardDataHelper.playCanAddExpoint(cards, cardInfoMO)

	local fightBeginRoundOp = FightDataHelper.operationDataMgr:newOperation()

	fightBeginRoundOp:playCard(from, targetEntityId, cardInfoMO, param2, param3)

	fightBeginRoundOp.cardColor = FightDataHelper.LYDataMgr:getCardColor(cards, from)
	fightBeginRoundOp.cardInfoMO.areaRedOrBlue = fightBeginRoundOp.cardColor

	if cardInfoMO.heatId ~= 0 then
		local teamDataMgr = FightDataHelper.teamDataMgr
		local heatId = cardInfoMO.heatId
		local myData = teamDataMgr.myData
		local heatData = myData.cardHeat.values[heatId]
		local oldValue = teamDataMgr.myCardHeatOffset[heatId] or 0

		teamDataMgr.myCardHeatOffset[heatId] = oldValue + heatData.changeValue

		FightController.instance:dispatchEvent(FightEvent.RefreshCardHeatShow, heatId)
	end

	FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, fightBeginRoundOp)
	table.remove(cards, from)

	local beforeDissolveCards = FightDataUtil.copyData(cards)
	local dissolveCardIndexsAfterPlay

	if not FightCardDataHelper.isSkill3(cardInfoMO) and FightCardDataHelper.isBigSkill(cardInfoMO.skillId) then
		while true do
			if #cards > 0 then
				local isDone = false

				for i = 1, #cards do
					local tempCardInfo = cards[i]

					if tempCardInfo.uid == cardInfoMO.uid and FightCardDataHelper.isBigSkill(tempCardInfo.skillId) and not FightCardDataHelper.isSkill3(tempCardInfo) then
						dissolveCardIndexsAfterPlay = dissolveCardIndexsAfterPlay or {}

						table.insert(dissolveCardIndexsAfterPlay, i)

						local op = FightDataHelper.operationDataMgr:newOperation()

						op:simulateDissolveCard(i)
						table.remove(cards, i)

						break
					end

					if i == #cards then
						isDone = true
					end
				end

				if isDone then
					break
				end
			else
				break
			end
		end
	end

	local needDiscard = false

	if FightCardDataHelper.isDiscard(cardInfoMO) then
		needDiscard = true
	end

	self._cardsForCombines = cards

	local context = self:getUserDataTb_()

	context.view = self
	context.cards = cards
	context.from = from
	context.viewGO = self.viewGO
	context.handCardTr = self._handCardTr
	context.handCardItemList = self._handCardItemList
	context.fightBeginRoundOp = fightBeginRoundOp
	context.beforeDissolveCards = beforeDissolveCards
	context.dissolveCardIndexsAfterPlay = dissolveCardIndexsAfterPlay
	context.needDiscard = needDiscard
	context.param2 = param2
	flow.context = context
	self.playCardFightBeginRoundOp = fightBeginRoundOp

	self:_playCardAudio(cardInfoMO)

	return flow
end

function FightViewHandCard:onRegistPlayHandCardWork(from, targetEntityId, param2, param3)
	local flow = self:buildPlayHandCardFlow(from, targetEntityId, param2, param3)

	if flow then
		FightMsgMgr.replyMsg(FightMsgId.RegistPlayHandCardWork, flow)
	end
end

function FightViewHandCard:_onPlayCardDone()
	self:_updateHandCards(FightDataHelper.handCardMgr.handCard)
	FightController.instance:dispatchEvent(FightEvent.OnPlayCardFlowDone, self.playCardFightBeginRoundOp)
	FightController.instance:dispatchEvent(FightEvent.PlayCardOver)
	self:_detectPlayPrecisionEffect()

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		self:_setBlockOperate(true)

		return
	end
end

function FightViewHandCard:_playCardAudio(cardInfoMO)
	if FightDataHelper.stateMgr.isReplay then
		return
	end

	local entity = FightHelper.getEntity(cardInfoMO.uid)
	local entityMO = entity and entity:getMO()

	if not entityMO then
		return
	end

	if FightEntityDataHelper.isPlayerUid(entityMO.id) then
		return
	end

	local cardOpList = FightDataHelper.operationDataMgr:getOpList()
	local buffList = FightBuffHelper.simulateBuffList(entityMO, cardOpList[#cardOpList])

	if not FightViewHandCardItemLock.canUseCardSkill(cardInfoMO.uid, cardInfoMO.skillId, buffList) then
		return
	end

	local skillCardLv = FightCardDataHelper.getSkillLv(cardInfoMO.uid, cardInfoMO.skillId)
	local heroId = entityMO.modelId
	local heroConfig = HeroConfig.instance:getHeroCO(heroId)
	local audioId

	if cardInfoMO.cardType == FightEnum.CardType.SKILL3 then
		audioId = self:getSkill3AudioId(entityMO, cardInfoMO)
	elseif skillCardLv == 1 or skillCardLv == 2 then
		audioId = FightAudioMgr.instance:getHeroVoiceRandom(heroId, CharacterEnum.VoiceType.FightCardStar12, cardInfoMO.uid)
	elseif skillCardLv == 3 then
		audioId = FightAudioMgr.instance:getHeroVoiceRandom(heroId, CharacterEnum.VoiceType.FightCardStar3, cardInfoMO.uid)

		if not audioId then
			if heroConfig and heroConfig.rare >= 4 then
				audioId = FightAudioMgr.instance:getHeroVoiceRandom(heroId, CharacterEnum.VoiceType.FightCardStar3, cardInfoMO.uid)
			else
				audioId = FightAudioMgr.instance:getHeroVoiceRandom(heroId, CharacterEnum.VoiceType.FightCardStar12, cardInfoMO.uid)
			end
		end
	elseif skillCardLv == FightEnum.UniqueSkillCardLv then
		audioId = FightAudioMgr.instance:getHeroVoiceRandom(heroId, CharacterEnum.VoiceType.FightCardUnique, cardInfoMO.uid)
	end

	if audioId then
		FightAudioMgr.instance:playCardAudio(cardInfoMO.uid, audioId, heroId)
	end
end

function FightViewHandCard:getSkill3AudioId(entityMO, cardInfoMO)
	local timeline = FightConfig.instance:getSkinSkillTimeline(entityMO.skin, cardInfoMO.skillId)
	local voiceCoList = FightAudioMgr.instance:_getHeroVoiceCOs(entityMO.modelId, CharacterEnum.VoiceType.FightCardSkill3, entityMO.skin)

	if not voiceCoList then
		return
	end

	for i = #voiceCoList, 1, -1 do
		local voiceCo = voiceCoList[i]
		local timelineList = string.split(voiceCo.param, "#")
		local ok = timelineList and tabletool.indexOf(timelineList, timeline)

		if not ok then
			table.remove(voiceCoList, i)
		end
	end

	local len = #voiceCoList

	if len < 1 then
		return
	end

	if len == 1 then
		return voiceCoList[1].audio
	end

	local index = math.random(len)

	return voiceCoList[index].audio
end

function FightViewHandCard:_playRedealCardEffect(oldCards, newCards)
	local context = self:getUserDataTb_()

	context.oldCards = oldCards
	context.newCards = newCards
	context.handCardItemList = self._handCardItemList

	self:beforeRedealCardFlow()
	self._redealCardFlow:registerDoneListener(self._onRedealCardDone, self)
	self._redealCardFlow:start(context)
end

function FightViewHandCard:beforeRedealCardFlow()
	for _, handCardItem in ipairs(self._handCardItemList) do
		handCardItem:playASFDAnim("close")
	end
end

function FightViewHandCard:afterRedealCardFlow()
	for _, handCardItem in ipairs(self._handCardItemList) do
		handCardItem:playASFDAnim("open")
	end
end

function FightViewHandCard:_onRedealCardDone()
	self._redealCardFlow:unregisterDoneListener(self._onRedealCardDone, self)
	self:afterRedealCardFlow()
	self:_updateNow()
end

function FightViewHandCard:_setCardMagicEffectChange(card_index, old_effect, new_efffect)
	self._card_magic_effect_change_info = self._card_magic_effect_change_info or {}
	self._card_magic_effect_change_info[card_index] = {
		old_effect = old_effect,
		new_effect = new_efffect
	}
end

function FightViewHandCard:_playCardMagicEffectChange()
	local context = self:getUserDataTb_()

	context.changeInfos = self._card_magic_effect_change_info
	context.handCardItemList = self._handCardItemList
	self._card_magic_effect_change_info = nil

	self:_setBlockOperate(true)
	self._magicEffectCardFlow:registerDoneListener(self._onMagicEffectCardFlowDone, self)
	self._magicEffectCardFlow:start(context)
end

function FightViewHandCard:_onMagicEffectCardFlowDone()
	self._magicEffectCardFlow:unregisterDoneListener(self._onMagicEffectCardFlowDone, self)

	local cards = FightDataHelper.handCardMgr.handCard

	self:_combineCards(cards)
end

function FightViewHandCard:_playUniversalAppear()
	self:_setBlockOperate(true)
	self:_updateNow()

	local context = self:getUserDataTb_()

	context.handCardItemList = self._handCardItemList

	self._universalAppearFlow:start(context)
	self._universalAppearFlow:registerDoneListener(self._onUniversalAppearDone, self)
end

function FightViewHandCard:_onSpCardAdd(index)
	self:_playCorrectHandCardScale(0)

	local cards = FightDataHelper.handCardMgr.handCard

	self:_updateHandCards(cards, index)

	local tarCard = self._handCardItemList[index]

	gohelper.setActive(tarCard.go, false)
	tarCard:playCardAni(ViewAnim.FightCardBalance)
end

function FightViewHandCard:_onCorrectHandCardScale(oldScale)
	self:_playCorrectHandCardScale(oldScale)
end

function FightViewHandCard:_playCorrectHandCardScale(oldScale, newScale)
	self._correctHandCardScale:stop()

	local context = self:getUserDataTb_()

	context.cards = tabletool.copy(FightDataHelper.handCardMgr.handCard)
	context.oldScale = oldScale
	context.newScale = newScale
	context.handCardContainer = self._handCardContainer

	self._correctHandCardScale:start(context)
end

function FightViewHandCard:_onCardsCompose()
	local cards = FightDataHelper.handCardMgr.handCard

	self:_combineCards(cards)
end

function FightViewHandCard:_onCardsComposeTimeOut()
	if self._cardCombineFlow then
		self._cardCombineFlow:stop()
	end

	self:_updateNow()
end

function FightViewHandCard:_onRemoveEntityCards(entityId)
	for i = #self._handCardItemList, 1, -1 do
		local cardItem = self._handCardItemList[i]

		if cardItem.go.activeInHierarchy and cardItem:dissolveEntityCard(entityId) then
			table.insert(self._handCardItemList, table.remove(self._handCardItemList, i))
		end
	end

	FightViewHandCard.refreshCardIndex(self._handCardItemList)
	TaskDispatcher.cancelTask(self._correctActiveCardObjPos, self)
	TaskDispatcher.runDelay(self._correctActiveCardObjPos, self, 1 / FightModel.instance:getUISpeed())
end

function FightViewHandCard.refreshCardIndex(handCardItemList)
	for i, cardItem in ipairs(handCardItemList) do
		cardItem.index = i
	end
end

function FightViewHandCard:_onCardLevelChange(index, oldSkillId, canCombine)
	local cardItem = self._handCardItemList[index]

	if cardItem then
		cardItem:playCardLevelChange(oldSkillId)
	end

	if canCombine then
		TaskDispatcher.cancelTask(self._combineAfterCardLevelChange, self)
		TaskDispatcher.runDelay(self._combineAfterCardLevelChange, self, FightEnum.PerformanceTime.CardLevelChange / FightModel.instance:getUISpeed())
	end
end

function FightViewHandCard:_combineAfterCardLevelChange()
	local cards = FightDataHelper.handCardMgr.handCard

	self:_combineCards(cards)
end

function FightViewHandCard:_onPlayCombineCards(cards)
	self:_combineCards(cards)
end

function FightViewHandCard:_onCardRemove(indexs, delayTime, canCombine)
	self:_onCardRemove2(indexs)

	if canCombine then
		TaskDispatcher.cancelTask(self._combineAfterCardRemove, self)
		TaskDispatcher.runDelay(self._combineAfterCardRemove, self, delayTime / FightModel.instance:getUISpeed())
	end
end

function FightViewHandCard:_combineAfterCardRemove()
	local cards = FightDataHelper.handCardMgr.handCard

	self:_combineCards(cards)
end

function FightViewHandCard:_onCardRemove2(indexs)
	for i, index in ipairs(indexs) do
		local cardItem = table.remove(self._handCardItemList, index)

		if cardItem and cardItem.go.activeInHierarchy then
			cardItem:dissolveCard()
			table.insert(self._handCardItemList, cardItem)
		end
	end

	FightViewHandCard.refreshCardIndex(self._handCardItemList)
	TaskDispatcher.cancelTask(self._correctActiveCardObjPos, self)
	TaskDispatcher.runDelay(self._correctActiveCardObjPos, self, 1 / FightModel.instance:getUISpeed())
end

function FightViewHandCard:_correctActiveCardObjPos()
	local delayIndex = 0

	for i = 1, #self._handCardItemList do
		local cardItem = self._handCardItemList[i]

		cardItem.index = i
		cardItem.go.name = "cardItem" .. i

		local go = cardItem.go

		if not go.activeInHierarchy then
			break
		end

		local curPosX = recthelper.getAnchorX(go.transform)
		local endX = FightViewHandCard.calcCardPosX(i)

		if math.abs(curPosX - endX) >= 10 then
			cardItem:moveSelfPos(i, delayIndex, endX)

			delayIndex = delayIndex + 1
		end
	end
end

function FightViewHandCard:_onAddHandCard(cardInfoMO, canCombine)
	self:_playCorrectHandCardScale(0)

	local cards = FightDataHelper.handCardMgr.handCard
	local cardCount = #cards

	self:_updateHandCards(cards, cardCount)

	local tarCard = self._handCardItemList[cardCount]

	tarCard:playDistribute()

	if canCombine then
		TaskDispatcher.runDelay(self._combineCardsAfterAddHandCard, self, 0.5 / FightModel.instance:getUISpeed())
	end
end

function FightViewHandCard:_onMasterAddHandCard(cardInfoMO, canCombine)
	self:_playCorrectHandCardScale(0)

	local cards = FightDataHelper.handCardMgr.handCard
	local cardCount = #cards

	self:_updateHandCards(cards, cardCount)

	local tarCard = self._handCardItemList[cardCount]

	tarCard:playMasterAddHandCard()

	if canCombine then
		TaskDispatcher.runDelay(self._combineCardsAfterAddHandCard, self, 1 / FightModel.instance:getUISpeed())
	end
end

function FightViewHandCard:_onMasterCardRemove(indexs, delayTime, canCombine)
	for i, index in ipairs(indexs) do
		local cardItem = table.remove(self._handCardItemList, index)

		if cardItem and cardItem.go.activeInHierarchy then
			cardItem:playMasterCardRemove()
			table.insert(self._handCardItemList, cardItem)
		end
	end

	FightViewHandCard.refreshCardIndex(self._handCardItemList)
	TaskDispatcher.cancelTask(self._correctActiveCardObjPos, self)
	TaskDispatcher.runDelay(self._correctActiveCardObjPos, self, 0.7 / FightModel.instance:getUISpeed())

	if canCombine then
		TaskDispatcher.cancelTask(self._combineAfterCardRemove, self)
		TaskDispatcher.runDelay(self._combineAfterCardRemove, self, delayTime / FightModel.instance:getUISpeed())
	end
end

function FightViewHandCard:_combineCardsAfterAddHandCard()
	local cards = FightDataHelper.handCardMgr.handCard

	self:_combineCards(cards)
end

function FightViewHandCard:_onCardAConvertCardB(index)
	local cards = FightDataHelper.handCardMgr.handCard
	local cardItem = self._handCardItemList[index]

	if cardItem then
		cardItem:playCardAConvertCardB()
		cardItem:updateItem(index, cards[index])
	else
		self:_updateNow()
	end
end

function FightViewHandCard:_onTempCardRemove()
	self:_updateNow()

	local cards = FightDataHelper.handCardMgr.handCard

	self:_combineCards(cards)
end

function FightViewHandCard:_onChangeToTempCard(index)
	local tarCard = self._handCardItemList[index]

	if tarCard then
		tarCard:changeToTempCard()
	end
end

function FightViewHandCard:_onUniversalAppearDone()
	self._universalAppearFlow:unregisterDoneListener(self._onUniversalAppearDone, self)
	self:_setBlockOperate(false)
	FightController.instance:dispatchEvent(FightEvent.OnUniversalAppear)
end

function FightViewHandCard:_combineCards(cards, universalCombineIndex, fightBeginRoundOp)
	self._combineIndex = universalCombineIndex or FightCardDataHelper.canCombineCardListForPerformance(cards)
	self._isUniversalCombine = universalCombineIndex and true or false

	if self._combineIndex then
		self._cardsForCombines = cards

		local context = self:getUserDataTb_()

		context.cards = cards
		context.combineIndex = self._combineIndex
		context.handCardItemList = self._handCardItemList
		context.fightBeginRoundOp = fightBeginRoundOp

		self._cardCombineFlow:registerDoneListener(self._onCombineCardDone, self)
		self._cardCombineFlow:start(context)
	else
		self:_setBlockOperate(false)
		FightController.instance:dispatchEvent(FightEvent.OnCombineCardEnd, cards)

		if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DistributeCard) then
			if self.distributeCards and #self.distributeCards > 0 then
				self:_nextDistributeCards(#cards)
			else
				gohelper.destroy(gohelper.findChild(self._handCardGO, "CombineEffect"))
				self:_updateNow()
				FightController.instance:dispatchEvent(FightEvent.OnDistributeCards)
			end
		end

		if fightBeginRoundOp then
			FightController.instance:dispatchEvent(FightEvent.PlayOperationEffectDone, fightBeginRoundOp)
			self:_detectPlayPrecisionEffect()
		end
	end
end

function FightViewHandCard:_onCombineCardDone(status)
	self._cardCombineFlow:unregisterDoneListener(self._onCombineCardDone, self)

	local newCardInfoMO = self._cardsForCombines[self._combineIndex]

	FightController.instance:dispatchEvent(FightEvent.OnCombineOneCard, newCardInfoMO, self._isUniversalCombine)
	self:_combineCards(self._cardsForCombines, nil, self._cardCombineFlow.context.fightBeginRoundOp)
end

function FightViewHandCard:_resetCard(oldCardOps)
	FightGameMgr.operateMgr:cancelAllOperate()
	FightDataHelper.paTaMgr:resetOp()
	FightController.instance:dispatchEvent(FightEvent.OnResetCard, oldCardOps)
end

function FightViewHandCard:_updateNow()
	self:_updateHandCards(FightDataHelper.handCardMgr.handCard)
end

function FightViewHandCard:_filterInvalidCard(cards)
	for i = #cards, 1, -1 do
		local skillId = cards[i].skillId

		if not lua_skill.configDict[skillId] then
			if not skillId then
				logError("手牌数据没有skillId,请保存复现数据找开发看看")
			else
				logError("技能表找不到id:" .. skillId)
			end

			table.remove(cards, i)
		end
	end

	return cards
end

function FightViewHandCard:_updateHandCards(handCards, startIndex)
	handCards = handCards or FightDataHelper.handCardMgr.handCard
	handCards = self:_filterInvalidCard(handCards)

	local handCardCount = handCards and #handCards or 0

	for i = startIndex or 1, handCardCount do
		local handCardItem = self._handCardItemList[i]

		if not handCardItem then
			local handCardGO = gohelper.clone(self._handCardItemPrefab, self._handCardGO)

			handCardItem = MonoHelper.addLuaComOnceToGo(handCardGO, FightViewHandCardItem, self)

			table.insert(self._handCardItemList, handCardItem)
		end

		handCardItem.go.name = "cardItem" .. i

		local posX = FightViewHandCard.calcCardPosX(i)

		recthelper.setAnchor(handCardItem.tr, posX, 0)
		gohelper.setActive(handCardItem.go, true)
		transformhelper.setLocalScale(handCardItem.tr, 1, 1, 1)
		handCardItem:updateItem(i, handCards[i])
		gohelper.setAsLastSibling(handCardItem.go)
	end

	for i = handCardCount + 1, #self._handCardItemList do
		local handCardItem = self._handCardItemList[i]

		gohelper.setActive(handCardItem.go, false)

		handCardItem.go.name = "cardItem" .. i

		handCardItem:updateItem(i, nil)
	end

	self:refreshPreDeleteCard(handCards)
	self:refreshLyCardTag()
end

function FightViewHandCard:_setBlockOperate(isBlock)
	FightViewHandCard.blockOperate = isBlock and true or false

	if not gohelper.isNil(self._handCardGOCanvasGroup) then
		self._handCardGOCanvasGroup.blocksRaycasts = not isBlock
	end

	if isBlock then
		TaskDispatcher.cancelTask(self._delayCancelBlock, self)
		TaskDispatcher.runDelay(self._delayCancelBlock, self, 10)
	else
		TaskDispatcher.cancelTask(self._delayCancelBlock, self)
	end

	self:refreshLYAreaActive()
end

function FightViewHandCard:_delayCancelBlock()
	self:_setBlockOperate(false)
end

function FightViewHandCard:_onAfterForceUpdatePerformanceData()
	self:_updateNow()
end

function FightViewHandCard:_onRoundSequenceFinish()
	self:_updateNow()
end

function FightViewHandCard:_onClothSkillRoundSequenceFinish()
	return
end

function FightViewHandCard:_onDragHandCardBegin(index, position)
	if self._cardDragFlow.status == WorkStatus.Running then
		return
	end

	if self._cardLongPressFlow.status == WorkStatus.Running then
		self._cardLongPressFlow:stop()
		self._cardLongPressFlow:reset()
	end

	self._dragBeginCards = FightDataHelper.handCardMgr.handCard
	self._cardCount = #self._dragBeginCards

	if index > self._cardCount then
		return
	end

	local context = self:getUserDataTb_()

	context.index = index
	context.position = position
	context.cardCount = self._cardCount
	context.handCardItemList = self._handCardItemList
	context.handCardTr = self._handCardTr
	context.handCards = self._dragBeginCards

	self._cardDragFlow:start(context)
	self._handCardItemList[index]:stopLongPressEffect()
	FightController.instance:dispatchEvent(FightEvent.HideCardSkillTips)
end

function FightViewHandCard:_onDragHandCardEnd(index, position)
	if index > self._cardCount then
		self:_updateNow()

		return
	end

	self._cardDragFlow:stop()
	self._cardDragFlow:reset()

	self._dragIndex = index

	local anchorPos = recthelper.screenPosToAnchorPos(position, self._handCardTr)
	local curScale, _, _ = transformhelper.getLocalScale(self._handCardItemList[index].tr)
	local targetPosX = anchorPos.x - FightViewHandCard.HalfWidth

	self._targetIndex = FightViewHandCard.calcCardIndexDraging(targetPosX, self._cardCount, 1)

	local context = self:getUserDataTb_()

	context.index = index
	context.targetIndex = self._targetIndex
	context.cardCount = self._cardCount
	context.handCardItemList = self._handCardItemList
	context.handCardTr = self._handCardTr
	context.handCards = self._dragBeginCards

	self._cardDragEndFlow:registerDoneListener(self._onDragEndFlowDone, self)
	self._cardDragEndFlow:start(context)
	self:_setBlockOperate(true)
end

function FightViewHandCard:_onDragEndFlowDone()
	self._cardDragEndFlow:unregisterDoneListener(self._onDragEndFlowDone, self)

	local from = self._dragIndex
	local to = self._targetIndex

	if not self:_checkGuideMoveCard(from, to) then
		return
	end

	if from == to then
		self:_setBlockOperate(false)

		return
	end

	local fromCard = self._dragBeginCards[from]
	local isMoveUniversalCard = false

	if FightEnum.UniversalCard[fromCard.skillId] then
		local cardList = tabletool.copy(self._dragBeginCards)

		table.remove(cardList, from)
		table.insert(cardList, to, fromCard)

		if not FightCardDataHelper.canCombineWithUniversalForPerformance(fromCard, cardList[to + 1]) then
			self:_updateNow()
			self:_setBlockOperate(false)

			return
		end

		isMoveUniversalCard = to
	end

	local cards = self._dragBeginCards
	local fromSkillId = fromCard.skillId

	if (fromCard.uid == FightEntityScene.MySideId or fromCard.uid == FightEntityScene.EnemySideId) and not FightEnum.UniversalCard[fromSkillId] then
		self:_updateNow()
		self:_setBlockOperate(false)

		return
	end

	self:_moveCardItemInList(from, to)

	if not FightDataHelper.operationDataMgr:isCardOpEnd() then
		local operation = FightDataHelper.operationDataMgr:newOperation()

		operation.moveCanAddExpoint, operation.isUnlimitMoveOrExtraMove = FightCardDataHelper.moveCanAddExpoint(cards, fromCard)

		if isMoveUniversalCard then
			operation:moveUniversalCard(from, to, fromCard)
		else
			operation:moveCard(from, to, fromCard)
		end

		FightCardDataHelper.moveOnly(cards, from, to)

		if from ~= to then
			AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_FightMoveCardEnd)
		end

		self:_updateHandCards(cards)
		FightController.instance:dispatchEvent(FightEvent.OnMoveHandCard, operation, fromCard)
		FightController.instance:dispatchEvent(FightEvent.AddPlayOperationData, operation)

		local combineIndex = isMoveUniversalCard and to

		self:_combineCards(cards, combineIndex, operation)
	else
		self:_updateHandCards(cards)

		if not FightDataHelper.stateMgr.isReplay then
			-- block empty
		end

		self:_setBlockOperate(false)
	end
end

function FightViewHandCard:_moveCardItemInList(from, to)
	if not self._handCardItemList or not self._handCardItemList[from] or not self._handCardItemList[to] then
		return
	end

	if from == to then
		return
	end

	local fromCardItem = self._handCardItemList[from]
	local offset = from < to and 1 or -1

	for i = from, to - offset, offset do
		self._handCardItemList[i] = self._handCardItemList[i + offset]
	end

	self._handCardItemList[to] = fromCardItem
end

function FightViewHandCard:_playCardItemInList(from)
	if not self._handCardItemList or not self._handCardItemList[from] then
		return
	end

	self:_moveCardItemInList(from, #self._handCardItemList)
end

function FightViewHandCard:_checkGuideMoveCard(from, to)
	local guideFlag = GuideModel.instance:getFlagValue(GuideModel.GuideFlag.FightMoveCard)

	if guideFlag then
		local success = from == guideFlag.from

		if success then
			local flag = false
			local tos = guideFlag.tos

			for i, one in ipairs(tos) do
				if to == one then
					flag = true

					break
				end
			end

			success = flag
		end

		if success then
			FightController.instance:dispatchEvent(FightEvent.OnGuideDragCard)

			return true
		else
			self:_resetCard({})
			self:_setBlockOperate(false)

			return false
		end
	end

	return true
end

function FightViewHandCard:selectLeftCard()
	if self._longPressIndex == nil then
		local index = 1

		for i, cardItem in pairs(self._handCardItemList) do
			if cardItem.go.activeInHierarchy and index < cardItem.index then
				index = cardItem.index
			end
		end

		self:OnkeyLongPress(index)
	else
		if self._longPressIndex + 1 > #self._handCardItemList then
			return
		end

		local cardItem = self._handCardItemList[self._longPressIndex + 1]

		if cardItem and not cardItem.go.activeInHierarchy then
			return
		end

		self:OnkeyLongPress(self._longPressIndex + 1)
	end
end

function FightViewHandCard:selectRightCard()
	if self._longPressIndex == nil then
		local index = 1

		for i, cardItem in pairs(self._handCardItemList) do
			if cardItem.go.activeInHierarchy and index > cardItem.index then
				index = cardItem.index
			end
		end

		self:OnkeyLongPress(index)
	else
		if self._longPressIndex - 1 < 1 then
			return
		end

		self:OnkeyLongPress(self._longPressIndex - 1)
	end
end

function FightViewHandCard:OnKeyPlayCard(index)
	if ViewMgr.instance:IsPopUpViewOpen() then
		return
	end

	self:_longPressHandCardEnd()

	local cardCount = #FightDataHelper.handCardMgr.handCard

	for i, cardItem in pairs(self._handCardItemList) do
		if cardItem.index == cardCount - index + 1 and cardItem.go.activeInHierarchy then
			cardItem:_onClickThis()
		end
	end
end

function FightViewHandCard:OnkeyLongPress(index)
	if FightDataHelper.stateMgr.isReplay then
		return
	end

	self:_longPressHandCardEnd()
	FightController.instance:dispatchEvent(FightEvent.HideCardSkillTips)

	for i, cardItem in pairs(self._handCardItemList) do
		if cardItem.index == index and cardItem.go.activeInHierarchy then
			cardItem:_onLongPress()
		end
	end
end

function FightViewHandCard:onControlRelease()
	if not self._longPressIndex then
		return
	end

	for i, cardItem in pairs(self._handCardItemList) do
		if cardItem and cardItem.index == self._longPressIndex then
			cardItem:_onClickThis()
		end
	end
end

function FightViewHandCard:OnSeleCardMoveEnd()
	self._keyDrag = false

	FightController.instance:dispatchEvent(FightEvent.SimulateDragHandCardEnd, self.startDragIndex, self.dragIndex)

	self.dragIndex = nil
	self.curLongPress = nil
end

function FightViewHandCard:getLongPressItemIndex()
	for i, cardItem in pairs(self._handCardItemList) do
		if cardItem and cardItem._isLongPress then
			return cardItem
		end
	end

	return nil
end

function FightViewHandCard:_longPressHandCard(index)
	self:_longPressHandCardEnd()

	if self._cardDragFlow.status == WorkStatus.Running then
		return
	end

	if self._cardLongPressFlow.status == WorkStatus.Running then
		return
	end

	FightCardModel.instance:setLongPressIndex(index)

	self._longPressIndex = index
	self._cardCount = #FightDataHelper.handCardMgr.handCard
	self._clearPressIndex = false

	local context = self:getUserDataTb_()

	context.index = index
	context.cardCount = self._cardCount
	context.handCardItemList = self._handCardItemList

	self._cardLongPressFlow:registerDoneListener(self._onLongPressFlowDone, self)
	self._cardLongPressFlow:start(context)

	local cardItem = self._handCardItemList[index]

	cardItem:playLongPressEffect()
end

function FightViewHandCard:_onLongPressFlowDone()
	self._cardLongPressFlow:unregisterDoneListener(self._onLongPressFlowDone, self)
end

function FightViewHandCard:_longPressHandCardEnd(index)
	index = index or self._longPressIndex

	if not index then
		return
	end

	self._handCardItemList[index]:stopLongPressEffect()
	self._handCardItemList[index]:onLongPressEnd()

	if self._cardLongPressFlow.status == WorkStatus.Running then
		self._cardLongPressFlow:stop()
		self._cardLongPressFlow:reset()
	end

	self._clearPressIndex = true

	local context = self:getUserDataTb_()

	context.index = index
	context.cardCount = self._cardCount
	context.handCardItemList = self._handCardItemList

	self._cardLongPressEndFlow:registerDoneListener(self._onLongPressEndFlowDone, self)
	self._cardLongPressEndFlow:start(context)

	self._longPressIndex = nil
end

function FightViewHandCard:_onLongPressEndFlowDone()
	if self._clearPressIndex then
		self._longPressIndex = nil

		FightCardModel.instance:setLongPressIndex(-1)
	end

	self._cardLongPressEndFlow:unregisterDoneListener(self._onLongPressEndFlowDone, self)
end

function FightViewHandCard:_onEnterOperateState(operateState)
	if operateState == FightStageMgr.OperateStateType.Discard then
		self._abandonTran:SetAsLastSibling()
		gohelper.setActive(self._abandon, true)
		self._playCardTransform:SetAsLastSibling()

		local count = 0

		for i = 1, #self._handCardItemList do
			local handCardItem = self._handCardItemList[i]

			if handCardItem then
				if handCardItem.go.activeInHierarchy then
					count = count + 1
				else
					break
				end

				local cardInfo = handCardItem.cardInfoMO
				local canDiscard = false
				local entityMO = FightDataHelper.entityMgr:getById(cardInfo.uid)

				if entityMO then
					if not FightCardDataHelper.isBigSkill(cardInfo.skillId) then
						canDiscard = true
					end
				else
					canDiscard = true
				end

				if canDiscard then
					handCardItem.go.transform:SetParent(self._abandonCardRootTran, true)
				end
			end
		end

		recthelper.setWidth(self._abandonLine, count * HandCardWidth + 20)
	end
end

function FightViewHandCard:cancelAbandonState()
	gohelper.setActive(self._abandon, false)

	local childCount = self._abandonCardRootTran.childCount

	for i = childCount - 1, 0, -1 do
		self._abandonCardRootTran:GetChild(i):SetParent(self._handCardTr, true)
	end

	self._playCardTransform:SetSiblingIndex(FightViewHandCard.playCardSiblingIndex)
end

function FightViewHandCard:_onExitOperateState(operateState)
	if operateState == FightStageMgr.OperateStateType.Discard then
		self:cancelAbandonState()
	end
end

function FightViewHandCard:_onRefreshCardHeatShow(heatId)
	if self._handCardItemList then
		for i, v in ipairs(self._handCardItemList) do
			v:showCardHeat()
		end
	end
end

function FightViewHandCard:onChangeCardEnergy(changeList)
	if not changeList then
		return
	end

	for _, change in ipairs(changeList) do
		local index = change[1]
		local cardItem = self._handCardItemList[index]

		if cardItem then
			cardItem:changeEnergy()
		end
	end
end

function FightViewHandCard.calcCardPosXDraging(cardIndex, cardCount, dragToIndex, dragCardScale)
	local totalWidth = FightViewHandCard.calcTotalWidth(cardCount, dragCardScale)
	local newCardWidth = totalWidth / (cardCount - 1 + dragCardScale)

	if cardIndex < dragToIndex then
		return -0.5 * newCardWidth - newCardWidth * (cardIndex - 1)
	elseif dragToIndex < cardIndex then
		return -0.5 * newCardWidth - newCardWidth * (cardIndex - 1) - (dragCardScale - 1) * newCardWidth
	else
		return -0.5 * newCardWidth - newCardWidth * (cardIndex - 2) - (dragCardScale * 0.5 + 0.5) * newCardWidth
	end
end

function FightViewHandCard.calcCardIndexDraging(anchorX, cardCount, dragCardScale)
	local totalWidth = FightViewHandCard.calcTotalWidth(cardCount, dragCardScale)
	local newCardWidth = totalWidth / (cardCount - 1 + dragCardScale)
	local index = -anchorX / newCardWidth - dragCardScale * 0.5 + 1

	index = math.floor(index + 0.5)
	index = Mathf.Clamp(index, 1, cardCount)

	return index
end

function FightViewHandCard.calcTotalWidth(cardCount, dragCardScale)
	return cardCount * HandCardWidth + (dragCardScale - 1) * HandCardWidth * 0.5
end

function FightViewHandCard.calcCardPosX(cardIndex)
	return -1 * HandCardWidth * (cardIndex - 1) - HandCardWidth / 2
end

return FightViewHandCard
