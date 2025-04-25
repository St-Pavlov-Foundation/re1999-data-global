module("modules.logic.room.view.manufacture.RoomManufactureBuildingView", package.seeall)

slot0 = class("RoomManufactureBuildingView", BaseView)
slot1 = 1

function slot0.onInitView(slot0)
	slot0._btnpopBlock = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#go_popBlock")
	slot0._imagebuildingIcon = gohelper.findChildImage(slot0.viewGO, "#go_left/headerInfo/#simage_buildingIcon")
	slot0._txtmanuName = gohelper.findChildText(slot0.viewGO, "#go_left/headerInfo/layout/#txt_manuName")
	slot0._txtlv = gohelper.findChildText(slot0.viewGO, "#go_left/headerInfo/layout/lv/#txt_lv")
	slot0._btnupgrade = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_left/headerInfo/#btn_upgrade")
	slot0._goupgradeReddot = gohelper.findChild(slot0.viewGO, "#go_left/headerInfo/#btn_upgrade/#go_reddot")
	slot0._goswithbtnlayout = gohelper.findChild(slot0.viewGO, "#go_left/layoutSwitchBtns")
	slot0._goswithItem = gohelper.findChild(slot0.viewGO, "#go_left/layoutSwitchBtns/#btn_swithItem")
	slot0._gocritterInfo = gohelper.findChild(slot0.viewGO, "#go_left/critterInfo")
	slot0._gocritterItem = gohelper.findChild(slot0.viewGO, "#go_left/critterInfo/#go_critterInfoItem")
	slot0._gomanufacture = gohelper.findChild(slot0.viewGO, "#go_right/#go_manufacture")
	slot0._btnaccelerate = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_right/#go_manufacture/slotQueue/txt_title/#btn_accelerate")
	slot0._btnwrong = gohelper.findChildClickWithDefaultAudio(slot0.viewGO, "#go_right/#go_manufacture/slotQueue/txt_title/#btn_wrong")
	slot0._gowrongselect = gohelper.findChild(slot0.viewGO, "#go_right/#go_manufacture/slotQueue/txt_title/#btn_wrong/#go_select")
	slot0._gowrongunselect = gohelper.findChild(slot0.viewGO, "#go_right/#go_manufacture/slotQueue/txt_title/#btn_wrong/#go_unselect")
	slot0._btnproduction = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_right/#go_manufacture/slotQueue/#btn_production")
	slot0._goproductionReddot = gohelper.findChild(slot0.viewGO, "#go_right/#go_manufacture/slotQueue/#btn_production/#go_reddot")
	slot0._goscrollslot = gohelper.findChild(slot0.viewGO, "#go_right/#go_manufacture/slotQueue/#scroll_slot")
	slot0._transscrollslot = slot0._goscrollslot.transform
	slot0._scrollslot = slot0._goscrollslot:GetComponent(typeof(UnityEngine.UI.ScrollRect))
	slot0._goslotItemContent = gohelper.findChild(slot0.viewGO, "#go_right/#go_manufacture/slotQueue/#scroll_slot/viewport/content")
	slot0._transslotItemContent = slot0._goslotItemContent.transform
	slot0._goslotItem = gohelper.findChild(slot0.viewGO, "#go_right/#go_manufacture/slotQueue/#scroll_slot/viewport/content/#go_slotItem")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_detail")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnupgrade:AddClickListener(slot0._btnupgradeOnClick, slot0)
	slot0._btnaccelerate:AddClickListener(slot0._btnaccelerateOnClick, slot0)
	slot0._btnwrong:AddClickListener(slot0._btnwrongOnClick, slot0)
	slot0._btnproduction:AddClickListener(slot0._btnproductionOnClick, slot0)
	slot0._btnpopBlock:AddClickListener(slot0._btnpopBlockOnClick, slot0)
	slot0._btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
	slot0:addEventCb(RoomController.instance, RoomEvent.ManufactureGuideTweenFinish, slot0._onManufactureGuideTweenFinish, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, slot0._onManufactureInfoUpdate, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.TradeLevelChange, slot0._onTradeLevelChange, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, slot0._onManufactureBuildingInfoChange, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedCritterSlotItem, slot0._onChangeSelectedCritterSlotItem, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureReadNewFormula, slot0._onReadNewFormula, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.BuildingLevelUpPush, slot0._onBuildingLevelUp, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onViewChange, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onViewChange, slot0)
	NavigateMgr.instance:addEscape(ViewName.RoomManufactureBuildingView, slot0._onEscape, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnupgrade:RemoveClickListener()
	slot0._btnaccelerate:RemoveClickListener()
	slot0._btnwrong:RemoveClickListener()
	slot0._btnproduction:RemoveClickListener()
	slot0._btnpopBlock:RemoveClickListener()
	slot0._btndetail:RemoveClickListener()
	slot0:clearSwitchBtnList()
	slot0:removeEventCb(RoomController.instance, RoomEvent.ManufactureGuideTweenFinish, slot0._onManufactureGuideTweenFinish, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, slot0._onManufactureInfoUpdate, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.TradeLevelChange, slot0._onTradeLevelChange, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, slot0._onManufactureBuildingInfoChange, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedCritterSlotItem, slot0._onChangeSelectedCritterSlotItem, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureReadNewFormula, slot0._onReadNewFormula, slot0)
	slot0:removeEventCb(RoomMapController.instance, RoomEvent.BuildingLevelUpPush, slot0._onBuildingLevelUp, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onViewChange, slot0)
	slot0:removeEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onViewChange, slot0)
