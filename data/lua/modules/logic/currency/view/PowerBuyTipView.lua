module("modules.logic.currency.view.PowerBuyTipView", package.seeall)

local var_0_0 = class("PowerBuyTipView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btntouchClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_touchClose")
	arg_1_0._simagetipbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_tipbg")
	arg_1_0._txtbuytip = gohelper.findChildText(arg_1_0.viewGO, "centerTip/#txt_buytip")
	arg_1_0._txtremaincount = gohelper.findChildText(arg_1_0.viewGO, "centerTip/#txt_remaincount")
	arg_1_0._toggletip = gohelper.findChildToggle(arg_1_0.viewGO, "centerTip/#toggle_tip")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_buy")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btntouchClose:AddClickListener(arg_2_0._btntouchCloseOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
	arg_2_0._toggletip:AddOnValueChanged(arg_2_0._toggleTipOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btntouchClose:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnbuy:RemoveClickListener()
	arg_3_0._toggletip:RemoveOnValueChanged()
end

function var_0_0._btntouchCloseOnClick(arg_4_0)
	arg_4_0:closeThis()
end

function var_0_0._btncloseOnClick(arg_5_0)
	arg_5_0:closeThis()
end

function var_0_0._btnbuyOnClick(arg_6_0)
	if arg_6_0._buyDiamondStep > 0 then
		if arg_6_0._buyDiamondStep == 1 then
			if arg_6_0:_checkExchangeFreeDiamond(arg_6_0.deltaDiamond) then
				arg_6_0:closeThis()
			end
		else
			StoreController.instance:checkAndOpenStoreView(StoreEnum.ChargeStoreTabId)
			ViewMgr.instance:closeView(ViewName.PowerView)
			arg_6_0:closeThis()
		end
	else
		local var_6_0 = arg_6_0._toggletip.isOn

		CurrencyController.instance:dispatchEvent(CurrencyEvent.PowerBuyTipToggleOn, var_6_0)

		arg_6_0.addPowerSuccess = true

		if arg_6_0.buyinfo.isPowerPotion then
			ItemRpc.instance:sendUsePowerItemRequest(arg_6_0.buyinfo.uid)
		elseif arg_6_0:_checkFreeDiamondEnough(arg_6_0._costParam[3]) then
			CurrencyRpc.instance:sendBuyPowerRequest()
		else
			arg_6_0.addPowerSuccess = false
		end

		if arg_6_0.addPowerSuccess then
			CurrencyController.instance:dispatchEvent(CurrencyEvent.PowerBuySuccess)
			arg_6_0:closeThis()
		end
	end
end

function var_0_0._ExchangeFreeDiamondCallBack(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	if arg_7_2 == 0 then
		CurrencyRpc.instance:sendBuyPowerRequest()
		CurrencyController.instance:dispatchEvent(CurrencyEvent.PowerBuySuccess)
	end
end

function var_0_0._checkExchangeFreeDiamond(arg_8_0, arg_8_1)
	local var_8_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Diamond)

	if var_8_0 then
		if arg_8_1 <= var_8_0.quantity then
			CurrencyRpc.instance:sendExchangeDiamondRequest(arg_8_1, CurrencyEnum.PayDiamondExchangeSource.Power, arg_8_0._ExchangeFreeDiamondCallBack, arg_8_0)

			return true
		else
			local var_8_1 = arg_8_1 - var_8_0.quantity
			local var_8_2 = MessageBoxConfig.instance:getMessage(MessageBoxIdDefine.PayDiamondNotEnough)

			arg_8_0._buyDiamondStep = 2
			arg_8_0._txtbuytip.text = var_8_2

			return false
		end
	else
		logError("can't find payDiamond MO")

		return true
	end
end

function var_0_0._checkFreeDiamondEnough(arg_9_0, arg_9_1)
	local var_9_0 = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.FreeDiamondCoupon)

	if var_9_0 then
		if arg_9_1 <= var_9_0.quantity then
			return true
		else
			arg_9_0.deltaDiamond = arg_9_1 - var_9_0.quantity
			arg_9_0._txtbuytip.text = string.format(luaLang("powerbuy_tip_2"), arg_9_0.deltaDiamond)

			gohelper.setActive(arg_9_0._txtremaincount.gameObject, false)

			arg_9_0._buyDiamondStep = 1

			return false
		end
	else
		logError("can't find freeDiamond MO")

		return false
	end
