module("modules.logic.room.view.RoomView", package.seeall)

slot0 = class("RoomView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btnRecord:AddClickListener(slot0._btnRecordOnClick, slot0)
	slot0._btnCritter:AddClickListener(slot0._btnCritterOnClick, slot0)
	slot0._btnOverview:AddClickListener(slot0._btnOverviewOnClick, slot0)
	slot0._btnTrade:AddClickListener(slot0._btnTradeOnClick, slot0)
	slot0._btnWarehouse:AddClickListener(slot0._btnWarehouseOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btnRecord:RemoveClickListener()
	slot0._btnCritter:RemoveClickListener()
	slot0._btnOverview:RemoveClickListener()
	slot0._btnTrade:RemoveClickListener()
	slot0._btnWarehouse:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._goreturnroot = gohelper.findChild(slot0.viewGO, "navigatebuttonscontainer")
	slot0._gonormalroot = gohelper.findChild(slot0.viewGO, "go_normalroot")
	slot0._simagemaskbg = gohelper.findChildSingleImage(slot0.viewGO, "go_normalroot/#simage_maskbg")
	slot0._simagemaskbg.spriteMeshType = UnityEngine.SpriteMeshType.Tight
	slot0._btnedit = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_edit")
	slot0._gobtncamera = gohelper.findChild(slot0.viewGO, "go_normalroot/btn_camera")
	slot0._btncharacter = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_character")
	slot0._btntracking = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_tracking")
	slot0._btndialog = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_dialog")
	slot0._btnhide = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_hide")
	slot0._btnstore = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_store")
	slot0._btnlayoutplan = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_layoutplan")
	slot0._btnlayoutcopy = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_copy")
	slot0._gobtnexpandManufacture = gohelper.findChild(slot0.viewGO, "go_normalroot/btn_expandManufacture")
	slot0._btnexpandManufacture = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_expandManufacture/btn")
	slot0._manufactureAnimator = gohelper.findChildComponent(slot0.viewGO, "go_normalroot/btn_expandManufacture", RoomEnum.ComponentType.Animator)
	slot0._goManufactureEntranceReddot = gohelper.findChild(slot0.viewGO, "go_normalroot/btn_expandManufacture/#go_reddot")
	slot0._btnRecord = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_expandManufacture/go_manuExpand/layout/btn_record")
	slot0._goRecordReddot = gohelper.findChild(slot0.viewGO, "go_normalroot/btn_expandManufacture/go_manuExpand/layout/btn_record/#go_reddot")
	slot0._btnCritter = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_expandManufacture/go_manuExpand/layout/btn_critter")
	slot0._goCritterReddot = gohelper.findChild(slot0.viewGO, "go_normalroot/btn_expandManufacture/go_manuExpand/layout/btn_critter/#go_reddot")
	slot0._btnOverview = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_expandManufacture/go_manuExpand/layout/btn_overview")
	slot0._goOverviewReddot = gohelper.findChild(slot0.viewGO, "go_normalroot/btn_expandManufacture/go_manuExpand/layout/btn_overview/#go_reddot")
	slot0._btnTrade = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_expandManufacture/go_manuExpand/layout/btn_trade")
	slot0._goTradeReddot = gohelper.findChild(slot0.viewGO, "go_normalroot/btn_expandManufacture/go_manuExpand/layout/btn_trade/#go_reddot")
	slot0._btnWarehouse = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_expandManufacture/go_manuExpand/layout/btn_warehouse")
	slot0._goWarehouseReddot = gohelper.findChild(slot0.viewGO, "go_normalroot/btn_expandManufacture/go_manuExpand/layout/btn_warehouse/#go_reddot")
	slot0._warehouseAnimator = slot0._btnWarehouse:GetComponent(typeof(UnityEngine.Animator))
	slot0._gobuildingreddot = gohelper.findChild(slot0.viewGO, "go_normalroot/btn_building/go_buildingreddot")
	slot0._goeditreddot = gohelper.findChild(slot0.viewGO, "go_normalroot/btn_edit/go_editreddot")
	slot0._blockoptab = gohelper.findChild(slot0.viewGO, "blockop_tab")
	slot0._golayoutplanUnlock = gohelper.findChild(slot0.viewGO, "go_normalroot/btn_layoutplan/icon")
	slot0._golayoutplanLock = gohelper.findChild(slot0.viewGO, "go_normalroot/btn_layoutplan/go_lock")
	slot0._golayoutcopyUnlock = gohelper.findChild(slot0.viewGO, "go_normalroot/btn_copy/icon")
	slot0._golayoutcopyLock = gohelper.findChild(slot0.viewGO, "go_normalroot/btn_copy/go_lock")
	slot0._gologtip = gohelper.findChild(slot0.viewGO, "go_normalroot/go_logtips")
	slot0._simagesticker = gohelper.findChildSingleImage(slot0.viewGO, "go_normalroot/go_logtips/#simage_stickers")
	slot0._txtlogdesc = gohelper.findChildText(slot0.viewGO, "go_normalroot/go_logtips/#scroll_des/viewport/content/#txt_Desc")
	slot0._btngoto = gohelper.findChildButton(slot0.viewGO, "go_normalroot/go_logtips/#btn_goto")

	slot0._btnedit:AddClickListener(slot0._btneditOnClick, slot0)
	slot0._btncharacter:AddClickListener(slot0._btncharacterOnClick, slot0)
	slot0._btntracking:AddClickListener(slot0._btntrackingOnClick, slot0)
	slot0._btndialog:AddClickListener(slot0._btndialogOnClick, slot0)
	slot0._btnhide:AddClickListener(slot0._btnhideOnClick, slot0)
	slot0._btnstore:AddClickListener(slot0._btnstoreOnClick, slot0)
	slot0._btnlayoutplan:AddClickListener(slot0._btnlayoutplanOnClick, slot0)
	slot0._btnlayoutcopy:AddClickListener(slot0._btnlayoutcopyOnClick, slot0)
	slot0._btnexpandManufacture:AddClickListener(slot0._btnexpandManufactureOnClick, slot0)
	slot0._btngoto:AddClickListener(slot0._openLogView, slot0)

	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._rootCanvasGroup = slot0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._canvasGroup = slot0._gonormalroot:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._layoutplanAnimator = gohelper.findChildComponent(slot0.viewGO, "go_normalroot/btn_layoutplan", typeof(UnityEngine.Animator))

	if RoomInventoryBlockModel.instance:openSelectOp() then
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "go_normalroot/go_inventory"), false)
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "go_normalroot/go_inventorytask"), false)
	end

	slot0._showHideViewNameDict = {
		[ViewName.RoomCharacterPlaceView] = true,
		[ViewName.RoomInitBuildingView] = true,
		[ViewName.RoomManufactureBuildingView] = true,
		[ViewName.RoomCritterBuildingView] = true,
		[ViewName.RoomTransportSiteView] = true,
		[ViewName.RoomInteractBuildingView] = true
	}
	slot0._showHideViewNameList = {}

	for slot4, slot5 in pairs(slot0._showHideViewNameDict) do
		table.insert(slot0._showHideViewNameList, slot4)
	end

	slot0:_updateNavigateButtonShow()
	gohelper.removeUIClickAudio(slot0._btncharacter.gameObject)
	gohelper.addUIClickAudio(slot0._btnlayoutplan.gameObject, AudioEnum.Room.play_ui_home_yield_open)

	slot0._PcBtnLocation = gohelper.findChild(slot0.viewGO, "go_normalroot/btn_tracking/#go_pcbtn")
	slot0._PcBuy = gohelper.findChild(slot0.viewGO, "go_normalroot/btn_store/#go_pcbtn")
	slot0._PcBtnLayout = gohelper.findChild(slot0.viewGO, "go_normalroot/btn_layoutplan/#go_pcbtn")
	slot0._PcBtnPlace = gohelper.findChild(slot0.viewGO, "go_normalroot/btn_character/#go_pcbtn")
	slot0._PcBtnEdit = gohelper.findChild(slot0.viewGO, "go_normalroot/btn_edit/#go_pcbtn")
	slot0._PcBtnHide = gohelper.findChild(slot0.viewGO, "go_normalroot/btn_hide/#go_pcbtn")

	slot0:_refreshLayoutPlan()
	slot0:showKeyTips()