end

function slot0._btndetailOnClick(slot0)
	slot1, slot2 = slot0:getViewBuilding()

	ManufactureController.instance:openRoomManufactureBuildingDetailView(slot1)
end

function slot0._btnupgradeOnClick(slot0)
	ManufactureController.instance:openManufactureBuildingLevelUpView(slot0:getViewBuilding())
end

function slot0._btnaccelerateOnClick(slot0)
	ManufactureController.instance:openManufactureAccelerateView(slot0:getViewBuilding())
end

function slot0._btnwrongOnClick(slot0)
	ManufactureController.instance:clickWrongBtn(slot0:getViewBuilding())
end

function slot0._btnproductionOnClick(slot0, slot1)
	ManufactureController.instance:clickSlotItem(slot0:getViewBuilding(), nil, , true, nil, slot1)
end

slot2 = {
	ViewName.RoomManufactureAddPopView,
	ViewName.RoomCritterListView,
	ViewName.RoomManufactureWrongTipView
}

function slot0._btnpopBlockOnClick(slot0)
	for slot4, slot5 in ipairs(uv0) do
		if ViewMgr.instance:isOpen(slot5) then
			slot0:closePopView()

			break
		end
	end
end

function slot0._btnswithItemOnClick(slot0, slot1)
	slot3 = slot1.isOnOpen

	if not slot0._switchBtnList[slot1.index] then
		return
	end

	slot5 = slot4.buildingUid

	if slot0:getViewBuilding() and slot6 == slot5 then
		return
	end

	slot0:closePopView()
	slot0.viewContainer:setContainerViewBuildingUid(slot5)

	slot0._curViewManufactureState = nil

	if not slot3 then
		slot0:_refreshCamera()
	end

	slot0:refreshSelectedSlot()
	slot0:refreshSelectedCritterSlot()
	slot0:_setCritterItem()
	slot0:_setSlotItems()
	slot0:_setAddPopItems()
	slot0:refresh()
end

function slot0._refreshCamera(slot0)
	slot1, slot2 = slot0:getViewBuilding()

	if not slot2 then
		return
	end

	slot4 = ManufactureConfig.instance:getBuildingCameraIdByIndex(slot2.buildingId)

	if RoomCameraController.instance:getRoomCamera() and slot4 then
		RoomCameraController.instance:tweenCameraFocusBuildingUseCameraId(slot1, slot4)
	end
end

function slot0._onManufactureGuideTweenFinish(slot0)
	slot0:_setSlotItems()
end

function slot0._onManufactureInfoUpdate(slot0)
	slot0:refreshSelectedSlot()
	slot0:refreshSelectedCritterSlot()
	slot0:_setCritterItem()
	slot0:_setSlotItems()
	slot0:refresh()
end

function slot0._onTradeLevelChange(slot0)
	slot0:refreshTitle()
	slot0:_setCritterItem()
end

function slot0._onManufactureBuildingInfoChange(slot0, slot1)
	if slot1 and not slot1[slot0:getViewBuilding()] then
		return
	end

	slot0:refreshSelectedSlot()
	slot0:refreshSelectedCritterSlot()
	slot0:_setCritterItem()
	slot0:_setSlotItems()
	slot0:refresh()
end

function slot0._onChangeSelectedCritterSlotItem(slot0)
	slot1 = false
	slot2, slot3 = ManufactureModel.instance:getSelectedCritterSlot()

	if slot3 and slot2 and slot2 == slot0:getViewBuilding() then
		slot1 = true
	end

	gohelper.setActive(slot0._gomanufacture, not slot1)
end

function slot0._onReadNewFormula(slot0)
	if not slot0._newFormulaReddot then
		return
	end

	slot0._newFormulaReddot:refreshRedDot()
end

function slot0._onBuildingLevelUp(slot0, slot1)
	if not slot1 or not slot1[slot0:getViewBuilding()] then
		return
	end

	slot0:closePopView()
	slot0:_setAddPopItems()
	slot0:_onReadNewFormula()
end

