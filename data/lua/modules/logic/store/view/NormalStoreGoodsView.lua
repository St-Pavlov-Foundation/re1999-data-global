module("modules.logic.store.view.NormalStoreGoodsView", package.seeall)

slot0 = class("NormalStoreGoodsView", BaseView)

function slot0.onInitView(slot0)
	slot0._simageblur = gohelper.findChildSingleImage(slot0.viewGO, "#simage_blur")
	slot0._simageleftbg = gohelper.findChildSingleImage(slot0.viewGO, "root/#simage_leftbg")
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "root/#simage_rightbg")
	slot0._simageicon = gohelper.findChildSingleImage(slot0.viewGO, "root/propinfo/goIcon/#simage_icon")
	slot0._imagecosticon = gohelper.findChildImage(slot0.viewGO, "root/#go_buy/cost/#simage_costicon")
	slot0._txtoriginalCost = gohelper.findChildText(slot0.viewGO, "root/#go_buy/cost/#txt_originalCost")
	slot0._txtsalePrice = gohelper.findChildText(slot0.viewGO, "root/#go_buy/cost/#txt_originalCost/#txt_salePrice")
	slot0._txtgoodsNameCn = gohelper.findChildText(slot0.viewGO, "root/propinfo/#txt_goodsNameCn")
	slot0._txtgoodsNameEn = gohelper.findChildText(slot0.viewGO, "root/propinfo/#txt_goodsNameEn")
	slot0._trsgoodsDesc = gohelper.findChild(slot0.viewGO, "root/propinfo/info/goodsDesc").transform
	slot0._txtgoodsDesc = gohelper.findChildText(slot0.viewGO, "root/propinfo/info/goodsDesc/Viewport/Content/#txt_goodsDesc")
	slot0._txtgoodsUseDesc = gohelper.findChildText(slot0.viewGO, "root/propinfo/info/goodsDesc/Viewport/Content/#txt_goodsUseDesc")
	slot0._txtgoodsHave = gohelper.findChildText(slot0.viewGO, "root/propinfo/group/#go_goodsHavebg/bg/#txt_goodsHave")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "root/propinfo/group/#go_item")
	slot0._txtitemcount = gohelper.findChildText(slot0.viewGO, "root/propinfo/group/#go_item/#txt_itemcount")
	slot0._txtvalue = gohelper.findChildText(slot0.viewGO, "root/#go_buy/valuebg/#txt_value")
	slot0._btnmin = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_buy/#btn_min")
	slot0._btnsub = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_buy/#btn_sub")
	slot0._btnadd = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_buy/#btn_add")
	slot0._btnmax = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_buy/#btn_max")
	slot0._btnbuy = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_buy/#btn_buy")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#btn_close")
	slot0._trsinfo = gohelper.findChild(slot0.viewGO, "root/propinfo/info").transform
	slot0._goremain = gohelper.findChild(slot0.viewGO, "root/propinfo/info/#go_goodsheader/remain")
	slot0._txtremain = gohelper.findChildText(slot0.viewGO, "root/propinfo/info/#go_goodsheader/remain/#txt_remain")
	slot0._goLimit = gohelper.findChild(slot0.viewGO, "root/propinfo/info/#go_goodsheader/#go_Limit")
	slot0._gounique = gohelper.findChild(slot0.viewGO, "root/propinfo/info/#go_goodsheader/go_unique")
	slot0._inputvalue = gohelper.findChildTextMeshInputField(slot0.viewGO, "root/#go_buy/valuebg/#input_value")
	slot0._btnclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/propinfo/#btn_click")
	slot0._gogoodsHavebg = gohelper.findChild(slot0.viewGO, "root/propinfo/group/#go_goodsHavebg")
	slot0._gobuy = gohelper.findChild(slot0.viewGO, "root/#go_buy")
	slot0._gotips = gohelper.findChild(slot0.viewGO, "root/#go_tips")
	slot0._txtlocktips = gohelper.findChildText(slot0.viewGO, "root/#go_tips/#txt_locktips")
	slot0._goinclude = gohelper.findChild(slot0.viewGO, "root/#go_include")
	slot0._txtsalePrice2 = gohelper.findChildText(slot0.viewGO, "root/#go_include/cost/#txt_salePrice")
	slot0._imagecosticon2 = gohelper.findChildImage(slot0.viewGO, "root/#go_include/cost/#simage_costicon")
	slot0._btnbuy2 = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_include/#btn_buy")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnmin:AddClickListener(slot0._btnminOnClick, slot0)
	slot0._btnsub:AddClickListener(slot0._btnsubOnClick, slot0)
	slot0._btnadd:AddClickListener(slot0._btnaddOnClick, slot0)
	slot0._btnmax:AddClickListener(slot0._btnmaxOnClick, slot0)
	slot0._btnbuy:AddClickListener(slot0._btnbuyOnClick, slot0)
	slot0._btnbuy2:AddClickListener(slot0._btnbuyOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btnCloseOnClick, slot0)
	slot0._inputvalue:AddOnEndEdit(slot0._onEndEdit, slot0)
	slot0._inputvalue:AddOnValueChanged(slot0._onValueChanged, slot0)
	slot0._btnclick:AddClickListener(slot0._btnclickOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnmin:RemoveClickListener()
	slot0._btnsub:RemoveClickListener()
	slot0._btnadd:RemoveClickListener()
	slot0._btnmax:RemoveClickListener()
	slot0._btnbuy:RemoveClickListener()
	slot0._btnbuy2:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
	slot0._inputvalue:RemoveOnEndEdit()
	slot0._inputvalue:RemoveOnValueChanged()
	slot0._btnclick:RemoveClickListener()
end

function slot0._btnclickOnClick(slot0)
	MaterialTipController.instance:showMaterialInfo(slot0._itemType, slot0._itemId)
end

function slot0._btnminOnClick(slot0)
	slot0._buyCount = 1

	slot0:_refreshBuyCount()
	slot0:_refreshGoods(slot0.goodsConfig)
end

function slot0._btnsubOnClick(slot0)
	if slot0._buyCount <= 1 then
		return
	else
		slot0._buyCount = slot0._buyCount - 1

		slot0:_refreshBuyCount()
		slot0:_refreshGoods(slot0.goodsConfig)
	end
end

function slot0._btnaddOnClick(slot0)
	if slot0._maxBuyCount < slot0._buyCount + 1 then
		slot0:_buyCountAddToast()

		return
	else
		slot0._buyCount = slot0._buyCount + 1

		slot0:_refreshBuyCount()
		slot0:_refreshGoods(slot0.goodsConfig)
	end
end

function slot0._btnmaxOnClick(slot0)
	slot0._buyCount = math.max(slot0._maxBuyCount, 1)

	if slot0._maxBuyCount < slot0._buyCount then
		slot0:_buyCountAddToast()
	end

	slot0:_refreshBuyCount()
	slot0:_refreshGoods(slot0.goodsConfig)
end

function slot0._btnCloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._onEndEdit(slot0, slot1)
	if not tonumber(slot1) or not math.floor(slot2) or slot2 <= 0 then
		slot2 = 1

		GameFacade.showToast(ToastEnum.VersionActivityNormalStoreNoGoods)
	end

	if slot0._maxBuyCount < slot2 then
		slot0:_buyCountAddToast()
	end

	slot0._buyCount = math.max(math.min(slot2, slot0._maxBuyCount), 1)

	slot0:_refreshBuyCount()
	slot0:_refreshGoods(slot0.goodsConfig)
end

function slot0._onValueChanged(slot0, slot1)
end

function slot0._btnbuyOnClick(slot0)
	if RoomConfig.instance:getBuildingSkinCoByItemId(slot0._itemId) and not slot0:_isHasBuiding(slot1) then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomBuldingStoreBuy, MsgBoxEnum.BoxType.Yes_No, slot0._tryBuyGoods, nil, , slot0, nil, )

		return
	end

	slot2 = false

	if slot0._itemType == MaterialEnum.MaterialType.Hero then
		slot2 = CharacterModel.instance:isHeroFullDuplicateCount(slot0._itemId)
	end

	if slot2 then
		slot4 = GameUtil.splitString2(HeroConfig.instance:getHeroCO(slot0._itemId).duplicateItem2, true)

		MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.HeroFullDuplicateCount, MsgBoxEnum.BoxType.Yes_No, slot0._tryBuyGoods, nil, , slot0, nil, , ItemConfig.instance:getItemConfig(slot4[1][1], slot4[1][2]).name)
	else
		slot0:_tryBuyGoods()
	end