end

function slot0._btneditOnClick(slot0)
	if RoomLayoutModel.instance:getById(RoomEnum.LayoutUsedPlanId) and slot1:isSharing() then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomEditShareLayoutPlan, MsgBoxEnum.BoxType.Yes_No, slot0._onEnterRoomEdit, nil, , slot0, nil, )

		return
	end

	slot0:_onEnterRoomEdit()
end

function slot0.showKeyTips(slot0)
	PCInputController.instance:showkeyTips(slot0._PcBtnLocation, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.guting)
	PCInputController.instance:showkeyTips(slot0._PcBuy, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.buy)
	PCInputController.instance:showkeyTips(slot0._PcBtnLayout, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.layout)
	PCInputController.instance:showkeyTips(slot0._PcBtnPlace, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.place)
	PCInputController.instance:showkeyTips(slot0._PcBtnEdit, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.edit)
	PCInputController.instance:showkeyTips(slot0._PcBtnHide, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.hide)
end

function slot0._onEnterRoomEdit(slot0)
	RoomController.instance:enterRoom(RoomEnum.GameMode.Edit)
end

function slot0._btncharacterOnClick(slot0)
	if RoomEnum.UseAStarPath and ZProj.AStarPathBridge.IsAStarInProgress() then
		slot0.MaxCheckAStarCount = 5
		slot0._checkAStarCount = 0

		TaskDispatcher.runRepeat(slot0._checkAStarFinish, slot0, 0.5, slot0.MaxCheckAStarCount)
		UIBlockMgr.instance:startBlock(UIBlockKey.RoomAStarScan)
		logNormal("astar扫描中，完成后再打开角色界面")
	else
		RoomCharacterController.instance:setCharacterListShow(true)
	end
