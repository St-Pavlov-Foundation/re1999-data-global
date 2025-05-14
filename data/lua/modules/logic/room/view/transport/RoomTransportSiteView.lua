module("modules.logic.room.view.transport.RoomTransportSiteView", package.seeall)

local var_0_0 = class("RoomTransportSiteView", BaseView)

function var_0_0.onInitView(arg_1_0)
	arg_1_0._btnmaskable = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "#btn_maskable")
	arg_1_0._goBackBtns = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_BackBtns")
	arg_1_0._goleft = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_left")
	arg_1_0._golayoutSwitchBtns = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_left/#go_layoutSwitchBtns")
	arg_1_0._gositesitem = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_left/#go_layoutSwitchBtns/#go_sitesitem")
	arg_1_0._gocritterInfoItem = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_left/critterInfo/#go_critterInfoItem")
	arg_1_0._gohascritter = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_left/critterInfo/#go_critterInfoItem/#go_hascritter")
	arg_1_0._gocritterIcon = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_left/critterInfo/#go_critterInfoItem/#go_hascritter/#go_critterIcon")
	arg_1_0._gonocritter = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_left/critterInfo/#go_critterInfoItem/#go_nocritter")
	arg_1_0._gocritterselected = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_left/critterInfo/#go_critterInfoItem/#go_critterselected")
	arg_1_0._btncritterclick = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_content/#go_left/critterInfo/#go_critterInfoItem/#btn_critterclick")
	arg_1_0._goright = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_right")
	arg_1_0._btnhideui = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_content/#go_right/#btn_hideui")
	arg_1_0._gobuildinginfo = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_right/#go_buildinginfo")
	arg_1_0._gohasBuilding = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_right/#go_buildinginfo/#go_hasBuilding")
	arg_1_0._imagebuildingrare = gohelper.findChildImage(arg_1_0.viewGO, "go_content/#go_right/#go_buildinginfo/#go_hasBuilding/#image_buildingrare")
	arg_1_0._simagebuildingicon = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_content/#go_right/#go_buildinginfo/#go_hasBuilding/#simage_buildingicon")
	arg_1_0._txtbuildingname = gohelper.findChildText(arg_1_0.viewGO, "go_content/#go_right/#go_buildinginfo/#go_hasBuilding/#txt_buildingname")
	arg_1_0._txtbuildingbase = gohelper.findChildText(arg_1_0.viewGO, "go_content/#go_right/#go_buildinginfo/#go_hasBuilding/#txt_buildingbase")
	arg_1_0._gonobuilding = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_right/#go_buildinginfo/#go_nobuilding")
	arg_1_0._btnbuilding = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_content/#go_right/#go_buildinginfo/#btn_building")
	arg_1_0._btncamerastate = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_content/#go_right/#btn_camerastate")
	arg_1_0._gofirstperson = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_right/#btn_camerastate/#go_firstperson")
	arg_1_0._gothirdperson = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_right/#btn_camerastate/#go_thirdperson")
	arg_1_0._gobuildinglist = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_right/#go_buildinglist")
	arg_1_0._simagerightbg = gohelper.findChildSingleImage(arg_1_0.viewGO, "go_content/#go_right/#go_buildinglist/#simage_rightbg")
	arg_1_0._scrollbuilding = gohelper.findChildScrollRect(arg_1_0.viewGO, "go_content/#go_right/#go_buildinglist/#scroll_building")
	arg_1_0._scrollbuildingskin = gohelper.findChildScrollRect(arg_1_0.viewGO, "go_content/#go_right/#go_buildinglist/#scroll_buildingskin")
	arg_1_0._btnbuildingconfirm = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_content/#go_right/#go_buildinglist/#btn_buildingconfirm")
	arg_1_0._btncloseBuilding = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_content/#go_right/#go_buildinglist/#btn_closeBuilding")
	arg_1_0._gocritterlist = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_right/#go_critterlist")
	arg_1_0._btnmood = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_mood")
	arg_1_0._gomoodnormal = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_mood/#go_moodnormal")
	arg_1_0._gomoodselected = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_mood/#go_moodselected")
	arg_1_0._btnrare = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_rare")
	arg_1_0._goratenormal = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_rare/#go_ratenormal")
	arg_1_0._gorateselected = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_rare/#go_rateselected")
	arg_1_0._btnfilter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_filter")
	arg_1_0._gonotfilter = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_filter/#go_notfilter")
	arg_1_0._gofilter = gohelper.findChild(arg_1_0.viewGO, "go_content/#go_right/#go_critterlist/sort/#btn_filter/#go_filter")
	arg_1_0._scrollcritter = gohelper.findChildScrollRect(arg_1_0.viewGO, "go_content/#go_right/#go_critterlist/#scroll_critter")
	arg_1_0._btncloseCritter = gohelper.findChildButtonWithAudio(arg_1_0.viewGO, "go_content/#go_right/#go_critterlist/#btn_closeCritter")

	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnmaskable:AddClickListener(arg_2_0._btnmaskableOnClick, arg_2_0)
	arg_2_0._btncritterclick:AddClickListener(arg_2_0._btncritterclickOnClick, arg_2_0)
	arg_2_0._btnhideui:AddClickListener(arg_2_0._btnhideuiOnClick, arg_2_0)
	arg_2_0._btnbuilding:AddClickListener(arg_2_0._btnbuildingOnClick, arg_2_0)
	arg_2_0._btncamerastate:AddClickListener(arg_2_0._btncamerastateOnClick, arg_2_0)
	arg_2_0._btnbuildingconfirm:AddClickListener(arg_2_0._btnbuildingconfirmOnClick, arg_2_0)
	arg_2_0._btncloseBuilding:AddClickListener(arg_2_0._btncloseBuildingOnClick, arg_2_0)
	arg_2_0._btnmood:AddClickListener(arg_2_0._btnmoodOnClick, arg_2_0)
	arg_2_0._btnrare:AddClickListener(arg_2_0._btnrareOnClick, arg_2_0)
	arg_2_0._btnfilter:AddClickListener(arg_2_0._btnfilterOnClick, arg_2_0)
	arg_2_0._btncloseCritter:AddClickListener(arg_2_0._btncloseCritterOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnmaskable:RemoveClickListener()
	arg_3_0._btncritterclick:RemoveClickListener()
	arg_3_0._btnhideui:RemoveClickListener()
	arg_3_0._btnbuilding:RemoveClickListener()
	arg_3_0._btncamerastate:RemoveClickListener()
	arg_3_0._btnbuildingconfirm:RemoveClickListener()
	arg_3_0._btncloseBuilding:RemoveClickListener()
	arg_3_0._btnmood:RemoveClickListener()
	arg_3_0._btnrare:RemoveClickListener()
	arg_3_0._btnfilter:RemoveClickListener()
	arg_3_0._btncloseCritter:RemoveClickListener()
end

function var_0_0._btncloseBuildingOnClick(arg_4_0)
	arg_4_0:_setRightTabId(arg_4_0._RightTabId.BuildingInfo)
end

function var_0_0._btnmoodOnClick(arg_5_0)
	return
end

function var_0_0._btnrareOnClick(arg_6_0)
	return
end

function var_0_0._btnfilterOnClick(arg_7_0)
	return
end

function var_0_0._btncamerastateOnClick(arg_8_0)
	arg_8_0._isFirstPerson = arg_8_0._isFirstPerson ~= true

	RoomTransportController.instance:tweenCameraFocusSite(arg_8_0._selectSiteType, arg_8_0._isFirstPerson)
	arg_8_0:_refreshCameraStateUI()

	local var_8_0 = arg_8_0:getPathMOBySiteType(arg_8_0._selectSiteType)

	RoomStatController.instance:roomTransportCameraSwitch(arg_8_0._isFirstPerson, var_8_0, var_8_0)
end

function var_0_0._btnmaskableOnClick(arg_9_0)
	if not arg_9_0._curUIIsShow then
		arg_9_0:_setUIShow(true)

		return
	end
end

function var_0_0._btnswithItemOnClick(arg_10_0)
	return
end

function var_0_0._btnbuildingconfirmOnClick(arg_11_0)
	local var_11_0 = RoomTransportBuildingListModel.instance:getSelectMO()
	local var_11_1 = arg_11_0:getPathMOBySiteType(arg_11_0._selectSiteType)
	local var_11_2 = RoomTransportBuildingSkinListModel.instance:getSelectMO()

	if var_11_1 and var_11_0 then
		var_11_1.buildingUid = var_11_0.id
		var_11_1.buildingId = var_11_0.buildingId

		local var_11_3 = var_11_2 and var_11_2.id or 0

		var_11_1.buildingSkinId = var_11_3

		RoomRpc.instance:sendAllotVehicleRequest(var_11_1.id, var_11_0.id, var_11_3)

		arg_11_0._waitReplyRightTabId = arg_11_0._RightTabId.BuildingInfo
	else
		arg_11_0:_setRightTabId(arg_11_0._RightTabId.BuildingInfo)
	end
end

function var_0_0._btnhideuiOnClick(arg_12_0)
	arg_12_0:_setUIShow(false)
end

function var_0_0._btnbuildingOnClick(arg_13_0)
	arg_13_0:_setRightTabId(arg_13_0._RightTabId.BuildingList)

	local var_13_0 = arg_13_0:getPathMOBySiteType(arg_13_0._selectSiteType)

	if var_13_0 then
		arg_13_0:_setBuildingSelect(var_13_0.buildingId, var_13_0.buildingSkinId)
		RoomTransportBuildingListModel.instance:setSelect(var_13_0.buildingUid)
	end
end

function var_0_0._btncritterclickOnClick(arg_14_0)
	local var_14_0 = arg_14_0:getPathMOBySiteType(arg_14_0._selectSiteType)

	if var_14_0 then
		ManufactureController.instance:clickTransportCritterSlotItem(var_14_0.id)
	end
end

function var_0_0._btncloseCritterOnClick(arg_15_0)
	arg_15_0:_setRightTabId(arg_15_0._RightTabId.BuildingInfo)
end

function var_0_0._editableInitView(arg_16_0)
	gohelper.setActive(arg_16_0._gocritterselected, false)

	arg_16_0._goAddAnim = gohelper.findChild(arg_16_0._gohascritter, "#add")
	arg_16_0._gocontent = gohelper.findChild(arg_16_0.viewGO, "go_content")
	arg_16_0._RightTabId = {
		CritterList = 2,
		BuildingInfo = 3,
		BuildingList = 1
	}

	arg_16_0:_setRightTabId(arg_16_0._RightTabId.BuildingInfo)
	arg_16_0:_initSiteItemList()
end

function var_0_0.onUpdateParam(arg_17_0)
	return
end

function var_0_0.onOpen(arg_18_0)
	RoomStatController.instance:startOpenTransportSiteView()

	arg_18_0._selectSiteType = arg_18_0.viewParam.siteType

	local var_18_0 = arg_18_0:getPathMOBySiteType(arg_18_0._selectSiteType)

	arg_18_0._addAnimCritterUid = var_18_0 and var_18_0.critterUid or 0
	arg_18_0._isFirstPerson = false

	if arg_18_0.viewContainer then
		arg_18_0:addEventCb(arg_18_0.viewContainer, RoomEvent.TransportSiteSelect, arg_18_0._onSelectSiteItem, arg_18_0)
		arg_18_0:addEventCb(arg_18_0.viewContainer, RoomEvent.TransportCritterSelect, arg_18_0._onSelectCritterItem, arg_18_0)
		arg_18_0:addEventCb(arg_18_0.viewContainer, RoomEvent.TransportBuildingSelect, arg_18_0._onSelectBuildingItem, arg_18_0)
		arg_18_0:addEventCb(arg_18_0.viewContainer, RoomEvent.TransportBuildingSkinSelect, arg_18_0._onSelectBuildingSkinItem, arg_18_0)
	end

	arg_18_0:addEventCb(RoomMapController.instance, RoomEvent.TransportCritterChanged, arg_18_0._refreshUI, arg_18_0)
	arg_18_0:addEventCb(RoomMapController.instance, RoomEvent.TransportBuildingChanged, arg_18_0._refreshUI, arg_18_0)
	arg_18_0:addEventCb(RoomMapController.instance, RoomEvent.ShowUI, arg_18_0._onShowUI, arg_18_0)
	arg_18_0:addEventCb(RoomMapController.instance, RoomEvent.HideUI, arg_18_0._onHideUI, arg_18_0)
	arg_18_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_18_0._onOpenCloseView, arg_18_0)
	arg_18_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_18_0._onOpenCloseView, arg_18_0)
	arg_18_0:addEventCb(RoomMapController.instance, RoomEvent.NewBuildingPush, arg_18_0._newBuildingPush, arg_18_0)
	arg_18_0:addEventCb(BackpackController.instance, BackpackEvent.UpdateItemList, arg_18_0._refreshSkinList, arg_18_0)
	RoomTransportCritterListModel.instance:setCritterList()
	RoomTransportBuildingListModel.instance:setBuildingList()
	arg_18_0:_refreshUI()
	RoomMapController.instance:dispatchEvent(RoomEvent.TransportSiteViewShowChanged)
