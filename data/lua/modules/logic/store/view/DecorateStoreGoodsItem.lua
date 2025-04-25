module("modules.logic.store.view.DecorateStoreGoodsItem", package.seeall)

slot0 = class("DecorateStoreGoodsItem", ListScrollCellExtend)

function slot0.onInitView(slot0)
	slot0._goNormalBg = gohelper.findChild(slot0.viewGO, "bg")
	slot0._goActBg = gohelper.findChild(slot0.viewGO, "actBg")
	slot0._goActBgEff = gohelper.findChild(slot0.viewGO, "actBg/mask")
	slot0._gogoods = gohelper.findChild(slot0.viewGO, "#go_goods")
	slot0._goicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_goods/#go_icon")
	slot0._goroomiconmask = gohelper.findChild(slot0.viewGO, "#go_goods/#go_roomiconmask")
	slot0._simageroomicon = gohelper.findChildSingleImage(slot0.viewGO, "#go_goods/#go_roomiconmask/#simage_roomicon")
	slot0._gonum = gohelper.findChild(slot0.viewGO, "#go_goods/#go_num")
	slot0._gonumBg = gohelper.findChild(slot0.viewGO, "#go_goods/#go_num/bg")
	slot0._gonumText = gohelper.findChildText(slot0.viewGO, "#go_goods/#go_num/bg/#txt_num")
	slot0._rare = gohelper.findChildImage(slot0.viewGO, "rare")
	slot0._txtmaterialNum = gohelper.findChildText(slot0.viewGO, "cost/txt_materialNum")
	slot0._imagematerial = gohelper.findChildImage(slot0.viewGO, "cost/txt_materialNum/simage_material")
	slot0._txtremain = gohelper.findChildText(slot0.viewGO, "layout/txt_remain")
	slot0._txtgoodsName = gohelper.findChildText(slot0.viewGO, "layout/txt_goodsName")
	slot0._gosoldout = gohelper.findChild(slot0.viewGO, "go_soldout")
	slot0._golevellimit = gohelper.findChild(slot0.viewGO, "go_levellimit")
	slot0._txtlvlimit = gohelper.findChildText(slot0.viewGO, "go_levellimit/txt")
	slot0._gohas = gohelper.findChild(slot0.viewGO, "go_has")
	slot0._goline = gohelper.findChild(slot0.viewGO, "#go_line")
	slot0._goitemreddot = gohelper.findChild(slot0.viewGO, "go_itemreddot")
	slot0._godiscount = gohelper.findChild(slot0.viewGO, "go_tag/#go_discount")
	slot0._txtdiscount = gohelper.findChildText(slot0.viewGO, "go_tag/#go_discount/#txt_discount")
	slot0._txtoriginalCost = gohelper.findChildText(slot0.viewGO, "cost/txt_materialNum/txt_originalCost")
	slot0._gooffflineTime = gohelper.findChild(slot0.viewGO, "#go_offflineTime")
	slot0._txtoffflineTime = gohelper.findChildText(slot0.viewGO, "#go_offflineTime/#txt_offflineTime")
	slot0._goRefreshTime = gohelper.findChild(slot0.viewGO, "#go_refreshtime")
	slot0._txtRefreshTime = gohelper.findChildText(slot0.viewGO, "#go_refreshtime/#txt_refreshtime")
	slot0._goroomactive = gohelper.findChild(slot0.viewGO, "#go_roomactive")
	slot0._goroomnum = gohelper.findChild(slot0.viewGO, "#go_roomactive/#go_roomnum")
	slot0._goroomticket = gohelper.findChild(slot0.viewGO, "#go_roomactive/#go_tag")
	slot0._txtroomnum = gohelper.findChildText(slot0.viewGO, "#go_roomactive/#go_roomnum/bg/#txt_roomnum")
	slot0._simageroomactiveicon = gohelper.findChildImage(slot0.viewGO, "#go_roomactive/#go_roomnum/bg/#txt_roomnum/#simage_roomactiveicon")
	slot0._txtCost2Num = gohelper.findChildText(slot0.viewGO, "cost/txt_yudiNum")
	slot0._imageCost2 = gohelper.findChildImage(slot0.viewGO, "cost/txt_yudiNum/simage_material")
	slot0._goherofull = gohelper.findChild(slot0.viewGO, "go_herofull")
	slot0._goUnique = gohelper.findChild(slot0.viewGO, "#go_unique")
	slot0._goLimit = gohelper.findChild(slot0.viewGO, "go_tag/#go_limit")
	slot0._goActTag = gohelper.findChild(slot0.viewGO, "go_tag/#go_act")
	slot0._goCost = gohelper.findChild(slot0.viewGO, "cost")
	slot0._goPath = gohelper.findChild(slot0.viewGO, "#go_path")
	slot0._txtPath = gohelper.findChildText(slot0.viewGO, "#go_path/#txt_path")
	slot0._btnPath = gohelper.findChildButton(slot0.viewGO, "#go_path/btn")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0:addEventCb(StoreController.instance, StoreEvent.jumpClickRoomChildGoods, slot0._onJumpClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0:removeEventCb(StoreController.instance, StoreEvent.jumpClickRoomChildGoods, slot0._onJumpClick, slot0)
end

function slot0._onJumpClick(slot0, slot1)
	if not slot1 or not slot0._mo then
		return
	end

	if slot1 == slot0._mo.goodsId then
		slot0:_onClick()
	end
end

function slot0._editableInitView(slot0)
	slot0._btnGO = gohelper.findChild(slot0.viewGO, "clickArea")
	slot0._btn = gohelper.getClickWithAudio(slot0._btnGO, AudioEnum.UI.Store_Good_Click)

	slot0._btn:AddClickListener(slot0._onClick, slot0)
	slot0._btnPath:AddClickListener(slot0._onClickPath, slot0)

	slot0._soldout = false
	slot0._limitSold = false
	slot0._hascloth = false

	gohelper.setActive(slot0._goline, false)
	gohelper.setActive(slot0._goUnique, false)

	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._imgicon = gohelper.findChildImage(slot0.viewGO, "#go_goods/#go_icon")
	slot0._gonewtag = gohelper.findChild(slot0.viewGO, "go_newtag")

	slot0:addEventCb(TimeDispatcher.instance, TimeDispatcher.OnHour, slot0.onHourRefresh, slot0)
end

function slot0._onClickPath(slot0)
	if not slot0._mo then
		return
	end

	if slot0._mo:getIsJumpGoods() then
		GameFacade.jump(slot0._mo.config.jumpId)
	end
end

function slot0._onClick(slot0)
	if slot0._mo:getIsActGoods() then
		slot0:_onActGoodsClick()
	elseif slot0._mo:getIsJumpGoods() then
		slot0:_onJumpGoodsClick()
	else
		slot0:_onNormalGoodsClick()
	end
end

function slot0._onJumpGoodsClick(slot0)
	if slot0._hascloth then
		GameFacade.showToast(ToastEnum.NormalStoreGoodsHasCloth)
	elseif slot0._soldout then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)
	elseif slot0._limitSold then
		GameFacade.showToast(ToastEnum.PackageStoreGoods)
	else
		MaterialTipController.instance:showMaterialInfo(slot0._itemType, slot0._itemId)
	end
