module("modules.logic.room.view.RoomView", package.seeall)

local var_0_0 = class("RoomView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btnRecord:AddClickListener(arg_2_0._btnRecordOnClick, arg_2_0)
	arg_2_0._btnCritter:AddClickListener(arg_2_0._btnCritterOnClick, arg_2_0)
	arg_2_0._btnOverview:AddClickListener(arg_2_0._btnOverviewOnClick, arg_2_0)
	arg_2_0._btnTrade:AddClickListener(arg_2_0._btnTradeOnClick, arg_2_0)
	arg_2_0._btnWarehouse:AddClickListener(arg_2_0._btnWarehouseOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnRecord:RemoveClickListener()
	arg_3_0._btnCritter:RemoveClickListener()
	arg_3_0._btnOverview:RemoveClickListener()
	arg_3_0._btnTrade:RemoveClickListener()
	arg_3_0._btnWarehouse:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._goreturnroot = gohelper.findChild(arg_4_0.viewGO, "navigatebuttonscontainer")
	arg_4_0._gonormalroot = gohelper.findChild(arg_4_0.viewGO, "go_normalroot")
	arg_4_0._simagemaskbg = gohelper.findChildSingleImage(arg_4_0.viewGO, "go_normalroot/#simage_maskbg")
	arg_4_0._simagemaskbg.spriteMeshType = UnityEngine.SpriteMeshType.Tight
	arg_4_0._btnedit = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_edit")
	arg_4_0._gobtncamera = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/btn_camera")
	arg_4_0._btncharacter = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_character")
	arg_4_0._btntracking = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_tracking")
	arg_4_0._btndialog = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_dialog")
	arg_4_0._btnhide = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_hide")
	arg_4_0._btnstore = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_store")
	arg_4_0._btnlayoutplan = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_layoutplan")
	arg_4_0._btnlayoutcopy = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_copy")
	arg_4_0._gobtnexpandManufacture = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/btn_expandManufacture")
	arg_4_0._btnexpandManufacture = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_expandManufacture/btn")
	arg_4_0._manufactureAnimator = gohelper.findChildComponent(arg_4_0.viewGO, "go_normalroot/btn_expandManufacture", RoomEnum.ComponentType.Animator)
	arg_4_0._goManufactureEntranceReddot = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/btn_expandManufacture/#go_reddot")
	arg_4_0._btnRecord = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_expandManufacture/go_manuExpand/layout/btn_record")
	arg_4_0._goRecordReddot = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/btn_expandManufacture/go_manuExpand/layout/btn_record/#go_reddot")
	arg_4_0._btnCritter = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_expandManufacture/go_manuExpand/layout/btn_critter")
	arg_4_0._goCritterReddot = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/btn_expandManufacture/go_manuExpand/layout/btn_critter/#go_reddot")
	arg_4_0._btnOverview = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_expandManufacture/go_manuExpand/layout/btn_overview")
	arg_4_0._goOverviewReddot = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/btn_expandManufacture/go_manuExpand/layout/btn_overview/#go_reddot")
	arg_4_0._btnTrade = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_expandManufacture/go_manuExpand/layout/btn_trade")
	arg_4_0._goTradeReddot = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/btn_expandManufacture/go_manuExpand/layout/btn_trade/#go_reddot")
	arg_4_0._btnWarehouse = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_expandManufacture/go_manuExpand/layout/btn_warehouse")
	arg_4_0._goWarehouseReddot = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/btn_expandManufacture/go_manuExpand/layout/btn_warehouse/#go_reddot")
	arg_4_0._warehouseAnimator = arg_4_0._btnWarehouse:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._gobuildingreddot = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/btn_building/go_buildingreddot")
	arg_4_0._goeditreddot = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/btn_edit/go_editreddot")
	arg_4_0._blockoptab = gohelper.findChild(arg_4_0.viewGO, "blockop_tab")
	arg_4_0._golayoutplanUnlock = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/btn_layoutplan/icon")
	arg_4_0._golayoutplanLock = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/btn_layoutplan/go_lock")
	arg_4_0._golayoutcopyUnlock = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/btn_copy/icon")
	arg_4_0._golayoutcopyLock = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/btn_copy/go_lock")
	arg_4_0._gologtip = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/go_logtips")
	arg_4_0._simagesticker = gohelper.findChildSingleImage(arg_4_0.viewGO, "go_normalroot/go_logtips/#simage_stickers")
	arg_4_0._txtlogdesc = gohelper.findChildText(arg_4_0.viewGO, "go_normalroot/go_logtips/#scroll_des/viewport/content/#txt_Desc")
	arg_4_0._btngoto = gohelper.findChildButton(arg_4_0.viewGO, "go_normalroot/go_logtips/#btn_goto")

	arg_4_0._btnedit:AddClickListener(arg_4_0._btneditOnClick, arg_4_0)
	arg_4_0._btncharacter:AddClickListener(arg_4_0._btncharacterOnClick, arg_4_0)
	arg_4_0._btntracking:AddClickListener(arg_4_0._btntrackingOnClick, arg_4_0)
	arg_4_0._btndialog:AddClickListener(arg_4_0._btndialogOnClick, arg_4_0)
	arg_4_0._btnhide:AddClickListener(arg_4_0._btnhideOnClick, arg_4_0)
	arg_4_0._btnstore:AddClickListener(arg_4_0._btnstoreOnClick, arg_4_0)
	arg_4_0._btnlayoutplan:AddClickListener(arg_4_0._btnlayoutplanOnClick, arg_4_0)
	arg_4_0._btnlayoutcopy:AddClickListener(arg_4_0._btnlayoutcopyOnClick, arg_4_0)
	arg_4_0._btnexpandManufacture:AddClickListener(arg_4_0._btnexpandManufactureOnClick, arg_4_0)
	arg_4_0._btngoto:AddClickListener(arg_4_0._openLogView, arg_4_0)

	arg_4_0._scene = GameSceneMgr.instance:getCurScene()
	arg_4_0._rootCanvasGroup = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._canvasGroup = arg_4_0._gonormalroot:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_4_0._layoutplanAnimator = gohelper.findChildComponent(arg_4_0.viewGO, "go_normalroot/btn_layoutplan", typeof(UnityEngine.Animator))

	if RoomInventoryBlockModel.instance:openSelectOp() then
		gohelper.setActive(gohelper.findChild(arg_4_0.viewGO, "go_normalroot/go_inventory"), false)
		gohelper.setActive(gohelper.findChild(arg_4_0.viewGO, "go_normalroot/go_inventorytask"), false)
	end

	arg_4_0._showHideViewNameDict = {
		[ViewName.RoomCharacterPlaceView] = true,
		[ViewName.RoomInitBuildingView] = true,
		[ViewName.RoomManufactureBuildingView] = true,
		[ViewName.RoomCritterBuildingView] = true,
		[ViewName.RoomTransportSiteView] = true,
		[ViewName.RoomInteractBuildingView] = true
	}
	arg_4_0._showHideViewNameList = {}

	for iter_4_0, iter_4_1 in pairs(arg_4_0._showHideViewNameDict) do
		table.insert(arg_4_0._showHideViewNameList, iter_4_0)
	end

	arg_4_0:_updateNavigateButtonShow()
	gohelper.removeUIClickAudio(arg_4_0._btncharacter.gameObject)
	gohelper.addUIClickAudio(arg_4_0._btnlayoutplan.gameObject, AudioEnum.Room.play_ui_home_yield_open)

	arg_4_0._PcBtnLocation = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/btn_tracking/#go_pcbtn")
	arg_4_0._PcBuy = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/btn_store/#go_pcbtn")
	arg_4_0._PcBtnLayout = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/btn_layoutplan/#go_pcbtn")
	arg_4_0._PcBtnPlace = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/btn_character/#go_pcbtn")
	arg_4_0._PcBtnEdit = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/btn_edit/#go_pcbtn")
	arg_4_0._PcBtnHide = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/btn_hide/#go_pcbtn")

	arg_4_0:_refreshLayoutPlan()
	arg_4_0:showKeyTips()
end

function var_0_0._btneditOnClick(arg_5_0)
	local var_5_0 = RoomLayoutModel.instance:getById(RoomEnum.LayoutUsedPlanId)

	if var_5_0 and var_5_0:isSharing() then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomEditShareLayoutPlan, MsgBoxEnum.BoxType.Yes_No, arg_5_0._onEnterRoomEdit, nil, nil, arg_5_0, nil, nil)

		return
	end

	arg_5_0:_onEnterRoomEdit()
end

function var_0_0.showKeyTips(arg_6_0)
	PCInputController.instance:showkeyTips(arg_6_0._PcBtnLocation, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.guting)
	PCInputController.instance:showkeyTips(arg_6_0._PcBuy, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.buy)
	PCInputController.instance:showkeyTips(arg_6_0._PcBtnLayout, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.layout)
	PCInputController.instance:showkeyTips(arg_6_0._PcBtnPlace, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.place)
	PCInputController.instance:showkeyTips(arg_6_0._PcBtnEdit, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.edit)
	PCInputController.instance:showkeyTips(arg_6_0._PcBtnHide, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.hide)
end

function var_0_0._onEnterRoomEdit(arg_7_0)
	RoomController.instance:enterRoom(RoomEnum.GameMode.Edit)
end

function var_0_0._btncharacterOnClick(arg_8_0)
	if RoomEnum.UseAStarPath and ZProj.AStarPathBridge.IsAStarInProgress() then
		arg_8_0.MaxCheckAStarCount = 5
		arg_8_0._checkAStarCount = 0

		TaskDispatcher.runRepeat(arg_8_0._checkAStarFinish, arg_8_0, 0.5, arg_8_0.MaxCheckAStarCount)
		UIBlockMgr.instance:startBlock(UIBlockKey.RoomAStarScan)
		logNormal("astar扫描中，完成后再打开角色界面")
	else
		RoomCharacterController.instance:setCharacterListShow(true)
	end
end

function var_0_0._checkAStarFinish(arg_9_0)
	arg_9_0._checkAStarCount = arg_9_0._checkAStarCount + 1

	if arg_9_0._checkAStarCount >= arg_9_0.MaxCheckAStarCount or not ZProj.AStarPathBridge.IsAStarInProgress() then
		logNormal("astar扫描完成，打开角色界面")
		TaskDispatcher.cancelTask(arg_9_0._checkAStarFinish, arg_9_0)
		UIBlockMgr.instance:endBlock(UIBlockKey.RoomAStarScan)
		RoomCharacterController.instance:setCharacterListShow(true)
	end
end

function var_0_0._btntrackingOnClick(arg_10_0)
	local var_10_0 = arg_10_0._scene.camera:getCameraFocus()

	if arg_10_0._scene.camera:getCameraState() == RoomEnum.CameraState.Overlook and math.abs(var_10_0.x) < 0.1 and math.abs(var_10_0.y) < 0.1 then
		GameFacade.showToast(ToastEnum.ClickRoomTracking)

		return
	end

	arg_10_0._scene.camera:switchCameraState(RoomEnum.CameraState.Overlook, {
		focusX = 0,
		focusY = 0
	})
end

function var_0_0._btndialogOnClick(arg_11_0)
	RoomCharacterController.instance:trynextDialogInteraction()
end

function var_0_0._btnhideOnClick(arg_12_0)
	if RoomMapController.instance:isUIHide() then
		RoomMapController.instance:setUIHide(false)
	else
		RoomMapController.instance:setUIHide(true)
	end
end

function var_0_0._btnstoreOnClick(arg_13_0)
	if StoreController.instance:checkAndOpenStoreView(StoreEnum.StoreId.RoomStore) then
		RoomMapController.instance:dispatchEvent(RoomEvent.BlockAtmosphereEffect)
	end
end

function var_0_0._btnlayoutplanOnClick(arg_14_0)
	if RoomLayoutController.instance:openView() then
		RoomMapController.instance:dispatchEvent(RoomEvent.BlockAtmosphereEffect)
	end
end

function var_0_0._btnlayoutcopyOnClick(arg_15_0)
	if RoomLayoutController.instance:isOpen(true) then
		RoomLayoutController.instance:openCopyView()
	end
end

function var_0_0._btnexpandManufactureOnClick(arg_16_0)
	local var_16_0 = ManufactureModel.instance:getExpandManufactureBtn()

	ManufactureModel.instance:setExpandManufactureBtn(not var_16_0)
	arg_16_0:_refreshManufactureExpand(true)
end

function var_0_0._btnRecordOnClick(arg_17_0)
	ManufactureController.instance:openRoomRecordView()
end

function var_0_0._btnCritterOnClick(arg_18_0)
	ManufactureController.instance:openCritterBuildingView()
end

function var_0_0._btnOverviewOnClick(arg_19_0)
	ManufactureController.instance:openOverView()
end

function var_0_0._btnTradeOnClick(arg_20_0)
	ManufactureController.instance:openRoomTradeView()
end

function var_0_0._btnWarehouseOnClick(arg_21_0)
	ManufactureController.instance:openRoomBackpackView()
end

function var_0_0._show(arg_22_0, arg_22_1)
	if arg_22_0:_isHasNeedHideView() then
		return
	end

	if arg_22_0:_isCheckHideView(arg_22_1) then
		arg_22_0:_hideView()
	else
		arg_22_0._animator:Play("show")
	end
end

function var_0_0._hide(arg_23_0, arg_23_1)
	if arg_23_0:_isHasNeedHideView() then
		return
	end

	arg_23_0._animator:Play("hide")
end

function var_0_0._resetYesCallback()
	RoomMapController.instance:resetRoom()
end

function var_0_0._confirmYesCallback()
	RoomMapController.instance:confirmRoom()
end

function var_0_0._revertYesCallback(arg_26_0)
	RoomMapController.instance:revertRoom()
end

function var_0_0._listViewShowChanged(arg_27_0)
	arg_27_0:_refreshBtnShow()
end

function var_0_0._updateCharacterInteractionUI(arg_28_0)
	arg_28_0:_refreshBtnShow()
	arg_28_0:_updateNavigateButtonShow()
end

function var_0_0._updateNavigateButtonShow(arg_29_0, arg_29_1)
	local var_29_0 = RoomBuildingController.instance:isBuildingListShow()
	local var_29_1 = RoomDebugController.instance:isDebugPlaceListShow()
	local var_29_2 = RoomDebugController.instance:isDebugPackageListShow()
	local var_29_3 = RoomDebugController.instance:isDebugBuildingListShow()
	local var_29_4 = RoomMapBlockModel.instance:isBackMore()
	local var_29_5 = RoomWaterReformModel.instance:isWaterReform()
	local var_29_6 = RoomCharacterHelper.isInDialogInteraction()
	local var_29_7 = RoomMapController.instance:isInRoomInitBuildingViewCamera()
	local var_29_8 = RoomTransportController.instance:isTransportPathShow() or RoomTransportController.instance:isTransportSitShow()
	local var_29_9 = ViewMgr.instance:isOpen(ViewName.RoomInteractBuildingView)
	local var_29_10
	local var_29_11

	if arg_29_1 and type(arg_29_1) == "table" then
		var_29_10 = arg_29_1.inCritterBuildingView or ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView)
		var_29_11 = arg_29_1.inManufactureBuildingView or ViewMgr.instance:isOpen(ViewName.RoomManufactureBuildingView)
	else
		var_29_10 = ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView)
		var_29_11 = ViewMgr.instance:isOpen(ViewName.RoomManufactureBuildingView)
	end

	arg_29_0.viewContainer:setNavigateButtonShow(not var_29_1 and not var_29_2 and not var_29_3 and not var_29_4 and not var_29_6 and not var_29_7 and not var_29_5 and not var_29_8 and not var_29_9 and not var_29_10 and not var_29_11)