end

function slot0._checkAStarFinish(slot0)
	slot0._checkAStarCount = slot0._checkAStarCount + 1

	if slot0.MaxCheckAStarCount <= slot0._checkAStarCount or not ZProj.AStarPathBridge.IsAStarInProgress() then
		logNormal("astar扫描完成，打开角色界面")
		TaskDispatcher.cancelTask(slot0._checkAStarFinish, slot0)
		UIBlockMgr.instance:endBlock(UIBlockKey.RoomAStarScan)
		RoomCharacterController.instance:setCharacterListShow(true)
	end
end

function slot0._btntrackingOnClick(slot0)
	slot1 = slot0._scene.camera:getCameraFocus()

	if slot0._scene.camera:getCameraState() == RoomEnum.CameraState.Overlook and math.abs(slot1.x) < 0.1 and math.abs(slot1.y) < 0.1 then
		GameFacade.showToast(ToastEnum.ClickRoomTracking)

		return
	end

	slot0._scene.camera:switchCameraState(RoomEnum.CameraState.Overlook, {
		focusX = 0,
		focusY = 0
	})
end

function slot0._btndialogOnClick(slot0)
	RoomCharacterController.instance:trynextDialogInteraction()
end

function slot0._btnhideOnClick(slot0)
	if RoomMapController.instance:isUIHide() then
		RoomMapController.instance:setUIHide(false)
	else
		RoomMapController.instance:setUIHide(true)
	end
end

function slot0._btnstoreOnClick(slot0)
	if StoreController.instance:checkAndOpenStoreView(StoreEnum.Room) then
		RoomMapController.instance:dispatchEvent(RoomEvent.BlockAtmosphereEffect)
	end
end

function slot0._btnlayoutplanOnClick(slot0)
	if RoomLayoutController.instance:openView() then
		RoomMapController.instance:dispatchEvent(RoomEvent.BlockAtmosphereEffect)
	end
