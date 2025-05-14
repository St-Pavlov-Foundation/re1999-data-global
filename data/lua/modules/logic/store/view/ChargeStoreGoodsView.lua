module("modules.logic.store.view.ChargeStoreGoodsView", package.seeall)

local var_0_0 = class("ChargeStoreGoodsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_leftbg")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_rightbg")
	arg_1_0._txtsalePrice = gohelper.findChildText(arg_1_0.viewGO, "buy/cost/#txt_salePrice")
	arg_1_0._txtgoodsNameCn = gohelper.findChildText(arg_1_0.viewGO, "propinfo/#txt_goodsNameCn")
	arg_1_0._txtgoodsNameEn = gohelper.findChildText(arg_1_0.viewGO, "propinfo/#txt_goodsNameEn")
	arg_1_0._txtgoodsDesc = gohelper.findChildText(arg_1_0.viewGO, "propinfo/goodsDesc/Viewport/Content/#txt_goodsDesc")
	arg_1_0._txtgoodsHave = gohelper.findChildText(arg_1_0.viewGO, "propinfo/#txt_goodsHave")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "propinfo/#go_item")
	arg_1_0._txtitemcount = gohelper.findChildText(arg_1_0.viewGO, "propinfo/#go_item/#txt_itemcount")
	arg_1_0._txtvalue = gohelper.findChildText(arg_1_0.viewGO, "buy/valuebg/#txt_value")
	arg_1_0._btncharge = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "buy/#btn_charge")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "propinfo/#btn_click")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "propinfo/#simage_icon")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncharge:AddClickListener(arg_2_0._btnchargeOnClick, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncharge:RemoveClickListener()
	arg_3_0._btnclick:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	MaterialTipController.instance:showMaterialInfo(arg_4_0._itemType, arg_4_0._itemId)
end

function var_0_0._btnchargeOnClick(arg_5_0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)
	PayController.instance:startPay(arg_5_0._mo.id)
end

function var_0_0._editableInitView(arg_6_0)
	arg_6_0._simageleftbg:LoadImage(ResUrl.getStoreBottomBgIcon("bg_1"))
	arg_6_0._simagerightbg:LoadImage(ResUrl.getStoreBottomBgIcon("bg_2"))
end

function var_0_0._refreshUI(arg_7_0)
	local var_7_0 = arg_7_0._mo.config.product
	local var_7_1 = string.splitToNumber(var_7_0, "#")

	arg_7_0._itemType = var_7_1[1]
	arg_7_0._itemId = var_7_1[2]
	arg_7_0._itemQuantity = var_7_1[3]

	local var_7_2, var_7_3 = ItemModel.instance:getItemConfigAndIcon(arg_7_0._itemType, arg_7_0._itemId, true)

	arg_7_0._simageicon:LoadImage(var_7_3)
	gohelper.setActive(arg_7_0._goitem, arg_7_0._itemQuantity > 1)

	arg_7_0._txtitemcount.text = GameUtil.numberDisplay(arg_7_0._itemQuantity)
	arg_7_0._txtgoodsNameCn.text = var_7_2.name
	arg_7_0._txtgoodsDesc.text = var_7_2.useDesc
	arg_7_0._txtsalePrice.text = string.format("%s%s", StoreModel.instance:getCostStr(arg_7_0._mo.config.price))
end

function var_0_0.onOpen(arg_8_0)
	arg_8_0._mo = arg_8_0.viewParam

	arg_8_0:addEventCb(PayController.instance, PayEvent.PayFinished, arg_8_0._payFinished, arg_8_0)
	arg_8_0:_refreshUI()
end

function var_0_0._payFinished(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0.onClose(arg_10_0)
	arg_10_0:removeEventCb(PayController.instance, PayEvent.PayFinished, arg_10_0._payFinished, arg_10_0)
end

function var_0_0.onUpdateParam(arg_11_0)
	arg_11_0._mo = arg_11_0.viewParam

	arg_11_0:_refreshUI()
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._simageleftbg:UnLoadImage()
	arg_12_0._simagerightbg:UnLoadImage()
	arg_12_0._simageicon:UnLoadImage()
end

return var_0_0
