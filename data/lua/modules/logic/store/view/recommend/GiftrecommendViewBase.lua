module("modules.logic.store.view.recommend.GiftrecommendViewBase", package.seeall)

local var_0_0 = class("GiftrecommendViewBase", StoreRecommendBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/#simage_bg")
	arg_1_0._txtduration = gohelper.findChildText(arg_1_0.viewGO, "view/txt_tips/#txt_duration")
	arg_1_0._txtprice1 = gohelper.findChildText(arg_1_0.viewGO, "view/left/#txt_price1")
	arg_1_0._btnbuy1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/left/#btn_buy1")
	arg_1_0._txtprice2 = gohelper.findChildText(arg_1_0.viewGO, "view/middle/#txt_price2")
	arg_1_0._btnbuy2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/middle/#btn_buy2")
	arg_1_0._txtprice3 = gohelper.findChildText(arg_1_0.viewGO, "view/right/#txt_price3")
	arg_1_0._btnbuy3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/right/#btn_buy3")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbuy1:AddClickListener(arg_2_0._btnbuy1OnClick, arg_2_0)
	arg_2_0._btnbuy2:AddClickListener(arg_2_0._btnbuy2OnClick, arg_2_0)
	arg_2_0._btnbuy3:AddClickListener(arg_2_0._btnbuy3OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbuy1:RemoveClickListener()
	arg_3_0._btnbuy2:RemoveClickListener()
	arg_3_0._btnbuy3:RemoveClickListener()
end

function var_0_0._btnbuy1OnClick(arg_4_0)
	if arg_4_0._isBought1 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	if arg_4_0._systemJumpCode1 then
		arg_4_0:statClick()

		local var_4_0 = string.splitToNumber(arg_4_0._systemJumpCode1, "#")[2]
		local var_4_1 = StoreConfig.instance:getChargeGoodsConfig(var_4_0)

		if var_4_1 and var_4_1.type == StoreEnum.StoreChargeType.Optional then
			module_views_preloader.OptionalChargeView(function()
				GameFacade.jumpByAdditionParam(arg_4_0._systemJumpCode1)
			end)
		else
			arg_4_0:_jumpToStoreGoodView(arg_4_0._systemJumpCode1)
		end
	end
end

function var_0_0._btnbuy2OnClick(arg_6_0)
	if arg_6_0._isBought2 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	if arg_6_0._systemJumpCode2 then
		arg_6_0:statClick()
		arg_6_0:_jumpToStoreGoodView(arg_6_0._systemJumpCode2)
	end
end

function var_0_0._btnbuy3OnClick(arg_7_0)
	if arg_7_0._isBought3 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	if arg_7_0._systemJumpCode3 then
		arg_7_0:statClick()
		arg_7_0:_jumpToStoreGoodView(arg_7_0._systemJumpCode3)
	end
end

function var_0_0._jumpToStoreGoodView(arg_8_0, arg_8_1)
	local var_8_0 = string.splitToNumber(arg_8_1, "#")[2]
	local var_8_1 = StoreModel.instance:getGoodsMO(var_8_0)

	StoreController.instance:openPackageStoreGoodsView(var_8_1)
end

function var_0_0.statClick(arg_9_0)
	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = tostring(arg_9_0.config and arg_9_0.config.id or ""),
		[StatEnum.EventProperties.RecommendPageName] = arg_9_0.config and arg_9_0.config.name or arg_9_0.__cname,
		[StatEnum.EventProperties.RecommendPageRank] = arg_9_0:getTabIndex()
	})
end

function var_0_0._getCostSymbolAndPrice(arg_10_0, arg_10_1)
	if not arg_10_1 or arg_10_1 == "" then
		return
	end

	local var_10_0 = string.splitToNumber(arg_10_1, "#")

	if type(var_10_0) ~= "table" and #var_10_0 < 2 then
		return
	end

	local var_10_1 = var_10_0[2]

	return PayModel.instance:getProductPrice(var_10_1), ""
end

function var_0_0._getIsBought(arg_11_0, arg_11_1)
	if not arg_11_1 then
		return false
	end

	local var_11_0 = arg_11_1[1]
	local var_11_1 = arg_11_1[2]

	if not var_11_0 or not var_11_1 then
		return false
	end

	local var_11_2 = StoreModel.instance:getGoodsMO(var_11_1)

	if var_11_2 == nil or var_11_2:isSoldOut() then
		return true
	end

	return false
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0._animator = arg_12_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_12_0._animatorPlayer = SLFramework.AnimatorPlayer.Get(arg_12_0.viewGO)
end

function var_0_0.onOpen(arg_13_0)
	var_0_0.super.onOpen(arg_13_0)
	arg_13_0:addEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, arg_13_0.refreshUI, arg_13_0)
	arg_13_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_13_0.refreshUI, arg_13_0)
	arg_13_0:refreshUI()
end

function var_0_0.refreshUI(arg_14_0)
	arg_14_0._txtprice1.text = ""
	arg_14_0._txtprice2.text = ""
	arg_14_0._txtprice3.text = ""

	if arg_14_0.config == nil then
		return
	end

	local var_14_0 = string.split(arg_14_0.config.systemJumpCode, " ")

	if var_14_0 then
		arg_14_0._systemJumpCode1 = var_14_0[1]
		arg_14_0._systemJumpCode2 = var_14_0[2]
		arg_14_0._systemJumpCode3 = var_14_0[3]

		local var_14_1, var_14_2 = arg_14_0:_getCostSymbolAndPrice(var_14_0[1])

		if var_14_1 then
			arg_14_0._txtprice1.text = string.format("%s%s", var_14_1, var_14_2)
		end

		local var_14_3, var_14_4 = arg_14_0:_getCostSymbolAndPrice(var_14_0[2])

		if var_14_3 then
			arg_14_0._txtprice2.text = string.format("%s%s", var_14_3, var_14_4)
		end

		local var_14_5, var_14_6 = arg_14_0:_getCostSymbolAndPrice(var_14_0[3])

		if var_14_5 then
			arg_14_0._txtprice3.text = string.format("%s%s", var_14_5, var_14_6)
		end
	end

	if not string.nilorempty(arg_14_0.config.relations) then
		local var_14_7 = GameUtil.splitString2(arg_14_0.config.relations, true)

		if type(var_14_7) == "table" then
			arg_14_0._isBought1 = arg_14_0:_getIsBought(var_14_7[1])
			arg_14_0._isBought2 = arg_14_0:_getIsBought(var_14_7[2])
			arg_14_0._isBought3 = arg_14_0:_getIsBought(var_14_7[3])
		end
	end

	arg_14_0._txtduration.text = StoreController.instance:getRecommendStoreTime(arg_14_0.config)
end

function var_0_0.onClose(arg_15_0)
	arg_15_0:removeEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, arg_15_0.refreshUI, arg_15_0)
	arg_15_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_15_0.refreshUI, arg_15_0)
end

function var_0_0.onDestroyView(arg_16_0)
	return
end

return var_0_0