end

function var_0_0.onClose(arg_19_0)
	local var_19_0 = arg_19_0:getPathMOBySiteType(arg_19_0._selectSiteType)
	local var_19_1 = RoomCameraController.instance:getRoomScene()

	RoomCameraController.instance:resetCameraStateByKey(ViewName.RoomTransportSiteView)

	if var_19_1 then
		var_19_1.cameraFollow:setFollowTarget(nil)
	end

	RoomStatController.instance:closeTransportSiteView(var_19_0)
	RoomMapController.instance:dispatchEvent(RoomEvent.TransportSiteViewShowChanged)
end

function var_0_0.onDestroyView(arg_20_0)
	return
end

function var_0_0._onShowUI(arg_21_0)
	arg_21_0:_setUIShow(true)
end

function var_0_0._onHideUI(arg_22_0)
	arg_22_0:_setUIShow(false)
end

function var_0_0._onOpenCloseView(arg_23_0, arg_23_1)
	gohelper.setActive(arg_23_0._gocritterselected, ViewMgr.instance:isOpen(ViewName.RoomCritterListView))
end

function var_0_0._setUIShow(arg_24_0, arg_24_1)
	arg_24_0._curUIIsShow = arg_24_1

	gohelper.setActive(arg_24_0._gocontent, arg_24_1)
