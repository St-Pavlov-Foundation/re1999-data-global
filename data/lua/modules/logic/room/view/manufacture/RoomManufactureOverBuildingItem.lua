module("modules.logic.room.view.manufacture.RoomManufactureOverBuildingItem", package.seeall)

slot0 = class("RoomManufactureOverBuildingItem", LuaCompBase)

function slot0.init(slot0, slot1)
	slot0.go = slot1

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0._editableInitView(slot0)
	slot0._gocritterInfo = gohelper.findChild(slot0.go, "critterInfo")
	slot0._gocritterItem = gohelper.findChild(slot0.go, "critterInfo/#go_critterInfoItem")
	slot0._txtbuilding = gohelper.findChildText(slot0.go, "manufactureInfo/progress/#txt_building")
	slot0._imagebuildingicon = gohelper.findChildImage(slot0.go, "manufactureInfo/progress/#txt_building/#image_buildingicon")
	slot0._btnaccelerate = gohelper.findChildButtonWithAudio(slot0.go, "manufactureInfo/progress/#txt_building/layout/#btn_accelerate")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.go, "manufactureInfo/progress/#txt_building/layout/#btn_detail")
	slot0._goaccelerate = slot0._btnaccelerate.gameObject
	slot0._btnwrong = gohelper.findChildClickWithDefaultAudio(slot0.go, "manufactureInfo/progress/#txt_building/layout/#btn_wrong")
	slot0._gowrongselect = gohelper.findChild(slot0.go, "manufactureInfo/progress/#txt_building/layout/#btn_wrong/#go_select")
	slot0._gowrongunselect = gohelper.findChild(slot0.go, "manufactureInfo/progress/#txt_building/layout/#btn_wrong/#go_unselect")
	slot0._btngoto = gohelper.findChildClickWithAudio(slot0.go, "manufactureInfo/progress/#btn_goto/clickarea")
	slot0._goscrollslot = gohelper.findChild(slot0.go, "manufactureInfo/#scroll_slot")
	slot0._scrollSlot = slot0._goscrollslot:GetComponent(typeof(ZProj.LimitedScrollRect))
	slot0._goslotItemContent = gohelper.findChild(slot0.go, "manufactureInfo/#scroll_slot/slotViewport/slotContent")
	slot0._transslotItemContent = slot0._goslotItemContent.transform
	slot0._goslotItem = gohelper.findChild(slot0.go, "manufactureInfo/#scroll_slot/slotViewport/slotContent/#go_slotItem")

	gohelper.setActive(slot0._goslotItem, false)

	slot0._gounselectdetail = gohelper.findChild(slot0.go, "manufactureInfo/progress/#txt_building/layout/#btn_detail/unselect")
	slot0._goselectdetail = gohelper.findChild(slot0.go, "manufactureInfo/progress/#txt_building/layout/#btn_detail/select")

	slot0:clearVar()
	slot0:_setDetailSelect(false)
end

function slot0.addEventListeners(slot0)
	slot0._btnaccelerate:AddClickListener(slot0._btnaccelerateOnClick, slot0)
	slot0._btnwrong:AddClickListener(slot0._btnwrongOnClick, slot0)
	slot0._btngoto:AddClickListener(slot0._btngotoOnClick, slot0)
	slot0._btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.OnCloseManufactureBuildingDetailView, slot0._onCloseDetatilView, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.OnWrongTipViewChange, slot0._onWrongViewChange, slot0)
end

function slot0.removeEventListeners(slot0)
	slot0._btnaccelerate:RemoveClickListener()
	slot0._btnwrong:RemoveClickListener()
	slot0._btngoto:RemoveClickListener()
	slot0._btndetail:RemoveClickListener()
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.OnCloseManufactureBuildingDetailView, slot0._onCloseDetatilView, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.OnWrongTipViewChange, slot0._onWrongViewChange, slot0)
end

function slot0._btnaccelerateOnClick(slot0)
	ManufactureController.instance:openManufactureAccelerateView(slot0:getViewBuilding())
	slot0:closePopView()
end

function slot0._btnwrongOnClick(slot0)
	ManufactureController.instance:clickWrongBtn(slot0:getViewBuilding(), true)
end

function slot0._btngotoOnClick(slot0)
	slot1, slot2 = slot0:getViewBuilding()

	ViewMgr.instance:closeView(ViewName.RoomOverView, true)

	if ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView) then
		ManufactureController.instance:closeCritterBuildingView(true)
	end

	slot4 = false

	if slot0.parentView and slot0.parentView.viewContainer.viewParam then
		slot4 = slot0.parentView.viewContainer.viewParam.openFromRest
	end

	ManufactureController.instance:openManufactureBuildingViewByBuilding(slot2, slot4)
end

