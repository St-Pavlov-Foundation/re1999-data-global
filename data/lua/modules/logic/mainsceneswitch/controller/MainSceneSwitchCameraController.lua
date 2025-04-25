module("modules.logic.mainsceneswitch.controller.MainSceneSwitchCameraController", package.seeall)

slot0 = class("MainSceneSwitchCameraController", BaseController)

function slot0.onInit(slot0)
	slot0:reInit()
end

function slot0.onInitFinish(slot0)
	GameGlobalMgr.instance:registerCallback(GameStateEvent.OnScreenResize, slot0._onScreenResize, slot0)
end

function slot0.addConstEvents(slot0)
end

function slot0.reInit(slot0)
end

function slot0.clear(slot0)
	TaskDispatcher.cancelTask(slot0._delayResize, slot0)

	slot0._showSceneId = nil
	slot0._calllback = nil
	slot0._callbackTarget = nil

	if slot0._rt then
		slot0._unitCamera.targetTexture = nil

		UnityEngine.RenderTexture.ReleaseTemporary(slot0._rt)

		slot0._rt = nil
	end

	MainSceneSwitchCameraDisplayController.instance:clear()

	if slot0._cameraLoader then
		slot0._cameraLoader:dispose()

		slot0._cameraLoader = nil
	end

	gohelper.destroy(slot0._cameraRootGO)

	slot0._cameraRootGO = nil
	slot0._cameraTrace = nil
	slot0._cameraCO = nil
	slot0._cameraTrace = nil
	slot0._cameraTraceGO = nil
	slot0._focusTrs = nil
	slot0._mainSceneRoot = nil
	slot0._unitPPVolume = nil
	slot0._mainCamera = nil
	slot0._mainCameraGO = nil
	slot0._mainCameraTrs = nil
	slot0._unitCamera = nil
	slot0._unitCameraGO = nil
	slot0._unitCameraTrs = nil
	slot0._isShowScene = false
end

function slot0.hideScene(slot0)
	MainSceneSwitchCameraDisplayController.instance:hideScene()

	slot0._isShowScene = false

	gohelper.setActive(slot0._cameraRootGO, false)
end

function slot0.showScene(slot0, slot1, slot2, slot3)
	slot0._showSceneId = slot1
	slot0._callback = slot2
	slot0._callbackTarget = slot3
	slot0._isShowScene = true

	if not slot0._callback or not slot0._callbackTarget then
		logError("MainSceneSwitchCameraController showScene callback or callbackTarget is nil")

		return
	end

	slot0:_showScene()
end

function slot0._showScene(slot0)
	if not slot0._showSceneId or not slot0._callback or not slot0._isShowScene then
		return
	end

	if slot0._cameraRootGO then
		gohelper.setActive(slot0._cameraRootGO, true)
		slot0:_initSettings()

		if not MainSceneSwitchCameraDisplayController.instance:hasSceneRoot() then
			MainSceneSwitchCameraDisplayController.instance:setSceneRoot(slot0._mainSceneRoot)
		end

		MainSceneSwitchCameraDisplayController.instance:showScene(slot0._showSceneId, slot0._onShowSceneFinish, slot0)
	else
		slot0:_loadCamera()
	end
end

function slot0._onShowSceneFinish(slot0)
	if slot0._callback then
		slot1(slot0._callbackTarget, slot0._rt)
	end
end

function slot0._onScreenResize(slot0, slot1, slot2)
	if not slot0._cameraRootGO then
		return
	end

	slot0:resetParam()
	slot0:applyDirectly()
	TaskDispatcher.cancelTask(slot0._delayResize, slot0)
	TaskDispatcher.runDelay(slot0._delayResize, slot0, 0)
end

function slot0._delayResize(slot0)
	if not slot0._rt or not slot0._isShowScene then
		return
	end

	slot1, slot2 = slot0:_getRTSize()

	if slot0._rt.width == slot1 and slot0._rt.height == slot2 then
		return
	end

	if slot0._rt then
		slot0._unitCamera.targetTexture = nil

		UnityEngine.RenderTexture.ReleaseTemporary(slot0._rt)

		slot0._rt = nil
	end

	slot0:_initRT()

	if slot0._callback then
		slot3(slot0._callbackTarget, slot0._rt)
	end
end

function slot0._loadCamera(slot0)
	if slot0._cameraLoader then
		return
	end

	slot0._cameraLoader = MultiAbLoader.New()
	slot0._cameraPath = "ppassets/switchscenecameraroot.prefab"

	slot0._cameraLoader:addPath(slot0._cameraPath)
	slot0._cameraLoader:startLoad(slot0._loadCameraFinish, slot0)
end

slot1 = 20000

function slot0._loadCameraFinish(slot0)
	slot0._cameraRootGO = gohelper.clone(slot0._cameraLoader:getAssetItem(slot0._cameraPath):GetResource(), nil, "switchscenecameraroot")

	transformhelper.setLocalPos(slot0._cameraRootGO.transform, uv0, 0, 0)
	slot0:_initCameraRootGO()

	slot0._cameraTrace.EnableTrace = true

	slot0:_initCurSceneCameraTrace(10101)

	slot0._cameraTrace.EnableTrace = false
end

slot2 = "main/MainCamera"
slot3 = "main/MainCamera/unitcamera"

