module("modules.logic.summon.view.SummonConfirmView", package.seeall)

slot0 = class("SummonConfirmView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagehuawen1 = gohelper.findChildSingleImage(slot0.viewGO, "bg/tipbg/#simage_huawen1")
	slot0._simagehuawen2 = gohelper.findChildSingleImage(slot0.viewGO, "bg/tipbg/#simage_huawen2")
	slot0._simagebeforeicon = gohelper.findChildSingleImage(slot0.viewGO, "cost/before/#simage_beforeicon")
	slot0._simageaftericon = gohelper.findChildSingleImage(slot0.viewGO, "cost/after/#simage_aftericon")
	slot0._txtbeforequantity = gohelper.findChildText(slot0.viewGO, "cost/before/numbg/#txt_beforequantity")
	slot0._txtafterquantity = gohelper.findChildText(slot0.viewGO, "cost/after/numbg/#txt_afterquantity")
	slot0._txtdesc = gohelper.findChildText(slot0.viewGO, "#txt_desc")
	slot0._btnyes = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_yes")
	slot0._btnno = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_no")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnyes:AddClickListener(slot0._btnyesOnClick, slot0)
	slot0._btnno:AddClickListener(slot0._btnnoOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnyes:RemoveClickListener()
	slot0._btnno:RemoveClickListener()
end

function slot0._btnyesOnClick(slot0)
	slot0._yes = true

	if slot0.viewParam.notEnough then
		CurrencyController.instance:checkFreeDiamondEnough(slot0.viewParam.cost_quantity, CurrencyEnum.PayDiamondExchangeSource.Summon, true, slot0._callCheckWithParam, slot0)
	end

	slot0:closeThis()
end

function slot0._btnnoOnClick(slot0)
	slot0:closeThis()
end

function slot0._callCheckWithParam(slot0)
	slot0._callback(slot0._callbackObj, slot0.viewParam)
end

function slot0._editableInitView(slot0)
	slot0._simagehuawen1:LoadImage(ResUrl.getMessageIcon("huawen1_002"))
	slot0._simagehuawen2:LoadImage(ResUrl.getMessageIcon("huawen2_003"))
	gohelper.addUIClickAudio(slot0._btnyes.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(slot0._btnno.gameObject, AudioEnum.UI.UI_Common_Click)
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.onOpen(slot0)
	slot0._type = slot0.viewParam.type
	slot0._id = slot0.viewParam.id
	slot0._quantity = slot0.viewParam.quantity
	slot0._callback = slot0.viewParam.callback
	slot0._callbackObj = slot0.viewParam.callbackObj
	slot0._yes = false
	slot0.needTransform = slot0.viewParam.needTransform
	slot1 = false

	if slot0._type == MaterialEnum.MaterialType.Currency and (slot0._id == CurrencyEnum.CurrencyType.Diamond or slot0._id == CurrencyEnum.CurrencyType.FreeDiamondCoupon) then
		slot1 = true
	end

	slot2, slot3 = ItemModel.instance:getItemConfigAndIcon(slot0._type, slot0._id)

	slot0._simageaftericon:LoadImage(slot3)

	if slot0.needTransform then
		slot4, slot5 = ItemModel.instance:getItemConfigAndIcon(slot0.viewParam.cost_type, slot0.viewParam.cost_id)

		slot0._simagebeforeicon:LoadImage(slot5)

		slot0._txtbeforequantity.text = GameUtil.numberDisplay(slot0.viewParam.cost_quantity)
		slot0._txtafterquantity.text = GameUtil.numberDisplay(slot0.viewParam.miss_quantity)
		slot0._txtdesc.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_transform_desc"), {
			slot0.viewParam.miss_quantity,
			slot1 and luaLang("summon_confirm_quantifier1") or luaLang("summon_confirm_quantifier2"),
			slot2.name,
			slot0.viewParam.cost_quantity,
			slot4.name
		})
	else
		slot0._simagebeforeicon:LoadImage(slot3)

		slot4 = ItemModel.instance:getItemQuantity(slot0._type, slot0._id)
		slot0._txtbeforequantity.text = GameUtil.numberDisplay(slot4)
		slot0._txtafterquantity.text = GameUtil.numberDisplay(slot4 - slot0._quantity)
		slot0._txtdesc.text = GameUtil.getSubPlaceholderLuaLang(luaLang("summon_confirm_desc"), {
			slot0._quantity,
			slot1 and luaLang("summon_confirm_quantifier1") or luaLang("summon_confirm_quantifier2"),
			slot2.name
		})
	end
end

function slot0.onClose(slot0)
end

function slot0.onCloseFinish(slot0)
	if slot0._yes and not slot0.viewParam.notEnough and slot0._callback then
		slot0._callback(slot0._callbackObj, slot0.viewParam)
	end
end

function slot0.onDestroyView(slot0)
	slot0._simagehuawen1:UnLoadImage()
	slot0._simagehuawen2:UnLoadImage()
	slot0._simagebeforeicon:UnLoadImage()
	slot0._simageaftericon:UnLoadImage()
end

return slot0
