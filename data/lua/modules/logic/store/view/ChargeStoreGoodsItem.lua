module("modules.logic.store.view.ChargeStoreGoodsItem", package.seeall)

slot0 = class("ChargeStoreGoodsItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#image_icon")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#image_icon/#txt_name")
	slot0._txtnum = gohelper.findChildText(slot0.viewGO, "#image_icon/huan/#txt_num")
	slot0._gorecharge = gohelper.findChild(slot0.viewGO, "#image_icon/#go_recharge")
	slot0._txtrecharge = gohelper.findChildText(slot0.viewGO, "#image_icon/#go_recharge/#txt_recharge")
	slot0._txtrechargenum = gohelper.findChildText(slot0.viewGO, "#image_icon/#go_recharge/#txt_recharge/#txt_recharge_num")
	slot0._goexcharge = gohelper.findChild(slot0.viewGO, "#image_icon/#go_excharge")
	slot0._txtexcharge = gohelper.findChildText(slot0.viewGO, "#image_icon/#go_excharge/excharge/#txt_excharge")
	slot0._txtexchargenum = gohelper.findChildText(slot0.viewGO, "#image_icon/#go_excharge/excharge/#txt_excharge_num")
	slot0._txtbtnnum = gohelper.findChildText(slot0.viewGO, "btn_bg/#txt_btn_num")
	slot0._gosign = gohelper.findChild(slot0.viewGO, "btn_bg/sign")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(PayController.instance, PayEvent.UpdateProductDetails, slot0._refreshGoods, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(PayController.instance, PayEvent.UpdateProductDetails, slot0._refreshGoods, slot0)
end

function slot0._editableInitView(slot0)
	slot0._btnGO = gohelper.findChild(slot0.viewGO, "clickArea")
	slot0._btn = gohelper.getClickWithAudio(slot0._btnGO)

	slot0._btn:AddClickListener(slot0._onClick, slot0)

	slot0._lastStartPayTime = 0
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function slot0._editableAddEvents(slot0)
end

function slot0._editableRemoveEvents(slot0)
end

function slot0._onClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)

	if Time.time - slot0._lastStartPayTime > 0.3 then
		PayController.instance:startPay(slot0._mo.id)

		slot0._lastStartPayTime = Time.time
	end
end

function slot0.onUpdateMO(slot0, slot1)
	slot0._mo = slot1

	slot0:_refreshGoods()
	slot0:_refreshDiscount()
end

slot1 = 210006

function slot0._refreshGoods(slot0)
	UISpriteSetMgr.instance:setStoreGoodsSprite(slot0._imageicon, slot0._mo.config.id, true)

	slot0._txtnum.text = string.splitToNumber(slot0._mo.config.product, "#")[3]
	slot0._txtbtnnum.text = PayModel.instance:getProductPrice(slot0._mo.id)

	gohelper.setActive(slot0._gosign, false)

	slot0._txtname.text = slot0._mo.config.name
end

function slot0._refreshDiscount(slot0)
	gohelper.setActive(slot0._gorecharge, false)
	gohelper.setActive(slot0._goexcharge, false)

	if slot0._mo.firstCharge then
		if slot0._mo.config.firstDiamond > 0 then
			gohelper.setActive(slot0._gorecharge, true)
			gohelper.setActive(slot0._gorechargeTip, true)

			slot0._txtrechargenum.text = string.format("<size=24>+</size>%s", slot0._mo.config.firstDiamond)
			slot0._txtrecharge.text = luaLang("store_charge_firstdouble")

			slot0._txtrecharge:GetPreferredValues()
		end
	elseif slot0._mo.config.extraDiamond > 0 then
		gohelper.setActive(slot0._goexcharge, true)

		slot0._txtexcharge.text = string.format(luaLang("store_charge_extra"), slot0._mo.config.extraDiamond)
		slot0._txtexchargenum.text = string.format("<voffset=1><size=24>+</size></voffset>%s", slot0._mo.config.extraDiamond)
	end
end

function slot0.onSelect(slot0, slot1)
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

function slot0.onDestroyView(slot0)
	slot0._btn:RemoveClickListener()
end

return slot0
