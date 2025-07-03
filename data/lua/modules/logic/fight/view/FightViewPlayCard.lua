module("modules.logic.fight.view.FightViewPlayCard", package.seeall)

local var_0_0 = class("FightViewPlayCard", BaseView)

var_0_0.PlayCardWidth = 130
var_0_0.HalfCardWidth = var_0_0.PlayCardWidth / 2
var_0_0.VisibleCount = 9
var_0_0.HalfScrollWidth = 610
var_0_0.OffsetX = 1220 - var_0_0.PlayCardWidth * var_0_0.VisibleCount
var_0_0.OffsetHalfX = var_0_0.OffsetX / 2

function var_0_0.onInitView(arg_1_0)
	arg_1_0._playCardGO = gohelper.findChild(arg_1_0.viewGO, "root/playcards")
	arg_1_0._playCardTr = arg_1_0._playCardGO.transform
	arg_1_0._scrollViewObj = gohelper.findChild(arg_1_0.viewGO, "root/playcards/#scroll_cards")
	arg_1_0._scrollView = gohelper.onceAddComponent(arg_1_0._scrollViewObj, gohelper.Type_ScrollRect)
	arg_1_0._playCardItemRoot = gohelper.findChild(arg_1_0.viewGO, "root/playcards/#scroll_cards/Viewport/Content")
	arg_1_0._playCardItemTransform = arg_1_0._playCardItemRoot.transform
	arg_1_0._playCardItemPrefab = gohelper.findChild(arg_1_0.viewGO, "root/playcards/#scroll_cards/Viewport/Content/cardItem")

	gohelper.setActive(arg_1_0._playCardItemPrefab, false)

	arg_1_0._playCardItemList = {}
	arg_1_0._resetCardFlow = FlowSequence.New()

	arg_1_0._resetCardFlow:addWork(FightCardResetEffect.New())
	arg_1_0:_clearBeginRoundOps()
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.CancelOperation, arg_4_0._refreshAllItemData, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.DistributeCards, arg_4_0._refreshAllItemData, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, arg_4_0._refreshAllItemData, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.PushCardInfo, arg_4_0._refreshAllItemData, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.OnRevertCard, arg_4_0._refreshAllItemData, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.OnResetCard, arg_4_0._onResetCard, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.OnAddActPoint, arg_4_0._refreshAllItemData, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, arg_4_0._refreshAllItemData, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.OnEffectExtraMoveAct, arg_4_0._refreshAllItemData, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.OnRestartFightDisposeDone, arg_4_0._refreshAllItemData, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.GMHideFightView, arg_4_0._refreshAllItemData, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.ShowPlayCardEffect, arg_4_0._showPlayCardEffect, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.ShowPlayCardFlyEffect, arg_4_0._onShowPlayCardFlyEffect, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.AddPlayOperationData, arg_4_0._onAddPlayOperationData, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.PlayOperationEffectDone, arg_4_0._onPlayOperationEffectDone, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.onNoActCostMoveFlowOver, arg_4_0._onNoActCostMoveFlowOver, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.CorrectPlayCardVisible, arg_4_0._onCorrectPlayCardVisible, arg_4_0)
	arg_4_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleBackPack, arg_4_0.OnBackPackClick, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.RefreshPlayCardRoundOp, arg_4_0._onRefreshPlayCardRoundOp, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.OnPlayCardFlowDone, arg_4_0._onPlayCardFlowDone, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.OnPlayAssistBossCardFlowDone, arg_4_0._onPlayAssistBossCardDone, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.EnterOperateState, arg_4_0._onEnterOperateState, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.ExitOperateState, arg_4_0._onExitOperateState, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.HidePlayCardAllCard, arg_4_0._onHidePlayCardAllCard, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.EnterStage, arg_4_0._onEnterStage, arg_4_0)
	arg_4_0:addEventCb(FightController.instance, FightEvent.BeforeCancelOperation, arg_4_0.onBeforeCancelOperation, arg_4_0)
end

function var_0_0._onEnterStage(arg_5_0, arg_5_1)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	if arg_5_1 == FightStageMgr.StageType.Play then
		gohelper.setActive(arg_5_0._playCardGO, false)
	end
