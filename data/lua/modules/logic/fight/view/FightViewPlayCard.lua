module("modules.logic.fight.view.FightViewPlayCard", package.seeall)

slot0 = class("FightViewPlayCard", BaseView)
slot0.PlayCardWidth = 130
slot0.HalfCardWidth = slot0.PlayCardWidth / 2
slot0.VisibleCount = 9
slot0.HalfScrollWidth = 610
slot0.OffsetX = 1220 - slot0.PlayCardWidth * slot0.VisibleCount
slot0.OffsetHalfX = slot0.OffsetX / 2

function slot0.onInitView(slot0)
	slot0._playCardGO = gohelper.findChild(slot0.viewGO, "root/playcards")
	slot0._playCardTr = slot0._playCardGO.transform
	slot0._scrollViewObj = gohelper.findChild(slot0.viewGO, "root/playcards/#scroll_cards")
	slot0._scrollView = gohelper.onceAddComponent(slot0._scrollViewObj, gohelper.Type_ScrollRect)
	slot0._playCardItemRoot = gohelper.findChild(slot0.viewGO, "root/playcards/#scroll_cards/Viewport/Content")
	slot0._playCardItemTransform = slot0._playCardItemRoot.transform
	slot0._playCardItemPrefab = gohelper.findChild(slot0.viewGO, "root/playcards/#scroll_cards/Viewport/Content/cardItem")

	gohelper.setActive(slot0._playCardItemPrefab, false)

	slot0._playCardItemList = {}
	slot0._resetCardFlow = FlowSequence.New()

	slot0._resetCardFlow:addWork(FightCardResetEffect.New())
	slot0:_clearBeginRoundOps()
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onOpen(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.DistributeCards, slot0._refreshAllItemData, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._refreshAllItemData, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PushCardInfo, slot0._refreshAllItemData, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRevertCard, slot0._refreshAllItemData, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnResetCard, slot0._onResetCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnAddActPoint, slot0._refreshAllItemData, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, slot0._refreshAllItemData, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnEffectExtraMoveAct, slot0._refreshAllItemData, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRestartFightDisposeDone, slot0._refreshAllItemData, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.GMHideFightView, slot0._refreshAllItemData, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ShowPlayCardEffect, slot0._showPlayCardEffect, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ShowPlayCardFlyEffect, slot0._onShowPlayCardFlyEffect, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.AddPlayOperationData, slot0._onAddPlayOperationData, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PlayOperationEffectDone, slot0._onPlayOperationEffectDone, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.onNoActCostMoveFlowOver, slot0._onNoActCostMoveFlowOver, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.CorrectPlayCardVisible, slot0._onCorrectPlayCardVisible, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBattleBackPack, slot0.OnBackPackClick, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.RefreshPlayCardRoundOp, slot0._onRefreshPlayCardRoundOp, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnPlayCardFlowDone, slot0._onPlayCardFlowDone, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnPlayAssistBossCardFlowDone, slot0._onPlayAssistBossCardDone, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.EnterOperateState, slot0._onEnterOperateState, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.ExitOperateState, slot0._onExitOperateState, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.HidePlayCardAllCard, slot0._onHidePlayCardAllCard, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.EnterStage, slot0._onEnterStage, slot0)
end

function slot0._onEnterStage(slot0, slot1)
	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	if slot1 == FightStageMgr.StageType.Play then
		gohelper.setActive(slot0._playCardGO, false)
	end
end

function slot0._onEnterOperateState(slot0, slot1)
	if slot1 == FightStageMgr.OperateStateType.SeasonChangeHero then
		gohelper.setActive(slot0._playCardGO, false)
	end
end

function slot0._onExitOperateState(slot0, slot1)
	if slot1 == FightStageMgr.OperateStateType.SeasonChangeHero then
		gohelper.setActive(slot0._playCardGO, true)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._resetScrollView, slot0)
	slot0._resetCardFlow:unregisterDoneListener(slot0._onResetEffectDone, slot0)
	slot0._resetCardFlow:stop()
	slot0:_clearBeginRoundOps()
	slot0:_releaseAllFlyItems()
end

function slot0.isVisible(slot0, slot1, slot2)
	slot5 = false

	return math.abs(uv0.calcCardPosX(slot0, slot1) + slot2) + uv0.HalfCardWidth <= uv0.HalfScrollWidth and slot4 - uv0.HalfCardWidth <= uv0.HalfScrollWidth and true or false