end

function slot0._btnlayoutcopyOnClick(slot0)
	if RoomLayoutController.instance:isOpen(true) then
		RoomLayoutController.instance:openCopyView()
	end
end

function slot0._btnexpandManufactureOnClick(slot0)
	ManufactureModel.instance:setExpandManufactureBtn(not ManufactureModel.instance:getExpandManufactureBtn())
	slot0:_refreshManufactureExpand(true)
end

function slot0._btnRecordOnClick(slot0)
	ManufactureController.instance:openRoomRecordView()
end

function slot0._btnCritterOnClick(slot0)
	ManufactureController.instance:openCritterBuildingView()
end

function slot0._btnOverviewOnClick(slot0)
	ManufactureController.instance:openOverView()
end

function slot0._btnTradeOnClick(slot0)
	ManufactureController.instance:openRoomTradeView()
end

function slot0._btnWarehouseOnClick(slot0)
	ManufactureController.instance:openRoomBackpackView()
end

function slot0._show(slot0, slot1)
	if slot0:_isHasNeedHideView() then
		return
	end

	if slot0:_isCheckHideView(slot1) then
		slot0:_hideView()
	else
		slot0._animator:Play("show")
	end
end

function slot0._hide(slot0, slot1)
	if slot0:_isHasNeedHideView() then
		return
	end

	slot0._animator:Play("hide")
end

function slot0._resetYesCallback()
	RoomMapController.instance:resetRoom()
end

function slot0._confirmYesCallback()
	RoomMapController.instance:confirmRoom()
end

function slot0._revertYesCallback(slot0)
	RoomMapController.instance:revertRoom()
end

function slot0._listViewShowChanged(slot0)
	slot0:_refreshBtnShow()
end

function slot0._updateCharacterInteractionUI(slot0)
	slot0:_refreshBtnShow()
	slot0:_updateNavigateButtonShow()
end

function slot0._updateNavigateButtonShow(slot0, slot1)
	slot2 = RoomBuildingController.instance:isBuildingListShow()
	slot3 = RoomDebugController.instance:isDebugPlaceListShow()
	slot4 = RoomDebugController.instance:isDebugPackageListShow()
	slot5 = RoomDebugController.instance:isDebugBuildingListShow()
	slot6 = RoomMapBlockModel.instance:isBackMore()
	slot7 = RoomWaterReformModel.instance:isWaterReform()
	slot8 = RoomCharacterHelper.isInDialogInteraction()
	slot9 = RoomMapController.instance:isInRoomInitBuildingViewCamera()
	slot10 = RoomTransportController.instance:isTransportPathShow() or RoomTransportController.instance:isTransportSitShow()
	slot11 = ViewMgr.instance:isOpen(ViewName.RoomInteractBuildingView)
	slot12, slot13 = nil

	if slot1 and type(slot1) == "table" then
		slot12 = slot1.inCritterBuildingView or ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView)
		slot13 = slot1.inManufactureBuildingView or ViewMgr.instance:isOpen(ViewName.RoomManufactureBuildingView)
	else
		slot12 = ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView)
		slot13 = ViewMgr.instance:isOpen(ViewName.RoomManufactureBuildingView)
	end

	slot0.viewContainer:setNavigateButtonShow(not slot3 and not slot4 and not slot5 and not slot6 and not slot8 and not slot9 and not slot7 and not slot10 and not slot11 and not slot12 and not slot13)
end