end

function var_0_0._addBtnAudio(arg_30_0)
	gohelper.addUIClickAudio(arg_30_0._btnedit.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function var_0_0._refreshBtnShow(arg_31_0)
	local var_31_0 = RoomBuildingController.instance:isBuildingListShow()
	local var_31_1 = RoomDebugController.instance:isDebugPlaceListShow()
	local var_31_2 = RoomDebugController.instance:isDebugPackageListShow()
	local var_31_3 = RoomDebugController.instance:isDebugBuildingListShow()
	local var_31_4 = RoomCharacterController.instance:isCharacterListShow()
	local var_31_5 = var_31_0 or var_31_1 or var_31_2 or var_31_3 or var_31_4
	local var_31_6 = RoomCharacterHelper.isInDialogInteraction()
	local var_31_7 = RoomController.instance:isObMode()

	gohelper.setActive(arg_31_0._simagemaskbg, not RoomController.instance:isEditMode())
	gohelper.setActive(arg_31_0._btnedit.gameObject, var_31_7 and not var_31_6 and (not var_31_5 or var_31_4))

	if arg_31_0._btnedit.gameObject.activeSelf then
		RedDotController.instance:addRedDot(arg_31_0._goeditreddot, RedDotEnum.DotNode.RoomEditBtn)
	end

	gohelper.setActive(arg_31_0._btnhide.gameObject, var_31_7 and not var_31_4 and not var_31_6)
	gohelper.setActive(arg_31_0._btncharacter.gameObject, var_31_7 and not var_31_6 and (not var_31_5 or var_31_4))
	gohelper.setActive(arg_31_0._gobtncamera, var_31_7 and not var_31_6 and (not var_31_5 or var_31_4) or RoomController.instance:isVisitMode() or RoomController.instance:isDebugMode())
	gohelper.setActive(arg_31_0._btntracking.gameObject, var_31_7 and not var_31_6 and (not var_31_5 or var_31_4))
	gohelper.setActive(arg_31_0._btndialog.gameObject, var_31_7 and var_31_6 and not var_31_5)
	gohelper.setActive(arg_31_0._btnstore.gameObject, var_31_7 and not var_31_6 and (not var_31_5 or var_31_4))

	local var_31_8 = not var_31_6 and var_31_7

	arg_31_0._isShowLayoutplan = var_31_8 and not var_31_5

	gohelper.setActive(arg_31_0._btnlayoutplan, var_31_8 and (not var_31_5 or var_31_4))

	local var_31_9 = ViewMgr.instance:isOpen(ViewName.RoomInteractBuildingView)

	arg_31_0._isShowManufactureBtn = not VersionValidator.instance:isInReviewing() and var_31_7 and not var_31_5 and not var_31_6 and not var_31_9

	arg_31_0:_checkManufactureUnlock()

	local var_31_10 = RoomModel.instance:getVisitParam()

	gohelper.setActive(arg_31_0._btnlayoutcopy, not RoomEnum.IsCloseLayouCopy and RoomController.instance:isVisitMode() and var_31_10 and var_31_10.userId and SocialModel.instance:isMyFriendByUserId(var_31_10.userId))

	if RoomController.instance:isDebugMode() then
		ViewMgr.instance:openView(ViewName.RoomDebugView)
	end

	if arg_31_0._isShowLayoutplan then
		arg_31_0:_layoutPlanUnLockAnim()
	end

	arg_31_0:_refreshTradeBtn()
end

function var_0_0._switchScene(arg_32_0)
	arg_32_0._animator:Play("xiaoshi", 0, 0)
end

function var_0_0._onSelectBlockOpTab(arg_33_0, arg_33_1)
	if not arg_33_1 then
		return
	end

	local var_33_0 = false

	for iter_33_0, iter_33_1 in pairs(RoomEnum.RoomViewBlockOpMode) do
		if iter_33_1 == arg_33_1 then
			var_33_0 = true

			break
		end
	end

	if var_33_0 then
		arg_33_0.viewContainer:selectBlockOpTab(arg_33_1)
	end
end

function var_0_0.onOpen(arg_34_0)
	arg_34_0:_refreshBtnShow()
	arg_34_0:_addBtnAudio()
	arg_34_0:addEventCb(RoomBuildingController.instance, RoomEvent.BuildingListShowChanged, arg_34_0._listViewShowChanged, arg_34_0)
	arg_34_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPlaceListShowChanged, arg_34_0._listViewShowChanged, arg_34_0)
	arg_34_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPackageListShowChanged, arg_34_0._listViewShowChanged, arg_34_0)
	arg_34_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugBuildingListShowChanged, arg_34_0._listViewShowChanged, arg_34_0)
	arg_34_0:addEventCb(RoomCharacterController.instance, RoomEvent.CharacterListShowChanged, arg_34_0._listViewShowChanged, arg_34_0)
	arg_34_0:addEventCb(RoomMapController.instance, RoomEvent.BackBlockShowChanged, arg_34_0._listViewShowChanged, arg_34_0)
	arg_34_0:addEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, arg_34_0._listViewShowChanged, arg_34_0)
	arg_34_0:addEventCb(RoomMapController.instance, RoomEvent.InteractBuildingShowChanged, arg_34_0._listViewShowChanged, arg_34_0)
	arg_34_0:addEventCb(RoomMapController.instance, RoomEvent.BackBlockShowChanged, arg_34_0._updateNavigateButtonShow, arg_34_0)
	arg_34_0:addEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, arg_34_0._updateNavigateButtonShow, arg_34_0)
	arg_34_0:addEventCb(RoomBuildingController.instance, RoomEvent.RefreshNavigateButton, arg_34_0._updateNavigateButtonShow, arg_34_0)
	arg_34_0:addEventCb(RoomBuildingController.instance, RoomEvent.BuildingListShowChanged, arg_34_0._updateNavigateButtonShow, arg_34_0)
	arg_34_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPlaceListShowChanged, arg_34_0._updateNavigateButtonShow, arg_34_0)
	arg_34_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPackageListShowChanged, arg_34_0._updateNavigateButtonShow, arg_34_0)
	arg_34_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugBuildingListShowChanged, arg_34_0._updateNavigateButtonShow, arg_34_0)
	arg_34_0:addEventCb(RoomCharacterController.instance, RoomEvent.CharacterListShowChanged, arg_34_0._updateNavigateButtonShow, arg_34_0)
	arg_34_0:addEventCb(RoomMapController.instance, RoomEvent.TransportPathViewShowChanged, arg_34_0._updateNavigateButtonShow, arg_34_0)
	arg_34_0:addEventCb(RoomMapController.instance, RoomEvent.TransportSiteViewShowChanged, arg_34_0._updateNavigateButtonShow, arg_34_0)
	arg_34_0:addEventCb(RoomMapController.instance, RoomEvent.InteractBuildingShowChanged, arg_34_0._updateNavigateButtonShow, arg_34_0)
	arg_34_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingViewChange, arg_34_0._updateNavigateButtonShow, arg_34_0)
	arg_34_0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingViewChange, arg_34_0._updateNavigateButtonShow, arg_34_0)
	arg_34_0:addEventCb(RoomController.instance, RoomEvent.SwitchScene, arg_34_0._switchScene, arg_34_0)
	arg_34_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_34_0._onOpenView, arg_34_0)
	arg_34_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_34_0._onCloseView, arg_34_0)
	arg_34_0:addEventCb(RoomMapController.instance, RoomEvent.WillOpenRoomInitBuildingView, arg_34_0._willOpenRoomInitBuildingView, arg_34_0)
	arg_34_0:addEventCb(RoomCharacterController.instance, RoomEvent.UpdateCharacterInteractionUI, arg_34_0._updateCharacterInteractionUI, arg_34_0)
	arg_34_0:addEventCb(RoomMapController.instance, RoomEvent.ShowUI, arg_34_0._show, arg_34_0)
	arg_34_0:addEventCb(RoomMapController.instance, RoomEvent.HideUI, arg_34_0._hide, arg_34_0)
	arg_34_0:addEventCb(RoomMapController.instance, RoomEvent.UpdateRoomLevel, arg_34_0._updateRoomLevel, arg_34_0)
	arg_34_0:addEventCb(RoomMapController.instance, RoomEvent.SelectRoomViewBlockOpTab, arg_34_0._onSelectBlockOpTab, arg_34_0)
	arg_34_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyHide, arg_34_0._btnhideOnClick, arg_34_0)
	arg_34_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEdit, arg_34_0._btneditOnClick, arg_34_0)
	arg_34_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyPlace, arg_34_0._btncharacterOnClick, arg_34_0)
	arg_34_0:addEventCb(PCInputController.instance, PCInputEvent.Notifylocate, arg_34_0._btntrackingOnClick, arg_34_0)
	arg_34_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBuy, arg_34_0._btnstoreOnClick, arg_34_0)
	arg_34_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyLayout, arg_34_0._btnlayoutplanOnClick, arg_34_0)
	arg_34_0:addEventCb(CritterController.instance, CritterEvent.onEnterCritterBuildingView, arg_34_0._hideView, arg_34_0)
	arg_34_0:addEventCb(ManufactureController.instance, ManufactureEvent.OnEnterManufactureBuildingView, arg_34_0._hideView, arg_34_0)
	arg_34_0:addEventCb(RoomController.instance, RoomEvent.NewLog, arg_34_0._showLogTips, arg_34_0)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, arg_34_0._onNewFuncUnlock, arg_34_0)
	arg_34_0:addEventCb(RoomTradeController.instance, RoomTradeEvent.OnTradeLevelUpReply, arg_34_0._refreshTradeBtn, arg_34_0)
	arg_34_0:addEventCb(RoomController.instance, RoomEvent.ManufactureExpand, arg_34_0._onManufactureExpand, arg_34_0)

	if RoomController.instance:isObMode() then
		RoomRpc.instance:sendGetRoomLogRequest()
	end

	if ViewMgr.instance:isOpen(ViewName.RoomInitBuildingView) then
		arg_34_0:_hideView()
	end

	arg_34_0:_refreshManufactureExpand()
	arg_34_0:_addReddot()
	Activity186Model.instance:checkReadTasks({
		Activity186Enum.ReadTaskId.Task1,
		Activity186Enum.ReadTaskId.Task2,
		Activity186Enum.ReadTaskId.Task3
	})
