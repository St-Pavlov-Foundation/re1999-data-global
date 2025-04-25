module("modules.logic.fight.view.cardeffect.FightCardPlayEffect", package.seeall)

slot0 = class("FightCardPlayEffect", BaseWork)
slot1 = 1

function slot0.onStart(slot0, slot1)
	FightCardModel.instance:setUniversalCombine(nil, )

	slot0._dt = 0.033 * uv0 / FightModel.instance:getUISpeed()
	slot0._tweenParamList = nil

	uv1.super.onStart(slot0, slot1)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_FightPlayCard)

	slot3 = slot1.handCardItemList[slot1.from]

	slot3:setASFDActive(false)

	if slot3._cardItem then
		slot3._cardItem:setHeatRootVisible(false)
	end

	slot0._cardInfoMO = slot3.cardInfoMO:clone()
	slot0._cardInfoMO.playCanAddExpoint = slot1.cards[slot1.from].playCanAddExpoint
	slot0._clonePlayCardGO = gohelper.cloneInPlace(slot3.go)

	gohelper.setActive(slot3.go, false)
	table.remove(tabletool.copy(slot0.context.cards), slot0.context.from)
	slot0:_addTrailEffect(slot0._clonePlayCardGO.transform)

	slot6 = true
	slot7 = false

	if slot0.context.needDiscard then
		slot6 = false
		slot7 = true
	end

	slot8 = false

	if slot1.dissolveCardIndexsAfterPlay and #slot9 > 0 then
		slot6 = false
		slot8 = true
	end

	slot10 = false

	if slot6 then
		slot10 = FightCardModel.getCombineIndexOnce(slot5) or false
	end

	if slot10 then
		slot0._stepCount = 1
	elseif slot7 or slot8 then
		slot0._stepCount = 2
	elseif FightCardModel.instance:isCardOpEnd() and #FightCardModel.instance:getCardOps() > 0 then
		slot0._stepCount = 2
	else
		slot0._stepCount = 1
	end

	FightController.instance:unregisterCallback(FightEvent.PlayCardFlayFinish, slot0._onPlayCardFlayFinish, slot0)

	if slot0._stepCount == 2 then
		FightController.instance:registerCallback(FightEvent.PlayCardFlayFinish, slot0._onPlayCardFlayFinish, slot0)
	end

	slot0._main_flow = FlowSequence.New()
	slot11 = FlowSequence.New()

	slot11:addWork(FunctionWork.New(function ()
		FightController.instance:dispatchEvent(FightEvent.ShowPlayCardFlyEffect, uv0._cardInfoMO, uv0._clonePlayCardGO, uv0.context.fightBeginRoundOp)
	end))

	if FightCardDataHelper.isNoCostSpecialCard(slot0._cardInfoMO) then
		slot11:addWork(slot0:_buildNoActCostMoveFlow())
	end

	slot11:addWork(WorkWaitSeconds.New(slot0._dt * 1))

	if slot10 then
		slot11:addWork(FunctionWork.New(function ()
			uv0:_playShrinkFlow()
		end))
		slot11:addWork(WorkWaitSeconds.New(slot0._dt * 6))
	else
		slot11:addWork(slot0:_startShrinkFlow())
	end

	slot0._main_flow:addWork(slot11)
	TaskDispatcher.runDelay(slot0._delayDone, slot0, 10 / FightModel.instance:getUISpeed())
	slot0._main_flow:registerDoneListener(slot0._onPlayCardDone, slot0)
	slot0._main_flow:start(slot1)
end

function slot0._onPlayCardFlayFinish(slot0, slot1)
	if slot1 == slot0.context.fightBeginRoundOp then
		slot0:_checkDone()
	end
end

