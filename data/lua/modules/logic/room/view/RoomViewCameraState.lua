module("modules.logic.room.view.RoomViewCameraState", package.seeall)

local var_0_0 = class("RoomViewCameraState", BaseView)

function var_0_0.onInitView(arg_1_0)
	if arg_1_0._editableInitView then
		arg_1_0:_editableInitView()
	end
end

function var_0_0.addEvents(arg_2_0)
	arg_2_0._btncamera:AddClickListener(arg_2_0._btncameraOnClick, arg_2_0)
	arg_2_0._btncameramask:AddClickListener(arg_2_0._btncameramaskOnClick, arg_2_0)
end

function var_0_0.removeEvents(arg_3_0)
	arg_3_0._btncamera:RemoveClickListener()
	arg_3_0._btncameramask:RemoveClickListener()
end

function var_0_0._editableInitView(arg_4_0)
	arg_4_0._btncamera = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_camera")
	arg_4_0._btncameramask = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_cameramask")
	arg_4_0._gocameraexpand = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/#go_cameraexpand")
	arg_4_0._gocameritem = gohelper.findChild(arg_4_0.viewGO, "go_normalroot/#go_cameraexpand/go_cameritem")
	arg_4_0._txtcamera = gohelper.findChildText(arg_4_0.viewGO, "go_normalroot/btn_camera/txt_camera")
	arg_4_0._imageicon = gohelper.findChildImage(arg_4_0.viewGO, "go_normalroot/btn_camera/image_icon")
	arg_4_0._scene = GameSceneMgr.instance:getCurScene()
	arg_4_0._cameraStateDataList = {
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
	arg_4_0._cameraTbList = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_0._cameraStateDataList) do
		local var_4_0 = gohelper.cloneInPlace(arg_4_0._gocameritem)
		local var_4_1 = arg_4_0:_createCameraTb(var_4_0, iter_4_1)

		table.insert(arg_4_0._cameraTbList, var_4_1)
	end

	gohelper.setActive(arg_4_0._gocameritem, false)
	gohelper.setActive(arg_4_0._gocameraexpand, false)
end

function var_0_0._createCameraTb(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0:getUserDataTb_()

	var_5_0.go = arg_5_1
	var_5_0.stateData = arg_5_2
	var_5_0.goselect = gohelper.findChild(arg_5_1, "go_select")
	var_5_0.btn = gohelper.findButtonWithAudio(arg_5_1)
	var_5_0.txtcamera = gohelper.findChildText(arg_5_1, "txt_camera")
	var_5_0.imageicon = gohelper.findChildImage(arg_5_1, "image_icon")

	function var_5_0.dispose(arg_6_0)
		arg_6_0.btn:RemoveClickListener()
	end

	var_5_0.btn:AddClickListener(arg_5_0._onCameraTbOnClick, arg_5_0, var_5_0)
	UISpriteSetMgr.instance:setRoomSprite(var_5_0.imageicon, arg_5_2.icon)

	var_5_0.txtcamera.text = luaLang(arg_5_2.landKey)

	return var_5_0
end

function var_0_0._btncameraOnClick(arg_7_0)
	arg_7_0:_showExpand(arg_7_0._isShowExpand ~= true)
end

function var_0_0._btncameramaskOnClick(arg_8_0)
	arg_8_0:_showExpand(false)
end

function var_0_0._onCameraTbOnClick(arg_9_0, arg_9_1)
	if arg_9_0._scene.camera:getCameraState() ~= arg_9_1.stateData.cameraState then
		arg_9_0._scene.camera:switchCameraState(arg_9_1.stateData.cameraState, {}, nil, arg_9_0._finishSwitchCameraState, arg_9_0)
	end

	arg_9_0:_showExpand(false)
end

function var_0_0._finishSwitchCameraState(arg_10_0)
	if arg_10_0._scene and arg_10_0._scene.audio then
		arg_10_0._scene.audio:changeRTPCValue()
	end
end

function var_0_0._refreshSelect(arg_11_0)
	local var_11_0 = arg_11_0._scene.camera:getCameraState()

	for iter_11_0, iter_11_1 in ipairs(arg_11_0._cameraTbList) do
		gohelper.setActive(iter_11_1.goselect, var_11_0 == iter_11_1.stateData.cameraState)
	end
end

function var_0_0._showExpand(arg_12_0, arg_12_1)
	arg_12_0._isShowExpand = arg_12_1

	gohelper.setActive(arg_12_0._gocameraexpand, arg_12_1)
	gohelper.setActive(arg_12_0._btncameramask, arg_12_1)
end

function var_0_0._btntrackingOnClick(arg_13_0)
	local var_13_0 = arg_13_0._scene.camera:getCameraFocus()

	if arg_13_0._scene.camera:getCameraState() == RoomEnum.CameraState.Overlook and math.abs(var_13_0.x) < 0.1 and math.abs(var_13_0.y) < 0.1 then
		GameFacade.showToast(ToastEnum.ClickRoomTracking)

		return
	end

	arg_13_0._scene.camera:switchCameraState(RoomEnum.CameraState.Overlook, {
		focusX = 0,
		focusY = 0
	})
end

function var_0_0._cameraStateUpdate(arg_14_0)
	local var_14_0 = arg_14_0._scene.camera:getCameraState()
	local var_14_1 = arg_14_0:_getStateData(var_14_0)

	if var_14_1 then
		arg_14_0._txtcamera.text = luaLang(var_14_1.landKey)

		UISpriteSetMgr.instance:setRoomSprite(arg_14_0._imageicon, var_14_1.icon)
		arg_14_0:_refreshSelect()
	else
		arg_14_0:_showExpand(false)
	end
end

function var_0_0._getStateData(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in ipairs(arg_15_0._cameraStateDataList) do
		if iter_15_1.cameraState == arg_15_1 then
			return iter_15_1
		end
	end
end

function var_0_0.onOpen(arg_16_0)
	arg_16_0:addEventCb(RoomMapController.instance, RoomEvent.CameraStateUpdate, arg_16_0._cameraStateUpdate, arg_16_0)
	arg_16_0:_cameraStateUpdate()
end

function var_0_0.onClose(arg_17_0)
	return
end

function var_0_0.onDestroyView(arg_18_0)
	if arg_18_0._cameraTbList then
		for iter_18_0, iter_18_1 in ipairs(arg_18_0._cameraTbList) do
			iter_18_1:dispose()
		end

		arg_18_0._cameraTbList = nil
	end
end

return var_0_0
