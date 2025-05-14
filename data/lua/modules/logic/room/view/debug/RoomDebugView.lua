module("modules.logic.room.view.debug.RoomDebugView", package.seeall)

local var_0_0 = class("RoomDebugView", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	return
end

function var_0_0.removeEvents(arg_3_0)
	return
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._gonormalroot = gohelper.findChild(arg_4_0.viewGO, "go_normalroot")
	arg_4_0._txtcamera = gohelper.findChildText(arg_4_0.viewGO, "go_normalroot/btn_camera/txt_camera")
	arg_4_0._btnreset = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_debugreset")
	arg_4_0._btncamera = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_camera")
	arg_4_0._btndebugplace = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_debugplace")
	arg_4_0._btndebugbuilding = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_debugbuilding")
	arg_4_0._btndebugpackage = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_debugpackage")
	arg_4_0._btnoutput = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_debugoutput")
	arg_4_0._btnbuildingarea = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_buildingarea")
	arg_4_0._blockoptab = gohelper.findChild(arg_4_0.viewGO, "blockop_tab")

	arg_4_0._btnreset:AddClickListener(arg_4_0._btnresetOnClick, arg_4_0)
	arg_4_0._btncamera:AddClickListener(arg_4_0._btncameraOnClick, arg_4_0)
	arg_4_0._btndebugplace:AddClickListener(arg_4_0._btndebugplaceOnClick, arg_4_0)
	arg_4_0._btndebugbuilding:AddClickListener(arg_4_0._btndebugbuildingOnClick, arg_4_0)
	arg_4_0._btndebugpackage:AddClickListener(arg_4_0._btndebugpackageOnClick, arg_4_0)
	arg_4_0._btnoutput:AddClickListener(arg_4_0._btnoutputOnClick, arg_4_0)
	arg_4_0._btnbuildingarea:AddClickListener(arg_4_0._btnbuildingareaOnClick, arg_4_0)

	arg_4_0._scene = GameSceneMgr.instance:getCurScene()
	arg_4_0._rootCanvasGroup = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	arg_4_0._animator = arg_4_0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	arg_4_0._canvasGroup = arg_4_0._gonormalroot:GetComponent(typeof(UnityEngine.CanvasGroup))

	if RoomInventoryBlockModel.instance:openSelectOp() then
		gohelper.setActive(gohelper.findChild(arg_4_0.viewGO, "go_normalroot/go_inventory"), false)
		gohelper.setActive(gohelper.findChild(arg_4_0.viewGO, "go_normalroot/go_inventorytask"), false)
	end

	arg_4_0:_cameraStateUpdate()
	arg_4_0:_updateNavigateButtonShow()
end

function var_0_0._btnresetOnClick(arg_5_0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomReset, MsgBoxEnum.BoxType.Yes_No, var_0_0._resetYesCallback)
	end
end

function var_0_0._btncameraOnClick(arg_6_0)
	local var_6_0 = arg_6_0._scene.camera:getCameraState()

	if var_6_0 == RoomEnum.CameraState.Normal then
		arg_6_0._scene.camera:switchCameraState(RoomEnum.CameraState.Overlook, {})
	elseif var_6_0 == RoomEnum.CameraState.Overlook then
		arg_6_0._scene.camera:switchCameraState(RoomEnum.CameraState.Normal, {})
	end
end

function var_0_0._btndebugplaceOnClick(arg_7_0)
	RoomDebugController.instance:setDebugPlaceListShow(true)
end

function var_0_0._btndebugbuildingOnClick(arg_8_0)
	RoomDebugController.instance:setDebugBuildingListShow(true)
end

function var_0_0._btndebugpackageOnClick(arg_9_0)
	RoomDebugController.instance:setDebugPackageListShow(true)
end

function var_0_0._btnbuildingareaOnClick(arg_10_0)
	RoomDebugController.instance:openBuildingAreaView()
end

function var_0_0._btnoutputOnClick(arg_11_0)
	RoomDebugController.instance:output()
end

function var_0_0._resetYesCallback()
	RoomMapController.instance:resetRoom()
end

function var_0_0._listViewShowChanged(arg_13_0)
	arg_13_0:_refreshBtnShow()
end

function var_0_0._updateCharacterInteractionUI(arg_14_0)
	arg_14_0:_refreshBtnShow()
	arg_14_0:_updateNavigateButtonShow()
end

function var_0_0._updateNavigateButtonShow(arg_15_0)
	return
end

function var_0_0._cameraStateUpdate(arg_16_0)
	local var_16_0 = arg_16_0._scene.camera:getCameraState()

	if var_16_0 == RoomEnum.CameraState.Overlook then
		arg_16_0._txtcamera.text = luaLang("roomstandbyview_highview")
	elseif var_16_0 == RoomEnum.CameraState.Normal then
		arg_16_0._txtcamera.text = luaLang("roomstandbyview_lowview")
	end
end

function var_0_0._addBtnAudio(arg_17_0)
	gohelper.addUIClickAudio(arg_17_0._btnreset.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function var_0_0._refreshBtnShow(arg_18_0)
	local var_18_0 = RoomDebugController.instance:isDebugPlaceListShow()
	local var_18_1 = RoomDebugController.instance:isDebugPackageListShow()
	local var_18_2 = RoomDebugController.instance:isDebugBuildingListShow()
	local var_18_3 = var_18_0 or var_18_1 or var_18_2

	gohelper.setActive(arg_18_0._btnreset.gameObject, RoomController.instance:isDebugMode() and not var_18_3 and not RoomController.instance:isEditMode())
	gohelper.setActive(arg_18_0._btndebugplace.gameObject, RoomController.instance:isDebugMode() and not var_18_3)
	gohelper.setActive(arg_18_0._btndebugpackage.gameObject, RoomController.instance:isDebugPackageMode() and not var_18_3)
	gohelper.setActive(arg_18_0._btndebugbuilding.gameObject, RoomController.instance:isDebugPackageMode() and not var_18_3)
	gohelper.setActive(arg_18_0._btncamera.gameObject, RoomController.instance:isObMode() and not var_18_3 or RoomController.instance:isVisitMode() or RoomController.instance:isDebugMode())
	gohelper.setActive(arg_18_0._btnoutput.gameObject, (RoomController.instance:isDebugInitMode() or RoomController.instance:isDebugPackageMode()) and not var_18_3)
end

function var_0_0.onOpen(arg_19_0)
	arg_19_0:_refreshBtnShow()
	arg_19_0:_addBtnAudio()
	arg_19_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPlaceListShowChanged, arg_19_0._listViewShowChanged, arg_19_0)
	arg_19_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPackageListShowChanged, arg_19_0._listViewShowChanged, arg_19_0)
	arg_19_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugBuildingListShowChanged, arg_19_0._listViewShowChanged, arg_19_0)
	arg_19_0:addEventCb(RoomMapController.instance, RoomEvent.CameraStateUpdate, arg_19_0._cameraStateUpdate, arg_19_0)
	arg_19_0:addEventCb(RoomMapController.instance, RoomEvent.BackBlockShowChanged, arg_19_0._updateNavigateButtonShow, arg_19_0)
	arg_19_0:addEventCb(RoomBuildingController.instance, RoomEvent.RefreshNavigateButton, arg_19_0._updateNavigateButtonShow, arg_19_0)
	arg_19_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPlaceListShowChanged, arg_19_0._updateNavigateButtonShow, arg_19_0)
	arg_19_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPackageListShowChanged, arg_19_0._updateNavigateButtonShow, arg_19_0)
	arg_19_0:addEventCb(RoomDebugController.instance, RoomEvent.DebugBuildingListShowChanged, arg_19_0._updateNavigateButtonShow, arg_19_0)
end

function var_0_0.onClose(arg_20_0)
	return
end

function var_0_0.onDestroyView(arg_21_0)
	arg_21_0._btnreset:RemoveClickListener()
	arg_21_0._btncamera:RemoveClickListener()
	arg_21_0._btndebugplace:RemoveClickListener()
	arg_21_0._btndebugbuilding:RemoveClickListener()
	arg_21_0._btndebugpackage:RemoveClickListener()
	arg_21_0._btnoutput:RemoveClickListener()
	arg_21_0._btnbuildingarea:RemoveClickListener()
end

return var_0_0
