module("modules.logic.survival.view.map.SurvivalShopView", package.seeall)

local var_0_0 = class("SurvivalShopView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Right/#btn_close")
	arg_1_0._goinfoview = gohelper.findChild(arg_1_0.viewGO, "Center/#go_info")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "Center/#go_empty")
	arg_1_0._goleftscroll = gohelper.findChild(arg_1_0.viewGO, "Left/#go_list/scroll_collection")
	arg_1_0._goleftitem = gohelper.findChild(arg_1_0.viewGO, "Left/#go_list/scroll_collection/Viewport/Content/go_bagitem")
	arg_1_0._goleftempty = gohelper.findChild(arg_1_0.viewGO, "Left/#go_list/#go_empty")
	arg_1_0._goheavy = gohelper.findChild(arg_1_0.viewGO, "Left/#go_heavy")
	arg_1_0._gosort = gohelper.findChild(arg_1_0.viewGO, "Left/#go_sort")
	arg_1_0._txttag1 = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/#go_tag/tag1/#txt_tag1")
	arg_1_0._txttag2 = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/#go_tag/tag2/#txt_tag2")
	arg_1_0._txttag3 = gohelper.findChildTextMesh(arg_1_0.viewGO, "Left/#go_tag/tag3/#txt_tag3")
	arg_1_0._btntag1 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_tag/tag1")
	arg_1_0._btntag2 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_tag/tag2")
	arg_1_0._btntag3 = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Left/#go_tag/tag3")
	arg_1_0._gorightscroll = gohelper.findChild(arg_1_0.viewGO, "Right/#go_list/scroll_collection")
	arg_1_0._gorightitem = gohelper.findChild(arg_1_0.viewGO, "Right/#go_list/scroll_collection/Viewport/Content/go_bagitem")
	arg_1_0._gorightempty = gohelper.findChild(arg_1_0.viewGO, "Right/#go_list/#go_empty")
	arg_1_0._gorightTag = gohelper.findChild(arg_1_0.viewGO, "Right/#go_tag")
	arg_1_0._golefttaganim = gohelper.findChild(arg_1_0.viewGO, "Left/#go_tag"):GetComponent(typeof(UnityEngine.Animation))
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0.onClickModalMask, arg_2_0)
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
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btntag1:RemoveClickListener()
	arg_3_0._btntag2:RemoveClickListener()
	arg_3_0._btntag3:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapBagUpdate, arg_3_0._refreshBagByServer, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnShelterBagUpdate, arg_3_0._refreshBagByServer, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnShopItemUpdate, arg_3_0._onShopItemUpdate, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnClickTipsBtn, arg_3_0._onClickInfo, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_mail_open)

	local var_4_0 = arg_4_0.viewContainer._viewSetting.otherRes.infoView
	local var_4_1 = arg_4_0:getResInst(var_4_0, arg_4_0._goinfoview)

	arg_4_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_1, SurvivalBagInfoPart)

	arg_4_0._infoPanel:setCloseShow(true, arg_4_0._onClickInfo, arg_4_0)
	arg_4_0._infoPanel:updateMo()

	local var_4_2 = {
		[SurvivalEnum.ItemSource.Shelter] = SurvivalEnum.ItemSource.ShopBag,
		[SurvivalEnum.ItemSource.Map] = SurvivalEnum.ItemSource.ShopBag
	}

	arg_4_0._infoPanel:setChangeSource(var_4_2)
	gohelper.setActive(arg_4_0._goempty, true)

	arg_4_0._shopMo, arg_4_0._panelUid = SurvivalMapHelper.instance:getShopPanel()
	arg_4_0._bagMo = SurvivalMapHelper.instance:getBagMo()
	arg_4_0._curSelectUid = nil
	arg_4_0._isSelectLeft = false

	gohelper.setActive(arg_4_0._gorightTag, not arg_4_0._panelUid)

	arg_4_0._simpleLeftList = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._goleftscroll, SurvivalSimpleListPart)

	arg_4_0._simpleLeftList:setCellUpdateCallBack(arg_4_0._createLeftItem, arg_4_0, nil, arg_4_0._goleftitem)

	arg_4_0._simpleRightList = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._gorightscroll, SurvivalSimpleListPart)

	arg_4_0._simpleRightList:setCellUpdateCallBack(arg_4_0._createRightItem, arg_4_0, nil, arg_4_0._gorightitem)
	arg_4_0:initWeightAndSort()
	arg_4_0:_refreshBag()
	arg_4_0:_refreshShopItems()
end

