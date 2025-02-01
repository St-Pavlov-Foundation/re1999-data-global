module("modules.logic.versionactivity1_2.versionactivity1_2dungeonother.view.VersionActivity1_2StoreGoodsItem", package.seeall)

slot0 = class("VersionActivity1_2StoreGoodsItem", UserDataDispose)

function slot0.onInitView(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.goClick = gohelper.getClick(slot1)
	slot0.imageBg = gohelper.findChildImage(slot0.go, "image_bg")
	slot0._goDiscount = gohelper.findChild(slot0.go, "go_discount")
	slot0.txtDiscount = gohelper.findChildText(slot0.go, "go_discount/txt_discount")
	slot0.txtLimitBuy = gohelper.findChildText(slot0.go, "layout/txt_remain")
	slot0.imageRare = gohelper.findChildImage(slot0.go, "image_rare")
	slot0.goMaxRareEffect = gohelper.findChild(slot0.go, "eff_rare5")
	slot0.simageIcon = gohelper.findChildSingleImage(slot0.go, "simage_icon")
	slot0.imageBar = gohelper.findChildImage(slot0.go, "layout/image_bar")
	slot0.imageIcon = gohelper.findChildImage(slot0.go, "simage_icon")
	slot0.goQuantity = gohelper.findChild(slot0.go, "quantity")
	slot0.txtQuantity = gohelper.findChildText(slot0.go, "quantity/txt_quantity")
	slot0.txtName = gohelper.findChildText(slot0.go, "layout/txt_goodsName")
	slot0.txtCost = gohelper.findChildText(slot0.go, "cost/txt_cost")
	slot0.simageCoin = gohelper.findChildSingleImage(slot0.go, "cost/txt_cost/simage_coin")
	slot0.imageCoin = gohelper.findChildImage(slot0.go, "cost/txt_cost/simage_coin")
	slot0.goOriginCost = gohelper.findChild(slot0.go, "cost/go_origincost")
	slot0.goSoldout = gohelper.findChild(slot0.go, "go_soldout")

	slot0.goClick:AddClickListener(slot0.onClick, slot0)
	gohelper.setActive(slot0.goOriginCost, false)
	slot0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, slot0.onBuyGoodsSuccess, slot0)

	slot0._txtOutlineColor = {
		"#D0D0D0FF",
		"#D0D0D0FF",
		"#745A7CFF",
		"#997C2EFF",
		"#B36B24FF"
	}
end

function slot0.onClick(slot0)
	if slot0.remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivityNormalStoreGoodsView, slot0.storeGoodsCo)
end

function slot0.onBuyGoodsSuccess(slot0, slot1, slot2)
	if slot1 ~= slot0.storeGoodsCo.activityId or slot2 ~= slot0.storeGoodsCo.id then
		return
	end

	slot0:refreshRemainBuyCount()
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

	UISpriteSetMgr.instance:setVersionActivity1_2Sprite(slot0.imageRare, "img_pinzhi_" .. slot7 + 1)
	UISpriteSetMgr.instance:setVersionActivity1_2Sprite(slot0.imageBg, "shangpin_di_" .. slot7 + 1)

	if slot7 > 2 then
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(slot0.imageBar, "bg_zhongdian_" .. slot7 + 1)
	end

	gohelper.setActive(slot0.imageBar.gameObject, slot7 > 2)
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

	gohelper.setActive(slot0._goDiscount, slot0.storeGoodsCo.tag > 0)

	slot0.txtDiscount.text = slot0.storeGoodsCo.tag > 0 and luaLang("versionactivity_1_2_storeview_tagtype_" .. slot0.storeGoodsCo.tag) or ""
	slot0.fontMaterial = slot0.fontMaterial or UnityEngine.Object.Instantiate(slot0.txtName.fontMaterial)
	slot0.txtName.fontMaterial = slot0.fontMaterial

	slot0.txtName.fontMaterial:SetFloat("_OutlineWidth", slot7 > 2 and 0.03 or 0)
	slot0.txtName.fontMaterial:SetColor("_OutlineColor", GameUtil.parseColor(slot0._txtOutlineColor[slot7]))
end

function slot0.refreshRemainBuyCount(slot0)
	if slot0.storeGoodsCo.maxBuyCount == 0 then
		gohelper.setActive(slot0.txtLimitBuy.gameObject, false)
		gohelper.setActive(slot0.goSoldout, false)

		slot0.remainBuyCount = 9999
	else
		gohelper.setActive(slot0.txtLimitBuy.gameObject, true)

		slot0.remainBuyCount = slot0.storeGoodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_2Enum.ActivityId.DungeonStore, slot0.storeGoodsCo.id)
		slot0.txtLimitBuy.text = luaLang("store_buylimit") .. slot0.remainBuyCount

		gohelper.setActive(slot0.goSoldout, slot0.remainBuyCount <= 0)
	end
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
	slot0:removeEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, slot0.onBuyGoodsSuccess, slot0)
	slot0:__onDispose()
end

return slot0
