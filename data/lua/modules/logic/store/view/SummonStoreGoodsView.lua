module("modules.logic.store.view.SummonStoreGoodsView", package.seeall)

local var_0_0 = class("SummonStoreGoodsView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._simageblur = gohelper.findChildSingleImage(arg_1_0.viewGO, "#simage_blur")
	arg_1_0._simageleftbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_leftbg")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/#simage_rightbg")
	arg_1_0._simageicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "root/propinfo/goIcon/#simage_icon")
	arg_1_0._imagecosticon = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_buy/cost/#simage_costicon")
	arg_1_0._txtoriginalCost = gohelper.findChildText(arg_1_0.viewGO, "root/#go_buy/cost/#txt_originalCost")
	arg_1_0._txtsalePrice = gohelper.findChildText(arg_1_0.viewGO, "root/#go_buy/cost/#txt_originalCost/#txt_salePrice")
	arg_1_0._txtgoodsNameCn = gohelper.findChildText(arg_1_0.viewGO, "root/propinfo/#txt_goodsNameCn")
	arg_1_0._txtgoodsNameEn = gohelper.findChildText(arg_1_0.viewGO, "root/propinfo/#txt_goodsNameEn")
	arg_1_0._trsgoodsDesc = gohelper.findChild(arg_1_0.viewGO, "root/propinfo/info/goodsDesc").transform
	arg_1_0._txtgoodsDesc = gohelper.findChildText(arg_1_0.viewGO, "root/propinfo/info/goodsDesc/Viewport/Content/#txt_goodsDesc")
	arg_1_0._txtgoodsUseDesc = gohelper.findChildText(arg_1_0.viewGO, "root/propinfo/info/goodsDesc/Viewport/Content/#txt_goodsUseDesc")
	arg_1_0._txtgoodsHave = gohelper.findChildText(arg_1_0.viewGO, "root/propinfo/group/#go_goodsHavebg/bg/#txt_goodsHave")
	arg_1_0._goitem = gohelper.findChild(arg_1_0.viewGO, "root/propinfo/group/#go_item")
	arg_1_0._txtitemcount = gohelper.findChildText(arg_1_0.viewGO, "root/propinfo/group/#go_item/#txt_itemcount")
	arg_1_0._txtvalue = gohelper.findChildText(arg_1_0.viewGO, "root/#go_buy/valuebg/#txt_value")
	arg_1_0._btnmin = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_buy/#btn_min")
	arg_1_0._btnsub = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_buy/#btn_sub")
	arg_1_0._btnadd = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_buy/#btn_add")
	arg_1_0._btnmax = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_buy/#btn_max")
	arg_1_0._btnbuy = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_buy/#btn_buy")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._trsinfo = gohelper.findChild(arg_1_0.viewGO, "root/propinfo/info").transform
	arg_1_0._goremain = gohelper.findChild(arg_1_0.viewGO, "root/propinfo/info/#go_goodsheader/remain")
	arg_1_0._txtremain = gohelper.findChildText(arg_1_0.viewGO, "root/propinfo/info/#go_goodsheader/remain/#txt_remain")
	arg_1_0._goLimit = gohelper.findChild(arg_1_0.viewGO, "root/propinfo/info/#go_goodsheader/#go_Limit")
	arg_1_0._gounique = gohelper.findChild(arg_1_0.viewGO, "root/propinfo/info/#go_goodsheader/go_unique")
	arg_1_0._inputvalue = gohelper.findChildTextMeshInputField(arg_1_0.viewGO, "root/#go_buy/valuebg/#input_value")
	arg_1_0._btnclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/propinfo/#btn_click")
	arg_1_0._gogoodsHavebg = gohelper.findChild(arg_1_0.viewGO, "root/propinfo/group/#go_goodsHavebg")
	arg_1_0._gobuy = gohelper.findChild(arg_1_0.viewGO, "root/#go_buy")
	arg_1_0._gotips = gohelper.findChild(arg_1_0.viewGO, "root/#go_tips")
	arg_1_0._txtlocktips = gohelper.findChildText(arg_1_0.viewGO, "root/#go_tips/#txt_locktips")
	arg_1_0._goinclude = gohelper.findChild(arg_1_0.viewGO, "root/#go_include")
	arg_1_0._txtsalePrice2 = gohelper.findChildText(arg_1_0.viewGO, "root/#go_include/cost/#txt_salePrice")
	arg_1_0._imagecosticon2 = gohelper.findChildImage(arg_1_0.viewGO, "root/#go_include/cost/#simage_costicon")
	arg_1_0._btnbuy2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#go_include/#btn_buy")

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

