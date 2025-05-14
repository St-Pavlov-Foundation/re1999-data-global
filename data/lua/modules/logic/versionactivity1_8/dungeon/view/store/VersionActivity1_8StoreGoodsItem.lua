module("modules.logic.versionactivity1_8.dungeon.view.store.VersionActivity1_8StoreGoodsItem", package.seeall)

local var_0_0 = class("VersionActivity1_8StoreGoodsItem", UserDataDispose)

function var_0_0.onInitView(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.goClick = gohelper.getClick(arg_1_1)
	arg_1_0.imageRare = gohelper.findChildImage(arg_1_0.go, "image_rare")
	arg_1_0.goMaxRareEffect = gohelper.findChild(arg_1_0.go, "eff_rare5")
	arg_1_0.goTag = gohelper.findChild(arg_1_0.go, "go_tag")
	arg_1_0.txtTag = gohelper.findChildText(arg_1_0.go, "go_tag/txt_tag")
	arg_1_0.txtLimitBuy = gohelper.findChildText(arg_1_0.go, "txt_limitbuy")
	arg_1_0.simageIcon = gohelper.findChildSingleImage(arg_1_0.go, "simage_icon")
	arg_1_0.imageIcon = gohelper.findChildImage(arg_1_0.go, "simage_icon")
	arg_1_0.txtName = gohelper.findChildText(arg_1_0.go, "txt_name")
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
	arg_3_0.storeGoodsCo = arg_3_1

	arg_3_0:refreshRemainBuyCount()

	local var_3_0, var_3_1, var_3_2 = VersionActivity1_8EnterHelper.getItemTypeIdQuantity(arg_3_0.storeGoodsCo.product)
	local var_3_3, var_3_4 = ItemModel.instance:getItemConfigAndIcon(var_3_0, var_3_1)
	local var_3_5 = MaterialEnum.ItemRareSSR

	if var_3_3.rare then
		var_3_5 = var_3_3.rare
	else
		logWarn("material type : %s, material id : %s not had rare attribute")
	end

	UISpriteSetMgr.instance:setV1a8MainActivitySprite(arg_3_0.imageRare, "v1a8_store_quality_" .. var_3_5)
	gohelper.setActive(arg_3_0.goMaxRareEffect, var_3_5 >= MaterialEnum.ItemRareSSR)

	if var_3_0 == MaterialEnum.MaterialType.Equip then
		local var_3_6 = ResUrl.getHeroDefaultEquipIcon(var_3_3.icon)

		arg_3_0.simageIcon:LoadImage(var_3_6, arg_3_0.setImageIconNative, arg_3_0)
	else
		arg_3_0.simageIcon:LoadImage(var_3_4, arg_3_0.setImageIconNative, arg_3_0)
	end

	gohelper.setActive(arg_3_0.txtName, false)

	if var_3_5 >= MaterialEnum.ItemRareR then
		local var_3_7 = gohelper.findChildText(arg_3_0.go, "txt_name" .. var_3_5)

		if var_3_7 then
			arg_3_0.txtName = var_3_7
		end
	end

	if arg_3_0.txtName then
		arg_3_0.txtName.text = var_3_3.name
	end

	gohelper.setActive(arg_3_0.txtName, true)
	gohelper.setActive(arg_3_0.goQuantity, var_3_2 > 1)

	arg_3_0.txtQuantity.text = var_3_2 > 1 and luaLang("multiple") .. var_3_2 or ""
	arg_3_0.costItemType, arg_3_0.costItemId, arg_3_0.costItemQuantity = VersionActivity1_8EnterHelper.getItemTypeIdQuantity(arg_3_0.storeGoodsCo.cost)
	arg_3_0.txtCost.text = arg_3_0.costItemQuantity

	local var_3_8, var_3_9 = ItemModel.instance:getItemConfigAndIcon(arg_3_0.costItemType, arg_3_0.costItemId)

	if arg_3_0.costItemType == MaterialEnum.MaterialType.Currency then
		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_3_0.imageCoin, var_3_8.icon .. "_1")
	else
		arg_3_0.simageCoin:LoadImage(var_3_9)
	end

	arg_3_0:refreshTag()
	gohelper.setActive(arg_3_0.go, true)
end

function var_0_0.refreshRemainBuyCount(arg_4_0)
	if arg_4_0.storeGoodsCo.maxBuyCount == 0 then
		gohelper.setActive(arg_4_0.txtLimitBuy.gameObject, false)
		gohelper.setActive(arg_4_0.goSoldout, false)

		arg_4_0.remainBuyCount = 9999
	else
		local var_4_0 = VersionActivity1_8Enum.ActivityId.DungeonStore

		gohelper.setActive(arg_4_0.txtLimitBuy.gameObject, true)

		arg_4_0.remainBuyCount = arg_4_0.storeGoodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(var_4_0, arg_4_0.storeGoodsCo.id)
		arg_4_0.txtLimitBuy.text = formatLuaLang("v1a4_bossrush_storeview_buylimit", arg_4_0.remainBuyCount)

		gohelper.setActive(arg_4_0.goSoldout, arg_4_0.remainBuyCount <= 0)
	end
end

function var_0_0.setImageIconNative(arg_5_0)
	arg_5_0.imageIcon:SetNativeSize()
end

function var_0_0.refreshTag(arg_6_0)
	if arg_6_0.storeGoodsCo.tag == 0 or arg_6_0.remainBuyCount <= 0 then
		gohelper.setActive(arg_6_0.goTag, false)

		return
	end

	gohelper.setActive(arg_6_0.goTag, true)

	arg_6_0.txtTag.text = ActivityStoreConfig.instance:getTagName(arg_6_0.storeGoodsCo.tag)
end

function var_0_0.hide(arg_7_0)
	gohelper.setActive(arg_7_0.go, false)
end

function var_0_0.onDestroy(arg_8_0)
	arg_8_0.goClick:RemoveClickListener()
	arg_8_0.simageIcon:UnLoadImage()
	arg_8_0.simageCoin:UnLoadImage()
	arg_8_0:__onDispose()
end

return var_0_0
