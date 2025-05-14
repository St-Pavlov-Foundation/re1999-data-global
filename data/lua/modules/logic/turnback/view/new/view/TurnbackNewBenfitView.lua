module("modules.logic.turnback.view.new.view.TurnbackNewBenfitView", package.seeall)

local var_0_0 = class("TurnbackNewBenfitView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnturnbackmonthcard = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/content/turnbackmonthcard/#btn_turnbackmonthcard")
	arg_1_0._txtdoublereward = gohelper.findChildText(arg_1_0.viewGO, "bg/content/doublereward/frame/txt_doublereward2/#txt_doublereward")
	arg_1_0._gounlock = gohelper.findChild(arg_1_0.viewGO, "bg/content/turnbackmonthcard/go_unlocked")
	arg_1_0._txtremaintime = gohelper.findChildText(arg_1_0.viewGO, "bg/content/doublereward/frame/go_time/#txt_remainTime")
	arg_1_0._btndoublereward = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/content/doublereward/#btn_doublereward")
	arg_1_0._godoublerewardfinish = gohelper.findChild(arg_1_0.viewGO, "bg/content/doublereward/go_finish")
	arg_1_0._canvasgroupmonthcard = gohelper.findChild(arg_1_0.viewGO, "bg/content/turnbackmonthcard/frame"):GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._btngreet = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "bg/content/greet/#btn_greet")
	arg_1_0._gogreetbuyed = gohelper.findChild(arg_1_0.viewGO, "bg/content/greet/go_unlocked")
	arg_1_0._txtsearchremaintime = gohelper.findChildText(arg_1_0.viewGO, "bg/content/search/go_time/#txt_remainTime")
	arg_1_0._goAllFinish = gohelper.findChild(arg_1_0.viewGO, "bg/content/search/#go_allFinished")
	arg_1_0._canvasgroupgreet = gohelper.findChild(arg_1_0.viewGO, "bg/content/greet/frame"):GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_1_0._godoublerewarddec = gohelper.findChild(arg_1_0.viewGO, "bg/content/doublereward/frame/dec")
	arg_1_0._searchItemList = {}

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnturnbackmonthcard:AddClickListener(arg_2_0._btnturnbackmonthcardOnClick, arg_2_0)
	arg_2_0._btndoublereward:AddClickListener(arg_2_0._btndoublerewardOnClick, arg_2_0)
	arg_2_0._btngreet:AddClickListener(arg_2_0._btngreetOnClick, arg_2_0)
	arg_2_0:addEventCb(PayController.instance, PayEvent.PayFinished, arg_2_0._onChargeBuySuccess, arg_2_0)
	arg_2_0:addEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_2_0._onFinishTask, arg_2_0)
	arg_2_0:addEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, arg_2_0.refreshUI, arg_2_0)
	arg_2_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_2_0._onCloseViewFinish, arg_2_0)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, arg_2_0.refreshUI, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnturnbackmonthcard:RemoveClickListener()
	arg_3_0._btndoublereward:RemoveClickListener()
	arg_3_0._btngreet:RemoveClickListener()
	arg_3_0:removeEventCb(PayController.instance, PayEvent.PayFinished, arg_3_0._onChargeBuySuccess, arg_3_0)
	arg_3_0:removeEventCb(TaskController.instance, TaskEvent.OnFinishTask, arg_3_0._onFinishTask, arg_3_0)
	arg_3_0:removeEventCb(TurnbackController.instance, TurnbackEvent.RefreshView, arg_3_0.refreshUI, arg_3_0)
	arg_3_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_3_0._onCloseViewFinish, arg_3_0)
	TimeDispatcher.instance:unregisterCallback(TimeDispatcher.OnDailyRefresh, arg_3_0.refreshUI, arg_3_0)

	for iter_3_0, iter_3_1 in ipairs(arg_3_0._searchItemList) do
		iter_3_1.btnclick:RemoveClickListener()
	end
end

function var_0_0._btndoublerewardOnClick(arg_4_0)
	if arg_4_0.jumptab[2] ~= 0 then
		GameFacade.jump(arg_4_0.jumptab[2])
	end
end

function var_0_0._btnturnbackmonthcardOnClick(arg_5_0)
	if TurnbackModel.instance:getMonthCardShowState() == false then
		return
	end

	logNormal("onClickMonthCard")

	local var_5_0 = TurnbackModel.instance:getCurTurnbackMo().config
	local var_5_1 = StoreModel.instance:getGoodsMO(var_5_0.monthCardAddedId)

	StoreController.instance:openPackageStoreGoodsView(var_5_1)
end