end

function slot0.OnBackPackClick(slot0)
	if slot0._playCardItemList then
		for slot4, slot5 in pairs(slot0._playCardItemList) do
			if slot5 then
				slot5:_onClickThis()
				FightController.instance:dispatchEvent(FightEvent.HideCardSkillTips)

				return
			end
		end
	end
end

function slot0.calContentPosX(slot0, slot1, slot2)
	if slot1 <= uv0.VisibleCount then
		return 0
	end

	slot3 = uv0.calcCardPosX(slot0, slot1)
	slot4 = uv0.isVisible(slot0, slot1, slot2)

	if slot1 - slot0 <= 2 then
		return -((slot1 - uv0.VisibleCount) * uv0.HalfCardWidth) + uv0.OffsetHalfX
	elseif slot4 then
		if not uv0.isVisible(slot0 + 2, slot1, slot2) then
			return -(slot1 - uv0.VisibleCount) * uv0.HalfCardWidth + (slot1 - (slot0 + 2)) * uv0.PlayCardWidth - uv0.OffsetHalfX
		else
			return slot2
		end
	elseif slot3 < 0 then
		return (slot1 - uv0.VisibleCount) * uv0.HalfCardWidth - (slot0 - 1) * uv0.PlayCardWidth - uv0.OffsetHalfX
	else
		return -(slot1 - uv0.VisibleCount) * uv0.HalfCardWidth + (slot1 - (slot0 + 2)) * uv0.PlayCardWidth - uv0.OffsetHalfX
	end

	return 0
end

function slot0._resetScrollView(slot0)
	slot0._scrollView.enabled = true
end

function slot0._onAddPlayOperationData(slot0, slot1)
	if not slot1 then
		return
	end

	slot0:recordPlayData(slot1)

	slot0._scrollView.enabled = false

	TaskDispatcher.cancelTask(slot0._resetScrollView, slot0)
	TaskDispatcher.runDelay(slot0._resetScrollView, slot0, 1)

	if uv0.VisibleCount < uv0.getMaxItemCount() then
		if FightCardDataHelper.isNoCostSpecialCard(slot1.cardInfoMO) then
			return
		end

		if not slot0._playCardItemList[slot0:getShowIndex(slot1)] then
			return
		end

		if gohelper.fitScrollItemOffset(slot0._scrollViewObj, slot0._playCardItemRoot, slot4.go, ScrollEnum.ScrollDirH) > 0 then
			recthelper.setAnchorX(slot0._playCardItemTransform, (slot2 - uv0.VisibleCount) * uv0.HalfCardWidth - (slot3 - 1) * uv0.PlayCardWidth - uv0.OffsetHalfX)
		elseif slot2 - slot3 <= 2 then
			recthelper.setAnchorX(slot0._playCardItemTransform, -((slot2 - uv0.VisibleCount) * uv0.HalfCardWidth) + uv0.OffsetHalfX)
		else
			if not slot0._playCardItemList[slot3 + 2] then
				return
			end

			if gohelper.fitScrollItemOffset(slot0._scrollViewObj, slot0._playCardItemRoot, slot7.go, ScrollEnum.ScrollDirH) ~= 0 then
				recthelper.setAnchorX(slot0._playCardItemTransform, -(slot2 - uv0.VisibleCount) * uv0.HalfCardWidth + (slot2 - slot6) * uv0.PlayCardWidth - uv0.OffsetHalfX)
			end
		end
	else
		slot0:_onCorrectPlayCardVisible(slot2)
	end
end

function slot0.getMaxItemCount()
	slot2 = FightCardModel.instance:getCardMO().actPoint
	slot3 = 0

	if FightCardModel.instance:getCardMO().extraMoveAct > 0 then
		slot2 = slot1 + slot0
	end

	for slot8, slot9 in ipairs(FightCardModel.instance:getShowOpActList()) do
		if slot9:isPlayCard() and slot9.costActPoint == 0 then
			slot2 = slot2 + 1
			slot3 = slot3 + 1
		end

		if slot9:isPlayCard() and slot9:needCopyCard() then
			slot2 = slot2 + 1
			slot3 = slot3 + 1
		end

		if slot9:isAssistBossPlayCard() then
			slot2 = slot2 + 1
			slot3 = slot3 + 1
		end

		if slot9:isPlayerFinisherSkill() then
			slot2 = slot2 + 1
			slot3 = slot3 + 1
		end
	end

	return slot2, slot3
