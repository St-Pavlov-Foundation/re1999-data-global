module("modules.logic.store.view.SummonStoreGoodsItem", package.seeall)

local var_0_0 = class("SummonStoreGoodsItem", ListScrollCellExtend)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gogoods = gohelper.findChild(arg_1_0.viewGO, "#go_goods")
	arg_1_0._goicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_goods/#go_icon")
	arg_1_0._goroomiconmask = gohelper.findChild(arg_1_0.viewGO, "#go_goods/#go_roomiconmask")
	arg_1_0._simageroomicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "#go_goods/#go_roomiconmask/#simage_roomicon")
	arg_1_0._gonum = gohelper.findChild(arg_1_0.viewGO, "#go_goods/#go_num")
	arg_1_0._gonumBg = gohelper.findChild(arg_1_0.viewGO, "#go_goods/#go_num/bg")
	arg_1_0._gonumText = gohelper.findChildText(arg_1_0.viewGO, "#go_goods/#go_num/bg/#txt_num")
	arg_1_0._rare = gohelper.findChildImage(arg_1_0.viewGO, "rare")
	arg_1_0._txtmaterialNum = gohelper.findChildText(arg_1_0.viewGO, "cost/txt_materialNum")
	arg_1_0._imagematerial = gohelper.findChildImage(arg_1_0.viewGO, "cost/txt_materialNum/simage_material")
	arg_1_0._txtremain = gohelper.findChildText(arg_1_0.viewGO, "layout/txt_remain")
	arg_1_0._txtgoodsName = gohelper.findChildText(arg_1_0.viewGO, "layout/txt_goodsName")
	arg_1_0._gosoldout = gohelper.findChild(arg_1_0.viewGO, "go_soldout")
	arg_1_0._golevellimit = gohelper.findChild(arg_1_0.viewGO, "go_levellimit")
	arg_1_0._txtlvlimit = gohelper.findChildText(arg_1_0.viewGO, "go_levellimit/txt")
	arg_1_0._gohas = gohelper.findChild(arg_1_0.viewGO, "go_has")
	arg_1_0._goline = gohelper.findChild(arg_1_0.viewGO, "#go_line")
	arg_1_0._goitemreddot = gohelper.findChild(arg_1_0.viewGO, "go_itemreddot")
	arg_1_0._godiscount = gohelper.findChild(arg_1_0.viewGO, "go_tag/#go_discount")
	arg_1_0._txtdiscount = gohelper.findChildText(arg_1_0.viewGO, "go_tag/#go_discount/#txt_discount")
	arg_1_0._txtoriginalCost = gohelper.findChildText(arg_1_0.viewGO, "cost/txt_materialNum/txt_originalCost")
	arg_1_0._gooffflineTime = gohelper.findChild(arg_1_0.viewGO, "#go_offflineTime")
	arg_1_0._txtoffflineTime = gohelper.findChildText(arg_1_0.viewGO, "#go_offflineTime/#txt_offflineTime")
	arg_1_0._goRefreshTime = gohelper.findChild(arg_1_0.viewGO, "#go_refreshtime")
	arg_1_0._txtRefreshTime = gohelper.findChildText(arg_1_0.viewGO, "#go_refreshtime/#txt_refreshtime")
	arg_1_0._goroomactive = gohelper.findChild(arg_1_0.viewGO, "#go_roomactive")
	arg_1_0._goroomnum = gohelper.findChild(arg_1_0.viewGO, "#go_roomactive/#go_roomnum")
	arg_1_0._txtroomnum = gohelper.findChildText(arg_1_0.viewGO, "#go_roomactive/#go_roomnum/bg/#txt_roomnum")
	arg_1_0._simageroomactiveicon = gohelper.findChildImage(arg_1_0.viewGO, "#go_roomactive/#go_roomnum/bg/#txt_roomnum/#simage_roomactiveicon")
	arg_1_0._txtCost2Num = gohelper.findChildText(arg_1_0.viewGO, "cost/txt_yudiNum")
	arg_1_0._imageCost2 = gohelper.findChildImage(arg_1_0.viewGO, "cost/txt_yudiNum/simage_material")
	arg_1_0._goherofull = gohelper.findChild(arg_1_0.viewGO, "go_herofull")
	arg_1_0._goUnique = gohelper.findChild(arg_1_0.viewGO, "#go_unique")
	arg_1_0._goLimit = gohelper.findChild(arg_1_0.viewGO, "go_tag/#go_limit")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._btnGO = gohelper.findChild(arg_4_0.viewGO, "clickArea")
	arg_4_0._btn = gohelper.getClickWithAudio(arg_4_0._btnGO, AudioEnum.UI.Store_Good_Click)

	arg_4_0._btn:AddClickListener(arg_4_0._onClick, arg_4_0)

	arg_4_0._soldout = false
	arg_4_0._limitSold = false
	arg_4_0._hascloth = false

	gohelper.setActive(arg_4_0._goline, false)
	gohelper.setActive(arg_4_0._goUnique, false)

	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._imgicon = gohelper.findChildImage(arg_4_0.viewGO, "#go_goods/#go_icon")
	arg_4_0._gonewtag = gohelper.findChild(arg_4_0.viewGO, "go_newtag")

	arg_4_0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnHour, arg_4_0.onHourRefresh, arg_4_0)
