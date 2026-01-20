-- chunkname: @modules/logic/fight/view/cardeffect/FightCardPlayEffect.lua

module("modules.logic.fight.view.cardeffect.FightCardPlayEffect", package.seeall)

local FightCardPlayEffect = class("FightCardPlayEffect", BaseWork)
local TimeFactor = 1

function FightCardPlayEffect:onStart(context)
	local dt = 0.033 * TimeFactor

	self._dt = dt / FightModel.instance:getUISpeed()
	self._tweenParamList = nil

	FightCardPlayEffect.super.onStart(self, context)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_FightPlayCard)

	local playCardItem = table.remove(context.handCardItemList, context.from)

	table.insert(context.handCardItemList, playCardItem)
	FightViewHandCard.refreshCardIndex(context.handCardItemList)
	playCardItem:setASFDActive(false)

	if playCardItem._cardItem then
		playCardItem._cardItem:setHeatRootVisible(false)

		local param3 = context.fightBeginRoundOp.param3

		if param3 and param3 ~= 0 then
			playCardItem._cardItem:updateItem(playCardItem.cardInfoMO.uid, param3, playCardItem.cardInfoMO)
		end
	end

	self._cardInfoMO = playCardItem.cardInfoMO:clone()
	self._clonePlayCardGO = gohelper.cloneInPlace(playCardItem.go)

	local playCardTr = self._clonePlayCardGO.transform

	gohelper.setActive(playCardItem.go, false)
	playCardItem:updateItem(#context.handCardItemList, nil)
	self:_addTrailEffect(playCardTr)

	local checkCombine = true
	local needDiscard = false

	if self.context.needDiscard then
		checkCombine = false
		needDiscard = true
	end

	local needRemove = false
	local removeIndexes = context.dissolveCardIndexsAfterPlay

	if removeIndexes and #removeIndexes > 0 then
		checkCombine = false
		needRemove = true
	end

	local need_cobine_card = false

	if checkCombine then
		need_cobine_card = FightCardDataHelper.canCombineCardListForPerformance(FightDataHelper.handCardMgr.handCard) or false
	end

	if need_cobine_card then
		self._stepCount = 1
	elseif needDiscard or needRemove then
		self._stepCount = 2
	elseif FightDataHelper.operationDataMgr:isCardOpEnd() and #FightDataHelper.operationDataMgr:getOpList() > 0 then
		self._stepCount = 2
	else
		self._stepCount = 1
	end

	FightController.instance:unregisterCallback(FightEvent.PlayCardFlayFinish, self._onPlayCardFlayFinish, self)

	if self._stepCount == 2 then
		FightController.instance:registerCallback(FightEvent.PlayCardFlayFinish, self._onPlayCardFlayFinish, self)
	end

	self._main_flow = FlowSequence.New()

	local sequence = FlowSequence.New()
	local roundOp = self.context.fightBeginRoundOp

	if roundOp.costActPoint <= 0 then
		sequence:addWork(self:_buildNoActCostMoveFlow(self.context.fightBeginRoundOp))
	end

	sequence:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.ShowPlayCardFlyEffect, self._cardInfoMO, self._clonePlayCardGO, self.context.fightBeginRoundOp)
	end))
	sequence:addWork(WorkWaitSeconds.New(self._dt * 1))

	if need_cobine_card then
		sequence:addWork(FunctionWork.New(function()
			self:_playShrinkFlow()
		end))
		sequence:addWork(WorkWaitSeconds.New(self._dt * 6))
	else
		sequence:addWork(self:_startShrinkFlow())
	end

	self._main_flow:addWork(sequence)
	TaskDispatcher.runDelay(self._delayDone, self, 10 / FightModel.instance:getUISpeed())
	self._main_flow:registerDoneListener(self._onPlayCardDone, self)
	self._main_flow:start(context)
end

function FightCardPlayEffect:_onPlayCardFlayFinish(roundOp)
	if roundOp == self.context.fightBeginRoundOp then
		self:_checkDone()
	end
end

