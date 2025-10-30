module("modules.logic.store.view.recommend.StoreNew6StarsChooseView", package.seeall)

local var_0_0 = class("StoreNew6StarsChooseView", StoreRecommendBaseSubView)

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
	local var_1_3, var_1_4 = PayModel.instance:getProductOriginPriceNum(var_1_1)
	local var_1_5 = ""

	if string.nilorempty(var_1_2) then
		local var_1_6 = string.reverse(var_1_4)
		local var_1_7 = string.find(var_1_6, "%d")
		local var_1_8 = string.len(var_1_6) - var_1_7 + 1
		local var_1_9 = string.sub(var_1_4, var_1_8 + 1, string.len(var_1_4))

		var_1_4 = string.sub(var_1_4, 1, var_1_8)

		return string.format("%s<size=50>%s</size>", var_1_4, var_1_9)
	else
		return string.format("<size=50>%s</size>%s", var_1_2, var_1_4)
	end
end

function var_0_0.ctor(arg_2_0, ...)
	var_0_0.super.ctor(arg_2_0, ...)

	arg_2_0.config = StoreConfig.instance:getStoreRecommendConfig(StoreEnum.RecommendSubStoreId.New6StarsChoose)
end

function var_0_0.onInitView(arg_3_0)
	arg_3_0._txtduration = gohelper.findChildText(arg_3_0.viewGO, "recommend/txt_tips/#txt_duration")
	arg_3_0._imageAttr1 = gohelper.findChildImage(arg_3_0.viewGO, "recommend/Name1/#image_Attr")
	arg_3_0._txtName1 = gohelper.findChildText(arg_3_0.viewGO, "recommend/Name1/#txt_Name")
	arg_3_0._imageAttr2 = gohelper.findChildImage(arg_3_0.viewGO, "recommend/Name2/#image_Attr")
	arg_3_0._txtName2 = gohelper.findChildText(arg_3_0.viewGO, "recommend/Name2/#txt_Name")
	arg_3_0._imageAttr3 = gohelper.findChildImage(arg_3_0.viewGO, "recommend/Name3/#image_Attr")
	arg_3_0._txtName3 = gohelper.findChildText(arg_3_0.viewGO, "recommend/Name3/#txt_Name")
	arg_3_0._txtChar = gohelper.findChildText(arg_3_0.viewGO, "recommend/image_Char/#txt_Char")
	arg_3_0._txtProp = gohelper.findChildText(arg_3_0.viewGO, "recommend/image_Prop/#txt_Prop")

	if arg_3_0._editableInitView then
		arg_3_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_4_0)
	return
end

function var_0_0.removeEvents(arg_5_0)
	if arg_5_0._clickBuy then
		arg_5_0._clickBuy:RemoveClickListener()
	end
end

function var_0_0._btnbuyOnClick(arg_6_0)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = tostring(arg_6_0.config and arg_6_0.config.id or ""),
		[StatEnum.EventProperties.RecommendPageName] = arg_6_0.config and arg_6_0.config.name or arg_6_0.__cname,
		[StatEnum.EventProperties.RecommendPageRank] = arg_6_0:getTabIndex()
	})

	local var_6_0 = string.splitToNumber(arg_6_0.config.systemJumpCode, "#")

	if var_6_0[2] then
		local var_6_1 = var_6_0[2]
		local var_6_2 = StoreModel.instance:getGoodsMO(var_6_1)

		StoreController.instance:openPackageStoreGoodsView(var_6_2)
	else
		GameFacade.jumpByAdditionParam(arg_6_0.config.systemJumpCode)
	end
end

function var_0_0._editableInitView(arg_7_0)
	var_0_0.super._editableInitView(arg_7_0)

	arg_7_0._txtNum = gohelper.findChildText(arg_7_0.viewGO, "recommend/Buy/txt_Num")

	local var_7_0 = arg_7_0:_getCostSymbolAndPrice(arg_7_0.config.systemJumpCode)

	arg_7_0._txtNum.text = var_7_0 or ""

	local var_7_1 = gohelper.findChild(arg_7_0.viewGO, "recommend/Buy")

	arg_7_0._clickBuy = SLFramework.UGUI.UIClickListener.Get(var_7_1)

	arg_7_0._clickBuy:AddClickListener(arg_7_0._btnbuyOnClick, arg_7_0)
end

function var_0_0.onOpen(arg_8_0)
	var_0_0.super.onOpen(arg_8_0)
	arg_8_0:addEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, arg_8_0.refreshUI, arg_8_0)
	arg_8_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_8_0.refreshUI, arg_8_0)
	arg_8_0:refreshUI()
end

function var_0_0.onClose(arg_9_0)
	arg_9_0:removeEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, arg_9_0.refreshUI, arg_9_0)
	arg_9_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_9_0.refreshUI, arg_9_0)
end

function var_0_0.refreshUI(arg_10_0)
	arg_10_0._txtduration.text = StoreController.instance:getRecommendStoreTime(arg_10_0.config)
end

return var_0_0
