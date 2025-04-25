module("modules.logic.room.view.manufacture.RoomManufactureBuildingDetailView", package.seeall)

slot0 = class("RoomManufactureBuildingDetailView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnclosFull = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_closFull")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "root/#go_content")
	slot0._imagebuildingIcon = gohelper.findChildImage(slot0.viewGO, "root/#go_content/#image_buildingIcon")
	slot0._txtbuildingName = gohelper.findChildText(slot0.viewGO, "root/#go_content/#txt_buildingName")
	slot0._scrollbase = gohelper.findChildScrollRect(slot0.viewGO, "root/#go_content/#scroll_base")
	slot0._gobaseLayer = gohelper.findChild(slot0.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_baseLayer")
	slot0._gobaseitem = gohelper.findChild(slot0.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem")
	slot0._txtname = gohelper.findChildText(slot0.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem/#txt_name")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem/#txt_name/#image_icon")
	slot0._txtratio = gohelper.findChildText(slot0.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_baseLayer/#go_baseitem/#txt_ratio")
	slot0._goitemLayer = gohelper.findChild(slot0.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_itemLayer")
	slot0._goitem = gohelper.findChild(slot0.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_itemLayer/#go_item")
	slot0._gocritterLayer = gohelper.findChild(slot0.viewGO, "root/#go_content/#scroll_base/viewport/content/#go_critterLayer")
	slot0._btnclose = gohelper.findChildButtonWithAudio(slot0.viewGO, "root/#go_content/#btn_close")
	slot0._gotopleft = gohelper.findChild(slot0.viewGO, "#go_topleft")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnclosFull:AddClickListener(slot0._btnclosFullOnClick, slot0)
	slot0._btnclose:AddClickListener(slot0._btncloseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnclosFull:RemoveClickListener()
	slot0._btnclose:RemoveClickListener()
end

function slot0._btnclosFullOnClick(slot0)
	slot0:closeThis()
end

function slot0._btncloseOnClick(slot0)
	slot0:closeThis()
end

function slot0._editableInitView(slot0)
	slot0._baseAttrTypeList = {
		CritterEnum.AttributeType.Efficiency,
		CritterEnum.AttributeType.Lucky
	}
	slot0._attrItemCompList = {}
	slot0._critterDetailCompList = {}
	slot0._itemTbList = {}

	gohelper.setActive(slot0._gobaseitem, false)
	gohelper.setActive(slot0._goitem, false)

	slot0._animator = slot0.viewGO:GetComponent(RoomEnum.ComponentType.Animator)
	slot0._goroot = gohelper.findChild(slot0.viewGO, "root")
end

function slot0.onUpdateParam(slot0)
	slot0:_updateParam()
	slot0:_refreshUI()
end

function slot0.onOpen(slot0)
	slot1 = slot0.viewParam and slot0.viewParam.showIsRight

	slot0:addEventCb(CritterController.instance, CritterEvent.CritterUpdateAttrPreview, slot0._onAttrPreviewUpdate, slot0)
	slot0:_updateParam()
	slot0:_refreshUI()

	if slot0._builidngCfg and slot0._critterUidList and #slot0._critterUidList > 0 then
		CritterRpc.instance:sendGetRealCritterAttributeRequest(slot0._builidngCfg.id, slot0._critterUidList, false)
	end

	if slot0._animator then
		slot0._animator:Play(slot1 and "open_right" or "open_left")
	end

	if ViewMgr.instance:isOpen(ViewName.RoomOverView) then
		slot2 = slot0._goroot.transform

		recthelper.setHeight(slot2, recthelper.getHeight(slot0.viewGO.transform))
		recthelper.setAnchor(slot2, 0, 0)
	end
end

function slot0.onClose(slot0)
	ManufactureController.instance:dispatchEvent(ManufactureEvent.OnCloseManufactureBuildingDetailView)
end

function slot0.onDestroyView(slot0)
	for slot4 = 1, #slot0._attrItemCompList do
		slot0._attrItemCompList[slot4]:onDestroy()
	end

	for slot4 = 1, #slot0._critterDetailCompList do
		slot0._critterDetailCompList[slot4]:onDestroy()
	end
end

function slot0._onAttrPreviewUpdate(slot0, slot1)
	slot2 = false

	for slot6, slot7 in ipairs(slot0._critterMOList) do
		if slot7.id and slot1[slot8] then
			slot2 = true

			break
		end
	end

	if slot2 then
		slot0:_updateParam()
		slot0:_refreshUI()
	end
end

function slot0._updateParam(slot0)
	slot0._buildingType = slot0.viewParam.buildingType
	slot0._buildingUid = slot0.viewParam.buildingUid
	slot0._buildingMO = slot0.viewParam.buildingMO
	slot0._builidngCfg = slot0._buildingMO and slot0._buildingMO.config
	slot0._buildingId = slot0._builidngCfg and slot0._builidngCfg.buildingId
	slot0._attrInfoMOList = {}
	slot0._critterMOList = CritterHelper.getWorkCritterMOListByBuid(slot0._buildingUid)
	slot0._critterUidList = {}

	for slot4, slot5 in ipairs(slot0._critterMOList) do
		table.insert(slot0._critterUidList, slot5.id)
	end

	for slot4, slot5 in ipairs(slot0._baseAttrTypeList) do
		table.insert(slot0._attrInfoMOList, slot0:_getArrtInfoMOByType(slot5))
	end

	slot0._manufactureItemIdList = ManufactureHelper.findLuckyItemIdListByBUid(slot0._buildingUid)
end

function slot0._getArrtInfoMOByType(slot0, slot1)
	return CritterHelper.sumArrtInfoMOByAttrId(slot1, slot0._critterMOList)
end

function slot0._refreshUI(slot0)
	slot0._txtbuildingName.text = slot0._builidngCfg and slot0._builidngCfg.name or ""

	if slot0._builidngCfg then
		slot3 = nil

		UISpriteSetMgr.instance:setRoomSprite(slot0._imagebuildingIcon, (not RoomBuildingEnum.BuildingArea[slot0._builidngCfg.buildingType] or ManufactureConfig.instance:getManufactureBuildingIcon(slot0._builidngCfg.id)) and RoomConfig.instance:getBuildingTypeIcon(slot1))
	end

	slot0:_refreshAttr()
	slot0:_refreshCritter()
	slot0:_refreshItem()
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

function slot0._refreshCritter(slot0)
	for slot5, slot6 in ipairs(slot0._critterMOList) do
		if not slot0._critterDetailCompList[slot5] then
			table.insert(slot0._critterDetailCompList, MonoHelper.addNoUpdateLuaComOnceToGo(slot0.viewContainer:getResInst(RoomManufactureCritterDetail.prefabPath, slot0._gocritterLayer), RoomManufactureCritterDetail))
		end

		slot7:onUpdateMO(slot6)
	end

	for slot6 = 1, #slot0._critterDetailCompList do
		gohelper.setActive(slot0._critterDetailCompList[slot6].viewGO, slot6 <= #slot1)
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

	for slot7 = 1, #slot0._itemTbList do
		gohelper.setActive(slot0._itemTbList[slot7].go, slot7 <= #slot0._manufactureItemIdList)
	end
end

return slot0