end

function slot0._isHasBuiding(slot0, slot1)
	if RoomModel.instance:getBuildingInfoList() then
		for slot6, slot7 in ipairs(slot2) do
			if slot1.buildingId == slot7.buildingId then
				return true
			end
		end
	end
end

function slot0._tryBuyGoods(slot0)
	if slot0._costType == MaterialEnum.MaterialType.Currency and slot0._costId == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
		if CurrencyController.instance:checkFreeDiamondEnough(slot0._mo:getCost(slot0._buyCount), CurrencyEnum.PayDiamondExchangeSource.Store, nil, slot0._buyGoods, slot0, slot0.closeThis, slot0) then
			slot0:_buyGoods()
		end
	elseif slot0._maxBuyCount < slot0._buyCount then
		slot0:_buyCountAddToast()
	elseif slot0._buyCount > 0 then
		slot0:_buyGoods()
	end
end

function slot0._buyGoods(slot0)
	StoreController.instance:buyGoods(slot0._mo, slot0._buyCount, slot0._buyCallback, slot0)
end

function slot0._buyCallback(slot0, slot1, slot2, slot3)
	if slot2 == 0 then
		slot0:closeThis()
	end
end

function slot0._editableInitView(slot0)
	slot0._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	slot0._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	slot0._buyCount = 1
	slot0._maxBuyCount = 1

	gohelper.addUIClickAudio(slot0._btnbuy.gameObject, AudioEnum.UI.Store_Good_Click)

	slot0._goincludeContent = gohelper.findChild(slot0._goinclude, "#scroll_product/viewport/content")
	slot0._contentHorizontal = slot0._goincludeContent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	slot0._iconItemList = {}
