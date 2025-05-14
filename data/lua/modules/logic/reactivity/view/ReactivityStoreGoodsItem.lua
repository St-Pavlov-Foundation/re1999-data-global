module("modules.logic.reactivity.view.ReactivityStoreGoodsItem", package.seeall)

local var_0_0 = class("ReactivityStoreGoodsItem", UserDataDispose)

function var_0_0.onInitView(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.goClick = gohelper.getClick(arg_1_1)
	arg_1_0.goTag = gohelper.findChild(arg_1_0.go, "go_tag")
	arg_1_0.txtTag = gohelper.findChildText(arg_1_0.go, "go_tag/txt_tag")
	arg_1_0.txtLimitBuy = gohelper.findChildText(arg_1_0.go, "txt_limitbuy")
	arg_1_0.imageRare = gohelper.findChildImage(arg_1_0.go, "image_rare")
	arg_1_0.simageIcon = gohelper.findChildSingleImage(arg_1_0.go, "simage_icon")
	arg_1_0.imageIcon = gohelper.findChildImage(arg_1_0.go, "simage_icon")
	arg_1_0.goQuantity = gohelper.findChild(arg_1_0.go, "quantity")
	arg_1_0.txtQuantity = gohelper.findChildText(arg_1_0.go, "quantity/txt_quantity")
	arg_1_0.txtName = gohelper.findChildText(arg_1_0.go, "txt_name")
	arg_1_0.txtCost = gohelper.findChildText(arg_1_0.go, "txt_cost")
	arg_1_0.simageCoin = gohelper.findChildSingleImage(arg_1_0.go, "txt_cost/simage_coin")
	arg_1_0.imageCoin = gohelper.findChildImage(arg_1_0.go, "txt_cost/simage_coin")
	arg_1_0.goSoldout = gohelper.findChild(arg_1_0.go, "go_soldout")
	arg_1_0.goSwitch = gohelper.findChild(arg_1_0.go, "switch_icon")
	arg_1_0.simageSwitchIcon1 = gohelper.findChildSingleImage(arg_1_0.go, "switch_icon/simage_icon1")
	arg_1_0.imageSwitchIcon1 = gohelper.findChildImage(arg_1_0.go, "switch_icon/simage_icon1")
	arg_1_0.goQuantity1 = gohelper.findChild(arg_1_0.go, "switch_icon/quantity1")
	arg_1_0.txtQuantity1 = gohelper.findChildText(arg_1_0.goQuantity1, "txt_quantity")
	arg_1_0.simageSwitchIcon2 = gohelper.findChildSingleImage(arg_1_0.go, "switch_icon/simage_icon2")
	arg_1_0.imageSwitchIcon2 = gohelper.findChildImage(arg_1_0.go, "switch_icon/simage_icon2")
	arg_1_0.goQuantity2 = gohelper.findChild(arg_1_0.go, "switch_icon/quantity2")
	arg_1_0.txtQuantity2 = gohelper.findChildText(arg_1_0.goQuantity2, "txt_quantity")
	arg_1_0.goIconExchange = gohelper.findChild(arg_1_0.go, "icon_exchange")

	arg_1_0.goClick:AddClickListener(arg_1_0.onClick, arg_1_0)

	arg_1_0.goMaxRareEffect = gohelper.findChild(arg_1_0.go, "eff_rare5")
end

function var_0_0.onClick(arg_2_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if arg_2_0.remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivityNormalStoreGoodsView, arg_2_0.storeGoodsCo)
end

function var_0_0.updateInfo(arg_3_0, arg_3_1)
	gohelper.setActive(arg_3_0.go, true)

	arg_3_0.storeGoodsCo = arg_3_1

	arg_3_0:refreshRemainBuyCount()

	local var_3_0, var_3_1, var_3_2 = arg_3_0:getItemTypeIdQuantity(arg_3_0.storeGoodsCo.product)
	local var_3_3 = ItemModel.instance:getItemConfigAndIcon(var_3_0, var_3_1)
	local var_3_4, var_3_5 = ReactivityConfig.instance:checkItemNeedConvert(var_3_0, var_3_1)
	local var_3_6
	local var_3_7

	if not var_3_3.rare then
		logWarn("material type : %s, material id : %s not had rare attribute")

		var_3_7 = 5
	else
		var_3_7 = var_3_3.rare
	end

	gohelper.setActive(arg_3_0.goMaxRareEffect, var_3_7 >= 5)
	UISpriteSetMgr.instance:setV1a8MainActivitySprite(arg_3_0.imageRare, "v1a8_store_quality_" .. var_3_7)

	if var_3_4 and arg_3_0.remainBuyCount > 0 then
		gohelper.setActive(arg_3_0.goIconExchange, true)
		gohelper.setActive(arg_3_0.simageIcon, false)
		gohelper.setActive(arg_3_0.goSwitch, false)
		gohelper.setActive(arg_3_0.goSwitch, true)
		gohelper.setActive(arg_3_0.goQuantity, false)
		arg_3_0:loadItemSingleImage(arg_3_0.simageSwitchIcon1, arg_3_0.imageSwitchIcon1, var_3_0, var_3_1)
		arg_3_0:setQuantityTxt(arg_3_0.goQuantity1, arg_3_0.txtQuantity1, var_3_2)

		local var_3_8 = string.splitToNumber(var_3_5, "#")

		arg_3_0:loadItemSingleImage(arg_3_0.simageSwitchIcon2, arg_3_0.imageSwitchIcon2, var_3_8[1], var_3_8[2])
		arg_3_0:setQuantityTxt(arg_3_0.goQuantity2, arg_3_0.txtQuantity2, var_3_8[3])
	else
		gohelper.setActive(arg_3_0.goIconExchange, false)
		gohelper.setActive(arg_3_0.simageIcon, true)
		gohelper.setActive(arg_3_0.goSwitch, false)
		arg_3_0:loadItemSingleImage(arg_3_0.simageIcon, arg_3_0.imageIcon, var_3_0, var_3_1)
		arg_3_0:setQuantityTxt(arg_3_0.goQuantity, arg_3_0.txtQuantity, var_3_2)
	end

	gohelper.setActive(arg_3_0.txtName, false)

	if var_3_7 >= MaterialEnum.ItemRareR then
		local var_3_9 = gohelper.findChildText(arg_3_0.go, "txt_name" .. var_3_7)

		if var_3_9 then
			arg_3_0.txtName = var_3_9
		end
	else
		arg_3_0.txtName = gohelper.findChildText(arg_3_0.go, "txt_name")
	end

	gohelper.setActive(arg_3_0.txtName, true)

	arg_3_0.txtName.text = var_3_3.name
	arg_3_0.costItemType, arg_3_0.costItemId, arg_3_0.costItemQuantity = arg_3_0:getItemTypeIdQuantity(arg_3_0.storeGoodsCo.cost)
	arg_3_0.txtCost.text = arg_3_0.costItemQuantity

	local var_3_10, var_3_11 = ItemModel.instance:getItemConfigAndIcon(arg_3_0.costItemType, arg_3_0.costItemId)

	if arg_3_0.costItemType == MaterialEnum.MaterialType.Currency then
		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_3_0.imageCoin, var_3_10.icon .. "_1")
	else
		arg_3_0.simageCoin:LoadImage(var_3_11)
	end

	arg_3_0:refreshTag()
