module("modules.logic.survival.view.shop.SurvivalShopView", package.seeall)

local var_0_0 = class("SurvivalShopView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_close")
	arg_1_0._btnenter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_enter")
	arg_1_0._goinfoview = gohelper.findChild(arg_1_0.viewGO, "Center/#go_info")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "Center/#go_empty")
	arg_1_0._txttitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "Center/Title/#txt_title")
	arg_1_0._txtLeftTitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/#txt_bag")
	arg_1_0._goleftscroll = gohelper.findChild(arg_1_0.viewGO, "Left/#go_list/scroll_collection")
	arg_1_0._goleftitem = gohelper.findChild(arg_1_0.viewGO, "Left/#go_list/scroll_collection/Viewport/Content/go_bagitem")
	arg_1_0._goleftempty = gohelper.findChild(arg_1_0.viewGO, "Left/#go_list/#go_empty")
	arg_1_0._goheavy = gohelper.findChild(arg_1_0.viewGO, "Left/#go_heavy")
	arg_1_0._gosort = gohelper.findChild(arg_1_0.viewGO, "Left/#go_sort")
	arg_1_0._gotag1 = gohelper.findChild(arg_1_0.viewGO, "Left/#go_tag/tag1")
	arg_1_0._gotag2 = gohelper.findChild(arg_1_0.viewGO, "Left/#go_tag/tag2")
	arg_1_0._gotag3 = gohelper.findChild(arg_1_0.viewGO, "Left/#go_tag/tag3")
	arg_1_0._txttag1 = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/#go_tag/tag1/#txt_tag1")
	arg_1_0._txttag2 = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/#go_tag/tag2/#txt_tag2")
	arg_1_0._txttag3 = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/#go_tag/tag3/#txt_tag3")
	arg_1_0._btntag1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_tag/tag1")
	arg_1_0._btntag2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_tag/tag2")
	arg_1_0._btntag3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_tag/tag3")
	arg_1_0._gorightscroll_normal = gohelper.findChild(arg_1_0.viewGO, "Right/#go_list/scroll_collection")
	arg_1_0._gorightitem_normal = gohelper.findChild(arg_1_0.viewGO, "Right/#go_list/scroll_collection/Viewport/Content/go_bagitem")
	arg_1_0._gorightempty = gohelper.findChild(arg_1_0.viewGO, "Right/#go_list/#go_empty")
	arg_1_0._gorightTag = gohelper.findChild(arg_1_0.viewGO, "Right/#go_tag")
	arg_1_0._golefttaganim = gohelper.findChild(arg_1_0.viewGO, "Left/#go_tag"):GetComponent(typeof(UnityEngine.Animation))
	arg_1_0._txtRightTitle = gohelper.findChildTextMesh(arg_1_0.viewGO, "Right/#txt_shop")
	arg_1_0._gorightscroll_preexploreshop = gohelper.findChild(arg_1_0.viewGO, "Right/#go_list/scroll_collection_preexploreshop")
	arg_1_0._gorightitem_preexploreshop = gohelper.findChild(arg_1_0.viewGO, "Right/#go_list/scroll_collection_preexploreshop/Viewport/Content/go_bagitem")
	arg_1_0.ShopTabScroll = gohelper.findChild(arg_1_0.viewGO, "Right/tab")
	arg_1_0.ShopTab = gohelper.findChild(arg_1_0.viewGO, "Right/tab/Viewport/Content/ShopTab")

	arg_1_0:createTabListComp()
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.onClickModalMask, arg_2_0)
	arg_2_0._btnenter:AddClickListener(arg_2_0.onClickBtnEnter, arg_2_0)
	arg_2_0._btntag1:AddClickListener(arg_2_0._openCurrencyTips, arg_2_0, {
		id = 1,
		btn = arg_2_0._btntag1
	})
	arg_2_0._btntag2:AddClickListener(arg_2_0._openCurrencyTips, arg_2_0, {
		id = 2,
		btn = arg_2_0._btntag2
	})
	arg_2_0._btntag3:AddClickListener(arg_2_0._openCurrencyTips, arg_2_0, {
		id = 3,
		btn = arg_2_0._btntag3
	})
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapBagUpdate, arg_2_0._refreshBagByServer, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnShelterBagUpdate, arg_2_0._refreshBagByServer, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnShopItemUpdate, arg_2_0._onShopItemUpdate, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnClickTipsBtn, arg_2_0._onClickInfo, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnReceiveSurvivalShopBuyReply, arg_2_0.onReceiveSurvivalShopBuyReply, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnenter:RemoveClickListener()
	arg_3_0._btntag1:RemoveClickListener()
	arg_3_0._btntag2:RemoveClickListener()
	arg_3_0._btntag3:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapBagUpdate, arg_3_0._refreshBagByServer, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnShelterBagUpdate, arg_3_0._refreshBagByServer, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnShopItemUpdate, arg_3_0._onShopItemUpdate, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnClickTipsBtn, arg_3_0._onClickInfo, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnReceiveSurvivalShopBuyReply, arg_3_0.onReceiveSurvivalShopBuyReply, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	arg_4_0.viewParam = arg_4_0.viewParam or {}

	if arg_4_0.viewParam.shopMo then
		arg_4_0._shopMo = arg_4_0.viewParam.shopMo
	else
		arg_4_0._shopMo, arg_4_0._panelUid = SurvivalMapHelper.instance:getShopPanel()
	end

	arg_4_0.mapId = arg_4_0.viewParam.mapId

	arg_4_0:refreshTitle()
	gohelper.setActive(arg_4_0._btnenter, arg_4_0._shopMo:isPreExploreShop())

	arg_4_0.isBuyItem = nil

	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_mail_open)

	local var_4_0 = arg_4_0.viewContainer._viewSetting.otherRes.infoView
	local var_4_1 = arg_4_0:getResInst(var_4_0, arg_4_0._goinfoview)

	arg_4_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_1, SurvivalBagInfoPart)

	arg_4_0._infoPanel:setShopData(arg_4_0._shopMo.id, arg_4_0._shopMo.shopType)
	arg_4_0._infoPanel:setCloseShow(true, arg_4_0._onClickInfo, arg_4_0)
	arg_4_0._infoPanel:updateMo()

	local var_4_2 = {
		[SurvivalEnum.ItemSource.Shelter] = SurvivalEnum.ItemSource.ShopBag,
		[SurvivalEnum.ItemSource.Map] = SurvivalEnum.ItemSource.ShopBag
	}

	arg_4_0._infoPanel:setChangeSource(var_4_2)
	gohelper.setActive(arg_4_0._goempty, true)

	if arg_4_0._shopMo:isPreExploreShop() then
		arg_4_0._bagMo = SurvivalShelterModel.instance:getWeekInfo():getBag(SurvivalEnum.ItemSource.Map)
	else
		arg_4_0._bagMo = SurvivalMapHelper.instance:getBagMo()
	end

	arg_4_0._curSelectUid = nil
	arg_4_0._isSelectLeft = false

	gohelper.setActive(arg_4_0._gorightTag, not arg_4_0:isShelterShop() and not arg_4_0._panelUid)

	arg_4_0._simpleLeftList = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._goleftscroll, SurvivalSimpleListPart)

	arg_4_0._simpleLeftList:setCellUpdateCallBack(arg_4_0._createLeftItem, arg_4_0, nil, arg_4_0._goleftitem)
	gohelper.setActive(arg_4_0._gorightscroll_preexploreshop, arg_4_0:isShowPrice())
	gohelper.setActive(arg_4_0._gorightscroll_normal, not arg_4_0:isShowPrice())

	arg_4_0._gorightscroll = arg_4_0:isShowPrice() and arg_4_0._gorightscroll_preexploreshop or arg_4_0._gorightscroll_normal
	arg_4_0._gorightitem = not arg_4_0:isShowPrice() and arg_4_0._gorightitem_preexploreshop or arg_4_0._gorightitem_normal
	arg_4_0._simpleRightList = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._gorightscroll, SurvivalSimpleListPart)

	arg_4_0._simpleRightList:setCellUpdateCallBack(arg_4_0._createRightItem, arg_4_0, nil, arg_4_0._gorightitem)
	arg_4_0:initWeightAndSort()
	arg_4_0:_refreshBag()
	arg_4_0:refreshTabListComp()
	arg_4_0.tabListComp:setSelect(1)
