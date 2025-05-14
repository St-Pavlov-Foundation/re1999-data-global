module("modules.logic.room.view.manufacture.RoomCritterListView", package.seeall)

local var_0_0 = class("RoomCritterListView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._gomood = gohelper.findChild(arg_1_0.viewGO, "#go_critter/sort/#btn_mood")
	arg_1_0._gorare = gohelper.findChild(arg_1_0.viewGO, "#go_critter/sort/#btn_rare")
	arg_1_0._btnfilter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_critter/sort/#btn_filter")
	arg_1_0._gonotfilter = gohelper.findChild(arg_1_0.viewGO, "#go_critter/sort/#btn_filter/#go_notfilter")
	arg_1_0._gofilter = gohelper.findChild(arg_1_0.viewGO, "#go_critter/sort/#btn_filter/#go_filter")
	arg_1_0._scrollrect = gohelper.findChildScrollRect(arg_1_0.viewGO, "#go_critter/#scroll_critter")
	arg_1_0._btncloseCritter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#go_critter/#btn_closeCritter")
	arg_1_0._goempty = gohelper.findChild(arg_1_0.viewGO, "#go_critter/#go_empty")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnfilter:AddClickListener(arg_2_0._btnfilterOnClick, arg_2_0)
	arg_2_0._btncloseCritter:AddClickListener(arg_2_0._btncloseCritterOnClick, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedCritterSlotItem, arg_2_0._onChangeSelectedCritterSlotItem, arg_2_0)
	arg_2_0:addEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedTransportPath, arg_2_0._onChangeSelectedTransportPath, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterChangeFilterType, arg_2_0.onCritterFilterTypeChange, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterListUpdate, arg_2_0.onCritterListUpdate, arg_2_0)
	arg_2_0:addEventCb(CritterController.instance, CritterEvent.CritterListResetScrollPos, arg_2_0.resetScrollPos, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnfilter:RemoveClickListener()
	arg_3_0._btncloseCritter:RemoveClickListener()

	if arg_3_0.sortMoodItem then
		arg_3_0.sortMoodItem.btnsort:RemoveClickListener()
	end

	if arg_3_0.sortRareItem then
		arg_3_0.sortRareItem.btnsort:RemoveClickListener()
	end

	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedCritterSlotItem, arg_3_0._onChangeSelectedCritterSlotItem, arg_3_0)
	arg_3_0:removeEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedTransportPath, arg_3_0._onChangeSelectedTransportPath, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterChangeFilterType, arg_3_0.onCritterFilterTypeChange, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterListUpdate, arg_3_0.onCritterListUpdate, arg_3_0)
	arg_3_0:removeEventCb(CritterController.instance, CritterEvent.CritterListResetScrollPos, arg_3_0.resetScrollPos, arg_3_0)
end

