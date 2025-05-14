module("modules.logic.store.view.NormalStoreGoodsView", package.seeall)

local var_0_0 = class("NormalStoreGoodsView", BaseView)

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
	local var_12_0 = RoomConfig.instance:getBuildingSkinCoByItemId(arg_12_0._itemId)

	if var_12_0 and not arg_12_0:_isHasBuiding(var_12_0) then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomBuldingStoreBuy, MsgBoxEnum.BoxType.Yes_No, arg_12_0._tryBuyGoods, nil, nil, arg_12_0, nil, nil)

		return
	end

	local var_12_1 = false

	if arg_12_0._itemType == MaterialEnum.MaterialType.Hero then
		var_12_1 = CharacterModel.instance:isHeroFullDuplicateCount(arg_12_0._itemId)
	end

	if var_12_1 then
		local var_12_2 = HeroConfig.instance:getHeroCO(arg_12_0._itemId).duplicateItem2
		local var_12_3 = GameUtil.splitString2(var_12_2, true)
		local var_12_4 = ItemConfig.instance:getItemConfig(var_12_3[1][1], var_12_3[1][2])

		MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.HeroFullDuplicateCount, MsgBoxEnum.BoxType.Yes_No, arg_12_0._tryBuyGoods, nil, nil, arg_12_0, nil, nil, var_12_4.name)
	else
		arg_12_0:_tryBuyGoods()
	end
end

function var_0_0._isHasBuiding(arg_13_0, arg_13_1)
	local var_13_0 = RoomModel.instance:getBuildingInfoList()

	if var_13_0 then
		for iter_13_0, iter_13_1 in ipairs(var_13_0) do
			if arg_13_1.buildingId == iter_13_1.buildingId then
				return true
			end
		end
	end
end

function var_0_0._tryBuyGoods(arg_14_0)
	if arg_14_0._costType == MaterialEnum.MaterialType.Currency and arg_14_0._costId == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
		local var_14_0 = arg_14_0._mo:getCost(arg_14_0._buyCount)

		if CurrencyController.instance:checkFreeDiamondEnough(var_14_0, CurrencyEnum.PayDiamondExchangeSource.Store, nil, arg_14_0._buyGoods, arg_14_0, arg_14_0.closeThis, arg_14_0) then
			arg_14_0:_buyGoods()
		end
	elseif arg_14_0._buyCount > arg_14_0._maxBuyCount then
		arg_14_0:_buyCountAddToast()
	elseif arg_14_0._buyCount > 0 then
		arg_14_0:_buyGoods()
	end
end

function var_0_0._buyGoods(arg_15_0)
	StoreController.instance:buyGoods(arg_15_0._mo, arg_15_0._buyCount, arg_15_0._buyCallback, arg_15_0)
end

