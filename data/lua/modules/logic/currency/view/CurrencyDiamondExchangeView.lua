module("modules.logic.currency.view.CurrencyDiamondExchangeView", package.seeall)

slot0 = class("CurrencyDiamondExchangeView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "decorate/#simage_leftbg")
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "decorate/#simage_rightbg")
	slot0._txtleftproductname = gohelper.findChildText(slot0.viewGO, "left/#txt_leftproductname")
	slot0._simageleftproduct = gohelper.findChildSingleImage(slot0.viewGO, "left/#simage_leftproduct")
	slot0._txtrightproductname = gohelper.findChildText(slot0.viewGO, "right/#txt_rightproductname")
	slot0._simagerightproduct = gohelper.findChildSingleImage(slot0.viewGO, "right/#simage_rightproduct")
	slot0._gobuy = gohelper.findChild(slot0.viewGO, "#go_buy")
	slot0._inputvalue = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_buy/valuebg/#input_value")
	slot0._btnmin = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buy/#btn_min")
	slot0._btnsub = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buy/#btn_sub")
	slot0._btnadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buy/#btn_add")
	slot0._btnmax = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buy/#btn_max")
	slot0._btnbuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buy/#btn_buy")
	slot0._gobuylimit = gohelper.findChild(slot0.viewGO, "#go_buy/#go_buylimit")
	slot0._simagecosticon = gohelper.findChildImage(slot0.viewGO, "#go_buy/cost/#simage_costicon")
	slot0._txtoriginalCost = gohelper.findChildText(slot0.viewGO, "#go_buy/cost/#txt_originalCost")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnmin:AddClickListener(slot0._btnminOnClick, slot0)
	slot0._btnsub:AddClickListener(slot0._btnsubOnClick, slot0)
	slot0._btnadd:AddClickListener(slot0._btnaddOnClick, slot0)
	slot0._btnmax:AddClickListener(slot0._btnmaxOnClick, slot0)
	slot0._btnbuy:AddClickListener(slot0._btnbuyOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnmin:RemoveClickListener()
	slot0._btnsub:RemoveClickListener()
	slot0._btnadd:RemoveClickListener()
	slot0._btnmax:RemoveClickListener()
	slot0._btnbuy:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

slot0.ClickStep = 1
slot0.MinAmount = 0

function slot0._editableInitView(slot0)
	slot0._currenctAmount = uv0.MinAmount
	slot1 = MaterialEnum.MaterialType.Currency
	slot3, slot4 = ItemModel.instance:getItemConfigAndIcon(slot1, CurrencyEnum.CurrencyType.Diamond, true)
	slot0._txtleftproductname.text = string.format("%s %s1", slot3.name, luaLang("multiple"))
	slot5, slot4 = ItemModel.instance:getItemConfigAndIcon(slot1, CurrencyEnum.CurrencyType.FreeDiamondCoupon, true)
	slot0._txtrightproductname.text = string.format("%s %s1", slot5.name, luaLang("multiple"))

	slot0._inputvalue:AddOnEndEdit(slot0._onInputNameEndEdit, slot0)

	slot0._inputText = slot0._inputvalue.inputField.textComponent
	slot0._colorDefault = Color.New(0.9058824, 0.8941177, 0.8941177, 1)

	slot0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	slot0._simageleftproduct:LoadImage(ResUrl.getCurrencyItemIcon("201"))
	slot0._simagerightproduct:LoadImage(ResUrl.getCurrencyItemIcon("202"))
	UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._simagecosticon, "201_1")
end

function slot0.onDestroyView(slot0)
	slot0._inputvalue:RemoveOnEndEdit()
	slot0._simageleftbg:UnLoadImage()
	slot0._simagerightbg:UnLoadImage()
	slot0._simageleftproduct:UnLoadImage()
	slot0._simagerightproduct:UnLoadImage()
end

function slot0.onUpdateParam(slot0)
	slot0:onOpen()
end

function slot0.onOpen(slot0)
	slot0._currenctAmount = 1

	slot0:refreshAmount()
	slot0:addEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshAmount, slot0)
end

function slot0.onClose(slot0)
	slot0:removeEventCb(CurrencyController.instance, CurrencyEvent.CurrencyChange, slot0.refreshAmount, slot0)
end

function slot0.refreshAmount(slot0)
	slot0:checkCurrenctAmount()

	slot1 = tostring(slot0._currenctAmount)
	slot3 = slot0._colorDefault

	if not (slot0._currenctAmount <= slot0:getOwnAmount()) then
		slot3 = Color.red
	end

	slot0._inputText.color = slot3

	slot0._inputvalue:SetText(slot1)

	slot0._txtoriginalCost.text = slot1

	gohelper.setActive(slot0._btnbuy.gameObject, slot0._currenctAmount > 0)
	gohelper.setActive(slot0._gobuylimit, slot0._currenctAmount <= 0)
end

function slot0._onInputNameEndEdit(slot0)
	slot0._currenctAmount = tonumber(slot0._inputvalue:GetText())

	slot0:refreshAmount()
end

function slot0._btnminOnClick(slot0)
	if slot0:getOwnAmount() <= 0 then
		slot0._currenctAmount = 0
	else
		slot0._currenctAmount = 1
	end

	slot0:refreshAmount()
end

function slot0._btnmaxOnClick(slot0)
	slot0._currenctAmount = slot0:getOwnAmount()

	slot0:refreshAmount()
end

function slot0._btnsubOnClick(slot0)
	if slot0._currenctAmount ~= nil then
		slot0._currenctAmount = slot0._currenctAmount - uv0.ClickStep

		slot0:refreshAmount()
	end
end

function slot0._btnaddOnClick(slot0)
	if slot0._currenctAmount ~= nil then
		slot0._currenctAmount = slot0._currenctAmount + uv0.ClickStep

		slot0:refreshAmount()
	end
end

function slot0._btnbuyOnClick(slot0)
	if slot0._currenctAmount ~= nil and slot0._currenctAmount > 0 then
		if slot0._currenctAmount <= slot0:getOwnAmount() then
			CurrencyRpc.instance:sendExchangeDiamondRequest(slot0._currenctAmount, CurrencyEnum.PayDiamondExchangeSource.HUD, slot0.closeThis, slot0)
		else
			slot4, slot5 = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.Diamond, true)

			GameFacade.showToast(ToastEnum.DiamondBuy, slot4.name)
		end
	end
end

function slot0.checkCurrenctAmount(slot0)
	slot1 = slot0:getOwnAmount()

	if slot0._currenctAmount == nil then
		slot0._currenctAmount = 1
	end

	if slot0._currenctAmount < uv0.MinAmount then
		slot0._currenctAmount = uv0.MinAmount
	end
end

function slot0.getOwnAmount(slot0)
	return ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.Diamond)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

return slot0
