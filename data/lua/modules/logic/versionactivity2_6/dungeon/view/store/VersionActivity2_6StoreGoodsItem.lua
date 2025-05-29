module("modules.logic.versionactivity2_6.dungeon.view.store.VersionActivity2_6StoreGoodsItem", package.seeall)

local var_0_0 = class("VersionActivity2_6StoreGoodsItem", ListScrollCell)

function var_0_0.init(arg_1_0, arg_1_1)
	arg_1_0.go = arg_1_1
	arg_1_0.goTag = gohelper.findChild(arg_1_0.go, "go_tag")
	arg_1_0.txtTag = gohelper.findChildText(arg_1_0.go, "go_tag/txt_tag")
	arg_1_0.txtLimitBuy = gohelper.findChildText(arg_1_0.go, "txt_limitbuy")
	arg_1_0.imageRare = gohelper.findChildImage(arg_1_0.go, "image_rare")
	arg_1_0.goMaxRareEffect = gohelper.findChild(arg_1_0.go, "eff_rare5")
	arg_1_0.simageIcon = gohelper.findChildSingleImage(arg_1_0.go, "simage_icon")
	arg_1_0.imageIcon = gohelper.findChildImage(arg_1_0.go, "simage_icon")
	arg_1_0.goQuantity = gohelper.findChild(arg_1_0.go, "quantity")
	arg_1_0.txtQuantity = gohelper.findChildText(arg_1_0.go, "quantity/txt_quantity")
	arg_1_0.txtCost = gohelper.findChildText(arg_1_0.go, "txt_cost")
	arg_1_0.simageCoin = gohelper.findChildSingleImage(arg_1_0.go, "txt_cost/simage_coin")
	arg_1_0.imageCoin = gohelper.findChildImage(arg_1_0.go, "txt_cost/simage_coin")
	arg_1_0.goSoldout = gohelper.findChild(arg_1_0.go, "go_soldout")
	arg_1_0.goClick = gohelper.getClickWithDefaultAudio(arg_1_1)

	arg_1_0.goClick:AddClickListener(arg_1_0.onClick, arg_1_0)
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0.onClick(arg_4_0)
	if arg_4_0.remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_5NormalStoreGoodsView, arg_4_0.goodsCo)
end

function var_0_0.onUpdateMO(arg_5_0, arg_5_1)
	arg_5_0.goodsCo = arg_5_1

	arg_5_0:updateProductCo()
	arg_5_0:updateRare()
	arg_5_0:refreshRemainBuyCount()
	gohelper.setActive(arg_5_0.go, true)
	arg_5_0:refreshUI()
end

function var_0_0.updateProductCo(arg_6_0)
	arg_6_0.productItemType, arg_6_0.productItemId, arg_6_0.productQuantity = arg_6_0:getItemTypeIdQuantity(arg_6_0.goodsCo.product)
	arg_6_0.productConfig, arg_6_0.productIconUrl = ItemModel.instance:getItemConfigAndIcon(arg_6_0.productItemType, arg_6_0.productItemId)
end

function var_0_0.updateRare(arg_7_0)
	arg_7_0.rare = arg_7_0.productConfig.rare

	if not arg_7_0.rare then
		logWarn("material type : %s, material id : %s not had rare attribute")

		arg_7_0.rare = 5
	end
end

function var_0_0.refreshRemainBuyCount(arg_8_0)
	if arg_8_0.goodsCo.maxBuyCount == 0 then
		gohelper.setActive(arg_8_0.txtLimitBuy.gameObject, false)
		gohelper.setActive(arg_8_0.goSoldout, false)

		arg_8_0.remainBuyCount = 9999
	else
		gohelper.setActive(arg_8_0.txtLimitBuy.gameObject, true)

		arg_8_0.remainBuyCount = arg_8_0.goodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity2_6Enum.ActivityId.DungeonStore, arg_8_0.goodsCo.id)
		arg_8_0.txtLimitBuy.text = formatLuaLang("v1a4_bossrush_storeview_buylimit", arg_8_0.remainBuyCount)

		gohelper.setActive(arg_8_0.goSoldout, arg_8_0.remainBuyCount <= 0)
	end