end

function var_0_0.isShowPrice(arg_5_0)
	return arg_5_0:isShelterShop() or arg_5_0:isSurvivalShop()
end

function var_0_0.isShelterShop(arg_6_0)
	return not SurvivalShelterModel.instance:getWeekInfo().inSurvival
end

function var_0_0.isSurvivalShop(arg_7_0)
	return SurvivalShelterModel.instance:getWeekInfo().inSurvival
end

function var_0_0.initWeightAndSort(arg_8_0)
	if arg_8_0._panelUid or arg_8_0._shopMo:isPreExploreShop() then
		MonoHelper.addNoUpdateLuaComOnceToGo(arg_8_0._goheavy, SurvivalWeightPart)
	else
		gohelper.setActive(arg_8_0._goheavy, false)
	end

	local var_8_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_8_0._gosort, SurvivalSortAndFilterPart)
	local var_8_1 = {
		{
			desc = luaLang("survival_sort_time"),
			type = SurvivalEnum.ItemSortType.Time
		},
		{
			desc = luaLang("survival_sort_mass"),
			type = SurvivalEnum.ItemSortType.Mass
		},
		{
			desc = luaLang("survival_sort_worth"),
			type = SurvivalEnum.ItemSortType.Worth
		},
		{
			desc = luaLang("survival_sort_type"),
			type = SurvivalEnum.ItemSortType.Type
		}
	}
	local var_8_2 = {
		{
			desc = luaLang("survival_filter_material"),
			type = SurvivalEnum.ItemFilterType.Material
		},
		{
			desc = luaLang("survival_filter_equip"),
			type = SurvivalEnum.ItemFilterType.Equip
		},
		{
			desc = luaLang("survival_filter_consume"),
			type = SurvivalEnum.ItemFilterType.Consume
		}
	}

	arg_8_0._curSort = var_8_1[1]
	arg_8_0._isDec = true
	arg_8_0._filterList = {}

	var_8_0:setOptions(var_8_1, var_8_2, arg_8_0._curSort, arg_8_0._isDec)
	var_8_0:setOptionChangeCallback(arg_8_0._onSortChange, arg_8_0)
