module("modules.logic.versionactivity1_2.versionactivity1_2dungeonother.view.VersionActivity1_2StoreGoodsItem", package.seeall)

local var_0_0 = class("VersionActivity1_2StoreGoodsItem", UserDataDispose)

function var_0_0.onInitView(arg_1_0, arg_1_1)
	arg_1_0:__onInit()

	arg_1_0.go = arg_1_1
	arg_1_0.goClick = gohelper.getClick(arg_1_1)
	arg_1_0.imageBg = gohelper.findChildImage(arg_1_0.go, "image_bg")
	arg_1_0._goDiscount = gohelper.findChild(arg_1_0.go, "go_discount")
	arg_1_0.txtDiscount = gohelper.findChildText(arg_1_0.go, "go_discount/txt_discount")
	arg_1_0.txtLimitBuy = gohelper.findChildText(arg_1_0.go, "layout/txt_remain")
	arg_1_0.imageRare = gohelper.findChildImage(arg_1_0.go, "image_rare")
	arg_1_0.goMaxRareEffect = gohelper.findChild(arg_1_0.go, "eff_rare5")
	arg_1_0.simageIcon = gohelper.findChildSingleImage(arg_1_0.go, "simage_icon")
	arg_1_0.imageBar = gohelper.findChildImage(arg_1_0.go, "layout/image_bar")
	arg_1_0.imageIcon = gohelper.findChildImage(arg_1_0.go, "simage_icon")
	arg_1_0.goQuantity = gohelper.findChild(arg_1_0.go, "quantity")
	arg_1_0.txtQuantity = gohelper.findChildText(arg_1_0.go, "quantity/txt_quantity")
	arg_1_0.txtName = gohelper.findChildText(arg_1_0.go, "layout/txt_goodsName")
	arg_1_0.txtCost = gohelper.findChildText(arg_1_0.go, "cost/txt_cost")
	arg_1_0.simageCoin = gohelper.findChildSingleImage(arg_1_0.go, "cost/txt_cost/simage_coin")
	arg_1_0.imageCoin = gohelper.findChildImage(arg_1_0.go, "cost/txt_cost/simage_coin")
	arg_1_0.goOriginCost = gohelper.findChild(arg_1_0.go, "cost/go_origincost")
	arg_1_0.goSoldout = gohelper.findChild(arg_1_0.go, "go_soldout")

	arg_1_0.goClick:AddClickListener(arg_1_0.onClick, arg_1_0)
	gohelper.setActive(arg_1_0.goOriginCost, false)
	arg_1_0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, arg_1_0.onBuyGoodsSuccess, arg_1_0)

	arg_1_0._txtOutlineColor = {
		"#D0D0D0FF",
		"#D0D0D0FF",
		"#745A7CFF",
		"#997C2EFF",
		"#B36B24FF"
	}
end

function var_0_0.onClick(arg_2_0)
	if arg_2_0.remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivityNormalStoreGoodsView, arg_2_0.storeGoodsCo)
end

