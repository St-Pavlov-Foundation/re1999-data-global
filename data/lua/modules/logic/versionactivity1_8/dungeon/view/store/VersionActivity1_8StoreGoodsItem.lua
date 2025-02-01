module("modules.logic.versionactivity1_8.dungeon.view.store.VersionActivity1_8StoreGoodsItem", package.seeall)

slot0 = class("VersionActivity1_8StoreGoodsItem", UserDataDispose)

function slot0.onInitView(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.goClick = gohelper.getClick(slot1)
	slot0.imageRare = gohelper.findChildImage(slot0.go, "image_rare")
	slot0.goMaxRareEffect = gohelper.findChild(slot0.go, "eff_rare5")
	slot0.goTag = gohelper.findChild(slot0.go, "go_tag")
	slot0.txtTag = gohelper.findChildText(slot0.go, "go_tag/txt_tag")
	slot0.txtLimitBuy = gohelper.findChildText(slot0.go, "txt_limitbuy")
	slot0.simageIcon = gohelper.findChildSingleImage(slot0.go, "simage_icon")
	slot0.imageIcon = gohelper.findChildImage(slot0.go, "simage_icon")
	slot0.txtName = gohelper.findChildText(slot0.go, "txt_name")
	slot0.goQuantity = gohelper.findChild(slot0.go, "quantity")
	slot0.txtQuantity = gohelper.findChildText(slot0.go, "quantity/txt_quantity")
	slot0.txtCost = gohelper.findChildText(slot0.go, "txt_cost")
	slot0.simageCoin = gohelper.findChildSingleImage(slot0.go, "txt_cost/simage_coin")
	slot0.imageCoin = gohelper.findChildImage(slot0.go, "txt_cost/simage_coin")
	slot0.goSoldout = gohelper.findChild(slot0.go, "go_soldout")

	slot0.goClick:AddClickListener(slot0.onClick, slot0)
end

function slot0.onClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if slot0.remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_6NormalStoreGoodsView, slot0.storeGoodsCo)
end

function slot0.updateInfo(slot0, slot1)
	slot0.storeGoodsCo = slot1

	slot0:refreshRemainBuyCount()

	slot2, slot3, slot4 = VersionActivity1_8EnterHelper.getItemTypeIdQuantity(slot0.storeGoodsCo.product)
	slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(slot2, slot3)
	slot7 = MaterialEnum.ItemRareSSR

	if slot5.rare then
		slot7 = slot5.rare
	else
		logWarn("material type : %s, material id : %s not had rare attribute")
	end

	UISpriteSetMgr.instance:setV1a8MainActivitySprite(slot0.imageRare, "v1a8_store_quality_" .. slot7)
	gohelper.setActive(slot0.goMaxRareEffect, MaterialEnum.ItemRareSSR <= slot7)

	if slot2 == MaterialEnum.MaterialType.Equip then
		slot0.simageIcon:LoadImage(ResUrl.getHeroDefaultEquipIcon(slot5.icon), slot0.setImageIconNative, slot0)
	else
		slot0.simageIcon:LoadImage(slot6, slot0.setImageIconNative, slot0)
	end

	gohelper.setActive(slot0.txtName, false)

	if MaterialEnum.ItemRareR <= slot7 and gohelper.findChildText(slot0.go, "txt_name" .. slot7) then
		slot0.txtName = slot8
	end

	if slot0.txtName then
		slot0.txtName.text = slot5.name
	end

	gohelper.setActive(slot0.txtName, true)
	gohelper.setActive(slot0.goQuantity, slot4 > 1)

	slot0.txtQuantity.text = slot4 > 1 and luaLang("multiple") .. slot4 or ""
	slot0.costItemType, slot0.costItemId, slot0.costItemQuantity = VersionActivity1_8EnterHelper.getItemTypeIdQuantity(slot0.storeGoodsCo.cost)
	slot0.txtCost.text = slot0.costItemQuantity
	slot8, slot9 = ItemModel.instance:getItemConfigAndIcon(slot0.costItemType, slot0.costItemId)

	if slot0.costItemType == MaterialEnum.MaterialType.Currency then
		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0.imageCoin, slot8.icon .. "_1")
	else
		slot0.simageCoin:LoadImage(slot9)
	end

	slot0:refreshTag()
	gohelper.setActive(slot0.go, true)
end

function slot0.refreshRemainBuyCount(slot0)
	if slot0.storeGoodsCo.maxBuyCount == 0 then
		gohelper.setActive(slot0.txtLimitBuy.gameObject, false)
		gohelper.setActive(slot0.goSoldout, false)

		slot0.remainBuyCount = 9999
	else
		gohelper.setActive(slot0.txtLimitBuy.gameObject, true)

		slot0.remainBuyCount = slot0.storeGoodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_8Enum.ActivityId.DungeonStore, slot0.storeGoodsCo.id)
		slot0.txtLimitBuy.text = formatLuaLang("v1a4_bossrush_storeview_buylimit", slot0.remainBuyCount)

		gohelper.setActive(slot0.goSoldout, slot0.remainBuyCount <= 0)
	end
end

function slot0.setImageIconNative(slot0)
	slot0.imageIcon:SetNativeSize()
end

function slot0.refreshTag(slot0)
	if slot0.storeGoodsCo.tag == 0 or slot0.remainBuyCount <= 0 then
		gohelper.setActive(slot0.goTag, false)

		return
	end

	gohelper.setActive(slot0.goTag, true)

	slot0.txtTag.text = ActivityStoreConfig.instance:getTagName(slot0.storeGoodsCo.tag)
end

function slot0.hide(slot0)
	gohelper.setActive(slot0.go, false)
end

function slot0.onDestroy(slot0)
	slot0.goClick:RemoveClickListener()
	slot0.simageIcon:UnLoadImage()
	slot0.simageCoin:UnLoadImage()
	slot0:__onDispose()
end

return slot0
