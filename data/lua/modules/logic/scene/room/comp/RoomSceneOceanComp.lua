module("modules.logic.scene.room.comp.RoomSceneOceanComp", package.seeall)

slot0 = class("RoomSceneOceanComp", BaseSceneComp)

function slot0.onInit(slot0)
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()

	slot0._scene.loader:makeSureLoaded({
		RoomScenePreloader.ResOcean
	}, slot0._OnGetInstance, slot0)
end

function slot0._OnGetInstance(slot0, slot1)
	slot0._oceanGO = RoomGOPool.getInstance(RoomScenePreloader.ResOcean, slot0._scene.go.waterRoot, "ocean")
	slot0._oceanFogGO = gohelper.findChild(slot0._oceanGO, "bxhy_ground_water_fog")
	slot0._fogAngle = nil

	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, slot0._cameraTransformUpdate, slot0)
end

function slot0._cameraTransformUpdate(slot0)
	slot0:_refreshPosition()
	slot0:_refreshFogRotation()
end

function slot0.setOceanFog(slot0, slot1)
	if not slot0._oceanFogGO then
		return
	end

	slot2, slot3, slot4 = transformhelper.getLocalPos(slot0._oceanFogGO.transform)

	transformhelper.setLocalPos(slot0._oceanFogGO.transform, slot2, slot1, slot4)
end

function slot0._refreshPosition(slot0)
	slot1 = slot0._scene.camera:getCameraPosition()

	transformhelper.setLocalPos(slot0._oceanGO.transform, slot1.x, 0, slot1.z)
end

function slot0._refreshFogRotation(slot0)
	if not slot0._oceanFogGO then
		return
	end

	slot3 = slot0._fogAngle or slot0._oceanFogGO.transform.localEulerAngles
	slot0._fogAngle = Vector3(slot3.x, slot3.y, CameraMgr.instance:getMainCameraGO().transform.eulerAngles.y + 94.4)
	slot0._oceanFogGO.transform.localEulerAngles = slot0._fogAngle
end

function slot0.onSceneClose(slot0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, slot0._cameraTransformUpdate, slot0)

	slot0._oceanGO = nil
end

return slot0
