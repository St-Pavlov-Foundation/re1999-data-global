module("modules.logic.versionactivity3_1.nationalgift.view.NationalGiftBuyTipView", package.seeall)

local var_0_0 = class("NationalGiftBuyTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotip = gohelper.findChild(arg_1_0.viewGO, "Title/image_TitleTips")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Title/image_TitleTips/#btn_click")
	arg_1_0._gobonusitem = gohelper.findChild(arg_1_0.viewGO, "layout/#go_bonusitem")
	arg_1_0._btnBuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Buy")
	arg_1_0._txtPrice = gohelper.findChildText(arg_1_0.viewGO, "#btn_Buy/#txt_Price")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "#go_time")
	arg_1_0._txtlimit = gohelper.findChildText(arg_1_0.viewGO, "#go_time/txt_limit")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "#go_time/#txt_time")
	arg_1_0._btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnBuy:AddClickListener(arg_2_0._btnBuyOnClick, arg_2_0)
	arg_2_0._btnClose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnBuy:RemoveClickListener()
	arg_3_0._btnClose:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	local var_4_0 = CommonConfig.instance:getConstStr(ConstEnum.NationalGiftDesc)

	HelpController.instance:openStoreTipView(var_4_0)
end

function var_0_0._btnBuyOnClick(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)

	local var_5_0 = NationalGiftModel.instance:getNationalGiftStoreId()

	PayController.instance:startPay(var_5_0)
end

function var_0_0._btnCloseOnClick(arg_6_0)
	arg_6_0:closeThis()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._bonusItems = {}
end

function var_0_0._addSelfEvents(arg_8_0)
	arg_8_0:addEventCb(NationalGiftController.instance, NationalGiftEvent.onAct212InfoGet, arg_8_0._refresh, arg_8_0)
	arg_8_0:addEventCb(NationalGiftController.instance, NationalGiftEvent.onAct212InfoUpdate, arg_8_0._refresh, arg_8_0)
	arg_8_0:addEventCb(PayController.instance, PayEvent.PayFinished, arg_8_0._onBonusPush, arg_8_0)
end

function var_0_0._removeSelfEvents(arg_9_0)
	arg_9_0:removeEventCb(NationalGiftController.instance, NationalGiftEvent.onAct212InfoGet, arg_9_0._refresh, arg_9_0)
	arg_9_0:removeEventCb(NationalGiftController.instance, NationalGiftEvent.onAct212InfoUpdate, arg_9_0._refresh, arg_9_0)
	arg_9_0:removeEventCb(PayController.instance, PayEvent.PayFinished, arg_9_0._onBonusPush, arg_9_0)
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:_addSelfEvents()
	arg_10_0:_initView()
	arg_10_0:_refresh()

	local var_10_0 = arg_10_0.viewParam and arg_10_0.viewParam.goodMo

	if var_10_0 then
		StoreController.instance:statOpenChargeGoods(var_10_0.belongStoreId, var_10_0.config)
	end
end

function var_0_0._initView(arg_11_0)
	local var_11_0 = NationalGiftModel.instance:getNationalGiftStoreId()

	arg_11_0._txtPrice.text = PayModel.instance:getProductPrice(var_11_0)

	AudioMgr.instance:trigger(AudioEnum3_1.NationalGift.play_ui_leimi_souvenir_open)
end

function var_0_0._onBonusPush(arg_12_0)
	arg_12_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_12_0._onCloseViewCall, arg_12_0)
end

function var_0_0._onCloseViewCall(arg_13_0, arg_13_1)
	if arg_13_1 == ViewName.CommonPropView then
		arg_13_0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_13_0._onCloseViewCall, arg_13_0)
		GameFacade.showMessageBox(MessageBoxIdDefine.NationalGiftJumpTip, MsgBoxEnum.BoxType.Yes_No, arg_13_0._onYesCallback, arg_13_0._onNoCallback, nil, arg_13_0, arg_13_0)
	end
end

function var_0_0._onYesCallback(arg_14_0)
	local var_14_0 = string.format("%s#%s", JumpEnum.JumpView.ActivityView, VersionActivity3_1Enum.ActivityId.NationalGift)

	JumpController.instance:jumpByParam(var_14_0)
	arg_14_0:closeThis()
end

function var_0_0._onNoCallback(arg_15_0)
	arg_15_0:closeThis()
end

function var_0_0._refresh(arg_16_0)
	arg_16_0:_checkAutoGetReward()
	arg_16_0:_refreshUI()
	arg_16_0:_refreshTime()
	arg_16_0:_refreshBonusItems()
end

function var_0_0._checkAutoGetReward(arg_17_0)
	if not NationalGiftModel.instance:isGiftHasBuy() then
		return
	end

	if not NationalGiftModel.instance:isBonusCouldGet(1) then
		return
	end

	Activity212Rpc.instance:sendAct212ReceiveBonusRequest(VersionActivity3_1Enum.ActivityId.NationalGift, 1)
end

function var_0_0._refreshUI(arg_18_0)
	local var_18_0 = NationalGiftModel.instance:isGiftHasBuy()

	gohelper.setActive(arg_18_0._btnBuy.gameObject, not var_18_0)
	gohelper.setActive(arg_18_0._gotip, not var_18_0)
end

function var_0_0._refreshTime(arg_19_0)
	local var_19_0 = NationalGiftModel.instance:isGiftHasBuy()
	local var_19_1 = ServerTime.now()

	if not var_19_0 then
		local var_19_2 = NationalGiftModel.instance:getBuyEndTime()

		if var_19_2 <= var_19_1 then
			gohelper.setActive(arg_19_0._gotime, false)

			return
		end

		local var_19_3 = TimeUtil.SecondToActivityTimeFormat(var_19_2 - var_19_1)

		arg_19_0._txtlimit.text = luaLang("buy_limit_time")
		arg_19_0._txttime.text = var_19_3
	else
		local var_19_4 = NationalGiftModel.instance:getBonusEndTime()

		if var_19_4 <= var_19_1 then
			gohelper.setActive(arg_19_0._gotime, false)

			return
		end

		local var_19_5 = TimeUtil.SecondToActivityTimeFormat(var_19_4 - var_19_1)

		arg_19_0._txtlimit.text = luaLang("receive_limit_time")
		arg_19_0._txttime.text = var_19_5
	end
end

function var_0_0._refreshBonusItems(arg_20_0)
	local var_20_0 = NationalGiftConfig.instance:getBonusCos()

	for iter_20_0, iter_20_1 in ipairs(var_20_0) do
		if not arg_20_0._bonusItems[iter_20_1.id] then
			arg_20_0._bonusItems[iter_20_1.id] = NationalGiftBuyTipBonusItem.New()

			local var_20_1 = gohelper.cloneInPlace(arg_20_0._gobonusitem)

			arg_20_0._bonusItems[iter_20_1.id]:init(var_20_1, iter_20_1)
		end

		arg_20_0._bonusItems[iter_20_1.id]:refresh()
	end
end

function var_0_0.onClose(arg_21_0)
	arg_21_0:_removeSelfEvents()

	if arg_21_0._bonusItems then
		for iter_21_0, iter_21_1 in ipairs(arg_21_0._bonusItems) do
			iter_21_1:destroy()
		end

		arg_21_0._bonusItems = nil
	end
end

function var_0_0.onDestroyView(arg_22_0)
	return
end

return var_0_0
