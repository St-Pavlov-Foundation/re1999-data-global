module("modules.logic.turnback.view.new.view.TurnbackNewBenfitView", package.seeall)

slot0 = class("TurnbackNewBenfitView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnturnbackmonthcard = gohelper.findChildButtonWithAudio(slot0.viewGO, "bg/content/turnbackmonthcard/#btn_turnbackmonthcard")
	slot0._txtdoublereward = gohelper.findChildText(slot0.viewGO, "bg/content/doublereward/frame/txt_doublereward2/#txt_doublereward")
	slot0._gounlock = gohelper.findChild(slot0.viewGO, "bg/content/turnbackmonthcard/go_unlocked")
	slot0._txtremaintime = gohelper.findChildText(slot0.viewGO, "bg/content/doublereward/frame/go_time/#txt_remainTime")
	slot0._btndoublereward = gohelper.findChildButtonWithAudio(slot0.viewGO, "bg/content/doublereward/#btn_doublereward")
	slot0._godoublerewardfinish = gohelper.findChild(slot0.viewGO, "bg/content/doublereward/go_finish")
	slot0._canvasgroupmonthcard = gohelper.findChild(slot0.viewGO, "bg/content/turnbackmonthcard/frame"):GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._btngreet = gohelper.findChildButtonWithAudio(slot0.viewGO, "bg/content/greet/#btn_greet")
	slot0._gogreetbuyed = gohelper.findChild(slot0.viewGO, "bg/content/greet/go_unlocked")
	slot0._txtsearchremaintime = gohelper.findChildText(slot0.viewGO, "bg/content/search/go_time/#txt_remainTime")
	slot0._goAllFinish = gohelper.findChild(slot0.viewGO, "bg/content/search/#go_allFinished")
	slot0._canvasgroupgreet = gohelper.findChild(slot0.viewGO, "bg/content/greet/frame"):GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._godoublerewarddec = gohelper.findChild(slot0.viewGO, "bg/content/doublereward/frame/dec")
	slot0._searchItemList = {}

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnturnbackmonthcard:AddClickListener(slot0._btnturnbackmonthcardOnClick, slot0)
	slot0._btndoublereward:AddClickListener(slot0._btndoublerewardOnClick, slot0)
	slot0._btngreet:AddClickListener(slot0._btngreetOnClick, slot0)
	slot0:addEventCb(PayController.instance, PayEvent.PayFinished, slot0._onChargeBuySuccess, slot0)
	slot0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	slot0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, slot0.refreshUI, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, slot0.refreshUI, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnturnbackmonthcard:RemoveClickListener()
	slot0._btndoublereward:RemoveClickListener()
	slot0._btngreet:RemoveClickListener()
	slot0:removeEventCb(PayController.instance, PayEvent.PayFinished, slot0._onChargeBuySuccess, slot0)
	slot0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, slot0._onFinishTask, slot0)
	slot0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, slot0.refreshUI, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseViewFinish, slot0)

	slot4 = slot0.refreshUI
	slot5 = slot0

	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, slot4, slot5)

	for slot4, slot5 in ipairs(slot0._searchItemList) do
		slot5.btnclick:RemoveClickListener()
	end
end

function slot0._btndoublerewardOnClick(slot0)
	if slot0.jumptab[2] ~= 0 then
		GameFacade.jump(slot0.jumptab[2])
	end
end

function slot0._btnturnbackmonthcardOnClick(slot0)
	if TurnbackModel.instance:getMonthCardShowState() == false then
		return
	end

	logNormal("onClickMonthCard")
	StoreController.instance:openPackageStoreGoodsView(StoreModel.instance:getGoodsMO(TurnbackModel.instance:getCurTurnbackMo().config.monthCardAddedId))
end

function slot0._btngreetOnClick(slot0)
	if not TurnbackModel.instance:getBuyDoubleBonus() then
		ViewMgr.instance:openView(ViewName.TurnbackDoubleRewardChargeView)
	else
		TurnbackModel.instance:setTargetCategoryId(TurnbackEnum.ActivityId.NewTaskView)
		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshBeginner)
	end
end

function slot0._btnturnbackpackageOnClick(slot0)
	if slot0.jumptab[1] ~= 0 then
		GameFacade.jump(slot0.jumptab[1])
	end
end

function slot0._editableInitView(slot0)
	for slot4 = 1, 3 do
		slot5 = slot0:getUserDataTb_()
		slot5.index = slot4
		slot5.go = gohelper.findChild(slot0.viewGO, "bg/content/search/node" .. slot4)
		slot5.golock = gohelper.findChild(slot5.go, "lock")
		slot5.gotxtlock = gohelper.findChild(slot5.go, "lock/#txt_locked")
		slot5.gounlock = gohelper.findChild(slot5.go, "unlock")
		slot5.golockreward = gohelper.findChild(slot5.go, "lock/bg/reward")
		slot5.gounlockreward = gohelper.findChild(slot5.go, "unlock/bg/reward")
		slot5.gofinishing = gohelper.findChild(slot5.go, "unlock/#go_finishing")
		slot5.txtfinishing = gohelper.findChildText(slot5.go, "unlock/#go_finishing/#txt_time")
		slot5.gocanget = gohelper.findChild(slot5.go, "unlock/#go_canget")
		slot5.btnclick = gohelper.findChildButton(slot5.go, "unlock/#go_canget/btn_click")
		slot5.gohasget = gohelper.findChild(slot5.go, "unlock/#go_hasget")
		slot5.txtunlock = gohelper.findChildText(slot5.go, "unlock/#go_finishing/#txt_time")
		slot5.animtor = slot5.go:GetComponent(typeof(UnityEngine.Animator))

		table.insert(slot0._searchItemList, slot5)
	end

	slot0:_initSearchItem()