function slot0._btndetailOnClick(slot0)
	slot0:_setDetailSelect(ManufactureController.instance:openRoomManufactureBuildingDetailView(slot0:getViewBuilding(), true))
end

function slot0._onCloseDetatilView(slot0)
	slot0:_setDetailSelect(false)
end

function slot0.onManufactureInfoUpdate(slot0)
	slot0:refreshSelectedSlot()
	slot0:refreshSelectedCritterSlot()
	slot0:_setSlotItems()
	slot0:_setCritterItem()
	slot0:refresh()
end

function slot0.onManufactureBuildingInfoChange(slot0, slot1)
	if slot1 and not slot1[slot0:getViewBuilding()] then
		return
	end

	slot0:refreshSelectedSlot()
	slot0:refreshSelectedCritterSlot()
	slot0:_setSlotItems()
	slot0:_setCritterItem()
	slot0:refresh()
end

function slot0.onTradeLevelChange(slot0)
	slot0:_setCritterItem()
end

function slot0.onChangeSelectedSlotItem(slot0)
	for slot4, slot5 in ipairs(slot0._slotItemList) do
		slot5:onChangeSelectedSlotItem()
	end
end

function slot0._setDetailSelect(slot0, slot1)
	gohelper.setActive(slot0._goselectdetail, slot1)
	gohelper.setActive(slot0._gounselectdetail, not slot1)
end

function slot0._onWrongViewChange(slot0, slot1)
	slot0:refreshWrongBtnSelect(slot1)
end

function slot0.setData(slot0, slot1, slot2, slot3)
	slot0.buildingMO = slot1
	slot0.index = slot2
	slot0.parentView = slot3
	slot0._scrollSlot.parentGameObject = slot3._goscrollbuilding
	slot0._curViewManufactureState = nil

	slot0:_setSlotItems()
	slot0:_setCritterItem()
	slot0:refresh()
end

function slot0._setSlotItems(slot0)
	slot1, slot2 = slot0:getViewBuilding()

	if not slot2 then
		slot0:recycleAllSlotItem()

		return
	end

	for slot9 = 1, ManufactureConfig.instance:getBuildingTotalSlotCount(slot2.buildingId) do
		slot0:getSlotItem(slot9):setData(slot2:getAllUnlockedSlotIdList()[slot9], slot9)
	end

	if slot5 < #slot0._slotItemList then
		for slot10 = slot5 + 1, slot6 do
			slot0:recycleSlotItem(slot0._slotItemList[slot10])
		end
	end

	slot0:_setSlotContentSize()
end

