module("modules.logic.survival.view.shelter.ShelterCompositeMaterialView", package.seeall)

local var_0_0 = class("ShelterCompositeMaterialView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0.goPanel = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#go_LeftTips")
	arg_1_0.selectPanelCanvasGroup = gohelper.onceAddComponent(arg_1_0.goPanel, typeof(UnityEngine.CanvasGroup))
	arg_1_0.goScroll = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#go_LeftTips/scroll_collection")

	local var_1_0 = arg_1_0.viewContainer:getSetting().otherRes.itemRes

	arg_1_0.goItem = arg_1_0:getResInst(var_1_0, arg_1_0.viewGO)

	gohelper.setActive(arg_1_0.goItem, false)

	arg_1_0.btnClose = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "Panel/Left/#go_LeftTips/#btn_close")
	arg_1_0.gosort = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#go_LeftTips/#go_sort")
	arg_1_0.goInfoView = gohelper.findChild(arg_1_0.viewGO, "Panel/Left/#go_LeftTips/#go_infoview")
	arg_1_0.animator = arg_1_0.viewGO:GetComponent(gohelper.Type_Animator)
	arg_1_0.isPanelVisible = false

	gohelper.setActive(arg_1_0.goPanel, false)
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnMapBagUpdate, arg_2_0.onMapBagUpdate, arg_2_0)
	arg_2_0:addEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_2_0.onShelterBagUpdate, arg_2_0)
	arg_2_0:addClickCb(arg_2_0.btnClose, arg_2_0.onClickCloseBtn, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnMapBagUpdate, arg_3_0.onMapBagUpdate, arg_3_0)
	arg_3_0:removeEventCb(SurvivalController.instance, SurvivalEvent.OnShelterBagUpdate, arg_3_0.onShelterBagUpdate, arg_3_0)
	arg_3_0:removeClickCb(arg_3_0.btnClose)
end

function var_0_0.onMapBagUpdate(arg_4_0)
	arg_4_0:refreshView()
end

function var_0_0.onShelterBagUpdate(arg_5_0)
	arg_5_0:refreshView()
end

function var_0_0.onClickCloseBtn(arg_6_0)
	arg_6_0:closeMaterialView()
end

function var_0_0.closeMaterialView(arg_7_0)
	arg_7_0.isShow = false

	arg_7_0:refreshView()
end

function var_0_0.showMaterialView(arg_8_0, arg_8_1)
	arg_8_0.isShow = true
	arg_8_0.selectIndex = arg_8_1

	arg_8_0:refreshView()
end

function var_0_0.onItemClick(arg_9_0, arg_9_1)
	if arg_9_1._mo:isEmpty() then
		return
	end

	arg_9_0._preSelectUid = arg_9_1._mo.uid

	arg_9_0:refreshView()
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0.isShow = false
	arg_10_0._preSelectUid = nil
	arg_10_0.selectIndex = nil

	arg_10_0:refreshView()
end

function var_0_0.refreshView(arg_11_0)
	arg_11_0:setPanelVisible(arg_11_0.isShow)

	if not arg_11_0.isShow then
		return
	end

	arg_11_0:refreshFilter()
	arg_11_0:refreshList()
	arg_11_0:refreshInfo()
end

function var_0_0.setPanelVisible(arg_12_0, arg_12_1)
	if arg_12_0.isPanelVisible == arg_12_1 then
		return
	end

	arg_12_0.isPanelVisible = arg_12_1

	gohelper.setActive(arg_12_0.goPanel, true)

	if arg_12_1 then
		arg_12_0.animator:Play("panel_in")

		arg_12_0.selectPanelCanvasGroup.interactable = true
		arg_12_0.selectPanelCanvasGroup.blocksRaycasts = true
	else
		arg_12_0.animator:Play("panel_out")

		arg_12_0.selectPanelCanvasGroup.interactable = false
		arg_12_0.selectPanelCanvasGroup.blocksRaycasts = false

		gohelper.setActive(arg_12_0.goInfoView, false)
	end
end

