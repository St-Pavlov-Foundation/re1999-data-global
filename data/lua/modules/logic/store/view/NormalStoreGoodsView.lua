module("modules.logic.store.view.NormalStoreGoodsView", package.seeall)

local var_0_0 = class("NormalStoreGoodsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageblur = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_blur")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_leftbg")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_rightbg")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/propinfo/goIcon/#simage_icon")
	arg_1_0._imagecosticon = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_buy/#go_buynormal/cost/#simage_costicon")
	arg_1_0._txtoriginalCost = gohelper.findChildText(arg_1_0.viewGO, "root/#go_buy/#go_buynormal/cost/#txt_originalCost")
	arg_1_0._txtsalePrice = gohelper.findChildText(arg_1_0.viewGO, "root/#go_buy/#go_buynormal/cost/#txt_originalCost/#txt_salePrice")
	arg_1_0._txtgoodsNameCn = gohelper.findChildText(arg_1_0.viewGO, "root/propinfo/#txt_goodsNameCn")
	arg_1_0._txtgoodsNameEn = gohelper.findChildText(arg_1_0.viewGO, "root/propinfo/#txt_goodsNameEn")
	arg_1_0._trsgoodsDesc = gohelper.findChild(arg_1_0.viewGO, "root/propinfo/info/goodsDesc").transform
	arg_1_0._txtgoodsDesc = gohelper.findChildText(arg_1_0.viewGO, "root/propinfo/info/goodsDesc/Viewport/Content/#txt_goodsDesc")
	arg_1_0._txtgoodsUseDesc = gohelper.findChildText(arg_1_0.viewGO, "root/propinfo/info/goodsDesc/Viewport/Content/#txt_goodsUseDesc")
	arg_1_0._txtgoodsHave = gohelper.findChildText(arg_1_0.viewGO, "root/propinfo/group/#go_goodsHavebg/bg/#txt_goodsHave")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "root/propinfo/group/#go_item")
	arg_1_0._txtitemcount = gohelper.findChildText(arg_1_0.viewGO, "root/propinfo/group/#go_item/#txt_itemcount")
	arg_1_0._txtvalue = gohelper.findChildText(arg_1_0.viewGO, "root/#go_buy/#go_buynormal/valuebg/#txt_value")
	arg_1_0._btnmin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_buy/#go_buynormal/#btn_min")
	arg_1_0._btnsub = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_buy/#go_buynormal/#btn_sub")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_buy/#go_buynormal/#btn_add")
	arg_1_0._btnmax = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_buy/#go_buynormal/#btn_max")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_buy/#btn_buy")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._trsinfo = gohelper.findChild(arg_1_0.viewGO, "root/propinfo/info").transform
	arg_1_0._goremain = gohelper.findChild(arg_1_0.viewGO, "root/propinfo/info/#go_goodsheader/remain")
	arg_1_0._txtremain = gohelper.findChildText(arg_1_0.viewGO, "root/propinfo/info/#go_goodsheader/remain/#txt_remain")
	arg_1_0._goLimit = gohelper.findChild(arg_1_0.viewGO, "root/propinfo/info/#go_goodsheader/#go_Limit")
	arg_1_0._gounique = gohelper.findChild(arg_1_0.viewGO, "root/propinfo/info/#go_goodsheader/go_unique")
	arg_1_0._inputvalue = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "root/#go_buy/#go_buynormal/valuebg/#input_value")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/propinfo/#btn_click")
	arg_1_0._gogoodsHavebg = gohelper.findChild(arg_1_0.viewGO, "root/propinfo/group/#go_goodsHavebg")
	arg_1_0._gobuy = gohelper.findChild(arg_1_0.viewGO, "root/#go_buy")
	arg_1_0._gobuynormal = gohelper.findChild(arg_1_0.viewGO, "root/#go_buy/#go_buynormal")
	arg_1_0._gobuycost2 = gohelper.findChild(arg_1_0.viewGO, "root/#go_buy/#go_buycost2")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "root/#go_tips")
	arg_1_0._txtlocktips = gohelper.findChildText(arg_1_0.viewGO, "root/#go_tips/#txt_locktips")
	arg_1_0._goinclude = gohelper.findChild(arg_1_0.viewGO, "root/#go_include")
	arg_1_0._txtsalePrice2 = gohelper.findChildText(arg_1_0.viewGO, "root/#go_include/cost/#txt_salePrice")
	arg_1_0._imagecosticon2 = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_include/cost/#simage_costicon")
	arg_1_0._btnbuy2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_include/#btn_buy")
	arg_1_0._btncost1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_buy/#go_buycost2/#btn_cost1")
	arg_1_0._gounselect1 = gohelper.findChild(arg_1_0.viewGO, "root/#go_buy/#go_buycost2/#btn_cost1/unselect")
	arg_1_0._imageiconunselect1 = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_buy/#go_buycost2/#btn_cost1/unselect/icon/simage_icon")
	arg_1_0._txtcurpriceunselect1 = gohelper.findChildText(arg_1_0.viewGO, "root/#go_buy/#go_buycost2/#btn_cost1/unselect/txt_Num")
	arg_1_0._txtoriginalpriceunselect1 = gohelper.findChildText(arg_1_0.viewGO, "root/#go_buy/#go_buycost2/#btn_cost1/unselect/#txt_original_price")
	arg_1_0._goselect1 = gohelper.findChild(arg_1_0.viewGO, "root/#go_buy/#go_buycost2/#btn_cost1/select")
	arg_1_0._imageiconselect1 = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_buy/#go_buycost2/#btn_cost1/select/icon/simage_icon")
	arg_1_0._txtcurpriceselect1 = gohelper.findChildText(arg_1_0.viewGO, "root/#go_buy/#go_buycost2/#btn_cost1/select/txt_Num")
	arg_1_0._txtoriginalpriceselect1 = gohelper.findChildText(arg_1_0.viewGO, "root/#go_buy/#go_buycost2/#btn_cost1/select/#txt_original_price")
	arg_1_0._btncost2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_buy/#go_buycost2/#btn_cost2")
	arg_1_0._gounselect2 = gohelper.findChild(arg_1_0.viewGO, "root/#go_buy/#go_buycost2/#btn_cost2/unselect")
	arg_1_0._imageiconunselect2 = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_buy/#go_buycost2/#btn_cost2/unselect/icon/simage_icon")
	arg_1_0._txtcurpriceunselect2 = gohelper.findChildText(arg_1_0.viewGO, "root/#go_buy/#go_buycost2/#btn_cost2/unselect/txt_Num")
	arg_1_0._txtoriginalpriceunselect2 = gohelper.findChildText(arg_1_0.viewGO, "root/#go_buy/#go_buycost2/#btn_cost2/unselect/#txt_original_price")
	arg_1_0._goselect2 = gohelper.findChild(arg_1_0.viewGO, "root/#go_buy/#go_buycost2/#btn_cost2/select")
	arg_1_0._imageiconselect2 = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_buy/#go_buycost2/#btn_cost2/select/icon/simage_icon")
	arg_1_0._txtcurpriceselect2 = gohelper.findChildText(arg_1_0.viewGO, "root/#go_buy/#go_buycost2/#btn_cost2/select/txt_Num")
	arg_1_0._txtoriginalpriceselect2 = gohelper.findChildText(arg_1_0.viewGO, "root/#go_buy/#go_buycost2/#btn_cost2/select/#txt_original_price")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnmin:AddClickListener(arg_2_0._btnminOnClick, arg_2_0)
	arg_2_0._btnsub:AddClickListener(arg_2_0._btnsubOnClick, arg_2_0)
	arg_2_0._btnadd:AddClickListener(arg_2_0._btnaddOnClick, arg_2_0)
	arg_2_0._btnmax:AddClickListener(arg_2_0._btnmaxOnClick, arg_2_0)
	arg_2_0._btnbuy:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
	arg_2_0._btnbuy2:AddClickListener(arg_2_0._btnbuyOnClick, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._btnCloseOnClick, arg_2_0)
	arg_2_0._inputvalue:AddOnEndEdit(arg_2_0._onEndEdit, arg_2_0)
	arg_2_0._inputvalue:AddOnValueChanged(arg_2_0._onValueChanged, arg_2_0)
	arg_2_0._btnclick:AddClickListener(arg_2_0._btnclickOnClick, arg_2_0)
	arg_2_0._btncost1:AddClickListener(arg_2_0._btncost1OnClick, arg_2_0)
	arg_2_0._btncost2:AddClickListener(arg_2_0._btncost2OnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnmin:RemoveClickListener()
	arg_3_0._btnsub:RemoveClickListener()
	arg_3_0._btnadd:RemoveClickListener()
	arg_3_0._btnmax:RemoveClickListener()
	arg_3_0._btnbuy:RemoveClickListener()
	arg_3_0._btnbuy2:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._inputvalue:RemoveOnEndEdit()
	arg_3_0._inputvalue:RemoveOnValueChanged()
	arg_3_0._btnclick:RemoveClickListener()
	arg_3_0._btncost1:RemoveClickListener()
	arg_3_0._btncost2:RemoveClickListener()
end

function var_0_0._btnclickOnClick(arg_4_0)
	MaterialTipController.instance:showMaterialInfo(arg_4_0._itemType, arg_4_0._itemId)
end

function var_0_0._btnminOnClick(arg_5_0)
	arg_5_0._buyCount = 1

	arg_5_0:_refreshBuyCount()
	arg_5_0:_refreshGoods(arg_5_0.goodsConfig)
end

function var_0_0._btnsubOnClick(arg_6_0)
	if arg_6_0._buyCount <= 1 then
		return
	else
		arg_6_0._buyCount = arg_6_0._buyCount - 1

		arg_6_0:_refreshBuyCount()
		arg_6_0:_refreshGoods(arg_6_0.goodsConfig)
	end
end

function var_0_0._btnaddOnClick(arg_7_0)
	if arg_7_0._buyCount + 1 > arg_7_0._maxBuyCount then
		arg_7_0:_buyCountAddToast()

		return
	else
		arg_7_0._buyCount = arg_7_0._buyCount + 1

		arg_7_0:_refreshBuyCount()
		arg_7_0:_refreshGoods(arg_7_0.goodsConfig)
	end
end

function var_0_0._btnmaxOnClick(arg_8_0)
	arg_8_0._buyCount = math.max(arg_8_0._maxBuyCount, 1)

	if arg_8_0._buyCount > arg_8_0._maxBuyCount then
		arg_8_0:_buyCountAddToast()
	end

	arg_8_0:_refreshBuyCount()
	arg_8_0:_refreshGoods(arg_8_0.goodsConfig)
end

function var_0_0._btnCloseOnClick(arg_9_0)
	arg_9_0:closeThis()
end

function var_0_0._btncost1OnClick(arg_10_0)
	arg_10_0:_btncostOnClick(1)
end

function var_0_0._btncost2OnClick(arg_11_0)
	arg_11_0:_btncostOnClick(2)
end

function var_0_0._btncostOnClick(arg_12_0, arg_12_1)
	if not arg_12_0:_isBuyCost2() or arg_12_0._buyCost2Index == arg_12_1 then
		return
	end

	arg_12_0:_setBuyCost2(arg_12_1)
end

function var_0_0._onEndEdit(arg_13_0, arg_13_1)
	local var_13_0 = tonumber(arg_13_1)

	var_13_0 = var_13_0 and math.floor(var_13_0)

	if not var_13_0 or var_13_0 <= 0 then
		var_13_0 = 1

		GameFacade.showToast(ToastEnum.VersionActivityNormalStoreNoGoods)
	end

	if var_13_0 > arg_13_0._maxBuyCount then
		arg_13_0:_buyCountAddToast()
	end

	arg_13_0._buyCount = math.max(math.min(var_13_0, arg_13_0._maxBuyCount), 1)

	arg_13_0:_refreshBuyCount()
	arg_13_0:_refreshGoods(arg_13_0.goodsConfig)
end

function var_0_0._onValueChanged(arg_14_0, arg_14_1)
	return
end

function var_0_0._btnbuyOnClick(arg_15_0)
	local var_15_0 = RoomConfig.instance:getBuildingSkinCoByItemId(arg_15_0._itemId)

	if var_15_0 and not arg_15_0:_isHasBuiding(var_15_0) then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomBuldingStoreBuy, MsgBoxEnum.BoxType.Yes_No, arg_15_0._tryBuyGoods, nil, nil, arg_15_0, nil, nil)

		return
	end

	local var_15_1 = false

	if arg_15_0._itemType == MaterialEnum.MaterialType.Hero then
		var_15_1 = CharacterModel.instance:isHeroFullDuplicateCount(arg_15_0._itemId)
	end

	if var_15_1 then
		local var_15_2 = HeroConfig.instance:getHeroCO(arg_15_0._itemId).duplicateItem2
		local var_15_3 = GameUtil.splitString2(var_15_2, true)
		local var_15_4 = ItemConfig.instance:getItemConfig(var_15_3[1][1], var_15_3[1][2])

		MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.HeroFullDuplicateCount, MsgBoxEnum.BoxType.Yes_No, arg_15_0._tryBuyGoods, nil, nil, arg_15_0, nil, nil, var_15_4.name)
	else
		arg_15_0:_tryBuyGoods()
	end
