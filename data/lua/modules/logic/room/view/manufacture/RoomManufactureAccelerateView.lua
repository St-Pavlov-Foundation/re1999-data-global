module("modules.logic.room.view.manufacture.RoomManufactureAccelerateView", package.seeall)

slot0 = class("RoomManufactureAccelerateView", BaseView)

function slot0.onInitView(slot0)
	slot0._clickMask = gohelper.findChildClickWithAudio(slot0.viewGO, "mask")
	slot0._imagebuildingIcon = gohelper.findChildImage(slot0.viewGO, "title/#simage_buildingIcon")
	slot0._txtbuildingName = gohelper.findChildText(slot0.viewGO, "title/#txt_buildingName")
	slot0._imgquality = gohelper.findChildImage(slot0.viewGO, "progress/#image_quality")
	slot0._gomanufactureItem = gohelper.findChild(slot0.viewGO, "progress/#go_manufactureItem")
	slot0._txtmanufactureItemName = gohelper.findChildText(slot0.viewGO, "progress/#txt_manufactureItemName")
	slot0._simagebarIcon = gohelper.findChildSingleImage(slot0.viewGO, "progress/progressBar/#simage_barIcon")
	slot0._simagebarValue = gohelper.findChildImage(slot0.viewGO, "progress/progressBar/#simage_barValue")
	slot0._gotime = gohelper.findChild(slot0.viewGO, "progress/progressBar/#go_time")
	slot0._txttime = gohelper.findChildText(slot0.viewGO, "progress/progressBar/#go_time/#txt_time")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "itemArea/#scroll_item/viewport/content")
	slot0._goaccelerateItem = gohelper.findChild(slot0.viewGO, "itemArea/#scroll_item/viewport/content/#go_accelerateItem")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._clickMask:AddClickListener(slot0.onClickModalMask, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, slot0._onManufactureInfoUpdate, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, slot0._onManufactureBuildingInfoChange, slot0)
end

function slot0.removeEvents(slot0)
	slot0._clickMask:RemoveClickListener()
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, slot0._onManufactureInfoUpdate, slot0)
	slot0:removeEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, slot0._onManufactureBuildingInfoChange, slot0)
end

function slot0.onClickModalMask(slot0)
	slot0:closeThis()
end

function slot0._onManufactureInfoUpdate(slot0)
	slot0:refreshProgress()
end

function slot0._onManufactureBuildingInfoChange(slot0, slot1)
	if slot1 and not slot1[slot0._buildingMO and slot0._buildingMO.id] then
		return
	end

	slot0:refreshProgress()
end

function slot0._editableInitView(slot0)
	slot0._accelerateItemList = {}
end

function slot0.onUpdateParam(slot0)
	slot0._buildingMO = RoomMapBuildingModel.instance:getBuildingMOById(slot0.viewParam.buildingUid)

	slot0:refreshTitle()
	slot0:setManufactureItem()
end

function slot0.setManufactureItem(slot0)
	slot0.curSlotId = slot0._buildingMO and slot0._buildingMO:getSlotIdInProgress()

	if ManufactureConfig.instance:getItemId(slot0._buildingMO:getSlotManufactureItemId(slot0.curSlotId)) then
		if not slot0._itemIcon then
			slot0._itemIcon = IconMgr.instance:getCommonItemIcon(slot0._gomanufactureItem)

			slot0._itemIcon:isShowQuality(false)
		end

		slot0._itemIcon:setMOValue(MaterialEnum.MaterialType.Item, slot2, nil, , , {
			specificIcon = ManufactureConfig.instance:getBatchIconPath(slot1)
		})
		UISpriteSetMgr.instance:setCritterSprite(slot0._imgquality, RoomManufactureEnum.RareImageMap[slot0._itemIcon:getRare()])

		slot0._txtmanufactureItemName.text = ManufactureConfig.instance:getManufactureItemName(slot1)
	end

	slot0:refreshProgress()
end

function slot0.onOpen(slot0)
	slot0:onUpdateParam()
	slot0:setAccelerateItemList()
	slot0:everySecondCall()
	TaskDispatcher.runRepeat(slot0.everySecondCall, slot0, 1)
end

function slot0.setAccelerateItemList(slot0)
	gohelper.CreateObjList(slot0, slot0._onSetAccelerateItem, ItemConfig.instance:getItemListBySubType(ItemEnum.SubType.RoomManufactureAccelerateItem), slot0._gocontent, slot0._goaccelerateItem, RoomManufactureAccelerateItem)
end

function slot0._onSetAccelerateItem(slot0, slot1, slot2, slot3)
	slot1:setData(slot0._buildingMO.id, slot2)
end

function slot0.refreshTitle(slot0)
	slot1 = ""
	slot2 = nil

	if slot0._buildingMO then
		slot1 = slot0._buildingMO.config.useDesc
		slot2 = ManufactureConfig.instance:getManufactureBuildingIcon(slot0._buildingMO.buildingId)
	end

	slot0._txtbuildingName.text = slot1

	UISpriteSetMgr.instance:setRoomSprite(slot0._imagebuildingIcon, slot2)
end

function slot0.refreshProgress(slot0)
	if not slot0._buildingMO then
		return
	end

	if not (slot0._buildingMO:getManufactureState() == RoomManufactureEnum.ManufactureState.Running) then
		slot0:closeThis()
	end

	if not slot0._buildingMO:getSlotIdInProgress() or slot3 ~= slot0.curSlotId then
		slot0:closeThis()
	end

	slot4 = 0
	slot5 = slot0._buildingMO:getSlotProgress(slot0.curSlotId)

	if slot0._buildingMO:getSlotManufactureItemId(slot0.curSlotId) and slot6 ~= 0 then
		slot4 = ManufactureConfig.instance:getNeedTime(slot6) * (1 - slot5)
	end

	slot0._simagebarValue.fillAmount = slot5
	slot0._txttime.text = ManufactureController.instance:getFormatTime(slot4)
end

function slot0.everySecondCall(slot0)
	slot0:refreshProgress()
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0.everySecondCall, slot0)
	MessageBoxController.instance:dispatchEvent(MessageBoxEvent.CloseSpecificMessageBoxView, MessageBoxIdDefine.RoomManufactureAccelerateOver)
end

function slot0.onDestroyView(slot0)
end

return slot0