end

function var_0_0._onEnterOperateState(arg_6_0, arg_6_1)
	if arg_6_1 == FightStageMgr.OperateStateType.SeasonChangeHero then
		gohelper.setActive(arg_6_0._playCardGO, false)
	end
end

function var_0_0._onExitOperateState(arg_7_0, arg_7_1)
	if arg_7_1 == FightStageMgr.OperateStateType.SeasonChangeHero then
		gohelper.setActive(arg_7_0._playCardGO, true)
	end
end

function var_0_0.onClose(arg_8_0)
	TaskDispatcher.cancelTask(arg_8_0._resetScrollView, arg_8_0)
	arg_8_0._resetCardFlow:unregisterDoneListener(arg_8_0._onResetEffectDone, arg_8_0)
	arg_8_0._resetCardFlow:stop()
	arg_8_0:_clearBeginRoundOps()
	arg_8_0:_releaseAllFlyItems()
end

function var_0_0.isVisible(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = var_0_0.calcCardPosX(arg_9_0, arg_9_1) + arg_9_2
	local var_9_1 = math.abs(var_9_0)
	local var_9_2 = false

	return var_9_1 + var_0_0.HalfCardWidth <= var_0_0.HalfScrollWidth and var_9_1 - var_0_0.HalfCardWidth <= var_0_0.HalfScrollWidth and true or false
end

function var_0_0.OnBackPackClick(arg_10_0)
	if arg_10_0._playCardItemList then
		for iter_10_0, iter_10_1 in pairs(arg_10_0._playCardItemList) do
			if iter_10_1 then
				iter_10_1:_onClickThis()
				FightController.instance:dispatchEvent(FightEvent.HideCardSkillTips)

				return
			end
		end
	end
end

function var_0_0.calContentPosX(arg_11_0, arg_11_1, arg_11_2)
	if arg_11_1 <= var_0_0.VisibleCount then
		return 0
	end

	local var_11_0 = var_0_0.calcCardPosX(arg_11_0, arg_11_1)
	local var_11_1 = var_0_0.isVisible(arg_11_0, arg_11_1, arg_11_2)

	if arg_11_1 - arg_11_0 <= 2 then
		return -((arg_11_1 - var_0_0.VisibleCount) * var_0_0.HalfCardWidth) + var_0_0.OffsetHalfX
	elseif var_11_1 then
		if not var_0_0.isVisible(arg_11_0 + 2, arg_11_1, arg_11_2) then
			return -(arg_11_1 - var_0_0.VisibleCount) * var_0_0.HalfCardWidth + (arg_11_1 - (arg_11_0 + 2)) * var_0_0.PlayCardWidth - var_0_0.OffsetHalfX
		else
			return arg_11_2
		end
	elseif var_11_0 < 0 then
		return (arg_11_1 - var_0_0.VisibleCount) * var_0_0.HalfCardWidth - (arg_11_0 - 1) * var_0_0.PlayCardWidth - var_0_0.OffsetHalfX
	else
		return -(arg_11_1 - var_0_0.VisibleCount) * var_0_0.HalfCardWidth + (arg_11_1 - (arg_11_0 + 2)) * var_0_0.PlayCardWidth - var_0_0.OffsetHalfX
	end

	return 0
end

function var_0_0._resetScrollView(arg_12_0)
	arg_12_0._scrollView.enabled = true
end

function var_0_0._onAddPlayOperationData(arg_13_0, arg_13_1)
	if not arg_13_1 then
		return
	end

	arg_13_0:recordPlayData(arg_13_1)

	arg_13_0._scrollView.enabled = false

	TaskDispatcher.cancelTask(arg_13_0._resetScrollView, arg_13_0)
	TaskDispatcher.runDelay(arg_13_0._resetScrollView, arg_13_0, 1)

	local var_13_0 = var_0_0.getMaxItemCount()

	if var_13_0 > var_0_0.VisibleCount then
		if FightCardDataHelper.isNoCostSpecialCard(arg_13_1.cardInfoMO) then
			return
		end

		local var_13_1 = arg_13_0:getShowIndex(arg_13_1)
		local var_13_2 = arg_13_0._playCardItemList[var_13_1]

		if not var_13_2 then
			return
		end

		if gohelper.fitScrollItemOffset(arg_13_0._scrollViewObj, arg_13_0._playCardItemRoot, var_13_2.go, ScrollEnum.ScrollDirH) > 0 then
			local var_13_3 = (var_13_0 - var_0_0.VisibleCount) * var_0_0.HalfCardWidth - (var_13_1 - 1) * var_0_0.PlayCardWidth - var_0_0.OffsetHalfX

			recthelper.setAnchorX(arg_13_0._playCardItemTransform, var_13_3)
		elseif var_13_0 - var_13_1 <= 2 then
			local var_13_4 = -((var_13_0 - var_0_0.VisibleCount) * var_0_0.HalfCardWidth) + var_0_0.OffsetHalfX

			recthelper.setAnchorX(arg_13_0._playCardItemTransform, var_13_4)
		else
			local var_13_5 = var_13_1 + 2
			local var_13_6 = arg_13_0._playCardItemList[var_13_5]

			if not var_13_6 then
				return
			end

			if gohelper.fitScrollItemOffset(arg_13_0._scrollViewObj, arg_13_0._playCardItemRoot, var_13_6.go, ScrollEnum.ScrollDirH) ~= 0 then
				local var_13_7 = -(var_13_0 - var_0_0.VisibleCount) * var_0_0.HalfCardWidth + (var_13_0 - var_13_5) * var_0_0.PlayCardWidth - var_0_0.OffsetHalfX

				recthelper.setAnchorX(arg_13_0._playCardItemTransform, var_13_7)
			end
		end
	else
		arg_13_0:_onCorrectPlayCardVisible(var_13_0)
	end
end

function var_0_0.getMaxItemCount()
	local var_14_0 = FightDataHelper.operationDataMgr.actPoint
	local var_14_1 = FightDataHelper.operationDataMgr.extraMoveAct
	local var_14_2 = var_14_0
	local var_14_3 = 0

	if var_14_1 > 0 then
		var_14_2 = var_14_1 + var_14_0
	end

	local var_14_4 = FightDataHelper.operationDataMgr:getShowOpActList()

	for iter_14_0, iter_14_1 in ipairs(var_14_4) do
		if iter_14_1:isPlayCard() and iter_14_1.costActPoint == 0 then
			var_14_2 = var_14_2 + 1
			var_14_3 = var_14_3 + 1
		end

		if iter_14_1:isPlayCard() and iter_14_1:needCopyCard() then
			var_14_2 = var_14_2 + 1
			var_14_3 = var_14_3 + 1
		end

		if iter_14_1:isAssistBossPlayCard() then
			var_14_2 = var_14_2 + 1
			var_14_3 = var_14_3 + 1
		end

		if iter_14_1:isPlayerFinisherSkill() then
			var_14_2 = var_14_2 + 1
			var_14_3 = var_14_3 + 1
		end

		if iter_14_1:isBloodPoolSkill() then
			var_14_2 = var_14_2 + 1
			var_14_3 = var_14_3 + 1
		end
	end

	return var_14_2, var_14_3
end

function var_0_0._refreshAllItemData(arg_15_0)
	arg_15_0:_clearAllItemData()

	local var_15_0 = arg_15_0:_onCorrectPlayCardObjList()
	local var_15_1 = FightDataHelper.operationDataMgr:getShowOpActList()

	for iter_15_0, iter_15_1 in ipairs(var_15_1) do
		arg_15_0:recordPlayData(iter_15_1)
		arg_15_0:_refreshPlayOperationData(iter_15_1)
	end

	arg_15_0:_onCorrectPlayCardVisible(var_15_0)
	arg_15_0:_refreshSeasonArrowShow()
end

function var_0_0._onCorrectPlayCardVisible(arg_16_0, arg_16_1)
	arg_16_1 = arg_16_1 or var_0_0.getMaxItemCount()

	if arg_16_1 <= var_0_0.VisibleCount then
		recthelper.setAnchorX(arg_16_0._playCardItemTransform, 0)
	else
		recthelper.setAnchorX(arg_16_0._playCardItemTransform, (arg_16_1 - var_0_0.VisibleCount) * var_0_0.HalfCardWidth - var_0_0.OffsetHalfX)
	end
end

function var_0_0.recordPlayData(arg_17_0, arg_17_1)
	if not arg_17_1 then
		return
	end

	if not FightDataHelper.operationDataMgr:canShowOpAct(arg_17_1) then
		return
	end

	if FightCardDataHelper.checkOpAsPlayCardHandle(arg_17_1) then
		table.insert(arg_17_0._begin_round_ops, arg_17_1)
	elseif arg_17_1:isMoveCard() then
		local var_17_0 = FightDataHelper.operationDataMgr.extraMoveAct

		if var_17_0 > 0 and var_17_0 > #arg_17_0._extra_move_round_ops then
			table.insert(arg_17_0._extra_move_round_ops, arg_17_1)
		else
			table.insert(arg_17_0._begin_round_ops, arg_17_1)
		end
	end

	table.insert(arg_17_0._all_recorded_ops, arg_17_1)
end

function var_0_0._onPlayOperationEffectDone(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:_refreshPlayOperationData(arg_18_1, arg_18_2)
	arg_18_0:_refreshSeasonArrowShow()

	if #arg_18_0._all_recorded_ops == 0 then
		FightController.instance:dispatchEvent(FightEvent.DetectCardOpEndAfterOperationEffectDone, arg_18_1)
	end
end

function var_0_0._onPlayCardFlowDone(arg_19_0, arg_19_1)
	tabletool.removeValue(arg_19_0._all_recorded_ops, arg_19_1)

	if #arg_19_0._all_recorded_ops == 0 then
		FightController.instance:dispatchEvent(FightEvent.DetectCardOpEndAfterOperationEffectDone)
	end
end

function var_0_0._onPlayAssistBossCardDone(arg_20_0, arg_20_1)
	tabletool.removeValue(arg_20_0._all_recorded_ops, arg_20_1)

	if #arg_20_0._all_recorded_ops == 0 then
		FightController.instance:dispatchEvent(FightEvent.DetectCardOpEndAfterOperationEffectDone)
	end
end

function var_0_0._onRefreshPlayCardRoundOp(arg_21_0, arg_21_1)
	arg_21_0:_onPlayOperationEffectDone(arg_21_1, true)
end

function var_0_0._refreshSeasonArrowShow(arg_22_0)
	if not FightModel.instance:isSeason2() then
		return
	end

	if FightDataHelper.operationDataMgr:isCardOpEnd() then
		return
	end

	local var_22_0, var_22_1 = var_0_0.getMaxItemCount()
	local var_22_2 = false

	for iter_22_0 = 1, var_22_0 do
		local var_22_3 = arg_22_0._playCardItemList[iter_22_0]

		if var_22_3 and not var_22_3.fightBeginRoundOp then
			if not var_22_2 then
				var_22_3:refreshSeasonArrowShow(true)

				var_22_2 = true
			else
				var_22_3:refreshSeasonArrowShow(false)
			end
		end
	end
end

function var_0_0._refreshPlayOperationData(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_0:getShowIndex(arg_23_1)

	if var_23_0 then
		arg_23_0:_refreshItemData(var_23_0, arg_23_1)

		if not arg_23_2 then
			tabletool.removeValue(arg_23_0._all_recorded_ops, arg_23_1)
		end
	end
end

function var_0_0.getShowIndex(arg_24_0, arg_24_1)
	local var_24_0 = tabletool.indexOf(arg_24_0._begin_round_ops, arg_24_1)

	if var_24_0 then
		for iter_24_0 = 1, var_24_0 - 1 do
			if arg_24_0._begin_round_ops[iter_24_0]:needCopyCard() then
				var_24_0 = var_24_0 + 1
			end
		end
	end

	if not var_24_0 then
		local var_24_1 = tabletool.indexOf(arg_24_0._extra_move_round_ops, arg_24_1)

		if var_24_1 then
			var_24_0 = var_0_0.getMaxItemCount() - FightDataHelper.operationDataMgr.extraMoveAct + var_24_1
		end
	end

	return var_24_0
end

function var_0_0._refreshItemData(arg_25_0, arg_25_1, arg_25_2)
	local var_25_0 = arg_25_0._playCardItemList[arg_25_1]

	if not var_25_0 then
		arg_25_0:_onCorrectPlayCardObjList()

		var_25_0 = arg_25_0._playCardItemList[arg_25_1]
	end

	if not var_25_0 then
		local var_25_1 = string.format("刷新出牌区出错,想要刷新下标:%d,但是当前总可用牌区点数为:%d", arg_25_1, var_0_0.getMaxItemCount())

		logError(var_25_1)
		arg_25_0:_refreshAllItemData()

		return
	end

	gohelper.setActive(var_25_0.go, true)
	var_25_0:updateItem(arg_25_2)
	arg_25_0:_refreshItemAni(arg_25_1, arg_25_2)

	if arg_25_2 and arg_25_2:needCopyCard() then
		arg_25_0:_onCorrectPlayCardObjList()

		local var_25_2 = arg_25_0._playCardItemList[arg_25_1 + 1]

		gohelper.setActive(var_25_2.go, true)
		var_25_2:updateItem(arg_25_2)
		var_25_2:setCopyCard()
		arg_25_0:_refreshItemAni(arg_25_1 + 1, arg_25_2)
	end
end

function var_0_0._refreshItemAni(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0._playCardItemList[arg_26_1]
	local var_26_1, var_26_2 = var_0_0.getMaxItemCount()

	if arg_26_1 > var_26_1 - FightDataHelper.operationDataMgr.extraMoveAct then
		if arg_26_2 then
			var_26_0:showExtMoveEndEffect()
		else
			var_26_0:showExtMoveEffect()
		end
	else
		var_26_0:hideExtMoveEffect()
	end
end

function var_0_0._onCorrectPlayCardObjList(arg_27_0)
	local var_27_0, var_27_1 = var_0_0.getMaxItemCount()

	for iter_27_0 = 1, var_27_0 do
		local var_27_2 = arg_27_0._playCardItemList[iter_27_0] or arg_27_0:_createNewPlayItemObj(iter_27_0)

		gohelper.setActive(var_27_2.go, true)

		local var_27_3, var_27_4 = var_0_0.calcCardPosX(iter_27_0, var_27_0)

		recthelper.setAnchor(var_27_2.tr, var_27_3, var_27_4)
	end

	for iter_27_1 = var_27_0 + 1, #arg_27_0._playCardItemList do
		local var_27_5 = arg_27_0._playCardItemList[iter_27_1]

		var_27_5:updateItem(nil)
		gohelper.setActive(var_27_5.go, false)
	end

	arg_27_0._curShowItemCount = var_27_0

	recthelper.setWidth(arg_27_0._playCardItemTransform, var_27_0 * var_0_0.PlayCardWidth)

	return var_27_0
end

function var_0_0._createNewPlayItemObj(arg_28_0, arg_28_1)
	local var_28_0 = gohelper.clone(arg_28_0._playCardItemPrefab, arg_28_0._playCardItemRoot, "cardItem" .. arg_28_1)
	local var_28_1 = MonoHelper.addNoUpdateLuaComOnceToGo(var_28_0, FightViewPlayCardItem)

	var_28_1.PARENTVIEW = arg_28_0

	table.insert(arg_28_0._playCardItemList, arg_28_1, var_28_1)
	arg_28_0:_refreshItemData(arg_28_1, nil)

	return var_28_1
end

function var_0_0._onHidePlayCardAllCard(arg_29_0)
	arg_29_0:_hideAllCard()
end

function var_0_0._hideAllCard(arg_30_0)
	for iter_30_0, iter_30_1 in ipairs(arg_30_0._playCardItemList) do
		gohelper.setActive(iter_30_1._innerGO, false)
	end
end

function var_0_0.refreshRankUpDown(arg_31_0)
	local var_31_0 = {}

	for iter_31_0, iter_31_1 in ipairs(arg_31_0._playCardItemList) do
		local var_31_1 = arg_31_0._playCardItemList[iter_31_0].fightBeginRoundOp

		if var_31_1 and var_31_1:isPlayCard() then
			local var_31_2 = lua_skill.configDict[var_31_1.skillId]

			if var_31_2 then
				for iter_31_2 = 1, FightEnum.MaxBehavior do
					local var_31_3 = var_31_2["behavior" .. iter_31_2]

					if var_31_3 then
						local var_31_4 = FightStrUtil.instance:getSplitCache(var_31_3, "#")

						if var_31_4[1] == "60075" then
							local var_31_5 = var_31_4[2] ~= "0"
							local var_31_6 = var_31_4[3] ~= "0"

							if var_31_5 then
								for iter_31_3 = iter_31_0 - 1, 1, -1 do
									local var_31_7 = arg_31_0._playCardItemList[iter_31_3].fightBeginRoundOp

									if var_31_7 and var_31_7:isPlayCard() then
										var_31_0[iter_31_3] = var_31_0[iter_31_3] or {}

										local var_31_8 = tonumber(var_31_4[2])

										table.insert(var_31_0[iter_31_3], var_31_8 > 0 and "Up" or "Down")

										break
									end
								end
							end

							if var_31_6 then
								for iter_31_4 = iter_31_0 + 1, #arg_31_0._playCardItemList do
									local var_31_9 = arg_31_0._playCardItemList[iter_31_4]
									local var_31_10 = var_31_9 and var_31_9.fightBeginRoundOp

									if var_31_10 and var_31_10:isPlayCard() then
										var_31_0[iter_31_4] = var_31_0[iter_31_4] or {}

										local var_31_11 = tonumber(var_31_4[3])

										table.insert(var_31_0[iter_31_4], var_31_11 > 0 and "Up" or "Down")

										break
									end
								end
							end
						end
					end
				end
			end
		end
	end

	for iter_31_5, iter_31_6 in ipairs(arg_31_0._playCardItemList) do
		local var_31_12 = var_31_0[iter_31_5]

		gohelper.setActive(iter_31_6.rankChangeRoot, var_31_12)

		if var_31_12 then
			local var_31_13 = "#go_" .. table.concat(var_31_12)
			local var_31_14 = iter_31_6.rankChangeRoot.transform
			local var_31_15 = var_31_14.childCount

			for iter_31_7 = 0, var_31_15 - 1 do
				local var_31_16 = var_31_14:GetChild(iter_31_7).gameObject

				gohelper.setActive(var_31_16, var_31_16.name == var_31_13)
			end
		end
	end
end

function var_0_0._clearAllItemData(arg_32_0)
	for iter_32_0 = 1, #arg_32_0._playCardItemList do
		arg_32_0._playCardItemList[iter_32_0]:updateItem(nil)
		arg_32_0:_refreshItemAni(iter_32_0, nil)
	end

	arg_32_0:_clearBeginRoundOps()
end

function var_0_0._createAndInsertItem(arg_33_0, arg_33_1)
	local var_33_0, var_33_1 = var_0_0.getMaxItemCount()

	if var_33_0 > #arg_33_0._playCardItemList then
		arg_33_0:_createNewPlayItemObj(arg_33_1)
	else
		local var_33_2 = #arg_33_0._playCardItemList
		local var_33_3 = table.remove(arg_33_0._playCardItemList, var_33_2)

		table.insert(arg_33_0._playCardItemList, arg_33_1, var_33_3)
	end

	for iter_33_0, iter_33_1 in ipairs(arg_33_0._playCardItemList) do
		iter_33_1.go.name = "cardItem" .. iter_33_0
	end
end

function var_0_0._onNoActCostMoveFlowOver(arg_34_0)
	local var_34_0 = var_0_0.getMaxItemCount()
	local var_34_1 = #arg_34_0._begin_round_ops + 1

	arg_34_0:_createAndInsertItem(var_34_1)
	arg_34_0:_onCorrectPlayCardObjList()
	arg_34_0:_refreshItemData(var_34_1, nil)

	local var_34_2 = var_0_0.calContentPosX(var_34_1 - 1, var_34_0, recthelper.getAnchorX(arg_34_0._playCardItemTransform))

	if var_34_2 then
		recthelper.setAnchorX(arg_34_0._playCardItemTransform, var_34_2)
	end
end

function var_0_0._onShowPlayCardFlyEffect(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	if not arg_35_0._fly_items then
		arg_35_0._fly_items = {}
	end

	local var_35_0 = FightCardPlayFlyEffect.New(arg_35_0, arg_35_1, arg_35_2, arg_35_3)

	var_35_0:_startFly()
	table.insert(arg_35_0._fly_items, var_35_0)
end

function var_0_0.onFlyDone(arg_36_0, arg_36_1)
	if arg_36_0._fly_items then
		for iter_36_0, iter_36_1 in ipairs(arg_36_0._fly_items) do
			if iter_36_1 == arg_36_1 then
				table.remove(arg_36_0._fly_items, iter_36_0)

				break
			end
		end
	end
end

function var_0_0._releaseAllFlyItems(arg_37_0)
	if arg_37_0._fly_items then
		for iter_37_0, iter_37_1 in ipairs(arg_37_0._fly_items) do
			iter_37_1:releaseSelf()
		end
	end

	arg_37_0._fly_items = nil
end

function var_0_0._showPlayCardEffect(arg_38_0, arg_38_1, arg_38_2, arg_38_3)
	local var_38_0 = arg_38_0._playCardItemList[arg_38_2]

	if var_38_0 and arg_38_1 then
		var_38_0:showPlayCardEffect(arg_38_1, arg_38_3)
	end
end

function var_0_0._clearBeginRoundOps(arg_39_0)
	arg_39_0._begin_round_ops = {}
	arg_39_0._extra_move_round_ops = {}
	arg_39_0._all_recorded_ops = {}
end

function var_0_0.onBeforeCancelOperation(arg_40_0)
	arg_40_0.curIndex2OriginHandCardIndex = {}

	for iter_40_0, iter_40_1 in ipairs(FightDataHelper.handCardMgr.handCard) do
		arg_40_0.curIndex2OriginHandCardIndex[iter_40_0] = iter_40_1.originHandCardIndex
	end
end

function var_0_0._onResetCard(arg_41_0, arg_41_1)
	arg_41_0:_releaseAllFlyItems()
	FightController.instance:dispatchEvent(FightEvent.SetBlockCardOperate, true)

	local var_41_0 = arg_41_0:getUserDataTb_()

	var_41_0.view = arg_41_0
	var_41_0.viewGO = arg_41_0.viewGO
	var_41_0.playCardItemList = arg_41_0._playCardItemList
	var_41_0.oldCardOps = arg_41_1
	var_41_0.curIndex2OriginHandCardIndex = arg_41_0.curIndex2OriginHandCardIndex
	arg_41_0.curIndex2OriginHandCardIndex = nil

	arg_41_0:_hideRankChangeEffect()
	arg_41_0._resetCardFlow:registerDoneListener(arg_41_0._onResetEffectDone, arg_41_0)
	arg_41_0._resetCardFlow:start(var_41_0)
end

function var_0_0._hideRankChangeEffect(arg_42_0)
	for iter_42_0, iter_42_1 in ipairs(arg_42_0._playCardItemList) do
		gohelper.setActive(iter_42_1.rankChangeRoot, false)
	end
end

function var_0_0._onResetEffectDone(arg_43_0)
	arg_43_0:_onCorrectPlayCardObjList()
	arg_43_0:_clearAllItemData()
	arg_43_0._resetCardFlow:unregisterDoneListener(arg_43_0._onResetEffectDone, arg_43_0)
	FightController.instance:dispatchEvent(FightEvent.SetBlockCardOperate, false)
end

function var_0_0.calcCardPosX(arg_44_0, arg_44_1)
	return -var_0_0.PlayCardWidth * arg_44_1 / 2 - var_0_0.HalfCardWidth + var_0_0.PlayCardWidth * arg_44_0, 2
end

return var_0_0
