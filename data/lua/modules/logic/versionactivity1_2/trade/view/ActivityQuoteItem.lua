module("modules.logic.versionactivity1_2.trade.view.ActivityQuoteItem", package.seeall)

slot0 = class("ActivityQuoteItem", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.txtremaincount = gohelper.findChildTextMesh(slot0.go, "top/txt_remaincount")
	slot0.goTabItem = gohelper.findChild(slot0.go, "tab/#go_tabitem")
	slot0.slider = gohelper.findChildSlider(slot0.go, "slider_setquotevalue")
	slot0.txtMinPrice = gohelper.findChildTextMesh(slot0.go, "slider_setquotevalue/txt_min")
	slot0.txtMaxPrice = gohelper.findChildTextMesh(slot0.go, "slider_setquotevalue/txt_max")
	slot0.txtTips = gohelper.findChildText(slot0.go, "tips")
	slot0.goDot = gohelper.findChild(slot0.go, "vx_dot")
	slot0.goBtn = gohelper.findChild(slot0.go, "goBtn")
	slot0.btnQuoted = gohelper.findChildButtonWithAudio(slot0.goBtn, "btn_quoted")
	slot0.btnConfirm = gohelper.findChildButtonWithAudio(slot0.goBtn, "btn_quote", AudioEnum.UI.Play_UI_General_OK)
	slot0.btnRequote1 = gohelper.findChildButtonWithAudio(slot0.goBtn, "btn_requote1", AudioEnum.UI.play_ui_bank_open)
	slot0.btnRequote2 = gohelper.findChildButtonWithAudio(slot0.goBtn, "btn_requote2", AudioEnum.UI.play_ui_bank_open)
	slot0.btnDeal = gohelper.findChildButtonWithAudio(slot0.goBtn, "btn_deal", AudioEnum.UI.play_ui_bank_open)

	slot0.btnConfirm:AddClickListener(slot0.onClickSubmitMyPrice, slot0)
	slot0.btnDeal:AddClickListener(slot0.onClickConfirmPrice, slot0)
	slot0.btnRequote1:AddClickListener(slot0.onClickRetryBargain, slot0)
	slot0.btnRequote2:AddClickListener(slot0.onClickRetryBargain, slot0)
	slot0.slider:AddOnValueChanged(slot0.onSliderValueChanged, slot0)

	slot0.tabItems = {}
end

function slot0.resetData(slot0)
	slot0.isWait = false

	if slot0.slider then
		slot0.slider:SetValue(0.5)
	end
end

function slot0.setData(slot0, slot1)
	slot0.data = slot1
	slot0.actId = slot1 and slot1.activityId

	if not slot1 then
		gohelper.setActive(slot0.go, false)

		return
	end

	gohelper.setActive(slot0.go, true)
	slot0:updateView()
end

function slot0.updateView(slot0)
	slot0.dealCount = #slot0.data.userDealScores
	slot0.limitCount = CommonConfig.instance:getConstNum(ConstEnum.ActivityTradeMaxTimes)
	slot0.curIndex = slot0.dealCount + (Activity117Model.instance:isInQuote(slot0.actId) and 1 or 0)
	slot0.curIndex = Mathf.Clamp(slot0.curIndex, 1, slot0.limitCount)
	slot0.hasCount = slot0.limitCount - slot0.dealCount > 0
	slot0.txtremaincount.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a2_tradequoteview_remaincount"), {
		slot0.limitCount - slot0.dealCount,
		slot0.limitCount
	})

	slot0:updateTabs()
	slot0:updateContent()
end

function slot0.onNegotiate(slot0, slot1)
	slot0.isWait = true

	slot0:setData(slot1)
end

function slot0._delaySetData(slot0)
	TaskDispatcher.cancelTask(slot0._delaySetData, slot0)

	if not slot0.isWait then
		return
	end

	slot0.isWait = false

	slot0:setData(slot0.data)
end

