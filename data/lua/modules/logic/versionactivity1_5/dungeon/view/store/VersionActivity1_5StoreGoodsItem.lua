module("modules.logic.versionactivity1_5.dungeon.view.store.VersionActivity1_5StoreGoodsItem", package.seeall)

slot0 = class("VersionActivity1_5StoreGoodsItem", UserDataDispose)

function slot0.onInitView(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.goClick = gohelper.getClick(slot1)
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

	slot0.goClick:AddClickListener(slot0.onClick, slot0)
end

function slot0.onClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if slot0.remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_5NormalStoreGoodsView, slot0.storeGoodsCo)
end

function slot0.updateInfo(slot0, slot1)
	gohelper.setActive(slot0.go, true)

	slot0.storeGoodsCo = slot1

	slot0:refreshRemainBuyCount()

	slot2, slot3, slot4 = slot0:getItemTypeIdQuantity(slot0.storeGoodsCo.product)
	slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(slot2, slot3)
	slot7 = nil

	if not slot5.rare then
		logWarn("material type : %s, material id : %s not had rare attribute")

		slot7 = 5
	else
		slot7 = slot5.rare
	end

	UISpriteSetMgr.instance:setV1a5DungeonStoreSprite(slot0.imageRare, "v1a5_store_quality_" .. slot7)
	gohelper.setActive(slot0.goMaxRareEffect, slot7 >= 5)

	if slot2 == MaterialEnum.MaterialType.Equip then
		slot0.simageIcon:LoadImage(ResUrl.getHeroDefaultEquipIcon(slot5.icon), function ()
			uv0.imageIcon:SetNativeSize()
		end)
	else
		slot0.simageIcon:LoadImage(slot6, function ()
			uv0.imageIcon:SetNativeSize()
		end)
	end

	gohelper.setActive(slot0.txtName, false)

	if MaterialEnum.ItemRareR <= slot7 then
		slot0.txtName = gohelper.findChildText(slot0.go, "txt_name" .. slot7)
	else
		slot0.txtName = gohelper.findChildText(slot0.go, "txt_name")
	end

	gohelper.setActive(slot0.txtName, true)

	slot0.txtName.text = slot5.name

	gohelper.setActive(slot0.goQuantity, slot4 > 1)

	slot0.txtQuantity.text = slot4 > 1 and luaLang("multiple") .. slot4 or ""
	slot0.costItemType, slot0.costItemId, slot0.costItemQuantity = slot0:getItemTypeIdQuantity(slot0.storeGoodsCo.cost)
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
	if slot0.storeGoodsCo.maxBuyCount == 0 then
		gohelper.setActive(slot0.txtLimitBuy.gameObject, false)
		gohelper.setActive(slot0.goSoldout, false)

		slot0.remainBuyCount = 9999
	else
		gohelper.setActive(slot0.txtLimitBuy.gameObject, true)

		slot0.remainBuyCount = slot0.storeGoodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_5Enum.ActivityId.DungeonStore, slot0.storeGoodsCo.id)
		slot0.txtLimitBuy.text = formatLuaLang("v1a4_bossrush_storeview_buylimit", slot0.remainBuyCount)

		gohelper.setActive(slot0.goSoldout, slot0.remainBuyCount <= 0)
	end
end

function slot0.refreshTag(slot0)
	if slot0.storeGoodsCo.tag == 0 or slot0.remainBuyCount <= 0 then
		gohelper.setActive(slot0.goTag, false)

		return
	end

	gohelper.setActive(slot0.goTag, true)

	slot0.txtTag.text = ActivityStoreConfig.instance:getTagName(slot0.storeGoodsCo.tag)
end

function slot0.getItemTypeIdQuantity(slot0, slot1)
	slot2 = string.splitToNumber(slot1, "#")

	return slot2[1], slot2[2], slot2[3]
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
