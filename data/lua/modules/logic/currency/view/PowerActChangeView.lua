module("modules.logic.currency.view.PowerActChangeView", package.seeall)

slot0 = class("PowerActChangeView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "decorate/#simage_rightbg")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "decorate/#simage_leftbg")
	slot0._txtleftproductname = gohelper.findChildText(slot0.viewGO, "left/#txt_leftproductname")
	slot0._txtrightproductname = gohelper.findChildText(slot0.viewGO, "right/#txt_rightproductname")
	slot0._gobuy = gohelper.findChild(slot0.viewGO, "#go_buy")
	slot0._inputvalue = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_buy/valuebg/#input_value")
	slot0._btnmin = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buy/#btn_min")
	slot0._btnsub = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buy/#btn_sub")
	slot0._btnadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buy/#btn_add")
	slot0._btnmax = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buy/#btn_max")
	slot0._btnbuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buy/#btn_buy")
	slot0._simagecosticon = gohelper.findChildSingleImage(slot0.viewGO, "#go_buy/cost/#simage_costicon")
	slot0._txtoriginalCost = gohelper.findChildText(slot0.viewGO, "#go_buy/cost/#txt_originalCost")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnmin:AddClickListener(slot0._btnminOnClick, slot0)
	slot0._btnsub:AddClickListener(slot0._btnsubOnClick, slot0)
	slot0._btnadd:AddClickListener(slot0._btnaddOnClick, slot0)
	slot0._btnmax:AddClickListener(slot0._btnmaxOnClick, slot0)
	slot0._btnbuy:AddClickListener(slot0._btnbuyOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnmin:RemoveClickListener()
	slot0._btnsub:RemoveClickListener()
	slot0._btnadd:RemoveClickListener()
	slot0._btnmax:RemoveClickListener()
	slot0._btnbuy:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btnminOnClick(slot0)
	slot0:changeUseCount(1)
end

function slot0._btnsubOnClick(slot0)
	if slot0.buyCount < 2 then
		return
	end

	slot0:changeUseCount(slot0.buyCount - 1)
end

function slot0._btnaddOnClick(slot0)
	if slot0.maxBuyCount <= slot0.buyCount then
		return
	end

	slot0:changeUseCount(slot0.buyCount + 1)
end

function slot0._btnmaxOnClick(slot0)
	slot0:changeUseCount(slot0.maxBuyCount)
end

function slot0._btnbuyOnClick(slot0)
	ItemRpc.instance:sendUsePowerItemListRequest(ItemPowerModel.instance:getUsePower(MaterialEnum.PowerId.ActPowerId, slot0.buyCount))
	BackpackController.instance:dispatchEvent(BackpackEvent.BeforeUsePowerPotionList)
end

function slot0.changeUseCount(slot0, slot1)
	slot0._inputvalue:SetText(slot1)

	if slot1 == slot0.buyCount then
		return
	end

	slot0.buyCount = slot1

	slot0:refreshUI()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.onClickBg(slot0)
	slot0:closeThis()
end

function slot0.onCountValueChange(slot0, slot1)
	if not tonumber(slot1) then
		return
	end

	if slot2 < 1 then
		slot2 = 1
	end

	if slot0.maxBuyCount < slot2 then
		slot2 = slot0.maxBuyCount
	end

	slot0:changeUseCount(slot2)
end

function slot0._editableInitView(slot0)
	slot0.bgClick = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "Mask")

	slot0.bgClick:AddClickListener(slot0.onClickBg, slot0)
	slot0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	slot0._inputvalue:AddOnValueChanged(slot0.onCountValueChange, slot0)
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.onCurrencyChange, slot0)
	slot0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, slot0.onRefreshActivity, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UsePowerPotionListFinish, slot0._onUsePowerPotionListFinish, slot0)
	NavigateMgr.instance:addEscape(slot0.viewName, slot0.closeThis, slot0)
end

function slot0.onOpen(slot0)
	slot0.actPowerConfig = ItemConfig.instance:getPowerItemCo(MaterialEnum.PowerId.ActPowerId)
	slot0.powerConfig = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	slot0.currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Power)
	slot0.oneActPowerEffect = slot0.actPowerConfig.effect
	slot0.buyCount = 1

	slot0:updateMaxBuyCount()
	slot0._inputvalue:SetText(slot0.buyCount)
	slot0:refreshUI()
end

function slot0.updateMaxBuyCount(slot0)
	slot0.maxBuyCount = math.min(math.floor((CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power).maxLimit - slot0.currencyMO.quantity) / slot0.oneActPowerEffect), ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.ActPowerId))
end

function slot0.refreshUI(slot0)
	slot0:refreshLeftItem()
	slot0:refreshRightItem()
	slot0:showOriginalCostTxt(slot0.buyCount, slot0.maxBuyCount)
end

function slot0.refreshLeftItem(slot0)
	slot0._txtleftproductname.text = GameUtil.getSubPlaceholderLuaLang(luaLang("poweractchangeview_productNameFormat"), {
		slot0.actPowerConfig.name,
		slot0.buyCount
	})
end

function slot0.refreshRightItem(slot0)
	slot0._txtrightproductname.text = GameUtil.getSubPlaceholderLuaLang(luaLang("poweractchangeview_productNameFormat"), {
		slot0.powerConfig.name,
		slot0.buyCount * slot0.oneActPowerEffect
	})
end

function slot0.onCurrencyChange(slot0, slot1)
	if slot1 and not slot1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	slot0:updateMaxBuyCount()
	slot0:showOriginalCostTxt(slot0.buyCount, slot0.maxBuyCount)

	if slot0.maxBuyCount < slot0.buyCount then
		slot0:changeUseCount(slot0.maxBuyCount)
	end
end

function slot0.showOriginalCostTxt(slot0, slot1, slot2)
	slot0._txtoriginalCost.text = string.format("<color=#ab4211>%s</color><color=#494440>/%s</color>", slot1, slot2)
end

function slot0.onRefreshActivity(slot0, slot1)
	if slot1 ~= MaterialEnum.ActPowerBindActId then
		return
	end

	if ActivityHelper.getActivityStatus(slot1) ~= ActivityEnum.ActivityStatus.Normal then
		if ItemPowerModel.instance:getPowerCount(MaterialEnum.PowerId.ActPowerId) < 1 then
			slot0:closeThis()

			return
		end

		if ItemPowerModel.instance:getPowerMinExpireTimeOffset(MaterialEnum.PowerId.ActPowerId) <= 0 then
			slot0:closeThis()
		end
	end
end

function slot0._onUsePowerPotionListFinish(slot0)
	slot0:closeThis()
end

function slot0.onClose(slot0)
	slot0.bgClick:RemoveClickListener()
end

function slot0.onDestroyView(slot0)
	slot0._simagerightbg:UnLoadImage()
	slot0._simageleftbg:UnLoadImage()
	slot0._inputvalue:RemoveOnValueChanged()
end

return slot0