end

function var_0_0._isHasBuiding(arg_16_0, arg_16_1)
	local var_16_0 = RoomModel.instance:getBuildingInfoList()

	if var_16_0 then
		for iter_16_0, iter_16_1 in ipairs(var_16_0) do
			if arg_16_1.buildingId == iter_16_1.buildingId then
				return true
			end
		end
	end
end

function var_0_0._tryBuyGoods(arg_17_0)
	if arg_17_0._costType == MaterialEnum.MaterialType.Currency and arg_17_0._costId == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
		local var_17_0 = arg_17_0._mo:getCost(arg_17_0._buyCount)

		if CurrencyController.instance:checkFreeDiamondEnough(var_17_0, CurrencyEnum.PayDiamondExchangeSource.Store, nil, arg_17_0._buyGoods, arg_17_0, arg_17_0.closeThis, arg_17_0) then
			arg_17_0:_buyGoods()
		end
	elseif arg_17_0._buyCount > arg_17_0._maxBuyCount then
		arg_17_0:_buyCountAddToast()
	elseif arg_17_0._buyCount > 0 then
		arg_17_0:_buyGoods()
	end
end

function var_0_0._buyGoods(arg_18_0)
	StoreController.instance:buyGoods(arg_18_0._mo, arg_18_0._buyCount, arg_18_0._buyCallback, arg_18_0, arg_18_0._buyCost2Index)
