module("modules.logic.versionactivity1_7.dungeon.view.store.VersionActivity1_7StoreGoodsItem", package.seeall)

slot0 = class("VersionActivity1_7StoreGoodsItem", ListScrollCell)

function slot0.init(slot0, slot1)
	slot0.go = slot1
	slot0.goTag = gohelper.findChild(slot0.go, "go_tag")
	slot0.txtTag = gohelper.findChildText(slot0.go, "go_tag/txt_tag")
	slot0.txtLimitBuy = gohelper.findChildText(slot0.go, "txt_limitbuy")
	slot0.imageRare = gohelper.findChildImage(slot0.go, "image_rare")
	slot0.goMaxRareEffect = gohelper.findChild(slot0.go, "eff_rare5")
	slot0.simageIcon = gohelper.findChildSingleImage(slot0.go, "simage_icon")
	slot0.imageIcon = gohelper.findChildImage(slot0.go, "simage_icon")
	slot0.goQuantity = gohelper.findChild(slot0.go, "quantity")
	slot0.txtQuantity = gohelper.findChildText(slot0.go, "quantity/txt_quantity")
	slot0.txtCost = gohelper.findChildText(slot0.go, "txt_cost")
	slot0.simageCoin = gohelper.findChildSingleImage(slot0.go, "txt_cost/simage_coin")
	slot0.imageCoin = gohelper.findChildImage(slot0.go, "txt_cost/simage_coin")
	slot0.goSoldout = gohelper.findChild(slot0.go, "go_soldout")
	slot0.goClick = gohelper.getClickWithDefaultAudio(slot1)

	slot0.goClick:AddClickListener(slot0.onClick, slot0)
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0.onClick(slot0)
	if slot0.remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_5NormalStoreGoodsView, slot0.goodsCo)
end

function slot0.onUpdateMO(slot0, slot1)
	slot0.goodsCo = slot1

	slot0:updateProductCo()
	slot0:updateRare()
	slot0:refreshRemainBuyCount()
	gohelper.setActive(slot0.go, true)
	slot0:refreshUI()
end

function slot0.updateProductCo(slot0)
	slot0.productItemType, slot0.productItemId, slot0.productQuantity = slot0:getItemTypeIdQuantity(slot0.goodsCo.product)
	slot0.productConfig, slot0.productIconUrl = ItemModel.instance:getItemConfigAndIcon(slot0.productItemType, slot0.productItemId)
end

function slot0.updateRare(slot0)
	slot0.rare = slot0.productConfig.rare

	if not slot0.rare then
		logWarn("material type : %s, material id : %s not had rare attribute")

		slot0.rare = 5
	end
end

function slot0.refreshRemainBuyCount(slot0)
	if slot0.goodsCo.maxBuyCount == 0 then
		gohelper.setActive(slot0.txtLimitBuy.gameObject, false)
		gohelper.setActive(slot0.goSoldout, false)

		slot0.remainBuyCount = 9999
	else
		gohelper.setActive(slot0.txtLimitBuy.gameObject, true)

		slot0.remainBuyCount = slot0.goodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_7Enum.ActivityId.DungeonStore, slot0.goodsCo.id)
		slot0.txtLimitBuy.text = formatLuaLang("v1a4_bossrush_storeview_buylimit", slot0.remainBuyCount)

		gohelper.setActive(slot0.goSoldout, slot0.remainBuyCount <= 0)
	end
end

function slot0.refreshUI(slot0)
	slot0:refreshRareBg()
	slot0:refreshIcon()
	slot0:refreshTag()
	slot0:refreshName()
	slot0:refreshQuantity()
	slot0:refreshCost()
end

function slot0.refreshRareBg(slot0)
	UISpriteSetMgr.instance:setV1a7MainActivitySprite(slot0.imageRare, "v1a7_store_quality_" .. slot0.rare)
	gohelper.setActive(slot0.goMaxRareEffect, slot0.rare >= 5)
end

function slot0.refreshIcon(slot0)
	if slot0.productItemType == MaterialEnum.MaterialType.Equip then
		slot0.simageIcon:LoadImage(ResUrl.getHeroDefaultEquipIcon(slot0.productConfig.icon), slot0.setNativeSize, slot0)
	else
		slot0.simageIcon:LoadImage(slot0.productIconUrl, slot0.setNativeSize, slot0)
	end
end

function slot0.setNativeSize(slot0)
	slot0.imageIcon:SetNativeSize()
end

function slot0.refreshTag(slot0)
	if slot0.goodsCo.tag == 0 or slot0.remainBuyCount <= 0 then
		gohelper.setActive(slot0.goTag, false)

		return
	end

	gohelper.setActive(slot0.goTag, true)

	slot0.txtTag.text = ActivityStoreConfig.instance:getTagName(slot0.goodsCo.tag)
end

function slot0.refreshName(slot0)
	gohelper.setActive(slot0.txtName, false)

	if MaterialEnum.ItemRareR <= slot0.rare then
		slot0.txtName = gohelper.findChildText(slot0.go, "txt_name" .. slot0.rare)
	else
		slot0.txtName = gohelper.findChildText(slot0.go, "txt_name")
	end

	gohelper.setActive(slot0.txtName, true)

	slot0.txtName.text = slot0.productConfig.name
end

function slot0.refreshQuantity(slot0)
	slot1 = slot0.productQuantity > 1

	gohelper.setActive(slot0.goQuantity, slot1)

	if slot1 then
		slot0.txtQuantity.text = luaLang("multiple") .. slot0.productQuantity
	end
end

function slot0.refreshCost(slot0)
	slot1, slot2, slot0.txtCost.text = slot0:getItemTypeIdQuantity(slot0.goodsCo.cost)
	slot4, slot5 = ItemModel.instance:getItemConfigAndIcon(slot1, slot2)

	if slot1 == MaterialEnum.MaterialType.Currency then
		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0.imageCoin, slot4.icon .. "_1")
	else
		slot0.simageCoin:LoadImage(slot5)
	end
end

function slot0.getItemTypeIdQuantity(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "#")

	return slot2[1], slot2[2], slot2[3]
end

function slot0.onDestroy(slot0)
	slot0.goClick:RemoveClickListener()
	slot0.simageIcon:UnLoadImage()
	slot0.simageCoin:UnLoadImage()
end

return slot0
