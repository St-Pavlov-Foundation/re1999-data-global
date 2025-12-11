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
	arg_2_0._btnfishing:AddClickListener(arg_2_0._btnfishingOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btnRecord:RemoveClickListener()
	arg_3_0._btnCritter:RemoveClickListener()
	arg_3_0._btnOverview:RemoveClickListener()
	arg_3_0._btnTrade:RemoveClickListener()
	arg_3_0._btnWarehouse:RemoveClickListener()
	arg_3_0._btnfishing:RemoveClickListener()
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
	arg_4_0._imagetracking = gohelper.findChildImage(arg_4_0.viewGO, "go_normalroot/btn_tracking")
	arg_4_0._txttracking = gohelper.findChildText(arg_4_0.viewGO, "go_normalroot/btn_tracking/txt")
	arg_4_0._btndialog = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_dialog")
	arg_4_0._btnhide = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_hide")
	arg_4_0._btnstore = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_store")
	arg_4_0._gobtnfishingResources = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/btn_fishingResource")
	arg_4_0._btnlayoutplan = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_layoutplan")
	arg_4_0._btnlayoutcopy = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_copy")
	arg_4_0._gobtnexpandManufacture = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/layout/btn_expandManufacture")
	arg_4_0._btnexpandManufacture = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/layout/btn_expandManufacture/btn")
	arg_4_0._manufactureAnimator = gohelper.findChildComponent(arg_4_0.viewGO, "go_normalroot/layout/btn_expandManufacture", RoomEnum.ComponentType.Animator)
	arg_4_0._goManufactureEntranceReddot = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/layout/btn_expandManufacture/#go_reddot")
	arg_4_0._btnRecord = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/layout/btn_expandManufacture/go_manuExpand/layout/btn_record")
	arg_4_0._goRecordReddot = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/layout/btn_expandManufacture/go_manuExpand/layout/btn_record/#go_reddot")
	arg_4_0._btnCritter = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/layout/btn_expandManufacture/go_manuExpand/layout/btn_critter")
	arg_4_0._goCritterReddot = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/layout/btn_expandManufacture/go_manuExpand/layout/btn_critter/#go_reddot")
	arg_4_0._btnOverview = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/layout/btn_expandManufacture/go_manuExpand/layout/btn_overview")
	arg_4_0._goOverviewReddot = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/layout/btn_expandManufacture/go_manuExpand/layout/btn_overview/#go_reddot")
	arg_4_0._btnTrade = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/layout/btn_expandManufacture/go_manuExpand/layout/btn_trade")
	arg_4_0._goTradeReddot = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/layout/btn_expandManufacture/go_manuExpand/layout/btn_trade/#go_reddot")
	arg_4_0._btnWarehouse = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/layout/btn_expandManufacture/go_manuExpand/layout/btn_warehouse")
	arg_4_0._goWarehouseReddot = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/layout/btn_expandManufacture/go_manuExpand/layout/btn_warehouse/#go_reddot")
	arg_4_0._warehouseAnimator = arg_4_0._btnWarehouse:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._btnfishing = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/layout/btn_fishing")
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

function var_0_0.showKeyTips(arg_5_0)
	PCInputController.instance:showkeyTips(arg_5_0._PcBtnLocation, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.guting)
	PCInputController.instance:showkeyTips(arg_5_0._PcBuy, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.buy)
	PCInputController.instance:showkeyTips(arg_5_0._PcBtnLayout, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.layout)
	PCInputController.instance:showkeyTips(arg_5_0._PcBtnPlace, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.place)
	PCInputController.instance:showkeyTips(arg_5_0._PcBtnEdit, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.edit)
	PCInputController.instance:showkeyTips(arg_5_0._PcBtnHide, PCInputModel.Activity.room, PCInputModel.RoomActivityFun.hide)
end

function var_0_0._btneditOnClick(arg_6_0)
	local var_6_0 = RoomLayoutModel.instance:getById(RoomEnum.LayoutUsedPlanId)

	if var_6_0 and var_6_0:isSharing() then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomEditShareLayoutPlan, MsgBoxEnum.BoxType.Yes_No, arg_6_0._onEnterRoomEdit, nil, nil, arg_6_0, nil, nil)

		return
	end

	arg_6_0:_onEnterRoomEdit()
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
	local var_10_0 = RoomEnum.CameraState.Overlook
	local var_10_1 = 0
	local var_10_2 = 0
	local var_10_3 = FishingModel.instance:isInFishing()

	if var_10_3 then
		local var_10_4 = RoomMapBuildingModel.instance:getBuildingListByType(RoomBuildingEnum.BuildingType.Fishing)

		if var_10_4 then
			for iter_10_0, iter_10_1 in ipairs(var_10_4) do
				local var_10_5 = iter_10_1:getBelongUserId()
				local var_10_6 = PlayerModel.instance:getMyUserId()

				if var_10_5 and var_10_5 == var_10_6 then
					local var_10_7 = HexMath.hexToPosition(iter_10_1.hexPoint, RoomBlockEnum.BlockSize)

					var_10_1 = var_10_7.x
					var_10_2 = var_10_7.y

					break
				end
			end
		end

		var_10_0 = RoomEnum.CameraState.OverlookAll
	end

	local var_10_8 = arg_10_0._scene.camera:getCameraFocus()

	if arg_10_0._scene.camera:getCameraState() == var_10_0 and math.abs(var_10_8.x - var_10_1) < 0.1 and math.abs(var_10_8.y - var_10_2) < 0.1 then
		local var_10_9 = ToastEnum.ClickRoomTracking

		if var_10_3 then
			var_10_9 = ToastEnum.ClickRoomFishingTracking
		end

		GameFacade.showToast(var_10_9)

		return
	end

	arg_10_0._scene.camera:switchCameraState(var_10_0, {
		focusX = var_10_1,
		focusY = var_10_2
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

function var_0_0._btnfishingOnClick(arg_22_0)
	FishingController.instance:enterFishingMode()
end

function var_0_0._show(arg_23_0, arg_23_1)
	if arg_23_0:_isHasNeedHideView() then
		return
	end

	if arg_23_0:_isCheckHideView(arg_23_1) then
		arg_23_0:_hideView()
	else
		arg_23_0._animator:Play("show")
	end
end

function var_0_0._hide(arg_24_0, arg_24_1)
	if arg_24_0:_isHasNeedHideView() then
		return
	end

	arg_24_0._animator:Play("hide")
end

function var_0_0._resetYesCallback()
	RoomMapController.instance:resetRoom()
end

function var_0_0._confirmYesCallback()
	RoomMapController.instance:confirmRoom()
end

function var_0_0._revertYesCallback(arg_27_0)
	RoomMapController.instance:revertRoom()
end

function var_0_0._listViewShowChanged(arg_28_0)
	arg_28_0:_refreshBtnShow()
end

function var_0_0._updateCharacterInteractionUI(arg_29_0)
	arg_29_0:_refreshBtnShow()
	arg_29_0:_updateNavigateButtonShow()
end

function var_0_0._updateNavigateButtonShow(arg_30_0, arg_30_1)
	local var_30_0 = RoomBuildingController.instance:isBuildingListShow()
	local var_30_1 = RoomDebugController.instance:isDebugPlaceListShow()
	local var_30_2 = RoomDebugController.instance:isDebugPackageListShow()
	local var_30_3 = RoomDebugController.instance:isDebugBuildingListShow()
	local var_30_4 = RoomMapBlockModel.instance:isBackMore()
	local var_30_5 = RoomWaterReformModel.instance:isWaterReform()
	local var_30_6 = RoomCharacterHelper.isInDialogInteraction()
	local var_30_7 = RoomMapController.instance:isInRoomInitBuildingViewCamera()
	local var_30_8 = RoomTransportController.instance:isTransportPathShow() or RoomTransportController.instance:isTransportSitShow()
	local var_30_9 = ViewMgr.instance:isOpen(ViewName.RoomInteractBuildingView)
	local var_30_10
	local var_30_11

	if arg_30_1 and type(arg_30_1) == "table" then
		var_30_10 = arg_30_1.inCritterBuildingView or ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView)
		var_30_11 = arg_30_1.inManufactureBuildingView or ViewMgr.instance:isOpen(ViewName.RoomManufactureBuildingView)
	else
		var_30_10 = ViewMgr.instance:isOpen(ViewName.RoomCritterBuildingView)
		var_30_11 = ViewMgr.instance:isOpen(ViewName.RoomManufactureBuildingView)
	end

	arg_30_0.viewContainer:setNavigateButtonShow(not var_30_1 and not var_30_2 and not var_30_3 and not var_30_4 and not var_30_6 and not var_30_7 and not var_30_5 and not var_30_8 and not var_30_9 and not var_30_10 and not var_30_11)
end

function var_0_0._addBtnAudio(arg_31_0)
	gohelper.addUIClickAudio(arg_31_0._btnedit.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function var_0_0._refreshBtnShow(arg_32_0)
	local var_32_0 = RoomBuildingController.instance:isBuildingListShow()
	local var_32_1 = RoomDebugController.instance:isDebugPlaceListShow()
	local var_32_2 = RoomDebugController.instance:isDebugPackageListShow()
	local var_32_3 = RoomDebugController.instance:isDebugBuildingListShow()
	local var_32_4 = RoomCharacterController.instance:isCharacterListShow()
	local var_32_5 = var_32_0 or var_32_1 or var_32_2 or var_32_3 or var_32_4
	local var_32_6 = RoomCharacterHelper.isInDialogInteraction()
	local var_32_7 = RoomController.instance:isObMode()
	local var_32_8 = RoomController.instance:isFishingMode()

	gohelper.setActive(arg_32_0._simagemaskbg, not RoomController.instance:isEditMode())
	gohelper.setActive(arg_32_0._btnedit.gameObject, var_32_7 and not var_32_6 and (not var_32_5 or var_32_4))

	if arg_32_0._btnedit.gameObject.activeSelf then
		RedDotController.instance:addRedDot(arg_32_0._goeditreddot, RedDotEnum.DotNode.RoomEditBtn)
	end

	gohelper.setActive(arg_32_0._btnhide.gameObject, var_32_7 and not var_32_4 and not var_32_6)
	gohelper.setActive(arg_32_0._btncharacter.gameObject, var_32_7 and not var_32_6 and (not var_32_5 or var_32_4))
	gohelper.setActive(arg_32_0._gobtncamera, (var_32_7 or var_32_8) and not var_32_6 and (not var_32_5 or var_32_4) or RoomController.instance:isVisitMode() or RoomController.instance:isDebugMode())
	gohelper.setActive(arg_32_0._btntracking.gameObject, (var_32_7 or var_32_8) and not var_32_6 and (not var_32_5 or var_32_4))

	local var_32_9 = "p_roomview_tracking"
	local var_32_10 = "xw_dingweishuniu_icon1"

	if var_32_8 then
		var_32_9 = "p_roomview_fishing_tracking"
		var_32_10 = "roomfish_locatebn"
	end

	arg_32_0._txttracking.text = luaLang(var_32_9)

	UISpriteSetMgr.instance:setRoomSprite(arg_32_0._imagetracking, var_32_10, true)
	gohelper.setActive(arg_32_0._btndialog.gameObject, var_32_7 and var_32_6 and not var_32_5)
	gohelper.setActive(arg_32_0._btnstore.gameObject, var_32_7 and not var_32_6 and (not var_32_5 or var_32_4))
	gohelper.setActive(arg_32_0._gobtnfishingResources, var_32_8 and not var_32_6 and (not var_32_5 or var_32_4))

	local var_32_11 = not var_32_6 and var_32_7

	arg_32_0._isShowLayoutplan = var_32_11 and not var_32_5

	gohelper.setActive(arg_32_0._btnlayoutplan, var_32_11 and (not var_32_5 or var_32_4))

	local var_32_12 = ViewMgr.instance:isOpen(ViewName.RoomInteractBuildingView)

	arg_32_0._isShowManufactureBtn = not VersionValidator.instance:isInReviewing() and var_32_7 and not var_32_5 and not var_32_6 and not var_32_12

	arg_32_0:_checkManufactureUnlock()

	arg_32_0._isShowRoomFishingBtn = var_32_7 and not var_32_5 and not var_32_6 and not var_32_12

	arg_32_0:_checkRoomFishingShow()

	local var_32_13 = RoomModel.instance:getVisitParam()

	gohelper.setActive(arg_32_0._btnlayoutcopy, not RoomEnum.IsCloseLayouCopy and RoomController.instance:isVisitMode() and var_32_13 and var_32_13.userId and SocialModel.instance:isMyFriendByUserId(var_32_13.userId))

	if RoomController.instance:isDebugMode() then
		ViewMgr.instance:openView(ViewName.RoomDebugView)
	end

	if arg_32_0._isShowLayoutplan then
		arg_32_0:_layoutPlanUnLockAnim()
	end

	if VersionValidator.instance:isInReviewing() then
		gohelper.setActive(arg_32_0._btnstore, false)
	end

	arg_32_0:_refreshTradeBtn()
end

function var_0_0._switchScene(arg_33_0)
	arg_33_0._animator:Play("xiaoshi", 0, 0)
end

function var_0_0._onSelectBlockOpTab(arg_34_0, arg_34_1)
	if not arg_34_1 then
		return
	end

	local var_34_0 = false

	for iter_34_0, iter_34_1 in pairs(RoomEnum.RoomViewBlockOpMode) do
		if iter_34_1 == arg_34_1 then
			var_34_0 = true

			break
		end
	end

	if var_34_0 then
		arg_34_0.viewContainer:selectBlockOpTab(arg_34_1)
	end
end

function var_0_0.onOpen(arg_35_0)
	arg_35_0:_refreshBtnShow()
	arg_35_0:_addBtnAudio()
	arg_35_0:addEventCb(RoomBuildingController.instance, RoomEvent.BuildingListShowChanged, arg_35_0._listViewShowChanged, arg_35_0)
	arg_35_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPlaceListShowChanged, arg_35_0._listViewShowChanged, arg_35_0)
	arg_35_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPackageListShowChanged, arg_35_0._listViewShowChanged, arg_35_0)
	arg_35_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugBuildingListShowChanged, arg_35_0._listViewShowChanged, arg_35_0)
	arg_35_0:addEventCb(RoomCharacterController.instance, RoomEvent.CharacterListShowChanged, arg_35_0._listViewShowChanged, arg_35_0)
	arg_35_0:addEventCb(RoomMapController.instance, RoomEvent.BackBlockShowChanged, arg_35_0._listViewShowChanged, arg_35_0)
	arg_35_0:addEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, arg_35_0._listViewShowChanged, arg_35_0)
	arg_35_0:addEventCb(RoomMapController.instance, RoomEvent.InteractBuildingShowChanged, arg_35_0._listViewShowChanged, arg_35_0)
	arg_35_0:addEventCb(RoomMapController.instance, RoomEvent.BackBlockShowChanged, arg_35_0._updateNavigateButtonShow, arg_35_0)
	arg_35_0:addEventCb(RoomWaterReformController.instance, RoomEvent.WaterReformShowChanged, arg_35_0._updateNavigateButtonShow, arg_35_0)
	arg_35_0:addEventCb(RoomBuildingController.instance, RoomEvent.RefreshNavigateButton, arg_35_0._updateNavigateButtonShow, arg_35_0)
	arg_35_0:addEventCb(RoomBuildingController.instance, RoomEvent.BuildingListShowChanged, arg_35_0._updateNavigateButtonShow, arg_35_0)
	arg_35_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPlaceListShowChanged, arg_35_0._updateNavigateButtonShow, arg_35_0)
	arg_35_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPackageListShowChanged, arg_35_0._updateNavigateButtonShow, arg_35_0)
	arg_35_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugBuildingListShowChanged, arg_35_0._updateNavigateButtonShow, arg_35_0)
	arg_35_0:addEventCb(RoomCharacterController.instance, RoomEvent.CharacterListShowChanged, arg_35_0._updateNavigateButtonShow, arg_35_0)
	arg_35_0:addEventCb(RoomMapController.instance, RoomEvent.TransportPathViewShowChanged, arg_35_0._updateNavigateButtonShow, arg_35_0)
	arg_35_0:addEventCb(RoomMapController.instance, RoomEvent.TransportSiteViewShowChanged, arg_35_0._updateNavigateButtonShow, arg_35_0)
	arg_35_0:addEventCb(RoomMapController.instance, RoomEvent.InteractBuildingShowChanged, arg_35_0._updateNavigateButtonShow, arg_35_0)
	arg_35_0:addEventCb(ManufactureController.instance, ManufactureEvent.ManufactureBuildingViewChange, arg_35_0._updateNavigateButtonShow, arg_35_0)
	arg_35_0:addEventCb(CritterController.instance, CritterEvent.CritterBuildingViewChange, arg_35_0._updateNavigateButtonShow, arg_35_0)
	arg_35_0:addEventCb(RoomController.instance, RoomEvent.SwitchScene, arg_35_0._switchScene, arg_35_0)
	arg_35_0:addEventCb(ViewMgr.instance, ViewEvent.OnOpenView, arg_35_0._onOpenView, arg_35_0)
	arg_35_0:addEventCb(ViewMgr.instance, ViewEvent.OnCloseView, arg_35_0._onCloseView, arg_35_0)
	arg_35_0:addEventCb(RoomMapController.instance, RoomEvent.WillOpenRoomInitBuildingView, arg_35_0._willOpenRoomInitBuildingView, arg_35_0)
	arg_35_0:addEventCb(RoomCharacterController.instance, RoomEvent.UpdateCharacterInteractionUI, arg_35_0._updateCharacterInteractionUI, arg_35_0)
	arg_35_0:addEventCb(RoomMapController.instance, RoomEvent.ShowUI, arg_35_0._show, arg_35_0)
	arg_35_0:addEventCb(RoomMapController.instance, RoomEvent.HideUI, arg_35_0._hide, arg_35_0)
	arg_35_0:addEventCb(RoomMapController.instance, RoomEvent.UpdateRoomLevel, arg_35_0._updateRoomLevel, arg_35_0)
	arg_35_0:addEventCb(RoomMapController.instance, RoomEvent.SelectRoomViewBlockOpTab, arg_35_0._onSelectBlockOpTab, arg_35_0)
	arg_35_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyHide, arg_35_0._btnhideOnClick, arg_35_0)
	arg_35_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyEdit, arg_35_0._btneditOnClick, arg_35_0)
	arg_35_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyPlace, arg_35_0._btncharacterOnClick, arg_35_0)
	arg_35_0:addEventCb(PCInputController.instance, PCInputEvent.Notifylocate, arg_35_0._btntrackingOnClick, arg_35_0)
	arg_35_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyBuy, arg_35_0._btnstoreOnClick, arg_35_0)
	arg_35_0:addEventCb(PCInputController.instance, PCInputEvent.NotifyLayout, arg_35_0._btnlayoutplanOnClick, arg_35_0)
	arg_35_0:addEventCb(CritterController.instance, CritterEvent.onEnterCritterBuildingView, arg_35_0._hideView, arg_35_0)
	arg_35_0:addEventCb(ManufactureController.instance, ManufactureEvent.OnEnterManufactureBuildingView, arg_35_0._hideView, arg_35_0)
	arg_35_0:addEventCb(RoomController.instance, RoomEvent.NewLog, arg_35_0._showLogTips, arg_35_0)
	OpenController.instance:registerCallback(OpenEvent.NewFuncUnlock, arg_35_0._onNewFuncUnlock, arg_35_0)
	arg_35_0:addEventCb(RoomTradeController.instance, RoomTradeEvent.OnTradeLevelUpReply, arg_35_0._refreshTradeBtn, arg_35_0)
	arg_35_0:addEventCb(RoomController.instance, RoomEvent.ManufactureExpand, arg_35_0._onManufactureExpand, arg_35_0)

	if RoomController.instance:isObMode() then
		RoomRpc.instance:sendGetRoomLogRequest()
	end

	if ViewMgr.instance:isOpen(ViewName.RoomInitBuildingView) then
		arg_35_0:_hideView()
	end

	arg_35_0:_refreshManufactureExpand()
	arg_35_0:_addReddot()
	Activity186Model.instance:checkReadTasks({
		Activity186Enum.ReadTaskId.Task1,
		Activity186Enum.ReadTaskId.Task2,
		Activity186Enum.ReadTaskId.Task3
	})
