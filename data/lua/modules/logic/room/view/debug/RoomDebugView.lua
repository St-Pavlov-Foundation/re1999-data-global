module("modules.logic.room.view.debug.RoomDebugView", package.seeall)

slot0 = class("RoomDebugView", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
end

function slot0.removeEvents(slot0)
end

function slot0._editableInitView(slot0)
	slot0._gonormalroot = gohelper.findChild(slot0.viewGO, "go_normalroot")
	slot0._txtcamera = gohelper.findChildText(slot0.viewGO, "go_normalroot/btn_camera/txt_camera")
	slot0._btnreset = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_debugreset")
	slot0._btncamera = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_camera")
	slot0._btndebugplace = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_debugplace")
	slot0._btndebugbuilding = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_debugbuilding")
	slot0._btndebugpackage = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_debugpackage")
	slot0._btnoutput = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_debugoutput")
	slot0._btnbuildingarea = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_buildingarea")
	slot0._blockoptab = gohelper.findChild(slot0.viewGO, "blockop_tab")

	slot0._btnreset:AddClickListener(slot0._btnresetOnClick, slot0)
	slot0._btncamera:AddClickListener(slot0._btncameraOnClick, slot0)
	slot0._btndebugplace:AddClickListener(slot0._btndebugplaceOnClick, slot0)
	slot0._btndebugbuilding:AddClickListener(slot0._btndebugbuildingOnClick, slot0)
	slot0._btndebugpackage:AddClickListener(slot0._btndebugpackageOnClick, slot0)
	slot0._btnoutput:AddClickListener(slot0._btnoutputOnClick, slot0)
	slot0._btnbuildingarea:AddClickListener(slot0._btnbuildingareaOnClick, slot0)

	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._rootCanvasGroup = slot0.viewGO:GetComponent(typeof(UnityEngine.CanvasGroup))
	slot0._animator = slot0.viewGO:GetComponent(typeof(UnityEngine.Animator))
	slot0._canvasGroup = slot0._gonormalroot:GetComponent(typeof(UnityEngine.CanvasGroup))

	if RoomInventoryBlockModel.instance:openSelectOp() then
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "go_normalroot/go_inventory"), false)
		gohelper.setActive(gohelper.findChild(slot0.viewGO, "go_normalroot/go_inventorytask"), false)
	end

	slot0:_cameraStateUpdate()
	slot0:_updateNavigateButtonShow()
end

function slot0._btnresetOnClick(slot0)
	if GuideModel.instance:isFlagEnable(GuideModel.GuideFlag.RoomForbidBtn) then
		GameFacade.showToast(RoomEnum.GuideForbidEscapeToast)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomReset, MsgBoxEnum.BoxType.Yes_No, uv0._resetYesCallback)
	end
end

function slot0._btncameraOnClick(slot0)
	if slot0._scene.camera:getCameraState() == RoomEnum.CameraState.Normal then
		slot0._scene.camera:switchCameraState(RoomEnum.CameraState.Overlook, {})
	elseif slot1 == RoomEnum.CameraState.Overlook then
		slot0._scene.camera:switchCameraState(RoomEnum.CameraState.Normal, {})
	end
end

function slot0._btndebugplaceOnClick(slot0)
	RoomDebugController.instance:setDebugPlaceListShow(true)
end

function slot0._btndebugbuildingOnClick(slot0)
	RoomDebugController.instance:setDebugBuildingListShow(true)
end

function slot0._btndebugpackageOnClick(slot0)
	RoomDebugController.instance:setDebugPackageListShow(true)
end

function slot0._btnbuildingareaOnClick(slot0)
	RoomDebugController.instance:openBuildingAreaView()
end

function slot0._btnoutputOnClick(slot0)
	RoomDebugController.instance:output()
end

function slot0._resetYesCallback()
	RoomMapController.instance:resetRoom()
end

function slot0._listViewShowChanged(slot0)
	slot0:_refreshBtnShow()
end

function slot0._updateCharacterInteractionUI(slot0)
	slot0:_refreshBtnShow()
	slot0:_updateNavigateButtonShow()
end

function slot0._updateNavigateButtonShow(slot0)
end

function slot0._cameraStateUpdate(slot0)
	if slot0._scene.camera:getCameraState() == RoomEnum.CameraState.Overlook then
		slot0._txtcamera.text = luaLang("roomstandbyview_highview")
	elseif slot1 == RoomEnum.CameraState.Normal then
		slot0._txtcamera.text = luaLang("roomstandbyview_lowview")
	end
end

function slot0._addBtnAudio(slot0)
	gohelper.addUIClickAudio(slot0._btnreset.gameObject, AudioEnum.UI.UI_vertical_first_tabs_click)
end

function slot0._refreshBtnShow(slot0)
	slot4 = RoomDebugController.instance:isDebugPlaceListShow() or RoomDebugController.instance:isDebugPackageListShow() or RoomDebugController.instance:isDebugBuildingListShow()

	gohelper.setActive(slot0._btnreset.gameObject, RoomController.instance:isDebugMode() and not slot4 and not RoomController.instance:isEditMode())
	gohelper.setActive(slot0._btndebugplace.gameObject, RoomController.instance:isDebugMode() and not slot4)
	gohelper.setActive(slot0._btndebugpackage.gameObject, RoomController.instance:isDebugPackageMode() and not slot4)
	gohelper.setActive(slot0._btndebugbuilding.gameObject, RoomController.instance:isDebugPackageMode() and not slot4)
	gohelper.setActive(slot0._btncamera.gameObject, RoomController.instance:isObMode() and not slot4 or RoomController.instance:isVisitMode() or RoomController.instance:isDebugMode())
	gohelper.setActive(slot0._btnoutput.gameObject, (RoomController.instance:isDebugInitMode() or RoomController.instance:isDebugPackageMode()) and not slot4)
end

function slot0.onOpen(slot0)
	slot0:_refreshBtnShow()
	slot0:_addBtnAudio()
	slot0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPlaceListShowChanged, slot0._listViewShowChanged, slot0)
	slot0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPackageListShowChanged, slot0._listViewShowChanged, slot0)
	slot0:addEventCb(RoomDebugController.instance, RoomEvent.DebugBuildingListShowChanged, slot0._listViewShowChanged, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.CameraStateUpdate, slot0._cameraStateUpdate, slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.BackBlockShowChanged, slot0._updateNavigateButtonShow, slot0)
	slot0:addEventCb(RoomBuildingController.instance, RoomEvent.RefreshNavigateButton, slot0._updateNavigateButtonShow, slot0)
	slot0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPlaceListShowChanged, slot0._updateNavigateButtonShow, slot0)
	slot0:addEventCb(RoomDebugController.instance, RoomEvent.DebugPackageListShowChanged, slot0._updateNavigateButtonShow, slot0)
	slot0:addEventCb(RoomDebugController.instance, RoomEvent.DebugBuildingListShowChanged, slot0._updateNavigateButtonShow, slot0)
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._btnreset:RemoveClickListener()
	slot0._btncamera:RemoveClickListener()
	slot0._btndebugplace:RemoveClickListener()
	slot0._btndebugbuilding:RemoveClickListener()
	slot0._btndebugpackage:RemoveClickListener()
	slot0._btnoutput:RemoveClickListener()
	slot0._btnbuildingarea:RemoveClickListener()
end

return slot0