function var_0_0._buyCallback(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_2 == 0 then
		arg_16_0:closeThis()
	end
end

function var_0_0._editableInitView(arg_17_0)
	arg_17_0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	arg_17_0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	arg_17_0._buyCount = 1
	arg_17_0._maxBuyCount = 1

	gohelper.addUIClickAudio(arg_17_0._btnbuy.gameObject, AudioEnum.UI.Store_Good_Click)

	arg_17_0._goincludeContent = gohelper.findChild(arg_17_0._goinclude, "#scroll_product/viewport/content")
	arg_17_0._contentHorizontal = arg_17_0._goincludeContent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	arg_17_0._iconItemList = {}
end

function var_0_0._refreshBuyCount(arg_18_0)
	local var_18_0 = arg_18_0._mo:getCost(arg_18_0._buyCount)

	if var_18_0 == 0 then
		arg_18_0._txtsalePrice.text = luaLang("store_free")
	else
		arg_18_0._txtsalePrice.text = tostring(var_18_0)
	end

	arg_18_0._txtsalePrice2.text = arg_18_0._txtsalePrice.text

	arg_18_0._inputvalue:SetText(tostring(arg_18_0._buyCount))

	local var_18_1 = arg_18_0._mo:canAffordQuantity()

	if var_18_1 == -1 or var_18_1 >= arg_18_0._buyCount then
		SLFramework.UGUI.GuiHelper.SetColor(arg_18_0._txtsalePrice, "#393939")
		SLFramework.UGUI.GuiHelper.SetColor(arg_18_0._txtsalePrice2, "#393939")
	else
		SLFramework.UGUI.GuiHelper.SetColor(arg_18_0._txtsalePrice, "#bf2e11")
		SLFramework.UGUI.GuiHelper.SetColor(arg_18_0._txtsalePrice2, "#bf2e11")
	end

	arg_18_0._txtoriginalCost.text = ""
end

function var_0_0.ShowLockTips(arg_19_0)
	if StoreConfig.instance:getGoodsConfig(arg_19_0._mo.goodsId).needEpisodeId == StoreEnum.Need4RDEpisodeId then
		arg_19_0._txtlocktips.text = string.format("%s%s", luaLang("dungeon_unlock_4RD"), luaLang("dungeon_unlock"))
	else
		local var_19_0 = arg_19_0._mo.lvlimitchapter
		local var_19_1 = arg_19_0._mo.lvlimitepisode
		local var_19_2 = "dungeon_unlock_episode"

		if arg_19_0._mo.isHardChapter then
			var_19_2 = "dungeon_unlock_episode_hard"
		end

		arg_19_0._txtlocktips.text = string.format(luaLang(var_19_2), string.format("%s-%s", var_19_0, var_19_1))
	end
end

function var_0_0._refreshUI(arg_20_0)
	arg_20_0.goodsConfig = StoreConfig.instance:getGoodsConfig(arg_20_0._mo.goodsId)

	local var_20_0 = string.splitToNumber(arg_20_0.goodsConfig.product, "#")
	local var_20_1 = var_20_0[1]
	local var_20_2 = var_20_0[2]

	arg_20_0._txtgoodsNameCn.text = ItemModel.instance:getItemConfig(var_20_1, var_20_2).name

	gohelper.setActive(arg_20_0._txtgoodsDesc.gameObject, true)
	gohelper.setActive(arg_20_0._txtgoodsUseDesc.gameObject, true)
	gohelper.setActive(arg_20_0._gobuy, arg_20_0:_isStoreItemUnlock())
	gohelper.setActive(arg_20_0._gotips, not arg_20_0:_isStoreItemUnlock())

	if not arg_20_0:_isStoreItemUnlock() then
		arg_20_0:ShowLockTips()
	end

	if StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(arg_20_0._mo.goodsId) then
		gohelper.setActive(arg_20_0._gobuy, false)
		gohelper.setActive(arg_20_0._gotips, true)

		arg_20_0._txtlocktips.text = string.format(luaLang("weekwalk_layer_unlock"), arg_20_0._mo.limitWeekWalkLayer)
	end

	arg_20_0:_refreshGoods(arg_20_0.goodsConfig)

	local var_20_3 = false

	if arg_20_0._itemType == MaterialEnum.MaterialType.Hero then
		arg_20_0._txtgoodsDesc.text = ItemModel.instance:getItemConfig(var_20_0[1], var_20_0[2]).desc2
	else
		arg_20_0._txtgoodsDesc.text = ItemModel.instance:getItemConfig(var_20_0[1], var_20_0[2]).desc
	end

	arg_20_0._txtgoodsUseDesc.text = ItemModel.instance:getItemConfig(var_20_0[1], var_20_0[2]).useDesc

	local var_20_4 = arg_20_0.goodsConfig.cost

	if string.nilorempty(var_20_4) then
		arg_20_0._costType, arg_20_0._costId = nil

		gohelper.setActive(arg_20_0._imagecosticon.gameObject, false)
		gohelper.setActive(arg_20_0._imagecosticon2.gameObject, false)
	else
		local var_20_5 = string.split(var_20_4, "|")

		var_20_3 = #var_20_5 > 1

		local var_20_6 = var_20_5[arg_20_0._mo.buyCount + 1] or var_20_5[#var_20_5]
		local var_20_7 = string.split(var_20_6, "#")

		arg_20_0._costType = tonumber(var_20_7[1])
		arg_20_0._costId = tonumber(var_20_7[2])

		local var_20_8, var_20_9 = ItemModel.instance:getItemConfigAndIcon(arg_20_0._costType, arg_20_0._costId)
		local var_20_10 = var_20_8.icon
		local var_20_11 = string.format("%s_1", var_20_10)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_20_0._imagecosticon, var_20_11)
		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_20_0._imagecosticon2, var_20_11)
		gohelper.setActive(arg_20_0._imagecosticon.gameObject, true)
		arg_20_0.viewContainer:setCurrencyType(arg_20_0._costId)
	end

	local var_20_12 = arg_20_0.goodsConfig.maxBuyCount - arg_20_0._mo.buyCount

	if var_20_3 then
		arg_20_0._txtremain.text = luaLang("store_multi_one")

		gohelper.setActive(arg_20_0._goremain, true)
		gohelper.setActive(arg_20_0._txtremain.gameObject, true)
	else
		local var_20_13 = StoreConfig.instance:getRemain(arg_20_0.goodsConfig, var_20_12, arg_20_0._mo.offlineTime)

		if string.nilorempty(var_20_13) then
			gohelper.setActive(arg_20_0._goremain, false)
			gohelper.setActive(arg_20_0._txtremain.gameObject, false)

			local var_20_14 = recthelper.getHeight(arg_20_0._trsinfo)

			recthelper.setHeight(arg_20_0._trsgoodsDesc, var_20_14)
		else
			gohelper.setActive(arg_20_0._goremain, true)
			gohelper.setActive(arg_20_0._txtremain.gameObject, true)

			arg_20_0._txtremain.text = var_20_13
		end
	end

	arg_20_0._buyCount = 1

	arg_20_0:_refreshBuyCount()
	arg_20_0:_refreshInclude()
	arg_20_0:_refreshGoUnique()
	arg_20_0:_refreshLimitTag()