end

function var_0_0.onOpenFinish(arg_36_0)
	arg_36_0:_refreshTradeBtn()
end

function var_0_0._addReddot(arg_37_0)
	RedDotController.instance:addRedDot(arg_37_0._goManufactureEntranceReddot, RedDotEnum.DotNode.ManufactureEntrance)
	RedDotController.instance:addRedDot(arg_37_0._goRecordReddot, RedDotEnum.DotNode.RecordEntrance)
	RedDotController.instance:addRedDot(arg_37_0._goCritterReddot, RedDotEnum.DotNode.CritterEntrance)
	RedDotController.instance:addRedDot(arg_37_0._goOverviewReddot, RedDotEnum.DotNode.OverviewEntrance)
	RedDotController.instance:addRedDot(arg_37_0._goTradeReddot, RedDotEnum.DotNode.TradeEntrance)
	RedDotController.instance:addRedDot(arg_37_0._goWarehouseReddot, RedDotEnum.DotNode.RoomBackpackEntrance)
end

function var_0_0._onOpenView(arg_38_0, arg_38_1)
	if arg_38_0:_isCheckHideView(arg_38_1) then
		arg_38_0:_hideView()
	end
end

function var_0_0._onCloseView(arg_39_0, arg_39_1)
	if arg_39_0:_isCheckHideView(arg_39_1) and not arg_39_0:_isHasNeedHideView() then
		arg_39_0:_showView()
		arg_39_0:_layoutPlanUnLockAnim()
		arg_39_0:_checkManufactureUnlock()
	end

	if arg_39_1 == ViewName.RoomManufactureGetView then
		local var_39_0 = ViewMgr.instance:isOpen(ViewName.RoomOverView)
		local var_39_1 = ViewMgr.instance:isOpen(ViewName.RoomManufactureBuildingView)
		local var_39_2 = ManufactureModel.instance:getExpandManufactureBtn()

		if arg_39_0._isShowManufactureBtn and not var_39_0 and not var_39_1 and var_39_2 then
			arg_39_0._warehouseAnimator:Play("charge", 0, 0)
			AudioMgr.instance:trigger(AudioEnum.Room.play_ui_home_shouji2)
		end
	end
