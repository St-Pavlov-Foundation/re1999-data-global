module("modules.logic.survival.view.map.SurvivalMapSearchView", package.seeall)

local var_0_0 = class("SurvivalMapSearchView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._anim = gohelper.findChildAnim(arg_1_0.viewGO, "")
	arg_1_0._btngetall = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_getall")
	arg_1_0._btnclose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "root/#btn_close")
	arg_1_0._itemRoot = gohelper.findChild(arg_1_0.viewGO, "root/scroll_collection/Viewport/Content")
	arg_1_0._btnbag = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_bag")
	arg_1_0._gobagfull = gohelper.findChild(arg_1_0.viewGO, "#btn_bag/#go_overweight")
	arg_1_0._goinfoview = gohelper.findChild(arg_1_0.viewGO, "root/#go_infoview")
	arg_1_0._goheavy = gohelper.findChild(arg_1_0.viewGO, "root/go_heavy")
	arg_1_0._gosort = gohelper.findChild(arg_1_0.viewGO, "root/#go_sort")
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btngetall:AddClickListener(arg_2_0._onClickGetAll, arg_2_0)
	arg_2_0._btnclose:AddClickListener(arg_2_0._closeEvent, arg_2_0)
	arg_2_0._btnbag:AddClickListener(arg_2_0._onClickBag, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnSearchEventUpdate, arg_2_0._onUpdateMos, arg_2_0)
	SurvivalController.instance:registerCallback(SurvivalEvent.OnMapBagUpdate, arg_2_0._refreshBagFull, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btngetall:RemoveClickListener()
	arg_3_0._btnclose:RemoveClickListener()
	arg_3_0._btnbag:RemoveClickListener()
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnSearchEventUpdate, arg_3_0._onUpdateMos, arg_3_0)
	SurvivalController.instance:unregisterCallback(SurvivalEvent.OnMapBagUpdate, arg_3_0._refreshBagFull, arg_3_0)
end

function var_0_0.onOpen(arg_4_0)
	MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._goheavy, SurvivalWeightPart)

	local var_4_0 = MonoHelper.addNoUpdateLuaComOnceToGo(arg_4_0._gosort, SurvivalSortAndFilterPart)
	local var_4_1 = {
		{
			desc = luaLang("survival_sort_worth"),
			type = SurvivalEnum.ItemSortType.Worth
		},
		{
			desc = luaLang("survival_sort_mass"),
			type = SurvivalEnum.ItemSortType.Mass
		},
		{
			desc = luaLang("survival_sort_type"),
			type = SurvivalEnum.ItemSortType.Type
		}
	}
	local var_4_2 = {
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

	arg_4_0._curSort = var_4_1[1]
	arg_4_0._isDec = true
	arg_4_0._filterList = {}

	var_4_0:setOptions(var_4_1, var_4_2, arg_4_0._curSort, arg_4_0._isDec)
	var_4_0:setOptionChangeCallback(arg_4_0._onSortChange, arg_4_0)

	local var_4_3 = arg_4_0.viewContainer._viewSetting.otherRes.infoView
	local var_4_4 = arg_4_0:getResInst(var_4_3, arg_4_0._goinfoview)

	arg_4_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_4_4, SurvivalBagInfoPart)

	arg_4_0._infoPanel:updateMo()

	local var_4_5 = arg_4_0.viewContainer._viewSetting.otherRes.itemRes

	arg_4_0._item = arg_4_0:getResInst(var_4_5, arg_4_0.viewGO)

	gohelper.setActive(arg_4_0._item, false)

	arg_4_0._allItemMos = arg_4_0.viewParam.preItems or arg_4_0.viewParam.itemMos
	arg_4_0.isShowLoading = arg_4_0.viewParam.isFirst

	arg_4_0:_onSortChange(arg_4_0._curSort, arg_4_0._isDec, arg_4_0._filterList)
	arg_4_0:_refreshBagFull()

	if not arg_4_0.isShowLoading then
		return
	end

	AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_sougua_2)

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._allItems) do
		if not iter_4_1._mo:isEmpty() then
			iter_4_1:showLoading(true)
		end
	end

	UIBlockMgrExtend.setNeedCircleMv(false)
	TaskDispatcher.runDelay(arg_4_0._delayHideLoading, arg_4_0, 1)
	UIBlockHelper.instance:startBlock("SurvivalMapSearchView_PlayLoading", 1)