end

function var_0_0._refreshGoUnique(arg_21_0)
	gohelper.setActive(arg_21_0._gounique, false)
end

function var_0_0._refreshInclude(arg_22_0)
	if not arg_22_0:_isStoreItemUnlock() then
		return
	end

	local var_22_0 = arg_22_0._itemSubType == ItemEnum.SubType.SpecifiedGift

	if not var_22_0 then
		return
	end

	local var_22_1

	gohelper.setActive(arg_22_0._gobuy, false)
	gohelper.setActive(arg_22_0._goinclude, true)
	gohelper.setActive(arg_22_0._txtgoodsDesc.gameObject, false)
	gohelper.setActive(arg_22_0._txtgoodsUseDesc.gameObject, true)

	local var_22_2 = 0

	if var_22_0 then
		local var_22_3, var_22_4 = ItemModel.instance:getItemConfigAndIcon(arg_22_0._itemType, arg_22_0._itemId, true)
		local var_22_5 = GameUtil.splitString2(var_22_3.effect, true)

		var_22_2 = #var_22_5

		for iter_22_0, iter_22_1 in ipairs(var_22_5) do
			local var_22_6 = arg_22_0._iconItemList[iter_22_0]
			local var_22_7 = iter_22_1[1]
			local var_22_8 = iter_22_1[2]
			local var_22_9 = iter_22_1[3]

			local function var_22_10()
				MaterialTipController.instance:showMaterialInfo(var_22_7, var_22_8)
			end

			if var_22_6 == nil then
				if var_22_7 == MaterialEnum.MaterialType.Equip then
					var_22_6 = IconMgr.instance:getCommonEquipIcon(arg_22_0._goincludeContent)

					var_22_6:setMOValue(var_22_7, var_22_8, var_22_9, nil, true)
					var_22_6:hideLv(true)
					var_22_6:customClick(var_22_10)

					var_22_1 = var_22_7
				else
					var_22_6 = IconMgr.instance:getCommonItemIcon(arg_22_0._goincludeContent)

					var_22_6:setMOValue(var_22_7, var_22_8, var_22_9, nil, true)

					var_22_1 = var_22_7
				end

				table.insert(arg_22_0._iconItemList, var_22_6)
			end
		end
	end

	if var_22_1 == MaterialEnum.MaterialType.Equip then
		arg_22_0._contentHorizontal.spacing = 6.62
		arg_22_0._contentHorizontal.padding.left = -2
		arg_22_0._contentHorizontal.padding.top = 10
	end

	for iter_22_2 = var_22_2 + 1, #arg_22_0._iconItemList do
		gohelper.setActive(arg_22_0._iconItemList[iter_22_2].go, false)
	end
end