function FightCardPlayEffect:_delayDone()
	TaskDispatcher.cancelTask(self._delayDone, self)
	logError("出牌流程超过了10秒,可能卡住了,先强制结束")

	self._stepCount = 1

	self:_onPlayCardDone()
	self:onStop()
end

function FightCardPlayEffect:_onPlayCardDone()
	self._main_flow:unregisterDoneListener(self._onPlayCardDone, self)
	TaskDispatcher.cancelTask(self._delayDone, self)
	self:_checkDone()
end

function FightCardPlayEffect:_checkDone()
	self._stepCount = self._stepCount - 1

	if self._stepCount <= 0 then
		self:onDone(true)
	end
end

function FightCardPlayEffect:_addTrailEffect(playCardTr)
	if GMFightShowState.cards then
		local url = ResUrl.getUIEffect(FightPreloadViewWork.ui_kapaituowei)
		local assetItem = FightHelper.getPreloadAssetItem(url)

		self._tailEffectGO = gohelper.clone(assetItem:GetResource(url), playCardTr.gameObject)
		self._tailEffectGO.name = FightPreloadViewWork.ui_kapaituowei
	end
end

function FightCardPlayEffect:_buildNoActCostMoveFlow()
	local sequence = FlowSequence.New()
	local noActCostMoveFlow = FlowParallel.New()
	local showPlayItemCount = FightViewPlayCard.getMaxItemCountIncludeExtraMoveAct()
	local playCardItemList = self.context.view.viewContainer.fightViewPlayCard._playCardItemList
	local start_index = self.context.view.viewContainer.fightViewPlayCard:getShowIndex(self.context.fightBeginRoundOp)

	if showPlayItemCount > FightViewPlayCard.VisibleCount then
		-- block empty
	else
		for i = 1, #playCardItemList do
			local playCardItemTran = playCardItemList[i].tr
			local finalIndex = i

			if start_index < i then
				finalIndex = finalIndex + 1
			end

			local posX = FightViewPlayCard.calcCardPosX(finalIndex, showPlayItemCount)

			noActCostMoveFlow:addWork(TweenWork.New({
				type = "DOAnchorPosX",
				tr = playCardItemTran,
				to = posX,
				t = self._dt * 3
			}))
		end
	end

	sequence:addWork(noActCostMoveFlow)
	sequence:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	end))

	return sequence
end

function FightCardPlayEffect:_playShrinkFlow()
	self._shrinkFlow = self:_startShrinkFlow()

	self._shrinkFlow:start()
end

function FightCardPlayEffect:_startShrinkFlow()
	local main_sequence = FlowSequence.New()

	main_sequence:addWork(WorkWaitSeconds.New(self._dt * 2))

	local flow = FlowParallel.New()
	local delayIndex = 1

	for i, item in ipairs(self.context.handCardItemList) do
		if item.go.activeInHierarchy and i >= self.context.from then
			local newIndex = i
			local targetPos = FightViewHandCard.calcCardPosX(newIndex)
			local oneCardFlow = FlowSequence.New()
			local delay = delayIndex * self._dt

			delayIndex = delayIndex + 1

			if delay > 0 then
				oneCardFlow:addWork(WorkWaitSeconds.New(delay))
			end

			local tweenParam = {
				type = "DOAnchorPosX",
				tr = item.tr,
				to = targetPos,
				t = self._dt * 5,
				ease = EaseType.OutQuart
			}

			oneCardFlow:addWork(TweenWork.New(tweenParam))
			flow:addWork(oneCardFlow)
		end
	end

	main_sequence:addWork(flow)

	return main_sequence
end

function FightCardPlayEffect:clearWork()
	FightController.instance:unregisterCallback(FightEvent.PlayCardFlayFinish, self._onPlayCardFlayFinish, self)
	TaskDispatcher.cancelTask(self._delayDone, self)

	if self._main_flow then
		self._main_flow:stop()

		self._main_flow = nil
	end

	if self._shrinkFlow then
		self._shrinkFlow:stop()

		self._shrinkFlow = nil
	end
end

return FightCardPlayEffect
