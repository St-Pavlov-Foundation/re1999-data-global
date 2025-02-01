module("modules.logic.room.view.RoomViewDebugCamera", package.seeall)

slot0 = class("RoomViewDebugCamera", BaseView)

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
	slot0._btndebugcameraoverlookfarest = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_debugcameraoverlookfarest")
	slot0._btndebugcameraoverlooknearest = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_debugcameraoverlooknearest")
	slot0._btndebugcameranormal = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_debugcameranormal")
	slot0._btndebugcameracharacter = gohelper.findChildButtonWithAudio(slot0.viewGO, "go_normalroot/btn_debugcameracharacter")

	slot0._btndebugcameraoverlookfarest:AddClickListener(slot0._btndebugcameraoverlookfarestOnClick, slot0)
	slot0._btndebugcameraoverlooknearest:AddClickListener(slot0._btndebugcameraoverlooknearestOnClick, slot0)
	slot0._btndebugcameranormal:AddClickListener(slot0._btndebugcameranormalOnClick, slot0)
	slot0._btndebugcameracharacter:AddClickListener(slot0._btndebugcameracharacterOnClick, slot0)

	slot0._scene = GameSceneMgr.instance:getCurScene()
end

function slot0._btndebugcameraoverlookfarestOnClick(slot0)
	slot0._scene.camera:switchCameraState(RoomEnum.CameraState.Overlook, {
		zoom = 1
	})
end

function slot0._btndebugcameraoverlooknearestOnClick(slot0)
	slot0._scene.camera:switchCameraState(RoomEnum.CameraState.Overlook, {
		zoom = 0
	})
end

function slot0._btndebugcameranormalOnClick(slot0)
	slot0._scene.camera:switchCameraState(RoomEnum.CameraState.Normal, {})
end

function slot0._btndebugcameracharacterOnClick(slot0)
	slot0._scene.camera:switchCameraState(RoomEnum.CameraState.Character, {})
end

function slot0._refreshUI(slot0)
	gohelper.setActive(slot0._btndebugcameraoverlookfarest.gameObject, RoomController.instance:isDebugMode())
	gohelper.setActive(slot0._btndebugcameraoverlooknearest.gameObject, RoomController.instance:isDebugMode())
	gohelper.setActive(slot0._btndebugcameranormal.gameObject, RoomController.instance:isDebugMode())
	gohelper.setActive(slot0._btndebugcameracharacter.gameObject, RoomController.instance:isDebugMode())
end

function slot0.onOpen(slot0)
	slot0:_refreshUI()
end

function slot0.onClose(slot0)
end

function slot0.onDestroyView(slot0)
	slot0._btndebugcameraoverlookfarest:RemoveClickListener()
	slot0._btndebugcameraoverlooknearest:RemoveClickListener()
	slot0._btndebugcameranormal:RemoveClickListener()
	slot0._btndebugcameracharacter:RemoveClickListener()
end

return slot0