function var_0_0.initWeightAndSort(arg_5_0)
	if arg_5_0._panelUid then
		MonoHelper.addNoUpdateLuaComOnceToGo(arg_5_0._goheavy, SurvivalWeightPart)
	else
		gohelper.setActive(arg_5_0._goheavy, false)
	end

	local var_5_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_5_0._gosort, SurvivalSortAndFilterPart)
	local var_5_1 = {
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
	local var_5_2 = {
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

	arg_5_0._curSort = var_5_1[1]
	arg_5_0._isDec = true
	arg_5_0._filterList = {}

	var_5_0:setOptions(var_5_1, var_5_2, arg_5_0._curSort, arg_5_0._isDec)
	var_5_0:setOptionChangeCallback(arg_5_0._onSortChange, arg_5_0)
end

function var_0_0._onClickInfo(arg_6_0)
	gohelper.setActive(arg_6_0._goempty, true)
	arg_6_0._infoPanel:updateMo()

	arg_6_0._curSelectUid = nil

	arg_6_0:updateItemSelect()
end

function var_0_0.onClickModalMask(arg_7_0)
	if arg_7_0._panelUid then
		SurvivalWeekRpc.instance:sendSurvivalClosePanelRequest(arg_7_0._panelUid, arg_7_0.closeThis, arg_7_0)
	else
		arg_7_0:closeThis()
	end
end

function var_0_0._onSortChange(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	arg_8_0._curSort = arg_8_1
	arg_8_0._isDec = arg_8_2
	arg_8_0._filterList = arg_8_3

	arg_8_0:_refreshBag()
end

function var_0_0._refreshBagByServer(arg_9_0, arg_9_1)
	for iter_9_0 = 1, 3 do
		if (tonumber(arg_9_0["_txttag" .. iter_9_0].text) or 0) < arg_9_0._bagMo:getCurrencyNum(iter_9_0) then
			arg_9_0._golefttaganim:Play()

			break
		end
	end

	local var_9_0 = {}

	for iter_9_1, iter_9_2 in ipairs(arg_9_1.delItemUids) do
		var_9_0[iter_9_2] = true
	end

	local var_9_1 = false

	if next(var_9_0) then
		for iter_9_3 in pairs(arg_9_0._simpleLeftList:getAllGos()) do
			local var_9_2 = gohelper.findChild(iter_9_3, "inst")
			local var_9_3 = MonoHelper.getLuaComFromGo(var_9_2, SurvivalBagItem)

			if var_9_3 and not var_9_3._mo:isEmpty() and var_9_0[var_9_3._mo.uid] then
				var_9_3:playCloseAnim()

				var_9_1 = true
			end
		end
	end

	if not var_9_1 then
		arg_9_0:_refreshBag()
	else
		UIBlockHelper.instance:startBlock("SurvivalShopView._refreshBag", 0.2)
		TaskDispatcher.runDelay(arg_9_0._refreshBag, arg_9_0, 0.2)
	end
end

function var_0_0._refreshBag(arg_10_0)
	for iter_10_0 = 1, 3 do
		arg_10_0["_txttag" .. iter_10_0].text = arg_10_0._bagMo:getCurrencyNum(iter_10_0)
	end

	local var_10_0 = {}

	for iter_10_1, iter_10_2 in ipairs(arg_10_0._bagMo.items) do
		if iter_10_2.sellPrice > 0 and SurvivalBagSortHelper.filterItemMo(arg_10_0._filterList, iter_10_2) then
			table.insert(var_10_0, iter_10_2)
		end
	end

	SurvivalBagSortHelper.sortItems(var_10_0, arg_10_0._curSort.type, arg_10_0._isDec)
	SurvivalHelper.instance:makeArrFull(var_10_0, SurvivalBagItemMo.Empty, 3, 5)
	arg_10_0._simpleLeftList:setList(var_10_0)

	arg_10_0._showItems = var_10_0

	gohelper.setActive(arg_10_0._goleftscroll, #var_10_0 > 0)
	gohelper.setActive(arg_10_0._goleftempty, #var_10_0 == 0)
end

function var_0_0._refreshShopItems(arg_11_0)
	arg_11_0._simpleRightList:setList(arg_11_0._shopMo.items)
	gohelper.setActive(arg_11_0._gorightscroll, #arg_11_0._shopMo.items > 0)
	gohelper.setActive(arg_11_0._gorightempty, #arg_11_0._shopMo.items == 0)
end

function var_0_0._onShopItemUpdate(arg_12_0, arg_12_1, arg_12_2)
	local var_12_0

	for iter_12_0, iter_12_1 in pairs(arg_12_0._simpleRightList:getAllGos()) do
		if iter_12_1 + 1 == arg_12_1 then
			var_12_0 = iter_12_0

			break
		end
	end

	if not var_12_0 then
		arg_12_0._simpleRightList:setList(arg_12_0._shopMo.items)
	else
		local var_12_1 = MonoHelper.getLuaComFromGo(gohelper.findChild(var_12_0, "inst"), SurvivalBagItem)

		if var_12_1 then
			if arg_12_2:isEmpty() then
				UIBlockHelper.instance:startBlock("SurvivalShopView.onShopUpdate", 1)
				var_12_1:playCloseAnim()
				var_12_1:playSearch()
				TaskDispatcher.runDelay(arg_12_0._refreshShopItems, arg_12_0, 1)
			else
				arg_12_0._simpleRightList:setList(arg_12_0._shopMo.items)
			end
		end
	end
end

function var_0_0._createLeftItem(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	local var_13_0 = arg_13_0.viewContainer._viewSetting.otherRes.itemRes
	local var_13_1 = gohelper.findChild(arg_13_1, "inst") or arg_13_0:getResInst(var_13_0, arg_13_1, "inst")
	local var_13_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_1, SurvivalBagItem)

	var_13_2:updateMo(arg_13_2)
	var_13_2:setClickCallback(arg_13_0._onLeftItemClick, arg_13_0)
	var_13_2:setIsSelect(arg_13_0._curSelectUid and arg_13_2.uid == arg_13_0._curSelectUid and arg_13_0._isSelectLeft)
end

function var_0_0._createRightItem(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	local var_14_0 = arg_14_0.viewContainer._viewSetting.otherRes.itemRes
	local var_14_1 = gohelper.findChild(arg_14_1, "inst") or arg_14_0:getResInst(var_14_0, arg_14_1, "inst")
	local var_14_2 = MonoHelper.addNoUpdateLuaComOnceToGo(var_14_1, SurvivalBagItem)

	var_14_2:updateMo(arg_14_2)
	var_14_2:setClickCallback(arg_14_0._onRightItemClick, arg_14_0)
	var_14_2:setIsSelect(arg_14_0._curSelectUid and arg_14_2.uid == arg_14_0._curSelectUid and not arg_14_0._isSelectLeft)
end

function var_0_0._onLeftItemClick(arg_15_0, arg_15_1)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_checkpoint_resources_Click)
	arg_15_0._infoPanel:updateMo(arg_15_1._mo)
	gohelper.setActive(arg_15_0._goempty, false)

	arg_15_0._curSelectUid = arg_15_1._mo.uid
	arg_15_0._isSelectLeft = true

	arg_15_0:updateItemSelect()
end

function var_0_0._onRightItemClick(arg_16_0, arg_16_1)
	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_checkpoint_resources_Click)
	arg_16_0._infoPanel:updateMo(arg_16_1._mo)
	gohelper.setActive(arg_16_0._goempty, false)

	arg_16_0._curSelectUid = arg_16_1._mo.uid
	arg_16_0._isSelectLeft = false

	arg_16_0:updateItemSelect()
end

function var_0_0.updateItemSelect(arg_17_0)
	for iter_17_0 in pairs(arg_17_0._simpleLeftList:getAllGos()) do
		local var_17_0 = gohelper.findChild(iter_17_0, "inst")
		local var_17_1 = MonoHelper.getLuaComFromGo(var_17_0, SurvivalBagItem)

		if var_17_1 and not var_17_1._mo:isEmpty() then
			var_17_1:setIsSelect(arg_17_0._isSelectLeft and arg_17_0._curSelectUid == var_17_1._mo.uid)
		end
	end

	for iter_17_1 in pairs(arg_17_0._simpleRightList:getAllGos()) do
		local var_17_2 = gohelper.findChild(iter_17_1, "inst")
		local var_17_3 = MonoHelper.getLuaComFromGo(var_17_2, SurvivalBagItem)

		if var_17_3 and not var_17_3._mo:isEmpty() then
			var_17_3:setIsSelect(not arg_17_0._isSelectLeft and arg_17_0._curSelectUid == var_17_3._mo.uid)
		end
	end
end

function var_0_0._openCurrencyTips(arg_18_0, arg_18_1)
	local var_18_0 = arg_18_1.btn.transform
	local var_18_1 = var_18_0.lossyScale
	local var_18_2 = var_18_0.position
	local var_18_3 = recthelper.getWidth(var_18_0)
	local var_18_4 = recthelper.getHeight(var_18_0)

	var_18_2.x = var_18_2.x - var_18_3 / 2 * var_18_1.x
	var_18_2.y = var_18_2.y - var_18_4 / 2 * var_18_1.y

	ViewMgr.instance:openView(ViewName.SurvivalCurrencyTipView, {
		arrow = "BR",
		id = arg_18_1.id,
		pos = var_18_2
	})
end

function var_0_0.onClose(arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._refreshBag, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._refreshShopItems, arg_19_0)
end

return var_0_0