end

function var_0_0._isCheckHideView(arg_40_0, arg_40_1)
	if arg_40_0._showHideViewNameDict[arg_40_1] then
		return true
	end

	return false
end

function var_0_0._isHasNeedHideView(arg_41_0)
	for iter_41_0 = 1, #arg_41_0._showHideViewNameList do
		if ViewMgr.instance:isOpen(arg_41_0._showHideViewNameList[iter_41_0]) then
			return true
		end
	end

	return false
end

function var_0_0._willOpenRoomInitBuildingView(arg_42_0)
	arg_42_0:_hideView()
end

function var_0_0._updateRoomLevel(arg_43_0)
	arg_43_0:_refreshLayoutPlan()
end

function var_0_0._refreshLayoutPlan(arg_44_0)
	local var_44_0 = RoomLayoutController.instance:isOpen()

	gohelper.setActive(arg_44_0._golayoutplanUnlock, var_44_0)
	gohelper.setActive(arg_44_0._golayoutplanLock, not var_44_0)
	gohelper.setActive(arg_44_0._golayoutcopyUnlock, var_44_0)
	gohelper.setActive(arg_44_0._golayoutcopyLock, not var_44_0)
	arg_44_0:_layoutPlanUnLockAnim()
end

function var_0_0._layoutPlanUnLockAnim(arg_45_0)
	if arg_45_0._isShowLayoutplan and RoomLayoutController.instance:isOpen() and not RoomLayoutModel.instance:getPlayUnLock() and not ViewMgr.instance:isOpen(ViewName.RoomInitBuildingView) then
		arg_45_0._layoutplanAnimator:Play("unlock", 0, 0)
		RoomLayoutModel.instance:setPlayUnLock(true)
	end
