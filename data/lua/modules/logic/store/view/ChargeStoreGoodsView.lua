module("modules.logic.store.view.ChargeStoreGoodsView", package.seeall)

slot0 = class("ChargeStoreGoodsView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_leftbg")
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "#simage_rightbg")
	slot0._txtsalePrice = gohelper.findChildText(slot0.viewGO, "buy/cost/#txt_salePrice")
	slot0._txtgoodsNameCn = gohelper.findChildText(slot0.viewGO, "propinfo/#txt_goodsNameCn")
	slot0._txtgoodsNameEn = gohelper.findChildText(slot0.viewGO, "propinfo/#txt_goodsNameEn")
	slot0._txtgoodsDesc = gohelper.findChildText(slot0.viewGO, "propinfo/goodsDesc/Viewport/Content/#txt_goodsDesc")
	slot0._txtgoodsHave = gohelper.findChildText(slot0.viewGO, "propinfo/#txt_goodsHave")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "propinfo/#go_item")
	slot0._txtitemcount = gohelper.findChildText(slot0.viewGO, "propinfo/#go_item/#txt_itemcount")
	slot0._txtvalue = gohelper.findChildText(slot0.viewGO, "buy/valuebg/#txt_value")
	slot0._btncharge = gohelper.findChildButtonWithAudio(slot0.viewGO, "buy/#btn_charge")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "propinfo/#btn_click")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "propinfo/#simage_icon")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncharge:AddClickListener(slot0._btnchargeOnClick, slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncharge:RemoveClickListener()
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(slot0._itemType, slot0._itemId)
end

function slot0._btnchargeOnClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)
	PayController.instance:startPay(slot0._mo.id)
end

function slot0._editableInitView(slot0)
	slot0._simageleftbg:LoadImage(ResUrl.getStoreBottomBgIcon("bg_1"))
	slot0._simagerightbg:LoadImage(ResUrl.getStoreBottomBgIcon("bg_2"))
end

function slot0._refreshUI(slot0)
	slot2 = string.splitToNumber(slot0._mo.config.product, "#")
	slot0._itemType = slot2[1]
	slot0._itemId = slot2[2]
	slot0._itemQuantity = slot2[3]
	slot3, slot4 = ItemModel.instance:getItemConfigAndIcon(slot0._itemType, slot0._itemId, true)

	slot0._simageicon:LoadImage(slot4)
	gohelper.setActive(slot0._goitem, slot0._itemQuantity > 1)

	slot0._txtitemcount.text = GameUtil.numberDisplay(slot0._itemQuantity)
	slot0._txtgoodsNameCn.text = slot3.name
	slot0._txtgoodsDesc.text = slot3.useDesc
	slot0._txtsalePrice.text = string.format("%s%s", StoreModel.instance:getCostStr(slot0._mo.config.price))
end

function slot0.onOpen(slot0)
	slot0._mo = slot0.viewParam

	slot0:addEventCb(PayController.instance, PayEvent.PayFinished, slot0._payFinished, slot0)
	slot0:_refreshUI()
end

function slot0._payFinished(slot0)
	slot0:closeThis()
end

function slot0.onClose(slot0)
	slot0:removeEventCb(PayController.instance, PayEvent.PayFinished, slot0._payFinished, slot0)
end

function slot0.onUpdateParam(slot0)
	slot0._mo = slot0.viewParam

	slot0:_refreshUI()
end

function slot0.onDestroyView(slot0)
	slot0._simageleftbg:UnLoadImage()
	slot0._simagerightbg:UnLoadImage()
	slot0._simageicon:UnLoadImage()
end

return slot0
