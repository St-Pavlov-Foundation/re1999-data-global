module("modules.logic.currency.view.PowerBuyTipView", package.seeall)

slot0 = class("PowerBuyTipView", BaseView)

function slot0.onInitView(slot0)
	slot0._btntouchClose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_touchClose")
	slot0._simagetipbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_tipbg")
	slot0._txtbuytip = gohelper.findChildText(slot0.viewGO, "centerTip/#txt_buytip")
	slot0._txtremaincount = gohelper.findChildText(slot0.viewGO, "centerTip/#txt_remaincount")
	slot0._toggletip = gohelper.findChildToggle(slot0.viewGO, "centerTip/#toggle_tip")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")
	slot0._btnbuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_buy")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btntouchClose:AddClickListener(slot0._btntouchCloseOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._btnbuy:AddClickListener(slot0._btnbuyOnClick, slot0)
	slot0._toggletip:AddOnValueChanged(slot0._toggleTipOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btntouchClose:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._btnbuy:RemoveClickListener()
	slot0._toggletip:RemoveOnValueChanged()
end

function slot0._btntouchCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._btnbuyOnClick(slot0)
	if slot0._buyDiamondStep > 0 then
		if slot0._buyDiamondStep == 1 then
			if slot0:_checkExchangeFreeDiamond(slot0.deltaDiamond) then
				slot0:closeThis()
			end
		else
			StoreController.instance:checkAndOpenStoreView(StoreEnum.ChargeStoreTabId)
			ViewMgr.instance:closeView(ViewName.PowerView)
			slot0:closeThis()
		end
	else
		CurrencyController.instance:dispatchEvent(CurrencyEvent.PowerBuyTipToggleOn, slot0._toggletip.isOn)

		slot0.addPowerSuccess = true

		if slot0.buyinfo.isPowerPotion then
			ItemRpc.instance:sendUsePowerItemRequest(slot0.buyinfo.uid)
		elseif slot0:_checkFreeDiamondEnough(slot0._costParam[3]) then
			CurrencyRpc.instance:sendBuyPowerRequest()
		else
			slot0.addPowerSuccess = false
		end

		if slot0.addPowerSuccess then
			CurrencyController.instance:dispatchEvent(CurrencyEvent.PowerBuySuccess)
			slot0:closeThis()
		end
	end
end

function slot0._ExchangeFreeDiamondCallBack(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		CurrencyRpc.instance:sendBuyPowerRequest()
		CurrencyController.instance:dispatchEvent(CurrencyEvent.PowerBuySuccess)
	end
end

function slot0._checkExchangeFreeDiamond(slot0, slot1)
	if CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Diamond) then
		if slot1 <= slot2.quantity then
			CurrencyRpc.instance:sendExchangeDiamondRequest(slot1, CurrencyEnum.PayDiamondExchangeSource.Power, slot0._ExchangeFreeDiamondCallBack, slot0)

			return true
		else
			slot3 = slot1 - slot2.quantity
			slot0._buyDiamondStep = 2
			slot0._txtbuytip.text = MessageBoxConfig.instance:getMessage(MessageBoxIdDefine.PayDiamondNotEnough)

			return false
		end
	else
		logError("can't find payDiamond MO")

		return true
	end
end

function slot0._checkFreeDiamondEnough(slot0, slot1)
	if CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.FreeDiamondCoupon) then
		if slot1 <= slot2.quantity then
			return true
		else
			slot0.deltaDiamond = slot1 - slot2.quantity
			slot0._txtbuytip.text = string.format(luaLang("powerbuy_tip_2"), slot0.deltaDiamond)

			gohelper.setActive(slot0._txtremaincount.gameObject, false)

			slot0._buyDiamondStep = 1

			return false
		end
	else
		logError("can't find freeDiamond MO")

		return false
	end
end

function slot0._toggleTipOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function slot0._editableInitView(slot0)
	slot0._toggletip.isOn = false

	slot0._simagetipbg:LoadImage(ResUrl.getMessageIcon("bg_tanchuang"))
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	slot0.buyinfo = slot0.viewParam
	slot1 = slot0.buyinfo.isPowerPotion

	gohelper.setActive(slot0._txtremaincount.gameObject, not slot1)
	gohelper.setActive(slot0._toggletip.gameObject, slot1)
	slot0:refreshCenterTip()

	slot0.addPowerSuccess = false
	slot0._buyDiamondStep = 0

	NavigateMgr.instance:addEscape(slot0.viewName, slot0._btncloseOnClick, slot0)
end

function slot0.refreshCenterTip(slot0)
	if not slot0.buyinfo.isPowerPotion then
		slot0._powerMaxBuyCount = CommonConfig.instance:getConstNum(ConstEnum.PowerMaxBuyCountId)
		slot0._costParamList = GameUtil.splitString2(CommonConfig.instance:getConstStr(ConstEnum.PowerBuyCostId), true)
		slot0._costParam = slot0._costParamList[slot0._powerMaxBuyCount - CurrencyModel.instance.powerCanBuyCount + 1]

		if slot0._costParam == nil then
			slot0._costParam = slot0._costParamList[#slot0._costParamList]
		end

		if LangSettings.instance:isEn() then
			slot0._txtbuytip.text = string.format("%s(%s)", GameUtil.getSubPlaceholderLuaLang(luaLang("powerbuy_tip"), {
				slot0._costParam[3],
				ItemModel.instance:getItemConfig(slot0._costParam[1], slot0._costParam[2]).name,
				PlayerConfig.instance:getPlayerLevelCO(PlayerModel.instance:getPlayinfo().level).addBuyRecoverPower
			}), string.format(luaLang("powerbuy_remaincount"), CurrencyModel.instance.powerCanBuyCount))
		else
			slot0._txtbuytip.text = string.format("%s（%s）", slot6, string.format(luaLang("powerbuy_remaincount"), CurrencyModel.instance.powerCanBuyCount))
		end

		slot0._txtremaincount.text = luaLang("powerbuy_tip_3")
	elseif slot0.buyinfo.type == MaterialEnum.PowerType.Small then
		slot0._txtbuytip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("powerbuy_tip"), {
			"",
			luaLang("power_item1_name"),
			60
		})
	elseif slot0.buyinfo.type == MaterialEnum.PowerType.Big then
		slot0._txtbuytip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("powerbuy_tip"), {
			"",
			luaLang("power_item2_name"),
			120
		})
	end
end

function slot0.onClose(slot0)
	if slot0.addPowerSuccess then
		return
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagetipbg:UnLoadImage()
end

return slot0