end

function var_0_0._buyCallback(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if arg_19_2 == 0 then
		arg_19_0:closeThis()
	end
end

function var_0_0._editableInitView(arg_20_0)
	arg_20_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_20_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	arg_20_0._buyCount = 1
	arg_20_0._maxBuyCount = 1

	gohelper.addUIClickAudio(arg_20_0._btnbuy.gameObject, AudioEnum.UI.Store_Good_Click)

	arg_20_0._goincludeContent = gohelper.findChild(arg_20_0._goinclude, "#scroll_product/viewport/content")
	arg_20_0._contentHorizontal = arg_20_0._goincludeContent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	arg_20_0._iconItemList = {}
end

function var_0_0._refreshBuyCount(arg_21_0)
	local var_21_0 = arg_21_0._mo:getCost(arg_21_0._buyCount)

	if var_21_0 == 0 then
		arg_21_0._txtsalePrice.text = luaLang("store_free")
	else
		arg_21_0._txtsalePrice.text = tostring(var_21_0)
	end

	arg_21_0._txtsalePrice2.text = arg_21_0._txtsalePrice.text

	arg_21_0._inputvalue:SetText(tostring(arg_21_0._buyCount))

	local var_21_1 = arg_21_0._mo:canAffordQuantity()

	if var_21_1 == -1 or var_21_1 >= arg_21_0._buyCount then
		SLFramework.UGUI.GuiHelper.SetColor(arg_21_0._txtsalePrice, "#393939")
		SLFramework.UGUI.GuiHelper.SetColor(arg_21_0._txtsalePrice2, "#393939")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_21_0._txtsalePrice, "#bf2e11")
		SLFramework.UGUI.GuiHelper.SetColor(arg_21_0._txtsalePrice2, "#bf2e11")
	end

	arg_21_0._txtoriginalCost.text = ""
