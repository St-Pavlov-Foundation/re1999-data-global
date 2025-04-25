module("modules.logic.room.view.manufacture.RoomManufactureBuildingDetailBanner", package.seeall)

slot0 = class("RoomManufactureBuildingDetailBanner", BaseView)

function slot0.onInitView(slot0)
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "#go_content")
	slot0._btndetail = gohelper.findChildButtonWithAudio(slot0.viewGO, "#go_content/#btn_detail")
	slot0._scrollbase = gohelper.findChildScrollRect(slot0.viewGO, "#go_content/#scroll_base")
	slot0._gobaseLayer = gohelper.findChild(slot0.viewGO, "#go_content/#scroll_base/viewport/content/#go_baseLayer")
	slot0._gobaseitem = gohelper.findChild(slot0.viewGO, "#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem/#txt_name")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem/#txt_name/#image_icon")
	slot0._txtratio = gohelper.findChildText(slot0.viewGO, "#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem/#txt_ratio")
	slot0._goitemLayer = gohelper.findChild(slot0.viewGO, "#go_content/#scroll_base/viewport/content/#go_itemLayer")
	slot0._txtadd = gohelper.findChildText(slot0.viewGO, "#go_content/#scroll_base/viewport/content/#go_itemLayer/#txt_add")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "#go_content/#scroll_base/viewport/content/#go_itemLayer/#go_item")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btndetail:AddClickListener(slot0._btndetailOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btndetail:RemoveClickListener()
end

function slot0._btndetailOnClick(slot0)
	slot0:_setDetailSelect(ManufactureController.instance:openRoomManufactureBuildingDetailView(slot0._buildingUid))
end

function slot0._editableInitView(slot0)
	slot0._gounselectdetail = gohelper.findChild(slot0.viewGO, "#go_content/#btn_detail/unselect")
	slot0._goselectdetail = gohelper.findChild(slot0.viewGO, "#go_content/#btn_detail/select")
	slot0._baseAttrTypeList = {
		CritterEnum.AttributeType.Efficiency,
		CritterEnum.AttributeType.Lucky
	}
	slot0._attrItemCompList = {}
	slot0._itemTbList = {}

	gohelper.setActive(slot0._gobaseitem, false)
	gohelper.setActive(slot0._goitem, false)
	slot0:_setDetailSelect(false)
end

function slot0.onUpdateParam(slot0)
	slot0:_startRefreshTask()
	slot0:_refreshUI()
end

function slot0.onOpen(slot0)
	slot0:addEventCb(RoomController.instance, RoomEvent.ManufactureGuideTweenFinish, slot0._startRefreshTask, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureInfoUpdate, slot0._startRefreshTask, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.TradeLevelChange, slot0._startRefreshTask, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingInfoChange, slot0._startRefreshTask, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ChangeSelectedCritterSlotItem, slot0._startRefreshTask, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureReadNewFormula, slot0._startRefreshTask, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.BuildingLevelUpPush, slot0._startRefreshTask, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterUpdateAttrPreview, slot0._startRefreshTask, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.OnCloseManufactureBuildingDetailView, slot0._onCloseDetatilView, slot0)
	slot0:_startRefreshTask()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0:_stopRefreshTask()
end

function slot0._startRefreshTask(slot0)
	if not slot0._hasWaitRefreshTask then
		slot0._hasWaitRefreshTask = true

		TaskDispatcher.runDelay(slot0._onRunRefreshTask, slot0, 0.1)
	end
end

function slot0._stopRefreshTask(slot0)
	slot0._hasWaitRefreshTask = false

	TaskDispatcher.cancelTask(slot0._onRunRefreshTask, slot0)
end

function slot0._onRunRefreshTask(slot0)
	slot0:_updateParam()
	slot0:_refreshAttr()
	slot0:_refreshItem()

	if not slot0._isSendCritterRequest and slot0._buildingType then
		slot0._isSendCritterRequest = true

		CritterController.instance:sendBuildManufacturAttrByBtype(slot0._buildingType)
	end

	slot0._hasWaitRefreshTask = false
end

function slot0._onCloseDetatilView(slot0)
	slot0:_setDetailSelect(false)
end

function slot0.getViewBuilding(slot0)
	slot1, slot2 = slot0.viewContainer:getContainerViewBuilding()

	return slot1, slot2
end

function slot0._updateParam(slot0)
	slot0._buildingUid, slot0._buildingMO = slot0:getViewBuilding()
	slot0._buildingType = slot0.viewParam.buildingType
	slot0._builidngCfg = slot0._buildingMO and slot0._buildingMO.config
	slot0._buildingType = slot0._builidngCfg and slot0._builidngCfg.buildingType
	slot0._buildingId = slot0._builidngCfg and slot0._builidngCfg.buildingId
	slot0._attrInfoMOList = {}
	slot0._critterMOList = CritterHelper.getWorkCritterMOListByBuid(slot0._buildingUid)
	slot0._critterUidList = {}

	for slot4, slot5 in ipairs(slot0._critterMOList) do
		table.insert(slot0._critterUidList, slot5.id)
	end

	for slot4, slot5 in ipairs(slot0._baseAttrTypeList) do
		table.insert(slot0._attrInfoMOList, CritterHelper.sumArrtInfoMOByAttrId(slot5, slot0._critterMOList))
	end

	slot0._manufactureItemIdList = ManufactureHelper.findLuckyItemIdListByBUid(slot0._buildingUid)

	gohelper.setActive(slot0._btndetail, #slot0._critterUidList > 0)
end

function slot0._refreshUI(slot0)
	slot0:_refreshAttr()
	slot0:_refreshItem()
end

function slot0._setDetailSelect(slot0, slot1)
	gohelper.setActive(slot0._goselectdetail, slot1)
	gohelper.setActive(slot0._gounselectdetail, not slot1)
end

function slot0._refreshAttr(slot0)
	for slot5, slot6 in ipairs(slot0._attrInfoMOList) do
		if not slot0._attrItemCompList[slot5] then
			table.insert(slot0._attrItemCompList, MonoHelper.addNoUpdateLuaComOnceToGo(gohelper.clone(slot0._gobaseitem, slot0._gobaseLayer), RoomCritterDetailAttrItem))
		end

		slot9 = CritterHelper.formatAttrValue(slot6.attributeId, CritterHelper.sumPreViewAttrValue(slot6.attributeId, slot0._critterUidList, slot0._buildingId, false))

		slot7:onRefreshMo(slot6, slot5, slot9, slot9, slot6:getName())
	end

	for slot6 = 1, #slot0._attrItemCompList do
		gohelper.setActive(slot0._attrItemCompList[slot6].viewGO, slot6 <= #slot1)
	end
end

function slot0._refreshItem(slot0)
	slot2 = CritterHelper.sumPreViewAttrValue(CritterEnum.AttributeType.Efficiency, slot0._critterUidList, slot0._buildingId, false) > 100

	for slot6, slot7 in ipairs(slot0._manufactureItemIdList) do
		if not slot0._itemTbList[slot6] then
			slot8 = slot0:getUserDataTb_()

			table.insert(slot0._itemTbList, slot8)

			slot9 = gohelper.cloneInPlace(slot0._goitem)
			slot8.go = slot9
			slot8.image_quality = gohelper.findChildImage(slot9, "image_quality")
			slot8.go_icon = gohelper.findChild(slot9, "go_icon")
			slot8.go_up = gohelper.findChild(slot9, "go_up")
			slot8.itemIcon = IconMgr.instance:getCommonItemIcon(slot8.go_icon)

			slot8.itemIcon:isShowQuality(false)
		end

		slot8.itemIcon:setMOValue(MaterialEnum.MaterialType.Item, slot7, nil, , )
		UISpriteSetMgr.instance:setCritterSprite(slot8.image_quality, RoomManufactureEnum.RareImageMap[slot8.itemIcon:getRare()])
		gohelper.setActive(slot8.go_up, slot2)
	end

	slot3 = #slot0._manufactureItemIdList

	for slot7 = 1, #slot0._itemTbList do
		gohelper.setActive(slot0._itemTbList[slot7].go, slot7 <= slot3)
	end

	slot0._txtadd.text = luaLang(slot3 < 1 and "room_manufacture_detail_no_item" or "room_manufacture_detail_item_title")
end

slot0.prefabPath = "ui/viewres/room/manufacture/roommanufacturebuildingdetailbanner.prefab"

return slot0
