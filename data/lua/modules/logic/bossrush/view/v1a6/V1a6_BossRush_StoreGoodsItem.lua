module("modules.logic.bossrush.view.v1a6.V1a6_BossRush_StoreGoodsItem", package.seeall)

slot0 = class("V1a6_BossRush_StoreGoodsItem", UserDataDispose)

function slot0.onInitView(slot0, slot1)
	slot0:__onInit()

	slot0.go = slot1
	slot0.goTag = gohelper.findChild(slot0.go, "go_tag")
	slot0.txtLimitBuy = gohelper.findChildText(slot0.go, "layout/txt_limitbuy")
	slot0.imageRare = gohelper.findChildImage(slot0.go, "image_rare")
	slot0.goMaxRareEffect = gohelper.findChild(slot0.go, "eff_rare5")
	slot0.simageIcon = gohelper.findChildSingleImage(slot0.go, "goIcon/simage_icon")
	slot0.imageIcon = gohelper.findChildImage(slot0.go, "goIcon/simage_icon")
	slot0.goQuantity = gohelper.findChild(slot0.go, "quantity")
	slot0.txtQuantity = gohelper.findChildText(slot0.go, "quantity/bg/txt_quantity")
	slot0.txtCost = gohelper.findChildText(slot0.go, "txt_cost")
	slot0.simageCoin = gohelper.findChildSingleImage(slot0.go, "txt_cost/simage_coin")
	slot0.imageCoin = gohelper.findChildImage(slot0.go, "txt_cost/simage_coin")
	slot0.goSoldout = gohelper.findChild(slot0.go, "go_soldout")
	slot0.goClick = gohelper.findChildButtonWithAudio(slot0.go, "goClick")
	slot0.reddot = gohelper.findChild(slot0.go, "#go_reddot")

	slot0.goClick:AddClickListener(slot0.onClick, slot0)
end

function slot0.onClick(slot0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if slot0.remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	ViewMgr.instance:openView(ViewName.NormalStoreGoodsView, slot0._mo)
	BossRushController.instance:dispatchEvent(BossRushEvent.OnHandleInStoreView)
	slot0:clearNewTag()
end

function slot0.updateInfo(slot0, slot1)
	gohelper.setActive(slot0.go, true)

	slot0._mo = slot1
	slot0._co = slot1.config

	slot0:refreshRemainBuyCount()

	slot2, slot3, slot4 = slot0:getItemTypeIdQuantity(slot0._co.product)
	slot5, slot6 = ItemModel.instance:getItemConfigAndIcon(slot2, slot3)
	slot7 = nil

	if not slot5.rare then
		logWarn("material type : %s, material id : %s not had rare attribute")

		slot7 = 5
	else
		slot7 = slot5.rare
	end

	UISpriteSetMgr.instance:setStoreGoodsSprite(slot0.imageRare, "rare" .. slot7)
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

	slot0.txtName = gohelper.findChildText(slot0.go, "layout/txt_name")

	gohelper.setActive(slot0.txtName, true)

	slot0.txtName.text = slot5.name

	gohelper.setActive(slot0.goQuantity, slot4 > 1)

	slot0.txtQuantity.text = slot4 > 1 and slot4 or ""
	slot0.costItemType, slot0.costItemId, slot0.costItemQuantity = slot0:getItemTypeIdQuantity(slot0._co.cost)
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
	if slot0._co.maxBuyCount == 0 then
		gohelper.setActive(slot0.txtLimitBuy.gameObject, false)
		gohelper.setActive(slot0.goSoldout, false)

		slot0.remainBuyCount = 9999
	else
		gohelper.setActive(slot0.txtLimitBuy.gameObject, true)

		slot0.remainBuyCount = slot0._co.maxBuyCount - slot0._mo.buyCount
		slot0.txtLimitBuy.text = string.format(luaLang("v1a4_bossrush_storeview_buylimit"), slot0.remainBuyCount)

		gohelper.setActive(slot0.goSoldout, slot0.remainBuyCount <= 0)
	end
end

function slot0.refreshTag(slot0)
	if slot0._co.tag == 0 or slot0.remainBuyCount <= 0 then
		gohelper.setActive(slot0.goTag, false)

		return
	end

	gohelper.setActive(slot0.goTag, true)
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

function slot0.updateNewData(slot0, slot1)
	gohelper.setActive(slot0.reddot, slot1 and slot1.isNew)
end

function slot0.clearNewTag(slot0)
	V1a6_BossRush_StoreModel.instance:onClickGoodsItem(slot0._mo.belongStoreId, slot0._mo.goodsId)
	gohelper.setActive(slot0.reddot, false)
end

return slot0