end

function var_0_0.ShowLockTips(arg_22_0)
	if StoreConfig.instance:getGoodsConfig(arg_22_0._mo.goodsId).needEpisodeId == StoreEnum.Need4RDEpisodeId then
		arg_22_0._txtlocktips.text = string.format("%s%s", luaLang("dungeon_unlock_4RD"), luaLang("dungeon_unlock"))
	else
		local var_22_0 = arg_22_0._mo.lvlimitchapter
		local var_22_1 = arg_22_0._mo.lvlimitepisode
		local var_22_2 = "dungeon_unlock_episode"

		if arg_22_0._mo.isHardChapter then
			var_22_2 = "dungeon_unlock_episode_hard"
		end

		arg_22_0._txtlocktips.text = string.format(luaLang(var_22_2), string.format("%s-%s", var_22_0, var_22_1))
	end
end

function var_0_0._refreshUI(arg_23_0)
	arg_23_0.goodsConfig = StoreConfig.instance:getGoodsConfig(arg_23_0._mo.goodsId)

	local var_23_0 = string.splitToNumber(arg_23_0.goodsConfig.product, "#")
	local var_23_1 = var_23_0[1]
	local var_23_2 = var_23_0[2]

	arg_23_0._txtgoodsNameCn.text = ItemModel.instance:getItemConfig(var_23_1, var_23_2).name

	gohelper.setActive(arg_23_0._txtgoodsDesc.gameObject, true)
	gohelper.setActive(arg_23_0._txtgoodsUseDesc.gameObject, true)

	local var_23_3 = arg_23_0:_isBuyCost2()

	if var_23_3 then
		if not arg_23_0.costParam then
			arg_23_0:_setBuyCost2Btn()
		end

		local var_23_4 = {}
		local var_23_5 = string.splitToNumber(arg_23_0.goodsConfig.cost, "#")
		local var_23_6 = string.splitToNumber(arg_23_0.goodsConfig.cost2, "#")

		table.insert(var_23_4, var_23_6[2])
		table.insert(var_23_4, var_23_5[2])
		arg_23_0.viewContainer:setCurrencyTypes(var_23_4)
	end

	gohelper.setActive(arg_23_0._gobuy, arg_23_0:_isStoreItemUnlock())
	gohelper.setActive(arg_23_0._gotips, not arg_23_0:_isStoreItemUnlock())
	gohelper.setActive(arg_23_0._gobuynormal, not var_23_3)
	gohelper.setActive(arg_23_0._gobuycost2, var_23_3)

	if not arg_23_0:_isStoreItemUnlock() then
		arg_23_0:ShowLockTips()
	end

	if StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(arg_23_0._mo.goodsId) then
		gohelper.setActive(arg_23_0._gobuy, false)
		gohelper.setActive(arg_23_0._gotips, true)

		arg_23_0._txtlocktips.text = string.format(luaLang("weekwalk_layer_unlock"), arg_23_0._mo.limitWeekWalkLayer)
	end

	arg_23_0:_refreshGoods(arg_23_0.goodsConfig)

	local var_23_7 = false

	if arg_23_0._itemType == MaterialEnum.MaterialType.Hero then
		arg_23_0._txtgoodsDesc.text = ItemModel.instance:getItemConfig(var_23_0[1], var_23_0[2]).desc2
	else
		arg_23_0._txtgoodsDesc.text = ItemModel.instance:getItemConfig(var_23_0[1], var_23_0[2]).desc
	end

	arg_23_0._txtgoodsUseDesc.text = ItemModel.instance:getItemConfig(var_23_0[1], var_23_0[2]).useDesc

	local var_23_8 = arg_23_0.goodsConfig.cost

	if string.nilorempty(var_23_8) then
		arg_23_0._costType, arg_23_0._costId = nil

		gohelper.setActive(arg_23_0._imagecosticon.gameObject, false)
		gohelper.setActive(arg_23_0._imagecosticon2.gameObject, false)
	else
		local var_23_9 = string.split(var_23_8, "|")

		var_23_7 = #var_23_9 > 1

		local var_23_10 = var_23_9[arg_23_0._mo.buyCount + 1] or var_23_9[#var_23_9]
		local var_23_11 = string.split(var_23_10, "#")

		arg_23_0._costType = tonumber(var_23_11[1])
		arg_23_0._costId = tonumber(var_23_11[2])

		local var_23_12, var_23_13 = ItemModel.instance:getItemConfigAndIcon(arg_23_0._costType, arg_23_0._costId)
		local var_23_14 = var_23_12.icon
		local var_23_15 = string.format("%s_1", var_23_14)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_23_0._imagecosticon, var_23_15)
		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_23_0._imagecosticon2, var_23_15)
		gohelper.setActive(arg_23_0._imagecosticon.gameObject, true)

		if not var_23_3 then
			arg_23_0.viewContainer:setCurrencyType(arg_23_0._costId)
		end
	end

	local var_23_16 = arg_23_0.goodsConfig.maxBuyCount - arg_23_0._mo.buyCount

	if var_23_7 then
		arg_23_0._txtremain.text = luaLang("store_multi_one")

		gohelper.setActive(arg_23_0._goremain, true)
		gohelper.setActive(arg_23_0._txtremain.gameObject, true)
	else
		local var_23_17 = StoreConfig.instance:getRemain(arg_23_0.goodsConfig, var_23_16, arg_23_0._mo.offlineTime)

		if string.nilorempty(var_23_17) then
			gohelper.setActive(arg_23_0._goremain, false)
			gohelper.setActive(arg_23_0._txtremain.gameObject, false)

			local var_23_18 = recthelper.getHeight(arg_23_0._trsinfo)

			recthelper.setHeight(arg_23_0._trsgoodsDesc, var_23_18)
		else
			gohelper.setActive(arg_23_0._goremain, true)
			gohelper.setActive(arg_23_0._txtremain.gameObject, true)

			arg_23_0._txtremain.text = var_23_17
		end
	end

	arg_23_0._buyCount = 1

	arg_23_0:_refreshBuyCount()
	arg_23_0:_refreshInclude()
	arg_23_0:_refreshGoUnique()
	arg_23_0:_refreshLimitTag()