end

function var_0_0.onOpenFinish(arg_35_0)
	arg_35_0:_refreshTradeBtn()
end

function var_0_0._addReddot(arg_36_0)
	RedDotController.instance:addRedDot(arg_36_0._goManufactureEntranceReddot, RedDotEnum.DotNode.ManufactureEntrance)
	RedDotController.instance:addRedDot(arg_36_0._goRecordReddot, RedDotEnum.DotNode.RecordEntrance)
	RedDotController.instance:addRedDot(arg_36_0._goCritterReddot, RedDotEnum.DotNode.CritterEntrance)
	RedDotController.instance:addRedDot(arg_36_0._goOverviewReddot, RedDotEnum.DotNode.OverviewEntrance)
	RedDotController.instance:addRedDot(arg_36_0._goTradeReddot, RedDotEnum.DotNode.TradeEntrance)
	RedDotController.instance:addRedDot(arg_36_0._goWarehouseReddot, RedDotEnum.DotNode.RoomBackpackEntrance)
end

function var_0_0._onOpenView(arg_37_0, arg_37_1)
	if arg_37_0:_isCheckHideView(arg_37_1) then
		arg_37_0:_hideView()
	end
end

function var_0_0._onCloseView(arg_38_0, arg_38_1)
	if arg_38_0:_isCheckHideView(arg_38_1) and not arg_38_0:_isHasNeedHideView() then
		arg_38_0:_showView()
		arg_38_0:_layoutPlanUnLockAnim()
		arg_38_0:_checkManufactureUnlock()
	end

	if arg_38_1 == ViewName.RoomManufactureGetView then
		local var_38_0 = ViewMgr.instance:isOpen(ViewName.RoomOverView)
		local var_38_1 = ViewMgr.instance:isOpen(ViewName.RoomManufactureBuildingView)
		local var_38_2 = ManufactureModel.instance:getExpandManufactureBtn()

		if arg_38_0._isShowManufactureBtn and not var_38_0 and not var_38_1 and var_38_2 then
			arg_38_0._warehouseAnimator:Play("charge", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_shouji2)
		end
	end
