module("modules.logic.fight.view.FightViewEnemyCard", package.seeall)

slot0 = class("FightViewEnemyCard", BaseView)

function slot0.onInitView(slot0)
	slot0._opItemContainer = gohelper.findChild(slot0.viewGO, "root/enemycards")
	slot0._opItemGO = gohelper.findChild(slot0.viewGO, "root/enemycards/item")
	slot0._enemyCardTip = gohelper.findChild(slot0.viewGO, "root/enemycards/enemyCardTip")
	slot0._txtActionCount = gohelper.findChildText(slot0.viewGO, "root/enemycards/enemyCardTip/txtactioncount")
	slot0._opItemList = slot0:getUserDataTb_()

	gohelper.setActive(slot0._opItemGO, false)
	gohelper.setActive(slot0._opItemContainer, false)

	slot0._myActBreakFlow = FlowSequence.New()

	slot0._myActBreakFlow:addWork(FightMyActPointBreakEffect.New())
	slot0._myActBreakFlow:addWork(FightEnemyPlayCardOpInEffect.New())

	slot0._enemyActBreakFlow = FlowSequence.New()

	slot0._enemyActBreakFlow:addWork(FightEnemyActPointBreakEffect.New())

	slot0._longPressTab = slot0:getUserDataTb_()
	slot0._deadEntityIds = nil
	slot0._enemyCurrActPoint = 0
	slot0._enemyNextActPoint = 0
end

function slot0.onDestroyView(slot0)
	slot0._myActBreakFlow:destroy()
	slot0._enemyActBreakFlow:destroy()

	for slot4, slot5 in ipairs(slot0._longPressTab) do
		slot5.longPress:RemoveLongPressListener()
		slot5.clickUp:RemoveClickUpListener()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, slot0._onStartSequenceFinish, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0, LuaEventSystem.Low)
	slot0:addEventCb(FightController.instance, FightEvent.OnRoundSequenceStart, slot0._onRoundSequenceStart, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.PushFightWave, slot0._onPushFightWave, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.BeforeDeadEffect, slot0._onEntityDead, slot0)
	slot0:addEventCb(FightController.instance, FightEvent.OnSummon, slot0._onSummon, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnStartSequenceFinish, slot0._onStartSequenceFinish, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceFinish, slot0._onRoundSequenceFinish, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnRoundSequenceStart, slot0._onRoundSequenceStart, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.PushFightWave, slot0._onPushFightWave, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.BeforeDeadEffect, slot0._onEntityDead, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnSummon, slot0._onSummon, slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._onSkillFinishDoActPoint, slot0)
end

function slot0._onStartSequenceFinish(slot0)
	slot0:_updateEnemyCardItems()

	slot0._myActPoint = FightCardModel.instance:getCardMO().actPoint
	slot0._enemyCurrActPoint = FightModel.instance:getCurRoundMO() and slot1:getEnemyActPoint() or 0
	slot0._enemyNextActPoint = slot0._enemyCurrActPoint

	if ViewMgr.instance:isOpen(ViewName.FightSpecialTipView) then
		slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	else
		slot0:_playEffect(slot0._myActPoint)
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot1 == ViewName.FightSpecialTipView then
		slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
		slot0:_playEffect(slot0._myActPoint)
	end
end

function slot0._onRoundSequenceFinish(slot0)
	if slot0._enemyActBreakFlow.status == WorkStatus.Running then
		slot0._enemyActBreakFlow:stop()
		slot0._enemyActBreakFlow:unregisterDoneListener(slot0._onEnemyActBreakDone, slot0)
	end

	slot0:_updateEnemyCardItems()

	slot2 = FightCardModel.instance:getCardMO().actPoint
	slot3 = FightModel.instance:getCurRoundMO() and slot1:getEnemyActPoint() or 0
	slot0._enemyCurrActPoint = slot3
	slot0._enemyNextActPoint = slot3

	slot0:_playEffect(slot2)

	slot0._mySideDead = nil
	slot0._enemySideDead = nil
	slot0._myActPoint = slot2
	slot0._enemyActPoint = slot3
end

function slot0._playEffect(slot0, slot1)
	gohelper.setActive(slot0._opItemContainer, false)

	slot2 = slot0:getUserDataTb_()
	slot2.viewGO = slot0.viewGO
	slot2.myHasDeadEntity = slot0._mySideDead
	slot2.myNowActPoint = slot1
	slot2.myBreakActPoint = slot1 < slot0._myActPoint and slot0._myActPoint - slot1 or 0

	slot0._myActBreakFlow:start(slot2)
end

function slot0._onRoundSequenceStart(slot0)
	slot0._enemyNextActPoint = FightModel.instance:getCurRoundMO() and slot1:getEnemyActPoint() or 0

	gohelper.setActive(slot0._opItemContainer, false)
end

function slot0._onPushFightWave(slot0)
	if FightModel.instance:getNextWaveMsg() then
		slot0._enemyNextActPoint = 0
	end
end

function slot0._onSummon(slot0, slot1)
	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightBack) then
		return
	end

	if not slot1 or not slot1:isEnemySide() then
		return
	end

	slot0:_updateEnemyCardItems()
end

