module("modules.logic.fight.view.cardeffect.FightCardPlayEffect", package.seeall)

local var_0_0 = class("FightCardPlayEffect", BaseWork)
local var_0_1 = 1

function var_0_0.onStart(arg_1_0, arg_1_1)
	arg_1_0._dt = 0.033 * var_0_1 / FightModel.instance:getUISpeed()
	arg_1_0._tweenParamList = nil

	var_0_0.super.onStart(arg_1_0, arg_1_1)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_FightPlayCard)

	local var_1_0 = table.remove(arg_1_1.handCardItemList, arg_1_1.from)

	table.insert(arg_1_1.handCardItemList, var_1_0)
	FightViewHandCard.refreshCardIndex(arg_1_1.handCardItemList)
	var_1_0:setASFDActive(false)

	if var_1_0._cardItem then
		var_1_0._cardItem:setHeatRootVisible(false)
	end

	arg_1_0._cardInfoMO = var_1_0.cardInfoMO:clone()
	arg_1_0._clonePlayCardGO = gohelper.cloneInPlace(var_1_0.go)

	local var_1_1 = arg_1_0._clonePlayCardGO.transform

	gohelper.setActive(var_1_0.go, false)
	var_1_0:updateItem(#arg_1_1.handCardItemList, nil)
	arg_1_0:_addTrailEffect(var_1_1)

	local var_1_2 = true
	local var_1_3 = false

	if arg_1_0.context.needDiscard then
		var_1_2 = false
		var_1_3 = true
	end

	local var_1_4 = false
	local var_1_5 = arg_1_1.dissolveCardIndexsAfterPlay

	if var_1_5 and #var_1_5 > 0 then
		var_1_2 = false
		var_1_4 = true
	end

	local var_1_6 = false

	if var_1_2 then
		var_1_6 = FightCardDataHelper.canCombineCardListForPerformance(FightDataHelper.handCardMgr.handCard) or false
	end

	if var_1_6 then
		arg_1_0._stepCount = 1
	elseif var_1_3 or var_1_4 then
		arg_1_0._stepCount = 2
	elseif FightDataHelper.operationDataMgr:isCardOpEnd() and #FightDataHelper.operationDataMgr:getOpList() > 0 then
		arg_1_0._stepCount = 2
	else
		arg_1_0._stepCount = 1
	end

	FightController.instance:unregisterCallback(FightEvent.PlayCardFlayFinish, arg_1_0._onPlayCardFlayFinish, arg_1_0)

	if arg_1_0._stepCount == 2 then
		FightController.instance:registerCallback(FightEvent.PlayCardFlayFinish, arg_1_0._onPlayCardFlayFinish, arg_1_0)
	end

	arg_1_0._main_flow = FlowSequence.New()

	local var_1_7 = FlowSequence.New()

	var_1_7:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.ShowPlayCardFlyEffect, arg_1_0._cardInfoMO, arg_1_0._clonePlayCardGO, arg_1_0.context.fightBeginRoundOp)
	end))

	local var_1_8 = false

	if FightCardDataHelper.isNoCostSpecialCard(arg_1_0._cardInfoMO) then
		var_1_8 = true
	end

	if FightCardDataHelper.isSkill3(arg_1_0._cardInfoMO) then
		var_1_8 = true
	end

	local var_1_9 = arg_1_0.context.fightBeginRoundOp

	if not FightCardDataHelper.checkIsBigSkillCostActPoint(var_1_9.belongToEntityId, var_1_9.skillId) then
		var_1_8 = true
	end

	if var_1_8 then
		var_1_7:addWork(arg_1_0:_buildNoActCostMoveFlow())
	end

	var_1_7:addWork(WorkWaitSeconds.New(arg_1_0._dt * 1))

	if var_1_6 then
		var_1_7:addWork(FunctionWork.New(function()
			arg_1_0:_playShrinkFlow()
		end))
		var_1_7:addWork(WorkWaitSeconds.New(arg_1_0._dt * 6))
	else
		var_1_7:addWork(arg_1_0:_startShrinkFlow())
	end

	arg_1_0._main_flow:addWork(var_1_7)
	TaskDispatcher.runDelay(arg_1_0._delayDone, arg_1_0, 10 / FightModel.instance:getUISpeed())
	arg_1_0._main_flow:registerDoneListener(arg_1_0._onPlayCardDone, arg_1_0)
	arg_1_0._main_flow:start(arg_1_1)
end

function var_0_0._onPlayCardFlayFinish(arg_4_0, arg_4_1)
	if arg_4_1 == arg_4_0.context.fightBeginRoundOp then
		arg_4_0:_checkDone()
	end
end