end

function var_0_0.setQuantityTxt(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	gohelper.setActive(arg_4_1, arg_4_3 > 1)

	if arg_4_3 > 1 then
		arg_4_2.text = luaLang("multiple") .. arg_4_3
	end
end

function var_0_0.loadItemSingleImage(arg_5_0, arg_5_1, arg_5_2, arg_5_3, arg_5_4)
	local var_5_0, var_5_1 = ItemModel.instance:getItemConfigAndIcon(arg_5_3, arg_5_4)

	if arg_5_3 == MaterialEnum.MaterialType.Equip then
		arg_5_1:LoadImage(ResUrl.getHeroDefaultEquipIcon(var_5_0.icon), function()
			arg_5_2:SetNativeSize()
		end)
	else
		arg_5_1:LoadImage(var_5_1, function()
			arg_5_2:SetNativeSize()
		end)
	end
end

function var_0_0.refreshRemainBuyCount(arg_8_0)
	if arg_8_0.storeGoodsCo.maxBuyCount == 0 then
		gohelper.setActive(arg_8_0.txtLimitBuy.gameObject, false)
		gohelper.setActive(arg_8_0.goSoldout, false)

		arg_8_0.remainBuyCount = 9999
	else
		gohelper.setActive(arg_8_0.txtLimitBuy.gameObject, true)

		arg_8_0.remainBuyCount = arg_8_0.storeGoodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(arg_8_0.storeGoodsCo.activityId, arg_8_0.storeGoodsCo.id)
		arg_8_0.txtLimitBuy.text = formatLuaLang("v1a4_bossrush_storeview_buylimit", arg_8_0.remainBuyCount)

		gohelper.setActive(arg_8_0.goSoldout, arg_8_0.remainBuyCount <= 0)
	end
end

function var_0_0.refreshTag(arg_9_0)
	if arg_9_0.storeGoodsCo.tag == 0 or arg_9_0.remainBuyCount <= 0 then
		gohelper.setActive(arg_9_0.goTag, false)

		return
	end

	gohelper.setActive(arg_9_0.goTag, true)

	arg_9_0.txtTag.text = ActivityStoreConfig.instance:getTagName(arg_9_0.storeGoodsCo.tag)
end

function var_0_0.getItemTypeIdQuantity(arg_10_0, arg_10_1)
	local var_10_0 = string.splitToNumber(arg_10_1, "#")

	return var_10_0[1], var_10_0[2], var_10_0[3]
end

function var_0_0.hide(arg_11_0)
	gohelper.setActive(arg_11_0.go, false)
end

function var_0_0.onDestroy(arg_12_0)
	arg_12_0.goClick:RemoveClickListener()
	arg_12_0.simageIcon:UnLoadImage()
	arg_12_0.simageCoin:UnLoadImage()
	arg_12_0:__onDispose()
end

return var_0_0