end

function var_0_0.onReceiveSurvivalShopBuyReply(arg_9_0)
	arg_9_0.isBuyItem = true
end

function var_0_0._onClickInfo(arg_10_0)
	arg_10_0:cancelSelect()
end

function var_0_0.cancelSelect(arg_11_0)
	if arg_11_0._curSelectUid then
		gohelper.setActive(arg_11_0._goempty, true)
		arg_11_0._infoPanel:updateMo()

		arg_11_0._curSelectUid = nil

		arg_11_0:updateItemSelect()
	end
end

function var_0_0.onClickModalMask(arg_12_0)
	if arg_12_0._panelUid then
		SurvivalWeekRpc.instance:sendSurvivalClosePanelRequest(arg_12_0._panelUid, arg_12_0.closeThis, arg_12_0)
	else
		arg_12_0:closeThis()
	end
end

function var_0_0.onClickBtnEnter(arg_13_0)
	if arg_13_0.isBuyItem then
		SurvivalController.instance:enterSurvivalMap(SurvivalMapModel.instance:getInitGroup())
	else
		GameFacade.showOptionMessageBox(MessageBoxIdDefine.Sign_SurvivalShopView_Buy, MsgBoxEnum.BoxType.Yes_No, MsgBoxEnum.optionType.Daily, arg_13_0.onYesClick, nil, nil, arg_13_0)
	end
end

function var_0_0.onYesClick(arg_14_0)
	SurvivalController.instance:enterSurvivalMap(SurvivalMapModel.instance:getInitGroup())
end