function var_0_0._btnsortOnClick(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1.orderDown

	if ManufactureCritterListModel.instance:getOrder() == arg_4_1.orderDown then
		var_4_0 = arg_4_1.orderUp
	end

	ManufactureCritterListModel.instance:setOrder(var_4_0)
	arg_4_0:refreshSort()
	arg_4_0:refreshList()
end

function var_0_0._btnfilterOnClick(arg_5_0)
	local var_5_0 = {
		CritterEnum.FilterType.Race,
		CritterEnum.FilterType.SkillTag
	}

	CritterController.instance:openCritterFilterView(var_5_0, arg_5_0.viewName)
end

function var_0_0._btncloseCritterOnClick(arg_6_0)
	if arg_6_0:getPathId() then
		ManufactureController.instance:clearSelectTransportPath()
	else
		ManufactureController.instance:clearSelectCritterSlotItem()
	end
end

function var_0_0._onChangeSelectedCritterSlotItem(arg_7_0)
	if arg_7_0:getPathId() then
		return
	end

	local var_7_0 = ManufactureModel.instance:getSelectedCritterSlot()

	if var_7_0 == arg_7_0:getViewBuilding() then
		return
	end

	local var_7_1 = RoomMapBuildingModel.instance:getBuildingMOById(var_7_0)

	if var_7_1 then
		arg_7_0.viewContainer:setContainerViewBelongId(var_7_0)
		CritterController.instance:setManufactureCritterList(var_7_1.buildingId, var_7_0, false, arg_7_0.filterMO)
	end
end

function var_0_0._onChangeSelectedTransportPath(arg_8_0)
	local var_8_0 = arg_8_0:getPathId()

	if not var_8_0 then
		return
	end

	local var_8_1 = ManufactureModel.instance:getSelectedTransportPath()

	if var_8_1 == var_8_0 then
		return
	end

	arg_8_0.viewContainer:setContainerViewBelongId(nil, var_8_1)

	local var_8_2, var_8_3, var_8_4 = arg_8_0:getViewBuilding()

	CritterController.instance:setManufactureCritterList(var_8_4, var_8_1, true, arg_8_0.filterMO)
end

function var_0_0.onCritterFilterTypeChange(arg_9_0, arg_9_1)
	if arg_9_1 ~= arg_9_0.viewName then
		return
	end

	arg_9_0:refreshFilterBtn()
	arg_9_0:refreshList()
end

function var_0_0.onCritterListUpdate(arg_10_0)
	local var_10_0 = ManufactureCritterListModel.instance:isCritterListEmpty()

	gohelper.setActive(arg_10_0._goempty, var_10_0)
end

function var_0_0.resetScrollPos(arg_11_0)
	arg_11_0._scrollrect.verticalNormalizedPosition = 1
end

function var_0_0._editableInitView(arg_12_0)
	arg_12_0.sortMoodItem = arg_12_0:getUserDataTb_()
	arg_12_0.sortRareItem = arg_12_0:getUserDataTb_()

	arg_12_0:_initSortItem(arg_12_0.sortMoodItem, arg_12_0._gomood, CritterEnum.OrderType.MoodUp, CritterEnum.OrderType.MoodDown)
	arg_12_0:_initSortItem(arg_12_0.sortRareItem, arg_12_0._gorare, CritterEnum.OrderType.RareUp, CritterEnum.OrderType.RareDown)
end

function var_0_0._initSortItem(arg_13_0, arg_13_1, arg_13_2, arg_13_3, arg_13_4)
	arg_13_1.btnsort = gohelper.findChildButtonWithAudio(arg_13_2, "")
	arg_13_1.go1 = gohelper.findChild(arg_13_2, "#go_normal")
	arg_13_1.go2 = gohelper.findChild(arg_13_2, "#go_selected")
	arg_13_1.goarrow = gohelper.findChild(arg_13_2, "#go_selected/txt/arrow")
	arg_13_1.orderUp = arg_13_3
	arg_13_1.orderDown = arg_13_4

	arg_13_1.btnsort:AddClickListener(arg_13_0._btnsortOnClick, arg_13_0, arg_13_1)
end

function var_0_0.onUpdateParam(arg_14_0)
	return
end

function var_0_0.onOpen(arg_15_0)
	arg_15_0.filterMO = CritterFilterModel.instance:generateFilterMO(arg_15_0.viewName)

	arg_15_0:refreshSort()
	arg_15_0:refreshFilterBtn()
	arg_15_0:refreshList()
end

function var_0_0.refreshList(arg_16_0)
	local var_16_0 = arg_16_0:getPathId()
	local var_16_1, var_16_2, var_16_3 = arg_16_0:getViewBuilding()
	local var_16_4 = var_16_0 and true or false

	CritterController.instance:setManufactureCritterList(var_16_3, var_16_0 or var_16_1, var_16_4, arg_16_0.filterMO)
end

function var_0_0.refreshSort(arg_17_0)
	arg_17_0:_refreshSortItemSort(arg_17_0.sortMoodItem)
	arg_17_0:_refreshSortItemSort(arg_17_0.sortRareItem)
end

function var_0_0._refreshSortItemSort(arg_18_0, arg_18_1)
	local var_18_0 = ManufactureCritterListModel.instance:getOrder()

	arg_18_0:_setSort(arg_18_1, var_18_0 == arg_18_1.orderUp or var_18_0 == arg_18_1.orderDown, var_18_0 == arg_18_1.orderUp)
end

function var_0_0._setSort(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if arg_19_2 then
		gohelper.setActive(arg_19_1.go1, false)
		gohelper.setActive(arg_19_1.go2, true)
		arg_19_0:_setReverse(arg_19_1.goarrow.transform, arg_19_3)
	else
		gohelper.setActive(arg_19_1.go1, true)
		gohelper.setActive(arg_19_1.go2, false)
	end
end

function var_0_0._setReverse(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0, var_20_1, var_20_2 = transformhelper.getLocalScale(arg_20_1)

	if arg_20_2 then
		transformhelper.setLocalScale(arg_20_1, var_20_0, -math.abs(var_20_1), var_20_2)
	else
		transformhelper.setLocalScale(arg_20_1, var_20_0, math.abs(var_20_1), var_20_2)
	end
end

function var_0_0.refreshFilterBtn(arg_21_0)
	local var_21_0 = arg_21_0.filterMO:isFiltering()

	gohelper.setActive(arg_21_0._gonotfilter, not var_21_0)
	gohelper.setActive(arg_21_0._gofilter, var_21_0)
end

function var_0_0.getViewBuilding(arg_22_0)
	local var_22_0, var_22_1, var_22_2 = arg_22_0.viewContainer:getContainerViewBuilding()

	return var_22_0, var_22_1, var_22_2
end

function var_0_0.getPathId(arg_23_0)
	return arg_23_0.viewContainer:getContainerPathId()
end

function var_0_0.onClose(arg_24_0)
	ManufactureCritterListModel.instance:clearSort()
end

function var_0_0.onDestroyView(arg_25_0)
	return
end

return var_0_0