function slot0.updateTabs(slot0)
	slot1 = 0

	if not slot0.hasCount and not slot0.isWait and slot0.data:checkPrice(slot0.data.userDealScores[slot0.dealCount]) == Activity117Enum.PriceType.Bad then
		slot1 = 1
	end

	slot0.curTabIndex = slot0.curIndex + slot1
	slot6 = slot0.limitCount + slot1

	for slot6 = 1, math.max(slot6, #slot0.tabItems) do
		if not slot0.tabItems[slot6] then
			slot0.tabItems[slot6] = slot0:createTab(slot6)
		end

		slot0:updateTab(slot0.tabItems[slot6], slot6 <= slot2)
	end
end

function slot0.createTab(slot0, slot1)
	slot2 = slot0:getUserDataTb_()
	slot2.index = slot1
	slot2.go = gohelper.cloneInPlace(slot0.goTabItem, "tab" .. slot1)
	slot2.goCurrent = gohelper.findChild(slot2.go, "go_current")
	slot2.txtCurrent = gohelper.findChildTextMesh(slot2.go, "go_current/txt_curvalue")
	slot2.goCurrentLine = gohelper.findChild(slot2.go, "go_current/txt_curvalue/go_line")
	slot2.goCricle = gohelper.findChild(slot2.go, "go_current/circle")
	slot2.goUnfinish = gohelper.findChild(slot2.go, "go_unfinish")
	slot2.goFinish = gohelper.findChild(slot2.go, "go_finish")
	slot2.txtFinish = gohelper.findChildTextMesh(slot2.go, "go_finish/txt_quotevalue")

	gohelper.setActive(slot2.go, true)

	return slot2
end

function slot0.updateTab(slot0, slot1, slot2)
	if not slot2 then
		gohelper.setActive(slot1.go, false)

		return
	end

	gohelper.setActive(slot1.go, true)

	slot3 = slot1.index == slot0.curTabIndex
	slot4 = slot0.data.userDealScores[slot1.index]

	if slot0.limitCount < slot1.index then
		slot4 = slot0.data:getMinPrice()
	end

	if slot3 then
		gohelper.setActive(slot1.goCurrent, true)
		gohelper.setActive(slot1.goFinish, false)
		gohelper.setActive(slot1.goUnfinish, false)

		if slot4 then
			if not slot0.isWait and slot0.data:checkPrice(slot4) == Activity117Enum.PriceType.Bad then
				slot1.txtCurrent.text = string.format("<color=#797E79>%s</color>", slot4)

				gohelper.setActive(slot1.goCurrentLine, true)
			else
				slot1.txtCurrent.text = slot4

				gohelper.setActive(slot1.goCurrentLine, false)
			end
		else
			slot1.txtCurrent.text = slot0:getSliderValue()

			gohelper.setActive(slot1.goCurrentLine, false)
		end
	else
		gohelper.setActive(slot1.goCurrent, false)

		if slot4 then
			gohelper.setActive(slot1.goFinish, true)
			gohelper.setActive(slot1.goUnfinish, false)

			slot1.txtFinish.text = string.format("%s", slot4)
		else
			gohelper.setActive(slot1.goFinish, false)
			gohelper.setActive(slot1.goUnfinish, true)
		end
	end
end

function slot0.updateContent(slot0)
	TaskDispatcher.cancelTask(slot0.showTalkDesc, slot0)

	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end

	if slot0.isWait then
		slot0.txtTips.text = ""

		Activity117Controller.instance:dispatchEvent(Activity117Event.PlayTalk, slot0.actId, "", true)
		slot0:setBtnActive(false, false, true, false, false)
		gohelper.setActive(slot0.slider, false)
		TaskDispatcher.runDelay(slot0._delaySetData, slot0, 3)
		gohelper.setActive(slot0.goDot, true)

		return
	end

	gohelper.setActive(slot0.goDot, false)

	if slot0.data.userDealScores[slot0.curIndex] then
		slot3 = #slot0.data.userDealScores

		if slot0.data:checkPrice(slot1) ~= Activity117Enum.PriceType.Bad then
			slot0:setBtnActive(slot0.hasCount, false, false, false, true)
		else
			slot0:setBtnActive(false, slot0.hasCount, false, false, not slot0.hasCount)

			if slot0.curIndex == slot0.limitCount then
				slot2 = Activity117Enum.PriceType.LastFail
			end
		end

		slot0:updateTalk(slot2)
		gohelper.setActive(slot0.slider, false)

		return
	end

	gohelper.setActive(slot0.slider, true)

	slot0.txtTips.text = ""

	slot0:setBtnActive(false, false, false, true, false)

	slot0.txtMinPrice.text = slot0.data.minScore
	slot0.txtMaxPrice.text = slot0.data.maxScore

	Activity117Controller.instance:dispatchEvent(Activity117Event.PlayTalk, slot0.actId)
end

function slot0.setBtnActive(slot0, slot1, slot2, slot3, slot4, slot5)
	gohelper.setActive(slot0.btnRequote1, slot1)
	gohelper.setActive(slot0.btnRequote2, slot2)
	gohelper.setActive(slot0.btnQuoted, slot3)
	gohelper.setActive(slot0.btnConfirm, slot4)
	gohelper.setActive(slot0.btnDeal, slot5)
end

function slot0.updateTalk(slot0, slot1)
	slot0.talkContent = Activity117Config.instance:getTalkCo(slot0.actId, slot1) and slot2.content2 or ""
	slot0.txtTips.text = ""

	Activity117Controller.instance:dispatchEvent(Activity117Event.PlayTalk, slot0.actId, slot2 and slot2.content1 or "")
	TaskDispatcher.runDelay(slot0.showTalkDesc, slot0, 2)
end

function slot0.showTalkDesc(slot0)
	TaskDispatcher.cancelTask(slot0.showTalkDesc, slot0)

	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end

	slot0.txtTips.text = ""
	slot0.tweenId = ZProj.TweenHelper.DOText(slot0.txtTips, slot0.talkContent, 2)
end

function slot0.getSliderValue(slot0)
	if not slot0.data then
		return 0
	end

	return tostring(math.ceil(slot0.slider:GetValue() * (slot0.data.maxScore - slot0.data.minScore)) + slot0.data.minScore)
end

function slot0.refreshBargainSliderText(slot0)
	if slot0.tabItems[slot0.curIndex or 1] then
		slot1.txtCurrent.text = slot0:getSliderValue()
	end
end

function slot0.onSliderValueChanged(slot0, slot1)
	slot0:refreshBargainSliderText()

	slot2 = Time.realtimeSinceStartup

	if not slot0._audioTime then
		slot0._audioTime = Time.realtimeSinceStartup

		AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_Star_In)

		return
	end

	if slot2 - slot0._audioTime > 0.1 then
		slot0._audioTime = slot2

		AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_Star_In)
	end