function var_0_0._btngreetOnClick(arg_6_0)
	if not TurnbackModel.instance:getBuyDoubleBonus() then
		ViewMgr.instance:openView(ViewName.TurnbackDoubleRewardChargeView)
	else
		TurnbackModel.instance:setTargetCategoryId(TurnbackEnum.ActivityId.NewTaskView)
		TurnbackController.instance:dispatchEvent(TurnbackEvent.RefreshBeginner)
	end
end

function var_0_0._btnturnbackpackageOnClick(arg_7_0)
	if arg_7_0.jumptab[1] ~= 0 then
		GameFacade.jump(arg_7_0.jumptab[1])
	end
end

function var_0_0._editableInitView(arg_8_0)
	for iter_8_0 = 1, 3 do
		local var_8_0 = arg_8_0:getUserDataTb_()

		var_8_0.index = iter_8_0
		var_8_0.go = gohelper.findChild(arg_8_0.viewGO, "bg/content/search/node" .. iter_8_0)
		var_8_0.golock = gohelper.findChild(var_8_0.go, "lock")
		var_8_0.gotxtlock = gohelper.findChild(var_8_0.go, "lock/#txt_locked")
		var_8_0.gounlock = gohelper.findChild(var_8_0.go, "unlock")
		var_8_0.golockreward = gohelper.findChild(var_8_0.go, "lock/bg/reward")
		var_8_0.gounlockreward = gohelper.findChild(var_8_0.go, "unlock/bg/reward")
		var_8_0.gofinishing = gohelper.findChild(var_8_0.go, "unlock/#go_finishing")
		var_8_0.txtfinishing = gohelper.findChildText(var_8_0.go, "unlock/#go_finishing/#txt_time")
		var_8_0.gocanget = gohelper.findChild(var_8_0.go, "unlock/#go_canget")
		var_8_0.btnclick = gohelper.findChildButton(var_8_0.go, "unlock/#go_canget/btn_click")
		var_8_0.gohasget = gohelper.findChild(var_8_0.go, "unlock/#go_hasget")
		var_8_0.txtunlock = gohelper.findChildText(var_8_0.go, "unlock/#go_finishing/#txt_time")
		var_8_0.animtor = var_8_0.go:GetComponent(typeof(UnityEngine.Animator))

		table.insert(arg_8_0._searchItemList, var_8_0)
	end

	arg_8_0:_initSearchItem()
end

function var_0_0._initSearchItem(arg_9_0)
	arg_9_0.coList = TurnbackConfig.instance:getSearchTaskCoList()

	for iter_9_0, iter_9_1 in ipairs(arg_9_0.coList) do
		local var_9_0 = arg_9_0._searchItemList[iter_9_0]

		var_9_0.config = iter_9_1

		local var_9_1 = string.splitToNumber(iter_9_1.bonus, "#")
		local var_9_2 = var_9_1[1]
		local var_9_3 = var_9_1[2]
		local var_9_4 = var_9_1[3]

		var_9_0.itemlockIcon = IconMgr.instance:getCommonPropItemIcon(var_9_0.golockreward)
		var_9_0.itemunlockIcon = IconMgr.instance:getCommonPropItemIcon(var_9_0.gounlockreward)

		var_9_0.itemlockIcon:setMOValue(var_9_2, var_9_3, var_9_4, nil, true)
		var_9_0.itemunlockIcon:setMOValue(var_9_2, var_9_3, var_9_4, nil, true)
		var_9_0.itemunlockIcon:setCountFontSize(48)
		var_9_0.itemlockIcon:setCountFontSize(48)
		var_9_0.btnclick:AddClickListener(arg_9_0._onClickSearchReward, arg_9_0, var_9_0)

		local var_9_5 = TurnbackTaskModel.instance:getSearchTaskMoById(var_9_0.config.id)
	end
end

function var_0_0.onUpdateParam(arg_10_0)
	return
end

function var_0_0._onClickSearchReward(arg_11_0, arg_11_1)
	TaskRpc.instance:sendFinishTaskRequest(arg_11_1.config.id)
end

function var_0_0._onFinishTask(arg_12_0)
	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
end

function var_0_0._onChargeBuySuccess(arg_13_0)
	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
end

function var_0_0.onGetTurnBackInfo(arg_14_0)
	arg_14_0:_refreshMonthCard()
	arg_14_0:_refreshGreet()
end

function var_0_0.refreshUI(arg_15_0)
	local var_15_0, var_15_1 = TurnbackModel.instance:getAdditionCountInfo()
	local var_15_2 = "#AC481A"

	arg_15_0._txtdoublereward.text = string.format("<color=%s>%s</color>/%s", var_15_2, var_15_0, var_15_1)

	arg_15_0:_refreshRemainTime()
	arg_15_0:_refreshMonthCard()
	arg_15_0:_refreshSearchItem()
	arg_15_0:_refreshGreet()

	local var_15_3 = TurnbackTaskModel.instance:checkOnlineTaskAllFinish()

	gohelper.setActive(arg_15_0._goAllFinish, var_15_3)