end

function slot0._refreshAllItemData(slot0)
	if not FightCardModel.instance:getCardMO() then
		return
	end

	slot0:_clearAllItemData()

	slot2 = slot0:_onCorrectPlayCardObjList()

	for slot7, slot8 in ipairs(FightCardModel.instance:getShowOpActList()) do
		slot0:recordPlayData(slot8)
		slot0:_refreshPlayOperationData(slot8)
	end

	slot0:_onCorrectPlayCardVisible(slot2)
	slot0:_refreshSeasonArrowShow()
end

function slot0._onCorrectPlayCardVisible(slot0, slot1)
	if (slot1 or uv0.getMaxItemCount()) <= uv0.VisibleCount then
		recthelper.setAnchorX(slot0._playCardItemTransform, 0)
	else
		recthelper.setAnchorX(slot0._playCardItemTransform, (slot1 - uv0.VisibleCount) * uv0.HalfCardWidth - uv0.OffsetHalfX)
	end
end

function slot0.recordPlayData(slot0, slot1)
	if not slot1 then
		return
	end

	if not FightCardModel.instance:canShowOpAct(slot1) then
		return
	end

	if slot1:isPlayCard() or slot1:isAssistBossPlayCard() or slot1:isPlayerFinisherSkill() then
		table.insert(slot0._begin_round_ops, slot1)
	elseif slot1:isMoveCard() then
		if FightCardModel.instance:getCardMO().extraMoveAct > 0 and slot2 > #slot0._extra_move_round_ops then
			table.insert(slot0._extra_move_round_ops, slot1)
		else
			table.insert(slot0._begin_round_ops, slot1)
		end
	end

	table.insert(slot0._all_recorded_ops, slot1)
end

function slot0._onPlayOperationEffectDone(slot0, slot1, slot2)
	slot0:_refreshPlayOperationData(slot1, slot2)
	slot0:_refreshSeasonArrowShow()

	if #slot0._all_recorded_ops == 0 then
		FightController.instance:dispatchEvent(FightEvent.DetectCardOpEndAfterOperationEffectDone, slot1)
	end
end

function slot0._onPlayCardFlowDone(slot0, slot1)
	tabletool.removeValue(slot0._all_recorded_ops, slot1)

	if #slot0._all_recorded_ops == 0 then
		FightController.instance:dispatchEvent(FightEvent.DetectCardOpEndAfterOperationEffectDone)
	end
end

function slot0._onPlayAssistBossCardDone(slot0, slot1)
	tabletool.removeValue(slot0._all_recorded_ops, slot1)

	if #slot0._all_recorded_ops == 0 then
		FightController.instance:dispatchEvent(FightEvent.DetectCardOpEndAfterOperationEffectDone)
	end
end

function slot0._onRefreshPlayCardRoundOp(slot0, slot1)
	slot0:_onPlayOperationEffectDone(slot1, true)
end

function slot0._refreshSeasonArrowShow(slot0)
	if not FightModel.instance:isSeason2() then
		return
	end

	if FightCardModel.instance:isCardOpEnd() then
		return
	end

	slot1, slot2 = uv0.getMaxItemCount()

	for slot7 = 1, slot1 do
		if slot0._playCardItemList[slot7] and not slot8.fightBeginRoundOp then
			if not false then
				slot8:refreshSeasonArrowShow(true)

				slot3 = true
			else
				slot8:refreshSeasonArrowShow(false)
			end
		end
	end
end

function slot0._refreshPlayOperationData(slot0, slot1, slot2)
	if slot0:getShowIndex(slot1) then
		slot0:_refreshItemData(slot3, slot1)

		if not slot2 then
			tabletool.removeValue(slot0._all_recorded_ops, slot1)
		end
	end
end

function slot0.getShowIndex(slot0, slot1)
	if tabletool.indexOf(slot0._begin_round_ops, slot1) then
		for slot6 = 1, slot2 - 1 do
			if slot0._begin_round_ops[slot6]:needCopyCard() then
				slot2 = slot2 + 1
			end
		end
	end

	if not slot2 and tabletool.indexOf(slot0._extra_move_round_ops, slot1) then
		slot2 = uv0.getMaxItemCount() - FightCardModel.instance:getCardMO().extraMoveAct + slot3
	end

	return slot2
