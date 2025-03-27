module("modules.logic.reactivity.view.ReactivityStoreGoodsItem", package.seeall)

slot0 = class("ReactivityStoreGoodsItem", UserDataDispose)

function slot0.onInitView(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.goClick = gohelper.getClick(slot1)
	slot0.goTag = gohelper.findChild(slot0.go, "go_tag")
	slot0.txtTag = gohelper.findChildText(slot0.go, "go_tag/txt_tag")
	slot0.txtLimitBuy = gohelper.findChildText(slot0.go, "txt_limitbuy")
	slot0.imageRare = gohelper.findChildImage(slot0.go, "image_rare")
	slot0.simageIcon = gohelper.findChildSingleImage(slot0.go, "simage_icon")
	slot0.imageIcon = gohelper.findChildImage(slot0.go, "simage_icon")
	slot0.goQuantity = gohelper.findChild(slot0.go, "quantity")
	slot0.txtQuantity = gohelper.findChildText(slot0.go, "quantity/txt_quantity")
	slot0.txtName = gohelper.findChildText(slot0.go, "txt_name")
	slot0.txtCost = gohelper.findChildText(slot0.go, "txt_cost")
	slot0.simageCoin = gohelper.findChildSingleImage(slot0.go, "txt_cost/simage_coin")
	slot0.imageCoin = gohelper.findChildImage(slot0.go, "txt_cost/simage_coin")
	slot0.goSoldout = gohelper.findChild(slot0.go, "go_soldout")
	slot0.goSwitch = gohelper.findChild(slot0.go, "switch_icon")
	slot0.simageSwitchIcon1 = gohelper.findChildSingleImage(slot0.go, "switch_icon/simage_icon1")
	slot0.imageSwitchIcon1 = gohelper.findChildImage(slot0.go, "switch_icon/simage_icon1")
	slot0.goQuantity1 = gohelper.findChild(slot0.go, "switch_icon/quantity1")
	slot0.txtQuantity1 = gohelper.findChildText(slot0.goQuantity1, "txt_quantity")
	slot0.simageSwitchIcon2 = gohelper.findChildSingleImage(slot0.go, "switch_icon/simage_icon2")
	slot0.imageSwitchIcon2 = gohelper.findChildImage(slot0.go, "switch_icon/simage_icon2")
	slot0.goQuantity2 = gohelper.findChild(slot0.go, "switch_icon/quantity2")
	slot0.txtQuantity2 = gohelper.findChildText(slot0.goQuantity2, "txt_quantity")
	slot0.goIconExchange = gohelper.findChild(slot0.go, "icon_exchange")

	slot0.goClick:AddClickListener(slot0.onClick, slot0)

	slot0.goMaxRareEffect = gohelper.findChild(slot0.go, "eff_rare5")
end

function slot0.onClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if slot0.remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivityNormalStoreGoodsView, slot0.storeGoodsCo)
end

function slot0.updateInfo(slot0, slot1)
	gohelper.setActive(slot0.go, true)

	slot0.storeGoodsCo = slot1

	slot0:refreshRemainBuyCount()

	slot2, slot3, slot4 = slot0:getItemTypeIdQuantity(slot0.storeGoodsCo.product)
	slot6, slot7 = ReactivityConfig.instance:checkItemNeedConvert(slot2, slot3)
	slot8 = nil

	if not ItemModel.instance:getItemConfigAndIcon(slot2, slot3).rare then
		logWarn("material type : %s, material id : %s not had rare attribute")

		slot8 = 5
	else
		slot8 = slot5.rare
	end

	gohelper.setActive(slot0.goMaxRareEffect, slot8 >= 5)
	UISpriteSetMgr.instance:setV1a8MainActivitySprite(slot0.imageRare, "v1a8_store_quality_" .. slot8)

	if slot6 and slot0.remainBuyCount > 0 then
		gohelper.setActive(slot0.goIconExchange, true)
		gohelper.setActive(slot0.simageIcon, false)
		gohelper.setActive(slot0.goSwitch, false)
		gohelper.setActive(slot0.goSwitch, true)
		gohelper.setActive(slot0.goQuantity, false)
		slot0:loadItemSingleImage(slot0.simageSwitchIcon1, slot0.imageSwitchIcon1, slot2, slot3)
		slot0:setQuantityTxt(slot0.goQuantity1, slot0.txtQuantity1, slot4)

		slot9 = string.splitToNumber(slot7, "#")

		slot0:loadItemSingleImage(slot0.simageSwitchIcon2, slot0.imageSwitchIcon2, slot9[1], slot9[2])
		slot0:setQuantityTxt(slot0.goQuantity2, slot0.txtQuantity2, slot9[3])
	else
		gohelper.setActive(slot0.goIconExchange, false)
		gohelper.setActive(slot0.simageIcon, true)
		gohelper.setActive(slot0.goSwitch, false)
		slot0:loadItemSingleImage(slot0.simageIcon, slot0.imageIcon, slot2, slot3)
		slot0:setQuantityTxt(slot0.goQuantity, slot0.txtQuantity, slot4)
	end

	gohelper.setActive(slot0.txtName, false)

	if MaterialEnum.ItemRareR <= slot8 then
		if gohelper.findChildText(slot0.go, "txt_name" .. slot8) then
			slot0.txtName = slot9
		end
	else
		slot0.txtName = gohelper.findChildText(slot0.go, "txt_name")
	end

	gohelper.setActive(slot0.txtName, true)

	slot0.txtName.text = slot5.name
	slot0.costItemType, slot0.costItemId, slot0.costItemQuantity = slot0:getItemTypeIdQuantity(slot0.storeGoodsCo.cost)
	slot0.txtCost.text = slot0.costItemQuantity
	slot9, slot10 = ItemModel.instance:getItemConfigAndIcon(slot0.costItemType, slot0.costItemId)

	if slot0.costItemType == MaterialEnum.MaterialType.Currency then
		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0.imageCoin, slot9.icon .. "_1")
	else
		slot0.simageCoin:LoadImage(slot10)
	end

	slot0:refreshTag()
end

function slot0.setQuantityTxt(slot0, slot1, slot2, slot3)
	gohelper.setActive(slot1, slot3 > 1)

	if slot3 > 1 then
		slot2.text = luaLang("multiple") .. slot3
	end
end

function slot0.loadItemSingleImage(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(slot3, slot4)

	if slot3 == MaterialEnum.MaterialType.Equip then
		slot1:LoadImage(ResUrl.getHeroDefaultEquipIcon(slot5.icon), function ()
			uv0:SetNativeSize()
		end)
	else
		slot1:LoadImage(slot6, function ()
			uv0:SetNativeSize()
		end)
	end
end

function slot0.refreshRemainBuyCount(slot0)
	if slot0.storeGoodsCo.maxBuyCount == 0 then
		gohelper.setActive(slot0.txtLimitBuy.gameObject, false)
		gohelper.setActive(slot0.goSoldout, false)

		slot0.remainBuyCount = 9999
	else
		gohelper.setActive(slot0.txtLimitBuy.gameObject, true)

		slot0.remainBuyCount = slot0.storeGoodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(slot0.storeGoodsCo.activityId, slot0.storeGoodsCo.id)
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