end

function var_0_0._toggleTipOnClick(arg_10_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function var_0_0._editableInitView(arg_11_0)
	arg_11_0._toggletip.isOn = false

	arg_11_0._simagetipbg:LoadImage(ResUrl.getMessageIcon("bg_tanchuang"))
end

function var_0_0.onUpdateParam(arg_12_0)
	return
end

function var_0_0.onOpen(arg_13_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	arg_13_0.buyinfo = arg_13_0.viewParam

	local var_13_0 = arg_13_0.buyinfo.isPowerPotion

	gohelper.setActive(arg_13_0._txtremaincount.gameObject, not var_13_0)
	gohelper.setActive(arg_13_0._toggletip.gameObject, var_13_0)
	arg_13_0:refreshCenterTip()

	arg_13_0.addPowerSuccess = false
	arg_13_0._buyDiamondStep = 0

	NavigateMgr.instance:addEscape(arg_13_0.viewName, arg_13_0._btncloseOnClick, arg_13_0)
end

function var_0_0.refreshCenterTip(arg_14_0)
	if not arg_14_0.buyinfo.isPowerPotion then
		local var_14_0 = CommonConfig.instance:getConstStr(ConstEnum.PowerBuyCostId)

		arg_14_0._powerMaxBuyCount = CommonConfig.instance:getConstNum(ConstEnum.PowerMaxBuyCountId)
		arg_14_0._costParamList = GameUtil.splitString2(var_14_0, true)
		arg_14_0._costParam = arg_14_0._costParamList[arg_14_0._powerMaxBuyCount - CurrencyModel.instance.powerCanBuyCount + 1]

		if arg_14_0._costParam == nil then
			arg_14_0._costParam = arg_14_0._costParamList[#arg_14_0._costParamList]
		end

		local var_14_1 = PlayerModel.instance:getPlayinfo().level
		local var_14_2 = PlayerConfig.instance:getPlayerLevelCO(var_14_1).addBuyRecoverPower
		local var_14_3 = ItemModel.instance:getItemConfig(arg_14_0._costParam[1], arg_14_0._costParam[2])
		local var_14_4 = {
			arg_14_0._costParam[3],
			var_14_3.name,
			var_14_2
		}
		local var_14_5 = GameUtil.getSubPlaceholderLuaLang(luaLang("powerbuy_tip"), var_14_4)

		if LangSettings.instance:isEn() then
			arg_14_0._txtbuytip.text = string.format("%s(%s)", var_14_5, string.format(luaLang("powerbuy_remaincount"), CurrencyModel.instance.powerCanBuyCount))
		else
			arg_14_0._txtbuytip.text = string.format("%s（%s）", var_14_5, string.format(luaLang("powerbuy_remaincount"), CurrencyModel.instance.powerCanBuyCount))
		end

		arg_14_0._txtremaincount.text = luaLang("powerbuy_tip_3")
	elseif arg_14_0.buyinfo.type == MaterialEnum.PowerType.Small then
		local var_14_6 = {
			"",
			luaLang("power_item1_name"),
			60
		}

		arg_14_0._txtbuytip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("powerbuy_tip"), var_14_6)
	elseif arg_14_0.buyinfo.type == MaterialEnum.PowerType.Big then
		local var_14_7 = {
			"",
			luaLang("power_item2_name"),
			120
		}

		arg_14_0._txtbuytip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("powerbuy_tip"), var_14_7)
	end
end

function var_0_0.onClose(arg_15_0)
	if arg_15_0.addPowerSuccess then
		return
	end
end

function var_0_0.onDestroyView(arg_16_0)
	arg_16_0._simagetipbg:UnLoadImage()
end

return var_0_0
