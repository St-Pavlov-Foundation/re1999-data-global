module("modules.logic.versionactivity.view.VersionActivityNormalStoreGoodsView", package.seeall)

slot0 = class("VersionActivityNormalStoreGoodsView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageblur = gohelper.findChildSingleImage(slot0.viewGO, "#simage_blur")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "root/#simage_leftbg")
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "root/#simage_rightbg")
	slot0._goremain = gohelper.findChild(slot0.viewGO, "root/propinfo/info/#go_goodsheader/remain")
	slot0._txtremain = gohelper.findChildText(slot0.viewGO, "root/propinfo/info/#go_goodsheader/remain/#txt_remain")
	slot0._gounique = gohelper.findChild(slot0.viewGO, "root/propinfo/info/#go_goodsheader/go_unique")
	slot0._goIcon = gohelper.findChild(slot0.viewGO, "root/propinfo/goIcon")
	slot0._simageicon = gohelper.findChildSingleImage(slot0._goIcon, "#simage_icon")
	slot0._txtgoodsNameCn = gohelper.findChildText(slot0.viewGO, "root/propinfo/#txt_goodsNameCn")
	slot0._txtgoodsUseDesc = gohelper.findChildText(slot0.viewGO, "root/propinfo/info/goodsDesc/Viewport/Content/#txt_goodsUseDesc")
	slot0._txtgoodsDesc = gohelper.findChildText(slot0.viewGO, "root/propinfo/info/goodsDesc/Viewport/Content/#txt_goodsDesc")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/propinfo/#btn_click")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "root/propinfo/group/#go_item")
	slot0._txtitemcount = gohelper.findChildText(slot0.viewGO, "root/propinfo/group/#go_item/#txt_itemcount")
	slot0._gogoodsHavebg = gohelper.findChild(slot0.viewGO, "root/propinfo/group/#go_goodsHavebg")
	slot0._txtgoodsHave = gohelper.findChildText(slot0.viewGO, "root/propinfo/group/#go_goodsHavebg/bg/#txt_goodsHave")
	slot0._gobuy = gohelper.findChild(slot0.viewGO, "root/#go_buy")
	slot0._inputvalue = gohelper.findChildTextMeshInputField(slot0.viewGO, "root/#go_buy/valuebg/#input_value")
	slot0._btnmin = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_buy/#btn_min")
	slot0._btnsub = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_buy/#btn_sub")
	slot0._btnadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_buy/#btn_add")
	slot0._btnmax = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_buy/#btn_max")
	slot0._btnbuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_buy/#btn_buy")
	slot0._txtoriginalCost = gohelper.findChildText(slot0.viewGO, "root/#go_buy/cost/#txt_originalCost")
	slot0._txtsalePrice = gohelper.findChildText(slot0.viewGO, "root/#go_buy/cost/#txt_originalCost/#txt_salePrice")
	slot0._simagecosticon = gohelper.findChildSingleImage(slot0.viewGO, "root/#go_buy/cost/#simage_costicon")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "root/#go_tips")
	slot0._txtlocktips = gohelper.findChildText(slot0.viewGO, "root/#go_tips/#txt_locktips")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
	slot0._btnmin:AddClickListener(slot0._btnminOnClick, slot0)
	slot0._btnsub:AddClickListener(slot0._btnsubOnClick, slot0)
	slot0._btnadd:AddClickListener(slot0._btnaddOnClick, slot0)
	slot0._btnmax:AddClickListener(slot0._btnmaxOnClick, slot0)
	slot0._btnbuy:AddClickListener(slot0._btnbuyOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
	slot0._inputvalue:AddOnEndEdit(slot0._onEndEdit, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclick:RemoveClickListener()
	slot0._btnmin:RemoveClickListener()
	slot0._btnsub:RemoveClickListener()
	slot0._btnadd:RemoveClickListener()
	slot0._btnmax:RemoveClickListener()
	slot0._btnbuy:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._inputvalue:RemoveOnEndEdit()
end

function slot0._onEndEdit(slot0, slot1)
	if not tonumber(slot1) or not math.floor(slot2) or slot2 < 1 then
		slot0.currentBuyCount = 1

		slot0:refreshByCount()
		GameFacade.showToast(ToastEnum.VersionActivityNormalStoreNoGoods)

		return
	end

	if slot0.maxBuyCount < slot2 then
		slot0.currentBuyCount = math.max(slot0.maxBuyCount, 1)

		slot0:refreshByCount()

		return
	end

	slot0.currentBuyCount = slot2

	slot0:refreshByCount()
end

function slot0._btnclickOnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(slot0.itemType, slot0.itemId)
end

function slot0._btnminOnClick(slot0)
	slot0.currentBuyCount = 1

	slot0:refreshByCount()
end

function slot0._btnsubOnClick(slot0)
	if slot0.currentBuyCount <= 1 then
		return
	end

	slot0.currentBuyCount = slot0.currentBuyCount - 1

	slot0:refreshByCount()
end

function slot0._btnaddOnClick(slot0)
	if slot0.storeGoodsCo.maxBuyCount ~= 0 and slot0.remainBuyCount <= slot0.currentBuyCount then
		GameFacade.showToast(ToastEnum.StoreMaxBuyCount)

		return
	end

	if slot0.maxBuyCount <= slot0.currentBuyCount then
		GameFacade.showToast(ToastEnum.DiamondBuy, slot0.costName)

		return
	end

	slot0.currentBuyCount = slot0.currentBuyCount + 1

	slot0:refreshByCount()
end

function slot0._btnmaxOnClick(slot0)
	slot0.currentBuyCount = math.max(slot0.maxBuyCount, 1)

	slot0:refreshByCount()
end

function slot0._btnbuyOnClick(slot0)
	if slot0.maxBuyCount < slot0.currentBuyCount then
		GameFacade.showToast(ToastEnum.DiamondBuy, slot0.costName)

		return
	end

	Activity107Rpc.instance:sendBuy107GoodsRequest(slot0.storeGoodsCo.activityId, slot0.storeGoodsCo.id, slot0.currentBuyCount)
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	slot0._imagecosticon = gohelper.findChildImage(slot0.viewGO, "root/#go_buy/cost/#simage_costicon")

	gohelper.setActive(slot0._gotips, false)
	gohelper.setActive(slot0._gobuy, true)
	gohelper.addUIClickAudio(slot0._btnbuy.gameObject, AudioEnum.UI.Store_Good_Click)
	slot0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, slot0.onBuyGoodsSuccess, slot0)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_Tipsopen)

	slot0.storeGoodsCo = slot0.viewParam
	slot1 = string.splitToNumber(slot0.storeGoodsCo.product, "#")
	slot0.itemType = slot1[1]
	slot0.itemId = slot1[2]
	slot0.oneItemCount = slot1[3]
	slot2 = string.split(slot0.storeGoodsCo.cost, "#")
	slot0.costType = slot2[1]
	slot0.costId = slot2[2]
	slot0.oneCostQuantity = tonumber(slot2[3])
	slot0.hadQuantity = ItemModel.instance:getItemQuantity(slot0.costType, slot0.costId)
	slot0.costName = ItemModel.instance:getItemConfig(slot0.costType, slot0.costId) and slot3.name or ""
	slot0.maxBuyCount = math.floor(slot0.hadQuantity / slot0.oneCostQuantity)
	slot0.remainBuyCount = slot0.storeGoodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(slot0.storeGoodsCo.activityId, slot0.storeGoodsCo.id)

	if slot0.storeGoodsCo.maxBuyCount ~= 0 then
		slot0.maxBuyCount = math.min(slot0.maxBuyCount, slot0.remainBuyCount)
	end

	slot0.currentBuyCount = 1

	slot0:refreshUI()