end

function var_0_0.refreshUI(arg_9_0)
	arg_9_0:refreshRareBg()
	arg_9_0:refreshIcon()
	arg_9_0:refreshTag()
	arg_9_0:refreshName()
	arg_9_0:refreshQuantity()
	arg_9_0:refreshCost()
end

function var_0_0.refreshRareBg(arg_10_0)
	UISpriteSetMgr.instance:setV2a6MainActivitySprite(arg_10_0.imageRare, "v2a6_store_quality_" .. arg_10_0.rare)
	gohelper.setActive(arg_10_0.goMaxRareEffect, arg_10_0.rare >= 5)
end

function var_0_0.refreshIcon(arg_11_0)
	if arg_11_0.productItemType == MaterialEnum.MaterialType.Equip then
		arg_11_0.simageIcon:LoadImage(ResUrl.getHeroDefaultEquipIcon(arg_11_0.productConfig.icon), arg_11_0.setNativeSize, arg_11_0)
	else
		arg_11_0.simageIcon:LoadImage(arg_11_0.productIconUrl, arg_11_0.setNativeSize, arg_11_0)
	end
end

function var_0_0.setNativeSize(arg_12_0)
	arg_12_0.imageIcon:SetNativeSize()
end

function var_0_0.refreshTag(arg_13_0)
	if arg_13_0.goodsCo.tag == 0 or arg_13_0.remainBuyCount <= 0 then
		gohelper.setActive(arg_13_0.goTag, false)

		return
	end

	gohelper.setActive(arg_13_0.goTag, true)

	arg_13_0.txtTag.text = ActivityStoreConfig.instance:getTagName(arg_13_0.goodsCo.tag)
end

function var_0_0.refreshName(arg_14_0)
	gohelper.setActive(arg_14_0.txtName, false)

	if arg_14_0.rare >= MaterialEnum.ItemRareR then
		arg_14_0.txtName = gohelper.findChildText(arg_14_0.go, "txt_name" .. arg_14_0.rare)
	else
		arg_14_0.txtName = gohelper.findChildText(arg_14_0.go, "txt_name")
	end

	gohelper.setActive(arg_14_0.txtName, true)

	arg_14_0.txtName.text = arg_14_0.productConfig.name
end

function var_0_0.refreshQuantity(arg_15_0)
	local var_15_0 = arg_15_0.productQuantity > 1

	gohelper.setActive(arg_15_0.goQuantity, var_15_0)

	if var_15_0 then
		arg_15_0.txtQuantity.text = luaLang("multiple") .. arg_15_0.productQuantity
	end
end

function var_0_0.refreshCost(arg_16_0)
	local var_16_0, var_16_1, var_16_2 = arg_16_0:getItemTypeIdQuantity(arg_16_0.goodsCo.cost)

	arg_16_0.txtCost.text = var_16_2

	local var_16_3, var_16_4 = ItemModel.instance:getItemConfigAndIcon(var_16_0, var_16_1)

	if var_16_0 == MaterialEnum.MaterialType.Currency then
		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_16_0.imageCoin, var_16_3.icon .. "_1")
	else
		arg_16_0.simageCoin:LoadImage(var_16_4)
	end
end

function var_0_0.getItemTypeIdQuantity(arg_17_0, arg_17_1)
	local var_17_0 = string.splitToNumber(arg_17_1, "#")

	return var_17_0[1], var_17_0[2], var_17_0[3]
end

function var_0_0.onDestroy(arg_18_0)
	arg_18_0.goClick:RemoveClickListener()
	arg_18_0.simageIcon:UnLoadImage()
	arg_18_0.simageCoin:UnLoadImage()
end

return var_0_0