function var_0_0._onEndEdit(arg_10_0, arg_10_1)
	local var_10_0 = tonumber(arg_10_1)

	var_10_0 = var_10_0 and math.floor(var_10_0)

	if not var_10_0 or var_10_0 <= 0 then
		var_10_0 = 1

		GameFacade.showToast(ToastEnum.VersionActivityNormalStoreNoGoods)
	end

	if var_10_0 > arg_10_0._maxBuyCount then
		arg_10_0:_buyCountAddToast()
	end

	arg_10_0._buyCount = math.max(math.min(var_10_0, arg_10_0._maxBuyCount), 1)

	arg_10_0:_refreshBuyCount()
	arg_10_0:_refreshGoods(arg_10_0.goodsConfig)
end

function var_0_0._onValueChanged(arg_11_0, arg_11_1)
	return
end

function var_0_0._btnbuyOnClick(arg_12_0)
	local var_12_0 = false

	if arg_12_0._itemType == MaterialEnum.MaterialType.Hero then
		var_12_0 = CharacterModel.instance:isHeroFullDuplicateCount(arg_12_0._itemId)
	end

	if var_12_0 then
		local var_12_1 = HeroConfig.instance:getHeroCO(arg_12_0._itemId).duplicateItem2
		local var_12_2 = GameUtil.splitString2(var_12_1, true)
		local var_12_3 = ItemConfig.instance:getItemConfig(var_12_2[1][1], var_12_2[1][2])

		MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.HeroFullDuplicateCount, MsgBoxEnum.BoxType.Yes_No, arg_12_0._tryBuyGoods, nil, nil, arg_12_0, nil, nil, var_12_3.name)
	else
		arg_12_0:_tryBuyGoods()
	end
end

function var_0_0._tryBuyGoods(arg_13_0)
	if arg_13_0._costType == MaterialEnum.MaterialType.Currency and arg_13_0._costId == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
		local var_13_0 = arg_13_0._mo:getCost(arg_13_0._buyCount)

		if CurrencyController.instance:checkFreeDiamondEnough(var_13_0, CurrencyEnum.PayDiamondExchangeSource.Store, nil, arg_13_0._buyGoods, arg_13_0, arg_13_0.closeThis, arg_13_0) then
			arg_13_0:_buyGoods()
		end
	elseif arg_13_0._buyCount > arg_13_0._maxBuyCount then
		arg_13_0:_buyCountAddToast()
	elseif arg_13_0._buyCount > 0 then
		arg_13_0:_buyGoods()
	end
end

function var_0_0._buyGoods(arg_14_0)
	StoreController.instance:buyGoods(arg_14_0._mo, arg_14_0._buyCount, arg_14_0._buyCallback, arg_14_0)
end

function var_0_0._buyCallback(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	if arg_15_2 == 0 then
		arg_15_0:closeThis()
	end
end

function var_0_0._editableInitView(arg_16_0)
	arg_16_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_16_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	arg_16_0._buyCount = 1
	arg_16_0._maxBuyCount = 1

	gohelper.addUIClickAudio(arg_16_0._btnbuy.gameObject, AudioEnum.UI.Store_Good_Click)

	arg_16_0._goincludeContent = gohelper.findChild(arg_16_0._goinclude, "#scroll_product/viewport/content")
	arg_16_0._contentHorizontal = arg_16_0._goincludeContent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	arg_16_0._iconItemList = {}
end

function var_0_0._refreshBuyCount(arg_17_0)
	local var_17_0 = arg_17_0._mo:getCost(arg_17_0._buyCount)

	if var_17_0 == 0 then
		arg_17_0._txtsalePrice.text = luaLang("store_free")
	else
		arg_17_0._txtsalePrice.text = tostring(var_17_0)
	end

	arg_17_0._txtsalePrice2.text = arg_17_0._txtsalePrice.text

	arg_17_0._inputvalue:SetText(tostring(arg_17_0._buyCount))

	local var_17_1 = arg_17_0._mo:canAffordQuantity()

	if var_17_1 == -1 or var_17_1 >= arg_17_0._buyCount then
		SLFramework.UGUI.GuiHelper.SetColor(arg_17_0._txtsalePrice, "#393939")
		SLFramework.UGUI.GuiHelper.SetColor(arg_17_0._txtsalePrice2, "#393939")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_17_0._txtsalePrice, "#bf2e11")
		SLFramework.UGUI.GuiHelper.SetColor(arg_17_0._txtsalePrice2, "#bf2e11")
	end

	arg_17_0._txtoriginalCost.text = ""