end

function slot0.refreshUI(slot0)
	slot1, slot2 = ItemModel.instance:getItemConfigAndIcon(slot0.itemType, slot0.itemId)
	slot0._txtgoodsNameCn.text = slot1.name
	slot0._txtgoodsDesc.text = slot1.desc
	slot0._txtgoodsUseDesc.text = slot1.useDesc

	if tonumber(slot0.itemType) == MaterialEnum.MaterialType.Equip then
		slot2 = ResUrl.getEquipSuit(slot1.icon)
	end

	if slot1.subType == ItemEnum.SubType.Portrait then
		gohelper.setActive(slot0._simageicon.gameObject, false)

		if not slot0.headIconItem then
			slot0.headIconItem = IconMgr.instance:getCommonHeadIcon(slot0._goIcon)
		end

		slot0.headIconItem:setItemId(slot1.id)
	else
		gohelper.setActive(slot0._simageicon.gameObject, true)
		slot0._simageicon:LoadImage(slot2)

		if slot0.headIconItem then
			slot0.headIconItem:setVisible(false)
		end
	end

	slot0._txtgoodsHave.text = string.format("%s", GameUtil.numberDisplay(ItemModel.instance:getItemQuantity(slot0.itemType, slot0.itemId)))

	if slot0.storeGoodsCo.maxBuyCount == 0 then
		gohelper.setActive(slot0._goremain, false)
	else
		gohelper.setActive(slot0._txtremain.gameObject, true)

		slot0._txtremain.text = luaLang("store_buylimit") .. slot0.remainBuyCount
	end

	slot0:refreshByCount()
	slot0:_refreshGoUnique()
end

function slot0._refreshGoUnique(slot0)
	gohelper.setActive(slot0._gounique, ItemConfig.instance:isUniqueById(slot0.itemType, slot0.itemId))
end

function slot0.refreshByCount(slot0)
	slot0._inputvalue:SetText(tostring(slot0.currentBuyCount))

	slot0._txtitemcount.text = string.format("%s%s", luaLang("multiple"), GameUtil.numberDisplay(slot0.oneItemCount * slot0.currentBuyCount))

	if slot0.hadQuantity < slot0.oneCostQuantity * slot0.currentBuyCount then
		slot0._txtsalePrice.text = string.format("<color=#BF2E11>%s</color>", slot1)
	else
		slot0._txtsalePrice.text = string.format("%s", slot1)
	end

	slot2, slot3 = ItemModel.instance:getItemConfigAndIcon(slot0.costType, slot0.costId)

	if tonumber(slot0.costType) == MaterialEnum.MaterialType.Currency then
		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagecosticon, slot2.icon .. "_1")
	else
		slot0._simagecosticon:LoadImage(slot3)
	end
end

function slot0.onBuyGoodsSuccess(slot0)
	slot0:closeThis()
end

function slot0.onClose(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
end

function slot0.onDestroyView(slot0)
	slot0._simageleftbg:UnLoadImage()
	slot0._simagerightbg:UnLoadImage()
	slot0._simageicon:UnLoadImage()
	slot0._simagecosticon:UnLoadImage()
end

return slot0