end

function var_0_0._isCheckHideView(arg_39_0, arg_39_1)
	if arg_39_0._showHideViewNameDict[arg_39_1] then
		return true
	end

	return false
end

function var_0_0._isHasNeedHideView(arg_40_0)
	for iter_40_0 = 1, #arg_40_0._showHideViewNameList do
		if ViewMgr.instance:isOpen(arg_40_0._showHideViewNameList[iter_40_0]) then
			return true
		end
	end

	return false
end

function var_0_0._willOpenRoomInitBuildingView(arg_41_0)
	arg_41_0:_hideView()
end

function var_0_0._updateRoomLevel(arg_42_0)
	arg_42_0:_refreshLayoutPlan()
end

function var_0_0._refreshLayoutPlan(arg_43_0)
	local var_43_0 = RoomLayoutController.instance:isOpen()

	gohelper.setActive(arg_43_0._golayoutplanUnlock, var_43_0)
	gohelper.setActive(arg_43_0._golayoutplanLock, not var_43_0)
	gohelper.setActive(arg_43_0._golayoutcopyUnlock, var_43_0)
	gohelper.setActive(arg_43_0._golayoutcopyLock, not var_43_0)
	arg_43_0:_layoutPlanUnLockAnim()
end

function var_0_0._layoutPlanUnLockAnim(arg_44_0)
	if arg_44_0._isShowLayoutplan and RoomLayoutController.instance:isOpen() and not RoomLayoutModel.instance:getPlayUnLock() and not ViewMgr.instance:isOpen(ViewName.RoomInitBuildingView) then
		arg_44_0._layoutplanAnimator:Play("unlock", 0, 0)
		RoomLayoutModel.instance:setPlayUnLock(true)
	end
