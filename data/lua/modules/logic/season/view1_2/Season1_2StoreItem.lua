module("modules.logic.season.view1_2.Season1_2StoreItem", package.seeall)

slot0 = class("Season1_2StoreItem", UserDataDispose)

function slot0.ctor(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.goClick = gohelper.findChildClickWithAudio(slot0.go, "goClick")
	slot0.goTag = gohelper.findChild(slot0.go, "go_tag")
	slot0.txtTag = gohelper.findChildText(slot0.go, "go_tag/txt_tag")
	slot0.txtLimitBuy = gohelper.findChildText(slot0.go, "layout/txt_limitbuy")
	slot0.imageRare = gohelper.findChildImage(slot0.go, "image_rare")
	slot0.goIcon = gohelper.findChild(slot0.go, "goIcon")
	slot0.simageIcon = gohelper.findChildSingleImage(slot0.go, "goIcon/simage_icon")
	slot0.imageIcon = gohelper.findChildImage(slot0.go, "goIcon/simage_icon")
	slot0.goQuantity = gohelper.findChild(slot0.go, "quantity")
	slot0.txtQuantity = gohelper.findChildText(slot0.go, "quantity/bg/txt_quantity")
	slot0.txtName = gohelper.findChildText(slot0.go, "layout/txt_name")
	slot0.txtCost = gohelper.findChildText(slot0.go, "txt_cost")
	slot0.simageCoin = gohelper.findChildSingleImage(slot0.go, "txt_cost/simage_coin")
	slot0.imageCoin = gohelper.findChildImage(slot0.go, "txt_cost/simage_coin")
	slot0.goSoldout = gohelper.findChild(slot0.go, "go_soldout")

	slot0.goClick:AddClickListener(slot0.onClick, slot0)
end

function slot0.onClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if not slot0.data then
		return
	end

	if slot0.remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	if slot0.productItemType == MaterialEnum.MaterialType.HeroSkin then
		ViewMgr.instance:openView(ViewName.StoreSkinGoodsView, {
			isActivityStore = true,
			goodsMO = slot0.data
		})
	else
		ViewMgr.instance:openView(ViewName.VersionActivityNormalStoreGoodsView, slot0.data)
	end
end

function slot0.setData(slot0, slot1)
	slot0.data = slot1

	if not slot1 then
		gohelper.setActive(slot0.go, false)

		return
	end

	gohelper.setActive(slot0.go, true)
	slot0:refreshRemainBuyCount()

	slot2, slot3, slot4 = slot0:getItemTypeIdQuantity(slot0.data.product)
	slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(slot2, slot3, true)
	slot0.productItemType = slot2
	slot7 = nil

	if not slot5.rare then
		logWarn("material type : %s, material id : %s not had rare attribute")

		slot7 = 5
	else
		slot7 = slot5.rare
	end

	UISpriteSetMgr.instance:setStoreGoodsSprite(slot0.imageRare, "rare" .. slot7)

	if slot2 == MaterialEnum.MaterialType.Equip then
		slot0.simageIcon:LoadImage(ResUrl.getHeroDefaultEquipIcon(slot5.icon), function ()
			uv0.imageIcon:SetNativeSize()
		end)

		if slot0.headIconItem then
			slot0.headIconItem:setVisible(false)
		end
	elseif slot5.subType == ItemEnum.SubType.Portrait then
		gohelper.setActive(slot0.simageIcon.gameObject, false)

		if not slot0.headIconItem then
			slot0.headIconItem = IconMgr.instance:getCommonHeadIcon(slot0.goIcon)
		end

		slot0.headIconItem:setItemId(slot5.id)
	else
		gohelper.setActive(slot0.simageIcon.gameObject, true)
		slot0.simageIcon:LoadImage(slot6, function ()
			uv0.imageIcon:SetNativeSize()
		end)

		if slot0.headIconItem then
			slot0.headIconItem:setVisible(false)
		end
	end

	slot0.txtName.text = slot5.name

	gohelper.setActive(slot0.goQuantity, slot4 > 1)

	slot0.txtQuantity.text = slot4 > 1 and slot4 or ""
	slot0.costItemType, slot0.costItemId, slot0.costItemQuantity = slot0:getItemTypeIdQuantity(slot0.data.cost)
	slot0.txtCost.text = slot0.costItemQuantity
	slot8, slot9 = ItemModel.instance:getItemConfigAndIcon(slot0.costItemType, slot0.costItemId)

	if slot0.costItemType == MaterialEnum.MaterialType.Currency then
		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0.imageCoin, slot8.icon .. "_1")
	else
		slot0.simageCoin:LoadImage(slot9)
	end

	slot0:refreshTag()
end

function slot0.refreshRemainBuyCount(slot0)
	if slot0.data.maxBuyCount == 0 then
		gohelper.setActive(slot0.txtLimitBuy.gameObject, false)
		gohelper.setActive(slot0.goSoldout, false)

		slot0.remainBuyCount = 9999
	else
		gohelper.setActive(slot0.txtLimitBuy.gameObject, true)

		slot0.remainBuyCount = slot0.data.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(slot0.data.activityId, slot0.data.id)
		slot0.txtLimitBuy.text = formatLuaLang("v1a4_bossrush_storeview_buylimit", slot0.remainBuyCount)

		gohelper.setActive(slot0.goSoldout, slot0.remainBuyCount <= 0)
	end
end

function slot0.refreshTag(slot0)
	if slot0.data.tag == 0 or slot0.remainBuyCount <= 0 then
		gohelper.setActive(slot0.goTag, false)

		return
	end

	gohelper.setActive(slot0.goTag, true)

	slot0.txtTag.text = ActivityStoreConfig.instance:getTagName(slot0.data.tag)
end

function slot0.getItemTypeIdQuantity(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "#")

	return slot2[1], slot2[2], slot2[3]
end

function slot0.destory(slot0)
	slot0.goClick:RemoveClickListener()
	slot0.simageIcon:UnLoadImage()
	slot0.simageCoin:UnLoadImage()
	slot0:__onDispose()
end

return slot0