function slot0._addBtnAudio(slot0)
	gohelper.addUIClickAudio(slot0._btnedit.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function slot0._refreshBtnShow(slot0)
	slot5 = RoomCharacterController.instance:isCharacterListShow()

	gohelper.setActive(slot0._simagemaskbg, not RoomController.instance:isEditMode())
	gohelper.setActive(slot0._btnedit.gameObject, RoomController.instance:isObMode() and not RoomCharacterHelper.isInDialogInteraction() and (not (RoomBuildingController.instance:isBuildingListShow() or RoomDebugController.instance:isDebugPlaceListShow() or RoomDebugController.instance:isDebugPackageListShow() or RoomDebugController.instance:isDebugBuildingListShow() or slot5) or slot5))

	if slot0._btnedit.gameObject.activeSelf then
		RedDotController.instance:addRedDot(slot0._goeditreddot, RedDotEnum.DotNode.RoomEditBtn)
	end

	gohelper.setActive(slot0._btnhide.gameObject, slot8 and not slot5 and not slot7)
	gohelper.setActive(slot0._btncharacter.gameObject, slot8 and not slot7 and (not slot6 or slot5))
	gohelper.setActive(slot0._gobtncamera, slot8 and not slot7 and slot6 and slot5 or RoomController.instance:isVisitMode() or RoomController.instance:isDebugMode())
	gohelper.setActive(slot0._btntracking.gameObject, slot8 and not slot7 and (not slot6 or slot5))
	gohelper.setActive(slot0._btndialog.gameObject, slot8 and slot7 and not slot6)
	gohelper.setActive(slot0._btnstore.gameObject, slot8 and not slot7 and (not slot6 or slot5))

	slot9 = not slot7 and slot8
	slot0._isShowLayoutplan = slot9 and not slot6

	gohelper.setActive(slot0._btnlayoutplan, slot9 and (not slot6 or slot5))

	slot0._isShowManufactureBtn = VersionValidator.instance:isInReviewing() or slot8 and not slot6 and not slot7 and not ViewMgr.instance:isOpen(ViewName.RoomInteractBuildingView)

	slot0:_checkManufactureUnlock()

	slot12 = RoomModel.instance:getVisitParam()

	gohelper.setActive(slot0._btnlayoutcopy, not RoomEnum.IsCloseLayouCopy and RoomController.instance:isVisitMode() and slot12 and slot12.userId and SocialModel.instance:isMyFriendByUserId(slot12.userId))

	if RoomController.instance:isDebugMode() then
		ViewMgr.instance:openView(ViewName.RoomDebugView)
	end

	if slot0._isShowLayoutplan then
		slot0:_layoutPlanUnLockAnim()
	end

	slot0:_refreshTradeBtn()
end

function slot0._switchScene(slot0)
	slot0._animator:Play("xiaoshi", 0, 0)
end

function slot0._onSelectBlockOpTab(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = false

	for slot6, slot7 in pairs(RoomEnum.RoomViewBlockOpMode) do
		if slot7 == slot1 then
			slot2 = true

			break
		end
	end

	if slot2 then
		slot0.viewContainer:selectBlockOpTab(slot1)
	end
end

function slot0.onOpen(slot0)
	slot0:_refreshBtnShow()
	slot0:_addBtnAudio()
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.BuildingListShowChanged, slot0._listViewShowChanged, slot0)
	slot0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPlaceListShowChanged, slot0._listViewShowChanged, slot0)
	slot0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPackageListShowChanged, slot0._listViewShowChanged, slot0)
	slot0:addEventCb(RoomDebugController.instance, RoomEvent.DebugBuildingListShowChanged, slot0._listViewShowChanged, slot0)
	slot0:addEventCb(RoomCharacterController.instance, RoomEvent.CharacterListShowChanged, slot0._listViewShowChanged, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.BackBlockShowChanged, slot0._listViewShowChanged, slot0)
	slot0:addEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, slot0._listViewShowChanged, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.InteractBuildingShowChanged, slot0._listViewShowChanged, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.BackBlockShowChanged, slot0._updateNavigateButtonShow, slot0)
	slot0:addEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, slot0._updateNavigateButtonShow, slot0)
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.RefreshNavigateButton, slot0._updateNavigateButtonShow, slot0)
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.BuildingListShowChanged, slot0._updateNavigateButtonShow, slot0)
	slot0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPlaceListShowChanged, slot0._updateNavigateButtonShow, slot0)
	slot0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPackageListShowChanged, slot0._updateNavigateButtonShow, slot0)
	slot0:addEventCb(RoomDebugController.instance, RoomEvent.DebugBuildingListShowChanged, slot0._updateNavigateButtonShow, slot0)
	slot0:addEventCb(RoomCharacterController.instance, RoomEvent.CharacterListShowChanged, slot0._updateNavigateButtonShow, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.TransportPathViewShowChanged, slot0._updateNavigateButtonShow, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.TransportSiteViewShowChanged, slot0._updateNavigateButtonShow, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.InteractBuildingShowChanged, slot0._updateNavigateButtonShow, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingViewChange, slot0._updateNavigateButtonShow, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingViewChange, slot0._updateNavigateButtonShow, slot0)
	slot0:addEventCb(RoomController.instance, RoomEvent.SwitchScene, slot0._switchScene, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, slot0._onOpenView, slot0)
	slot0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, slot0._onCloseView, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.WillOpenRoomInitBuildingView, slot0._willOpenRoomInitBuildingView, slot0)
	slot0:addEventCb(RoomCharacterController.instance, RoomEvent.UpdateCharacterInteractionUI, slot0._updateCharacterInteractionUI, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.ShowUI, slot0._show, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.HideUI, slot0._hide, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.UpdateRoomLevel, slot0._updateRoomLevel, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.SelectRoomViewBlockOpTab, slot0._onSelectBlockOpTab, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyHide, slot0._btnhideOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEdit, slot0._btneditOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyPlace, slot0._btncharacterOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.Notifylocate, slot0._btntrackingOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBuy, slot0._btnstoreOnClick, slot0)
	slot0:addEventCb(PCInputController.instance, PCInputEvent.NotifyLayout, slot0._btnlayoutplanOnClick, slot0)
	slot0:addEventCb(CritterController.instance, CritterEvent.onEnterCritterBuildingView, slot0._hideView, slot0)
	slot0:addEventCb(ManufactureController.instance, ManufactureEvent.OnEnterManufactureBuildingView, slot0._hideView, slot0)
	slot0:addEventCb(RoomController.instance, RoomEvent.NewLog, slot0._showLogTips, slot0)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, slot0._onNewFuncUnlock, slot0)
	slot0:addEventCb(RoomTradeController.instance, RoomTradeEvent.OnTradeLevelUpReply, slot0._refreshTradeBtn, slot0)
	slot0:addEventCb(RoomController.instance, RoomEvent.ManufactureExpand, slot0._onManufactureExpand, slot0)

	if RoomController.instance:isObMode() then
		RoomRpc.instance:sendGetRoomLogRequest()
	end

	if ViewMgr.instance:isOpen(ViewName.RoomInitBuildingView) then
		slot0:_hideView()
	end

	slot0:_refreshManufactureExpand()
	slot0:_addReddot()
	Activity186Model.instance:checkReadTasks({
		Activity186Enum.ReadTaskId.Task1,
		Activity186Enum.ReadTaskId.Task2,
		Activity186Enum.ReadTaskId.Task3
	})