end

function var_0_0._newBuildingPush(arg_25_0)
	RoomTransportBuildingListModel.instance:setBuildingList()
end

function var_0_0._refreshSkinList(arg_26_0)
	local var_26_0 = RoomTransportBuildingListModel.instance:getSelect()

	RoomTransportBuildingSkinListModel.instance:setBuildingUid(var_26_0)
end

function var_0_0._refreshUI(arg_27_0)
	arg_27_0:_refreshCritterUI()
	arg_27_0:_refreshBuildingUI()
	arg_27_0:_applyReplyRightTabId()
	arg_27_0:_refreshCameraStateUI()
	arg_27_0:_refreshSiteItemUI()
end

function var_0_0._applyReplyRightTabId(arg_28_0)
	if arg_28_0._waitReplyRightTabId then
		arg_28_0:_setRightTabId(arg_28_0._waitReplyRightTabId)
	end
end

function var_0_0._refreshCameraStateUI(arg_29_0)
	gohelper.setActive(arg_29_0._gofirstperson, not arg_29_0._isFirstPerson)
	gohelper.setActive(arg_29_0._gothirdperson, arg_29_0._isFirstPerson)
end

function var_0_0._refreshCritterUI(arg_30_0)
	local var_30_0 = arg_30_0:getPathMOBySiteType(arg_30_0._selectSiteType)
	local var_30_1

	if var_30_0 then
		var_30_1 = CritterModel.instance:getCritterMOByUid(var_30_0.critterUid)
	end

	local var_30_2 = var_30_1 ~= nil

	if var_30_2 then
		if not arg_30_0.critterIcon then
			arg_30_0.critterIcon = IconMgr.instance:getCommonCritterIcon(arg_30_0._gocritterIcon)
		end

		arg_30_0.critterIcon:setMOValue(var_30_1:getId(), var_30_1:getDefineId())
		arg_30_0.critterIcon:showMood()
	end

	gohelper.setActive(arg_30_0._gohascritter, var_30_2)
	gohelper.setActive(arg_30_0._gonocritter, not var_30_2)

	local var_30_3 = var_30_0 and var_30_0.critterUid or 0

	if arg_30_0._addAnimCritterUid ~= var_30_3 then
		arg_30_0._addAnimCritterUid = var_30_3

		if var_30_2 then
			gohelper.setActive(arg_30_0._goAddAnim, false)
		end
	end

	gohelper.setActive(arg_30_0._goAddAnim, var_30_2)