end

function slot0._initSearchItem(slot0)
	slot0.coList = TurnbackConfig.instance:getSearchTaskCoList()

	for slot4, slot5 in ipairs(slot0.coList) do
		slot6 = slot0._searchItemList[slot4]
		slot6.config = slot5
		slot7 = string.splitToNumber(slot5.bonus, "#")
		slot8 = slot7[1]
		slot9 = slot7[2]
		slot10 = slot7[3]
		slot6.itemlockIcon = IconMgr.instance:getCommonPropItemIcon(slot6.golockreward)
		slot6.itemunlockIcon = IconMgr.instance:getCommonPropItemIcon(slot6.gounlockreward)

		slot6.itemlockIcon:setMOValue(slot8, slot9, slot10, nil, true)
		slot6.itemunlockIcon:setMOValue(slot8, slot9, slot10, nil, true)
		slot6.itemunlockIcon:setCountFontSize(48)
		slot6.itemlockIcon:setCountFontSize(48)
		slot6.btnclick:AddClickListener(slot0._onClickSearchReward, slot0, slot6)

		slot11 = TurnbackTaskModel.instance:getSearchTaskMoById(slot6.config.id)
	end
end

function slot0.onUpdateParam(slot0)
end

function slot0._onClickSearchReward(slot0, slot1)
	TaskRpc.instance:sendFinishTaskRequest(slot1.config.id)
end

function slot0._onFinishTask(slot0)
	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
end

function slot0._onChargeBuySuccess(slot0)
	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
end

function slot0.onGetTurnBackInfo(slot0)
	slot0:_refreshMonthCard()
	slot0:_refreshGreet()
end

function slot0.refreshUI(slot0)
	slot1, slot2 = TurnbackModel.instance:getAdditionCountInfo()
	slot0._txtdoublereward.text = string.format("<color=%s>%s</color>/%s", "#AC481A", slot1, slot2)

	slot0:_refreshRemainTime()
	slot0:_refreshMonthCard()
	slot0:_refreshSearchItem()
	slot0:_refreshGreet()
	gohelper.setActive(slot0._goAllFinish, TurnbackTaskModel.instance:checkOnlineTaskAllFinish())
end

function slot0._refreshRemainTime(slot0)
	slot0._txtremaintime.text = TurnbackController.instance:refreshRemainTime(slot0.endTime)
	slot0._txtsearchremaintime.text = TurnbackController.instance:refreshRemainTime(slot0.searchEndTime)
	slot1, slot2, slot3 = TurnbackModel.instance:getRemainTime(slot0.endTime)
	slot4 = false

	if slot1 < 0 or not TurnbackModel.instance:isInOpenTime() then
		slot4 = true
	end

	gohelper.setActive(slot0._btndoublereward.gameObject, not slot4)
	gohelper.setActive(slot0._godoublerewardfinish, slot4)
	gohelper.setActive(slot0._godoublerewarddec, not slot4)
end

function slot0._refreshMonthCard(slot0)
	slot1 = TurnbackModel.instance:getMonthCardShowState()

	gohelper.setActive(slot0._btnturnbackmonthcard.gameObject, slot1)
	gohelper.setActive(slot0._gounlock, not slot1)

	if slot1 then
		slot0._canvasgroupmonthcard.alpha = 1
	else
		slot0._canvasgroupmonthcard.alpha = 0.5
	end
end

function slot0._refreshGreet(slot0)
	slot1 = TurnbackModel.instance:getBuyDoubleBonus()

	gohelper.setActive(slot0._btngreet.gameObject, not slot1)
	gohelper.setActive(slot0._gogreetbuyed, slot1)

	if slot1 then
		slot0._canvasgroupgreet.alpha = 0.5
	else
		slot0._canvasgroupgreet.alpha = 1
	end
end

function slot0._getEndTime(slot0)
	return TurnbackModel.instance:getCurTurnbackMo().startTime + TurnbackConfig.instance:getAdditionDurationDays(TurnbackModel.instance:getCurTurnbackId()) * TimeUtil.OneDaySecond
end

function slot0._getSeacrhEndTime(slot0)
	return TurnbackModel.instance:getCurTurnbackMo().startTime + TurnbackConfig.instance:getOnlineDurationDays(TurnbackModel.instance:getCurTurnbackId()) * TimeUtil.OneDaySecond
end

