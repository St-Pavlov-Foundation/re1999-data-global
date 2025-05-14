module("modules.logic.store.view.recommend.GiftrecommendView815", package.seeall)

local var_0_0 = class("GiftrecommendView815", StoreRecommendBaseSubView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simagebg = gohelper.findChildSingleImage(arg_1_0.viewGO, "view/#simage_bg")
	arg_1_0._txtduration = gohelper.findChildText(arg_1_0.viewGO, "view/txt_tips/#txt_duration")
	arg_1_0._txtprice3 = gohelper.findChildText(arg_1_0.viewGO, "view/right/#txt_price3")
	arg_1_0._btnbuy3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "view/right/#btn_buy3")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnbuy3:AddClickListener(arg_2_0._btnbuy3OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnbuy3:RemoveClickListener()
end

function var_0_0._btnbuy3OnClick(arg_4_0)
	if arg_4_0._isBought3 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	if arg_4_0._systemJumpCode3 then
		GameFacade.jumpByAdditionParam(arg_4_0._systemJumpCode3)
	end
end

function var_0_0._getIsBought(arg_5_0, arg_5_1)
	if not arg_5_1 then
		return false
	end

	local var_5_0 = arg_5_1[1]
	local var_5_1 = arg_5_1[2]

	if not var_5_0 or not var_5_1 then
		return false
	end

	local var_5_2 = StoreModel.instance:getGoodsMO(var_5_1)

	if var_5_2 == nil or var_5_2:isSoldOut() then
		return true
	end

	return false
end

function var_0_0.onOpen(arg_6_0)
	var_0_0.super.onOpen(arg_6_0)
	arg_6_0:_refreshUI()
	arg_6_0:addEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, arg_6_0._refreshUI, arg_6_0)
	arg_6_0:addEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_6_0._refreshUI, arg_6_0)
end

function var_0_0._refreshUI(arg_7_0)
	arg_7_0._txtprice3.text = ""

	if arg_7_0.config == nil then
		return
	end

	arg_7_0._systemJumpCode3 = arg_7_0.config.systemJumpCode

	if arg_7_0._systemJumpCode3 then
		local var_7_0 = arg_7_0:_getCostSymbolAndPrice(arg_7_0._systemJumpCode3)

		if var_7_0 then
			arg_7_0._txtprice3.text = var_7_0
		end
	end

	if not string.nilorempty(arg_7_0.config.relations) then
		local var_7_1 = GameUtil.splitString2(arg_7_0.config.relations, true)

		if type(var_7_1) == "table" then
			arg_7_0._isBought3 = arg_7_0:_getIsBought(var_7_1[3])
		end
	end

	arg_7_0._txtduration.text = StoreController.instance:getRecommendStoreTime(arg_7_0.config)
end

function var_0_0._getCostSymbolAndPrice(arg_8_0, arg_8_1)
	if not arg_8_1 or arg_8_1 == "" then
		return
	end

	local var_8_0 = string.splitToNumber(arg_8_1, "#")

	if type(var_8_0) ~= "table" and #var_8_0 < 2 then
		return
	end

	local var_8_1 = var_8_0[2]
	local var_8_2 = PayModel.instance:getProductOriginPriceSymbol(var_8_1)
	local var_8_3, var_8_4 = PayModel.instance:getProductOriginPriceNum(var_8_1)
	local var_8_5 = ""

	if string.nilorempty(var_8_2) then
		local var_8_6 = string.reverse(var_8_4)
		local var_8_7 = string.find(var_8_6, "%d")
		local var_8_8 = string.len(var_8_6) - var_8_7 + 1
		local var_8_9 = string.sub(var_8_4, var_8_8 + 1, string.len(var_8_4))

		var_8_4 = string.sub(var_8_4, 1, var_8_8)

		return string.format("%s<size=50>%s</size>", var_8_4, var_8_9)
	else
		return string.format("<size=50>%s</size>%s", var_8_2, var_8_4)
	end
end

function var_0_0.onClose(arg_9_0)
	var_0_0.super.onClose(arg_9_0)
	arg_9_0:removeEventCb(StoreController.instance, StoreEvent.UpdatePackageStore, arg_9_0._refreshUI, arg_9_0)
	arg_9_0:removeEventCb(StoreController.instance, StoreEvent.StoreInfoChanged, arg_9_0._refreshUI, arg_9_0)
end

return var_0_0
