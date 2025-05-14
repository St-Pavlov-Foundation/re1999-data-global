module("modules.logic.scene.room.comp.RoomSceneLightComp", package.seeall)

local var_0_0 = class("RoomSceneLightComp", BaseSceneComp)

function var_0_0.onInit(arg_1_0)
	arg_1_0._lightRangeId = UnityEngine.Shader.PropertyToID("_LightRange")
	arg_1_0._lightOffsetId = UnityEngine.Shader.PropertyToID("_LightOffset")
	arg_1_0._linghtMinId = UnityEngine.Shader.PropertyToID("_LightMin")
end

function var_0_0.init(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._scene = arg_2_0:getCurScene()
	arg_2_0._directionalLightGO = arg_2_0._scene.go.directionalLightGO
	arg_2_0._directionalLightGOTrs = arg_2_0._directionalLightGO.transform
	arg_2_0._directionalLight = arg_2_0._directionalLightGO:GetComponent(typeof(UnityEngine.Light))
	arg_2_0._initRotation = arg_2_0._directionalLightGOTrs.rotation
	arg_2_0._sceneAmbient = arg_2_0._scene.go.sceneAmbient
	arg_2_0._sceneAmbientData = arg_2_0._scene.go.sceneAmbientData
	arg_2_0._lightMinValue = arg_2_0._sceneAmbientData.lightmin
end

function var_0_0._refreshLight(arg_3_0)
	local var_3_0 = arg_3_0._scene.camera.cameraTrs
	local var_3_1, var_3_2, var_3_3 = transformhelper.getLocalRotation(var_3_0)
	local var_3_4 = Quaternion.AngleAxis(var_3_2, Vector3.up)

	arg_3_0._directionalLightGOTrs.rotation = var_3_4 * arg_3_0._initRotation
end

function var_0_0.getLightColor(arg_4_0)
	return arg_4_0._directionalLight.color
end

function var_0_0.setLightColor(arg_5_0, arg_5_1)
	arg_5_0._directionalLight.color = arg_5_1
end

function var_0_0.getLightIntensity(arg_6_0)
	return arg_6_0._directionalLight.intensity
end

function var_0_0.setLightIntensity(arg_7_0, arg_7_1)
	arg_7_0._directionalLight.intensity = arg_7_1
end

function var_0_0.setLocalRotation(arg_8_0, arg_8_1, arg_8_2, arg_8_3)
	transformhelper.setLocalRotation(arg_8_0._directionalLightGOTrs, arg_8_1, arg_8_2, arg_8_3)
end

function var_0_0.setLightMin(arg_9_0, arg_9_1)
	if arg_9_0._lightMinValue and arg_9_0._lightMinValue ~= arg_9_1 then
		arg_9_0._lightMinValue = arg_9_1
		arg_9_0._scene.go.sceneAmbientData.lightmin = arg_9_1
		arg_9_0._sceneAmbient.data = arg_9_0._scene.go.sceneAmbientData

		RoomHelper.setGlobalFloat(arg_9_0._linghtMinId, arg_9_1)
	end
end

function var_0_0.setLightRange(arg_10_0, arg_10_1)
	return
end

function var_0_0.setLightOffset(arg_11_0, arg_11_1)
	return
end

function var_0_0.onSceneClose(arg_12_0)
	arg_12_0._lightMinValue = nil
	arg_12_0._sceneAmbientData = nil
	arg_12_0._sceneAmbient = nil
	arg_12_0._directionalLightGOTrs = nil

	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, arg_12_0._refreshLight, arg_12_0)
end

return var_0_0
