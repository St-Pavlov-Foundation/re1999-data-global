module("modules.logic.versionactivity3_1.nationalgift.view.NationalGiftFullView", package.seeall)

local var_0_0 = class("NationalGiftFullView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gotip = gohelper.findChild(arg_1_0.viewGO, "txt_tips")
	arg_1_0._gotime = gohelper.findChild(arg_1_0.viewGO, "#go_time")
	arg_1_0._txtlimit = gohelper.findChildText(arg_1_0.viewGO, "#go_time/txt_limit")
	arg_1_0._txttime = gohelper.findChildText(arg_1_0.viewGO, "#go_time/#txt_time")
	arg_1_0._btntips = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_tips")
	arg_1_0._gonode1 = gohelper.findChild(arg_1_0.viewGO, "content/#go_node1")
	arg_1_0._gonode2 = gohelper.findChild(arg_1_0.viewGO, "content/#go_node2")
	arg_1_0._gonode3 = gohelper.findChild(arg_1_0.viewGO, "content/#go_node3")
	arg_1_0._gonode4 = gohelper.findChild(arg_1_0.viewGO, "content/#go_node4")
	arg_1_0._gonode5 = gohelper.findChild(arg_1_0.viewGO, "content/#go_node5")
	arg_1_0._btnBuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_Buy")
	arg_1_0._txtPrice = gohelper.findChildText(arg_1_0.viewGO, "#btn_Buy/#txt_Price")
	arg_1_0._gohasbuy = gohelper.findChild(arg_1_0.viewGO, "#go_hasbuy")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntips:AddClickListener(arg_2_0._btntipsOnClick, arg_2_0)
	arg_2_0._btnBuy:AddClickListener(arg_2_0._btnBuyOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntips:RemoveClickListener()
	arg_3_0._btnBuy:RemoveClickListener()
end

function var_0_0._btntipsOnClick(arg_4_0)
	local var_4_0 = CommonConfig.instance:getConstStr(ConstEnum.NationalGiftDesc)

	HelpController.instance:openStoreTipView(var_4_0)
end

function var_0_0._btnBuyOnClick(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)

	local var_5_0 = NationalGiftModel.instance:getNationalGiftStoreId()

	PayController.instance:startPay(var_5_0)
end

function var_0_0._buyCallback(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	if arg_6_2 ~= 0 then
		return
	end

	arg_6_0:_refresh()
end

function var_0_0._editableInitView(arg_7_0)
	arg_7_0._anim = arg_7_0._gonode1:GetComponent(typeof(UnityEngine.Animator))
end

function var_0_0._addSelfEvents(arg_8_0)
	arg_8_0:addEventCb(NationalGiftController.instance, NationalGiftEvent.onAct212InfoGet, arg_8_0._refresh, arg_8_0)
	arg_8_0:addEventCb(NationalGiftController.instance, NationalGiftEvent.onAct212InfoUpdate, arg_8_0._refresh, arg_8_0)
	arg_8_0:addEventCb(NationalGiftController.instance, NationalGiftEvent.OnAct212BonusUpdate, arg_8_0._onBonusUpdate, arg_8_0)
end

function var_0_0._removeSelfEvents(arg_9_0)
	arg_9_0:removeEventCb(NationalGiftController.instance, NationalGiftEvent.onAct212InfoGet, arg_9_0._refresh, arg_9_0)
	arg_9_0:removeEventCb(NationalGiftController.instance, NationalGiftEvent.onAct212InfoUpdate, arg_9_0._refresh, arg_9_0)
	arg_9_0:removeEventCb(NationalGiftController.instance, NationalGiftEvent.OnAct212BonusUpdate, arg_9_0._onBonusUpdate, arg_9_0)
end

function var_0_0._onBonusUpdate(arg_10_0)
	local var_10_0 = NationalGiftModel.instance:isGiftHasBuy()

	if not arg_10_0._isGiftHasBuy and var_10_0 then
		arg_10_0._anim:Play("buy", 0, 0)
		gohelper.setActive(arg_10_0._gohasbuy, true)
	end

	arg_10_0:_refresh()
end

function var_0_0.onOpen(arg_11_0)
	local var_11_0 = arg_11_0.viewParam.parent

	gohelper.addChild(var_11_0, arg_11_0.viewGO)

	arg_11_0._actId = VersionActivity3_1Enum.ActivityId.SurvivalOperAct
	arg_11_0._bonusItems = {}

	arg_11_0:_addSelfEvents()
	arg_11_0:_initView()
	arg_11_0:_refresh()
end

function var_0_0._initView(arg_12_0)
	local var_12_0 = NationalGiftModel.instance:getNationalGiftStoreId()

	arg_12_0._txtPrice.text = PayModel.instance:getProductPrice(var_12_0)

	AudioMgr.instance:trigger(AudioEnum3_1.NationalGift.play_ui_mln_page_turn)
end

function var_0_0._refresh(arg_13_0)
	arg_13_0._isGiftHasBuy = NationalGiftModel.instance:isGiftHasBuy()

	arg_13_0:_refreshUI()
	arg_13_0:_refreshTime()
	arg_13_0:_refreshBonusItems()
end

function var_0_0._refreshUI(arg_14_0)
	gohelper.setActive(arg_14_0._btnBuy.gameObject, not arg_14_0._isGiftHasBuy)
	gohelper.setActive(arg_14_0._gotip, not arg_14_0._isGiftHasBuy)
	gohelper.setActive(arg_14_0._gohasbuy, arg_14_0._isGiftHasBuy)
end

function var_0_0._refreshTime(arg_15_0)
	local var_15_0 = ServerTime.now()

	if not arg_15_0._isGiftHasBuy then
		local var_15_1 = NationalGiftModel.instance:getBuyEndTime()

		if var_15_1 <= var_15_0 then
			gohelper.setActive(arg_15_0._gotime, false)

			return
		end

		local var_15_2 = TimeUtil.SecondToActivityTimeFormat(var_15_1 - var_15_0)

		arg_15_0._txtlimit.text = luaLang("buy_limit_time")
		arg_15_0._txttime.text = var_15_2
	else
		local var_15_3 = NationalGiftModel.instance:getBonusEndTime()

		if var_15_3 <= var_15_0 then
			gohelper.setActive(arg_15_0._gotime, false)

			return
		end

		local var_15_4 = TimeUtil.SecondToActivityTimeFormat(var_15_3 - var_15_0)

		arg_15_0._txtlimit.text = luaLang("receive_limit_time")
		arg_15_0._txttime.text = var_15_4
	end
end

function var_0_0._refreshBonusItems(arg_16_0)
	local var_16_0 = NationalGiftConfig.instance:getBonusCos()

	for iter_16_0, iter_16_1 in ipairs(var_16_0) do
		if not arg_16_0._bonusItems[iter_16_1.id] then
			arg_16_0._bonusItems[iter_16_1.id] = NationalGiftFullBonusItem.New()

			arg_16_0._bonusItems[iter_16_1.id]:init(arg_16_0["_gonode" .. tostring(iter_16_1.id)], iter_16_1)
		end

		arg_16_0._bonusItems[iter_16_1.id]:refresh()
	end
end

function var_0_0.onClose(arg_17_0)
	arg_17_0:_removeSelfEvents()

	if arg_17_0._bonusItems then
		for iter_17_0, iter_17_1 in pairs(arg_17_0._bonusItems) do
			iter_17_1:destroy()
		end

		arg_17_0._bonusItems = nil
	end
end

function var_0_0.onDestroyView(arg_18_0)
	return
end

return var_0_0