end

function var_0_0._refreshGoUnique(arg_24_0)
	gohelper.setActive(arg_24_0._gounique, false)
end

function var_0_0._refreshInclude(arg_25_0)
	if not arg_25_0:_isStoreItemUnlock() then
		return
	end

	local var_25_0 = arg_25_0._itemSubType == ItemEnum.SubType.SpecifiedGift

	if not var_25_0 then
		return
	end

	local var_25_1

	gohelper.setActive(arg_25_0._gobuy, false)
	gohelper.setActive(arg_25_0._goinclude, true)
	gohelper.setActive(arg_25_0._txtgoodsDesc.gameObject, false)
	gohelper.setActive(arg_25_0._txtgoodsUseDesc.gameObject, true)

	local var_25_2 = 0

	if var_25_0 then
		local var_25_3, var_25_4 = ItemModel.instance:getItemConfigAndIcon(arg_25_0._itemType, arg_25_0._itemId, true)
		local var_25_5 = GameUtil.splitString2(var_25_3.effect, true)

		var_25_2 = #var_25_5

		for iter_25_0, iter_25_1 in ipairs(var_25_5) do
			local var_25_6 = arg_25_0._iconItemList[iter_25_0]
			local var_25_7 = iter_25_1[1]
			local var_25_8 = iter_25_1[2]
			local var_25_9 = iter_25_1[3]

			local function var_25_10()
				MaterialTipController.instance:showMaterialInfo(var_25_7, var_25_8)
			end

			if var_25_6 == nil then
				if var_25_7 == MaterialEnum.MaterialType.Equip then
					var_25_6 = IconMgr.instance:getCommonEquipIcon(arg_25_0._goincludeContent)

					var_25_6:setMOValue(var_25_7, var_25_8, var_25_9, nil, true)
					var_25_6:hideLv(true)
					var_25_6:customClick(var_25_10)

					var_25_1 = var_25_7
				else
					var_25_6 = IconMgr.instance:getCommonItemIcon(arg_25_0._goincludeContent)

					var_25_6:setMOValue(var_25_7, var_25_8, var_25_9, nil, true)

					var_25_1 = var_25_7
				end

				table.insert(arg_25_0._iconItemList, var_25_6)
			end
		end
	end

	if var_25_1 == MaterialEnum.MaterialType.Equip then
		arg_25_0._contentHorizontal.spacing = 6.62
		arg_25_0._contentHorizontal.padding.left = -2
		arg_25_0._contentHorizontal.padding.top = 10
	end

	for iter_25_2 = var_25_2 + 1, #arg_25_0._iconItemList do
		gohelper.setActive(arg_25_0._iconItemList[iter_25_2].go, false)
	end