end

function slot0.onClickRetryBargain(slot0, slot1)
	Activity117Model.instance:setInQuote(slot0.actId, true)
	Activity117Controller.instance:dispatchEvent(Activity117Event.RefreshQuoteView, slot0.actId)
end

function slot0.onClickConfirmPrice(slot0, slot1)
	Activity117Rpc.instance:sendAct117DealRequest(slot0.actId, Activity117Model.instance:getSelectOrder(slot0.actId))
end

function slot0.onClickSubmitMyPrice(slot0)
	if not slot0.data then
		return
	end

	slot2 = Activity117Model.instance:getSelectOrder(slot0.actId)
	slot3 = math.ceil(slot0.slider:GetValue() * (slot1.maxScore - slot1.minScore)) + slot1.minScore

	GameFacade.showMessageBox(MessageBoxIdDefine.TradeBargainConfirm, MsgBoxEnum.BoxType.Yes_No, function ()
		Activity117Rpc.instance:sendAct117NegotiateRequest(uv0.actId, uv1, uv2)
	end)
end

function slot0.destory(slot0)
	if slot0.tweenId then
		ZProj.TweenHelper.KillById(slot0.tweenId)

		slot0.tweenId = nil
	end

	slot0.tabItems = nil

	slot0.btnConfirm:RemoveClickListener()
	slot0.btnDeal:RemoveClickListener()
	slot0.btnRequote1:RemoveClickListener()
	slot0.btnRequote2:RemoveClickListener()
	slot0.slider:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(slot0._delaySetData, slot0)
	TaskDispatcher.cancelTask(slot0.showTalkDesc, slot0)
	slot0:__onDispose()
end

return slot0