end

function var_0_0._refreshRemainTime(arg_16_0)
	arg_16_0._txtremaintime.text = TurnbackController.instance:refreshRemainTime(arg_16_0.endTime)
	arg_16_0._txtsearchremaintime.text = TurnbackController.instance:refreshRemainTime(arg_16_0.searchEndTime)

	local var_16_0, var_16_1, var_16_2 = TurnbackModel.instance:getRemainTime(arg_16_0.endTime)
	local var_16_3 = false

	if var_16_0 < 0 or not TurnbackModel.instance:isInOpenTime() then
		var_16_3 = true
	end

	gohelper.setActive(arg_16_0._btndoublereward.gameObject, not var_16_3)
	gohelper.setActive(arg_16_0._godoublerewardfinish, var_16_3)
	gohelper.setActive(arg_16_0._godoublerewarddec, not var_16_3)
end

function var_0_0._refreshMonthCard(arg_17_0)
	local var_17_0 = TurnbackModel.instance:getMonthCardShowState()

	gohelper.setActive(arg_17_0._btnturnbackmonthcard.gameObject, var_17_0)
	gohelper.setActive(arg_17_0._gounlock, not var_17_0)

	if var_17_0 then
		arg_17_0._canvasgroupmonthcard.alpha = 1
	else
		arg_17_0._canvasgroupmonthcard.alpha = 0.5
	end
end

function var_0_0._refreshGreet(arg_18_0)
	local var_18_0 = TurnbackModel.instance:getBuyDoubleBonus()

	gohelper.setActive(arg_18_0._btngreet.gameObject, not var_18_0)
	gohelper.setActive(arg_18_0._gogreetbuyed, var_18_0)

	if var_18_0 then
		arg_18_0._canvasgroupgreet.alpha = 0.5
	else
		arg_18_0._canvasgroupgreet.alpha = 1
	end
end

function var_0_0._getEndTime(arg_19_0)
	local var_19_0 = TurnbackModel.instance:getCurTurnbackId()
	local var_19_1 = TurnbackConfig.instance:getAdditionDurationDays(var_19_0)

	return TurnbackModel.instance:getCurTurnbackMo().startTime + var_19_1 * TimeUtil.OneDaySecond
end

function var_0_0._getSeacrhEndTime(arg_20_0)
	local var_20_0 = TurnbackModel.instance:getCurTurnbackId()
	local var_20_1 = TurnbackConfig.instance:getOnlineDurationDays(var_20_0)

	return TurnbackModel.instance:getCurTurnbackMo().startTime + var_20_1 * TimeUtil.OneDaySecond
end

function var_0_0.onOpen(arg_21_0)
	local var_21_0 = arg_21_0.viewParam.parent

	gohelper.addChild(var_21_0, arg_21_0.viewGO)

	arg_21_0.config = TurnbackConfig.instance:getTurnbackSubModuleCo(arg_21_0.viewParam.actId)
	arg_21_0.jumptab = string.splitToNumber(arg_21_0.config.jumpId, "#")
	arg_21_0.endTime = arg_21_0:_getEndTime()
	arg_21_0.searchEndTime = arg_21_0:_getSeacrhEndTime()

	TurnbackRpc.instance:sendGetTurnbackInfoRequest()
	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_Interface_entry_02)
end