end

function slot0._refreshItemData(slot0, slot1, slot2)
	if not slot0._playCardItemList[slot1] then
		slot0:_onCorrectPlayCardObjList()

		slot3 = slot0._playCardItemList[slot1]
	end

	if not slot3 then
		logError(string.format("刷新出牌区出错,想要刷新下标:%d,但是当前总可用牌区点数为:%d", slot1, uv0.getMaxItemCount()))
		slot0:_refreshAllItemData()

		return
	end

	gohelper.setActive(slot3.go, true)
	slot3:updateItem(slot2)
	slot0:_refreshItemAni(slot1, slot2)

	if slot2 and slot2:needCopyCard() then
		slot0:_onCorrectPlayCardObjList()

		slot3 = slot0._playCardItemList[slot1 + 1]

		gohelper.setActive(slot3.go, true)
		slot3:updateItem(slot2)
		slot3:setCopyCard()
		slot0:_refreshItemAni(slot1 + 1, slot2)
	end
end

function slot0._refreshItemAni(slot0, slot1, slot2)
	slot4, slot5 = uv0.getMaxItemCount()

	if slot1 > slot4 - FightCardModel.instance:getCardMO().extraMoveAct then
		if slot2 then
			slot0._playCardItemList[slot1]:showExtMoveEndEffect()
		else
			slot3:showExtMoveEffect()
		end
	else
		slot3:hideExtMoveEffect()
	end
end

function slot0._onCorrectPlayCardObjList(slot0)
	slot1, slot2 = uv0.getMaxItemCount()

	for slot6 = 1, slot1 do
		slot7 = slot0._playCardItemList[slot6] or slot0:_createNewPlayItemObj(slot6)

		gohelper.setActive(slot7.go, true)

		slot8, slot9 = uv0.calcCardPosX(slot6, slot1)

		recthelper.setAnchor(slot7.tr, slot8, slot9)
	end

	for slot6 = slot1 + 1, #slot0._playCardItemList do
		slot7 = slot0._playCardItemList[slot6]

		slot7:updateItem(nil)
		gohelper.setActive(slot7.go, false)
	end

	slot0._curShowItemCount = slot1

	recthelper.setWidth(slot0._playCardItemTransform, slot1 * uv0.PlayCardWidth)

	return slot1
end

function slot0._createNewPlayItemObj(slot0, slot1)
	slot3 = MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0._playCardItemPrefab, slot0._playCardItemRoot, "cardItem" .. slot1), FightViewPlayCardItem)
	slot3.PARENTVIEW = slot0

	table.insert(slot0._playCardItemList, slot1, slot3)
	slot0:_refreshItemData(slot1, nil)

	return slot3
end

function slot0._onHidePlayCardAllCard(slot0)
	slot0:_hideAllCard()
end

function slot0._hideAllCard(slot0)
	for slot4, slot5 in ipairs(slot0._playCardItemList) do
		gohelper.setActive(slot5._innerGO, false)
	end
end

function slot0.refreshRankUpDown(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0._playCardItemList) do
		if slot0._playCardItemList[slot5].fightBeginRoundOp and slot8:isPlayCard() and lua_skill.configDict[slot8.skillId] then
			for slot13 = 1, FightEnum.MaxBehavior do
				if slot9["behavior" .. slot13] and FightStrUtil.instance:getSplitCache(slot14, "#")[1] == "60075" then
					slot17 = slot15[3] ~= "0"

					if slot15[2] ~= "0" then
						for slot21 = slot5 - 1, 1, -1 do
							if slot0._playCardItemList[slot21].fightBeginRoundOp and slot23:isPlayCard() then
								slot1[slot21] = slot1[slot21] or {}

								table.insert(slot1[slot21], tonumber(slot15[2]) > 0 and "Up" or "Down")

								break
							end
						end
					end

					if slot17 then
						for slot21 = slot5 + 1, #slot0._playCardItemList do
							if slot0._playCardItemList[slot21] and slot22.fightBeginRoundOp and slot23:isPlayCard() then
								slot1[slot21] = slot1[slot21] or {}

								table.insert(slot1[slot21], tonumber(slot15[3]) > 0 and "Up" or "Down")

								break
							end
						end
					end
				end
			end
		end
	end

	for slot5, slot6 in ipairs(slot0._playCardItemList) do
		slot7 = slot1[slot5]

		gohelper.setActive(slot6.rankChangeRoot, slot7)

		if slot7 then
			for slot14 = 0, slot6.rankChangeRoot.transform.childCount - 1 do
				slot15 = slot9:GetChild(slot14).gameObject

				gohelper.setActive(slot15, slot15.name == "#go_" .. table.concat(slot7))
			end
		end
	end
