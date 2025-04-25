module("modules.logic.room.view.critter.train.RoomCritterExchangeView", package.seeall)

slot0 = class("RoomCritterExchangeView", BaseView)

function slot0.onInitView(slot0)
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "decorate/#simage_rightbg")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "decorate/#simage_leftbg")
	slot0._txtleftproductname = gohelper.findChildText(slot0.viewGO, "left/#txt_leftproductname")
	slot0._simageleftproduct = gohelper.findChildSingleImage(slot0.viewGO, "left/#simage_leftproduct")
	slot0._txtrightproductname = gohelper.findChildText(slot0.viewGO, "right/#txt_rightproductname")
	slot0._simagerightproduct = gohelper.findChildSingleImage(slot0.viewGO, "right/#simage_rightproduct")
	slot0._gobuy = gohelper.findChild(slot0.viewGO, "#go_buy")
	slot0._txtcount = gohelper.findChildText(slot0.viewGO, "#go_buy/#txt_count")
	slot0._inputvalue = gohelper.findChildTextMeshInputField(slot0.viewGO, "#go_buy/valuebg/#input_value")
	slot0._btnmin = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buy/#btn_min")
	slot0._btnsub = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buy/#btn_sub")
	slot0._btnadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buy/#btn_add")
	slot0._btnmax = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buy/#btn_max")
	slot0._btnbuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_buy/#btn_buy")
	slot0._gobuylimit = gohelper.findChild(slot0.viewGO, "#go_buy/#go_buylimit")
	slot0._gocost = gohelper.findChild(slot0.viewGO, "#go_buy/cost")
	slot0._simagecosticon = gohelper.findChildSingleImage(slot0.viewGO, "#go_buy/cost/#simage_costicon")
	slot0._txtoriginalCost = gohelper.findChildText(slot0.viewGO, "#go_buy/cost/#txt_originalCost")
	slot0._txtoriginalCost2 = gohelper.findChildText(slot0.viewGO, "#go_buy/cost/#txt_originalCost2")
	slot0._gorighttop = gohelper.findChild(slot0.viewGO, "#go_righttop")
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

slot1 = 99

function slot0._btnminOnClick(slot0)
	slot0._buyCount = 1

	slot0:_refreshUI()
end

function slot0._btnsubOnClick(slot0)
	if slot0._buyCount < 1 then
		return
	end

	slot0._buyCount = slot0._buyCount - 1

	slot0:_refreshUI()
end

function slot0._btnaddOnClick(slot0)
	if slot0._maxBuyCount <= slot0._buyCount then
		return
	end

	slot0._buyCount = slot0._buyCount + 1

	slot0:_refreshUI()
end

function slot0._btnmaxOnClick(slot0)
	slot0._buyCount = slot0._maxBuyCount

	slot0:_refreshUI()
end

function slot0._btnbuyOnClick(slot0)
	slot2 = string.splitToNumber(RoomTrainCritterModel.instance:getProductGood(slot0.viewParam[2]).config.cost, "#")

	if slot0:getOwnCount() < slot0._buyCount then
		GameFacade.showToast(ToastEnum.RoomCritterTrainNotEnoughCurrency, ItemModel.instance:getItemConfig(slot2[1], slot2[2]).name)

		return
	end

	StoreController.instance:buyGoods(slot1, slot0._buyCount, slot0._buyCallback, slot0)
	slot0:closeThis()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._onInputCountValueChanged(slot0)
	slot0._buyCount = slot0._maxBuyCount < tonumber(slot0._inputvalue:GetText()) and slot0._maxBuyCount or tonumber(slot0._inputvalue:GetText())

	slot0:_refreshUI()
end

function slot0._onInputCountEndEdit(slot0)
	slot0._buyCount = slot0._maxBuyCount < tonumber(slot0._inputvalue:GetText()) and slot0._maxBuyCount or tonumber(slot0._inputvalue:GetText())

	slot0:_refreshUI()
end

function slot0._editableInitView(slot0)
	slot0._colorDefault = Color.New(0.9058824, 0.8941177, 0.8941177, 1)
	slot0._inputText = slot0._inputvalue.inputField.textComponent
	slot0._buyCount = 1
end