function var_0_0._delayDone(arg_5_0)
	TaskDispatcher.cancelTask(arg_5_0._delayDone, arg_5_0)
	logError("出牌流程超过了10秒,可能卡住了,先强制结束")

	arg_5_0._stepCount = 1

	arg_5_0:_onPlayCardDone()
	arg_5_0:onStop()
end

function var_0_0._onPlayCardDone(arg_6_0)
	arg_6_0._main_flow:unregisterDoneListener(arg_6_0._onPlayCardDone, arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._delayDone, arg_6_0)
	arg_6_0:_checkDone()
end

function var_0_0._checkDone(arg_7_0)
	arg_7_0._stepCount = arg_7_0._stepCount - 1

	if arg_7_0._stepCount <= 0 then
		arg_7_0:onDone(true)
	end
end

function var_0_0._addTrailEffect(arg_8_0, arg_8_1)
	if GMFightShowState.cards then
		local var_8_0 = ResUrl.getUIEffect(FightPreloadViewWork.ui_kapaituowei)
		local var_8_1 = FightHelper.getPreloadAssetItem(var_8_0)

		arg_8_0._tailEffectGO = gohelper.clone(var_8_1:GetResource(var_8_0), arg_8_1.gameObject)
		arg_8_0._tailEffectGO.name = FightPreloadViewWork.ui_kapaituowei
	end
end

function var_0_0._buildNoActCostMoveFlow(arg_9_0)
	local var_9_0 = FlowSequence.New()
	local var_9_1 = FlowParallel.New()
	local var_9_2, var_9_3 = FightViewPlayCard.getMaxItemCount()
	local var_9_4 = arg_9_0.context.view.viewContainer.fightViewPlayCard._playCardItemList
	local var_9_5 = arg_9_0.context.view.viewContainer.fightViewPlayCard:getShowIndex(arg_9_0.context.fightBeginRoundOp)

	if var_9_2 > FightViewPlayCard.VisibleCount then
		-- block empty
	else
		for iter_9_0 = 1, #var_9_4 do
			local var_9_6 = var_9_4[iter_9_0].tr
			local var_9_7 = iter_9_0

			if var_9_5 < iter_9_0 then
				var_9_7 = var_9_7 + 1
			end

			local var_9_8 = FightViewPlayCard.calcCardPosX(var_9_7, var_9_2)

			var_9_1:addWork(TweenWork.New({
				type = "DOAnchorPosX",
				tr = var_9_6,
				to = var_9_8,
				t = arg_9_0._dt * 3
			}))
		end
	end

	var_9_0:addWork(var_9_1)
	var_9_0:addWork(FunctionWork.New(function()
		FightController.instance:dispatchEvent(FightEvent.onNoActCostMoveFlowOver)
	end))

	return var_9_0
end

function var_0_0._playShrinkFlow(arg_11_0)
	arg_11_0._shrinkFlow = arg_11_0:_startShrinkFlow()

	arg_11_0._shrinkFlow:start()
end

function var_0_0._startShrinkFlow(arg_12_0)
	local var_12_0 = FlowSequence.New()

	var_12_0:addWork(WorkWaitSeconds.New(arg_12_0._dt * 2))

	local var_12_1 = FlowParallel.New()
	local var_12_2 = 1

	for iter_12_0, iter_12_1 in ipairs(arg_12_0.context.handCardItemList) do
		if iter_12_1.go.activeInHierarchy and iter_12_0 >= arg_12_0.context.from then
			local var_12_3 = iter_12_0
			local var_12_4 = FightViewHandCard.calcCardPosX(var_12_3)
			local var_12_5 = FlowSequence.New()
			local var_12_6 = var_12_2 * arg_12_0._dt

			var_12_2 = var_12_2 + 1

			if var_12_6 > 0 then
				var_12_5:addWork(WorkWaitSeconds.New(var_12_6))
			end

			local var_12_7 = {
				type = "DOAnchorPosX",
				tr = iter_12_1.tr,
				to = var_12_4,
				t = arg_12_0._dt * 5,
				ease = EaseType.OutQuart
			}

			var_12_5:addWork(TweenWork.New(var_12_7))
			var_12_1:addWork(var_12_5)
		end
	end

	var_12_0:addWork(var_12_1)

	return var_12_0
end

function var_0_0.clearWork(arg_13_0)
	FightController.instance:unregisterCallback(FightEvent.PlayCardFlayFinish, arg_13_0._onPlayCardFlayFinish, arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0._delayDone, arg_13_0)

	if arg_13_0._main_flow then
		arg_13_0._main_flow:stop()

		arg_13_0._main_flow = nil
	end

	if arg_13_0._shrinkFlow then
		arg_13_0._shrinkFlow:stop()

		arg_13_0._shrinkFlow = nil
	end
end

return var_0_0
