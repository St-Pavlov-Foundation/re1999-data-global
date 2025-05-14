module("modules.logic.store.view.recommend.StoreSkinBagView", package.seeall)

local var_0_0 = class("StoreSkinBagView", GiftrecommendViewBase)

function var_0_0._getCostSymbolAndPrice(arg_1_0, arg_1_1)
	if not arg_1_1 or arg_1_1 == "" then
		return
	end

	local var_1_0 = string.splitToNumber(arg_1_1, "#")

	if type(var_1_0) ~= "table" and #var_1_0 < 2 then
		return
	end

	local var_1_1 = var_1_0[2]
	local var_1_2 = PayModel.instance:getProductOriginPriceSymbol(var_1_1)
	local var_1_3, var_1_4, var_1_5 = PayModel.instance:getProductOriginPriceNum(var_1_1)

	return var_1_2, var_1_4
end

function var_0_0.onInitView(arg_2_0)
	arg_2_0._simagebg = gohelper.findChildSingleImage(arg_2_0.viewGO, "view/#simage_bg")
	arg_2_0._txtdurationTime = gohelper.findChildText(arg_2_0.viewGO, "view/time/#txt_durationTime")
	arg_2_0._btnbuy = gohelper.findChildButtonWithAudio(arg_2_0.viewGO, "view/#btn_buy")

	if arg_2_0._editableInitView then
		arg_2_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_3_0)
	arg_3_0._btnbuy:AddClickListener(arg_3_0._btnbuyOnClick, arg_3_0)
end

function var_0_0.removeEvents(arg_4_0)
	arg_4_0._btnbuy:RemoveClickListener()
end

function var_0_0._btnbuyOnClick(arg_5_0)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = tostring(arg_5_0.config and arg_5_0.config.id or ""),
		[StatEnum.EventProperties.RecommendPageName] = arg_5_0.config and arg_5_0.config.name or "StoreSkinBagView"
	})
	GameFacade.jumpByAdditionParam(arg_5_0.config.systemJumpCode)
end

function var_0_0._editableInitView(arg_6_0)
	var_0_0.super._editableInitView(arg_6_0)

	arg_6_0._pricetxtnum = gohelper.findChildText(arg_6_0.viewGO, "view/pricetxt/pricetxtnum")
	arg_6_0._pricetxticon = gohelper.findChildText(arg_6_0.viewGO, "view/pricetxt/pricetxtnum/pricetxticon")

	local var_6_0, var_6_1 = arg_6_0:_getCostSymbolAndPrice(arg_6_0.config.systemJumpCode)

	arg_6_0._pricetxtnum.text = ""
	arg_6_0._pricetxticon.text = ""

	if not string.nilorempty(var_6_0) then
		arg_6_0._pricetxticon.text = var_6_0
	end

	if not string.nilorempty(var_6_1) then
		arg_6_0._pricetxtnum.text = var_6_1
	end
end

function var_0_0.onOpen(arg_7_0)
	arg_7_0.config = arg_7_0.config or StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.StoreSkinBagView)

	var_0_0.super.onOpen(arg_7_0)
end

function var_0_0.onClose(arg_8_0)
	var_0_0.super.onClose(arg_8_0)
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0._txtdurationTime.text = StoreController.instance:getRecommendStoreTime(arg_9_0.config)
end

function var_0_0.onDestroyView(arg_10_0)
	var_0_0.super.onDestroyView(arg_10_0)
end

return var_0_0
