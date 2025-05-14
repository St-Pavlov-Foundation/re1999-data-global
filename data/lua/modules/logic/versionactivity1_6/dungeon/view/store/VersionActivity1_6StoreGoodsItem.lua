module("modules.logic.versionactivity1_6.dungeon.view.store.VersionActivity1_6StoreGoodsItem", package.seeall)

local var_0_0 = class("VersionActivity1_6StoreGoodsItem", UserDataDispose)

function var_0_0.onInitView(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.goClick = gohelper.getClick(arg_1_1)
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

	arg_1_0.goClick:AddClickListener(arg_1_0.onClick, arg_1_0)
end

function var_0_0.onClick(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if arg_2_0.remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_6NormalStoreGoodsView, arg_2_0.storeGoodsCo)
end

function var_0_0.updateInfo(arg_3_0, arg_3_1)
	gohelper.setActive(arg_3_0.go, true)

	arg_3_0.storeGoodsCo = arg_3_1

	arg_3_0:refreshRemainBuyCount()

	local var_3_0, var_3_1, var_3_2 = arg_3_0:getItemTypeIdQuantity(arg_3_0.storeGoodsCo.product)
	local var_3_3, var_3_4 = ItemModel.instance:getItemConfigAndIcon(var_3_0, var_3_1)
	local var_3_5
	local var_3_6

	if not var_3_3.rare then
		logWarn("material type : %s, material id : %s not had rare attribute")

		var_3_6 = 5
	else
		var_3_6 = var_3_3.rare
	end

	UISpriteSetMgr.instance:setV1a6DungeonStoreSprite(arg_3_0.imageRare, "v1a6_store_quality_" .. var_3_6)
	gohelper.setActive(arg_3_0.goMaxRareEffect, var_3_6 >= 5)

	if var_3_0 == MaterialEnum.MaterialType.Equip then
		arg_3_0.simageIcon:LoadImage(ResUrl.getHeroDefaultEquipIcon(var_3_3.icon), function()
			arg_3_0.imageIcon:SetNativeSize()
		end)
	else
		arg_3_0.simageIcon:LoadImage(var_3_4, function()
			arg_3_0.imageIcon:SetNativeSize()
		end)
	end

	gohelper.setActive(arg_3_0.txtName, false)

	if var_3_6 >= MaterialEnum.ItemRareR then
		arg_3_0.txtName = gohelper.findChildText(arg_3_0.go, "txt_name" .. var_3_6)
	else
		arg_3_0.txtName = gohelper.findChildText(arg_3_0.go, "txt_name")
	end

	gohelper.setActive(arg_3_0.txtName, true)

	arg_3_0.txtName.text = var_3_3.name

	gohelper.setActive(arg_3_0.goQuantity, var_3_2 > 1)

	arg_3_0.txtQuantity.text = var_3_2 > 1 and luaLang("multiple") .. var_3_2 or ""
	arg_3_0.costItemType, arg_3_0.costItemId, arg_3_0.costItemQuantity = arg_3_0:getItemTypeIdQuantity(arg_3_0.storeGoodsCo.cost)
	arg_3_0.txtCost.text = arg_3_0.costItemQuantity

	local var_3_7, var_3_8 = ItemModel.instance:getItemConfigAndIcon(arg_3_0.costItemType, arg_3_0.costItemId)

	if arg_3_0.costItemType == MaterialEnum.MaterialType.Currency then
		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_3_0.imageCoin, var_3_7.icon .. "_1")
	else
		arg_3_0.simageCoin:LoadImage(var_3_8)
	end

	arg_3_0:refreshTag()
end

function var_0_0.refreshRemainBuyCount(arg_6_0)
	if arg_6_0.storeGoodsCo.maxBuyCount == 0 then
		gohelper.setActive(arg_6_0.txtLimitBuy.gameObject, false)
		gohelper.setActive(arg_6_0.goSoldout, false)

		arg_6_0.remainBuyCount = 9999
	else
		gohelper.setActive(arg_6_0.txtLimitBuy.gameObject, true)

		arg_6_0.remainBuyCount = arg_6_0.storeGoodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_6Enum.ActivityId.DungeonStore, arg_6_0.storeGoodsCo.id)
		arg_6_0.txtLimitBuy.text = formatLuaLang("v1a4_bossrush_storeview_buylimit", arg_6_0.remainBuyCount)

		gohelper.setActive(arg_6_0.goSoldout, arg_6_0.remainBuyCount <= 0)
	end
end

function var_0_0.refreshTag(arg_7_0)
	if arg_7_0.storeGoodsCo.tag == 0 or arg_7_0.remainBuyCount <= 0 then
		gohelper.setActive(arg_7_0.goTag, false)

		return
	end

	gohelper.setActive(arg_7_0.goTag, true)

	arg_7_0.txtTag.text = ActivityStoreConfig.instance:getTagName(arg_7_0.storeGoodsCo.tag)
end

function var_0_0.getItemTypeIdQuantity(arg_8_0, arg_8_1)
	local var_8_0 = string.splitToNumber(arg_8_1, "#")

	return var_8_0[1], var_8_0[2], var_8_0[3]
end

function var_0_0.hide(arg_9_0)
	gohelper.setActive(arg_9_0.go, false)
end

function var_0_0.onDestroy(arg_10_0)
	arg_10_0.goClick:RemoveClickListener()
	arg_10_0.simageIcon:UnLoadImage()
	arg_10_0.simageCoin:UnLoadImage()
	arg_10_0:__onDispose()
end

return var_0_0