function slot0.onOpen(slot0)
	gohelper.addChild(slot0.viewParam.parent, slot0.viewGO)

	slot0.config = TurnbackConfig.instance:getTurnbackSubModuleCo(slot0.viewParam.actId)
	slot0.jumptab = string.splitToNumber(slot0.config.jumpId, "#")
	slot0.endTime = slot0:_getEndTime()
	slot0.searchEndTime = slot0:_getSeacrhEndTime()

	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_Interface_entry_02)
end

function slot0._refreshSearchItem(slot0)
	slot1 = false

	for slot5, slot6 in ipairs(slot0._searchItemList) do
		gohelper.setActive(slot6.gotxtlock, true)
		gohelper.setActive(slot6.btnclick.gameObject, true)

		if TurnbackTaskModel.instance:getSearchTaskMoById(slot6.config.id) then
			gohelper.setActive(slot6.golock, slot1)
			gohelper.setActive(slot6.gounlock, not slot1)

			if not slot1 then
				if slot7.finishCount > 0 then
					gohelper.setActive(slot6.gofinishing, false)
					gohelper.setActive(slot6.gocanget, false)
					gohelper.setActive(slot6.gohasget, true)

					slot8 = TurnbackEnum.SearchState.NotFinish

					if not slot6.state or slot6.state ~= slot8 then
						slot6.state = slot8
					end
				elseif slot0:checkFinishedTask(slot7) then
					gohelper.setActive(slot6.gofinishing, false)
					gohelper.setActive(slot6.gocanget, true)
					gohelper.setActive(slot6.gohasget, false)

					slot8 = TurnbackEnum.SearchState.CanGet

					if not slot6.state or slot6.state ~= slot8 then
						slot6.state = slot8

						slot6.animtor:Update(0)
						slot6.animtor:Play("finishing")
					end
				else
					gohelper.setActive(slot6.gofinishing, true)
					gohelper.setActive(slot6.gocanget, false)
					gohelper.setActive(slot6.gohasget, false)

					slot8 = TurnbackEnum.SearchState.HasGet

					if not slot6.state or slot6.state ~= slot8 then
						slot6.state = slot8

						gohelper.setActive(slot6.golock, false)
						gohelper.setActive(slot6.gounlock, true)

						if TurnbackController.instance:isPlayFirstUnlockToday(slot7.id) then
							gohelper.setActive(slot6.golock, true)
							slot6.animtor:Update(0)
							slot6.animtor:Play("unlock")

							function slot0.afterunlockAnim()
								TaskDispatcher.cancelTask(uv0.afterunlockAnim, uv0)
								gohelper.setActive(uv1.golock, false)
								gohelper.setActive(uv1.gounlock, true)
								TurnbackController.instance:savePlayUnlockAnim(uv2.id)
							end

							TaskDispatcher.runDelay(slot0.afterunlockAnim, slot0, 0.6)
						end
					end

					slot0.remainsearchtime = slot7.config.maxProgress - slot7.progress
					slot6.txtfinishing.text = TimeUtil.getFormatTime2(slot0.remainsearchtime)
					slot0._currentitem = slot6

					TaskDispatcher.runRepeat(slot0._updateSearchRemainTime, slot0, 1)

					slot1 = true
				end
			else
				gohelper.setActive(slot6.golock, slot1)
				gohelper.setActive(slot6.gounlock, not slot1)
				slot6.animtor:Update(0)
				slot6.animtor:Play("idle")
			end
		else
			slot8 = true

			gohelper.setActive(slot6.golock, slot8)
			gohelper.setActive(slot6.gotxtlock, not slot8)
			gohelper.setActive(slot6.btnclick.gameObject, not slot8)
			gohelper.setActive(slot6.gounlock, not slot8)
		end
	end
end

function slot0._updateSearchRemainTime(slot0)
	if not slot0._currentitem or not slot0.remainsearchtime then
		return
	end

	slot0.remainsearchtime = slot0.remainsearchtime - 1

	if slot0.remainsearchtime > 0 then
		slot0._currentitem.txtfinishing.text = TimeUtil.getFormatTime2(slot0.remainsearchtime)
	else
		TurnbackRpc.instance:sendGetTurnbackInfoRequest()
		TaskDispatcher.cancelTask(slot0._updateSearchRemainTime, slot0)
	end
end

function slot0.checkFinishedTask(slot0, slot1)
	if slot1.config.maxProgress <= slot1.progress and slot1.finishCount == 0 then
		return true
	end

	return false
end

function slot0.isTaskReceive(slot0, slot1)
	return slot1.finishCount > 0 and slot1.config.maxProgress <= slot1.progress
end

function slot0._onCloseViewFinish(slot0, slot1)
	if slot1 == ViewName.CommonPropView then
		gohelper.setActive(slot0._goAllFinish, TurnbackTaskModel.instance:checkOnlineTaskAllFinish())
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.afterunlockAnim, slot0)
	TaskDispatcher.cancelTask(slot0._updateSearchRemainTime, slot0)
end

function slot0.onDestroyView(slot0)
	TaskDispatcher.cancelTask(slot0.afterunlockAnim, slot0)
	TaskDispatcher.cancelTask(slot0._updateSearchRemainTime, slot0)
end

return slot0
