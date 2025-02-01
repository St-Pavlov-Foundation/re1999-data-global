module("modules.logic.room.view.manufacture.RoomCritterListView", package.seeall)

slot0 = class("RoomCritterListView", BaseView)

function slot0.onInitView(slot0)
	slot0._gomood = gohelper.findChild(slot0.viewGO, "#go_critter/sort/#btn_mood")
	slot0._gorare = gohelper.findChild(slot0.viewGO, "#go_critter/sort/#btn_rare")
	slot0._btnfilter = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_critter/sort/#btn_filter")
	slot0._gonotfilter = gohelper.findChild(slot0.viewGO, "#go_critter/sort/#btn_filter/#go_notfilter")
	slot0._gofilter = gohelper.findChild(slot0.viewGO, "#go_critter/sort/#btn_filter/#go_filter")
	slot0._scrollrect = gohelper.findChildScrollRect(slot0.viewGO, "#go_critter/#scroll_critter")
	slot0._btncloseCritter = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_critter/#btn_closeCritter")
	slot0._goempty = gohelper.findChild(slot0.viewGO, "#go_critter/#go_empty")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnfilter:AddClickListener(slot0._btnfilterOnClick, slot0)
	slot0._btncloseCritter:AddClickListener(slot0._btncloseCritterOnClick, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedCritterSlotItem, slot0._onChangeSelectedCritterSlotItem, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedTransportPath, slot0._onChangeSelectedTransportPath, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterChangeFilterType, slot0.onCritterFilterTypeChange, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterListUpdate, slot0.onCritterListUpdate, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterListResetScrollPos, slot0.resetScrollPos, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnfilter:RemoveClickListener()
	slot0._btncloseCritter:RemoveClickListener()

	if slot0.sortMoodItem then
		slot0.sortMoodItem.btnsort:RemoveClickListener()
	end

	if slot0.sortRareItem then
		slot0.sortRareItem.btnsort:RemoveClickListener()
	end

	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedCritterSlotItem, slot0._onChangeSelectedCritterSlotItem, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedTransportPath, slot0._onChangeSelectedTransportPath, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterChangeFilterType, slot0.onCritterFilterTypeChange, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterListUpdate, slot0.onCritterListUpdate, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.CritterListResetScrollPos, slot0.resetScrollPos, slot0)
end

function slot0._btnsortOnClick(slot0, slot1)
	slot2 = slot1.orderDown

	if ManufactureCritterListModel.instance:getOrder() == slot1.orderDown then
		slot2 = slot1.orderUp
	end

	ManufactureCritterListModel.instance:setOrder(slot2)
	slot0:refreshSort()
	slot0:refreshList()
end

function slot0._btnfilterOnClick(slot0)
	CritterController.instance:openCritterFilterView({
		CritterEnum.FilterType.Race,
		CritterEnum.FilterType.SkillTag
	}, slot0.viewName)
end

function slot0._btncloseCritterOnClick(slot0)
	if slot0:getPathId() then
		ManufactureController.instance:clearSelectTransportPath()
	else
		ManufactureController.instance:clearSelectCritterSlotItem()
	end
end

function slot0._onChangeSelectedCritterSlotItem(slot0)
	if slot0:getPathId() then
		return
	end

	if ManufactureModel.instance:getSelectedCritterSlot() == slot0:getViewBuilding() then
		return
	end

	if RoomMapBuildingModel.instance:getBuildingMOById(slot2) then
		slot0.viewContainer:setContainerViewBelongId(slot2)
		CritterController.instance:setManufactureCritterList(slot4.buildingId, slot2, false, slot0.filterMO)
	end
end

function slot0._onChangeSelectedTransportPath(slot0)
	if not slot0:getPathId() then
		return
	end

	if ManufactureModel.instance:getSelectedTransportPath() == slot1 then
		return
	end

	slot0.viewContainer:setContainerViewBelongId(nil, slot2)

	slot3, slot4, slot5 = slot0:getViewBuilding()

	CritterController.instance:setManufactureCritterList(slot5, slot2, true, slot0.filterMO)