function slot0._setSlotContentSize(slot0)
	recthelper.setWidth(slot0._transslotItemContent, (recthelper.getWidth(slot0._goslotItem.transform) + RoomManufactureEnum.OverviewSlotItemSpace) * #slot0._slotItemList - RoomManufactureEnum.OverviewSlotItemSpace)
end

function slot0._setCritterItem(slot0)
	slot1, slot2 = slot0:getViewBuilding()
	slot3 = 0

	if slot2 then
		slot3 = slot2:getCanPlaceCritterCount()
	end

	if slot0._critterItemList and #slot0._critterItemList and slot3 < slot4 then
		for slot8 = slot3 + 1, slot4 do
			slot0._critterItemList[slot8]:reset()
		end
	end

	slot0._critterItemList = {}

	for slot9 = 1, slot3 do
	end

	gohelper.CreateObjList(slot0, slot0._onSetCritterItem, {
		[slot9] = slot9 - 1
	}, slot0._gocritterInfo, slot0._gocritterItem, RoomManufactureCritterInfo)
end

function slot0._onSetCritterItem(slot0, slot1, slot2, slot3)
	slot0._critterItemList[slot3] = slot1

	slot1:setData(slot2, slot3, slot0)
end

function slot0.closePopView(slot0)
	ManufactureController.instance:clearSelectedSlotItem()
	ManufactureController.instance:clearSelectCritterSlotItem()
end

function slot0.getSlotItem(slot0, slot1)
	if not slot0._slotItemList[slot1] then
		slot0._slotItemList[slot1] = slot0:getSlotItemFromPool()
	end

	return slot2
end

function slot0.getSlotItemFromPool(slot0)
	if next(slot0._slotItemPool) then
		return table.remove(slot0._slotItemPool)
	else
		return slot0:createSlotItem()
	end
end

function slot0.createSlotItem(slot0)
	return RoomManufactureOverSlotItem.New(gohelper.clone(slot0._goslotItem, slot0._goslotItemContent), slot0)
end

function slot0.recycleSlotItem(slot0, slot1)
	slot1:reset(true)
	tabletool.removeValue(slot0._slotItemList, slot1)
	table.insert(slot0._slotItemPool, slot1)
end

function slot0.recycleAllSlotItem(slot0)
	if slot0._slotItemList then
		for slot4, slot5 in ipairs(slot0._slotItemList) do
			slot5:reset(true)
			table.insert(slot0._slotItemPool, slot5)
		end
	end

	slot0._slotItemList = {}
end

function slot0.refresh(slot0)
	slot0:refreshTitle()
	slot0:refreshCritter()
	slot0:checkManufactureState()
	slot0:refreshSlotItems()
	slot0:refreshWrongBtnShow()
	slot0:refreshDetailBtn()
end

function slot0.refreshTitle(slot0)
	slot1 = ""
	slot2 = 0
	slot3 = nil
	slot4, slot5 = slot0:getViewBuilding()

	if slot5 then
		slot1 = slot5.config.useDesc
		slot2 = slot5.level
		slot3 = slot5.buildingId
	end

	slot6 = ""
	slot0._txtbuilding.text = string.format("%s <color=#E19653>%s</color>", slot1, (ManufactureConfig.instance:getBuildingMaxLevel(slot3) > slot2 or luaLang("lv_max")) and formatLuaLang("v1a5_aizila_level", slot2))

	UISpriteSetMgr.instance:setRoomSprite(slot0._imagebuildingicon, ManufactureConfig.instance:getManufactureBuildingIcon(slot5.buildingId))
end

function slot0.refreshCritter(slot0)
end

function slot0.checkManufactureState(slot0)
	slot1 = false
	slot2, slot3 = slot0:getViewBuilding()

	if slot3 then
		slot1 = slot3:getManufactureState()
	end

	if slot0._curViewManufactureState == slot1 then
		return
	end

	slot0._curViewManufactureState = slot1

	gohelper.setActive(slot0._goaccelerate, slot0._curViewManufactureState == RoomManufactureEnum.ManufactureState.Running)
end

function slot0.refreshSlotItems(slot0)
	for slot4, slot5 in ipairs(slot0._slotItemList) do
		slot5:refresh()
	end
end

function slot0.refreshSelectedSlot(slot0)
	if ManufactureModel.instance:getSelectedSlot() == slot0:getViewBuilding() then
		ManufactureController.instance:refreshSelectedSlotId(slot1)
	end
end

function slot0.refreshSelectedCritterSlot(slot0)
	if ManufactureModel.instance:getSelectedCritterSlot() == slot0:getViewBuilding() then
		ManufactureController.instance:refreshSelectedCritterSlotId(slot1)
	end
end

function slot0.refreshWrongBtnShow(slot0)
	slot0:refreshWrongBtnSelect()
	gohelper.setActive(slot0._btnwrong, #ManufactureModel.instance:getManufactureWrongTipItemList(slot0:getViewBuilding()) > 0)
end

function slot0.refreshWrongBtnSelect(slot0, slot1)
	slot4 = ViewMgr.instance:isOpen(ViewName.RoomManufactureWrongTipView) and slot1 == slot0:getViewBuilding()

	gohelper.setActive(slot0._gowrongselect, slot4)
	gohelper.setActive(slot0._gowrongunselect, not slot4)
end

function slot0.refreshDetailBtn(slot0)
	slot1, slot2 = slot0:getViewBuilding()

	gohelper.setActive(slot0._btndetail, next(slot2:getSlot2CritterDict()))
end

function slot0.everySecondCall(slot0)
	for slot4, slot5 in ipairs(slot0._slotItemList) do
		slot5:everySecondCall()
	end
end

function slot0.getViewBuilding(slot0)
	slot1 = nil

	if slot0.buildingMO then
		slot1 = slot0.buildingMO.uid
	end

	return slot1, slot0.buildingMO
end

function slot0.getSlotItemContentTrans(slot0)
	return slot0._transslotItemContent
end

function slot0.getIndex(slot0)
	return slot0.index
end

function slot0.isShowAddPop(slot0)
	return slot0.parentView:isShowAddPop()
end

function slot0.setViewBuildingUid(slot0)
	slot0.parentView:setViewBuildingUid(slot0:getViewBuilding())
end

function slot0.clearVar(slot0)
	slot0.index = nil
	slot0._curViewManufactureState = nil

	slot0:clearSlotPool()
	slot0:clearSlotItemList()
end

function slot0.clearSlotPool(slot0)
	if slot0._slotItemPool then
		for slot4, slot5 in ipairs(slot0._slotItemPool) do
			slot5:destroy()
		end
	end

	slot0._slotItemPool = {}
end

function slot0.clearSlotItemList(slot0)
	if slot0._slotItemList then
		for slot4, slot5 in ipairs(slot0._slotItemList) do
			slot5:destroy()
		end
	end

	slot0._slotItemList = {}
end

function slot0.onDestroy(slot0)
	slot0:clearVar()
end

return slot0