function slot0._initCameraRootGO(slot0)
	slot0._cameraTraceGO = gohelper.findChild(slot0._cameraRootGO, "main")
	slot0._cameraTrace = ZProj.GameCameraTrace.Get(slot0._cameraTraceGO)
	slot0._cameraTrace.EnableTrace = false

	ZProj.CameraChangeActor4Lua.Instance:SetCameraTrace(slot0._cameraTrace)

	slot0._focusTrs = gohelper.findChild(slot0._cameraRootGO, "focus").transform

	slot0._cameraTrace:SetFocusTransform(slot0._focusTrs)

	slot2 = gohelper.findChild(slot0._cameraRootGO, uv1)

	slot0:setMainCamera(gohelper.findChild(slot0._cameraRootGO, uv0))
	slot0:setUnitCamera(slot2)
	TaskDispatcher.runDelay(slot0._destoryActiveGos, slot0, 1)

	slot0._mainSceneRoot = gohelper.findChild(slot0._cameraRootGO, "SceneRoot/MainScene")
	slot0._unitPPVolume = gohelper.findChildComponent(slot2, "PPVolume", PostProcessingMgr.PPVolumeWrapType)

	MainSceneSwitchCameraDisplayController.instance:initMaps()
	MainSceneSwitchCameraDisplayController.instance:setSceneRoot(slot0._mainSceneRoot)
	slot0:_initSettings()
	slot0:setPPMaskType(true)
	slot0:_showScene()
end

function slot0.setPPMaskType(slot0, slot1)
	slot0:setUnitPPValue("rolesStoryMaskActive", slot1)
	slot0:setUnitPPValue("RolesStoryMaskActive", slot1)
	slot0:setUnitPPValue("rgbSplitStrength", 0)
	slot0:setUnitPPValue("RgbSplitStrength", 0)
	slot0:setUnitPPValue("radialBlurLevel", 1)
	slot0:setUnitPPValue("RadialBlurLevel", 1)
	slot0:setUnitPPValue("dofFactor", 0)
	slot0:setUnitPPValue("DofFactor", 0)
end

function slot0.setUnitPPValue(slot0, slot1, slot2)
	if slot0._unitPPVolume then
		slot0._unitPPVolume.refresh = true
		slot0._unitPPVolume[slot1] = slot2
	end
end

function slot0.setLocalBloomColor(slot0, slot1)
	slot0:setUnitPPValue("localBloomColor", slot1)
end

function slot0.setMainCamera(slot0, slot1)
	slot0._mainCamera = slot1:GetComponent("Camera")
	slot0._mainCameraGO = slot1
	slot0._mainCameraTrs = slot1.transform
end

function slot0.setUnitCamera(slot0, slot1)
	slot0._unitCamera = slot1:GetComponent("Camera")
	slot0._unitCameraGO = slot1
	slot0._unitCameraTrs = slot1.transform
end

function slot0._destoryActiveGos(slot0)
	if gohelper.findChild(slot0._mainCameraGO, "scene") then
		gohelper.destroy(slot1)
	end

	if gohelper.findChild(slot0._unitCameraGO, "unit") then
		gohelper.destroy(slot2)
	end
end

function slot0._initSettings(slot0)
	slot0:_initRT()
	slot0:_initProfile()
end

function slot0._initProfile(slot0)
	slot0._unitPPVolume:SetProfile(PostProcessingMgr.instance:getProfile())
end

function slot0._initRT(slot0)
	slot0._rt = slot0._rt or slot0:_getRT()
	slot0._unitCamera.targetTexture = slot0._rt
end

function slot0._getRT(slot0)
	slot1, slot2 = slot0:_getRTSize()

	return UnityEngine.RenderTexture.GetTemporary(slot1, slot2, 0, UnityEngine.RenderTextureFormat.ARGBHalf)
end

function slot0._getRTSize(slot0)
	slot1 = slot0._mainCamera.pixelWidth

	if UnityEngine.SystemInfo.maxTextureSize < slot1 and slot2 < slot1 then
		slot2 = slot4 / (slot1 / slot0._mainCamera.pixelHeight)
	end

	if slot4 < slot2 and slot1 < slot2 then
		slot1 = slot4 * slot3
	end

	return slot1, slot2
end

function slot0._initCurSceneCameraTrace(slot0, slot1)
	slot0._cameraCO = lua_camera.configDict[lua_scene_level.configDict[slot1].cameraId]

	slot0:resetParam()
	slot0:applyDirectly()
end

function slot0.resetParam(slot0, slot1)
	slot1 = slot1 or slot0._cameraCO
	slot2 = slot1.yaw
	slot0.yaw = slot2

	slot0._cameraTrace:SetTargetParam(slot2, slot1.pitch, slot1.distance, slot0:_calcFovInternal(slot1), 0, 0, 0)
	slot0:setFocus(uv0, slot1.yOffset, slot1.focusZ)
end

function slot0.setFocus(slot0, slot1, slot2, slot3)
	transformhelper.setPos(slot0._focusTrs, slot1, slot2, slot3)
end

function slot0._calcFovInternal(slot0, slot1)
	slot2 = 1.7777777777777777 * UnityEngine.Screen.height / UnityEngine.Screen.width

	if BootNativeUtil.isWindows() then
		slot3, slot4 = SettingsModel.instance:getCurrentScreenSize()
		slot2 = 16 * slot4 / 9 / slot3
	end

	if slot2 > 1 then
		slot3 = slot1.fov * slot2 * 0.85
	end

	slot4, slot5 = slot0:_getMinMaxFov()

	return Mathf.Clamp(slot3, slot4, slot5)
end

function slot0._getMinMaxFov(slot0)
	return 35, 120
end

function slot0.applyDirectly(slot0)
	slot0._cameraTrace:SetTargetFocusPos(transformhelper.getPos(slot0._focusTrs))
	slot0._cameraTrace:ApplyDirectly()
end

slot0.instance = slot0.New()

return slot0