end

function slot0.onCritterFilterTypeChange(slot0, slot1)
	if slot1 ~= slot0.viewName then
		return
	end

	slot0:refreshFilterBtn()
	slot0:refreshList()
end

function slot0.onCritterListUpdate(slot0)
	gohelper.setActive(slot0._goempty, ManufactureCritterListModel.instance:isCritterListEmpty())
end

function slot0.resetScrollPos(slot0)
	slot0._scrollrect.verticalNormalizedPosition = 1
end

function slot0._editableInitView(slot0)
	slot0.sortMoodItem = slot0:getUserDataTb_()
	slot0.sortRareItem = slot0:getUserDataTb_()

	slot0:_initSortItem(slot0.sortMoodItem, slot0._gomood, CritterEnum.OrderType.MoodUp, CritterEnum.OrderType.MoodDown)
	slot0:_initSortItem(slot0.sortRareItem, slot0._gorare, CritterEnum.OrderType.RareUp, CritterEnum.OrderType.RareDown)
end

function slot0._initSortItem(slot0, slot1, slot2, slot3, slot4)
	slot1.btnsort = gohelper.findChildButtonWithAudio(slot2, "")
	slot1.go1 = gohelper.findChild(slot2, "#go_normal")
	slot1.go2 = gohelper.findChild(slot2, "#go_selected")
	slot1.goarrow = gohelper.findChild(slot2, "#go_selected/txt/arrow")
	slot1.orderUp = slot3
	slot1.orderDown = slot4

	slot1.btnsort:AddClickListener(slot0._btnsortOnClick, slot0, slot1)
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	slot0.filterMO = CritterFilterModel.instance:generateFilterMO(slot0.viewName)

	slot0:refreshSort()
	slot0:refreshFilterBtn()
	slot0:refreshList()
end

function slot0.refreshList(slot0)
	slot2, slot3, slot4 = slot0:getViewBuilding()

	CritterController.instance:setManufactureCritterList(slot4, slot1 or slot2, slot0:getPathId() and true or false, slot0.filterMO)
end

function slot0.refreshSort(slot0)
	slot0:_refreshSortItemSort(slot0.sortMoodItem)
	slot0:_refreshSortItemSort(slot0.sortRareItem)
end

function slot0._refreshSortItemSort(slot0, slot1)
	slot0:_setSort(slot1, ManufactureCritterListModel.instance:getOrder() == slot1.orderUp or slot2 == slot1.orderDown, slot2 == slot1.orderUp)
end

function slot0._setSort(slot0, slot1, slot2, slot3)
	if slot2 then
		gohelper.setActive(slot1.go1, false)
		gohelper.setActive(slot1.go2, true)
		slot0:_setReverse(slot1.goarrow.transform, slot3)
	else
		gohelper.setActive(slot1.go1, true)
		gohelper.setActive(slot1.go2, false)
	end
end

function slot0._setReverse(slot0, slot1, slot2)
	slot3, slot4, slot5 = transformhelper.getLocalScale(slot1)

	if slot2 then
		transformhelper.setLocalScale(slot1, slot3, -math.abs(slot4), slot5)
	else
		transformhelper.setLocalScale(slot1, slot3, math.abs(slot4), slot5)
	end
end

function slot0.refreshFilterBtn(slot0)
	slot1 = slot0.filterMO:isFiltering()

	gohelper.setActive(slot0._gonotfilter, not slot1)
	gohelper.setActive(slot0._gofilter, slot1)
end

function slot0.getViewBuilding(slot0)
	slot1, slot2, slot3 = slot0.viewContainer:getContainerViewBuilding()

	return slot1, slot2, slot3
end

function slot0.getPathId(slot0)
	return slot0.viewContainer:getContainerPathId()
end

function slot0.onClose(slot0)
	ManufactureCritterListModel.instance:clearSort()
end

function slot0.onDestroyView(slot0)
end

return slot0
