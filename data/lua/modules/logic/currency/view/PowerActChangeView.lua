module("modules.logic.currency.view.PowerActChangeView", package.seeall)

local var_0_0 = class("PowerActChangeView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "decorate/#simage_rightbg")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "decorate/#simage_leftbg")
	arg_1_0._txtleftproductname = gohelper.findChildText(arg_1_0.viewGO, "left/#txt_leftproductname")
	arg_1_0._simageleftproduct = gohelper.findChildSingleImage(arg_1_0.viewGO, "left/leftproduct_icon")
	arg_1_0._txtrightproductname = gohelper.findChildText(arg_1_0.viewGO, "right/#txt_rightproductname")
	arg_1_0._gobuy = gohelper.findChild(arg_1_0.viewGO, "#go_buy")
	arg_1_0._inputvalue = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "#go_buy/valuebg/#input_value")
	arg_1_0._btnmin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buy/#btn_min")
	arg_1_0._btnsub = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buy/#btn_sub")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buy/#btn_add")
	arg_1_0._btnmax = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buy/#btn_max")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_buy/#btn_buy")
	arg_1_0._imagecosticon = gohelper.findChildImage(arg_1_0.viewGO, "#go_buy/cost/#simage_costicon")
	arg_1_0._txtoriginalCost = gohelper.findChildText(arg_1_0.viewGO, "#go_buy/cost/#txt_originalCost")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnmin:AddClickListener(arg_2_0._btnminOnClick, arg_2_0)
	arg_2_0._btnsub:AddClickListener(arg_2_0._btnsubOnClick, arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
	arg_2_0._btnmax:AddClickListener(arg_2_0._btnmaxOnClick, arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnmin:RemoveClickListener()
	arg_3_0._btnsub:RemoveClickListener()
	arg_3_0._btnadd:RemoveClickListener()
	arg_3_0._btnmax:RemoveClickListener()
	arg_3_0._btnbuy:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
end

function var_0_0._btnminOnClick(arg_4_0)
	arg_4_0:changeUseCount(1)
end

function var_0_0._btnsubOnClick(arg_5_0)
	if arg_5_0.buyCount < 2 then
		return
	end

	arg_5_0:changeUseCount(arg_5_0.buyCount - 1)
end

function var_0_0._btnaddOnClick(arg_6_0)
	if arg_6_0.buyCount >= arg_6_0.maxBuyCount then
		return
	end

	arg_6_0:changeUseCount(arg_6_0.buyCount + 1)
end

function var_0_0._btnmaxOnClick(arg_7_0)
	arg_7_0:changeUseCount(arg_7_0.maxBuyCount)
end

function var_0_0._btnbuyOnClick(arg_8_0)
	local var_8_0 = ItemPowerModel.instance:getUsePower(arg_8_0._powerId, arg_8_0.buyCount)

	ItemRpc.instance:sendUsePowerItemListRequest(var_8_0)
	BackpackController.instance:dispatchEvent(BackpackEvent.BeforeUsePowerPotionList)

	if arg_8_0._powerId == MaterialEnum.PowerId.OverflowPowerId then
		ItemRpc.instance:sendGetPowerMakerInfoRequest()
	end
end

function var_0_0.changeUseCount(arg_9_0, arg_9_1)
	arg_9_0._inputvalue:SetText(arg_9_1)

	if arg_9_1 == arg_9_0.buyCount then
		return
	end

	arg_9_0.buyCount = arg_9_1

	arg_9_0:refreshUI()
end

function var_0_0._btncloseOnClick(arg_10_0)
	arg_10_0:closeThis()
end

function var_0_0.onClickBg(arg_11_0)
	arg_11_0:closeThis()
end

function var_0_0.onCountValueChange(arg_12_0, arg_12_1)
	local var_12_0 = tonumber(arg_12_1)

	if not var_12_0 then
		return
	end

	if var_12_0 < 1 then
		var_12_0 = 1
	end

	if var_12_0 > arg_12_0.maxBuyCount then
		var_12_0 = arg_12_0.maxBuyCount
	end

	arg_12_0:changeUseCount(var_12_0)
end

function var_0_0._editableInitView(arg_13_0)
	arg_13_0.bgClick = gohelper.findChildClickWithDefaultAudio(arg_13_0.viewGO, "Mask")

	arg_13_0.bgClick:AddClickListener(arg_13_0.onClickBg, arg_13_0)
	arg_13_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_13_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	arg_13_0._inputvalue:AddOnValueChanged(arg_13_0.onCountValueChange, arg_13_0)
	arg_13_0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, arg_13_0.onCurrencyChange, arg_13_0)
	arg_13_0:addEventCb(ActivityController.instance, ActivityEvent.RefreshActivityState, arg_13_0.onRefreshActivity, arg_13_0)
	arg_13_0:addEventCb(BackpackController.instance, BackpackEvent.UsePowerPotionListFinish, arg_13_0._onUsePowerPotionListFinish, arg_13_0)
	NavigateMgr.instance:addEscape(arg_13_0.viewName, arg_13_0.closeThis, arg_13_0)
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0._powerId = arg_14_0.viewParam and arg_14_0.viewParam.PowerId or MaterialEnum.PowerId.ActPowerId
	arg_14_0.actPowerConfig = ItemConfig.instance:getPowerItemCo(arg_14_0._powerId)
	arg_14_0.powerConfig = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	arg_14_0.currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Power)
	arg_14_0.oneActPowerEffect = arg_14_0.actPowerConfig.effect

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_14_0._imagecosticon, arg_14_0._powerId .. "_1")
	arg_14_0._simageleftproduct:LoadImage(ResUrl.getPropItemIcon(arg_14_0.actPowerConfig.icon))

	arg_14_0.buyCount = 1

	arg_14_0:updateMaxBuyCount()
	arg_14_0._inputvalue:SetText(arg_14_0.buyCount)
	arg_14_0:refreshUI()