function slot0._delayDone(slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	logError("出牌流程超过了10秒,可能卡住了,先强制结束")

	slot0._stepCount = 1

	slot0:_onPlayCardDone()
	slot0:onStop()
end

function slot0._onPlayCardDone(slot0)
	slot0._main_flow:unregisterDoneListener(slot0._onPlayCardDone, slot0)
	table.remove(slot0.context.cards, slot0.context.from)

	if slot0._tweenParamList then
		for slot4, slot5 in ipairs(slot0._tweenParamList) do
			if slot0.context.from <= slot5.index then
				slot5.index = slot5.index - 1

				slot0:_tweenCardPosFrameCb(slot5.curPos, slot5)
			end
		end
	end

	TaskDispatcher.cancelTask(slot0._delayDone, slot0)
	slot0.context.view:_playCardItemInList(slot0.context.from)
	slot0.context.view:_updateHandCards(slot0.context.cards)
	slot0:_checkDone()
end

function slot0._checkDone(slot0)
	slot0._stepCount = slot0._stepCount - 1

	if slot0._stepCount <= 0 then
		slot0:onDone(true)
	end
end

function slot0._addTrailEffect(slot0, slot1)
	if GMFightShowState.cards then
		slot2 = ResUrl.getUIEffect(FightPreloadViewWork.ui_kapaituowei)
		slot0._tailEffectGO = gohelper.clone(FightHelper.getPreloadAssetItem(slot2):GetResource(slot2), slot1.gameObject)
		slot0._tailEffectGO.name = FightPreloadViewWork.ui_kapaituowei
	end
end

function slot0._buildNoActCostMoveFlow(slot0)
	slot1 = FlowSequence.New()
	slot2 = FlowParallel.New()
	slot3, slot4 = FightViewPlayCard.getMaxItemCount()
	slot5 = slot0.context.view.viewContainer.fightViewPlayCard._playCardItemList
	slot6 = slot0.context.view.viewContainer.fightViewPlayCard:getShowIndex(slot0.context.fightBeginRoundOp)

	if FightViewPlayCard.VisibleCount >= slot3 then
		for slot10 = 1, #slot5 do
			slot11 = slot5[slot10].tr

			if slot6 < slot10 then
				slot12 = slot10 + 1
			end

			slot2:addWork(TweenWork.New({
				type = "DOAnchorPosX",
				tr = slot11,
				to = FightViewPlayCard.calcCardPosX(slot12, slot3),
				t = slot0._dt * 3
			}))
		end
	end

	slot1:addWork(slot2)
	slot1:addWork(FunctionWork.New(function ()
		FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	end))

	return slot1
end

function slot0._playShrinkFlow(slot0)
	slot0._shrinkFlow = slot0:_startShrinkFlow()

	slot0._shrinkFlow:start()
end

function slot0._startShrinkFlow(slot0)
	FlowSequence.New():addWork(WorkWaitSeconds.New(slot0._dt * 2))

	slot2 = FlowParallel.New()
	slot0._tweenParamList = {}

	for slot6, slot7 in ipairs(slot0.context.handCardItemList) do
		if slot7.go.activeInHierarchy and slot0.context.from < slot6 then
			slot9 = FightViewHandCard.calcCardPosX(slot6 <= slot0.context.from and slot6 or slot6 - 1)
			slot10 = FlowSequence.New()

			if (slot6 - slot0.context.from - 1) * slot0._dt > 0 then
				slot10:addWork(WorkWaitSeconds.New(slot11))
			end

			slot12 = recthelper.getAnchorX(slot7.tr)
			slot13 = {
				index = slot6,
				curPos = slot12
			}

			table.insert(slot0._tweenParamList, slot13)
			slot10:addWork(TweenWork.New({
				type = "DOTweenFloat",
				from = slot12,
				to = slot9,
				t = slot0._dt * 5,
				frameCb = slot0._tweenCardPosFrameCb,
				cbObj = slot0,
				param = slot13,
				ease = EaseType.OutQuart
			}))
			slot2:addWork(slot10)
		end
	end

	slot1:addWork(slot2)

	return slot1
end

function slot0._tweenCardPosFrameCb(slot0, slot1, slot2)
	slot2.curPos = slot1

	if not gohelper.isNil(slot0.context.handCardTr) and not gohelper.isNil(gohelper.findChild(slot0.context.handCardTr.gameObject, "cardItem" .. slot2.index)) then
		recthelper.setAnchorX(slot5.transform, slot1)
	end
end

function slot0.clearWork(slot0)
	FightController.instance:unregisterCallback(FightEvent.PlayCardFlayFinish, slot0._onPlayCardFlayFinish, slot0)
	TaskDispatcher.cancelTask(slot0._delayDone, slot0)

	if slot0._main_flow then
		slot0._main_flow:stop()

		slot0._main_flow = nil
	end

	if slot0._shrinkFlow then
		slot0._shrinkFlow:stop()

		slot0._shrinkFlow = nil
	end
end

return slot0