end

function var_0_0._onClick(arg_5_0)
	if arg_5_0._hascloth then
		GameFacade.showToast(ToastEnum.NormalStoreGoodsHasCloth)
	elseif arg_5_0._soldout then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)
	elseif arg_5_0._limitSold then
		GameFacade.showToast(ToastEnum.PackageStoreGoods)
	elseif not arg_5_0:_isStoreItemUnlock() then
		arg_5_0._mo.lvlimitchapter = arg_5_0.lvlimitchapter
		arg_5_0._mo.lvlimitepisode = arg_5_0.lvlimitepisode
		arg_5_0._mo.isHardChapter = arg_5_0.isHardChapter

		StoreController.instance:openSummonStoreGoodsView(arg_5_0._mo)
	elseif StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(arg_5_0._mo.goodsId) then
		local var_5_0 = StoreConfig.instance:getGoodsConfig(arg_5_0._mo.goodsId)

		if var_5_0 then
			arg_5_0._mo.limitWeekWalkLayer = var_5_0.needWeekwalkLayer

			StoreController.instance:openSummonStoreGoodsView(arg_5_0._mo)
		end
	else
		StoreController.instance:openSummonStoreGoodsView(arg_5_0._mo)
	end
end

function var_0_0._isStoreItemUnlock(arg_6_0)
	local var_6_0 = StoreConfig.instance:getGoodsConfig(arg_6_0._mo.goodsId).needEpisodeId

	if not var_6_0 or var_6_0 == 0 then
		return true
	end

	if var_6_0 == StoreEnum.Need4RDEpisodeId then
		return false
	end

	return DungeonModel.instance:hasPassLevelAndStory(var_6_0)
end

function var_0_0.hideOffflineTime(arg_7_0)
	arg_7_0._hideOffflineTime = true
end