end

function var_0_0._refreshManufactureExpand(arg_46_0, arg_46_1)
	arg_46_0._warehouseAnimator:Play("idle", 0, 0)

	local var_46_0 = ManufactureModel.instance:getExpandManufactureBtn() and UIAnimationName.Open or UIAnimationName.Close

	if arg_46_1 then
		arg_46_0._manufactureAnimator:Play(var_46_0, 0, 0)
	else
		arg_46_0._manufactureAnimator:Play(var_46_0, 0, 1)
	end
end

function var_0_0._hideView(arg_47_0)
	arg_47_0._animator:Play(UIAnimationName.Close)
end

function var_0_0._showView(arg_48_0)
	arg_48_0._animator:Play(UIAnimationName.Open)
end

function var_0_0._refreshTradeBtn(arg_49_0)
	local var_49_0 = 0

	if ManufactureModel.instance:isManufactureUnlock() then
		var_49_0 = ManufactureModel.instance:getTradeLevel()
	end

	local var_49_1 = var_49_0 >= RoomTradeTaskModel.instance:getOpenOrderLevel()

	gohelper.setActive(arg_49_0._btnTrade.gameObject, var_49_1)

	if var_49_1 and RoomTradeModel.instance:isCanPlayTradeEnterBtnUnlockAnim() then
		if not arg_49_0._tradeBtnAnimator then
			arg_49_0._tradeBtnAnimator = SLFramework.AnimatorPlayer.Get(arg_49_0._btnTrade.gameObject)
		end

		arg_49_0._tradeBtnAnimator:Play(RoomTradeEnum.TradeAnim.Unlock, nil, arg_49_0)
		RoomTradeModel.instance:setPlayTradeEnterBtnUnlockAnim()
	end