end

function var_0_0._delayHideLoading(arg_5_0)
	UIBlockMgrExtend.setNeedCircleMv(true)

	for iter_5_0, iter_5_1 in ipairs(arg_5_0._allItems) do
		iter_5_1:showLoading(false)
		iter_5_1:setIsSelect(iter_5_1._mo.uid and iter_5_1._mo.uid == arg_5_0._curSelectUid)
	end

	arg_5_0.isShowLoading = false

	if arg_5_0.viewParam.preItems then
		UIBlockHelper.instance:startBlock("SurvivalMapSearchView_changeItems", 1)

		local var_5_0 = arg_5_0.viewParam.itemMos

		for iter_5_2, iter_5_3 in pairs(arg_5_0._showList) do
			if not iter_5_3:isEmpty() and var_5_0[iter_5_3.uid] and iter_5_3.id ~= var_5_0[iter_5_3.uid].id then
				arg_5_0._items[iter_5_3.uid]:playComposeAnim()
			end
		end

		TaskDispatcher.runDelay(arg_5_0._delayShowItemMos, arg_5_0, 1)
	else
		arg_5_0:_refreshLeftPart()
	end
end

function var_0_0._delayShowItemMos(arg_6_0)
	arg_6_0:_onUpdateMos(arg_6_0.viewParam.itemMos, true)
	arg_6_0:_refreshLeftPart()
end

function var_0_0._onSortChange(arg_7_0, arg_7_1, arg_7_2, arg_7_3)
	arg_7_0._curSort = arg_7_1
	arg_7_0._isDec = arg_7_2
	arg_7_0._filterList = arg_7_3

	local var_7_0 = {}

	for iter_7_0, iter_7_1 in pairs(arg_7_0._allItemMos) do
		if SurvivalBagSortHelper.filterItemMo(arg_7_3, iter_7_1) then
			table.insert(var_7_0, iter_7_1)
		end
	end

	SurvivalBagSortHelper.sortItems(var_7_0, arg_7_1.type, arg_7_2)

	arg_7_0._showList = var_7_0

	arg_7_0:_refreshBag()
end

function var_0_0._onUpdateMos(arg_8_0, arg_8_1, arg_8_2)
	local var_8_0 = not arg_8_2 and not SurvivalMapModel.instance.isSearchRemove
	local var_8_1 = false

	SurvivalMapModel.instance.isSearchRemove = false
	arg_8_0._allItemMos = arg_8_1

	for iter_8_0, iter_8_1 in pairs(arg_8_0._showList) do
		if not iter_8_1:isEmpty() then
			if arg_8_1[iter_8_1.uid] then
				if iter_8_1.id ~= arg_8_1[iter_8_1.uid].id and iter_8_1.id > 0 and arg_8_1[iter_8_1.uid].id > 0 then
					iter_8_1:init(arg_8_1[iter_8_1.uid])
				elseif iter_8_1.count ~= arg_8_1[iter_8_1.uid].count then
					iter_8_1:init(arg_8_1[iter_8_1.uid])

					if var_8_0 then
						arg_8_0._items[iter_8_1.uid]:playSearch()
					end
				end
			else
				if iter_8_1.uid == arg_8_0._curSelectUid then
					arg_8_0._infoPanel:updateMo()
				end

				if var_8_0 then
					arg_8_0._items[iter_8_1.uid]:playSearch()
				end

				arg_8_0._items[iter_8_1.uid]:playCloseAnim()
				iter_8_1:ctor()

				var_8_1 = true
			end
		end
	end

	if var_8_0 or var_8_1 then
		if var_8_0 then
			AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_sougua_3)
			arg_8_0._anim:Play("searching", 0, 0)
		end

		UIBlockHelper.instance:startBlock("SurvivalMapSearchView.searching", 0.167)
		TaskDispatcher.runDelay(arg_8_0._onSearchAnim, arg_8_0, 0.167)
	else
		arg_8_0:_refreshBag()
		SurvivalController.instance:dispatchEvent(SurvivalEvent.SurvivalSearchAnimFinish)
	end
end

