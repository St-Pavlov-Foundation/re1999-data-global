module("modules.logic.scene.room.comp.RoomSceneLightComp", package.seeall)

slot0 = class("RoomSceneLightComp", BaseSceneComp)

function slot0.onInit(slot0)
	slot0._lightRangeId = UnityEngine.Shader.PropertyToID("_LightRange")
	slot0._lightOffsetId = UnityEngine.Shader.PropertyToID("_LightOffset")
	slot0._linghtMinId = UnityEngine.Shader.PropertyToID("_LightMin")
end

function slot0.init(slot0, slot1, slot2)
	slot0._scene = slot0:getCurScene()
	slot0._directionalLightGO = slot0._scene.go.directionalLightGO
	slot0._directionalLightGOTrs = slot0._directionalLightGO.transform
	slot0._directionalLight = slot0._directionalLightGO:GetComponent(typeof(UnityEngine.Light))
	slot0._initRotation = slot0._directionalLightGOTrs.rotation
	slot0._sceneAmbient = slot0._scene.go.sceneAmbient
	slot0._sceneAmbientData = slot0._scene.go.sceneAmbientData
	slot0._lightMinValue = slot0._sceneAmbientData.lightmin
end

function slot0._refreshLight(slot0)
	slot2, slot3, slot4 = transformhelper.getLocalRotation(slot0._scene.camera.cameraTrs)
	slot0._directionalLightGOTrs.rotation = Quaternion.AngleAxis(slot3, Vector3.up) * slot0._initRotation
end

function slot0.getLightColor(slot0)
	return slot0._directionalLight.color
end

function slot0.setLightColor(slot0, slot1)
	slot0._directionalLight.color = slot1
end

function slot0.getLightIntensity(slot0)
	return slot0._directionalLight.intensity
end

function slot0.setLightIntensity(slot0, slot1)
	slot0._directionalLight.intensity = slot1
end

function slot0.setLocalRotation(slot0, slot1, slot2, slot3)
	transformhelper.setLocalRotation(slot0._directionalLightGOTrs, slot1, slot2, slot3)
end

function slot0.setLightMin(slot0, slot1)
	if slot0._lightMinValue and slot0._lightMinValue ~= slot1 then
		slot0._lightMinValue = slot1
		slot0._scene.go.sceneAmbientData.lightmin = slot1
		slot0._sceneAmbient.data = slot0._scene.go.sceneAmbientData

		RoomHelper.setGlobalFloat(slot0._linghtMinId, slot1)
	end
end

function slot0.setLightRange(slot0, slot1)
end

function slot0.setLightOffset(slot0, slot1)
end

function slot0.onSceneClose(slot0)
	slot0._lightMinValue = nil
	slot0._sceneAmbientData = nil
	slot0._sceneAmbient = nil
	slot0._directionalLightGOTrs = nil

	RoomMapController.instance:unregisterCallback(RoomEvent.CameraTransformUpdate, slot0._refreshLight, slot0)
end

return slot0