end

function slot0._refreshBuyCount(slot0)
	if slot0._mo:getCost(slot0._buyCount) == 0 then
		slot0._txtsalePrice.text = luaLang("store_free")
	else
		slot0._txtsalePrice.text = tostring(slot1)
	end

	slot0._txtsalePrice2.text = slot0._txtsalePrice.text

	slot0._inputvalue:SetText(tostring(slot0._buyCount))

	if slot0._mo:canAffordQuantity() == -1 or slot0._buyCount <= slot2 then
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtsalePrice, "#393939")
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtsalePrice2, "#393939")
	else
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtsalePrice, "#bf2e11")
		SLFramework.UGUI.GuiHelper.SetColor(slot0._txtsalePrice2, "#bf2e11")
	end

	slot0._txtoriginalCost.text = ""
end

function slot0.ShowLockTips(slot0)
	if StoreConfig.instance:getGoodsConfig(slot0._mo.goodsId).needEpisodeId == StoreEnum.Need4RDEpisodeId then
		slot0._txtlocktips.text = string.format("%s%s", luaLang("dungeon_unlock_4RD"), luaLang("dungeon_unlock"))
	else
		slot2 = slot0._mo.lvlimitchapter
		slot3 = slot0._mo.lvlimitepisode
		slot4 = "dungeon_unlock_episode"

		if slot0._mo.isHardChapter then
			slot4 = "dungeon_unlock_episode_hard"
		end

		slot0._txtlocktips.text = string.format(luaLang(slot4), string.format("%s-%s", slot2, slot3))
	end
end