end

function var_0_0.ShowLockTips(arg_18_0)
	if StoreConfig.instance:getGoodsConfig(arg_18_0._mo.goodsId).needEpisodeId == StoreEnum.Need4RDEpisodeId then
		arg_18_0._txtlocktips.text = string.format("%s%s", luaLang("dungeon_unlock_4RD"), luaLang("dungeon_unlock"))
	else
		local var_18_0 = arg_18_0._mo.lvlimitchapter
		local var_18_1 = arg_18_0._mo.lvlimitepisode
		local var_18_2 = "dungeon_unlock_episode"

		if arg_18_0._mo.isHardChapter then
			var_18_2 = "dungeon_unlock_episode_hard"
		end

		arg_18_0._txtlocktips.text = string.format(luaLang(var_18_2), string.format("%s-%s", var_18_0, var_18_1))
	end
end

function var_0_0._refreshUI(arg_19_0)
	arg_19_0.goodsConfig = StoreConfig.instance:getGoodsConfig(arg_19_0._mo.goodsId)

	local var_19_0 = string.splitToNumber(arg_19_0.goodsConfig.product, "#")
	local var_19_1 = var_19_0[1]
	local var_19_2 = var_19_0[2]

	arg_19_0._txtgoodsNameCn.text = ItemModel.instance:getItemConfig(var_19_1, var_19_2).name

	gohelper.setActive(arg_19_0._txtgoodsDesc.gameObject, true)
	gohelper.setActive(arg_19_0._txtgoodsUseDesc.gameObject, true)
	gohelper.setActive(arg_19_0._gobuy, arg_19_0:_isStoreItemUnlock())
	gohelper.setActive(arg_19_0._gotips, not arg_19_0:_isStoreItemUnlock())

	if not arg_19_0:_isStoreItemUnlock() then
		arg_19_0:ShowLockTips()
	end

	if StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(arg_19_0._mo.goodsId) then
		gohelper.setActive(arg_19_0._gobuy, false)
		gohelper.setActive(arg_19_0._gotips, true)

		arg_19_0._txtlocktips.text = string.format(luaLang("weekwalk_layer_unlock"), arg_19_0._mo.limitWeekWalkLayer)
	end

	arg_19_0:_refreshGoods(arg_19_0.goodsConfig)

	local var_19_3 = false

	if arg_19_0._itemType == MaterialEnum.MaterialType.Hero then
		arg_19_0._txtgoodsDesc.text = ItemModel.instance:getItemConfig(var_19_0[1], var_19_0[2]).desc2
	else
		arg_19_0._txtgoodsDesc.text = ItemModel.instance:getItemConfig(var_19_0[1], var_19_0[2]).desc
	end

	arg_19_0._txtgoodsUseDesc.text = ItemModel.instance:getItemConfig(var_19_0[1], var_19_0[2]).useDesc

	local var_19_4 = arg_19_0.goodsConfig.cost

	if string.nilorempty(var_19_4) then
		arg_19_0._costType, arg_19_0._costId = nil

		gohelper.setActive(arg_19_0._imagecosticon.gameObject, false)
		gohelper.setActive(arg_19_0._imagecosticon2.gameObject, false)
	else
		local var_19_5 = string.split(var_19_4, "|")

		var_19_3 = #var_19_5 > 1

		local var_19_6 = var_19_5[arg_19_0._mo.buyCount + 1] or var_19_5[#var_19_5]
		local var_19_7 = string.split(var_19_6, "#")

		arg_19_0._costType = tonumber(var_19_7[1])
		arg_19_0._costId = tonumber(var_19_7[2])

		local var_19_8, var_19_9 = ItemModel.instance:getItemConfigAndIcon(arg_19_0._costType, arg_19_0._costId)
		local var_19_10 = var_19_8.icon
		local var_19_11 = string.format("%s_1", var_19_10)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_19_0._imagecosticon, var_19_11)
		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_19_0._imagecosticon2, var_19_11)
		gohelper.setActive(arg_19_0._imagecosticon.gameObject, true)

		if var_19_8 ~= nil then
			arg_19_0.viewContainer:setCurrencyType(arg_19_0._costId, arg_19_0._costType, var_19_10)
		else
			arg_19_0.viewContainer:setCurrencyType(arg_19_0._costId, arg_19_0._costType)
		end
	end

	local var_19_12 = arg_19_0.goodsConfig.maxBuyCount - arg_19_0._mo.buyCount

	if var_19_3 then
		arg_19_0._txtremain.text = luaLang("store_multi_one")

		gohelper.setActive(arg_19_0._goremain, true)
		gohelper.setActive(arg_19_0._txtremain.gameObject, true)
	else
		local var_19_13 = StoreConfig.instance:getRemain(arg_19_0.goodsConfig, var_19_12, arg_19_0._mo.offlineTime)

		if string.nilorempty(var_19_13) then
			gohelper.setActive(arg_19_0._goremain, false)
			gohelper.setActive(arg_19_0._txtremain.gameObject, false)

			local var_19_14 = recthelper.getHeight(arg_19_0._trsinfo)

			recthelper.setHeight(arg_19_0._trsgoodsDesc, var_19_14)
		else
			gohelper.setActive(arg_19_0._goremain, true)
			gohelper.setActive(arg_19_0._txtremain.gameObject, true)

			arg_19_0._txtremain.text = var_19_13
		end
	end

	arg_19_0._buyCount = 1

	arg_19_0:_refreshBuyCount()
	arg_19_0:_refreshInclude()
	arg_19_0:_refreshGoUnique()
	arg_19_0:_refreshLimitTag()
