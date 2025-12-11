module("modules.logic.chargepush.view.ChargePushMonthCardView", package.seeall)

local var_0_0 = class("ChargePushMonthCardView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_Close")
	arg_1_0.btnLeft = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_emptyLeft")
	arg_1_0.btnRight = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_emptyRight")
	arg_1_0.btnTop = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_emptyTop")
	arg_1_0.btnBottom = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_emptyBottom")
	arg_1_0.txtDesc = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/info/#scroll_desc/Viewport/#txt_desc")
	arg_1_0.txtTime = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/info/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	arg_1_0.btnBuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/buy/#btn_buy")
	arg_1_0.txtCost = gohelper.findChildText(arg_1_0.viewGO, "root/buy/#txt_cost")
	arg_1_0.txtCostIcon = gohelper.findChildTextMesh(arg_1_0.viewGO, "root/buy/costicon")
	arg_1_0.goIcon1 = gohelper.findChild(arg_1_0.viewGO, "root/reward1/#go_icon1")
	arg_1_0.goIcon2 = gohelper.findChild(arg_1_0.viewGO, "root/reward1/#go_icon2")
	arg_1_0.goIcon3 = gohelper.findChild(arg_1_0.viewGO, "root/reward2/#go_icon1")
	arg_1_0.goIcon4 = gohelper.findChild(arg_1_0.viewGO, "root/reward2/#go_icon2")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClose, arg_2_0.onClickClose, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnLeft, arg_2_0.onClickClose, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnRight, arg_2_0.onClickClose, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnTop, arg_2_0.onClickClose, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnBottom, arg_2_0.onClickClose, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnBuy, arg_2_0.onClickBuy, arg_2_0)
	arg_2_0:addEventCb(PayController.instance, PayEvent.PayFinished, arg_2_0._payFinished, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnClose)
	arg_3_0:removeClickCb(arg_3_0.btnLeft)
	arg_3_0:removeClickCb(arg_3_0.btnRight)
	arg_3_0:removeClickCb(arg_3_0.btnTop)
	arg_3_0:removeClickCb(arg_3_0.btnBottom)
	arg_3_0:removeClickCb(arg_3_0.btnBuy)
	arg_3_0:removeEventCb(PayController.instance, PayEvent.PayFinished, arg_3_0._payFinished, arg_3_0)
end

function var_0_0._editableInitView(arg_4_0)
	return
end

