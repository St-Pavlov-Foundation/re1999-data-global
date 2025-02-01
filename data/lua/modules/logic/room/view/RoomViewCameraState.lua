module("modules.logic.room.view.RoomViewCameraState", package.seeall)

slot0 = class("RoomViewCameraState", BaseView)

function slot0.onInitView(slot0)
	if slot0._editableInitView then
		slot0:_editableInitView()
	end
end

function slot0.addEvents(slot0)
	slot0._btncamera:AddClickListener(slot0._btncameraOnClick, slot0)
	slot0._btncameramask:AddClickListener(slot0._btncameramaskOnClick, slot0)
end

function slot0.removeEvents(slot0)
	slot0._btncamera:RemoveClickListener()
	slot0._btncameramask:RemoveClickListener()
end

function slot0._editableInitView(slot0)
	slot0._btncamera = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_camera")
	slot0._btncameramask = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_cameramask")
	slot0._gocameraexpand = gohelper.findChild(slot0.viewGO, "go_normalroot/#go_cameraexpand")
	slot0._gocameritem = gohelper.findChild(slot0.viewGO, "go_normalroot/#go_cameraexpand/go_cameritem")
	slot0._txtcamera = gohelper.findChildText(slot0.viewGO, "go_normalroot/btn_camera/txt_camera")
	slot0._imageicon = gohelper.findChildImage(slot0.viewGO, "go_normalroot/btn_camera/image_icon")
	slot0._scene = GameSceneMgr.instance:getCurScene()
	slot0._cameraStateDataList = {
		{
			landKey = "roomstandbyview_highview_all",
			icon = "zuoce_ziyuan_quanlanshijiao",
			cameraState = RoomEnum.CameraState.OverlookAll
		},
		{
			landKey = "roomstandbyview_highview",
			icon = "zuoce_ziyuan_gaoshijiao",
			cameraState = RoomEnum.CameraState.Overlook
		},
		{
			landKey = "roomstandbyview_lowview",
			icon = "zuoce_ziyuan_pingshijiao",
			cameraState = RoomEnum.CameraState.Normal
		}
	}
	slot0._cameraTbList = {}

	for slot4, slot5 in ipairs(slot0._cameraStateDataList) do
		table.insert(slot0._cameraTbList, slot0:_createCameraTb(gohelper.cloneInPlace(slot0._gocameritem), slot5))
	end

	gohelper.setActive(slot0._gocameritem, false)
	gohelper.setActive(slot0._gocameraexpand, false)
end

function slot0._createCameraTb(slot0, slot1, slot2)
	slot3 = slot0:getUserDataTb_()
	slot3.go = slot1
	slot3.stateData = slot2
	slot3.goselect = gohelper.findChild(slot1, "go_select")
	slot3.btn = gohelper.findButtonWithAudio(slot1)
	slot3.txtcamera = gohelper.findChildText(slot1, "txt_camera")
	slot3.imageicon = gohelper.findChildImage(slot1, "image_icon")

	function slot3.dispose(slot0)
		slot0.btn:RemoveClickListener()
	end

	slot3.btn:AddClickListener(slot0._onCameraTbOnClick, slot0, slot3)
	UISpriteSetMgr.instance:setRoomSprite(slot3.imageicon, slot2.icon)

	slot3.txtcamera.text = luaLang(slot2.landKey)

	return slot3
end

function slot0._btncameraOnClick(slot0)
	slot0:_showExpand(slot0._isShowExpand ~= true)
end

function slot0._btncameramaskOnClick(slot0)
	slot0:_showExpand(false)
end

function slot0._onCameraTbOnClick(slot0, slot1)
	if slot0._scene.camera:getCameraState() ~= slot1.stateData.cameraState then
		slot0._scene.camera:switchCameraState(slot1.stateData.cameraState, {}, nil, slot0._finishSwitchCameraState, slot0)
	end

	slot0:_showExpand(false)
end

function slot0._finishSwitchCameraState(slot0)
	if slot0._scene and slot0._scene.audio then
		slot0._scene.audio:changeRTPCValue()
	end
end

function slot0._refreshSelect(slot0)
	for slot5, slot6 in ipairs(slot0._cameraTbList) do
		gohelper.setActive(slot6.goselect, slot0._scene.camera:getCameraState() == slot6.stateData.cameraState)
	end
end

function slot0._showExpand(slot0, slot1)
	slot0._isShowExpand = slot1

	gohelper.setActive(slot0._gocameraexpand, slot1)
	gohelper.setActive(slot0._btncameramask, slot1)
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

function slot0._cameraStateUpdate(slot0)
	if slot0:_getStateData(slot0._scene.camera:getCameraState()) then
		slot0._txtcamera.text = luaLang(slot2.landKey)

		UISpriteSetMgr.instance:setRoomSprite(slot0._imageicon, slot2.icon)
		slot0:_refreshSelect()
	else
		slot0:_showExpand(false)
	end
end

function slot0._getStateData(slot0, slot1)
	for slot5, slot6 in ipairs(slot0._cameraStateDataList) do
		if slot6.cameraState == slot1 then
			return slot6
		end
	end
end

function slot0.onOpen(slot0)
	slot0:addEventCb(RoomMapController.instance, RoomEvent.CameraStateUpdate, slot0._cameraStateUpdate, slot0)
	slot0:_cameraStateUpdate()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	if slot0._cameraTbList then
		for slot4, slot5 in ipairs(slot0._cameraTbList) do
			slot5:dispose()
		end

		slot0._cameraTbList = nil
	end
end

return slot0