end

function var_0_0._refreshGoUnique(arg_20_0)
	gohelper.setActive(arg_20_0._gounique, false)
end

function var_0_0._refreshInclude(arg_21_0)
	if not arg_21_0:_isStoreItemUnlock() then
		return
	end

	local var_21_0 = arg_21_0._itemSubType == ItemEnum.SubType.SpecifiedGift

	if not var_21_0 then
		return
	end

	local var_21_1

	gohelper.setActive(arg_21_0._gobuy, false)
	gohelper.setActive(arg_21_0._goinclude, true)
	gohelper.setActive(arg_21_0._txtgoodsDesc.gameObject, false)
	gohelper.setActive(arg_21_0._txtgoodsUseDesc.gameObject, true)

	local var_21_2 = 0

	if var_21_0 then
		local var_21_3, var_21_4 = ItemModel.instance:getItemConfigAndIcon(arg_21_0._itemType, arg_21_0._itemId, true)
		local var_21_5 = GameUtil.splitString2(var_21_3.effect, true)

		var_21_2 = #var_21_5

		for iter_21_0, iter_21_1 in ipairs(var_21_5) do
			local var_21_6 = arg_21_0._iconItemList[iter_21_0]
			local var_21_7 = iter_21_1[1]
			local var_21_8 = iter_21_1[2]
			local var_21_9 = iter_21_1[3]

			local function var_21_10()
				MaterialTipController.instance:showMaterialInfo(var_21_7, var_21_8)
			end

			if var_21_6 == nil then
				if var_21_7 == MaterialEnum.MaterialType.Equip then
					var_21_6 = IconMgr.instance:getCommonEquipIcon(arg_21_0._goincludeContent)

					var_21_6:setMOValue(var_21_7, var_21_8, var_21_9, nil, true)
					var_21_6:hideLv(true)
					var_21_6:customClick(var_21_10)

					var_21_1 = var_21_7
				else
					var_21_6 = IconMgr.instance:getCommonItemIcon(arg_21_0._goincludeContent)

					var_21_6:setMOValue(var_21_7, var_21_8, var_21_9, nil, true)

					var_21_1 = var_21_7
				end

				table.insert(arg_21_0._iconItemList, var_21_6)
			end
		end
	end

	if var_21_1 == MaterialEnum.MaterialType.Equip then
		arg_21_0._contentHorizontal.spacing = 6.62
		arg_21_0._contentHorizontal.padding.left = -2
		arg_21_0._contentHorizontal.padding.top = 10
	end

	for iter_21_2 = var_21_2 + 1, #arg_21_0._iconItemList do
		gohelper.setActive(arg_21_0._iconItemList[iter_21_2].go, false)
	end
end