end

function slot0._clearAllItemData(slot0)
	for slot4 = 1, #slot0._playCardItemList do
		slot0._playCardItemList[slot4]:updateItem(nil)
		slot0:_refreshItemAni(slot4, nil)
	end

	slot0:_clearBeginRoundOps()
end

function slot0._createAndInsertItem(slot0, slot1)
	slot2, slot3 = uv0.getMaxItemCount()

	if slot2 > #slot0._playCardItemList then
		slot0:_createNewPlayItemObj(slot1)
	else
		table.insert(slot0._playCardItemList, slot1, table.remove(slot0._playCardItemList, #slot0._playCardItemList))
	end

	for slot7, slot8 in ipairs(slot0._playCardItemList) do
		slot8.go.name = "cardItem" .. slot7
	end
end

function slot0._onNoActCostMoveFlowOver(slot0)
	slot2 = #slot0._begin_round_ops + 1

	slot0:_createAndInsertItem(slot2)
	slot0:_onCorrectPlayCardObjList()
	slot0:_refreshItemData(slot2, nil)

	if uv0.calContentPosX(slot2 - 1, uv0.getMaxItemCount(), recthelper.getAnchorX(slot0._playCardItemTransform)) then
		recthelper.setAnchorX(slot0._playCardItemTransform, slot3)
	end
end

function slot0._onShowPlayCardFlyEffect(slot0, slot1, slot2, slot3)
	if not slot0._fly_items then
		slot0._fly_items = {}
	end

	slot4 = FightCardPlayFlyEffect.New(slot0, slot1, slot2, slot3)

	slot4:_startFly()
	table.insert(slot0._fly_items, slot4)
end

function slot0.onFlyDone(slot0, slot1)
	if slot0._fly_items then
		for slot5, slot6 in ipairs(slot0._fly_items) do
			if slot6 == slot1 then
				table.remove(slot0._fly_items, slot5)

				break
			end
		end
	end
end

function slot0._releaseAllFlyItems(slot0)
	if slot0._fly_items then
		for slot4, slot5 in ipairs(slot0._fly_items) do
			slot5:releaseSelf()
		end
	end

	slot0._fly_items = nil
end

function slot0._showPlayCardEffect(slot0, slot1, slot2, slot3)
	if slot0._playCardItemList[slot2] and slot1 then
		slot4:showPlayCardEffect(slot1, slot3)
	end
end

function slot0._clearBeginRoundOps(slot0)
	slot0._begin_round_ops = {}
	slot0._extra_move_round_ops = {}
	slot0._all_recorded_ops = {}
end

function slot0._onResetCard(slot0, slot1)
	slot0:_releaseAllFlyItems()
	FightController.instance:dispatchEvent(FightEvent.SetBlockCardOperate, true)

	slot2 = slot0:getUserDataTb_()
	slot2.view = slot0
	slot2.viewGO = slot0.viewGO
	slot2.playCardItemList = slot0._playCardItemList
	slot2.oldCardOps = slot1

	slot0:_hideRankChangeEffect()
	slot0._resetCardFlow:registerDoneListener(slot0._onResetEffectDone, slot0)
	slot0._resetCardFlow:start(slot2)
end

function slot0._hideRankChangeEffect(slot0)
	for slot4, slot5 in ipairs(slot0._playCardItemList) do
		gohelper.setActive(slot5.rankChangeRoot, false)
	end
end

function slot0._onResetEffectDone(slot0)
	slot0:_onCorrectPlayCardObjList()
	slot0:_clearAllItemData()
	slot0._resetCardFlow:unregisterDoneListener(slot0._onResetEffectDone, slot0)
	FightController.instance:dispatchEvent(FightEvent.SetBlockCardOperate, false)
end

function slot0.calcCardPosX(slot0, slot1)
	return -uv0.PlayCardWidth * slot1 / 2 - uv0.HalfCardWidth + uv0.PlayCardWidth * slot0, 2
end

return slot0