function slot0._onViewChange(slot0, slot1)
	if slot1 == ViewName.RoomManufactureWrongTipView then
		slot0:refreshWrongBtnSelect()
	end
end

function slot0._onEscape(slot0)
	ViewMgr.instance:closeView(ViewName.RoomManufactureBuildingView)
	ManufactureController.instance:resetCameraOnCloseView()
end

function slot0._editableInitView(slot0)
	slot0:clearVar()
	gohelper.setActive(slot0._goslotItem, false)
end

function slot0.onUpdateParam(slot0)
	slot0.buildingType = slot0.viewParam.buildingType
	slot0.defaultBuildingUid = slot0.viewParam.defaultBuildingUid

	slot0:setView()

	if slot0.viewParam.addManuItem then
		slot0:_btnproductionOnClick(slot0.viewParam.addManuItem)
	end
end

function slot0.onOpen(slot0)
	slot0:onUpdateParam()
	slot0:everySecondCall()
	TaskDispatcher.runRepeat(slot0.everySecondCall, slot0, TimeUtil.OneSecond)
	AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_yield_click)
end

function slot0.setView(slot0)
	slot0:_setSwitchBtnGroup()

	slot1 = uv0

	if slot0.defaultBuildingUid then
		for slot5, slot6 in ipairs(slot0._switchBtnList) do
			if slot6.buildingUid == slot0.defaultBuildingUid then
				slot1 = slot5

				break
			end
		end
	end

	slot0:_btnswithItemOnClick({
		isOnOpen = true,
		index = slot1
	})
end

function slot0._setSwitchBtnGroup(slot0)
	gohelper.CreateObjList(slot0, slot0._onSetSwitchBtnItem, RoomMapBuildingModel.instance:getBuildingListByType(slot0.buildingType, true) or {}, slot0._goswithbtnlayout, slot0._goswithItem)
end

function slot0._onSetSwitchBtnItem(slot0, slot1, slot2, slot3)
	slot4 = slot0:getUserDataTb_()
	slot4.go = slot1
	slot4.buildingUid = slot2.uid
	slot4.goSelect = gohelper.findChild(slot4.go, "go_select")
	slot4.goUnselect = gohelper.findChild(slot4.go, "go_unselect")
	slot4.goReddot = gohelper.findChild(slot4.go, "#go_reddot")

	RedDotController.instance:addRedDot(slot4.goReddot, RedDotEnum.DotNode.ManufactureBuildingCanLevelUp, tonumber(slot4.buildingUid))

	slot5 = ManufactureConfig.instance:getManufactureBuildingIcon(slot2.buildingId)
	slot4.imgSelectIcon = gohelper.findChildImage(slot4.go, "go_select/image_selecticon")
	slot4.imgUnselectIcon = gohelper.findChildImage(slot4.go, "go_unselect/image_unselecticon")

	UISpriteSetMgr.instance:setRoomSprite(slot4.imgSelectIcon, slot5)
	UISpriteSetMgr.instance:setRoomSprite(slot4.imgUnselectIcon, slot5)

	slot4.btn = gohelper.findChildClickWithDefaultAudio(slot4.go, "clickarea")

	slot4.btn:AddClickListener(slot0._btnswithItemOnClick, slot0, {
		index = slot3
	})

	slot0._switchBtnList[slot3] = slot4
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

function slot0._setSlotItems(slot0)
	slot1, slot2 = slot0:getViewBuilding()

	if not slot2 then
		slot0:recycleAllSlotItem()

		return
	end

	if slot0:checkGuide() then
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
end

function slot0._setAddPopItems(slot0)
	ManufactureController.instance:setManufactureFormulaItemList(slot0:getViewBuilding())
end

function slot0.closePopView(slot0)
	slot0:_closeFormulaListView()
	slot0:_closeCritterListView()
	slot0:_closeWrongTipView()
end

function slot0._closeCritterListView(slot0)
	ManufactureController.instance:clearSelectCritterSlotItem()
end

function slot0._closeFormulaListView(slot0)
	ManufactureController.instance:clearSelectedSlotItem()
end

function slot0._closeWrongTipView(slot0)
	ManufactureController.instance:closeWrongTipView()
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

function slot0.createSlotItem(slot0, slot1)
	return RoomManufactureSlotItem.New(gohelper.clone(slot0._goslotItem, slot1 or slot0._goslotItemContent), slot0)
end

function slot0.recycleSlotItem(slot0, slot1)
	if not slot1 then
		return
	end

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
	slot0:refreshSwitchBtns()
	slot0:refreshSlotItems()
	slot0:checkManufactureState()
	slot0:refreshReddot()
	slot0:refreshWrongBtnShow()
end