end

function slot0.onOpenFinish(slot0)
	slot0:_refreshTradeBtn()
end

function slot0._addReddot(slot0)
	RedDotController.instance:addRedDot(slot0._goManufactureEntranceReddot, RedDotEnum.DotNode.ManufactureEntrance)
	RedDotController.instance:addRedDot(slot0._goRecordReddot, RedDotEnum.DotNode.RecordEntrance)
	RedDotController.instance:addRedDot(slot0._goCritterReddot, RedDotEnum.DotNode.CritterEntrance)
	RedDotController.instance:addRedDot(slot0._goOverviewReddot, RedDotEnum.DotNode.OverviewEntrance)
	RedDotController.instance:addRedDot(slot0._goTradeReddot, RedDotEnum.DotNode.TradeEntrance)
	RedDotController.instance:addRedDot(slot0._goWarehouseReddot, RedDotEnum.DotNode.RoomBackpackEntrance)
end

function slot0._onOpenView(slot0, slot1)
	if slot0:_isCheckHideView(slot1) then
		slot0:_hideView()
	end
end

function slot0._onCloseView(slot0, slot1)
	if slot0:_isCheckHideView(slot1) and not slot0:_isHasNeedHideView() then
		slot0:_showView()
		slot0:_layoutPlanUnLockAnim()
		slot0:_checkManufactureUnlock()
	end

	if slot1 == ViewName.RoomManufactureGetView then
		if slot0._isShowManufactureBtn and not ViewMgr.instance:isOpen(ViewName.RoomOverView) and not ViewMgr.instance:isOpen(ViewName.RoomManufactureBuildingView) and ManufactureModel.instance:getExpandManufactureBtn() then
			slot0._warehouseAnimator:Play("charge", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_shouji2)
		end
	end
