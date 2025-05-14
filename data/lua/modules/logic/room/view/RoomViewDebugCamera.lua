module("modules.logic.room.view.RoomViewDebugCamera", package.seeall)

local var_0_0 = class("RoomViewDebugCamera", BaseView)

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
	arg_4_0._btndebugcameraoverlookfarest = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_debugcameraoverlookfarest")
	arg_4_0._btndebugcameraoverlooknearest = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_debugcameraoverlooknearest")
	arg_4_0._btndebugcameranormal = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_debugcameranormal")
	arg_4_0._btndebugcameracharacter = gohelper.findChildButtonWithAudio(arg_4_0.viewGO, "go_normalroot/btn_debugcameracharacter")

	arg_4_0._btndebugcameraoverlookfarest:AddClickListener(arg_4_0._btndebugcameraoverlookfarestOnClick, arg_4_0)
	arg_4_0._btndebugcameraoverlooknearest:AddClickListener(arg_4_0._btndebugcameraoverlooknearestOnClick, arg_4_0)
	arg_4_0._btndebugcameranormal:AddClickListener(arg_4_0._btndebugcameranormalOnClick, arg_4_0)
	arg_4_0._btndebugcameracharacter:AddClickListener(arg_4_0._btndebugcameracharacterOnClick, arg_4_0)

	arg_4_0._scene = GameSceneMgr.instance:getCurScene()
end

function var_0_0._btndebugcameraoverlookfarestOnClick(arg_5_0)
	arg_5_0._scene.camera:switchCameraState(RoomEnum.CameraState.Overlook, {
		zoom = 1
	})
end

function var_0_0._btndebugcameraoverlooknearestOnClick(arg_6_0)
	arg_6_0._scene.camera:switchCameraState(RoomEnum.CameraState.Overlook, {
		zoom = 0
	})
end

function var_0_0._btndebugcameranormalOnClick(arg_7_0)
	arg_7_0._scene.camera:switchCameraState(RoomEnum.CameraState.Normal, {})
end

function var_0_0._btndebugcameracharacterOnClick(arg_8_0)
	arg_8_0._scene.camera:switchCameraState(RoomEnum.CameraState.Character, {})
end

function var_0_0._refreshUI(arg_9_0)
	gohelper.setActive(arg_9_0._btndebugcameraoverlookfarest.gameObject, RoomController.instance:isDebugMode())
	gohelper.setActive(arg_9_0._btndebugcameraoverlooknearest.gameObject, RoomController.instance:isDebugMode())
	gohelper.setActive(arg_9_0._btndebugcameranormal.gameObject, RoomController.instance:isDebugMode())
	gohelper.setActive(arg_9_0._btndebugcameracharacter.gameObject, RoomController.instance:isDebugMode())
end

function var_0_0.onOpen(arg_10_0)
	arg_10_0:_refreshUI()
end

function var_0_0.onClose(arg_11_0)
	return
end

function var_0_0.onDestroyView(arg_12_0)
	arg_12_0._btndebugcameraoverlookfarest:RemoveClickListener()
	arg_12_0._btndebugcameraoverlooknearest:RemoveClickListener()
	arg_12_0._btndebugcameranormal:RemoveClickListener()
	arg_12_0._btndebugcameracharacter:RemoveClickListener()
end

return var_0_0