end

function var_0_0.updateMaxBuyCount(arg_15_0)
	local var_15_0 = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power).maxLimit - arg_15_0.currencyMO.quantity
	local var_15_1 = math.floor(var_15_0 / arg_15_0.oneActPowerEffect)

	arg_15_0.maxBuyCount = math.min(var_15_1, ItemPowerModel.instance:getPowerCount(arg_15_0._powerId))
end

function var_0_0.refreshUI(arg_16_0)
	arg_16_0:refreshLeftItem()
	arg_16_0:refreshRightItem()
	arg_16_0:showOriginalCostTxt(arg_16_0.buyCount, arg_16_0.maxBuyCount)
end

function var_0_0.refreshLeftItem(arg_17_0)
	arg_17_0._txtleftproductname.text = GameUtil.getSubPlaceholderLuaLang(luaLang("poweractchangeview_productNameFormat"), {
		arg_17_0.actPowerConfig.name,
		arg_17_0.buyCount
	})
end

function var_0_0.refreshRightItem(arg_18_0)
	arg_18_0._txtrightproductname.text = GameUtil.getSubPlaceholderLuaLang(luaLang("poweractchangeview_productNameFormat"), {
		arg_18_0.powerConfig.name,
		arg_18_0.buyCount * arg_18_0.oneActPowerEffect
	})
end

function var_0_0.onCurrencyChange(arg_19_0, arg_19_1)
	if arg_19_1 and not arg_19_1[CurrencyEnum.CurrencyType.Power] then
		return
	end

	arg_19_0:updateMaxBuyCount()
	arg_19_0:showOriginalCostTxt(arg_19_0.buyCount, arg_19_0.maxBuyCount)

	if arg_19_0.buyCount > arg_19_0.maxBuyCount then
		arg_19_0:changeUseCount(arg_19_0.maxBuyCount)
	end
end

function var_0_0.showOriginalCostTxt(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0._txtoriginalCost.text = string.format("<color=#ab4211>%s</color><color=#494440>/%s</color>", arg_20_1, arg_20_2)
end

function var_0_0.onRefreshActivity(arg_21_0, arg_21_1)
	if arg_21_1 ~= MaterialEnum.ActPowerBindActId then
		return
	end

	local var_21_0 = ActivityHelper.getActivityStatus(arg_21_1)
	local var_21_1 = ItemPowerModel.instance:getPowerCount(arg_21_0._powerId)

	if var_21_0 ~= ActivityEnum.ActivityStatus.Normal then
		if var_21_1 < 1 then
			arg_21_0:closeThis()

			return
		end

		if ItemPowerModel.instance:getPowerMinExpireTimeOffset(arg_21_0._powerId) <= 0 then
			arg_21_0:closeThis()
		end
	end
end

function var_0_0._onUsePowerPotionListFinish(arg_22_0)
	arg_22_0:closeThis()
end

function var_0_0.onClose(arg_23_0)
	arg_23_0.bgClick:RemoveClickListener()
end

function var_0_0.onDestroyView(arg_24_0)
	arg_24_0._simagerightbg:UnLoadImage()
	arg_24_0._simageleftbg:UnLoadImage()
	arg_24_0._simageleftproduct:UnLoadImage()
	arg_24_0._inputvalue:RemoveOnValueChanged()
end

return var_0_0
