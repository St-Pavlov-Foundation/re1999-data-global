module("modules.logic.scene.room.comp.RoomSceneBloomComp", package.seeall)

slot0 = class("RoomSceneBloomComp", BaseSceneComp)

function slot0.onInit(slot0)
	slot0._originalBloomColor = nil
	slot0._originalBloomActive = nil
	slot0._originalBloomlocalActive = nil
	slot0._originalBloomIntensity = nil
	slot0._originalBloomThreshold = nil
	slot0._originalBloomDiffusion = nil
	slot0._originalBloomRTDownTimes = nil
	slot0._originalBloomPercent = nil
	slot0._originalMaskActive = nil
	slot0._originalMainCameraVolumeTrigger = nil
	slot0._originalMainCameraUsePostProcess = nil
	slot0._originalMainCameraVolumeMask = nil
end

function slot0.init(slot0, slot1, slot2)
	slot3 = lua_scene_level.configDict[slot2]
	slot0._unitPPVolume = gohelper.findChildComponent(CameraMgr.instance:getMainCameraGO(), "PPVolume", PostProcessingMgr.PPVolumeWrapType)
	slot0._originalBloomColor = slot0:_getUnitPPValue("localBloomColor")

	slot0:_setUnitPPValue("localBloomColor", Color.New(slot3.bloomR, slot3.bloomG, slot3.bloomB, slot3.bloomA))

	slot0._originalBloomActive = slot0:_getUnitPPValue("bloomActive")

	slot0:_setUnitPPValue("bloomActive", slot3.useBloom == 1 and GameGlobalMgr.instance:getScreenState().grade ~= ModuleEnum.Performance.Low)

	slot0._originalBloomlocalActive = slot0:_getUnitPPValue("localBloomActive")

	slot0:_setUnitPPValue("localBloomActive", false)

	slot0._originalBloomIntensity = slot0:_getUnitPPValue("bloomIntensity")

	slot0:_setUnitPPValue("bloomIntensity", 11)

	slot0._originalBloomThreshold = slot0:_getUnitPPValue("bloomThreshold")

	slot0:_setUnitPPValue("bloomThreshold", 1)

	slot0._originalBloomDiffusion = slot0:_getUnitPPValue("bloomDiffusion")

	slot0:_setUnitPPValue("bloomDiffusion", 4)

	slot0._originalBloomRTDownTimes = slot0:_getUnitPPValue("bloomRTDownTimes")

	slot0:_setUnitPPValue("bloomRTDownTimes", 1)

	slot0._originalBloomPercent = slot0:_getUnitPPValue("bloomPercent")

	slot0:_setUnitPPValue("bloomPercent", 1)

	slot0._originalMaskActive = slot0:_getUnitPPValue("localMaskActive")

	slot0:_setUnitPPValue("localMaskActive", false)
	slot0:_setUnitPPValue("LocalMaskActive", false)
	slot0:_setCamera()
end

function slot0._setCamera(slot0)
	slot0._originalMainCameraVolumeTrigger = CameraMgr.instance:getMainCameraGO():GetComponent(PostProcessingMgr.PPCustomCamDataType).volumeTrigger

	if slot0._unitPPVolume then
		slot2.volumeTrigger = slot0._unitPPVolume.transform
	end

	slot0._originalMainCameraUsePostProcess = slot2.usePostProcess
	slot2.usePostProcess = true
	slot0._originalMainCameraVolumeMask = slot2.volumeMask
	slot2.volumeMask = LayerMask.GetMask("Unit")
end

function slot0._setUnitPPValue(slot0, slot1, slot2)
	if slot0._unitPPVolume then
		slot0._unitPPVolume.refresh = true
		slot0._unitPPVolume[slot1] = slot2
	end
end

function slot0._getUnitPPValue(slot0, slot1, slot2)
	if slot0._unitPPVolume then
		return slot0._unitPPVolume[slot1]
	end
end

function slot0.onSceneClose(slot0)
	if slot0._originalBloomColor ~= nil then
		slot0:_setUnitPPValue("localBloomColor", slot0._originalBloomColor)

		slot0._originalBloomColor = nil
	end

	if slot0._originalBloomActive ~= nil then
		slot0:_setUnitPPValue("bloomActive", slot0._originalBloomActive)

		slot0._originalBloomActive = nil
	end

	if slot0._originalBloomlocalActive ~= nil then
		slot0:_setUnitPPValue("localBloomActive", slot0._originalBloomlocalActive)

		slot0._originalBloomlocalActive = nil
	end

	if slot0._originalBloomIntensity ~= nil then
		slot0:_setUnitPPValue("bloomIntensity", slot0._originalBloomIntensity)

		slot0._originalBloomIntensity = nil
	end

	if slot0._originalBloomThreshold ~= nil then
		slot0:_setUnitPPValue("bloomThreshold", slot0._originalBloomThreshold)

		slot0._originalBloomThreshold = nil
	end

	if slot0._originalBloomDiffusion ~= nil then
		slot0:_setUnitPPValue("bloomDiffusion", slot0._originalBloomDiffusion)

		slot0._originalBloomDiffusion = nil
	end

	if slot0._originalBloomRTDownTimes ~= nil then
		slot0:_setUnitPPValue("bloomRTDownTimes", slot0._originalBloomRTDownTimes)

		slot0._originalBloomRTDownTimes = nil
	end

	if slot0._originalBloomPercent ~= nil then
		slot0:_setUnitPPValue("bloomPercent", slot0._originalBloomPercent)

		slot0._originalBloomPercent = nil
	end

	if slot0._originalMaskActive ~= nil then
		slot0:_setUnitPPValue("localMaskActive", slot0._originalMaskActive)
		slot0:_setUnitPPValue("LocalMaskActive", slot0._originalMaskActive)

		slot0._originalMaskActive = nil
	end

	slot0:_resetCamera()

	slot0._unitPPVolume = nil
end

function slot0._resetCamera(slot0)
	slot2 = CameraMgr.instance:getMainCameraGO():GetComponent(PostProcessingMgr.PPCustomCamDataType)
	slot2.volumeTrigger = slot0._originalMainCameraVolumeTrigger
	slot2.usePostProcess = slot0._originalMainCameraUsePostProcess
	slot2.volumeMask = slot0._originalMainCameraVolumeMask
end

return slot0