end

function slot0._isCheckHideView(slot0, slot1)
	if slot0._showHideViewNameDict[slot1] then
		return true
	end

	return false
end

function slot0._isHasNeedHideView(slot0)
	for slot4 = 1, #slot0._showHideViewNameList do
		if ViewMgr.instance:isOpen(slot0._showHideViewNameList[slot4]) then
			return true
		end
	end

	return false
end

function slot0._willOpenRoomInitBuildingView(slot0)
	slot0:_hideView()
end

function slot0._updateRoomLevel(slot0)
	slot0:_refreshLayoutPlan()
end

function slot0._refreshLayoutPlan(slot0)
	slot1 = RoomLayoutController.instance:isOpen()

	gohelper.setActive(slot0._golayoutplanUnlock, slot1)
	gohelper.setActive(slot0._golayoutplanLock, not slot1)
	gohelper.setActive(slot0._golayoutcopyUnlock, slot1)
	gohelper.setActive(slot0._golayoutcopyLock, not slot1)
	slot0:_layoutPlanUnLockAnim()
end

function slot0._layoutPlanUnLockAnim(slot0)
	if slot0._isShowLayoutplan and RoomLayoutController.instance:isOpen() and not RoomLayoutModel.instance:getPlayUnLock() and not ViewMgr.instance:isOpen(ViewName.RoomInitBuildingView) then
		slot0._layoutplanAnimator:Play("unlock", 0, 0)
		RoomLayoutModel.instance:setPlayUnLock(true)
	end
end

function slot0._refreshManufactureExpand(slot0, slot1)
	slot0._warehouseAnimator:Play("idle", 0, 0)

	if slot1 then
		slot0._manufactureAnimator:Play(ManufactureModel.instance:getExpandManufactureBtn() and UIAnimationName.Open or UIAnimationName.Close, 0, 0)
	else
		slot0._manufactureAnimator:Play(slot3, 0, 1)
	end
end

function slot0._hideView(slot0)
	slot0._animator:Play(UIAnimationName.Close)
end

function slot0._showView(slot0)
	slot0._animator:Play(UIAnimationName.Open)
end

function slot0._refreshTradeBtn(slot0)
	slot1 = 0

	if ManufactureModel.instance:isManufactureUnlock() then
		slot1 = ManufactureModel.instance:getTradeLevel()
	end

	slot4 = RoomTradeTaskModel.instance:getOpenOrderLevel() <= slot1

	gohelper.setActive(slot0._btnTrade.gameObject, slot4)

	if slot4 and RoomTradeModel.instance:isCanPlayTradeEnterBtnUnlockAnim() then
		if not slot0._tradeBtnAnimator then
			slot0._tradeBtnAnimator = SLFramework.AnimatorPlayer.Get(slot0._btnTrade.gameObject)
		end

		slot0._tradeBtnAnimator:Play(RoomTradeEnum.TradeAnim.Unlock, nil, slot0)
		RoomTradeModel.instance:setPlayTradeEnterBtnUnlockAnim()
	end
end