end

function var_0_0._refreshManufactureExpand(arg_45_0, arg_45_1)
	arg_45_0._warehouseAnimator:Play("idle", 0, 0)

	local var_45_0 = ManufactureModel.instance:getExpandManufactureBtn() and UIAnimationName.Open or UIAnimationName.Close

	if arg_45_1 then
		arg_45_0._manufactureAnimator:Play(var_45_0, 0, 0)
	else
		arg_45_0._manufactureAnimator:Play(var_45_0, 0, 1)
	end
end

function var_0_0._hideView(arg_46_0)
	arg_46_0._animator:Play(UIAnimationName.Close)
end

function var_0_0._showView(arg_47_0)
	arg_47_0._animator:Play(UIAnimationName.Open)
end

function var_0_0._refreshTradeBtn(arg_48_0)
	local var_48_0 = 0

	if ManufactureModel.instance:isManufactureUnlock() then
		var_48_0 = ManufactureModel.instance:getTradeLevel()
	end

	local var_48_1 = var_48_0 >= RoomTradeTaskModel.instance:getOpenOrderLevel()

	gohelper.setActive(arg_48_0._btnTrade.gameObject, var_48_1)

	if var_48_1 and RoomTradeModel.instance:isCanPlayTradeEnterBtnUnlockAnim() then
		if not arg_48_0._tradeBtnAnimator then
			arg_48_0._tradeBtnAnimator = SLFramework.AnimatorPlayer.Get(arg_48_0._btnTrade.gameObject)
		end

		arg_48_0._tradeBtnAnimator:Play(RoomTradeEnum.TradeAnim.Unlock, nil, arg_48_0)
		RoomTradeModel.instance:setPlayTradeEnterBtnUnlockAnim()
	end
