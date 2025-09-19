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

	arg_4_0._allItemMos = arg_4_0.viewParam.itemMos
	arg_4_0.isShowLoading = arg_4_0.viewParam.isFirst

	arg_4_0:_onSortChange(arg_4_0._curSort, arg_4_0._isDec, arg_4_0._filterList)
	arg_4_0:_refreshBagFull()

	if not arg_4_0.viewParam.isFirst then
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

	arg_5_0:_refreshLeftPart()
end

function var_0_0._onSortChange(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0._curSort = arg_6_1
	arg_6_0._isDec = arg_6_2
	arg_6_0._filterList = arg_6_3

	local var_6_0 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0._allItemMos) do
		if SurvivalBagSortHelper.filterItemMo(arg_6_3, iter_6_1) then
			table.insert(var_6_0, iter_6_1)
		end
	end

	SurvivalBagSortHelper.sortItems(var_6_0, arg_6_1.type, arg_6_2)

	arg_6_0._showList = var_6_0

	arg_6_0:_refreshBag()
end

function var_0_0._onUpdateMos(arg_7_0, arg_7_1)
	local var_7_0 = not SurvivalMapModel.instance.isSearchRemove
	local var_7_1 = false

	SurvivalMapModel.instance.isSearchRemove = false
	arg_7_0._allItemMos = arg_7_1

	for iter_7_0, iter_7_1 in pairs(arg_7_0._showList) do
		if not iter_7_1:isEmpty() then
			if arg_7_1[iter_7_1.uid] then
				if iter_7_1.count ~= arg_7_1[iter_7_1.uid].count then
					iter_7_1:init(arg_7_1[iter_7_1.uid])

					if var_7_0 then
						arg_7_0._items[iter_7_1.uid]:playSearch()
					end
				end
			else
				if iter_7_1.uid == arg_7_0._curSelectUid then
					arg_7_0._infoPanel:updateMo()
				end

				if var_7_0 then
					arg_7_0._items[iter_7_1.uid]:playSearch()
				end

				arg_7_0._items[iter_7_1.uid]:playCloseAnim()
				iter_7_1:ctor()

				var_7_1 = true
			end
		end
	end

	if var_7_0 or var_7_1 then
		if var_7_0 then
			AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_sougua_3)
			arg_7_0._anim:Play("searching", 0, 0)
		end

		UIBlockHelper.instance:startBlock("SurvivalMapSearchView.searching", 0.167)
		TaskDispatcher.runDelay(arg_7_0._onSearchAnim, arg_7_0, 0.167)
	else
		arg_7_0:_refreshBag()
		SurvivalController.instance:dispatchEvent(SurvivalEvent.SurvivalSearchAnimFinish)
	end
end

function var_0_0._onSearchAnim(arg_8_0)
	UIBlockHelper.instance:startBlock("SurvivalMapSearchView.searching", 0.5)
	TaskDispatcher.runDelay(arg_8_0._delayRefreshBag, arg_8_0, 0.5)
end

function var_0_0._delayRefreshBag(arg_9_0)
	SurvivalController.instance:dispatchEvent(SurvivalEvent.SurvivalSearchAnimFinish)
	arg_9_0:_refreshBag()
end

function var_0_0._refreshBag(arg_10_0)
	SurvivalHelper.instance:makeArrFull(arg_10_0._showList, SurvivalBagItemMo.Empty, 4, 3)

	arg_10_0._items = {}
	arg_10_0._allItems = {}

	gohelper.CreateObjList(arg_10_0, arg_10_0._createItem, arg_10_0._showList, arg_10_0._itemRoot, arg_10_0._item, SurvivalBagItem)

	if arg_10_0._curSelectUid and (not arg_10_0._items[arg_10_0._curSelectUid] or arg_10_0._items[arg_10_0._curSelectUid] and arg_10_0._items[arg_10_0._curSelectUid]._mo:isEmpty()) then
		arg_10_0._curSelectUid = nil
	end

	if not arg_10_0._curSelectUid then
		for iter_10_0, iter_10_1 in ipairs(arg_10_0._showList) do
			if not iter_10_1:isEmpty() then
				arg_10_0._curSelectUid = iter_10_1.uid

				arg_10_0._items[arg_10_0._curSelectUid]:setIsSelect(true)

				break
			end
		end
	end

	arg_10_0:_refreshLeftPart()
end

function var_0_0._createItem(arg_11_0, arg_11_1, arg_11_2, arg_11_3)
	if not arg_11_2:isEmpty() then
		arg_11_0._items[arg_11_2.uid] = arg_11_1
	end

	arg_11_0._allItems[arg_11_3] = arg_11_1

	arg_11_1:updateMo(arg_11_2)
	arg_11_1:setClickCallback(arg_11_0._onClickItem, arg_11_0)
	arg_11_1:setIsSelect(arg_11_2.uid and arg_11_2.uid == arg_11_0._curSelectUid)
end

function var_0_0._onClickItem(arg_12_0, arg_12_1)
	if arg_12_0._curSelectUid == arg_12_1._mo.uid then
		return
	end

	if arg_12_0._curSelectUid then
		arg_12_0._items[arg_12_0._curSelectUid]:setIsSelect(false)
	end

	arg_12_0._curSelectUid = arg_12_1._mo.uid

	arg_12_1:setIsSelect(true)
	arg_12_0:_refreshLeftPart()
end

function var_0_0._refreshLeftPart(arg_13_0)
	if arg_13_0.isShowLoading then
		return
	end

	if arg_13_0._curSelectUid then
		AudioMgr.instance:trigger(AudioEnum2_8.Survival.play_ui_fuleyuan_tansuo_details)
		arg_13_0._infoPanel:updateMo(arg_13_0._items[arg_13_0._curSelectUid]._mo)
	else
		arg_13_0._infoPanel:updateMo()
	end
end

function var_0_0._onClickGetAll(arg_14_0)
	SurvivalInteriorRpc.instance:sendSurvivalSceneOperation(SurvivalEnum.OperType.OperSearch, "1#-1")
end

function var_0_0._closeEvent(arg_15_0)
	local var_15_0 = SurvivalMapModel.instance:getSceneMo()

	if not var_15_0.panel then
		arg_15_0:closeThis()

		return
	end

	SurvivalWeekRpc.instance:sendSurvivalClosePanelRequest(var_15_0.panel.uid, arg_15_0._onRecvMsg, arg_15_0)
end

function var_0_0._onRecvMsg(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	if arg_16_2 == 0 then
		local var_16_0 = SurvivalMapModel.instance:getSceneMo()

		if var_16_0.panel and var_16_0.panel.type == SurvivalEnum.PanelType.Search then
			var_16_0.panel = nil
		end

		arg_16_0:closeThis()
	end
end

function var_0_0._onClickBag(arg_17_0)
	ViewMgr.instance:openView(ViewName.SurvivalMapBagView)
end

function var_0_0._refreshBagFull(arg_18_0)
	local var_18_0 = SurvivalMapModel.instance:getSceneMo()
	local var_18_1 = var_18_0.bag.totalMass > var_18_0.bag.maxWeightLimit + SurvivalShelterModel.instance:getWeekInfo():getAttr(SurvivalEnum.AttrType.AttrWeight)

	gohelper.setActive(arg_18_0._gobagfull, var_18_1)
end

function var_0_0.onClose(arg_19_0)
	UIBlockMgrExtend.setNeedCircleMv(true)
	TaskDispatcher.cancelTask(arg_19_0._onSearchAnim, arg_19_0)
	TaskDispatcher.cancelTask(arg_19_0._delayRefreshBag, arg_19_0)
end

return var_0_0