function slot0._refreshUI(slot0)
	slot0._inputvalue:SetText(slot0._buyCount)

	if not RoomTrainCritterModel.instance:getProductGood(slot0.viewParam[2]) then
		logError("不存在可兑换的商品！请检查配置")

		return
	end

	slot3 = string.splitToNumber(slot1.config.cost, "#")
	slot4 = slot0:getOwnCount()

	if string.nilorempty(StoreConfig.instance:getRemain(slot1.config, slot1.config.maxBuyCount - slot1.buyCount, slot1.offlineTime)) then
		gohelper.setActive(slot0._txtcount.gameObject, false)

		slot0._maxBuyCount = uv0 < slot4 and uv0 or slot4
	else
		gohelper.setActive(slot0._txtcount.gameObject, true)

		slot0._txtcount.text = slot5 .. "/" .. slot1.config.maxBuyCount
		slot0._maxBuyCount = slot2
	end

	if slot4 == 0 then
		slot0._maxBuyCount = 1
	end

	gohelper.setActive(slot0._gobuylimit, slot0._buyCount <= 0)
	gohelper.setActive(slot0._btnbuy.gameObject, slot0._buyCount > 0)
	gohelper.setActive(slot0._gocost, slot0._buyCount > 0)

	if slot0._buyCount > 0 then
		if string.nilorempty(slot1.config.cost) then
			gohelper.setActive(slot0._txtoriginalCost.gameObject, false)
		else
			gohelper.setActive(slot0._txtoriginalCost.gameObject, true)

			slot0._txtoriginalCost.text = slot0._buyCount * slot3[3]
		end

		if slot1.config.originalCost > 0 then
			gohelper.setActive(slot0._txtoriginalCost2.gameObject, true)

			slot0._txtoriginalCost2.text = slot0._buyCount * slot1.config.originalCost
		else
			gohelper.setActive(slot0._txtoriginalCost2.gameObject, false)
		end
	end

	slot0._inputText.color = slot0._buyCount <= slot4 and slot0._colorDefault or Color.red
end

function slot0.getOwnCount(slot0)
	slot2 = string.splitToNumber(RoomTrainCritterModel.instance:getProductGood(slot0.viewParam[2]).config.cost, "#")

	return math.floor(ItemModel.instance:getItemQuantity(slot2[1], slot2[2]) / slot2[3])
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0:_initIcon()
	slot0:_refreshUI()
	slot0._inputvalue:AddOnValueChanged(slot0._onInputCountValueChanged, slot0)
	slot0._inputvalue:AddOnEndEdit(slot0._onInputCountEndEdit, slot0)
end

function slot0._initIcon(slot0)
	if not RoomTrainCritterModel.instance:getProductGood(slot0.viewParam[2]) then
		logError("不存在可兑换的商品！请检查配置")

		return
	end

	slot2 = string.splitToNumber(slot1.config.product, "#")
	slot3, slot4 = ItemModel.instance:getItemConfigAndIcon(slot2[1], slot2[2], true)

	gohelper.setActive(slot0._simagerightproduct.gameObject, true)
	slot0._simagerightproduct:LoadImage(slot4)

	slot0._txtrightproductname.text = string.format("%s%s%s", slot3.name, luaLang("multiple"), slot2[3])
	slot5 = string.splitToNumber(slot1.config.cost, "#")
	slot6, slot7 = ItemModel.instance:getItemConfigAndIcon(slot5[1], slot5[2], true)

	gohelper.setActive(slot0._simageleftproduct.gameObject, true)
	slot0._simageleftproduct:LoadImage(slot7)

	slot0._txtleftproductname.text = string.format("%s%s%s", slot6.name, luaLang("multiple"), slot5[3])

	slot0._simagecosticon:LoadImage(slot7)

	slot8 = {}

	table.insert(slot8, slot2[2])
	table.insert(slot8, slot5[2])
	slot0.viewContainer:setCurrencyType(slot8)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._inputvalue:RemoveOnValueChanged()
	slot0._inputvalue:RemoveOnEndEdit()
	slot0._simageleftbg:UnLoadImage()
	slot0._simagerightbg:UnLoadImage()
	slot0._simageleftproduct:UnLoadImage()
	slot0._simagerightproduct:UnLoadImage()
end

return slot0