end

function var_0_0._refreshBuildingUI(arg_31_0)
	local var_31_0 = arg_31_0:getPathMOBySiteType(arg_31_0._selectSiteType)
	local var_31_1

	if var_31_0 then
		var_31_1 = RoomConfig.instance:getBuildingConfig(var_31_0.buildingId)
	end

	local var_31_2 = var_31_1 ~= nil

	gohelper.setActive(arg_31_0._gohasBuilding, var_31_2)
	gohelper.setActive(arg_31_0._gonobuilding, not var_31_2)

	if var_31_1 then
		arg_31_0._simagebuildingicon:LoadImage(ResUrl.getRoomImage("building/" .. var_31_1.icon))

		local var_31_3 = RoomBuildingEnum.RareFrame[var_31_1.rare] or RoomBuildingEnum.RareFrame[1]

		UISpriteSetMgr.instance:setRoomSprite(arg_31_0._imagebuildingrare, var_31_3)

		arg_31_0._txtbuildingname.text = var_31_1.name
		arg_31_0._txtbuildingbase.text = var_31_1.useDesc
	end

	arg_31_0.viewContainer:setUseBuildingUid(var_31_0 and var_31_0.buildingUid)
end

function var_0_0._setRightTabId(arg_32_0, arg_32_1)
	arg_32_0._waitReplyRightTabId = nil

	if arg_32_0._lastRightTabId ~= arg_32_1 then
		arg_32_0._lastRightTabId = arg_32_1

		gohelper.setActive(arg_32_0._gobuildinginfo, arg_32_1 == arg_32_0._RightTabId.BuildingInfo)
		gohelper.setActive(arg_32_0._gobuildinglist, arg_32_1 == arg_32_0._RightTabId.BuildingList)
		gohelper.setActive(arg_32_0._gocritterlist, arg_32_1 == arg_32_0._RightTabId.CritterList)
	end