function var_0_0.onBuyGoodsSuccess(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 ~= arg_3_0.storeGoodsCo.activityId or arg_3_2 ~= arg_3_0.storeGoodsCo.id then
		return
	end

	arg_3_0:refreshRemainBuyCount()
end

function var_0_0.updateInfo(arg_4_0, arg_4_1)
	gohelper.setActive(arg_4_0.go, true)

	arg_4_0.storeGoodsCo = arg_4_1

	arg_4_0:refreshRemainBuyCount()

	local var_4_0, var_4_1, var_4_2 = arg_4_0:getItemTypeIdQuantity(arg_4_0.storeGoodsCo.product)
	local var_4_3, var_4_4 = ItemModel.instance:getItemConfigAndIcon(var_4_0, var_4_1)
	local var_4_5
	local var_4_6

	if not var_4_3.rare then
		logWarn("material type : %s, material id : %s not had rare attribute")

		var_4_6 = 5
	else
		var_4_6 = var_4_3.rare
	end

	UISpriteSetMgr.instance:setVersionActivity1_2Sprite(arg_4_0.imageRare, "img_pinzhi_" .. var_4_6 + 1)
	UISpriteSetMgr.instance:setVersionActivity1_2Sprite(arg_4_0.imageBg, "shangpin_di_" .. var_4_6 + 1)

	if var_4_6 > 2 then
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(arg_4_0.imageBar, "bg_zhongdian_" .. var_4_6 + 1)
	end

	gohelper.setActive(arg_4_0.imageBar.gameObject, var_4_6 > 2)
	gohelper.setActive(arg_4_0.goMaxRareEffect, var_4_6 >= 5)

	if var_4_0 == MaterialEnum.MaterialType.Equip then
		arg_4_0.simageIcon:LoadImage(ResUrl.getHeroDefaultEquipIcon(var_4_3.icon), function()
			arg_4_0.imageIcon:SetNativeSize()
		end)
	else
		arg_4_0.simageIcon:LoadImage(var_4_4, function()
			arg_4_0.imageIcon:SetNativeSize()
		end)
	end

	arg_4_0.txtName.text = var_4_3.name

	gohelper.setActive(arg_4_0.goQuantity, var_4_2 > 1)

	arg_4_0.txtQuantity.text = var_4_2 > 1 and luaLang("multiple") .. var_4_2 or ""
	arg_4_0.costItemType, arg_4_0.costItemId, arg_4_0.costItemQuantity = arg_4_0:getItemTypeIdQuantity(arg_4_0.storeGoodsCo.cost)
	arg_4_0.txtCost.text = arg_4_0.costItemQuantity

	local var_4_7, var_4_8 = ItemModel.instance:getItemConfigAndIcon(arg_4_0.costItemType, arg_4_0.costItemId)

	if arg_4_0.costItemType == MaterialEnum.MaterialType.Currency then
		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_4_0.imageCoin, var_4_7.icon .. "_1")
	else
		arg_4_0.simageCoin:LoadImage(var_4_8)
	end

	gohelper.setActive(arg_4_0._goDiscount, arg_4_0.storeGoodsCo.tag > 0)

	arg_4_0.txtDiscount.text = arg_4_0.storeGoodsCo.tag > 0 and luaLang("versionactivity_1_2_storeview_tagtype_" .. arg_4_0.storeGoodsCo.tag) or ""
	arg_4_0.fontMaterial = arg_4_0.fontMaterial or UnityEngine.Object.Instantiate(arg_4_0.txtName.fontMaterial)
	arg_4_0.txtName.fontMaterial = arg_4_0.fontMaterial

	arg_4_0.txtName.fontMaterial:SetFloat("_OutlineWidth", var_4_6 > 2 and 0.03 or 0)
	arg_4_0.txtName.fontMaterial:SetColor("_OutlineColor", GameUtil.parseColor(arg_4_0._txtOutlineColor[var_4_6]))
end

function var_0_0.refreshRemainBuyCount(arg_7_0)
	if arg_7_0.storeGoodsCo.maxBuyCount == 0 then
		gohelper.setActive(arg_7_0.txtLimitBuy.gameObject, false)
		gohelper.setActive(arg_7_0.goSoldout, false)

		arg_7_0.remainBuyCount = 9999
	else
		gohelper.setActive(arg_7_0.txtLimitBuy.gameObject, true)

		arg_7_0.remainBuyCount = arg_7_0.storeGoodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_2Enum.ActivityId.DungeonStore, arg_7_0.storeGoodsCo.id)
		arg_7_0.txtLimitBuy.text = luaLang("store_buylimit") .. arg_7_0.remainBuyCount

		gohelper.setActive(arg_7_0.goSoldout, arg_7_0.remainBuyCount <= 0)
	end
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
	arg_10_0:removeEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, arg_10_0.onBuyGoodsSuccess, arg_10_0)
	arg_10_0:__onDispose()
end

return var_0_0