function slot0._refreshUI(slot0)
	slot0.goodsConfig = StoreConfig.instance:getGoodsConfig(slot0._mo.goodsId)
	slot1 = string.splitToNumber(slot0.goodsConfig.product, "#")
	slot0._txtgoodsNameCn.text = ItemModel.instance:getItemConfig(slot1[1], slot1[2]).name

	gohelper.setActive(slot0._txtgoodsDesc.gameObject, true)
	gohelper.setActive(slot0._txtgoodsUseDesc.gameObject, true)
	gohelper.setActive(slot0._gobuy, slot0:_isStoreItemUnlock())
	gohelper.setActive(slot0._gotips, not slot0:_isStoreItemUnlock())

	if not slot0:_isStoreItemUnlock() then
		slot0:ShowLockTips()
	end

	if StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(slot0._mo.goodsId) then
		gohelper.setActive(slot0._gobuy, false)
		gohelper.setActive(slot0._gotips, true)

		slot0._txtlocktips.text = string.format(luaLang("weekwalk_layer_unlock"), slot0._mo.limitWeekWalkLayer)
	end

	slot0:_refreshGoods(slot0.goodsConfig)

	slot4 = false

	if slot0._itemType == MaterialEnum.MaterialType.Hero then
		slot0._txtgoodsDesc.text = ItemModel.instance:getItemConfig(slot1[1], slot1[2]).desc2
	else
		slot0._txtgoodsDesc.text = ItemModel.instance:getItemConfig(slot1[1], slot1[2]).desc
	end

	slot0._txtgoodsUseDesc.text = ItemModel.instance:getItemConfig(slot1[1], slot1[2]).useDesc

	if string.nilorempty(slot0.goodsConfig.cost) then
		slot0._costId = nil
		slot0._costType = nil

		gohelper.setActive(slot0._imagecosticon.gameObject, false)
		gohelper.setActive(slot0._imagecosticon2.gameObject, false)
	else
		slot4 = #string.split(slot5, "|") > 1
		slot8 = string.split(slot6[slot0._mo.buyCount + 1] or slot6[#slot6], "#")
		slot0._costType = tonumber(slot8[1])
		slot0._costId = tonumber(slot8[2])
		slot9, slot10 = ItemModel.instance:getItemConfigAndIcon(slot0._costType, slot0._costId)
		slot12 = string.format("%s_1", slot9.icon)

		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagecosticon, slot12)
		UISpriteSetMgr.instance:setCurrencyItemSprite(slot0._imagecosticon2, slot12)
		gohelper.setActive(slot0._imagecosticon.gameObject, true)
		slot0.viewContainer:setCurrencyType(slot0._costId)
	end

	slot7 = slot0.goodsConfig.maxBuyCount - slot0._mo.buyCount

	if slot4 then
		slot0._txtremain.text = luaLang("store_multi_one")

		gohelper.setActive(slot0._goremain, true)
		gohelper.setActive(slot0._txtremain.gameObject, true)
	elseif string.nilorempty(StoreConfig.instance:getRemain(slot0.goodsConfig, slot7, slot0._mo.offlineTime)) then
		gohelper.setActive(slot0._goremain, false)
		gohelper.setActive(slot0._txtremain.gameObject, false)
		recthelper.setHeight(slot0._trsgoodsDesc, recthelper.getHeight(slot0._trsinfo))
	else
		gohelper.setActive(slot0._goremain, true)
		gohelper.setActive(slot0._txtremain.gameObject, true)

		slot0._txtremain.text = slot8
	end

	slot0._buyCount = 1

	slot0:_refreshBuyCount()
	slot0:_refreshInclude()
	slot0:_refreshGoUnique()
	slot0:_refreshLimitTag()
end

function slot0._refreshGoUnique(slot0)
	gohelper.setActive(slot0._gounique, false)
end

function slot0._refreshInclude(slot0)
	if not slot0:_isStoreItemUnlock() then
		return
	end

	if not (slot0._itemSubType == ItemEnum.SubType.SpecifiedGift) then
		return
	end

	slot2 = nil

	gohelper.setActive(slot0._gobuy, false)
	gohelper.setActive(slot0._goinclude, true)
	gohelper.setActive(slot0._txtgoodsDesc.gameObject, false)
	gohelper.setActive(slot0._txtgoodsUseDesc.gameObject, true)

	slot3 = 0

	if slot1 then
		slot4, slot5 = ItemModel.instance:getItemConfigAndIcon(slot0._itemType, slot0._itemId, true)
		slot6 = GameUtil.splitString2(slot4.effect, true)
		slot3 = #slot6

		for slot10, slot11 in ipairs(slot6) do
			slot13 = slot11[1]

			if slot0._iconItemList[slot10] == nil then
				if slot13 == MaterialEnum.MaterialType.Equip then
					slot12 = IconMgr.instance:getCommonEquipIcon(slot0._goincludeContent)

					slot12:setMOValue(slot13, slot11[2], slot11[3], nil, true)
					slot12:hideLv(true)
					slot12:customClick(function ()
						MaterialTipController.instance:showMaterialInfo(uv0, uv1)
					end)

					slot2 = slot13
				else
					IconMgr.instance:getCommonItemIcon(slot0._goincludeContent):setMOValue(slot13, slot14, slot15, nil, true)

					slot2 = slot13
				end

				table.insert(slot0._iconItemList, slot12)
			end
		end
	end

	if slot2 == MaterialEnum.MaterialType.Equip then
		slot0._contentHorizontal.spacing = 6.62
		slot0._contentHorizontal.padding.left = -2
		slot0._contentHorizontal.padding.top = 10
	end

	for slot7 = slot3 + 1, #slot0._iconItemList do
		gohelper.setActive(slot0._iconItemList[slot7].go, false)
	end
end

function slot0._refreshGoods(slot0, slot1)
	slot3 = string.split(slot1.product, "#")
	slot0._itemType = tonumber(slot3[1])
	slot0._itemId = tonumber(slot3[2])
	slot0._itemQuantity = tonumber(slot3[3])

	gohelper.setActive(slot0._goitem, true)

	slot0._txtitemcount.text = string.format("%s%s", luaLang("multiple"), GameUtil.numberDisplay(slot0._itemQuantity * slot0._buyCount))
	slot4, slot5 = ItemModel.instance:getItemConfigAndIcon(slot0._itemType, slot0._itemId, true)
	slot0._itemSubType = slot4.subType
	slot6 = true

	if tonumber(slot0._itemType) == MaterialEnum.MaterialType.Equip then
		slot5 = ResUrl.getEquipSuit(slot4.icon)
		slot6 = false
	end

	slot0._simageicon:LoadImage(slot5, slot6 and function ()
		uv0._simageicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
	end or nil)
	gohelper.setActive(slot0._gogoodsHavebg, true)

	slot0._txtgoodsHave.text = string.format("%s", GameUtil.numberDisplay(ItemModel.instance:getItemQuantity(slot0._itemType, slot0._itemId)))
end

function slot0._refreshLimitTag(slot0)
	slot1 = string.splitToNumber(slot0.goodsConfig.product, "#")
	slot4 = false

	if slot1[1] == MaterialEnum.MaterialType.Equip then
		slot4 = EquipModel.instance:isLimit(slot1[2])
	end

	gohelper.setActive(slot0._goLimit, slot4)
end

function slot0._buyCountAddToast(slot0)
	slot1, slot2 = slot0._mo:getBuyMaxQuantity()

	if CommonConfig.instance:getConstNum(ConstEnum.StoreMaxBuyCount) <= slot0._buyCount + 1 or slot2 == StoreEnum.LimitType.BuyLimit or slot2 == StoreEnum.LimitType.Default then
		GameFacade.showToast(ToastEnum.StoreMaxBuyCount)
	elseif slot2 == StoreEnum.LimitType.Currency then
		if slot0._costType and slot0._costId then
			GameFacade.showToast(ToastEnum.DiamondBuy, ItemModel.instance:getItemConfig(slot0._costType, slot0._costId).name)
		end
	elseif slot2 == StoreEnum.LimitType.CurrencyChanged then
		GameFacade.showToast(ToastEnum.CurrencyChanged)
	end
end

function slot0._refreshMaxBuyCount(slot0)
	slot0._maxBuyCount = slot0._mo:getBuyMaxQuantity()

	if CommonConfig.instance:getConstNum(ConstEnum.StoreMaxBuyCount) < slot0._maxBuyCount or slot0._maxBuyCount == -1 then
		slot0._maxBuyCount = slot1
	end
end

function slot0.onOpen(slot0)
	slot0._mo = slot0.viewParam

	slot0:_refreshMaxBuyCount()
	slot0:_refreshUI()
	StoreController.instance:statOpenGoods(slot0._mo.belongStoreId, StoreConfig.instance:getGoodsConfig(slot0._mo.goodsId))
end

function slot0._isStoreItemUnlock(slot0)
	slot1 = StoreConfig.instance:getGoodsConfig(slot0._mo.goodsId).needEpisodeId

	if StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(slot0._mo.goodsId) then
		return false
	end

	if not slot1 or slot1 == 0 then
		return true
	end

	if slot1 == StoreEnum.Need4RDEpisodeId then
		return false
	end

	return DungeonModel.instance:hasPassLevelAndStory(slot1)
end

function slot0.onClose(slot0)
	StoreController.instance:statCloseGoods(StoreConfig.instance:getGoodsConfig(slot0._mo.goodsId))
end

function slot0.onUpdateParam(slot0)
	slot0._mo = slot0.viewParam

	slot0:_refreshMaxBuyCount()
	slot0:_refreshUI()
end

function slot0.onDestroyView(slot0)
	slot0._simageleftbg:UnLoadImage()
	slot0._simagerightbg:UnLoadImage()
end

return slot0