end

function var_0_0._onSelectSiteItem(arg_33_0, arg_33_1)
	if not arg_33_1 or arg_33_1.buildingType == arg_33_0._selectSiteType then
		return
	end

	local var_33_0 = arg_33_0:getPathMOBySiteType(arg_33_0._selectSiteType)

	arg_33_0._selectSiteType = arg_33_1.buildingType

	local var_33_1 = arg_33_0:getPathMOBySiteType(arg_33_0._selectSiteType)

	arg_33_0._addAnimCritterUid = var_33_1 and var_33_1.critterUid or 0

	RoomTransportController.instance:tweenCameraFocusSite(arg_33_0._selectSiteType, arg_33_0._isFirstPerson)
	arg_33_0:_refreshUI()
	RoomStatController.instance:roomTransportCameraSwitch(arg_33_0._isFirstPerson, var_33_0, var_33_1)

	if ViewMgr.instance:isOpen(ViewName.RoomCritterListView) then
		ViewMgr.instance:closeView(ViewName.RoomCritterListView)
	end
end

function var_0_0._onSelectCritterItem(arg_34_0, arg_34_1)
	if not arg_34_1 then
		return
	end

	local var_34_0 = arg_34_0:getPathMOBySiteType(arg_34_0._selectSiteType)

	RoomRpc.instance:sendAllotCritterRequestt(var_34_0.id, arg_34_1.id)

	arg_34_0._waitReplyRightTabId = arg_34_0._RightTabId.BuildingInfo
end

function var_0_0._onSelectBuildingItem(arg_35_0, arg_35_1)
	if arg_35_1.isNeedToBuy then
		if RoomBuildingEnum.TransportBuyTosatDic[arg_35_1.buildingId] then
			GameFacade.showToast(RoomBuildingEnum.TransportBuyTosatDic[arg_35_1.buildingId])

			return
		end

		GameFacade.showMessageBox(MessageBoxIdDefine.RoomTransportBuildingSkinShopBuy, MsgBoxEnum.BoxType.Yes_No, arg_35_0._yseGoToShop, nil, nil, arg_35_0, nil, nil)

		return
	end

	RoomTransportBuildingListModel.instance:setSelect(arg_35_1.id)

	local var_35_0 = arg_35_0:getPathMOByBuildingUid(arg_35_1.id)
	local var_35_1 = 0

	var_35_1 = var_35_0 and RoomTransportBuildingSkinListModel.instance:getById(var_35_0.buildingSkinId) and var_35_0.buildingSkinId or var_35_1

	arg_35_0:_setBuildingSelect(arg_35_1.buildingId, var_35_1)