function slot0.refreshTitle(slot0)
	slot1 = ""
	slot2 = 0
	slot3, slot4 = nil
	slot5, slot6 = slot0:getViewBuilding()

	if slot6 then
		slot1 = slot6.config.useDesc
		slot2 = slot6:getLevel()
		slot4 = ManufactureConfig.instance:getManufactureBuildingIcon(slot6.buildingId)
		slot3 = slot6.buildingId
	end

	slot0._txtmanuName.text = slot1
	slot7 = ""
	slot0._txtlv.text = (ManufactureConfig.instance:getBuildingMaxLevel(slot3) > slot2 or luaLang("lv_max")) and formatLuaLang("v1a5_aizila_level", slot2)

	if slot4 then
		UISpriteSetMgr.instance:setRoomSprite(slot0._imagebuildingIcon, slot4)
	end

	gohelper.setActive(slot0._btnupgrade.gameObject, not ManufactureModel.instance:isMaxLevel(slot5))
end

function slot0.refreshSwitchBtns(slot0)
	if not slot0._switchBtnList then
		return
	end

	for slot5, slot6 in ipairs(slot0._switchBtnList) do
		slot7 = slot6.buildingUid == slot0:getViewBuilding()

		gohelper.setActive(slot6.goSelect, slot7)
		gohelper.setActive(slot6.goUnselect, not slot7)
	end
end

function slot0.refreshSlotItems(slot0)
	if slot0:checkGuide() then
		return
	end

	for slot4, slot5 in ipairs(slot0._slotItemList) do
		slot5:refresh()
	end
end

function slot0.checkManufactureState(slot0)
	slot1, slot2 = slot0:getViewBuilding()
	slot3 = false

	if slot2 then
		slot3 = slot2:getManufactureState()
	end

	if slot0._curViewManufactureState == slot3 then
		return
	end

	slot0._curViewManufactureState = slot3

	gohelper.setActive(slot0._btnaccelerate.gameObject, slot0._curViewManufactureState == RoomManufactureEnum.ManufactureState.Running)
end

function slot0.refreshSelectedSlot(slot0)
	ManufactureController.instance:refreshSelectedSlotId(slot0:getViewBuilding())
end

function slot0.refreshSelectedCritterSlot(slot0)
	ManufactureController.instance:refreshSelectedCritterSlotId(slot0:getViewBuilding())
end

function slot0.refreshReddot(slot0)
	RedDotController.instance:addRedDot(slot0._goupgradeReddot, RedDotEnum.DotNode.ManufactureBuildingCanLevelUp, tonumber(slot0:getViewBuilding()))

	slot0._newFormulaReddot = RedDotController.instance:addNotEventRedDot(slot0._goproductionReddot, slot0.checkNewFormulaReddot, slot0)
end

function slot0.checkNewFormulaReddot(slot0)
	return ManufactureModel.instance:hasNewManufactureFormula(slot0:getViewBuilding())
end

function slot0.refreshWrongBtnShow(slot0)
	if #ManufactureModel.instance:getManufactureWrongTipItemList(slot0:getViewBuilding()) > 0 then
		slot0:refreshWrongBtnSelect()
	end

	gohelper.setActive(slot0._btnwrong, slot3)
end

function slot0.refreshWrongBtnSelect(slot0)
	slot1 = ViewMgr.instance:isOpen(ViewName.RoomManufactureWrongTipView)

	gohelper.setActive(slot0._gowrongselect, slot1)
	gohelper.setActive(slot0._gowrongunselect, not slot1)
end

function slot0.everySecondCall(slot0)
	for slot4, slot5 in ipairs(slot0._slotItemList) do
		slot5:everySecondCall()
	end
end

function slot0.getViewBuilding(slot0)
	slot1, slot2 = slot0.viewContainer:getContainerViewBuilding()

	return slot1, slot2
end

function slot0.clearVar(slot0)
	slot0.buildingType = nil
	slot0.defaultBuildingUid = nil

	slot0:clearSwitchBtnList()

	slot0._curViewManufactureState = nil

	slot0:clearSlotPool()
	slot0:clearSlotItemList()
end

function slot0.clearSwitchBtnList(slot0)
	if slot0._switchBtnList then
		for slot4, slot5 in ipairs(slot0._switchBtnList) do
			slot5.btn:RemoveClickListener()
			gohelper.destroy(slot5.go)
		end
	end

	slot0._switchBtnList = {}
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

function slot0.checkGuide(slot0)
	slot2 = false

	if GuideModel.instance:getLockGuideId() == 414 then
		for slot6, slot7 in ipairs(slot0._slotItemList) do
			if slot7:checkPlayGuideTween() then
				slot2 = true
			end
		end
	end

	return slot2
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)
	slot0:closePopView()
	ManufactureController.instance:dispatchEvent(ManufactureEvent.ManufactureBuildingViewChange)
end

function slot0.onDestroyView(slot0)
	slot0:clearVar()
end

return slot0