end

function var_0_0._refreshGoods(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_1.product
	local var_27_1 = string.split(var_27_0, "#")

	arg_27_0._itemType = tonumber(var_27_1[1])
	arg_27_0._itemId = tonumber(var_27_1[2])
	arg_27_0._itemQuantity = tonumber(var_27_1[3])

	gohelper.setActive(arg_27_0._goitem, true)

	arg_27_0._txtitemcount.text = string.format("%s%s", luaLang("multiple"), GameUtil.numberDisplay(arg_27_0._itemQuantity * arg_27_0._buyCount))

	local var_27_2, var_27_3 = ItemModel.instance:getItemConfigAndIcon(arg_27_0._itemType, arg_27_0._itemId, true)

	arg_27_0._itemSubType = var_27_2.subType

	local var_27_4 = true

	if tonumber(arg_27_0._itemType) == MaterialEnum.MaterialType.Equip then
		var_27_3 = ResUrl.getEquipSuit(var_27_2.icon)
		var_27_4 = false
	end

	arg_27_0._simageicon:LoadImage(var_27_3, var_27_4 and function()
		arg_27_0._simageicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
	end or nil)
	gohelper.setActive(arg_27_0._gogoodsHavebg, true)

	arg_27_0._txtgoodsHave.text = string.format("%s", GameUtil.numberDisplay(ItemModel.instance:getItemQuantity(arg_27_0._itemType, arg_27_0._itemId)))
end

function var_0_0._refreshLimitTag(arg_29_0)
	local var_29_0 = string.splitToNumber(arg_29_0.goodsConfig.product, "#")
	local var_29_1 = var_29_0[1]
	local var_29_2 = var_29_0[2]
	local var_29_3 = false

	if var_29_1 == MaterialEnum.MaterialType.Equip then
		var_29_3 = EquipModel.instance:isLimit(var_29_2)
	end

	gohelper.setActive(arg_29_0._goLimit, var_29_3)
end

function var_0_0._buyCountAddToast(arg_30_0)
	local var_30_0, var_30_1 = arg_30_0._mo:getBuyMaxQuantity()

	if arg_30_0._buyCount + 1 >= CommonConfig.instance:getConstNum(ConstEnum.StoreMaxBuyCount) or var_30_1 == StoreEnum.LimitType.BuyLimit or var_30_1 == StoreEnum.LimitType.Default then
		GameFacade.showToast(ToastEnum.StoreMaxBuyCount)
	elseif var_30_1 == StoreEnum.LimitType.Currency then
		if arg_30_0._costType and arg_30_0._costId then
			local var_30_2 = ItemModel.instance:getItemConfig(arg_30_0._costType, arg_30_0._costId)

			GameFacade.showToast(ToastEnum.DiamondBuy, var_30_2.name)
		end
	elseif var_30_1 == StoreEnum.LimitType.CurrencyChanged then
		GameFacade.showToast(ToastEnum.CurrencyChanged)
	end
end

function var_0_0._refreshMaxBuyCount(arg_31_0)
	arg_31_0._maxBuyCount = arg_31_0._mo:getBuyMaxQuantity()

	local var_31_0 = CommonConfig.instance:getConstNum(ConstEnum.StoreMaxBuyCount)

	if var_31_0 < arg_31_0._maxBuyCount or arg_31_0._maxBuyCount == -1 then
		arg_31_0._maxBuyCount = var_31_0
	end
end

function var_0_0._refreshMaxBuyCountByCost2(arg_32_0)
	arg_32_0._maxBuyCount = arg_32_0._mo:getBuyMaxQuantityByCost2()

	local var_32_0 = CommonConfig.instance:getConstNum(ConstEnum.StoreMaxBuyCount)

	if var_32_0 < arg_32_0._maxBuyCount or arg_32_0._maxBuyCount == -1 then
		arg_32_0._maxBuyCount = var_32_0
	end
end

function var_0_0.onOpen(arg_33_0)
	arg_33_0._mo = arg_33_0.viewParam

	arg_33_0:_refreshMaxBuyCount()
	arg_33_0:_refreshUI()

	local var_33_0 = StoreConfig.instance:getGoodsConfig(arg_33_0._mo.goodsId)

	StoreController.instance:statOpenGoods(arg_33_0._mo.belongStoreId, var_33_0)

	if arg_33_0:_isBuyCost2() then
		arg_33_0:_setBuyCost2(1)
	end
end

function var_0_0._isStoreItemUnlock(arg_34_0)
	local var_34_0 = StoreConfig.instance:getGoodsConfig(arg_34_0._mo.goodsId).needEpisodeId

	if StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(arg_34_0._mo.goodsId) then
		return false
	end

	if not var_34_0 or var_34_0 == 0 then
		return true
	end

	if var_34_0 == StoreEnum.Need4RDEpisodeId then
		return false
	end

	return DungeonModel.instance:hasPassLevelAndStory(var_34_0)
end

function var_0_0._isBuyCost2(arg_35_0)
	return not string.nilorempty(arg_35_0.goodsConfig.cost2)
end

function var_0_0._setBuyCost2(arg_36_0, arg_36_1)
	if not arg_36_0.costParam or not arg_36_0.costParam[arg_36_1] then
		arg_36_0:_setBuyCost2Btn()
	end

	arg_36_0._buyCost2Index = arg_36_1
	arg_36_0._costType = arg_36_0.costParam[arg_36_1][1]
	arg_36_0._costId = arg_36_0.costParam[arg_36_1][2]

	arg_36_0:_refreshBuyCost2Btn()

	if arg_36_1 == 2 then
		arg_36_0:_refreshMaxBuyCountByCost2()
	else
		arg_36_0:_refreshMaxBuyCount()
	end
end

function var_0_0._refreshBuyCost2Btn(arg_37_0)
	gohelper.setActive(arg_37_0._goselect1, arg_37_0._buyCost2Index == 1)
	gohelper.setActive(arg_37_0._goselect2, arg_37_0._buyCost2Index == 2)
end

function var_0_0._setBuyCost2Btn(arg_38_0)
	arg_38_0.costParam = {}

	local var_38_0 = string.splitToNumber(arg_38_0.goodsConfig.cost, "#")
	local var_38_1 = ItemModel.instance:getItemQuantity(var_38_0[1], var_38_0[2])
	local var_38_2 = ItemModel.instance:getItemConfigAndIcon(var_38_0[1], var_38_0[2])
	local var_38_3 = "#393939"
	local var_38_4 = "#bf2e11"

	if var_38_1 >= var_38_0[3] then
		SLFramework.UGUI.GuiHelper.SetColor(arg_38_0._txtcurpriceunselect1, var_38_3)
		SLFramework.UGUI.GuiHelper.SetColor(arg_38_0._txtcurpriceselect1, var_38_3)
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_38_0._txtcurpriceunselect1, var_38_4)
		SLFramework.UGUI.GuiHelper.SetColor(arg_38_0._txtcurpriceselect1, var_38_4)
	end

	arg_38_0._txtcurpriceunselect1.text = var_38_0[3]
	arg_38_0._txtcurpriceselect1.text = var_38_0[3]

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_38_0._imageiconunselect1, var_38_2.icon .. "_1", true)
	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_38_0._imageiconselect1, var_38_2.icon .. "_1", true)

	local var_38_5 = string.splitToNumber(arg_38_0.goodsConfig.cost2, "#")
	local var_38_6 = ItemModel.instance:getItemQuantity(var_38_5[1], var_38_5[2])
	local var_38_7 = ItemModel.instance:getItemConfigAndIcon(var_38_5[1], var_38_5[2])

	if var_38_6 >= var_38_5[3] then
		SLFramework.UGUI.GuiHelper.SetColor(arg_38_0._txtcurpriceunselect2, var_38_3)
		SLFramework.UGUI.GuiHelper.SetColor(arg_38_0._txtcurpriceselect2, var_38_3)
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_38_0._txtcurpriceunselect2, var_38_4)
		SLFramework.UGUI.GuiHelper.SetColor(arg_38_0._txtcurpriceselect2, var_38_4)
	end

	arg_38_0._txtcurpriceunselect2.text = var_38_5[3]
	arg_38_0._txtcurpriceselect2.text = var_38_5[3]

	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_38_0._imageiconunselect2, var_38_7.icon .. "_1", true)
	UISpriteSetMgr.instance:setCurrencyItemSprite(arg_38_0._imageiconselect2, var_38_7.icon .. "_1", true)

	arg_38_0.costParam = {
		var_38_0,
		var_38_5
	}
end

function var_0_0.onClose(arg_39_0)
	local var_39_0 = StoreConfig.instance:getGoodsConfig(arg_39_0._mo.goodsId)

	StoreController.instance:statCloseGoods(var_39_0)
end

function var_0_0.onUpdateParam(arg_40_0)
	arg_40_0._mo = arg_40_0.viewParam

	arg_40_0:_refreshMaxBuyCount()
	arg_40_0:_refreshUI()
end

function var_0_0.onDestroyView(arg_41_0)
	arg_41_0._simageleftbg:UnLoadImage()
	arg_41_0._simagerightbg:UnLoadImage()
end

return var_0_0
