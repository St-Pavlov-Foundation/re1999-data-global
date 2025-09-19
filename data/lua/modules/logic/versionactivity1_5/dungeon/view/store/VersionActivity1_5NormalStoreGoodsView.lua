module("modules.logic.versionactivity1_5.dungeon.view.store.VersionActivity1_5NormalStoreGoodsView", package.seeall)

local var_0_0 = class("VersionActivity1_5NormalStoreGoodsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_leftbg")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_rightbg")
	arg_1_0._goremain = gohelper.findChild(arg_1_0.viewGO, "root/propinfo/info/#go_goodsheader/remain")
	arg_1_0._txtremain = gohelper.findChildText(arg_1_0.viewGO, "root/propinfo/info/#go_goodsheader/remain/#txt_remain")
	arg_1_0._gounique = gohelper.findChild(arg_1_0.viewGO, "root/propinfo/info/#go_goodsheader/go_unique")
	arg_1_0._goIcon = gohelper.findChild(arg_1_0.viewGO, "root/propinfo/goIcon")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0._goIcon, "#simage_icon")
	arg_1_0._txtgoodsNameCn = gohelper.findChildText(arg_1_0.viewGO, "root/propinfo/#txt_goodsNameCn")
	arg_1_0._txtgoodsUseDesc = gohelper.findChildText(arg_1_0.viewGO, "root/propinfo/info/goodsDesc/Viewport/Content/#txt_goodsUseDesc")
	arg_1_0._txtgoodsDesc = gohelper.findChildText(arg_1_0.viewGO, "root/propinfo/info/goodsDesc/Viewport/Content/#txt_goodsDesc")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/propinfo/#btn_click")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "root/propinfo/group/#go_item")
	arg_1_0._txtitemcount = gohelper.findChildText(arg_1_0.viewGO, "root/propinfo/group/#go_item/#txt_itemcount")
	arg_1_0._gogoodsHavebg = gohelper.findChild(arg_1_0.viewGO, "root/propinfo/group/#go_goodsHavebg")
	arg_1_0._txtgoodsHave = gohelper.findChildText(arg_1_0.viewGO, "root/propinfo/group/#go_goodsHavebg/bg/#txt_goodsHave")
	arg_1_0._gobuy = gohelper.findChild(arg_1_0.viewGO, "root/#go_buy")
	arg_1_0._inputvalue = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "root/#go_buy/#go_buynormal/valuebg/#input_value")
	arg_1_0._btnmin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_buy/#go_buynormal/#btn_min")
	arg_1_0._btnsub = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_buy/#go_buynormal/#btn_sub")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_buy/#go_buynormal/#btn_add")
	arg_1_0._btnmax = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_buy/#go_buynormal/#btn_max")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_buy/#btn_buy")
	arg_1_0._txtoriginalCost = gohelper.findChildText(arg_1_0.viewGO, "root/#go_buy/#go_buynormal/cost/#txt_originalCost")
	arg_1_0._txtsalePrice = gohelper.findChildText(arg_1_0.viewGO, "root/#go_buy/#go_buynormal/cost/#txt_originalCost/#txt_salePrice")
	arg_1_0._simagecosticon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#go_buy/#go_buynormal/cost/#simage_costicon")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "root/#go_tips")
	arg_1_0._txtlocktips = gohelper.findChildText(arg_1_0.viewGO, "root/#go_tips/#txt_locktips")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btnmin:AddClickListener(arg_2_0._btnminOnClick, arg_2_0)
	arg_2_0._btnsub:AddClickListener(arg_2_0._btnsubOnClick, arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
	arg_2_0._btnmax:AddClickListener(arg_2_0._btnmaxOnClick, arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btncloseOnClick, arg_2_0)
	arg_2_0._inputvalue:AddOnEndEdit(arg_2_0._onEndEdit, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btnmin:RemoveClickListener()
	arg_3_0._btnsub:RemoveClickListener()
	arg_3_0._btnadd:RemoveClickListener()
	arg_3_0._btnmax:RemoveClickListener()
	arg_3_0._btnbuy:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._inputvalue:RemoveOnEndEdit()
end

function var_0_0._onEndEdit(arg_4_0, arg_4_1)
	local var_4_0 = tonumber(arg_4_1)

	var_4_0 = var_4_0 and math.floor(var_4_0)

	if not var_4_0 or var_4_0 < 1 then
		arg_4_0.currentBuyCount = 1

		arg_4_0:refreshByCount()
		GameFacade.showToast(ToastEnum.VersionActivityNormalStoreNoGoods)

		return
	end

	if var_4_0 > arg_4_0.maxBuyCount then
		arg_4_0.currentBuyCount = math.max(arg_4_0.maxBuyCount, 1)

		arg_4_0:refreshByCount()

		return
	end

	arg_4_0.currentBuyCount = var_4_0

	arg_4_0:refreshByCount()
end

function var_0_0._btnclickOnClick(arg_5_0)
	MaterialTipController.instance:showMaterialInfo(arg_5_0.itemType, arg_5_0.itemId)
end

function var_0_0._btnminOnClick(arg_6_0)
	arg_6_0.currentBuyCount = 1

	arg_6_0:refreshByCount()
end

function var_0_0._btnsubOnClick(arg_7_0)
	if arg_7_0.currentBuyCount <= 1 then
		return
	end

	arg_7_0.currentBuyCount = arg_7_0.currentBuyCount - 1

	arg_7_0:refreshByCount()
end

function var_0_0._btnaddOnClick(arg_8_0)
	if arg_8_0.storeGoodsCo.maxBuyCount ~= 0 and arg_8_0.currentBuyCount >= arg_8_0.remainBuyCount then
		GameFacade.showToast(ToastEnum.StoreMaxBuyCount)

		return
	end

	if arg_8_0.currentBuyCount >= arg_8_0.maxBuyCount then
		GameFacade.showToast(ToastEnum.DiamondBuy, arg_8_0.costName)

		return
	end

	arg_8_0.currentBuyCount = arg_8_0.currentBuyCount + 1

	arg_8_0:refreshByCount()
end

function var_0_0._btnmaxOnClick(arg_9_0)
	arg_9_0.currentBuyCount = math.max(arg_9_0.maxBuyCount, 1)

	arg_9_0:refreshByCount()
end

function var_0_0._btnbuyOnClick(arg_10_0)
	if arg_10_0.currentBuyCount > arg_10_0.maxBuyCount then
		GameFacade.showToast(ToastEnum.DiamondBuy, arg_10_0.costName)

		return
	end

	Activity107Rpc.instance:sendBuy107GoodsRequest(arg_10_0.storeGoodsCo.activityId, arg_10_0.storeGoodsCo.id, arg_10_0.currentBuyCount)
end

function var_0_0._btncloseOnClick(arg_11_0)
	arg_11_0:closeThis()
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_12_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	arg_12_0._imagecosticon = gohelper.findChildImage(arg_12_0.viewGO, "root/#go_buy/#go_buynormal/cost/#simage_costicon")

	gohelper.setActive(arg_12_0._gotips, false)
	gohelper.setActive(arg_12_0._gobuy, true)
	gohelper.addUIClickAudio(arg_12_0._btnbuy.gameObject, AudioEnum.UI.Store_Good_Click)
	arg_12_0:addEventCb(VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, arg_12_0.onBuyGoodsSuccess, arg_12_0)
end

function var_0_0.onUpdateParam(arg_13_0)
	return
end

function var_0_0.onOpen(arg_14_0)
	arg_14_0.storeGoodsCo = arg_14_0.viewParam

	local var_14_0 = string.splitToNumber(arg_14_0.storeGoodsCo.product, "#")

	arg_14_0.itemType = var_14_0[1]
	arg_14_0.itemId = var_14_0[2]
	arg_14_0.oneItemCount = var_14_0[3]

	local var_14_1 = string.split(arg_14_0.storeGoodsCo.cost, "#")

	arg_14_0.costType = var_14_1[1]
	arg_14_0.costId = var_14_1[2]
	arg_14_0.oneCostQuantity = tonumber(var_14_1[3])
	arg_14_0.hadQuantity = ItemModel.instance:getItemQuantity(arg_14_0.costType, arg_14_0.costId)

	local var_14_2 = ItemModel.instance:getItemConfig(arg_14_0.costType, arg_14_0.costId)

	arg_14_0.costName = var_14_2 and var_14_2.name or ""
	arg_14_0.maxBuyCount = math.floor(arg_14_0.hadQuantity / arg_14_0.oneCostQuantity)
	arg_14_0.remainBuyCount = arg_14_0.storeGoodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(arg_14_0.storeGoodsCo.activityId, arg_14_0.storeGoodsCo.id)

	if arg_14_0.storeGoodsCo.maxBuyCount ~= 0 then
		arg_14_0.maxBuyCount = math.min(arg_14_0.maxBuyCount, arg_14_0.remainBuyCount)
	end

	arg_14_0.currentBuyCount = 1

	arg_14_0:refreshUI()
end

function var_0_0.refreshUI(arg_15_0)
	local var_15_0, var_15_1 = ItemModel.instance:getItemConfigAndIcon(arg_15_0.itemType, arg_15_0.itemId)

	arg_15_0._txtgoodsNameCn.text = var_15_0.name
	arg_15_0._txtgoodsDesc.text = var_15_0.desc
	arg_15_0._txtgoodsUseDesc.text = var_15_0.useDesc

	if tonumber(arg_15_0.itemType) == MaterialEnum.MaterialType.Equip then
		var_15_1 = ResUrl.getEquipSuit(var_15_0.icon)
	end

	if var_15_0.subType == ItemEnum.SubType.Portrait then
		gohelper.setActive(arg_15_0._simageicon.gameObject, false)

		if not arg_15_0.headIconItem then
			arg_15_0.headIconItem = IconMgr.instance:getCommonHeadIcon(arg_15_0._goIcon)
		end

		arg_15_0.headIconItem:setItemId(var_15_0.id)
	else
		gohelper.setActive(arg_15_0._simageicon.gameObject, true)
		arg_15_0._simageicon:LoadImage(var_15_1)

		if arg_15_0.headIconItem then
			arg_15_0.headIconItem:setVisible(false)
		end
	end

	arg_15_0._txtgoodsHave.text = string.format("%s", GameUtil.numberDisplay(ItemModel.instance:getItemQuantity(arg_15_0.itemType, arg_15_0.itemId)))

	arg_15_0:refreshByCount()
	arg_15_0:refreshRemain()
	arg_15_0:refreshGoUnique()
end

function var_0_0.refreshByCount(arg_16_0)
	arg_16_0._inputvalue:SetText(tostring(arg_16_0.currentBuyCount))

	arg_16_0._txtitemcount.text = string.format("x%s", GameUtil.numberDisplay(arg_16_0.oneItemCount * arg_16_0.currentBuyCount))

	local var_16_0 = arg_16_0.oneCostQuantity * arg_16_0.currentBuyCount

	if var_16_0 > arg_16_0.hadQuantity then
		arg_16_0._txtsalePrice.text = string.format("<color=#BF2E11>%s</color>", var_16_0)
	else
		arg_16_0._txtsalePrice.text = string.format("%s", var_16_0)
	end

	local var_16_1, var_16_2 = ItemModel.instance:getItemConfigAndIcon(arg_16_0.costType, arg_16_0.costId)

	if tonumber(arg_16_0.costType) == MaterialEnum.MaterialType.Currency then
		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_16_0._imagecosticon, var_16_1.icon .. "_1")
	else
		arg_16_0._simagecosticon:LoadImage(var_16_2)
	end
end

function var_0_0.refreshRemain(arg_17_0)
	if arg_17_0.storeGoodsCo.maxBuyCount == 0 then
		gohelper.setActive(arg_17_0._goremain, false)
	else
		gohelper.setActive(arg_17_0._goremain, true)

		arg_17_0._txtremain.text = luaLang("store_buylimit") .. arg_17_0.remainBuyCount
	end
end

function var_0_0.refreshGoUnique(arg_18_0)
	gohelper.setActive(arg_18_0._gounique, ItemConfig.instance:isUniqueById(arg_18_0.itemType, arg_18_0.itemId))
end

function var_0_0.onBuyGoodsSuccess(arg_19_0)
	arg_19_0:closeThis()
end

function var_0_0.onClose(arg_20_0)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
end

function var_0_0.onDestroyView(arg_21_0)
	arg_21_0._simageleftbg:UnLoadImage()
	arg_21_0._simagerightbg:UnLoadImage()
	arg_21_0._simageicon:UnLoadImage()
	arg_21_0._simagecosticon:UnLoadImage()
end

return var_0_0