function var_0_0.onUpdateMO(arg_8_0, arg_8_1)
	if arg_8_1:getIsActGoods() then
		return
	end

	arg_8_0._mo = arg_8_1

	gohelper.setActive(arg_8_0._goitemreddot, StoreModel.instance:isGoodsItemRedDotShow(arg_8_1.goodsId))
	gohelper.setActive(arg_8_0._golevellimit, not arg_8_0:_isStoreItemUnlock())

	if not arg_8_0:_isStoreItemUnlock() then
		local var_8_0 = StoreConfig.instance:getGoodsConfig(arg_8_0._mo.goodsId).needEpisodeId

		if var_8_0 == StoreEnum.Need4RDEpisodeId then
			arg_8_0._txtlvlimit.text = string.format("%s%s", luaLang("level_limit_4RD_unlock"), luaLang("dungeon_unlock"))
		else
			local var_8_1 = DungeonConfig.instance:getEpisodeCO(var_8_0)
			local var_8_2 = DungeonConfig.instance:getChapterCO(var_8_1.chapterId)
			local var_8_3 = "dungeon_main_unlock"

			arg_8_0.isHardChapter = false

			if var_8_2 and var_8_2.type == DungeonEnum.ChapterType.Hard then
				var_8_1 = DungeonConfig.instance:getEpisodeCO(var_8_1.preEpisode)
				var_8_2 = DungeonConfig.instance:getChapterCO(var_8_1.chapterId)
				var_8_3 = "dungeon_main_hard_unlock"
				arg_8_0.isHardChapter = true
			end

			local var_8_4
			local var_8_5
			local var_8_6

			if var_8_1 and var_8_2 then
				var_8_4 = var_8_2.chapterIndex

				local var_8_7

				var_8_5, var_8_7 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(var_8_2.id, var_8_1.id)

				if type == DungeonEnum.EpisodeType.Sp then
					var_8_4 = "SP"
				end
			end

			arg_8_0._txtlvlimit.text = string.format(luaLang(var_8_3), string.format("%s-%s", var_8_4, var_8_5))
			arg_8_0.lvlimitchapter = var_8_4
			arg_8_0.lvlimitepisode = var_8_5
		end
	end

	if StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(arg_8_0._mo.goodsId) then
		gohelper.setActive(arg_8_0._golevellimit, true)

		local var_8_8 = StoreConfig.instance:getGoodsConfig(arg_8_0._mo.goodsId).needWeekwalkLayer

		arg_8_0._txtlvlimit.text = string.format(luaLang("dungeon_weekwalk_unlock"), var_8_8)
	end

	local var_8_9 = StoreConfig.instance:getGoodsConfig(arg_8_1.goodsId)

	arg_8_0:updateGoodsItemAttribute(var_8_9)

	local var_8_10 = ItemModel.instance:getItemConfig(arg_8_0._itemType, arg_8_0._itemId)

	if string.nilorempty(arg_8_1.config.name) == false then
		arg_8_0._txtgoodsName.text = arg_8_1.config.name
	elseif var_8_10 then
		arg_8_0._txtgoodsName.text = var_8_10.name
	else
		logError("找不到商品配置: " .. var_8_9.product)
	end

	arg_8_0:_refreshGoods(var_8_9)

	local var_8_11 = var_8_9.cost

	if string.nilorempty(var_8_11) then
		arg_8_0._txtmaterialNum.text = luaLang("store_free")

		gohelper.setActive(arg_8_0._imagematerial.gameObject, false)
	else
		local var_8_12 = string.split(var_8_11, "|")
		local var_8_13 = var_8_12[arg_8_1.buyCount + 1] or var_8_12[#var_8_12]
		local var_8_14 = string.splitToNumber(var_8_13, "#")
		local var_8_15 = var_8_14[1]
		local var_8_16 = var_8_14[2]

		arg_8_0._costQuantity = var_8_14[3]

		local var_8_17, var_8_18 = ItemModel.instance:getItemConfigAndIcon(var_8_15, var_8_16)
		local var_8_19 = var_8_17.icon
		local var_8_20 = string.format("%s_1", var_8_19)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_8_0._imagematerial, var_8_20)
		gohelper.setActive(arg_8_0._imagematerial.gameObject, true)

		arg_8_0._txtmaterialNum.text = arg_8_0._costQuantity
	end

	local var_8_21 = var_8_9.cost2

	if string.nilorempty(var_8_21) then
		gohelper.setActive(arg_8_0._txtCost2Num.gameObject, false)

		arg_8_0._txtmaterialNum.fontSize = 36
		arg_8_0._txtCost2Num.fontSize = 36
	else
		arg_8_0._txtmaterialNum.fontSize = 30
		arg_8_0._txtCost2Num.fontSize = 30

		gohelper.setActive(arg_8_0._txtCost2Num.gameObject, true)
		gohelper.setActive(arg_8_0._goline, true)

		local var_8_22 = string.split(var_8_21, "|")
		local var_8_23 = var_8_22[arg_8_1.buyCount + 1] or var_8_22[#var_8_22]
		local var_8_24 = string.splitToNumber(var_8_23, "#")
		local var_8_25 = var_8_24[1]
		local var_8_26 = var_8_24[2]
		local var_8_27 = var_8_24[3]
		local var_8_28, var_8_29 = ItemModel.instance:getItemConfigAndIcon(var_8_25, var_8_26)
		local var_8_30 = var_8_28.icon
		local var_8_31 = string.format("%s_1", var_8_30)

		UISpriteSetMgr.instance:setCurrencyItemSprite(arg_8_0._imageCost2, var_8_31)

		arg_8_0._txtCost2Num.text = var_8_27
	end

	gohelper.setActive(arg_8_0._godiscount, arg_8_1.config.originalCost > 0)

	if var_8_9.cost and var_8_9.cost2 then
		gohelper.setActive(arg_8_0._txtoriginalCost.gameObject, false)
	else
		gohelper.setActive(arg_8_0._txtoriginalCost.gameObject, arg_8_1.config.originalCost > 0)
	end

	local var_8_32 = arg_8_0._costQuantity / arg_8_1.config.originalCost
	local var_8_33 = math.ceil(var_8_32 * 100)

	arg_8_0._txtdiscount.text = string.format("-%d%%", 100 - var_8_33)
	arg_8_0._txtoriginalCost.text = arg_8_1.config.originalCost

	gohelper.setActive(arg_8_0._gooffflineTime, not arg_8_0._hideOffflineTime and arg_8_1.offlineTime > 0)

	local var_8_34 = arg_8_1.offlineTime - ServerTime.now()

	if var_8_34 > 0 then
		if var_8_34 > 3600 then
			local var_8_35, var_8_36 = TimeUtil.secondToRoughTime(var_8_34)

			arg_8_0._txtoffflineTime.text = formatLuaLang("remain", var_8_35 .. var_8_36)
		else
			arg_8_0._txtoffflineTime.text = luaLang("not_enough_one_hour")
		end
	end

	arg_8_0._soldout = arg_8_1:isSoldOut()

	arg_8_0:refreshNextRefreshTime(var_8_9)

	if arg_8_1:needShowNew() then
		local var_8_37 = arg_8_0._itemType == MaterialEnum.MaterialType.BlockPackage
		local var_8_38 = arg_8_0._itemType == MaterialEnum.MaterialType.Building

		if not var_8_37 and not var_8_38 then
			gohelper.setActive(arg_8_0._gonewtag, arg_8_1:needShowNew())
		end
	end

	local var_8_39 = var_8_9.maxBuyCount - arg_8_1.buyCount
	local var_8_40 = StoreConfig.instance:getRemain(var_8_9, var_8_39, arg_8_1.offlineTime)

	if string.nilorempty(var_8_40) then
		gohelper.setActive(arg_8_0._txtremain.gameObject, false)
	else
		gohelper.setActive(arg_8_0._txtremain.gameObject, true)

		arg_8_0._txtremain.text = var_8_40
	end

	arg_8_0._hascloth = arg_8_0._mo:alreadyHas()

	gohelper.setActive(arg_8_0._gohas, false)
	gohelper.setActive(arg_8_0._gosoldout, false)

	if arg_8_0._hascloth then
		gohelper.setActive(arg_8_0._gohas, true)
	elseif arg_8_0._soldout then
		gohelper.setActive(arg_8_0._gosoldout, true)
		gohelper.setActive(arg_8_0._goherofull, false)
	end

	arg_8_0:refreshGoUnique()
	arg_8_0:refreshLimitHas()
end

function var_0_0.updateGoodsItemAttribute(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1.product
	local var_9_1 = GameUtil.splitString2(var_9_0, true)[1]

	arg_9_0._itemType = var_9_1[1]
	arg_9_0._itemId = var_9_1[2]
	arg_9_0._itemQuantity = var_9_1[3]
	arg_9_0.itemConfig, arg_9_0.itemIcon = ItemModel.instance:getItemConfigAndIcon(arg_9_0._itemType, arg_9_0._itemId, true)
end

function var_0_0.refreshGoUnique(arg_10_0)
	gohelper.setActive(arg_10_0._goLimit, ItemConfig.instance:isUniqueByCo(arg_10_0._itemType, arg_10_0.itemConfig))
end

function var_0_0.refreshLimitHas(arg_11_0)
	if arg_11_0._itemType == MaterialEnum.MaterialType.Equip and not arg_11_0._soldout then
		arg_11_0._limitSold = EquipModel.instance:isLimitAndAlreadyHas(arg_11_0._itemId)

		gohelper.setActive(arg_11_0._golevellimit, arg_11_0._limitSold)

		arg_11_0._txtlvlimit.text = string.format(luaLang("reachUpperLimit"))
	else
		arg_11_0._limitSold = false
	end
end

function var_0_0.getEndTimeStamp(arg_12_0, arg_12_1)
	if not arg_12_1 then
		return -1
	end

	if arg_12_1.refreshTime == StoreEnum.RefreshTime.Forever then
		return -1
	elseif arg_12_1.refreshTime == StoreEnum.RefreshTime.Day then
		return ServerTime.getToadyEndTimeStamp(true)
	elseif arg_12_1.refreshTime == StoreEnum.RefreshTime.Week then
		return ServerTime.getWeekEndTimeStamp(true)
	elseif arg_12_1.refreshTime == StoreEnum.RefreshTime.Month then
		return ServerTime.getMonthEndTimeStamp(true)
	else
		return -1
	end
end

function var_0_0.refreshNextRefreshTime(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._soldout and arg_13_1.refreshTime ~= StoreEnum.RefreshTime.Forever

	gohelper.setActive(arg_13_0._goRefreshTime, var_13_0)

	if var_13_0 then
		local var_13_1 = arg_13_0:getEndTimeStamp(arg_13_1) - ServerTime.now()

		if var_13_1 > 0 then
			gohelper.setActive(arg_13_0._goRefreshTime, true)

			if var_13_1 > TimeUtil.OneHourSecond then
				local var_13_2, var_13_3 = TimeUtil.secondToRoughTime(var_13_1)

				arg_13_0._txtRefreshTime.text = formatLuaLang("refresh_remain_time", var_13_2 .. var_13_3)
			else
				arg_13_0._txtRefreshTime.text = luaLang("not_enough_one_hour")
			end
		end
	end
end

function var_0_0._refreshGoods(arg_14_0, arg_14_1)
	local function var_14_0(arg_15_0, arg_15_1)
		recthelper.setSize(arg_14_0._imgicon.transform, arg_15_0, arg_15_1)
	end

	local var_14_1 = 278
	local var_14_2 = 228
	local var_14_3 = 256
	local var_14_4 = 256

	if arg_14_0._itemType == MaterialEnum.MaterialType.Equip then
		arg_14_0._goicon:LoadImage(ResUrl.getHeroDefaultEquipIcon(arg_14_0.itemConfig.icon), var_14_0(var_14_1, var_14_2))
	else
		arg_14_0._goicon:LoadImage(arg_14_0.itemIcon, var_14_0(var_14_3, var_14_4))
	end

	local var_14_5 = arg_14_0._itemType == MaterialEnum.MaterialType.BlockPackage
	local var_14_6 = arg_14_0._itemType == MaterialEnum.MaterialType.Building

	gohelper.setActive(arg_14_0._goroomactive, var_14_5 or var_14_6)
	arg_14_0:refreshRoomItemUI(var_14_5, var_14_6)

	if var_14_5 or var_14_6 then
		UISpriteSetMgr.instance:setRoomSprite(arg_14_0._simageroomactiveicon, "jianshezhi")
	end

	local var_14_7 = arg_14_1.product
	local var_14_8 = GameUtil.splitString2(var_14_7, true)
	local var_14_9 = 0

	for iter_14_0, iter_14_1 in ipairs(var_14_8) do
		if iter_14_1[1] == MaterialEnum.MaterialType.BlockPackage then
			var_14_9 = var_14_9 + RoomConfig.instance:getBlockPackageFullDegree(iter_14_1[2]) * iter_14_1[3]
		elseif iter_14_1[1] == MaterialEnum.MaterialType.Building then
			var_14_9 = var_14_9 + RoomConfig.instance:getBuildingConfig(iter_14_1[2]).buildDegree * iter_14_1[3]
		end
	end

	arg_14_0._txtroomnum.text = var_14_9

	arg_14_0:showStackableNum()
	arg_14_0:_checkHeroFullDuplicateCount()
	UISpriteSetMgr.instance:setStoreGoodsSprite(arg_14_0._rare, "rare" .. arg_14_0.itemConfig.rare)
end

function var_0_0._checkHeroFullDuplicateCount(arg_16_0)
	local var_16_0 = false

	if arg_16_0._itemType == MaterialEnum.MaterialType.Hero then
		var_16_0 = CharacterModel.instance:isHeroFullDuplicateCount(arg_16_0._itemId)
	end

	gohelper.setActive(arg_16_0._goherofull, var_16_0)
end

function var_0_0.showStackableNum(arg_17_0)
	if (not arg_17_0.itemConfig.isStackable or arg_17_0.itemConfig.isStackable == 1 or arg_17_0._itemType == MaterialEnum.MaterialType.Equip) and arg_17_0._itemQuantity > 1 then
		gohelper.setActive(arg_17_0._gonum.gameObject, true)

		arg_17_0._gonumText.text = GameUtil.numberDisplay(arg_17_0._itemQuantity)
	else
		gohelper.setActive(arg_17_0._gonum.gameObject, false)
	end
end

function var_0_0.refreshRoomItemUI(arg_18_0, arg_18_1, arg_18_2)
	gohelper.setActive(arg_18_0._goicon.gameObject, not arg_18_1 and not arg_18_2)
	gohelper.setActive(arg_18_0._goroomiconmask, arg_18_1 or arg_18_2)

	if arg_18_1 or arg_18_2 then
		local var_18_0 = arg_18_0._mo.config.bigImg

		if string.nilorempty(arg_18_0._mo.config.bigImg) then
			var_18_0 = arg_18_0.itemIcon
		end

		arg_18_0._simageroomicon:LoadImage(var_18_0, function()
			arg_18_0._simageroomicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
		end)
	end
end

function var_0_0.onHourRefresh(arg_20_0)
	local var_20_0 = StoreConfig.instance:getGoodsConfig(arg_20_0._mo.goodsId)

	arg_20_0:refreshNextRefreshTime(var_20_0)
end

function var_0_0.getAnimator(arg_21_0)
	return arg_21_0._animator
end

function var_0_0.onDestroy(arg_22_0)
	if arg_22_0._goicon then
		arg_22_0._goicon:UnLoadImage()

		arg_22_0._goicon = nil
	end

	arg_22_0._simageroomicon:UnLoadImage()
	arg_22_0._btn:RemoveClickListener()
end

return var_0_0