end

function var_0_0._showLogTips(arg_50_0, arg_50_1)
	arg_50_0._haveLog = true

	gohelper.setActive(arg_50_0._gologtip, true)

	local var_50_0 = string.split(arg_50_1.config.extraBonus, "#")[2]

	if var_50_0 then
		arg_50_0._simagesticker:LoadImage(ResUrl.getPropItemIcon(var_50_0))
	end

	arg_50_0._txtlogdesc.text = arg_50_1.logConfigList[1].content

	TaskDispatcher.runDelay(arg_50_0._closeLogTips, arg_50_0, 6)
end

function var_0_0._closeLogTips(arg_51_0)
	arg_51_0._haveLog = false

	gohelper.setActive(arg_51_0._gologtip, false)
	RoomRpc.instance:sendReadRoomLogNewRequest()
end

function var_0_0._openLogView(arg_52_0)
	ViewMgr.instance:openView(ViewName.RoomRecordView, RoomRecordEnum.View.Log)
	arg_52_0:_closeLogTips()
end

function var_0_0._onManufactureExpand(arg_53_0, arg_53_1)
	local var_53_0 = tonumber(arg_53_1)

	if var_53_0 == 1 then
		ManufactureModel.instance:setExpandManufactureBtn(false)
		arg_53_0:_refreshManufactureExpand()
	elseif var_53_0 == 2 then
		ManufactureModel.instance:setExpandManufactureBtn(true)
		arg_53_0:_refreshManufactureExpand()
	elseif var_53_0 == 3 then
		-- block empty
	end