function var_0_0._refreshGoods(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1.product
	local var_23_1 = string.split(var_23_0, "#")

	arg_23_0._itemType = tonumber(var_23_1[1])
	arg_23_0._itemId = tonumber(var_23_1[2])
	arg_23_0._itemQuantity = tonumber(var_23_1[3])

	gohelper.setActive(arg_23_0._goitem, true)

	arg_23_0._txtitemcount.text = string.format("%s%s", luaLang("multiple"), GameUtil.numberDisplay(arg_23_0._itemQuantity * arg_23_0._buyCount))

	local var_23_2, var_23_3 = ItemModel.instance:getItemConfigAndIcon(arg_23_0._itemType, arg_23_0._itemId, true)

	arg_23_0._itemSubType = var_23_2.subType

	local var_23_4 = true

	if tonumber(arg_23_0._itemType) == MaterialEnum.MaterialType.Equip then
		var_23_3 = ResUrl.getEquipSuit(var_23_2.icon)
		var_23_4 = false
	end

	arg_23_0._simageicon:LoadImage(var_23_3, var_23_4 and function()
		arg_23_0._simageicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
	end or nil)
	gohelper.setActive(arg_23_0._gogoodsHavebg, true)

	arg_23_0._txtgoodsHave.text = string.format("%s", GameUtil.numberDisplay(ItemModel.instance:getItemQuantity(arg_23_0._itemType, arg_23_0._itemId)))
end

function var_0_0._refreshLimitTag(arg_25_0)
	local var_25_0 = string.splitToNumber(arg_25_0.goodsConfig.product, "#")
	local var_25_1 = var_25_0[1]
	local var_25_2 = var_25_0[2]
	local var_25_3 = false

	if var_25_1 == MaterialEnum.MaterialType.Equip then
		var_25_3 = EquipModel.instance:isLimit(var_25_2)
	end

	gohelper.setActive(arg_25_0._goLimit, var_25_3)
end

function var_0_0._buyCountAddToast(arg_26_0)
	local var_26_0, var_26_1 = arg_26_0._mo:getBuyMaxQuantity()

	if arg_26_0._buyCount + 1 >= CommonConfig.instance:getConstNum(ConstEnum.StoreMaxBuyCount) or var_26_1 == StoreEnum.LimitType.BuyLimit or var_26_1 == StoreEnum.LimitType.Default then
		GameFacade.showToast(ToastEnum.StoreMaxBuyCount)
	elseif var_26_1 == StoreEnum.LimitType.Currency then
		if arg_26_0._costType and arg_26_0._costId then
			local var_26_2 = ItemModel.instance:getItemConfig(arg_26_0._costType, arg_26_0._costId)

			GameFacade.showToast(ToastEnum.DiamondBuy, var_26_2.name)
		end
	elseif var_26_1 == StoreEnum.LimitType.CurrencyChanged then
		GameFacade.showToast(ToastEnum.CurrencyChanged)
	end
end

function var_0_0._refreshMaxBuyCount(arg_27_0)
	arg_27_0._maxBuyCount = arg_27_0._mo:getBuyMaxQuantity()

	local var_27_0 = CommonConfig.instance:getConstNum(ConstEnum.StoreMaxBuyCount)

	if var_27_0 < arg_27_0._maxBuyCount or arg_27_0._maxBuyCount == -1 then
		arg_27_0._maxBuyCount = var_27_0
	end
end

function var_0_0.onOpen(arg_28_0)
	arg_28_0._mo = arg_28_0.viewParam

	arg_28_0:_refreshMaxBuyCount()
	arg_28_0:_refreshUI()

	local var_28_0 = StoreConfig.instance:getGoodsConfig(arg_28_0._mo.goodsId)

	StoreController.instance:statOpenGoods(arg_28_0._mo.belongStoreId, var_28_0)
end

function var_0_0._isStoreItemUnlock(arg_29_0)
	local var_29_0 = StoreConfig.instance:getGoodsConfig(arg_29_0._mo.goodsId).needEpisodeId

	if StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(arg_29_0._mo.goodsId) then
		return false
	end

	if not var_29_0 or var_29_0 == 0 then
		return true
	end

	if var_29_0 == StoreEnum.Need4RDEpisodeId then
		return false
	end

	return DungeonModel.instance:hasPassLevelAndStory(var_29_0)
end

function var_0_0.onClose(arg_30_0)
	local var_30_0 = StoreConfig.instance:getGoodsConfig(arg_30_0._mo.goodsId)

	StoreController.instance:statCloseGoods(var_30_0)
end

function var_0_0.onUpdateParam(arg_31_0)
	arg_31_0._mo = arg_31_0.viewParam

	arg_31_0:_refreshMaxBuyCount()
	arg_31_0:_refreshUI()
end

function var_0_0.onDestroyView(arg_32_0)
	arg_32_0._simageleftbg:UnLoadImage()
	arg_32_0._simagerightbg:UnLoadImage()
end

return var_0_0