end

function slot0._onNormalGoodsClick(slot0)
	if slot0._hascloth then
		GameFacade.showToast(ToastEnum.NormalStoreGoodsHasCloth)
	elseif slot0._soldout then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)
	elseif slot0._limitSold then
		GameFacade.showToast(ToastEnum.PackageStoreGoods)
	elseif not slot0:_isStoreItemUnlock() then
		slot0._mo.lvlimitchapter = slot0.lvlimitchapter
		slot0._mo.lvlimitepisode = slot0.lvlimitepisode
		slot0._mo.isHardChapter = slot0.isHardChapter

		StoreController.instance:openNormalGoodsView(slot0._mo)
	elseif StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(slot0._mo.goodsId) then
		slot0._mo.limitWeekWalkLayer = StoreConfig.instance:getGoodsConfig(slot0._mo.goodsId).needWeekwalkLayer

		StoreController.instance:openNormalGoodsView(slot0._mo)
	else
		StoreController.instance:openNormalGoodsView(slot0._mo)
	end
end

function slot0._isStoreItemUnlock(slot0)
	if slot0._mo:getIsActGoods() then
		return true
	end

	if not StoreConfig.instance:getGoodsConfig(slot0._mo.goodsId).needEpisodeId or slot1 == 0 then
		return true
	end

	if slot1 == StoreEnum.Need4RDEpisodeId then
		return false
	end

	return DungeonModel.instance:hasPassLevelAndStory(slot1)