function var_0_0._payFinished(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0.onClickBuy(arg_6_0)
	local var_6_0 = StoreModel.instance:getGoodsMO(arg_6_0.goodsId)

	if not var_6_0 then
		return
	end

	StoreController.instance:openPackageStoreGoodsView(var_6_0)
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0:refreshParam()
	arg_7_0:refreshView()
end

function var_0_0.onUpdateParam(arg_8_0)
	arg_8_0:refreshParam()
	arg_8_0:refreshView()
end

function var_0_0.refreshParam(arg_9_0)
	arg_9_0.config = arg_9_0.viewParam and arg_9_0.viewParam.config
	arg_9_0.goodsId = StoreEnum.MonthCardGoodsId
end

function var_0_0.refreshView(arg_10_0)
	if not arg_10_0.config then
		return
	end

	arg_10_0.txtDesc.text = arg_10_0.config.desc

	local var_10_0 = PayModel.instance:getProductOriginPriceNum(arg_10_0.goodsId)
	local var_10_1 = PayModel.instance:getProductOriginPriceSymbol(arg_10_0.goodsId)

	arg_10_0.txtCost.text = var_10_0
	arg_10_0.txtCostIcon.text = var_10_1

	arg_10_0:updateMonthCardItem()
	arg_10_0:refreshRemainDay()
end

function var_0_0.refreshRemainDay(arg_11_0)
	if tonumber(arg_11_0.config.listenerType) == ChargePushEnum.ListenerType.MonthCardAfter then
		arg_11_0.txtTime.text = luaLang("hasExpire")

		return
	end

	local var_11_0 = StoreModel.instance:getMonthCardInfo()

	if var_11_0 then
		local var_11_1 = var_11_0:getRemainDay()

		if var_11_1 == StoreEnum.MonthCardStatus.NotPurchase then
			arg_11_0.txtTime.text = luaLang("hasExpire")
		elseif var_11_1 == StoreEnum.MonthCardStatus.NotEnoughOneDay then
			arg_11_0.txtTime.text = luaLang("not_enough_one_day")
		else
			arg_11_0.txtTime.text = formatLuaLang("remain_day", var_11_1)
		end
	else
		arg_11_0.txtTime.text = luaLang("not_purchase")
	end
end

function var_0_0.updateMonthCardItem(arg_12_0)
	local var_12_0 = StoreConfig.instance:getMonthCardConfig(arg_12_0.goodsId)
	local var_12_1 = GameUtil.splitString2(var_12_0.onceBonus, true)
	local var_12_2 = var_12_1[1]
	local var_12_3 = var_12_2[1]
	local var_12_4 = var_12_2[2]
	local var_12_5 = var_12_2[3]

	arg_12_0._monthCardItemIcon = arg_12_0._monthCardItemIcon or IconMgr.instance:getCommonItemIcon(arg_12_0.goIcon1)

	arg_12_0:_setIcon(arg_12_0._monthCardItemIcon, var_12_3, var_12_4, var_12_5)

	local var_12_6 = var_12_1[2]
	local var_12_7 = var_12_6[1]
	local var_12_8 = var_12_6[2]
	local var_12_9 = var_12_6[3]

	arg_12_0._monthCardItemIcon2 = arg_12_0._monthCardItemIcon2 or IconMgr.instance:getCommonItemIcon(arg_12_0.goIcon2)

	arg_12_0:_setIcon(arg_12_0._monthCardItemIcon2, var_12_7, var_12_8, var_12_9)

	local var_12_10 = GameUtil.splitString2(var_12_0.dailyBonus, true)
	local var_12_11 = var_12_10[1]
	local var_12_12 = var_12_11[1]
	local var_12_13 = var_12_11[2]
	local var_12_14 = var_12_11[3]

	arg_12_0._monthCardDailyItemIcon = arg_12_0._monthCardDailyItemIcon or IconMgr.instance:getCommonItemIcon(arg_12_0.goIcon3)

	arg_12_0:_setIcon(arg_12_0._monthCardDailyItemIcon, var_12_12, var_12_13, var_12_14)

	local var_12_15 = var_12_10[2]
	local var_12_16 = var_12_15[1]
	local var_12_17 = var_12_15[2]
	local var_12_18 = var_12_15[3]

	arg_12_0._monthCardPowerItemIcon = arg_12_0._monthCardPowerItemIcon or IconMgr.instance:getCommonItemIcon(arg_12_0.goIcon4)

	arg_12_0:_setIcon(arg_12_0._monthCardPowerItemIcon, var_12_16, var_12_17, var_12_18)
end

function var_0_0._setIcon(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	if arg_13_2 == MaterialEnum.MaterialType.PowerPotion then
		arg_13_1:setMOValue(arg_13_2, arg_13_3, arg_13_4, nil, true)
		arg_13_1:setCantJump(true)
		arg_13_1:setCountFontSize(36)
		arg_13_1:setScale(0.7)
		arg_13_1:SetCountLocalY(43.6)
		arg_13_1:SetCountBgHeight(25)
		arg_13_1:setItemIconScale(1.1)

		local var_13_0 = arg_13_1:getIcon().transform

		recthelper.setAnchor(var_13_0, -7.2, 3.5)

		local var_13_1 = arg_13_1:getDeadline1()

		recthelper.setAnchor(var_13_1.transform, 78, 82.8)
		transformhelper.setLocalScale(var_13_1.transform, 0.7, 0.7, 1)

		arg_13_0._simgdeadline = gohelper.findChildImage(var_13_1, "timebg")

		UISpriteSetMgr.instance:setStoreGoodsSprite(arg_13_0._simgdeadline, "img_xianshi1")
	else
		arg_13_1:setMOValue(arg_13_2, arg_13_3, arg_13_4, nil, true)
		arg_13_1:setCantJump(true)
		arg_13_1:setCountFontSize(36)
		arg_13_1:setScale(0.7)
		arg_13_1:SetCountLocalY(43.6)
		arg_13_1:SetCountBgHeight(25)
	end
end

function var_0_0.onClose(arg_14_0)
	return
end

function var_0_0.onDestroyView(arg_15_0)
	return
end

function var_0_0.onClickClose(arg_16_0)
	arg_16_0:closeThis()
end

function var_0_0.onClickModalMask(arg_17_0)
	arg_17_0:closeThis()
end

return var_0_0