function var_0_0._onSortChange(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_0._curSort = arg_15_1
	arg_15_0._isDec = arg_15_2
	arg_15_0._filterList = arg_15_3

	arg_15_0:_refreshBag()
end

function var_0_0._refreshBagByServer(arg_16_0, arg_16_1)
	for iter_16_0 = 1, #arg_16_0.currencyShow do
		if tabletool.indexOf(arg_16_0.currencyShow, iter_16_0) and (tonumber(arg_16_0["_txttag" .. iter_16_0].text) or 0) < arg_16_0._bagMo:getCurrencyNum(iter_16_0) then
			arg_16_0._golefttaganim:Play()

			break
		end
	end

	local var_16_0 = {}

	for iter_16_1, iter_16_2 in ipairs(arg_16_1.delItemUids) do
		var_16_0[iter_16_2] = true
	end

	local var_16_1 = false

	if next(var_16_0) then
		for iter_16_3 in pairs(arg_16_0._simpleLeftList:getAllGos()) do
			local var_16_2 = gohelper.findChild(iter_16_3, "inst")
			local var_16_3 = MonoHelper.getLuaComFromGo(var_16_2, SurvivalBagItem)

			if var_16_3 and not var_16_3._mo:isEmpty() and var_16_0[var_16_3._mo.uid] then
				var_16_3:playCloseAnim()

				var_16_1 = true
			end
		end
	end

	if not var_16_1 then
		arg_16_0:_refreshBag()
	else
		UIBlockHelper.instance:startBlock("SurvivalShopView._refreshBag", 0.2)
		TaskDispatcher.runDelay(arg_16_0._refreshBag, arg_16_0, 0.2)
	end
end

function var_0_0.refreshTitle(arg_17_0)
	arg_17_0._txttitle.text = SurvivalConfig.instance:getShopName(arg_17_0._shopMo.id)

	if arg_17_0._shopMo:isPreExploreShop() then
		arg_17_0._txtLeftTitle.text = luaLang("SurvivalShopView_1")
	elseif arg_17_0._shopMo.shopType == SurvivalEnum.ShopType.GeneralShop then
		arg_17_0._txtLeftTitle.text = luaLang("SurvivalShopView_1")
	else
		arg_17_0._txtLeftTitle.text = luaLang("p_survivalcommititemview_txt_bag")
	end
end

function var_0_0.refreshRightTitle(arg_18_0)
	if arg_18_0.haveTab then
		arg_18_0._txtRightTitle.text = arg_18_0.datas[arg_18_0.tabListComp:getSelect()].cfg.name
	else
		arg_18_0._txtRightTitle.text = luaLang("p_survivalshopview_txt_shop")
	end
end

function var_0_0._refreshBag(arg_19_0)
	arg_19_0.currencyShow = {
		1
	}

	for iter_19_0 = 1, 3 do
		if tabletool.indexOf(arg_19_0.currencyShow, iter_19_0) then
			gohelper.setActive(arg_19_0["_gotag" .. iter_19_0], true)

			arg_19_0["_txttag" .. iter_19_0].text = arg_19_0._bagMo:getCurrencyNum(iter_19_0)
		else
			gohelper.setActive(arg_19_0["_gotag" .. iter_19_0], false)
		end
	end

	local var_19_0 = {}

	for iter_19_1, iter_19_2 in ipairs(arg_19_0._bagMo.items) do
		if arg_19_0:isShowItem(iter_19_2) and SurvivalBagSortHelper.filterItemMo(arg_19_0._filterList, iter_19_2) then
			table.insert(var_19_0, iter_19_2)
		end
	end

	if arg_19_0:isSurvivalShop() then
		SurvivalBagSortHelper.sortItems(var_19_0, arg_19_0._curSort.type, arg_19_0._isDec, {
			isCheckNPCItem = true
		})
	else
		SurvivalBagSortHelper.sortItems(var_19_0, arg_19_0._curSort.type, arg_19_0._isDec)
	end

	SurvivalHelper.instance:makeArrFull(var_19_0, SurvivalBagItemMo.Empty, 3, 5)
	arg_19_0._simpleLeftList:setList(var_19_0)

	arg_19_0._showItems = var_19_0

	gohelper.setActive(arg_19_0._goleftscroll, #var_19_0 > 0)
	gohelper.setActive(arg_19_0._goleftempty, #var_19_0 == 0)
end

function var_0_0.isShowItem(arg_20_0, arg_20_1)
	if not arg_20_1 or not arg_20_1.co then
		return false
	end

	if arg_20_1.sellPrice > 0 then
		return true
	end

	if arg_20_0._shopMo:isPreExploreShop() and arg_20_1.co.type == SurvivalEnum.ItemType.Material and arg_20_1.co.subType == SurvivalEnum.ItemSubType.Material_VehicleItem then
		return true
	end

	return false
end

function var_0_0.getShopItems(arg_21_0)
	if arg_21_0.haveTab then
		local var_21_0 = arg_21_0.tabListComp:getSelect()
		local var_21_1 = arg_21_0.datas[var_21_0].cfg.id

		return arg_21_0._shopMo:getItemsByTabId(var_21_1)
	else
		return arg_21_0._shopMo.items
	end
end

function var_0_0._refreshShopItems(arg_22_0)
	local var_22_0 = arg_22_0:getShopItems()

	arg_22_0._simpleRightList:setList(var_22_0)
	gohelper.setActive(arg_22_0._gorightscroll, #var_22_0 > 0)
	gohelper.setActive(arg_22_0._gorightempty, #var_22_0 == 0)
end

function var_0_0._onShopItemUpdate(arg_23_0, arg_23_1, arg_23_2, arg_23_3)
	for iter_23_0, iter_23_1 in pairs(arg_23_0._simpleRightList:getAllGos()) do
		local var_23_0 = gohelper.findChild(iter_23_0, "inst")

		if var_23_0 then
			local var_23_1 = MonoHelper.getLuaComFromGo(var_23_0, SurvivalBagItem)

			if var_23_1._preUid == arg_23_3 then
				if arg_23_2:isEmpty() then
					UIBlockHelper.instance:startBlock("SurvivalShopView.onShopUpdate", 1)
					var_23_1:playCloseAnim()
					var_23_1:playSearch()
					TaskDispatcher.runDelay(arg_23_0._refreshShopItems, arg_23_0, 1)

					break
				end

				local var_23_2 = arg_23_0:getShopItems()

				arg_23_0._simpleRightList:setList(var_23_2)

				break
			end
		end
	end
end

function var_0_0._createLeftItem(arg_24_0, arg_24_1, arg_24_2, arg_24_3)
	local var_24_0 = arg_24_0.viewContainer._viewSetting.otherRes.itemRes
	local var_24_1 = gohelper.findChild(arg_24_1, "inst") or arg_24_0:getResInst(var_24_0, arg_24_1, "inst")
	local var_24_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_24_1, SurvivalBagItem)

	var_24_2:updateMo(arg_24_2)
	var_24_2:setClickCallback(arg_24_0._onLeftItemClick, arg_24_0)
	var_24_2:setIsSelect(arg_24_0._curSelectUid and arg_24_2.uid == arg_24_0._curSelectUid and arg_24_0._isSelectLeft)

	local var_24_3 = arg_24_0:isSurvivalShop() and arg_24_2:isNPCRecommendItem()

	var_24_2:setItemSubType_npc(var_24_3)

	local var_24_4 = arg_24_0:isShelterShop() and arg_24_2:isDisasterRecommendItem(arg_24_0.mapId)

	var_24_2:setRecommend(var_24_4)
end

function var_0_0._createRightItem(arg_25_0, arg_25_1, arg_25_2, arg_25_3)
	local var_25_0 = arg_25_0.viewContainer._viewSetting.otherRes.itemRes
	local var_25_1 = gohelper.findChild(arg_25_1, "inst") or arg_25_0:getResInst(var_25_0, arg_25_1, "inst")
	local var_25_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_25_1, SurvivalBagItem)

	var_25_2:updateMo(arg_25_2)
	var_25_2:setClickCallback(arg_25_0._onRightItemClick, arg_25_0)
	var_25_2:setIsSelect(arg_25_0._curSelectUid and arg_25_2.uid == arg_25_0._curSelectUid and not arg_25_0._isSelectLeft)

	if arg_25_0:isShowPrice() then
		var_25_2:setShopStyle({
			isShow = not arg_25_2:isEmpty(),
			price = arg_25_2:getBuyPrice()
		})
	end

	local var_25_3 = arg_25_0:isShelterShop() and arg_25_2:isDisasterRecommendItem(arg_25_0.mapId)

	var_25_2:setRecommend(var_25_3)
end

function var_0_0._onLeftItemClick(arg_26_0, arg_26_1)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_checkpoint_resources_Click)
	arg_26_0._infoPanel:updateMo(arg_26_1._mo, {
		mapId = arg_26_0.mapId
	})
	gohelper.setActive(arg_26_0._goempty, false)

	arg_26_0._curSelectUid = arg_26_1._mo.uid
	arg_26_0._isSelectLeft = true

	arg_26_0:updateItemSelect()
end

function var_0_0._onRightItemClick(arg_27_0, arg_27_1)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_checkpoint_resources_Click)
	arg_27_0._infoPanel:updateMo(arg_27_1._mo, {
		mapId = arg_27_0.mapId
	})
	gohelper.setActive(arg_27_0._goempty, false)

	arg_27_0._curSelectUid = arg_27_1._mo.uid
	arg_27_0._isSelectLeft = false

	arg_27_0:updateItemSelect()
end

function var_0_0.updateItemSelect(arg_28_0)
	for iter_28_0 in pairs(arg_28_0._simpleLeftList:getAllGos()) do
		local var_28_0 = gohelper.findChild(iter_28_0, "inst")
		local var_28_1 = MonoHelper.getLuaComFromGo(var_28_0, SurvivalBagItem)

		if var_28_1 and not var_28_1._mo:isEmpty() then
			var_28_1:setIsSelect(arg_28_0._isSelectLeft and arg_28_0._curSelectUid == var_28_1._mo.uid)
		end
	end

	for iter_28_1 in pairs(arg_28_0._simpleRightList:getAllGos()) do
		local var_28_2 = gohelper.findChild(iter_28_1, "inst")
		local var_28_3 = MonoHelper.getLuaComFromGo(var_28_2, SurvivalBagItem)

		if var_28_3 and not var_28_3._mo:isEmpty() then
			var_28_3:setIsSelect(not arg_28_0._isSelectLeft and arg_28_0._curSelectUid == var_28_3._mo.uid)
		end
	end
end

function var_0_0._openCurrencyTips(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_1.btn.transform
	local var_29_1 = var_29_0.lossyScale
	local var_29_2 = var_29_0.position
	local var_29_3 = recthelper.getWidth(var_29_0)
	local var_29_4 = recthelper.getHeight(var_29_0)

	var_29_2.x = var_29_2.x - var_29_3 / 2 * var_29_1.x
	var_29_2.y = var_29_2.y - var_29_4 / 2 * var_29_1.y

	ViewMgr.instance:openView(ViewName.SurvivalCurrencyTipView, {
		arrow = "BR",
		id = arg_29_1.id,
		pos = var_29_2
	})
end

function var_0_0.createTabListComp(arg_30_0)
	local var_30_0 = SurvivalSimpleListParam.New()

	var_30_0.cellClass = SurvivalShopTab
	var_30_0.lineCount = 1
	var_30_0.cellWidth = 104
	var_30_0.cellHeight = 84
	var_30_0.cellSpaceH = 0
	var_30_0.cellSpaceV = 10
	arg_30_0.tabListComp = SurvivalHelper.instance:createLuaSimpleListComp(arg_30_0.ShopTabScroll, var_30_0, arg_30_0.ShopTab, arg_30_0.viewContainer)

	arg_30_0.tabListComp:setSelectCallBack(arg_30_0.onSelectCallBack, arg_30_0)
end

function var_0_0.refreshTabListComp(arg_31_0)
	local var_31_0 = SurvivalConfig.instance:getShopTabConfigs()

	arg_31_0.datas = {}
	arg_31_0.haveTab = arg_31_0._shopMo:haveTab()

	if arg_31_0.haveTab then
		for iter_31_0, iter_31_1 in ipairs(var_31_0) do
			local var_31_1 = var_31_0[iter_31_0].id

			if #arg_31_0._shopMo:getItemsByTabId(var_31_1) > 0 then
				local var_31_2 = {
					cfg = var_31_0[iter_31_0],
					onClickFunc = arg_31_0.onClickTab,
					context = arg_31_0
				}

				table.insert(arg_31_0.datas, var_31_2)
			end
		end
	end

	arg_31_0.tabListComp:setList(arg_31_0.datas)
end

function var_0_0.onClickTab(arg_32_0, arg_32_1)
	arg_32_0.tabListComp:setSelect(arg_32_1.index)
end

function var_0_0.onSelectCallBack(arg_33_0, arg_33_1)
	if not arg_33_0._isSelectLeft then
		arg_33_0:cancelSelect()
	end

	arg_33_0:_refreshShopItems()
	arg_33_0:refreshRightTitle()
end

function var_0_0.onClose(arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._refreshBag, arg_34_0)
	TaskDispatcher.cancelTask(arg_34_0._refreshShopItems, arg_34_0)
end

return var_0_0