function var_0_0._onSearchAnim(arg_9_0)
	UIBlockHelper.instance:startBlock("SurvivalMapSearchView.searching", 0.5)
	TaskDispatcher.runDelay(arg_9_0._delayRefreshBag, arg_9_0, 0.5)
end

function var_0_0._delayRefreshBag(arg_10_0)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.SurvivalSearchAnimFinish)
	arg_10_0:_refreshBag()
end

function var_0_0._refreshBag(arg_11_0)
	SurvivalHelper.instance:makeArrFull(arg_11_0._showList, SurvivalBagItemMo.Empty, 4, 3)

	arg_11_0._items = {}
	arg_11_0._allItems = {}

	gohelper.CreateObjList(arg_11_0, arg_11_0._createItem, arg_11_0._showList, arg_11_0._itemRoot, arg_11_0._item, SurvivalBagItem)

	if arg_11_0._curSelectUid and (not arg_11_0._items[arg_11_0._curSelectUid] or arg_11_0._items[arg_11_0._curSelectUid] and arg_11_0._items[arg_11_0._curSelectUid]._mo:isEmpty()) then
		arg_11_0._curSelectUid = nil
	end

	if not arg_11_0._curSelectUid then
		for iter_11_0, iter_11_1 in ipairs(arg_11_0._showList) do
			if not iter_11_1:isEmpty() then
				arg_11_0._curSelectUid = iter_11_1.uid

				arg_11_0._items[arg_11_0._curSelectUid]:setIsSelect(true)

				break
			end
		end
	end

	arg_11_0:_refreshLeftPart()
end

function var_0_0._createItem(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if not arg_12_2:isEmpty() then
		arg_12_0._items[arg_12_2.uid] = arg_12_1
	end

	arg_12_0._allItems[arg_12_3] = arg_12_1

	arg_12_1:updateMo(arg_12_2)
	arg_12_1:setClickCallback(arg_12_0._onClickItem, arg_12_0)
	arg_12_1:setIsSelect(arg_12_2.uid and arg_12_2.uid == arg_12_0._curSelectUid)
end

function var_0_0._onClickItem(arg_13_0, arg_13_1)
	if arg_13_0._curSelectUid == arg_13_1._mo.uid then
		return
	end

	if arg_13_0._curSelectUid then
		arg_13_0._items[arg_13_0._curSelectUid]:setIsSelect(false)
	end

	arg_13_0._curSelectUid = arg_13_1._mo.uid

	arg_13_1:setIsSelect(true)
	arg_13_0:_refreshLeftPart()
end

function var_0_0._refreshLeftPart(arg_14_0)
	if arg_14_0.isShowLoading then
		return
	end

	if arg_14_0._curSelectUid then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_details)
		arg_14_0._infoPanel:updateMo(arg_14_0._items[arg_14_0._curSelectUid]._mo)
	else
		arg_14_0._infoPanel:updateMo()
	end
end

function var_0_0._onClickGetAll(arg_15_0)
	SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.OperSearch, "1#-1")
end

function var_0_0._closeEvent(arg_16_0)
	local var_16_0 = SurvivalMapModel.instance:getSceneMo()

	if not var_16_0.panel then
		arg_16_0:closeThis()

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalClosePanelRequest(var_16_0.panel.uid, arg_16_0._onRecvMsg, arg_16_0)
end

function var_0_0._onRecvMsg(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	if arg_17_2 == 0 then
		local var_17_0 = SurvivalMapModel.instance:getSceneMo()

		if var_17_0.panel and var_17_0.panel.type == SurvivalEnum.PanelType.Search then
			var_17_0.panel = nil
		end

		arg_17_0:closeThis()
	end
end

function var_0_0._onClickBag(arg_18_0)
	ViewMgr.instance:openView(ViewName.SurvivalMapBagView)
end

function var_0_0._refreshBagFull(arg_19_0)
	local var_19_0 = SurvivalMapHelper.instance:getBagMo()
	local var_19_1 = var_19_0.totalMass > var_19_0.maxWeightLimit + SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.AttrWeight)

	gohelper.setActive(arg_19_0._gobagfull, var_19_1)
end

function var_0_0.onClose(arg_20_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(arg_20_0._onSearchAnim, arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._delayRefreshBag, arg_20_0)
	TaskDispatcher.cancelTask(arg_20_0._delayShowItemMos, arg_20_0)
end

return var_0_0