end

function var_0_0._onNewFuncUnlock(arg_54_0)
	arg_54_0:_checkManufactureUnlock()
	arg_54_0:_checkRoomFishingShow()
end

function var_0_0._checkManufactureUnlock(arg_55_0)
	ManufactureController.instance:getManufactureServerInfo()

	local var_55_0 = ManufactureModel.instance:isManufactureUnlock()

	gohelper.setActive(arg_55_0._gobtnexpandManufacture, var_55_0 and arg_55_0._isShowManufactureBtn)
	arg_55_0:_refreshManufactureExpand()

	local var_55_1 = ManufactureModel.instance:getPlayManufactureUnlock()
	local var_55_2 = ViewMgr.instance:isOpen(ViewName.RoomInitBuildingView)

	if arg_55_0._isShowManufactureBtn and var_55_0 and not var_55_1 and not var_55_2 then
		arg_55_0._manufactureAnimator:Play("unlock", 0, 0)
		ManufactureModel.instance:setPlayManufactureUnlock(true)
	end
end

function var_0_0._checkRoomFishingShow(arg_56_0)
	local var_56_0 = FishingModel.instance:isUnlockRoomFishing()

	gohelper.setActive(arg_56_0._btnfishing, var_56_0 and arg_56_0._isShowRoomFishingBtn)