end

function var_0_0._showLogTips(arg_49_0, arg_49_1)
	arg_49_0._haveLog = true

	gohelper.setActive(arg_49_0._gologtip, true)

	local var_49_0 = string.split(arg_49_1.config.extraBonus, "#")[2]

	if var_49_0 then
		arg_49_0._simagesticker:LoadImage(ResUrl.getPropItemIcon(var_49_0))
	end

	arg_49_0._txtlogdesc.text = arg_49_1.logConfigList[1].content

	TaskDispatcher.runDelay(arg_49_0._closeLogTips, arg_49_0, 6)
end

function var_0_0._closeLogTips(arg_50_0)
	arg_50_0._haveLog = false

	gohelper.setActive(arg_50_0._gologtip, false)
	RoomRpc.instance:sendReadRoomLogNewRequest()
end

function var_0_0._openLogView(arg_51_0)
	ViewMgr.instance:openView(ViewName.RoomRecordView, RoomRecordEnum.View.Log)
	arg_51_0:_closeLogTips()
end

function var_0_0._onManufactureExpand(arg_52_0, arg_52_1)
	local var_52_0 = tonumber(arg_52_1)

	if var_52_0 == 1 then
		ManufactureModel.instance:setExpandManufactureBtn(false)
		arg_52_0:_refreshManufactureExpand()
	elseif var_52_0 == 2 then
		ManufactureModel.instance:setExpandManufactureBtn(true)
		arg_52_0:_refreshManufactureExpand()
	elseif var_52_0 == 3 then
		-- block empty
	end
