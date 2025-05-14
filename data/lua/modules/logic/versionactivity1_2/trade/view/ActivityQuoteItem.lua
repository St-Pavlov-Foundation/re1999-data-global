module("modules.logic.versionactivity1_2.trade.view.ActivityQuoteItem", package.seeall)

local var_0_0 = class("ActivityQuoteItem", UserDataDispose)

function var_0_0.ctor(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.txtremaincount = gohelper.findChildTextMesh(arg_1_0.go, "top/txt_remaincount")
	arg_1_0.goTabItem = gohelper.findChild(arg_1_0.go, "tab/#go_tabitem")
	arg_1_0.slider = gohelper.findChildSlider(arg_1_0.go, "slider_setquotevalue")
	arg_1_0.txtMinPrice = gohelper.findChildTextMesh(arg_1_0.go, "slider_setquotevalue/txt_min")
	arg_1_0.txtMaxPrice = gohelper.findChildTextMesh(arg_1_0.go, "slider_setquotevalue/txt_max")
	arg_1_0.txtTips = gohelper.findChildText(arg_1_0.go, "tips")
	arg_1_0.goDot = gohelper.findChild(arg_1_0.go, "vx_dot")
	arg_1_0.goBtn = gohelper.findChild(arg_1_0.go, "goBtn")
	arg_1_0.btnQuoted = gohelper.findChildButtonWithAudio(arg_1_0.goBtn, "btn_quoted")
	arg_1_0.btnConfirm = gohelper.findChildButtonWithAudio(arg_1_0.goBtn, "btn_quote", AudioEnum.UI.Play_UI_General_OK)
	arg_1_0.btnRequote1 = gohelper.findChildButtonWithAudio(arg_1_0.goBtn, "btn_requote1", AudioEnum.UI.play_ui_bank_open)
	arg_1_0.btnRequote2 = gohelper.findChildButtonWithAudio(arg_1_0.goBtn, "btn_requote2", AudioEnum.UI.play_ui_bank_open)
	arg_1_0.btnDeal = gohelper.findChildButtonWithAudio(arg_1_0.goBtn, "btn_deal", AudioEnum.UI.play_ui_bank_open)

	arg_1_0.btnConfirm:AddClickListener(arg_1_0.onClickSubmitMyPrice, arg_1_0)
	arg_1_0.btnDeal:AddClickListener(arg_1_0.onClickConfirmPrice, arg_1_0)
	arg_1_0.btnRequote1:AddClickListener(arg_1_0.onClickRetryBargain, arg_1_0)
	arg_1_0.btnRequote2:AddClickListener(arg_1_0.onClickRetryBargain, arg_1_0)
	arg_1_0.slider:AddOnValueChanged(arg_1_0.onSliderValueChanged, arg_1_0)

	arg_1_0.tabItems = {}
end

function var_0_0.resetData(arg_2_0)
	arg_2_0.isWait = false

	if arg_2_0.slider then
		arg_2_0.slider:SetValue(0.5)
	end
end

function var_0_0.setData(arg_3_0, arg_3_1)
	arg_3_0.data = arg_3_1
	arg_3_0.actId = arg_3_1 and arg_3_1.activityId

	if not arg_3_1 then
		gohelper.setActive(arg_3_0.go, false)

		return
	end

	gohelper.setActive(arg_3_0.go, true)
	arg_3_0:updateView()
end

function var_0_0.updateView(arg_4_0)
	arg_4_0.dealCount = #arg_4_0.data.userDealScores
	arg_4_0.limitCount = CommonConfig.instance:getConstNum(ConstEnum.ActivityTradeMaxTimes)
	arg_4_0.curIndex = arg_4_0.dealCount + (Activity117Model.instance:isInQuote(arg_4_0.actId) and 1 or 0)
	arg_4_0.curIndex = Mathf.Clamp(arg_4_0.curIndex, 1, arg_4_0.limitCount)
	arg_4_0.hasCount = arg_4_0.limitCount - arg_4_0.dealCount > 0

	local var_4_0 = {
		arg_4_0.limitCount - arg_4_0.dealCount,
		arg_4_0.limitCount
	}

	arg_4_0.txtremaincount.text = GameUtil.getSubPlaceholderLuaLang(luaLang("v1a2_tradequoteview_remaincount"), var_4_0)

	arg_4_0:updateTabs()
	arg_4_0:updateContent()
end

function var_0_0.onNegotiate(arg_5_0, arg_5_1)
	arg_5_0.isWait = true

	arg_5_0:setData(arg_5_1)
end

function var_0_0._delaySetData(arg_6_0)
	TaskDispatcher.cancelTask(arg_6_0._delaySetData, arg_6_0)

	if not arg_6_0.isWait then
		return
	end

	arg_6_0.isWait = false

	arg_6_0:setData(arg_6_0.data)
end

function var_0_0.updateTabs(arg_7_0)
	local var_7_0 = 0

	if not arg_7_0.hasCount and not arg_7_0.isWait then
		local var_7_1 = arg_7_0.data.userDealScores[arg_7_0.dealCount]

		if arg_7_0.data:checkPrice(var_7_1) == Activity117Enum.PriceType.Bad then
			var_7_0 = 1
		end
	end

	arg_7_0.curTabIndex = arg_7_0.curIndex + var_7_0

	local var_7_2 = arg_7_0.limitCount + var_7_0

	for iter_7_0 = 1, math.max(var_7_2, #arg_7_0.tabItems) do
		if not arg_7_0.tabItems[iter_7_0] then
			arg_7_0.tabItems[iter_7_0] = arg_7_0:createTab(iter_7_0)
		end

		arg_7_0:updateTab(arg_7_0.tabItems[iter_7_0], iter_7_0 <= var_7_2)
	end
end

function var_0_0.createTab(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0:getUserDataTb_()

	var_8_0.index = arg_8_1
	var_8_0.go = gohelper.cloneInPlace(arg_8_0.goTabItem, "tab" .. arg_8_1)
	var_8_0.goCurrent = gohelper.findChild(var_8_0.go, "go_current")
	var_8_0.txtCurrent = gohelper.findChildTextMesh(var_8_0.go, "go_current/txt_curvalue")
	var_8_0.goCurrentLine = gohelper.findChild(var_8_0.go, "go_current/txt_curvalue/go_line")
	var_8_0.goCricle = gohelper.findChild(var_8_0.go, "go_current/circle")
	var_8_0.goUnfinish = gohelper.findChild(var_8_0.go, "go_unfinish")
	var_8_0.goFinish = gohelper.findChild(var_8_0.go, "go_finish")
	var_8_0.txtFinish = gohelper.findChildTextMesh(var_8_0.go, "go_finish/txt_quotevalue")

	gohelper.setActive(var_8_0.go, true)

	return var_8_0
end

function var_0_0.updateTab(arg_9_0, arg_9_1, arg_9_2)
	if not arg_9_2 then
		gohelper.setActive(arg_9_1.go, false)

		return
	end

	gohelper.setActive(arg_9_1.go, true)

	local var_9_0 = arg_9_1.index == arg_9_0.curTabIndex
	local var_9_1 = arg_9_0.data.userDealScores[arg_9_1.index]

	if arg_9_1.index > arg_9_0.limitCount then
		var_9_1 = arg_9_0.data:getMinPrice()
	end

	if var_9_0 then
		gohelper.setActive(arg_9_1.goCurrent, true)
		gohelper.setActive(arg_9_1.goFinish, false)
		gohelper.setActive(arg_9_1.goUnfinish, false)

		if var_9_1 then
			local var_9_2 = arg_9_0.data:checkPrice(var_9_1)

			if not arg_9_0.isWait and var_9_2 == Activity117Enum.PriceType.Bad then
				arg_9_1.txtCurrent.text = string.format("<color=#797E79>%s</color>", var_9_1)

				gohelper.setActive(arg_9_1.goCurrentLine, true)
			else
				arg_9_1.txtCurrent.text = var_9_1

				gohelper.setActive(arg_9_1.goCurrentLine, false)
			end
		else
			arg_9_1.txtCurrent.text = arg_9_0:getSliderValue()

			gohelper.setActive(arg_9_1.goCurrentLine, false)
		end
	else
		gohelper.setActive(arg_9_1.goCurrent, false)

		if var_9_1 then
			gohelper.setActive(arg_9_1.goFinish, true)
			gohelper.setActive(arg_9_1.goUnfinish, false)

			arg_9_1.txtFinish.text = string.format("%s", var_9_1)
		else
			gohelper.setActive(arg_9_1.goFinish, false)
			gohelper.setActive(arg_9_1.goUnfinish, true)
		end
	end
end

function var_0_0.updateContent(arg_10_0)
	TaskDispatcher.cancelTask(arg_10_0.showTalkDesc, arg_10_0)

	if arg_10_0.tweenId then
		ZProj.TweenHelper.KillById(arg_10_0.tweenId)

		arg_10_0.tweenId = nil
	end

	if arg_10_0.isWait then
		arg_10_0.txtTips.text = ""

		Activity117Controller.instance:dispatchEvent(Activity117Event.PlayTalk, arg_10_0.actId, "", true)
		arg_10_0:setBtnActive(false, false, true, false, false)
		gohelper.setActive(arg_10_0.slider, false)
		TaskDispatcher.runDelay(arg_10_0._delaySetData, arg_10_0, 3)
		gohelper.setActive(arg_10_0.goDot, true)

		return
	end

	gohelper.setActive(arg_10_0.goDot, false)

	local var_10_0 = arg_10_0.data.userDealScores[arg_10_0.curIndex]

	if var_10_0 then
		local var_10_1 = arg_10_0.data:checkPrice(var_10_0)
		local var_10_2 = #arg_10_0.data.userDealScores

		if var_10_1 ~= Activity117Enum.PriceType.Bad then
			arg_10_0:setBtnActive(arg_10_0.hasCount, false, false, false, true)
		else
			arg_10_0:setBtnActive(false, arg_10_0.hasCount, false, false, not arg_10_0.hasCount)

			if arg_10_0.curIndex == arg_10_0.limitCount then
				var_10_1 = Activity117Enum.PriceType.LastFail
			end
		end

		arg_10_0:updateTalk(var_10_1)
		gohelper.setActive(arg_10_0.slider, false)

		return
	end

	gohelper.setActive(arg_10_0.slider, true)

	arg_10_0.txtTips.text = ""

	arg_10_0:setBtnActive(false, false, false, true, false)

	arg_10_0.txtMinPrice.text = arg_10_0.data.minScore
	arg_10_0.txtMaxPrice.text = arg_10_0.data.maxScore

	Activity117Controller.instance:dispatchEvent(Activity117Event.PlayTalk, arg_10_0.actId)
end

function var_0_0.setBtnActive(arg_11_0, arg_11_1, arg_11_2, arg_11_3, arg_11_4, arg_11_5)
	gohelper.setActive(arg_11_0.btnRequote1, arg_11_1)
	gohelper.setActive(arg_11_0.btnRequote2, arg_11_2)
	gohelper.setActive(arg_11_0.btnQuoted, arg_11_3)
	gohelper.setActive(arg_11_0.btnConfirm, arg_11_4)
	gohelper.setActive(arg_11_0.btnDeal, arg_11_5)
end

function var_0_0.updateTalk(arg_12_0, arg_12_1)
	local var_12_0 = Activity117Config.instance:getTalkCo(arg_12_0.actId, arg_12_1)

	arg_12_0.talkContent = var_12_0 and var_12_0.content2 or ""
	arg_12_0.txtTips.text = ""

	Activity117Controller.instance:dispatchEvent(Activity117Event.PlayTalk, arg_12_0.actId, var_12_0 and var_12_0.content1 or "")
	TaskDispatcher.runDelay(arg_12_0.showTalkDesc, arg_12_0, 2)
end

function var_0_0.showTalkDesc(arg_13_0)
	TaskDispatcher.cancelTask(arg_13_0.showTalkDesc, arg_13_0)

	if arg_13_0.tweenId then
		ZProj.TweenHelper.KillById(arg_13_0.tweenId)

		arg_13_0.tweenId = nil
	end

	arg_13_0.txtTips.text = ""
	arg_13_0.tweenId = ZProj.TweenHelper.DOText(arg_13_0.txtTips, arg_13_0.talkContent, 2)
end

function var_0_0.getSliderValue(arg_14_0)
	if not arg_14_0.data then
		return 0
	end

	return tostring(math.ceil(arg_14_0.slider:GetValue() * (arg_14_0.data.maxScore - arg_14_0.data.minScore)) + arg_14_0.data.minScore)
end

function var_0_0.refreshBargainSliderText(arg_15_0)
	local var_15_0 = arg_15_0.tabItems[arg_15_0.curIndex or 1]

	if var_15_0 then
		var_15_0.txtCurrent.text = arg_15_0:getSliderValue()
	end
end

function var_0_0.onSliderValueChanged(arg_16_0, arg_16_1)
	arg_16_0:refreshBargainSliderText()

	local var_16_0 = Time.realtimeSinceStartup

	if not arg_16_0._audioTime then
		arg_16_0._audioTime = Time.realtimeSinceStartup

		AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_Star_In)

		return
	end

	if var_16_0 - arg_16_0._audioTime > 0.1 then
		arg_16_0._audioTime = var_16_0

		AudioMgr.instance:trigger(AudioEnum.UI.Task_UI_Star_In)
	end
end

function var_0_0.onClickRetryBargain(arg_17_0, arg_17_1)
	Activity117Model.instance:setInQuote(arg_17_0.actId, true)
	Activity117Controller.instance:dispatchEvent(Activity117Event.RefreshQuoteView, arg_17_0.actId)
end

function var_0_0.onClickConfirmPrice(arg_18_0, arg_18_1)
	local var_18_0 = Activity117Model.instance:getSelectOrder(arg_18_0.actId)

	Activity117Rpc.instance:sendAct117DealRequest(arg_18_0.actId, var_18_0)
end

function var_0_0.onClickSubmitMyPrice(arg_19_0)
	local var_19_0 = arg_19_0.data

	if not var_19_0 then
		return
	end

	local var_19_1 = Activity117Model.instance:getSelectOrder(arg_19_0.actId)
	local var_19_2 = math.ceil(arg_19_0.slider:GetValue() * (var_19_0.maxScore - var_19_0.minScore)) + var_19_0.minScore

	local function var_19_3()
		Activity117Rpc.instance:sendAct117NegotiateRequest(arg_19_0.actId, var_19_1, var_19_2)
	end

	GameFacade.showMessageBox(MessageBoxIdDefine.TradeBargainConfirm, MsgBoxEnum.BoxType.Yes_No, var_19_3)
end

function var_0_0.destory(arg_21_0)
	if arg_21_0.tweenId then
		ZProj.TweenHelper.KillById(arg_21_0.tweenId)

		arg_21_0.tweenId = nil
	end

	arg_21_0.tabItems = nil

	arg_21_0.btnConfirm:RemoveClickListener()
	arg_21_0.btnDeal:RemoveClickListener()
	arg_21_0.btnRequote1:RemoveClickListener()
	arg_21_0.btnRequote2:RemoveClickListener()
	arg_21_0.slider:RemoveOnValueChanged()
	TaskDispatcher.cancelTask(arg_21_0._delaySetData, arg_21_0)
	TaskDispatcher.cancelTask(arg_21_0.showTalkDesc, arg_21_0)
	arg_21_0:__onDispose()
end

return var_0_0