end

function var_0_0.onClose(arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0._checkAStarFinish, arg_57_0)
	TaskDispatcher.cancelTask(arg_57_0._closeLogTips, arg_57_0)
	UIBlockMgr.instance:endBlock(UIBlockKey.RoomAStarScan)
	ViewMgr.instance:closeView(ViewName.RoomDebugView)
	arg_57_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyHide, arg_57_0._btnhideOnClick, arg_57_0)
	arg_57_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyEdit, arg_57_0._btneditOnClick, arg_57_0)
	arg_57_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyPlace, arg_57_0._btncharacterOnClick, arg_57_0)
	arg_57_0:removeEventCb(PCInputController.instance, PCInputEvent.Notifylocate, arg_57_0._btntrackingOnClick, arg_57_0)
	arg_57_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyBuy, arg_57_0._btnstoreOnClick, arg_57_0)
	arg_57_0:removeEventCb(PCInputController.instance, PCInputEvent.NotifyLayout, arg_57_0._btnlayoutplanOnClick, arg_57_0)
	arg_57_0:removeEventCb(CritterController.instance, CritterEvent.onEnterCritterBuildingView, arg_57_0._hideView, arg_57_0)
	arg_57_0:removeEventCb(RoomController.instance, RoomEvent.NewLog, arg_57_0._showLogTips, arg_57_0)
	OpenController.instance:unregisterCallback(OpenEvent.NewFuncUnlock, arg_57_0._onNewFuncUnlock, arg_57_0)
	arg_57_0:removeEventCb(RoomTradeController.instance, RoomTradeEvent.OnTradeLevelUpReply, arg_57_0._refreshTradeBtn, arg_57_0)
	arg_57_0:removeEventCb(RoomController.instance, RoomEvent.ManufactureExpand, arg_57_0._onManufactureExpand, arg_57_0)
end

function var_0_0.onDestroyView(arg_58_0)
	arg_58_0._simagemaskbg:UnLoadImage()
	arg_58_0._btnedit:RemoveClickListener()
	arg_58_0._btncharacter:RemoveClickListener()
	arg_58_0._btntracking:RemoveClickListener()
	arg_58_0._btndialog:RemoveClickListener()
	arg_58_0._btnhide:RemoveClickListener()
	arg_58_0._btnstore:RemoveClickListener()
	arg_58_0._btnlayoutplan:RemoveClickListener()
	arg_58_0._btnlayoutcopy:RemoveClickListener()
	arg_58_0._btnexpandManufacture:RemoveClickListener()
	arg_58_0._btngoto:RemoveClickListener()
end

return var_0_0