end

function slot0._onActGoodsClick(slot0)
	if not slot0._mo then
		return
	end

	if FurnaceTreasureModel.instance:getGoodsRemainCount(slot0._mo:getBelongStoreId(), slot0._mo:getActGoodsId()) < FurnaceTreasureEnum.DEFAULT_BUY_COUNT then
		GameFacade.showToast(ToastEnum.CurrencyChanged)

		return
	end

	ViewMgr.instance:openView(ViewName.FurnaceTreasureBuyView, {
		goodsId = slot1,
		storeId = slot2
	})
end

function slot0.onHourRefresh(slot0)
	if slot0._mo:getIsActGoods() then
		return
	end

	slot0:refreshNextRefreshTime(StoreConfig.instance:getGoodsConfig(slot0._mo.goodsId))
end

function slot0.getAnimator(slot0)
	return slot0._animator
end

function slot0.hideOffflineTime(slot0)
	slot0._hideOffflineTime = true
end

function slot0.onUpdateMO(slot0, slot1)
	if not slot1 then
		return
	end

	slot0._mo = slot1

	if slot1:getIsActGoods() then
		slot0:refreshActGoods()
	else
		slot0:refreshNormalGoods()
	end

	gohelper.setActive(slot0._goNormalBg, not slot2)
	gohelper.setActive(slot0._goActBg, slot2)
	gohelper.setActive(slot0._goActTag, slot2)
end

