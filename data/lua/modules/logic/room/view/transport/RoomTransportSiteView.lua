module("modules.logic.room.view.transport.RoomTransportSiteView", package.seeall)

slot0 = class("RoomTransportSiteView", BaseView)

function slot0.onInitView(slot0)
	slot0._btnmaskable = gohelper.findChildButtonWithAudio(slot0.viewGO, "#btn_maskable")
	slot0._goBackBtns = gohelper.findChild(slot0.viewGO, "go_content/#go_BackBtns")
	slot0._goleft = gohelper.findChild(slot0.viewGO, "go_content/#go_left")
	slot0._golayoutSwitchBtns = gohelper.findChild(slot0.viewGO, "go_content/#go_left/#go_layoutSwitchBtns")
	slot0._gositesitem = gohelper.findChild(slot0.viewGO, "go_content/#go_left/#go_layoutSwitchBtns/#go_sitesitem")
	slot0._gocritterInfoItem = gohelper.findChild(slot0.viewGO, "go_content/#go_left/critterInfo/#go_critterInfoItem")
	slot0._gohascritter = gohelper.findChild(slot0.viewGO, "go_content/#go_left/critterInfo/#go_critterInfoItem/#go_hascritter")
	slot0._gocritterIcon = gohelper.findChild(slot0.viewGO, "go_content/#go_left/critterInfo/#go_critterInfoItem/#go_hascritter/#go_critterIcon")
	slot0._gonocritter = gohelper.findChild(slot0.viewGO, "go_content/#go_left/critterInfo/#go_critterInfoItem/#go_nocritter")
	slot0._gocritterselected = gohelper.findChild(slot0.viewGO, "go_content/#go_left/critterInfo/#go_critterInfoItem/#go_critterselected")
	slot0._btncritterclick = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_content/#go_left/critterInfo/#go_critterInfoItem/#btn_critterclick")
	slot0._goright = gohelper.findChild(slot0.viewGO, "go_content/#go_right")
	slot0._btnhideui = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_content/#go_right/#btn_hideui")
	slot0._gobuildinginfo = gohelper.findChild(slot0.viewGO, "go_content/#go_right/#go_buildinginfo")
	slot0._gohasBuilding = gohelper.findChild(slot0.viewGO, "go_content/#go_right/#go_buildinginfo/#go_hasBuilding")
	slot0._imagebuildingrare = gohelper.findChildImage(slot0.viewGO, "go_content/#go_right/#go_buildinginfo/#go_hasBuilding/#image_buildingrare")
	slot0._simagebuildingicon = gohelper.findChildSingleImage(slot0.viewGO, "go_content/#go_right/#go_buildinginfo/#go_hasBuilding/#simage_buildingicon")
	slot0._txtbuildingname = gohelper.findChildText(slot0.viewGO, "go_content/#go_right/#go_buildinginfo/#go_hasBuilding/#txt_buildingname")
	slot0._txtbuildingbase = gohelper.findChildText(slot0.viewGO, "go_content/#go_right/#go_buildinginfo/#go_hasBuilding/#txt_buildingbase")
	slot0._gonobuilding = gohelper.findChild(slot0.viewGO, "go_content/#go_right/#go_buildinginfo/#go_nobuilding")
	slot0._btnbuilding = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_content/#go_right/#go_buildinginfo/#btn_building")
	slot0._btncamerastate = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_content/#go_right/#btn_camerastate")
	slot0._gofirstperson = gohelper.findChild(slot0.viewGO, "go_content/#go_right/#btn_camerastate/#go_firstperson")
	slot0._gothirdperson = gohelper.findChild(slot0.viewGO, "go_content/#go_right/#btn_camerastate/#go_thirdperson")
	slot0._gobuildinglist = gohelper.findChild(slot0.viewGO, "go_content/#go_right/#go_buildinglist")
	slot0._simagerightbg = gohelper.findChildSingleImage(slot0.viewGO, "go_content/#go_right/#go_buildinglist/#simage_rightbg")
	slot0._scrollbuilding = gohelper.findChildScrollRect(slot0.viewGO, "go_content/#go_right/#go_buildinglist/#scroll_building")
	slot0._scrollbuildingskin = gohelper.findChildScrollRect(slot0.viewGO, "go_content/#go_right/#go_buildinglist/#scroll_buildingskin")
	slot0._btnbuildingconfirm = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_content/#go_right/#go_buildinglist/#btn_buildingconfirm")
	slot0._btncloseBuilding = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_content/#go_right/#go_buildinglist/#btn_closeBuilding")
	slot0._gocritterlist = gohelper.findChild(slot0.viewGO, "go_content/#go_right/#go_critterlist")
	slot0._btnmood = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_mood")
	slot0._gomoodnormal = gohelper.findChild(slot0.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_mood/#go_moodnormal")
	slot0._gomoodselected = gohelper.findChild(slot0.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_mood/#go_moodselected")
	slot0._btnrare = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_rare")
	slot0._goratenormal = gohelper.findChild(slot0.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_rare/#go_ratenormal")
	slot0._gorateselected = gohelper.findChild(slot0.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_rare/#go_rateselected")
	slot0._btnfilter = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_filter")
	slot0._gonotfilter = gohelper.findChild(slot0.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_filter/#go_notfilter")
	slot0._gofilter = gohelper.findChild(slot0.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_filter/#go_filter")
	slot0._scrollcritter = gohelper.findChildScrollRect(slot0.viewGO, "go_content/#go_right/#go_critterlist/#scroll_critter")
	slot0._btncloseCritter = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_content/#go_right/#go_critterlist/#btn_closeCritter")

	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnmaskable:AddClickListener(slot0._btnmaskableOnClick, slot0)
	slot0._btncritterclick:AddClickListener(slot0._btncritterclickOnClick, slot0)
	slot0._btnhideui:AddClickListener(slot0._btnhideuiOnClick, slot0)
	slot0._btnbuilding:AddClickListener(slot0._btnbuildingOnClick, slot0)
	slot0._btncamerastate:AddClickListener(slot0._btncamerastateOnClick, slot0)
	slot0._btnbuildingconfirm:AddClickListener(slot0._btnbuildingconfirmOnClick, slot0)
	slot0._btncloseBuilding:AddClickListener(slot0._btncloseBuildingOnClick, slot0)
	slot0._btnmood:AddClickListener(slot0._btnmoodOnClick, slot0)
	slot0._btnrare:AddClickListener(slot0._btnrareOnClick, slot0)
	slot0._btnfilter:AddClickListener(slot0._btnfilterOnClick, slot0)
	slot0._btncloseCritter:AddClickListener(slot0._btncloseCritterOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnmaskable:RemoveClickListener()
	slot0._btncritterclick:RemoveClickListener()
	slot0._btnhideui:RemoveClickListener()
	slot0._btnbuilding:RemoveClickListener()
	slot0._btncamerastate:RemoveClickListener()
	slot0._btnbuildingconfirm:RemoveClickListener()
	slot0._btncloseBuilding:RemoveClickListener()
	slot0._btnmood:RemoveClickListener()
	slot0._btnrare:RemoveClickListener()
	slot0._btnfilter:RemoveClickListener()
	slot0._btncloseCritter:RemoveClickListener()
end

function slot0._btncloseBuildingOnClick(slot0)
	slot0:_setRightTabId(slot0._RightTabId.BuildingInfo)
end

function slot0._btnmoodOnClick(slot0)
end

function slot0._btnrareOnClick(slot0)
end

function slot0._btnfilterOnClick(slot0)
end

function slot0._btncamerastateOnClick(slot0)
	slot0._isFirstPerson = slot0._isFirstPerson ~= true

	RoomTransportController.instance:tweenCameraFocusSite(slot0._selectSiteType, slot0._isFirstPerson)
	slot0:_refreshCameraStateUI()

	slot1 = slot0:getPathMOBySiteType(slot0._selectSiteType)

	RoomStatController.instance:roomTransportCameraSwitch(slot0._isFirstPerson, slot1, slot1)
end

function slot0._btnmaskableOnClick(slot0)
	if not slot0._curUIIsShow then
		slot0:_setUIShow(true)

		return
	end
end

function slot0._btnswithItemOnClick(slot0)
end

function slot0._btnbuildingconfirmOnClick(slot0)
	slot1 = RoomTransportBuildingListModel.instance:getSelectMO()
	slot3 = RoomTransportBuildingSkinListModel.instance:getSelectMO()

	if slot0:getPathMOBySiteType(slot0._selectSiteType) and slot1 then
		slot2.buildingUid = slot1.id
		slot2.buildingId = slot1.buildingId
		slot4 = slot3 and slot3.id or 0
		slot2.buildingSkinId = slot4

		RoomRpc.instance:sendAllotVehicleRequest(slot2.id, slot1.id, slot4)

		slot0._waitReplyRightTabId = slot0._RightTabId.BuildingInfo
	else
		slot0:_setRightTabId(slot0._RightTabId.BuildingInfo)
	end
end

function slot0._btnhideuiOnClick(slot0)
	slot0:_setUIShow(false)
end

function slot0._btnbuildingOnClick(slot0)
	slot0:_setRightTabId(slot0._RightTabId.BuildingList)

	if slot0:getPathMOBySiteType(slot0._selectSiteType) then
		slot0:_setBuildingSelect(slot1.buildingId, slot1.buildingSkinId)
		RoomTransportBuildingListModel.instance:setSelect(slot1.buildingUid)
	end
end

function slot0._btncritterclickOnClick(slot0)
	if slot0:getPathMOBySiteType(slot0._selectSiteType) then
		ManufactureController.instance:clickTransportCritterSlotItem(slot1.id)
	end
end

function slot0._btncloseCritterOnClick(slot0)
	slot0:_setRightTabId(slot0._RightTabId.BuildingInfo)
end

function slot0._editableInitView(slot0)
	gohelper.setActive(slot0._gocritterselected, false)

	slot0._goAddAnim = gohelper.findChild(slot0._gohascritter, "#add")
	slot0._gocontent = gohelper.findChild(slot0.viewGO, "go_content")
	slot0._RightTabId = {
		CritterList = 2,
		BuildingInfo = 3,
		BuildingList = 1
	}

	slot0:_setRightTabId(slot0._RightTabId.BuildingInfo)
	slot0:_initSiteItemList()
end

function slot0.onUpdateParam(slot0)
end

function slot0.onOpen(slot0)
	RoomStatController.instance:startOpenTransportSiteView()

	slot0._selectSiteType = slot0.viewParam.siteType
	slot0._addAnimCritterUid = slot0:getPathMOBySiteType(slot0._selectSiteType) and slot1.critterUid or 0
	slot0._isFirstPerson = false

	if slot0.viewContainer then
		slot0:addEventCb(slot0.viewContainer, RoomEvent.TransportSiteSelect, slot0._onSelectSiteItem, slot0)
		slot0:addEventCb(slot0.viewContainer, RoomEvent.TransportCritterSelect, slot0._onSelectCritterItem, slot0)
		slot0:addEventCb(slot0.viewContainer, RoomEvent.TransportBuildingSelect, slot0._onSelectBuildingItem, slot0)
		slot0:addEventCb(slot0.viewContainer, RoomEvent.TransportBuildingSkinSelect, slot0._onSelectBuildingSkinItem, slot0)
	end

	slot0:addEventCb(RoomMapController.instance, RoomEvent.TransportCritterChanged, slot0._refreshUI, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.TransportBuildingChanged, slot0._refreshUI, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ShowUI, slot0._onShowUI, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.HideUI, slot0._onHideUI, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenCloseView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onOpenCloseView, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.NewBuildingPush, slot0._newBuildingPush, slot0)
	slot0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, slot0._refreshSkinList, slot0)
	RoomTransportCritterListModel.instance:setCritterList()
	RoomTransportBuildingListModel.instance:setBuildingList()
	slot0:_refreshUI()
	RoomMapController.instance:dispatchEvent(RoomEvent.TransportSiteViewShowChanged)
end

function slot0.onClose(slot0)
	slot1 = slot0:getPathMOBySiteType(slot0._selectSiteType)

	RoomCameraController.instance:resetCameraStateByKey(ViewName.RoomTransportSiteView)

	if RoomCameraController.instance:getRoomScene() then
		slot2.cameraFollow:setFollowTarget(nil)
	end

	RoomStatController.instance:closeTransportSiteView(slot1)
	RoomMapController.instance:dispatchEvent(RoomEvent.TransportSiteViewShowChanged)
end

function slot0.onDestroyView(slot0)
end

function slot0._onShowUI(slot0)
	slot0:_setUIShow(true)
end

function slot0._onHideUI(slot0)
	slot0:_setUIShow(false)
end

function slot0._onOpenCloseView(slot0, slot1)
	gohelper.setActive(slot0._gocritterselected, ViewMgr.instance:isOpen(ViewName.RoomCritterListView))
end

function slot0._setUIShow(slot0, slot1)
	slot0._curUIIsShow = slot1

	gohelper.setActive(slot0._gocontent, slot1)
end

function slot0._newBuildingPush(slot0)
	RoomTransportBuildingListModel.instance:setBuildingList()
end

function slot0._refreshSkinList(slot0)
	RoomTransportBuildingSkinListModel.instance:setBuildingUid(RoomTransportBuildingListModel.instance:getSelect())
end

function slot0._refreshUI(slot0)
	slot0:_refreshCritterUI()
	slot0:_refreshBuildingUI()
	slot0:_applyReplyRightTabId()
	slot0:_refreshCameraStateUI()
	slot0:_refreshSiteItemUI()
end

function slot0._applyReplyRightTabId(slot0)
	if slot0._waitReplyRightTabId then
		slot0:_setRightTabId(slot0._waitReplyRightTabId)
	end
end

function slot0._refreshCameraStateUI(slot0)
	gohelper.setActive(slot0._gofirstperson, not slot0._isFirstPerson)
	gohelper.setActive(slot0._gothirdperson, slot0._isFirstPerson)
end

function slot0._refreshCritterUI(slot0)
	slot2 = nil

	if slot0:getPathMOBySiteType(slot0._selectSiteType) then
		slot2 = CritterModel.instance:getCritterMOByUid(slot1.critterUid)
	end

	if slot2 ~= nil then
		if not slot0.critterIcon then
			slot0.critterIcon = IconMgr.instance:getCommonCritterIcon(slot0._gocritterIcon)
		end

		slot0.critterIcon:setMOValue(slot2:getId(), slot2:getDefineId())
		slot0.critterIcon:showMood()
	end

	gohelper.setActive(slot0._gohascritter, slot3)
	gohelper.setActive(slot0._gonocritter, not slot3)

	if slot0._addAnimCritterUid ~= (slot1 and slot1.critterUid or 0) then
		slot0._addAnimCritterUid = slot4

		if slot3 then
			gohelper.setActive(slot0._goAddAnim, false)
		end
	end

	gohelper.setActive(slot0._goAddAnim, slot3)
end

function slot0._refreshBuildingUI(slot0)
	slot2 = nil

	if slot0:getPathMOBySiteType(slot0._selectSiteType) then
		slot2 = RoomConfig.instance:getBuildingConfig(slot1.buildingId)
	end

	slot3 = slot2 ~= nil

	gohelper.setActive(slot0._gohasBuilding, slot3)
	gohelper.setActive(slot0._gonobuilding, not slot3)

	if slot2 then
		slot0._simagebuildingicon:LoadImage(ResUrl.getRoomImage("building/" .. slot2.icon))
		UISpriteSetMgr.instance:setRoomSprite(slot0._imagebuildingrare, RoomBuildingEnum.RareFrame[slot2.rare] or RoomBuildingEnum.RareFrame[1])

		slot0._txtbuildingname.text = slot2.name
		slot0._txtbuildingbase.text = slot2.useDesc
	end

	slot0.viewContainer:setUseBuildingUid(slot1 and slot1.buildingUid)
end

function slot0._setRightTabId(slot0, slot1)
	slot0._waitReplyRightTabId = nil

	if slot0._lastRightTabId ~= slot1 then
		slot0._lastRightTabId = slot1

		gohelper.setActive(slot0._gobuildinginfo, slot1 == slot0._RightTabId.BuildingInfo)
		gohelper.setActive(slot0._gobuildinglist, slot1 == slot0._RightTabId.BuildingList)
		gohelper.setActive(slot0._gocritterlist, slot1 == slot0._RightTabId.CritterList)
	end
end

function slot0._onSelectSiteItem(slot0, slot1)
	if not slot1 or slot1.buildingType == slot0._selectSiteType then
		return
	end

	slot0._selectSiteType = slot1.buildingType
	slot0._addAnimCritterUid = slot0:getPathMOBySiteType(slot0._selectSiteType) and slot3.critterUid or 0

	RoomTransportController.instance:tweenCameraFocusSite(slot0._selectSiteType, slot0._isFirstPerson)
	slot0:_refreshUI()
	RoomStatController.instance:roomTransportCameraSwitch(slot0._isFirstPerson, slot0:getPathMOBySiteType(slot0._selectSiteType), slot3)

	if ViewMgr.instance:isOpen(ViewName.RoomCritterListView) then
		ViewMgr.instance:closeView(ViewName.RoomCritterListView)
	end
end

function slot0._onSelectCritterItem(slot0, slot1)
	if not slot1 then
		return
	end

	RoomRpc.instance:sendAllotCritterRequestt(slot0:getPathMOBySiteType(slot0._selectSiteType).id, slot1.id)

	slot0._waitReplyRightTabId = slot0._RightTabId.BuildingInfo
end

function slot0._onSelectBuildingItem(slot0, slot1)
	if slot1.isNeedToBuy then
		if RoomBuildingEnum.TransportBuyTosatDic[slot1.buildingId] then
			GameFacade.showToast(RoomBuildingEnum.TransportBuyTosatDic[slot1.buildingId])

			return
		end

		GameFacade.showMessageBox(MessageBoxIdDefine.RoomTransportBuildingSkinShopBuy, MsgBoxEnum.BoxType.Yes_No, slot0._yseGoToShop, nil, , slot0, nil, )

		return
	end

	RoomTransportBuildingListModel.instance:setSelect(slot1.id)

	if slot0:getPathMOByBuildingUid(slot1.id) and RoomTransportBuildingSkinListModel.instance:getById(slot2.buildingSkinId) then
		slot3 = slot2.buildingSkinId or 0
	end

	slot0:_setBuildingSelect(slot1.buildingId, slot3)
end

function slot0._setBuildingSelect(slot0, slot1, slot2)
	RoomTransportBuildingSkinListModel.instance:setBuildingId(slot1)
	gohelper.setActive(slot0._scrollbuildingskin, RoomTransportBuildingSkinListModel.instance:getCount() > 0)
	RoomTransportBuildingSkinListModel.instance:setSelect(RoomTransportBuildingSkinListModel.instance:getById(slot2).id or 0)
end

function slot0._onSelectBuildingSkinItem(slot0, slot1)
	if slot1 and not slot1.isLock then
		RoomTransportBuildingSkinListModel.instance:setSelect(slot1.id)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomTransportBuildingSkinShopBuy, MsgBoxEnum.BoxType.Yes_No, slot0._yseGoToShop, nil, , slot0, nil, )
	end
end

function slot0._yseGoToShop(slot0)
	GameFacade.jump(JumpEnum.JumpId.RoomStoreTabFluff)
end

function slot0._initSiteItemList(slot0)
	slot0._dataList = slot0:getPathDataList()
	slot0._siteItemCompList = {}

	gohelper.CreateObjList(slot0, slot0._siteItemShow, slot0._dataList, slot0._golayoutSwitchBtns, slot0._gositesitem, RoomTransportSiteItem)
end

function slot0._siteItemShow(slot0, slot1, slot2, slot3)
	slot1:onUpdateMO(slot2)

	if not slot1._view then
		slot1._view = slot0
	end

	table.insert(slot0._siteItemCompList, slot1)
end

function slot0._refreshSiteItemUI(slot0)
	if slot0._siteItemCompList then
		for slot4, slot5 in ipairs(slot0._siteItemCompList) do
			slot5:onSelect(slot5:getDataMO() and slot6.buildingType == slot0._selectSiteType)
			slot5:refreshUI()
		end
	end
end

function slot0.getPathMOBySiteType(slot0, slot1)
	slot2, slot3 = RoomTransportHelper.getSiteFromToByType(slot1)

	return RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(slot2, slot3)
end

function slot0.getPathMOByBuildingUid(slot0, slot1)
	for slot6 = 1, #RoomMapTransportPathModel.instance:getTransportPathMOList() do
		if slot2[slot6] and slot7.buildingUid == slot1 then
			return slot7
		end
	end
end

function slot0.getPathDataList(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(RoomTransportHelper.getPathBuildingTypesList()) do
		if RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(slot7[1], slot7[2]) then
			table.insert(slot2, {
				buildingType = slot8,
				fromType = slot8,
				toType = slot9,
				pathId = slot10.id
			})
		end
	end

	return slot2
end

return slot0