function var_0_0._refreshGoods(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_1.product
	local var_24_1 = string.split(var_24_0, "#")

	arg_24_0._itemType = tonumber(var_24_1[1])
	arg_24_0._itemId = tonumber(var_24_1[2])
	arg_24_0._itemQuantity = tonumber(var_24_1[3])

	gohelper.setActive(arg_24_0._goitem, true)

	arg_24_0._txtitemcount.text = string.format("%s%s", luaLang("multiple"), GameUtil.numberDisplay(arg_24_0._itemQuantity * arg_24_0._buyCount))

	local var_24_2, var_24_3 = ItemModel.instance:getItemConfigAndIcon(arg_24_0._itemType, arg_24_0._itemId, true)

	arg_24_0._itemSubType = var_24_2.subType

	local var_24_4 = true

	if tonumber(arg_24_0._itemType) == MaterialEnum.MaterialType.Equip then
		var_24_3 = ResUrl.getEquipSuit(var_24_2.icon)
		var_24_4 = false
	end

	arg_24_0._simageicon:LoadImage(var_24_3, var_24_4 and function()
		arg_24_0._simageicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
	end or nil)
	gohelper.setActive(arg_24_0._gogoodsHavebg, true)

	arg_24_0._txtgoodsHave.text = string.format("%s", GameUtil.numberDisplay(ItemModel.instance:getItemQuantity(arg_24_0._itemType, arg_24_0._itemId)))
end

function var_0_0._refreshLimitTag(arg_26_0)
	local var_26_0 = string.splitToNumber(arg_26_0.goodsConfig.product, "#")
	local var_26_1 = var_26_0[1]
	local var_26_2 = var_26_0[2]
	local var_26_3 = false

	if var_26_1 == MaterialEnum.MaterialType.Equip then
		var_26_3 = EquipModel.instance:isLimit(var_26_2)
	end

	gohelper.setActive(arg_26_0._goLimit, var_26_3)
end

function var_0_0._buyCountAddToast(arg_27_0)
	local var_27_0, var_27_1 = arg_27_0._mo:getBuyMaxQuantity()

	if arg_27_0._buyCount + 1 >= CommonConfig.instance:getConstNum(ConstEnum.StoreMaxBuyCount) or var_27_1 == StoreEnum.LimitType.BuyLimit or var_27_1 == StoreEnum.LimitType.Default then
		GameFacade.showToast(ToastEnum.StoreMaxBuyCount)
	elseif var_27_1 == StoreEnum.LimitType.Currency then
		if arg_27_0._costType and arg_27_0._costId then
			local var_27_2 = ItemModel.instance:getItemConfig(arg_27_0._costType, arg_27_0._costId)

			GameFacade.showToast(ToastEnum.DiamondBuy, var_27_2.name)
		end
	elseif var_27_1 == StoreEnum.LimitType.CurrencyChanged then
		GameFacade.showToast(ToastEnum.CurrencyChanged)
	end
end

function var_0_0._refreshMaxBuyCount(arg_28_0)
	arg_28_0._maxBuyCount = arg_28_0._mo:getBuyMaxQuantity()

	local var_28_0 = CommonConfig.instance:getConstNum(ConstEnum.StoreMaxBuyCount)

	if var_28_0 < arg_28_0._maxBuyCount or arg_28_0._maxBuyCount == -1 then
		arg_28_0._maxBuyCount = var_28_0
	end
end

function var_0_0.onOpen(arg_29_0)
	arg_29_0._mo = arg_29_0.viewParam

	arg_29_0:_refreshMaxBuyCount()
	arg_29_0:_refreshUI()

	local var_29_0 = StoreConfig.instance:getGoodsConfig(arg_29_0._mo.goodsId)

	StoreController.instance:statOpenGoods(arg_29_0._mo.belongStoreId, var_29_0)
end

function var_0_0._isStoreItemUnlock(arg_30_0)
	local var_30_0 = StoreConfig.instance:getGoodsConfig(arg_30_0._mo.goodsId).needEpisodeId

	if StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(arg_30_0._mo.goodsId) then
		return false
	end

	if not var_30_0 or var_30_0 == 0 then
		return true
	end

	if var_30_0 == StoreEnum.Need4RDEpisodeId then
		return false
	end

	return DungeonModel.instance:hasPassLevelAndStory(var_30_0)
end

function var_0_0.onClose(arg_31_0)
	local var_31_0 = StoreConfig.instance:getGoodsConfig(arg_31_0._mo.goodsId)

	StoreController.instance:statCloseGoods(var_31_0)
end

function var_0_0.onUpdateParam(arg_32_0)
	arg_32_0._mo = arg_32_0.viewParam

	arg_32_0:_refreshMaxBuyCount()
	arg_32_0:_refreshUI()
end

function var_0_0.onDestroyView(arg_33_0)
	arg_33_0._simageleftbg:UnLoadImage()
	arg_33_0._simagerightbg:UnLoadImage()
end

return var_0_0