function slot0.refreshNormalGoods(slot0)
	slot2 = slot0:_isStoreItemUnlock()

	gohelper.setActive(slot0._goitemreddot, StoreModel.instance:isGoodsItemRedDotShow(slot0._mo.goodsId))
	gohelper.setActive(slot0._golevellimit, not slot2)

	if not slot2 then
		if StoreConfig.instance:getGoodsConfig(slot1.goodsId).needEpisodeId == StoreEnum.Need4RDEpisodeId then
			slot0._txtlvlimit.text = string.format("%s%s", luaLang("level_limit_4RD_unlock"), luaLang("dungeon_unlock"))
		else
			slot6 = "dungeon_main_unlock"
			slot0.isHardChapter = false

			if DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot3).chapterId) and slot5.type == DungeonEnum.ChapterType.Hard then
				slot5 = DungeonConfig.instance:getChapterCO(DungeonConfig.instance:getEpisodeCO(slot4.preEpisode).chapterId)
				slot6 = "dungeon_main_hard_unlock"
				slot0.isHardChapter = true
			end

			slot7, slot8, slot9 = nil

			if slot4 and slot5 then
				slot7 = slot5.chapterIndex
				slot8, slot9 = DungeonConfig.instance:getChapterEpisodeIndexWithSP(slot5.id, slot4.id)

				if type == DungeonEnum.EpisodeType.Sp then
					slot7 = "SP"
				end
			end

			slot0._txtlvlimit.text = string.format(luaLang(slot6), string.format("%s-%s", slot7, slot8))
			slot0.lvlimitchapter = slot7
			slot0.lvlimitepisode = slot8
		end
	end

	if StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(slot1.goodsId) then
		gohelper.setActive(slot0._golevellimit, true)

		slot0._txtlvlimit.text = string.format(luaLang("dungeon_weekwalk_unlock"), StoreConfig.instance:getGoodsConfig(slot1.goodsId).needWeekwalkLayer)
	end

	slot0:updateGoodsItemAttribute(StoreConfig.instance:getGoodsConfig(slot1.goodsId))

	slot4 = ItemModel.instance:getItemConfig(slot0._itemType, slot0._itemId)

	if string.nilorempty(slot1.config.name) == false then
		slot0._txtgoodsName.text = slot1.config.name
	elseif slot4 then
		slot0._txtgoodsName.text = slot4.name
	else
		logError("找不到商品配置: " .. slot3.product)
	end

	slot0:_refreshGoods(slot3)

	if string.nilorempty(slot3.cost) then
		slot0._txtmaterialNum.text = luaLang("store_free")

		gohelper.setActive(slot0._imagematerial.gameObject, false)
	else
		slot8 = string.splitToNumber(string.split(slot5, "|")[slot1.buyCount + 1] or slot6[#slot6], "#")
		slot0._costQuantity = slot8[3]
		slot11, slot12 = ItemModel.instance:getItemConfigAndIcon(slot8[1], slot8[2])

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagematerial, string.format("%s_1", slot11.icon))
		gohelper.setActive(slot0._imagematerial.gameObject, true)

		slot0._txtmaterialNum.text = slot0._costQuantity
	end

	if string.nilorempty(slot3.cost2) then
		gohelper.setActive(slot0._txtCost2Num.gameObject, false)

		slot0._txtmaterialNum.fontSize = 36
		slot0._txtCost2Num.fontSize = 36
	else
		slot0._txtmaterialNum.fontSize = 30
		slot0._txtCost2Num.fontSize = 30

		gohelper.setActive(slot0._txtCost2Num.gameObject, true)
		gohelper.setActive(slot0._goline, true)

		slot9 = string.splitToNumber(string.split(slot6, "|")[slot1.buyCount + 1] or slot7[#slot7], "#")
		slot13, slot14 = ItemModel.instance:getItemConfigAndIcon(slot9[1], slot9[2])

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imageCost2, string.format("%s_1", slot13.icon))

		slot0._txtCost2Num.text = slot9[3]
	end

	if slot0._mo.config.jumpId ~= 0 then
		gohelper.setActive(slot0._goCost, false)
		gohelper.setActive(slot0._goline, false)
		gohelper.setActive(slot0._goPath, true)

		if slot0._mo.config.activityId ~= 0 then
			slot0._txtPath.text = luaLang("getGoodsByActivity")
		elseif slot0._mo.config.bindgoodid ~= 0 then
			slot0._txtPath.text = luaLang("getGoodsByBingGoods")
		end
	end

	gohelper.setActive(slot0._godiscount, slot1.config.originalCost > 0)

	if slot3.cost and slot3.cost2 then
		gohelper.setActive(slot0._txtoriginalCost.gameObject, false)
	else
		gohelper.setActive(slot0._txtoriginalCost.gameObject, slot1.config.originalCost > 0)
	end

	slot0._txtdiscount.text = string.format("-%d%%", 100 - math.ceil(slot0._costQuantity / slot1.config.originalCost * 100))
	slot0._txtoriginalCost.text = slot1.config.originalCost

	gohelper.setActive(slot0._gooffflineTime, not slot0._hideOffflineTime and slot1.offlineTime > 0)

	if slot1.offlineTime - ServerTime.now() > 0 then
		if slot8 > 3600 then
			slot9, slot10 = TimeUtil.secondToRoughTime(slot8)
			slot0._txtoffflineTime.text = formatLuaLang("remain", slot9 .. slot10)
		else
			slot0._txtoffflineTime.text = luaLang("not_enough_one_hour")
		end
	end

	slot0._soldout = slot1:isSoldOut()

	slot0:refreshNextRefreshTime(slot3)

	if slot1:needShowNew() then
		if not (slot0._itemType == MaterialEnum.MaterialType.BlockPackage) and not (slot0._itemType == MaterialEnum.MaterialType.Building) then
			gohelper.setActive(slot0._gonewtag, slot1:needShowNew())
		end
	end

	if string.nilorempty(StoreConfig.instance:getRemain(slot3, slot3.maxBuyCount - slot1.buyCount, slot1.offlineTime)) then
		gohelper.setActive(slot0._txtremain.gameObject, false)
	else
		gohelper.setActive(slot0._txtremain.gameObject, true)

		slot0._txtremain.text = slot11
	end

	slot0._hascloth = slot1:alreadyHas()

	gohelper.setActive(slot0._gohas, false)
	gohelper.setActive(slot0._gosoldout, false)
	gohelper.setActive(slot0._btnPath.gameObject, not slot0._hascloth)

	if slot0._hascloth then
		gohelper.setActive(slot0._gohas, true)
	elseif slot0._soldout then
		gohelper.setActive(slot0._gosoldout, true)
		gohelper.setActive(slot0._goherofull, false)
	end

	slot0:refreshGoUnique()
	slot0:refreshLimitHas()
end

function slot0.updateGoodsItemAttribute(slot0, slot1)
	slot4 = GameUtil.splitString2(slot1.product, true)[1]
	slot0._itemType = slot4[1]
	slot0._itemId = slot4[2]
	slot0._itemQuantity = slot4[3]
	slot0.itemConfig, slot0.itemIcon = ItemModel.instance:getItemConfigAndIcon(slot0._itemType, slot0._itemId, true)
end

function slot0.refreshNextRefreshTime(slot0, slot1)
	slot2 = slot0._soldout and slot1.refreshTime ~= StoreEnum.RefreshTime.Forever

	gohelper.setActive(slot0._goRefreshTime, slot2)

	if slot2 and slot0:getEndTimeStamp(slot1) - ServerTime.now() > 0 then
		gohelper.setActive(slot0._goRefreshTime, true)

		if TimeUtil.OneHourSecond < slot3 then
			slot4, slot5 = TimeUtil.secondToRoughTime(slot3)
			slot0._txtRefreshTime.text = formatLuaLang("refresh_remain_time", slot4 .. slot5)
		else
			slot0._txtRefreshTime.text = luaLang("not_enough_one_hour")
		end
	end
end

function slot0.getEndTimeStamp(slot0, slot1)
	if not slot1 then
		return -1
	end

	if slot1.refreshTime == StoreEnum.RefreshTime.Forever then
		return -1
	elseif slot1.refreshTime == StoreEnum.RefreshTime.Day then
		return ServerTime.getToadyEndTimeStamp(true)
	elseif slot1.refreshTime == StoreEnum.RefreshTime.Week then
		return ServerTime.getWeekEndTimeStamp(true)
	elseif slot1.refreshTime == StoreEnum.RefreshTime.Month then
		return ServerTime.getMonthEndTimeStamp(true)
	else
		return -1
	end
end

function slot0.refreshLimitHas(slot0)
	if slot0._itemType == MaterialEnum.MaterialType.Equip and not slot0._soldout then
		slot0._limitSold = EquipModel.instance:isLimitAndAlreadyHas(slot0._itemId)

		gohelper.setActive(slot0._golevellimit, slot0._limitSold)

		slot0._txtlvlimit.text = string.format(luaLang("reachUpperLimit"))
	else
		slot0._limitSold = false
	end
end

function slot0.refreshActGoods(slot0)
	slot0._soldout = false
	slot0._limitSold = false
	slot0._hascloth = false
	slot1 = slot0._mo

	gohelper.setActive(slot0._goitemreddot, false)
	gohelper.setActive(slot0._golevellimit, false)
	gohelper.setActive(slot0._goActBgEff, slot1:getIsGreatActGoods())
	slot0:updateActGoodsItemAttribute(slot1:getBelongStoreId(), slot0._mo:getActGoodsId())

	slot0._txtgoodsName.text = ItemModel.instance:getItemConfig(slot0._itemType, slot0._itemId) and slot5.name or ""

	slot0:_refreshGoods()

	if not FurnaceTreasureModel.instance:getCostItem(slot2) then
		slot0._txtmaterialNum.text = luaLang("store_free")

		gohelper.setActive(slot0._imagematerial.gameObject, false)
	else
		slot7 = MaterialEnum.MaterialType.Currency

		if string.nilorempty(FurnaceTreasureConfig.instance:get147GoodsCost(slot3)) then
			slot0._costQuantity = 0
		else
			slot0._costQuantity = string.splitToNumber(slot8, "#")[1]
		end

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagematerial, string.format("%s_1", ItemModel.instance:getItemConfigAndIcon(slot7, slot6).icon))
		gohelper.setActive(slot0._imagematerial.gameObject, true)

		slot0._txtmaterialNum.text = slot0._costQuantity
	end

	gohelper.setActive(slot0._txtCost2Num.gameObject, false)

	slot0._txtmaterialNum.fontSize = 36
	slot0._txtCost2Num.fontSize = 36

	gohelper.setActive(slot0._godiscount, false)
	gohelper.setActive(slot0._txtoriginalCost.gameObject, false)
	gohelper.setActive(slot0._gooffflineTime, false)
	gohelper.setActive(slot0._goRefreshTime, false)
	gohelper.setActive(slot0._gonewtag, false)

	slot0._txtremain.text = string.format("%s:%d", luaLang("store_buylimit_day"), FurnaceTreasureModel.instance:getGoodsRemainCount(slot2, slot3))

	gohelper.setActive(slot0._txtremain.gameObject, true)
	gohelper.setActive(slot0._gohas, false)
	gohelper.setActive(slot0._gosoldout, false)
	gohelper.setActive(slot0._goherofull, false)
	slot0:refreshGoUnique()
end

function slot0.updateActGoodsItemAttribute(slot0, slot1, slot2)
	slot0._itemType, slot0._itemId, slot0._itemQuantity = FurnaceTreasureConfig.instance:getAct147GoodsShowItem(FurnaceTreasureModel.instance:getGoodsPoolId(slot1, slot2))
	slot0.itemConfig, slot0.itemIcon = ItemModel.instance:getItemConfigAndIcon(slot0._itemType, slot0._itemId, true)
end

slot1 = {
	StoreEnum.StoreId.CritterStore
}

function slot0._refreshGoods(slot0, slot1)
	slot5 = 256
	slot6 = 256
	slot7 = false

	if slot0._itemType == MaterialEnum.MaterialType.Equip then
		slot0._goicon:LoadImage(ResUrl.getHeroDefaultEquipIcon(slot0.itemConfig.icon), function (slot0, slot1)
			recthelper.setSize(uv0._imgicon.transform, slot0, slot1)
		end(278, 228))
	elseif not string.nilorempty(slot0.itemIcon) then
		slot0._goicon:LoadImage(slot0.itemIcon, slot2(slot5, slot6))
	else
		slot7 = true
	end

	slot8 = slot0._itemType == MaterialEnum.MaterialType.BlockPackage
	slot9 = slot0._itemType == MaterialEnum.MaterialType.Building

	gohelper.setActive(slot0._goicon.gameObject, not slot8 and not slot9 and not slot7)
	gohelper.setActive(slot0._goroomactive, not LuaUtil.tableContains(uv0, slot0._mo.belongStoreId) and (slot8 or slot9))
	gohelper.setActive(slot0._goroomticket, slot0:checkShowTicket() and not slot0._soldout)
	slot0:refreshRoomItemUI(slot8, slot9)

	if slot8 or slot9 then
		UISpriteSetMgr.instance:setRoomSprite(slot0._simageroomactiveicon, "jianshezhi")
	end

	slot10 = 0

	if not string.nilorempty(slot1 and slot1.product) then
		for slot16, slot17 in ipairs(GameUtil.splitString2(slot11, true)) do
			if slot17[1] == MaterialEnum.MaterialType.BlockPackage then
				slot10 = slot10 + RoomConfig.instance:getBlockPackageFullDegree(slot17[2]) * slot17[3]
			elseif slot17[1] == MaterialEnum.MaterialType.Building then
				slot10 = slot10 + RoomConfig.instance:getBuildingConfig(slot17[2]).buildDegree * slot17[3]
			end
		end
	end

	slot0._txtroomnum.text = slot10

	slot0:showStackableNum()
	slot0:_checkHeroFullDuplicateCount()
	slot0:refreshRare()
end

function slot0.refreshRare(slot0)
	slot1 = false

	if slot0._mo:getIsActGoods() then
		UISpriteSetMgr.instance:setStoreGoodsSprite(slot0._rare, FurnaceTreasureEnum.RareBgName)

		slot1 = true
	elseif slot0.itemConfig then
		UISpriteSetMgr.instance:setStoreGoodsSprite(slot0._rare, "rare" .. slot0.itemConfig.rare)

		slot1 = true
	end

	gohelper.setActive(slot0._rare.gameObject, slot1)
end

function slot0.refreshRoomItemUI(slot0, slot1, slot2)
	gohelper.setActive(slot0._goroomiconmask, slot1 or slot2)

	if slot1 or slot2 then
		slot3 = slot0._mo.config.bigImg

		if string.nilorempty(slot0._mo.config.bigImg) then
			slot3 = slot0.itemIcon
		end

		slot0._simageroomicon:LoadImage(slot3, function ()
			uv0._simageroomicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
		end)
	end
end

function slot0.showStackableNum(slot0)
	if not slot0.itemConfig then
		gohelper.setActive(slot0._gonum.gameObject, false)

		return
	end

	if (not slot0.itemConfig.isStackable or slot0.itemConfig.isStackable == 1 or slot0._itemType == MaterialEnum.MaterialType.Equip) and slot0._itemQuantity > 1 then
		gohelper.setActive(slot0._gonum.gameObject, true)

		slot0._gonumText.text = GameUtil.numberDisplay(slot0._itemQuantity)
	else
		gohelper.setActive(slot0._gonum.gameObject, false)
	end
end

function slot0._checkHeroFullDuplicateCount(slot0)
	slot1 = false

	if slot0._itemType == MaterialEnum.MaterialType.Hero then
		slot1 = CharacterModel.instance:isHeroFullDuplicateCount(slot0._itemId)
	end

	gohelper.setActive(slot0._goherofull, slot1)
end

function slot0.refreshGoUnique(slot0)
	gohelper.setActive(slot0._goLimit, ItemConfig.instance:isUniqueByCo(slot0._itemType, slot0.itemConfig))
end

function slot0.checkShowTicket(slot0)
	if slot0._mo.belongStoreId == StoreEnum.SubRoomOld or slot0._mo.belongStoreId == StoreEnum.SubRoomNew then
		if slot0._itemType ~= MaterialEnum.MaterialType.BlockPackage and slot0._itemType ~= MaterialEnum.MaterialType.Building then
			return false
		end

		if slot0._mo:getIsJumpGoods() then
			return false
		end

		if slot0.itemConfig.rare <= 3 then
			if ItemModel.instance:getItemCount(StoreEnum.NormalRoomTicket) > 0 or ItemModel.instance:getItemCount(StoreEnum.TopRoomTicket) > 0 then
				return true
			end
		elseif slot0.itemConfig.rare <= 5 and ItemModel.instance:getItemCount(StoreEnum.TopRoomTicket) > 0 then
			return true
		end
	end

	return false
end

function slot0.onDestroy(slot0)
	if slot0._goicon then
		slot0._goicon:UnLoadImage()

		slot0._goicon = nil
	end

	slot0._simageroomicon:UnLoadImage()
	slot0._btn:RemoveClickListener()
	slot0._btnPath:RemoveClickListener()
end

return slot0