end

function var_0_0._setBuildingSelect(arg_36_0, arg_36_1, arg_36_2)
	RoomTransportBuildingSkinListModel.instance:setBuildingId(arg_36_1)

	local var_36_0 = RoomTransportBuildingSkinListModel.instance:getCount()

	gohelper.setActive(arg_36_0._scrollbuildingskin, var_36_0 > 0)

	local var_36_1 = RoomTransportBuildingSkinListModel.instance:getById(arg_36_2)

	RoomTransportBuildingSkinListModel.instance:setSelect(var_36_1.id or 0)
end

function var_0_0._onSelectBuildingSkinItem(arg_37_0, arg_37_1)
	if arg_37_1 and not arg_37_1.isLock then
		RoomTransportBuildingSkinListModel.instance:setSelect(arg_37_1.id)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomTransportBuildingSkinShopBuy, MsgBoxEnum.BoxType.Yes_No, arg_37_0._yseGoToShop, nil, nil, arg_37_0, nil, nil)
	end
end

function var_0_0._yseGoToShop(arg_38_0)
	GameFacade.jump(JumpEnum.JumpId.RoomStoreTabFluff)
end

function var_0_0._initSiteItemList(arg_39_0)
	arg_39_0._dataList = arg_39_0:getPathDataList()
	arg_39_0._siteItemCompList = {}

	local var_39_0 = arg_39_0._golayoutSwitchBtns
	local var_39_1 = arg_39_0._gositesitem

	gohelper.CreateObjList(arg_39_0, arg_39_0._siteItemShow, arg_39_0._dataList, var_39_0, var_39_1, RoomTransportSiteItem)
end

function var_0_0._siteItemShow(arg_40_0, arg_40_1, arg_40_2, arg_40_3)
	arg_40_1:onUpdateMO(arg_40_2)

	if not arg_40_1._view then
		arg_40_1._view = arg_40_0
	end

	table.insert(arg_40_0._siteItemCompList, arg_40_1)
end

function var_0_0._refreshSiteItemUI(arg_41_0)
	if arg_41_0._siteItemCompList then
		for iter_41_0, iter_41_1 in ipairs(arg_41_0._siteItemCompList) do
			local var_41_0 = iter_41_1:getDataMO()

			iter_41_1:onSelect(var_41_0 and var_41_0.buildingType == arg_41_0._selectSiteType)
			iter_41_1:refreshUI()
		end
	end
end

function var_0_0.getPathMOBySiteType(arg_42_0, arg_42_1)
	local var_42_0, var_42_1 = RoomTransportHelper.getSiteFromToByType(arg_42_1)

	return RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(var_42_0, var_42_1)
end

function var_0_0.getPathMOByBuildingUid(arg_43_0, arg_43_1)
	local var_43_0 = RoomMapTransportPathModel.instance:getTransportPathMOList()

	for iter_43_0 = 1, #var_43_0 do
		local var_43_1 = var_43_0[iter_43_0]

		if var_43_1 and var_43_1.buildingUid == arg_43_1 then
			return var_43_1
		end
	end
end

function var_0_0.getPathDataList(arg_44_0)
	local var_44_0 = RoomTransportHelper.getPathBuildingTypesList()
	local var_44_1 = {}

	for iter_44_0, iter_44_1 in ipairs(var_44_0) do
		local var_44_2 = iter_44_1[1]
		local var_44_3 = iter_44_1[2]
		local var_44_4 = RoomMapTransportPathModel.instance:getTransportPathMOBy2Type(var_44_2, var_44_3)

		if var_44_4 then
			local var_44_5 = {
				buildingType = var_44_2,
				fromType = var_44_2,
				toType = var_44_3,
				pathId = var_44_4.id
			}

			table.insert(var_44_1, var_44_5)
		end
	end

	return var_44_1
end

return var_0_0
