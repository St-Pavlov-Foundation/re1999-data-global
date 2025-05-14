module("modules.logic.scene.room.comp.RoomSceneOceanComp", package.seeall)

local var_0_0 = class("RoomSceneOceanComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	return
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()

	arg_2_0._scene.loader:makeSureLoaded({
		RoomScenePreloader.ResOcean
	}, arg_2_0._OnGetInstance, arg_2_0)
end

function var_0_0._OnGetInstance(arg_3_0, arg_3_1)
	arg_3_0._oceanGO = RoomGOPool.getInstance(RoomScenePreloader.ResOcean, arg_3_0._scene.go.waterRoot, "ocean")
	arg_3_0._oceanFogGO = gohelper.findChild(arg_3_0._oceanGO, "bxhy_ground_water_fog")
	arg_3_0._fogAngle = nil

	RoomMapController.instance:registerCallback(RoomEvent.CameraTransformUpdate, arg_3_0._cameraTransformUpdate, arg_3_0)
end

function var_0_0._cameraTransformUpdate(arg_4_0)
	arg_4_0:_refreshPosition()
	arg_4_0:_refreshFogRotation()
end

function var_0_0.setOceanFog(arg_5_0, arg_5_1)
	if not arg_5_0._oceanFogGO then
		return
	end

	local var_5_0, var_5_1, var_5_2 = transformhelper.getLocalPos(arg_5_0._oceanFogGO.transform)

	transformhelper.setLocalPos(arg_5_0._oceanFogGO.transform, var_5_0, arg_5_1, var_5_2)
end

function var_0_0._refreshPosition(arg_6_0)
	local var_6_0 = arg_6_0._scene.camera:getCameraPosition()

	transformhelper.setLocalPos(arg_6_0._oceanGO.transform, var_6_0.x, 0, var_6_0.z)
end

function var_0_0._refreshFogRotation(arg_7_0)
	if not arg_7_0._oceanFogGO then
		return
	end

	local var_7_0 = CameraMgr.instance:getMainCameraGO().transform.eulerAngles
	local var_7_1 = arg_7_0._fogAngle or arg_7_0._oceanFogGO.transform.localEulerAngles

	arg_7_0._fogAngle = Vector3(var_7_1.x, var_7_1.y, var_7_0.y + 94.4)
	arg_7_0._oceanFogGO.transform.localEulerAngles = arg_7_0._fogAngle
end

function var_0_0.onSceneClose(arg_8_0)
	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, arg_8_0._cameraTransformUpdate, arg_8_0)

	arg_8_0._oceanGO = nil
end

return var_0_0