function slot0._showLogTips(slot0, slot1)
	slot0._haveLog = true

	gohelper.setActive(slot0._gologtip, true)

	if string.split(slot1.config.extraBonus, "#")[2] then
		slot0._simagesticker:LoadImage(ResUrl.getPropItemIcon(slot3))
	end

	slot0._txtlogdesc.text = slot1.logConfigList[1].content

	TaskDispatcher.runDelay(slot0._closeLogTips, slot0, 6)
end

function slot0._closeLogTips(slot0)
	slot0._haveLog = false

	gohelper.setActive(slot0._gologtip, false)
	RoomRpc.instance:sendReadRoomLogNewRequest()
end

function slot0._openLogView(slot0)
	ViewMgr.instance:openView(ViewName.RoomRecordView, RoomRecordEnum.View.Log)
	slot0:_closeLogTips()
end

function slot0._onManufactureExpand(slot0, slot1)
	if tonumber(slot1) == 1 then
		ManufactureModel.instance:setExpandManufactureBtn(false)
		slot0:_refreshManufactureExpand()
	elseif slot2 == 2 then
		ManufactureModel.instance:setExpandManufactureBtn(true)
		slot0:_refreshManufactureExpand()
	elseif slot2 == 3 then
		-- Nothing
	end
end

function slot0._onNewFuncUnlock(slot0)
	slot0:_checkManufactureUnlock()
end

function slot0._checkManufactureUnlock(slot0)
	ManufactureController.instance:getManufactureServerInfo()
	gohelper.setActive(slot0._gobtnexpandManufacture, ManufactureModel.instance:isManufactureUnlock() and slot0._isShowManufactureBtn)

	if slot0._isShowManufactureBtn and slot1 and not ManufactureModel.instance:getPlayManufactureUnlock() and not ViewMgr.instance:isOpen(ViewName.RoomInitBuildingView) then
		slot0._manufactureAnimator:Play("unlock", 0, 0)
		ManufactureModel.instance:setPlayManufactureUnlock(true)
	end
end

function slot0.onClose(slot0)
	TaskDispatcher.cancelTask(slot0._checkAStarFinish, slot0)
	TaskDispatcher.cancelTask(slot0._closeLogTips, slot0)
	UIBlockMgr.instance:endBlock(UIBlockKey.RoomAStarScan)
	ViewMgr.instance:closeView(ViewName.RoomDebugView)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyHide, slot0._btnhideOnClick, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEdit, slot0._btneditOnClick, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyPlace, slot0._btncharacterOnClick, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.Notifylocate, slot0._btntrackingOnClick, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBuy, slot0._btnstoreOnClick, slot0)
	slot0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyLayout, slot0._btnlayoutplanOnClick, slot0)
	slot0:removeEventCb(CritterController.instance, CritterEvent.onEnterCritterBuildingView, slot0._hideView, slot0)
	slot0:removeEventCb(RoomController.instance, RoomEvent.NewLog, slot0._showLogTips, slot0)
	OpenController.instance:unregisterCallback(OpenEvent.NewFuncUnlock, slot0._onNewFuncUnlock, slot0)
	slot0:removeEventCb(RoomTradeController.instance, RoomTradeEvent.OnTradeLevelUpReply, slot0._refreshTradeBtn, slot0)
	slot0:removeEventCb(RoomController.instance, RoomEvent.ManufactureExpand, slot0._onManufactureExpand, slot0)
end

function slot0.onDestroyView(slot0)
	slot0._simagemaskbg:UnLoadImage()
	slot0._btnedit:RemoveClickListener()
	slot0._btncharacter:RemoveClickListener()
	slot0._btntracking:RemoveClickListener()
	slot0._btndialog:RemoveClickListener()
	slot0._btnhide:RemoveClickListener()
	slot0._btnstore:RemoveClickListener()
	slot0._btnlayoutplan:RemoveClickListener()
	slot0._btnlayoutcopy:RemoveClickListener()
	slot0._btnexpandManufacture:RemoveClickListener()
	slot0._btngoto:RemoveClickListener()
end

return slot0
