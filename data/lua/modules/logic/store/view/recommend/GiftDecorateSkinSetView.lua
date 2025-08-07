module("modules.logic.store.view.recommend.GiftDecorateSkinSetView", package.seeall)

local var_0_0 = class("GiftDecorateSkinSetView", StoreRecommendBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/#simage_bg")
	arg_1_0._simagedec = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/Left/#simage_dec")
	arg_1_0._btnlook = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/Left/#btn_look")
	arg_1_0._txtduration = gohelper.findChildText(arg_1_0.viewGO, "view/Right/txt_tips/#txt_duration")
	arg_1_0._txtprice = gohelper.findChildText(arg_1_0.viewGO, "view/Right/#txt_price")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/Right/#btn_buy")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	if arg_2_0._btnlook then
		arg_2_0._btnlook:AddClickListener(arg_2_0._btnlookOnClick, arg_2_0)
	end

	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	if arg_3_0._btnlook then
		arg_3_0._btnlook:RemoveClickListener()
	end

	arg_3_0._btnbuy:RemoveClickListener()
end

function var_0_0._btnlookOnClick(arg_4_0)
	arg_4_0:_jumpByIndex(2)
end

function var_0_0._btnbuyOnClick(arg_5_0)
	arg_5_0:_jumpByIndex(1)
end

function var_0_0.onOpen(arg_6_0)
	var_0_0.super.onOpen(arg_6_0)

	arg_6_0._systyemjumpList = string.split(arg_6_0.config.systemJumpCode, " ")

	arg_6_0:refreshUI()
end

function var_0_0._jumpByIndex(arg_7_0, arg_7_1)
	if arg_7_0:_isBought() then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	StatController.instance:track(StatEnum.EventName.ClickRecommendPage, {
		[StatEnum.EventProperties.RecommendPageType] = StatEnum.RecommendType.Store,
		[StatEnum.EventProperties.RecommendPageId] = tostring(arg_7_0.config and arg_7_0.config.id or ""),
		[StatEnum.EventProperties.RecommendPageName] = arg_7_0.config and arg_7_0.config.name or "GiftDecorateSkinSetView"
	})

	if arg_7_0._systyemjumpList and arg_7_0._systyemjumpList[arg_7_1] then
		GameFacade.jumpByAdditionParam(arg_7_0._systyemjumpList[arg_7_1])
	end
end

function var_0_0._getIsBought(arg_8_0, arg_8_1)
	if not arg_8_1 then
		return false
	end

	local var_8_0 = arg_8_1[1]
	local var_8_1 = arg_8_1[2]

	if not var_8_0 or not var_8_1 then
		return false
	end

	local var_8_2 = StoreModel.instance:getGoodsMO(var_8_1)

	if var_8_2 == nil or var_8_2:isSoldOut() then
		return true
	end

	return false
end

function var_0_0._isBought(arg_9_0)
	if not string.nilorempty(arg_9_0.config.relations) then
		local var_9_0 = GameUtil.splitString2(arg_9_0.config.relations, true)

		if var_9_0[1] then
			return arg_9_0:_getIsBought(var_9_0[1])
		end
	end
end

function var_0_0.refreshUI(arg_10_0)
	if arg_10_0.config == nil then
		return
	end

	arg_10_0._txtduration.text = StoreController.instance:getRecommendStoreTime(arg_10_0.config)

	if arg_10_0._txtprice then
		local var_10_0, var_10_1 = arg_10_0:_getCostSymbolAndPrice(arg_10_0._systyemjumpList and arg_10_0._systyemjumpList[1])

		if var_10_0 then
			arg_10_0._txtprice.text = string.format("<size=48>%s</size>%s", var_10_0, var_10_1)
		end
	end
end

function var_0_0._getCostSymbolAndPrice(arg_11_0, arg_11_1)
	if not arg_11_1 or arg_11_1 == "" then
		return
	end

	local var_11_0 = string.splitToNumber(arg_11_1, "#")

	if type(var_11_0) ~= "table" or #var_11_0 < 2 then
		return
	end

	local var_11_1 = var_11_0[2]

	return PayModel.instance:getProductPrice(var_11_1), ""
end

return var_0_0