function var_0_0._refreshSearchItem(arg_22_0)
	local var_22_0 = false

	for iter_22_0, iter_22_1 in ipairs(arg_22_0._searchItemList) do
		gohelper.setActive(iter_22_1.gotxtlock, true)
		gohelper.setActive(iter_22_1.btnclick.gameObject, true)

		local var_22_1 = TurnbackTaskModel.instance:getSearchTaskMoById(iter_22_1.config.id)

		if var_22_1 then
			gohelper.setActive(iter_22_1.golock, var_22_0)
			gohelper.setActive(iter_22_1.gounlock, not var_22_0)

			if not var_22_0 then
				if var_22_1.finishCount > 0 then
					gohelper.setActive(iter_22_1.gofinishing, false)
					gohelper.setActive(iter_22_1.gocanget, false)
					gohelper.setActive(iter_22_1.gohasget, true)

					local var_22_2 = TurnbackEnum.SearchState.NotFinish

					if not iter_22_1.state or iter_22_1.state ~= var_22_2 then
						iter_22_1.state = var_22_2
					end
				elseif arg_22_0:checkFinishedTask(var_22_1) then
					gohelper.setActive(iter_22_1.gofinishing, false)
					gohelper.setActive(iter_22_1.gocanget, true)
					gohelper.setActive(iter_22_1.gohasget, false)

					local var_22_3 = TurnbackEnum.SearchState.CanGet

					if not iter_22_1.state or iter_22_1.state ~= var_22_3 then
						iter_22_1.state = var_22_3

						iter_22_1.animtor:Update(0)
						iter_22_1.animtor:Play("finishing")
					end
				else
					gohelper.setActive(iter_22_1.gofinishing, true)
					gohelper.setActive(iter_22_1.gocanget, false)
					gohelper.setActive(iter_22_1.gohasget, false)

					local var_22_4 = TurnbackEnum.SearchState.HasGet

					if not iter_22_1.state or iter_22_1.state ~= var_22_4 then
						iter_22_1.state = var_22_4

						gohelper.setActive(iter_22_1.golock, false)
						gohelper.setActive(iter_22_1.gounlock, true)

						if TurnbackController.instance:isPlayFirstUnlockToday(var_22_1.id) then
							gohelper.setActive(iter_22_1.golock, true)
							iter_22_1.animtor:Update(0)
							iter_22_1.animtor:Play("unlock")

							function arg_22_0.afterunlockAnim()
								TaskDispatcher.cancelTask(arg_22_0.afterunlockAnim, arg_22_0)
								gohelper.setActive(iter_22_1.golock, false)
								gohelper.setActive(iter_22_1.gounlock, true)
								TurnbackController.instance:savePlayUnlockAnim(var_22_1.id)
							end

							TaskDispatcher.runDelay(arg_22_0.afterunlockAnim, arg_22_0, 0.6)
						end
					end

					arg_22_0.remainsearchtime = var_22_1.config.maxProgress - var_22_1.progress
					iter_22_1.txtfinishing.text = TimeUtil.getFormatTime2(arg_22_0.remainsearchtime)
					arg_22_0._currentitem = iter_22_1

					TaskDispatcher.runRepeat(arg_22_0._updateSearchRemainTime, arg_22_0, 1)

					var_22_0 = true
				end
			else
				gohelper.setActive(iter_22_1.golock, var_22_0)
				gohelper.setActive(iter_22_1.gounlock, not var_22_0)
				iter_22_1.animtor:Update(0)
				iter_22_1.animtor:Play("idle")
			end
		else
			local var_22_5 = true

			gohelper.setActive(iter_22_1.golock, var_22_5)
			gohelper.setActive(iter_22_1.gotxtlock, not var_22_5)
			gohelper.setActive(iter_22_1.btnclick.gameObject, not var_22_5)
			gohelper.setActive(iter_22_1.gounlock, not var_22_5)
		end
	end
end

function var_0_0._updateSearchRemainTime(arg_24_0)
	if not arg_24_0._currentitem or not arg_24_0.remainsearchtime then
		return
	end

	arg_24_0.remainsearchtime = arg_24_0.remainsearchtime - 1

	if arg_24_0.remainsearchtime > 0 then
		arg_24_0._currentitem.txtfinishing.text = TimeUtil.getFormatTime2(arg_24_0.remainsearchtime)
	else
		TurnbackRpc.instance:sendGetTurnbackInfoRequest()
		TaskDispatcher.cancelTask(arg_24_0._updateSearchRemainTime, arg_24_0)
	end
end

function var_0_0.checkFinishedTask(arg_25_0, arg_25_1)
	if arg_25_1.progress >= arg_25_1.config.maxProgress and arg_25_1.finishCount == 0 then
		return true
	end

	return false
end

function var_0_0.isTaskReceive(arg_26_0, arg_26_1)
	return arg_26_1.finishCount > 0 and arg_26_1.progress >= arg_26_1.config.maxProgress
end

function var_0_0._onCloseViewFinish(arg_27_0, arg_27_1)
	if arg_27_1 == ViewName.CommonPropView then
		local var_27_0 = TurnbackTaskModel.instance:checkOnlineTaskAllFinish()

		gohelper.setActive(arg_27_0._goAllFinish, var_27_0)
	end
end

function var_0_0.onClose(arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0.afterunlockAnim, arg_28_0)
	TaskDispatcher.cancelTask(arg_28_0._updateSearchRemainTime, arg_28_0)
end

function var_0_0.onDestroyView(arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0.afterunlockAnim, arg_29_0)
	TaskDispatcher.cancelTask(arg_29_0._updateSearchRemainTime, arg_29_0)
end

return var_0_0