function slot0._onEntityDead(slot0, slot1)
	slot0._minusCount = slot0._minusCount or 0

	if FightDataHelper.entityMgr:getById(slot1).side == FightEnum.EntitySide.MySide then
		slot0._mySideDead = true
	elseif slot2.side == FightEnum.EntitySide.EnemySide then
		slot0._enemySideDead = true

		if FightHelper.isAllEntityDead(FightEnum.EntitySide.EnemySide) then
			slot0._minusCount = slot0._enemyCurrActPoint
		else
			slot0._minusCount = slot0._minusCount + slot0:_calcMinusCount(slot1)
		end
	end

	if FightSkillMgr.instance:isPlayingAnyTimeline() then
		slot0:addEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._onSkillFinishDoActPoint, slot0)
	else
		slot0:_onDeadPlayActPointEffect()
	end
end

function slot0._onSkillFinishDoActPoint(slot0)
	slot0:removeEventCb(FightController.instance, FightEvent.OnSkillPlayFinish, slot0._onSkillFinishDoActPoint, slot0)
	slot0:_onDeadPlayActPointEffect()
end

function slot0._onDeadPlayActPointEffect(slot0)
	if not OpenModel.instance:isFuncBtnShow(OpenEnum.UnlockFunc.FightBack) then
		return
	end

	if slot0._minusCount and slot0._minusCount > 0 then
		slot2 = nil

		if slot0._enemyActBreakFlow.status == WorkStatus.Running then
			slot2 = slot0._enemyActBreakFlow.context

			slot0._enemyActBreakFlow:stop()

			slot2.enemyHasDeadEntity = slot0._enemySideDead
			slot2.enemyNowActPoint = slot2.enemyNowActPoint - slot0._minusCount
			slot2.enemyBreakActPoint = slot2.enemyBreakActPoint + slot0._minusCount
		else
			slot2 = {
				enemyHasDeadEntity = slot0._enemySideDead,
				enemyNowActPoint = slot0._enemyCurrActPoint - slot0._minusCount,
				enemyBreakActPoint = slot0._minusCount
			}
		end

		slot2.viewGO = slot0.viewGO

		slot0._enemyActBreakFlow:registerDoneListener(slot0._onEnemyActBreakDone, slot0)
		slot0._enemyActBreakFlow:start(slot2)
		gohelper.setActive(slot0._opItemContainer, false)

		slot0._enemyCurrActPoint = slot0._enemyCurrActPoint - slot0._minusCount

		if slot0._enemySideDead then
			AudioMgr.instance:trigger(AudioEnum.UI.play_buff_disappear_grid)
		end
	end

	slot0._minusCount = nil
end

function slot0._calcMinusCount(slot0, slot1)
	if not FightDataHelper.entityMgr:getById(slot1) or slot2.side ~= FightEnum.EntitySide.EnemySide then
		return 0
	end

	slot3 = 1

	for slot9 = 1, FightHelper.buildSkills(slot2.modelId) and #slot4 or 0 do
		if lua_skill.configDict[slot4[slot9]] then
			for slot15 = 1, FightEnum.MaxBehavior do
				if not string.nilorempty(slot11["behavior" .. slot15]) and FightStrUtil.instance:getSplitToNumberCache(slot16, "#")[1] == 50006 then
					slot3 = slot3 + (slot17[2] or 0)
				end
			end
		end
	end

	if slot0._enemyNextActPoint <= slot0._enemyCurrActPoint - slot3 then
		return slot3
	else
		return slot0._enemyCurrActPoint - slot0._enemyNextActPoint
	end
end

function slot0._onEnemyActBreakDone(slot0)
	gohelper.setActive(slot0._opItemContainer, false)
end

function slot0._updateEnemyCardItems(slot0)
	if not FightModel.instance:getCurRoundMO() then
		return
	end

	slot3 = slot1:getAIUseCardMOList() and #slot2 or 0

	for slot7 = 1, slot3 do
		slot8 = slot2[slot7]

		if not slot0._opItemList[slot7] then
			table.insert(slot0._opItemList, MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.findChild(gohelper.cloneInPlace(slot0._opItemGO, "item" .. slot7), "op"), FightOpItem))
		end

		slot10 = slot9.go.transform.parent.gameObject
		slot11 = {
			longPress = SLFramework.UGUI.UILongPressListener.Get(slot10),
			clickUp = SLFramework.UGUI.UIClickListener.Get(slot10)
		}

		slot11.longPress:AddLongPressListener(slot0._showEnemyCardTip, slot0)
		slot11.clickUp:AddClickUpListener(slot0._onEnemyCardClickUp, slot0)

		slot0._longPressTab[slot7] = slot11

		gohelper.setActive(slot10, true)
		slot9:updateCardInfoMO(slot8)
		gohelper.setActive(slot9.go, false)
	end

	for slot7 = slot3 + 1, #slot0._opItemList do
		gohelper.setActive(slot0._opItemList[slot7].go.transform.parent.gameObject, false)
	end
end

function slot0._showEnemyCardTip(slot0)
	slot3 = FightModel.instance:getCurRoundMO():getAIUseCardMOList() and #slot2 or 0

	recthelper.setAnchor(slot0._enemyCardTip.transform, recthelper.getAnchorX(slot0._opItemList[slot3].go.transform.parent) + 31, recthelper.getAnchorY(slot0._opItemList[slot3].go.transform.parent) + 7.5)

	slot0._txtActionCount.text = slot3

	gohelper.setActive(slot0._enemyCardTip, true)
end

function slot0._onEnemyCardClickUp(slot0)
	gohelper.setActive(slot0._enemyCardTip, false)
end

return slot0