function var_0_0.refreshInfo(arg_13_0)
	local var_13_0 = arg_13_0:getBag():getItemByUid(arg_13_0._preSelectUid)

	if not var_13_0 then
		gohelper.setActive(arg_13_0.goInfoView, false)

		return
	end

	gohelper.setActive(arg_13_0.goInfoView, true)

	if not arg_13_0._infoPanel then
		local var_13_1 = arg_13_0.viewContainer:getSetting().otherRes.infoView
		local var_13_2 = arg_13_0.viewContainer:getResInst(var_13_1, arg_13_0.goInfoView)

		arg_13_0._infoPanel = MonoHelper.addNoUpdateLuaComOnceToGo(var_13_2, SurvivalBagInfoPart)

		local var_13_3 = {
			[SurvivalEnum.ItemSource.Map] = SurvivalEnum.ItemSource.Composite,
			[SurvivalEnum.ItemSource.Shelter] = SurvivalEnum.ItemSource.Composite
		}

		arg_13_0._infoPanel:setChangeSource(var_13_3)
	end

	arg_13_0._infoPanel:updateMo(var_13_0)
end

function var_0_0.refreshList(arg_14_0)
	if not arg_14_0._simpleList then
		arg_14_0._simpleList = MonoHelper.addNoUpdateLuaComOnceToGo(arg_14_0.goScroll, SurvivalSimpleListPart)

		arg_14_0._simpleList:setCellUpdateCallBack(arg_14_0._createItem, arg_14_0, SurvivalBagItem, arg_14_0.goItem)
	end

	local var_14_0 = arg_14_0:getBag()
	local var_14_1 = {}
	local var_14_2

	for iter_14_0, iter_14_1 in ipairs(var_14_0.items) do
		if iter_14_1.co.type == SurvivalEnum.ItemType.Equip and not arg_14_0.viewContainer:isSelectItem(arg_14_0.selectIndex, iter_14_1) and SurvivalBagSortHelper.filterEquipMo(arg_14_0._filterList, iter_14_1) then
			table.insert(var_14_1, iter_14_1)

			if arg_14_0._preSelectUid == iter_14_1.uid then
				var_14_2 = iter_14_1.uid
			end
		end
	end

	SurvivalBagSortHelper.sortItems(var_14_1, arg_14_0._curSort.type, arg_14_0._isDec)
	SurvivalHelper.instance:makeArrFull(var_14_1, SurvivalBagItemMo.Empty, 5, 4)

	arg_14_0._preSelectUid = var_14_2

	arg_14_0._simpleList:setList(var_14_1)
end

function var_0_0._createItem(arg_15_0, arg_15_1, arg_15_2, arg_15_3)
	arg_15_1:updateMo(arg_15_2)
	arg_15_1:setClickCallback(arg_15_0.onItemClick, arg_15_0)

	if arg_15_2.uid == arg_15_0._preSelectUid and arg_15_0._preSelectUid then
		arg_15_1:setIsSelect(true)
	end
end

function var_0_0.getBag(arg_16_0)
	local var_16_0 = SurvivalShelterModel.instance:getWeekInfo()
	local var_16_1 = var_16_0.bag

	if var_16_0.inSurvival then
		var_16_1 = SurvivalMapModel.instance:getSceneMo().bag
	end

	return var_16_1
end

function var_0_0.refreshFilter(arg_17_0)
	if arg_17_0.filterComp then
		return
	end

	arg_17_0.filterComp = MonoHelper.addNoUpdateLuaComOnceToGo(arg_17_0.gosort, SurvivalSortAndFilterPart)

	local var_17_0 = {
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
	local var_17_1 = {}

	for iter_17_0, iter_17_1 in ipairs(lua_survival_equip_found.configList) do
		table.insert(var_17_1, {
			desc = iter_17_1.name,
			type = iter_17_1.id
		})
	end

	arg_17_0._curSort = var_17_0[1]
	arg_17_0._isDec = true
	arg_17_0._filterList = {}

	arg_17_0.filterComp:setOptions(var_17_0, var_17_1, arg_17_0._curSort, arg_17_0._isDec)
	arg_17_0.filterComp:setOptionChangeCallback(arg_17_0._onSortChange, arg_17_0)
end

function var_0_0._onSortChange(arg_18_0, arg_18_1, arg_18_2, arg_18_3)
	arg_18_0._curSort = arg_18_1
	arg_18_0._isDec = arg_18_2
	arg_18_0._filterList = arg_18_3

	arg_18_0:refreshView()
end

function var_0_0.onClose(arg_19_0)
	return
end

return var_0_0