end

function var_0_0._onNewFuncUnlock(arg_53_0)
	arg_53_0:_checkManufactureUnlock()
end

function var_0_0._checkManufactureUnlock(arg_54_0)
	ManufactureController.instance:getManufactureServerInfo()

	local var_54_0 = ManufactureModel.instance:isManufactureUnlock()

	gohelper.setActive(arg_54_0._gobtnexpandManufacture, var_54_0 and arg_54_0._isShowManufactureBtn)

	local var_54_1 = ManufactureModel.instance:getPlayManufactureUnlock()
	local var_54_2 = ViewMgr.instance:isOpen(ViewName.RoomInitBuildingView)

	if arg_54_0._isShowManufactureBtn and var_54_0 and not var_54_1 and not var_54_2 then
		arg_54_0._manufactureAnimator:Play("unlock", 0, 0)
		ManufactureModel.instance:setPlayManufactureUnlock(true)
	end
end

function var_0_0.onClose(arg_55_0)
	TaskDispatcher.cancelTask(arg_55_0._checkAStarFinish, arg_55_0)
	TaskDispatcher.cancelTask(arg_55_0._closeLogTips, arg_55_0)
	UIBlockMgr.instance:endBlock(UIBlockKey.RoomAStarScan)
	ViewMgr.instance:closeView(ViewName.RoomDebugView)
	arg_55_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyHide, arg_55_0._btnhideOnClick, arg_55_0)
	arg_55_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEdit, arg_55_0._btneditOnClick, arg_55_0)
	arg_55_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyPlace, arg_55_0._btncharacterOnClick, arg_55_0)
	arg_55_0:removeEventCb(PCInputController.instance, PCInputEvent.Notifylocate, arg_55_0._btntrackingOnClick, arg_55_0)
	arg_55_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBuy, arg_55_0._btnstoreOnClick, arg_55_0)
	arg_55_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyLayout, arg_55_0._btnlayoutplanOnClick, arg_55_0)
	arg_55_0:removeEventCb(CritterController.instance, CritterEvent.onEnterCritterBuildingView, arg_55_0._hideView, arg_55_0)
	arg_55_0:removeEventCb(RoomController.instance, RoomEvent.NewLog, arg_55_0._showLogTips, arg_55_0)
	OpenController.instance:unregisterCallback(OpenEvent.NewFuncUnlock, arg_55_0._onNewFuncUnlock, arg_55_0)
	arg_55_0:removeEventCb(RoomTradeController.instance, RoomTradeEvent.OnTradeLevelUpReply, arg_55_0._refreshTradeBtn, arg_55_0)
	arg_55_0:removeEventCb(RoomController.instance, RoomEvent.ManufactureExpand, arg_55_0._onManufactureExpand, arg_55_0)
end

function var_0_0.onDestroyView(arg_56_0)
	arg_56_0._simagemaskbg:UnLoadImage()
	arg_56_0._btnedit:RemoveClickListener()
	arg_56_0._btncharacter:RemoveClickListener()
	arg_56_0._btntracking:RemoveClickListener()
	arg_56_0._btndialog:RemoveClickListener()
	arg_56_0._btnhide:RemoveClickListener()
	arg_56_0._btnstore:RemoveClickListener()
	arg_56_0._btnlayoutplan:RemoveClickListener()
	arg_56_0._btnlayoutcopy:RemoveClickListener()
	arg_56_0._btnexpandManufacture:RemoveClickListener()
	arg_56_0._btngoto:RemoveClickListener()
end

return var_0_0
